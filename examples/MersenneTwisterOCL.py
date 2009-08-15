###############################################################################
# An OpenCL implementation of a multithreaded Mersenne Twister PRNG.
#
# This program serves as an example of usage and validation of the numerical
# series with statistical analysis.
#
# Written by Jay L. T. Cornwall <jay@jcornwall.me.uk>
# With thanks to John McInerney for statistical improvements.
#
# The author asserts no copyright over this code.
#
# Small modifications by In Tlapatlac for newest Python::OpenCL.
###############################################################################

import array, ctypes, numpy, opencl, random, sys, time

# Number of random numbers to generate and test.
gNRandomNumbers = 10000000

# Number of times to repeat each kernel timing.
gNRuns = 5

# Do not change this. It is fixed with regards to the seed file size.
gNRNGS = 32768

def GenerateRandomNumbers():
  # Read the offline-generated initial Twister configuration file.
  datFile = open("MersenneTwister.dat", "rb")
  mtData = numpy.fromfile(datFile, "uint32", gNRNGS * 4)
  datFile.close()

  # Seed each Twister with low-quality random numbers.
  # Twisters will need "warming up" before the PRNG quality improves.
  for i in range(0, gNRNGS):
    mtData[i*4+3] = random.randint(0, 4294967295)

  # Upload the initial Twister configurations to an OpenCL buffer.
  mtDataOCLBuf = opencl.Buffer(mtData)

  # Read the OpenCL Mersenne Twister test program into a string.
  oclSourceFile = open("MersenneTwister.cl", "r")
  oclSourceCode = oclSourceFile.read()
  oclSourceFile.close()

  # Test two versions of the kernel - a no-op and the PRNG generator.
  # Time difference between the two roughly corresponds to the computational
  # cost of generating random numbers.
  oclProg = opencl.Program(oclSourceCode)
  oclProg.build()

  oclQueue = opencl.default_queue()
  prnOCLBuf = opencl.Buffer(gNRandomNumbers * 4)

  timings = []
  for kernelName in ["TestNoOp", "TestMersenneTwisters"]:
    sumTimings = 0.0

    for run in range(0, gNRuns):
      oclKern = oclProg.create_kernel(kernelName)

      # Setup parameters and an output buffer for the test kernel.
      oclKern.set_arg(0, mtDataOCLBuf)
      oclKern.set_arg(1, prnOCLBuf)
      oclKern.set_arg(2, gNRandomNumbers)

      # Execute the kernel. This is messy because we need 512 threads in 64
      # blocks. Or, in OpenCL terminology, 32768 global and 512 local work
      # items. This uses all of the seeds we have generated but of course you
      # could use fewer.
      t0 = time.time()
      oclQueue.enqueue_nd_range_kernel(oclKern, [32768], [512])
      oclQueue.finish()
      t1 = time.time()

      # Discard the first run if we can as it carries initialisation overhead.
      if gNRuns == 1 or run > 0:
        sumTimings += (t1 - t0)

    timings.append(sumTimings / gNRuns)

  # Figure out how many PRNs/second a kernel can make into a register.
  randomNumbersPerSec = gNRandomNumbers / (timings[1] - timings[0])

  # Finally, read the random number series back to host memory.
  randomNumbers = numpy.ndarray((gNRandomNumbers), dtype = "float32")
  oclQueue.enqueue_read_buffer(prnOCLBuf, randomNumbers)

  return (randomNumbers, randomNumbersPerSec)

def CheckRandomNumbers(randomNumbers):
  # Upscale 32-bit IEEE 754 to 64-bit for better statistical accuracy in
  # numpy's mean/standard deviation functions, which use the array type
  # for intermediate calculations.
  randomNumbers = randomNumbers.astype("float64")

  mean = randomNumbers.mean()
  std = randomNumbers.std()

  print("Generated " + str(gNRandomNumbers) + " [0.0,1.0] random numbers")
  print("  Mean: %.7f [ideal: 0.5]" % mean)
  print("  S.D.: %.7f [ideal: 0.2886751]" % std)

def main():
  # Run the OpenCL example kernel to generate an array of random numbers.
  # (This is just for testing: in practical applications any thread can
  # generate its own serial sequence of random numbers on-demand.)
  (randomNumbers, randomNumbersPerSec) = GenerateRandomNumbers()

  # Apply some statistical analyses to test the quality of the PRN series.
  CheckRandomNumbers(randomNumbers)

  print("")
  print("Performance: %.0fM PRNs/second into registers." % (randomNumbersPerSec / 1000000))

if __name__ == "__main__":
  try:
    main()
  except KeyboardInterrupt:
    sys.exit(1)
