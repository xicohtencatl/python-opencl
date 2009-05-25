# -*- coding: utf-8; -*-

'''
Cython wrapper around the OpenCL library.

:author: Émilien Tlapale <emilien@tlapale.com>
'''

include "stdlib.pxi"

# cl_device_type - bitfield
DEVICE_TYPE_DEFAULT = 1<<0
DEVICE_TYPE_CPU = 1<<1
DEVICE_TYPE_GPU = 1<<2
DEVICE_TYPE_ACCELERATOR = 1<<3
DEVICE_TYPE_ALL = 0xFFFFFFFF

# cl_context_info
CONTEXT_REFERENCE_COUNT = 0x1080
CONTEXT_NUM_DEVICES     = 0x1081
CONTEXT_DEVICES         = 0x1082
CONTEXT_PROPERTIES      = 0x1083
CONTEXT_PLATFORM        = 0x1084


# Hacks! Change them!
ctypedef long           intptr_t
#ctypedef unsigned long  size_t

ctypedef void *         cl_context
ctypedef void *         cl_device_id
ctypedef void *         cl_command_queue

ctypedef int            cl_int
ctypedef unsigned int   cl_uint
ctypedef unsigned long  cl_ulong

ctypedef cl_ulong       cl_bitfield

ctypedef intptr_t       cl_context_properties
ctypedef cl_bitfield    cl_command_queue_properties
ctypedef cl_bitfield    cl_device_type
ctypedef cl_uint        cl_context_info


# The OpenCL Platform Layer
cdef extern from "CL/cl.h":
    # Contexts
    cl_context clCreateContextFromType(cl_context_properties*,
                                       cl_device_type,
                                       void (*)(char *, void *, size_t, void *),
                                       void*,
                                       cl_int*)
    cl_int clGetContextInfo(cl_context, cl_context_info, size_t, void*, size_t*)

# The OpenCL Runtime
cdef extern from "CL/cl.h":
    # Command Queues
    cl_command_queue clCreateCommandQueue(cl_context, cl_device_id,
                                          cl_command_queue_properties,
                                          cl_int*)

class OpenCLError(BaseException):
    codes = {0: 'Success',
                
             -1: 'Device not found',
             -2: 'Device not available',
             -3: 'Device compiler not available',
             -4: 'Memory object allocation failure',
             -5: 'Out of resources',
             -6: 'Out of host memory',
             -7: 'Profiling info not available',
             -8: 'Memory copy overlap',
             -9: 'Image format mismatch',
             -10: 'Image format not supported',
             -11: 'Build program failure',
             -12: 'Map failure',
                
             -30: 'Invalid value',
             -31: 'Invalid device type',
             -32: 'Invalid platform',
             -33: 'Invalid device',
             -34: 'Invalid context',
             -35: 'Invalid queue properties',
             -36: 'Invalid command queue',
             -37: 'Invalid host pointer',
             -38: 'Invalid memory objet',
             -39: 'Invalid image format description',
             -40: 'Invalid image size'}
    def __init__(self, code):
        self.code = code
    def __str__(self):
        if self.code in self.codes:
            return self.codes[self.code]
        return 'Unknown'

cdef class Context:
    cdef cl_context context

    def __init__(self, cl_device_type type=DEVICE_TYPE_DEFAULT):
        cdef cl_int err
        self.context = clCreateContextFromType(<cl_context_properties*>0,
                                          type,
                                          <void (*)(char *, void *, size_t, void *)>0,
                                          <void*>0,
                                          &err)
        if err != 0:
            raise OpenCLError(err)
        print 'Context', <long>self.context

    def get_devices_count(self):
        cdef cl_int err
        cdef size_t ret
        err = clGetContextInfo(self.context, CONTEXT_DEVICES,
                               <size_t>0, <void*>0, &ret)
        if err != 0:
            raise OpenCLError(err)
        return ret/sizeof(cl_device_id)

    def get_devices(self):
        dev_count = self.get_devices_count()

        cdef cl_int err
        cdef cl_device_id *dev_mem = <cl_device_id *> malloc (dev_count*sizeof(cl_device_id))
        err = clGetContextInfo(self.context, CONTEXT_DEVICES,
                               dev_count*sizeof(cl_device_id),
                               dev_mem, <size_t *>0)
        if err != 0:
            free(dev_mem)
            raise OpenCLError(err)

        devs = [<unsigned long>dev_mem[i] for i from 0<=i<dev_count]
        free(dev_mem)
        
        return devs

cdef class CommandQueue:
    cdef cl_command_queue queue
    def __init__(self, Context ctx, device=None):
        if device is None:
            device = ctx.get_devices()[0]

        cdef cl_int err
        print <unsigned long>ctx.context, device
        self.queue = clCreateCommandQueue(ctx.context,
                                          <cl_device_id>device,
                                          <cl_command_queue_properties>0,
                                          &err)
        if err != 0:
            raise OpenCLError(err)
