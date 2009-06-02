#! /usr/bin/env python

'''
Bandwidth test mimick from NVIDIA's example.
'''

from time import clock, time
from numpy import arange, array, ndarray, zeros
import opencl


MEMCOPY_ITERATIONS  = 10
DEFAULT_SIZE        = 32 * (1<<20)  # 32M
DEFAULT_INCREMENT   = 1<<22         # 4M

DEVICE_TO_HOST, HOST_TO_DEVICE, DEVICE_TO_DEVICE = range(3)


def test_bandwidth_quick(size, kind):
    test_bandwidth_range(size, size, DEFAULT_INCREMENT, kind)

def test_bandwidth_range(start, end, increment, kind):
    count = 1 + ((end - start) / increment)
    mem_sizes = ndarray(count, dtype=int)
    bandwidths = zeros(count, dtype=float)

    # Print information for use
    if kind == DEVICE_TO_HOST:
        print ' Device to Host Bandwidth for', \
                'Pageable memory,', 'direct access'
    elif kind == HOST_TO_DEVICE:
        print ' Host to Device Bandwidth for', \
                'Pageable memory,', 'direct access'
    else:
        print ' Device to Device Bandwidth'

    # Run each of the copies
    for i in range(count):
        mem_sizes[i] = start + i * increment
        if kind == DEVICE_TO_HOST:
            bandwidths[i] += test_device_to_host_transfer(mem_sizes[i])
        elif kind == HOST_TO_DEVICE:
            bandwidths[i] += test_host_to_device_transfer(mem_sizes[i])
        else:
            bandwidths[i] += test_device_to_device_transfer(mem_sizes[i])
        print '...'

def test_host_to_device_transfer(mem_size):
    # Allocate host memory
    h_idata = arange(mem_size, dtype='uint8')

    # Allocate device memory
    mem_flags = opencl.MEM_READ_ONLY
    if True:
        h_odata = ndarray(mem_size, dtype='uint8')
        mem_flags |= opencl.MEM_USE_HOST_PTR
        d_odata = opencl.Buffer(ctx, h_odata, mem_flags)
    if True:
        for i in range(MEMCOPY_ITERATIONS):
            queue.enqueue_write_buffer(d_odata, False, 0, mem_size, h_idata,
                                       0, None, None)
        queue.finish()


if __name__ == '__main__':
    devices = opencl.get_device_ids(opencl.PLATFORM_NVIDIA,
                                    opencl.DEVICE_TYPE_GPU)
    print 'Running on...'
    for dev in devices:
        print ' Device %s (from %d)' % (opencl.device_name(dev), dev)

    ctx = opencl.Context(opencl.DEVICE_TYPE_GPU)
    if True:
        print ' Quick Mode'
        test_bandwidth_quick(DEFAULT_SIZE, HOST_TO_DEVICE)
