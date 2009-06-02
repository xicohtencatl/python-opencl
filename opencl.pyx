# -*- coding: utf-8; -*-

'''
Cython wrapper around the OpenCL library.

:author: Émilien Tlapale <emilien@tlapale.com>
'''

include "stdlib.pxi"

cdef extern from "arrayobject.h":
    ctypedef int intp
    ctypedef extern class numpy.ndarray [object PyArrayObject]:
        cdef char *data
        cdef int nd
        cdef intp *dimensions
        cdef intp *strides
        cdef int flags

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

DEVICE_QUEUE_PROPERTIES = 0x102a
DEVICE_NAME             = 0x102b
DEVICE_VENDOR           = 0x102c
DRIVER_VERSION          = 0x102d
DEVICE_PROFILE          = 0x102e
DEVICE_VERSION          = 0x102f
DEVICE_EXTENSIONS       = 0x1030
DEVICE_PLATFORM         = 0x1031

PLATFORM_NVIDIA         = 0x3001

MEM_READ_WRITE          = 1<<0
MEM_WRITE_ONLY          = 1<<1
MEM_READ_ONLY           = 1<<2
MEM_USE_HOST_PTR        = 1<<3
MEM_ALLOC_HOST_PTR      = 1<<4
MEM_COPY_HOST_PTR       = 1<<5


# Hacks! Change them!
ctypedef long           intptr_t

ctypedef long         cl_platform_id
ctypedef long         cl_device_id
ctypedef long         cl_context
ctypedef long         cl_command_queue
ctypedef long         cl_mem
ctypedef long         cl_program
ctypedef long         cl_kernel
ctypedef long         cl_event
ctypedef long         cl_sampler

ctypedef int            cl_int
ctypedef unsigned int   cl_uint
ctypedef unsigned long  cl_ulong

ctypedef cl_uint        cl_bool
ctypedef cl_ulong       cl_bitfield
ctypedef cl_bitfield    cl_device_type
ctypedef cl_uint        cl_platform_info
ctypedef cl_uint        cl_device_info
ctypedef cl_bitfield    cl_device_address_info
ctypedef cl_bitfield    cl_device_fp_config
ctypedef cl_uint        cl_device_mem_cache_type
ctypedef cl_uint        cl_device_local_mem_type
ctypedef cl_bitfield    cl_device_exec_capabilities
ctypedef cl_bitfield    cl_command_queue_properties

ctypedef intptr_t       cl_context_properties
ctypedef cl_uint        cl_context_info
ctypedef cl_uint             cl_command_queue_info
ctypedef cl_uint             cl_channel_order
ctypedef cl_uint             cl_channel_type
ctypedef cl_bitfield         cl_mem_flags
ctypedef cl_uint             cl_mem_object_type
ctypedef cl_uint             cl_mem_info
ctypedef cl_uint             cl_image_info
ctypedef cl_uint             cl_addressing_mode
ctypedef cl_uint             cl_filter_mode
ctypedef cl_uint             cl_sampler_info
ctypedef cl_bitfield         cl_map_flags
ctypedef cl_uint             cl_program_info
ctypedef cl_uint             cl_program_build_info
ctypedef cl_int              cl_build_status
ctypedef cl_uint             cl_kernel_info
ctypedef cl_uint             cl_kernel_work_group_info
ctypedef cl_uint             cl_event_info
ctypedef cl_uint             cl_command_type
ctypedef cl_uint             cl_profiling_info

# The OpenCL Platform Layer
cdef extern from "CL/cl.h":
    # Contexts
    cl_context clCreateContextFromType(cl_context_properties*,
                                       cl_device_type,
                                       void (*)(char *, void *, size_t, void *),
                                       void*,
                                       cl_int*)
    cl_int clGetContextInfo(cl_context, cl_context_info, size_t, void*, size_t*)

    # Command Queues
    cl_command_queue clCreateCommandQueue(cl_context, cl_device_id,
                                          cl_command_queue_properties,
                                          cl_int*)
    cl_int clFlush(cl_command_queue)
    cl_int clFinish(cl_command_queue)

    # Device API
    cl_int clGetDeviceIDs(cl_platform_id, cl_device_type, cl_uint,
                          cl_device_id *, cl_uint *)
    cl_int clGetDeviceInfo(cl_device_id, cl_device_info, size_t,
                           void *, size_t *)

    # Memory Object APIs
    cl_mem clCreateBuffer(cl_context, cl_mem_flags, size_t, void *, cl_int *)

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

def get_device_ids(platform, type=DEVICE_TYPE_DEFAULT):
    # Get devices count
    cdef cl_uint dev_count
    err = clGetDeviceIDs(<cl_platform_id>PLATFORM_NVIDIA, type, 0, <cl_device_id *>0,
                         &dev_count)
    if err != 0:
        raise OpenCLError(err)
    # Fetch the device IDs
    cdef cl_device_id *devices = \
            <cl_device_id *> malloc (dev_count * sizeof (cl_device_id))
    err = clGetDeviceIDs(<cl_platform_id>PLATFORM_NVIDIA, type, dev_count,
                         devices, &dev_count)
    if err != 0:
        free(devices)
        raise OpenCLError(err)
    # Cast the device IDs to Python ints
    devs = [<unsigned long>devices[i] for i from 0<=i<dev_count]
    free(devices)

    return devs

def device_name(device):
    cdef char dev_str[1024]
    err = clGetDeviceInfo(<cl_device_id>device, DEVICE_NAME, 1024,
                          dev_str, <size_t *>0)
    if err != 0:
        raise OpenCLError(err)
    return str(dev_str)

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
        self.queue = clCreateCommandQueue(ctx.context,
                                          <cl_device_id>device,
                                          <cl_command_queue_properties>0,
                                          &err)
        if err != 0:
            raise OpenCLError(err)

    def flush(self):
        '''
        Issues all previously queued OpenCL commands in the queue.
        '''
        cdef cl_int err
        err = clFlush(self.queue)
        if err != 0:
            raise OpenCLError(err)

    def finish(self):
        '''
        Blocks until all previously queued OpenCL commands are issued.
        '''
        cdef cl_int err
        err = clFinish(self.queue)
        if err != 0:
            raise OpenCLError(err)

cdef class Buffer:
    cdef cl_mem mem
    def __init__(self, Context ctx, size_or_data, mem_flags=MEM_READ_WRITE):
        cdef void * c_data
        # Handle NumPy array
        if isinstance(size_or_data, ndarray):
            # TODO: assert contiguousity
            #data = ascontiguousarray(size_or_data)
            data = <ndarray>size_or_data
            c_data = <void *>data.data
            size = data.size
        else:
            c_data = <void *>None
            size = int(size_or_data)

        cdef cl_int err
        self.mem = clCreateBuffer(ctx.context, <cl_mem_flags>mem_flags, size,
                                  c_data, &err)
        if err != 0:
            raise OpenCLError(err)

