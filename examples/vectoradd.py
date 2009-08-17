#! /usr/bin/env python
# -*- coding: utf-8; -*-

'''
Demo application function to compute a simple vector addition computation
between 2 arrays using OpenCL.
'''

from numpy import *
import opencl


# OpenCL source code
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

# Some interesting data for the vectors
init_data_1 = array([37,50,54,50,56,12,37,45,77,81,92,56,-22,-4], dtype='int8')
init_data_2 = array([35,51,54,58,55,32,-5,42,34,33,16,44, 55,14], dtype='int8')

# Number of elements in the vectors to be added
SIZE = init_data_1.shape[0]*3

if __name__ == '__main__':
    # Here's two vectors in CPU (Host) memory
    host_vector_1 = ndarray((SIZE,), dtype='int8')
    host_vector_2 = ndarray((SIZE,), dtype='int8')
    host_vector_out = ones((SIZE,), dtype='int8')

    # Lets initialize them with some interesting repeating data
    for c in range(SIZE):
        host_vector_1[c] = init_data_1[c%init_data_1.shape[0]]
        host_vector_2[c] = init_data_2[c%init_data_2.shape[0]]

    # First we build the OpenCL program from source code
    prog = opencl.Program(opencl_source)

    # Extract the kernel and execute it
    prog.vector_add(host_vector_out, host_vector_1, host_vector_2)

    # Print out the results for fun.
    print 'Results:'
    print ''.join([chr(c) for c in host_vector_out])
