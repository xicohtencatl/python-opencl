===================================
Getting started with Python::OpenCL
===================================
`Python::OpenCL`_ is an easy to use Python wrapper around the `OpenCL`_ library.
This chapter will serve as a gentle introduction `Python::OpenCL`_ without
any prior knowledge on `OpenCL`_ required. However this tutorial uses a lot
the major scientific library for Python, `SciPy`_, and you should thus knows
a bit how it works before using `Python::OpenCL`_. Also basic knowledge of C is
necessary to write and understand `OpenCL`_ kernel codes.

`OpenCL`_ is a standard for parallel programming on heterogeneous devices
including CPUs, GPUs, and others processors. It provides a common language
C-like language for executing code on those devices, as well as APIs to
setup the computations.

Example: vector summing
=======================
We start by analyzing the following program implementing a vector addition
using `OpenCL`_.
::

  from numpy import *
  import opencl

  # CPU vectors allocation and initialization - Classic NumPy
  host_vec_1 = array([37,50,54,50,56,12,37,45,77,81,92,56,-22,-4], dtype='int8')
  host_vec_2 = array([35,51,54,58,55,32,-5,42,34,33,16,44, 55,14], dtype='int8')
  host_vec_out = ndarray(host_vec_1.shape, dtype='int8')

  # OpenCL C source
  opencl_source = '''
  __kernel void
  vector_add (__global char *c, __global char *a, __global char *b)
  {
    // Index of the elements to add
    unsigned int n = get_global_id(0);
    // Sum the nth element of vectors a and b and store in c
    c[n] = a[n] + b[n];
  }
  '''

  # Compile the code and exec the kernel
  prog = opencl.Program(opencl_source)
  prog.vector_add(host_vec_out, host_vec_1, host_vec_2)

  # Display the result
  print ''.join([chr(c) for c in host_vec_out])

Try running this program to make sure your installation of `Python::OpenCL`_ is correctly
setup. It should display the classical ``Hello, World!`` message. Let's now start 
understanding it line by line, except for the first NumPy lines.

OpenCL kernels
==============
OpenCL is a framework for writing programs for heterogeneous devices like
CPUs or GPUs. In particular OpenCL defines a common C-like language to write
*kernels* which can then be compiled for specific devices. In Python::OpenCL you
can write the kernel sources as normal Python character strings. In this
example the variable ``opencl_source`` refers to a string containing our
single kernel named ``vector_add``::

  __kernel void
  vector_add (__global char *c, __global char *a, __global char *b)
  {
    // Index of the elements to add
    unsigned int n = get_global_id(0);
    // Sum the nth element of vectors a and b and store in c
    c[n] = a[n] + b[n];
  }

As you can see, the kernel ``vector_add`` is defined using a C99 syntax:
it takes three arrays as arguments, ``a,b,c``, and returns nothing (``void``).
Note that a few specifier are required to explicit the fact this code is a
kernel (``__kernel``) and the location is device memory of the arrays (``__global``).

The kernel will be used a bit like in a ``for`` loop in standard C code, so with
something like::

  for (global_id = 0; global_id < SIZE; global_id++)
    vector_add (c, a, b);

assuming you can then access the ``for`` variable through ``get_global_id ()``.
The major difference, and main purpose of OpenCL, is that the calls to
``vector_add`` in the ``for`` loop are executed in parallel by different
processor. If your program is correctly designed, it should then run a lot
faster. That explain why in the second instruction of the kernel we only modify
one single element of the output vector ``c``.

As any standard C programs, OpenCL C source code must be compiled for a specific
device. To do so `Python::OpenCL`_ defines a class named ``Program`` to which you can
simply pass one or multiple kernel code as character string. You will then be
able to extract the compiled kernel and run them on the device easily. Indeed in
our example we can directly call our kernel as a function from the program::

  prog = opencl.Program(opencl_source)
  prog.vector_add(host_vec_out, host_vec_1, host_vec_2)

Yes, `OpenCL`_ kernels are compiled on the fly. That mean your program could
generate OpenCL code at runtime, including variables from Python code.

Memory buffers
==============
`OpenCL`_ devices often do not use classical CPU memory, the RAM, but may
have their own physically distinct memory. For this reason before calling your
kernel, you must transfer memory from the host (CPU) to the device (e.g. GPU).
The memory chunks allocated by `OpenCL`_ in device memory are called *memory
buffers*.

In the previous example it seems that we did not allocate or use device
memory buffers. In fact `Python::OpenCL`_ can automatically allocate device memory,
copy host memory to device memory, and then fetch back the results from device
to host memory after kernels have been called. We could however explicitly
declare our memory buffers in device memory easily::

  # Allocate GPU memory
  gpu_vec_1 = opencl.Buffer(host_vec_1)
  gpu_vec_2 = opencl.Buffer(host_vec_2)
  gpu_vec_out = opencl.Buffer(host_vec_out)

  # Exec the kernel
  prog.vector_add(gpu_vec_out, gpu_vec_1, gpu_vec_2)

  # Fetch back results
  gpu_vec_out.read(host_vector_out)

`Python::OpenCL`_ acts as a wrapper between Python and `OpenCL`_ and it is thus
very easy to transfer memory from host to the device, and/or to create an
empty device memory buffer by simply instantiating the class ``opencl.Buffer``.
In particular `Python::OpenCL`_ implements transfer from `NumPy`_ multi-dimensional
arrays to `OpenCL`_ devices transparently::

  gpu_vec_1 = opencl.Buffer(host_vector_1)

In the considered example, we also made sure of transferring the results from
device memory buffer back to host memory so you can process and display it.
Indeed, from standard Python. or any other host program, you can only directly
access host memory::

  gpu_vec_out.read(host_vector_out)


.. _`Python::OpenCL`: http://python-opencl.next-touch.com
.. _OpenCL: http://www.khronos.org/opencl/
.. _SciPy: http://www.scipy.org
.. _NumPy: http://numpy.scipy.org
.. _`OpenCL Specification`: http://www.khronos.org/registry/cl/
