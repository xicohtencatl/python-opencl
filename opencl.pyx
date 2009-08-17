# -*- coding: utf-8; -*-

'''
Cython wrapper around the OpenCL library.

:author: Émilien Tlapale <emilien@tlapale.com>
'''

import numpy
from os import environ

include "stdlib.pxi"

include "numpy.pxd"

# cl_platform_info
PLATFORM_PROFILE     =                   0x0900
PLATFORM_VERSION     =                   0x0901
PLATFORM_NAME        =                   0x0902
PLATFORM_VENDOR      =                   0x0903


# cl_device_type - bitfield
DEVICE_TYPE_DEFAULT = 1<<0
DEVICE_TYPE_CPU = 1<<1
DEVICE_TYPE_GPU = 1<<2
DEVICE_TYPE_ACCELERATOR = 1<<3
DEVICE_TYPE_ALL = 0xFFFFFFFF

# cl_context_info
CONTEXT_REFERENCE_COUNT = 0x1080
#CONTEXT_NUM_DEVICES     = 0x1081
CONTEXT_DEVICES         = 0x1081
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

# cl_command_queue_properties - bitfield
QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE      = (1 << 0)
QUEUE_PROFILING_ENABLE                   = (1 << 1)

# OpenCL Version
VERSION_1_0 =                               1

# cl_bool
FALSE =                                     0
TRUE =                                      1

# cl_platform_info
PLATFORM_PROFILE =                          0x0900
PLATFORM_VERSION =                          0x0901
PLATFORM_NAME =                             0x0902
PLATFORM_VENDOR =                           0x0903
PLATFORM_EXTENSIONS =                       0x0904

# cl_device_type - bitfield
DEVICE_TYPE_DEFAULT =                       (1 << 0)
DEVICE_TYPE_CPU =                           (1 << 1)
DEVICE_TYPE_GPU =                           (1 << 2)
DEVICE_TYPE_ACCELERATOR =                   (1 << 3)
DEVICE_TYPE_ALL =                           0xFFFFFFFF

# cl_device_info
DEVICE_TYPE =                               0x1000
DEVICE_VENDOR_ID =                          0x1001
DEVICE_MAX_COMPUTE_UNITS =                  0x1002
DEVICE_MAX_WORK_ITEM_DIMENSIONS =           0x1003
DEVICE_MAX_WORK_GROUP_SIZE =                0x1004
DEVICE_MAX_WORK_ITEM_SIZES =                0x1005
DEVICE_PREFERRED_VECTOR_WIDTH_CHAR =        0x1006
DEVICE_PREFERRED_VECTOR_WIDTH_SHORT =       0x1007
DEVICE_PREFERRED_VECTOR_WIDTH_INT =         0x1008
DEVICE_PREFERRED_VECTOR_WIDTH_LONG =        0x1009
DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT =       0x100A
DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE =      0x100B
DEVICE_MAX_CLOCK_FREQUENCY =                0x100C
DEVICE_ADDRESS_BITS =                       0x100D
DEVICE_MAX_READ_IMAGE_ARGS =                0x100E
DEVICE_MAX_WRITE_IMAGE_ARGS =               0x100F
DEVICE_MAX_MEM_ALLOC_SIZE =                 0x1010
DEVICE_IMAGE2D_MAX_WIDTH =                  0x1011
DEVICE_IMAGE2D_MAX_HEIGHT =                 0x1012
DEVICE_IMAGE3D_MAX_WIDTH =                  0x1013
DEVICE_IMAGE3D_MAX_HEIGHT =                 0x1014
DEVICE_IMAGE3D_MAX_DEPTH =                  0x1015
DEVICE_IMAGE_SUPPORT =                      0x1016
DEVICE_MAX_PARAMETER_SIZE =                 0x1017
DEVICE_MAX_SAMPLERS =                       0x1018
DEVICE_MEM_BASE_ADDR_ALIGN =                0x1019
DEVICE_MIN_DATA_TYPE_ALIGN_SIZE =           0x101A
DEVICE_SINGLE_FP_CONFIG =                   0x101B
DEVICE_GLOBAL_MEM_CACHE_TYPE =              0x101C
DEVICE_GLOBAL_MEM_CACHELINE_SIZE =          0x101D
DEVICE_GLOBAL_MEM_CACHE_SIZE =              0x101E
DEVICE_GLOBAL_MEM_SIZE =                    0x101F
DEVICE_MAX_CONSTANT_BUFFER_SIZE =           0x1020
DEVICE_MAX_CONSTANT_ARGS =                  0x1021
DEVICE_LOCAL_MEM_TYPE =                     0x1022
DEVICE_LOCAL_MEM_SIZE =                     0x1023
DEVICE_ERROR_CORRECTION_SUPPORT =           0x1024
DEVICE_PROFILING_TIMER_RESOLUTION =         0x1025
DEVICE_ENDIAN_LITTLE =                      0x1026
DEVICE_AVAILABLE =                          0x1027
DEVICE_COMPILER_AVAILABLE =                 0x1028
DEVICE_EXECUTION_CAPABILITIES =             0x1029
DEVICE_QUEUE_PROPERTIES =                   0x102A
DEVICE_NAME =                               0x102B
DEVICE_VENDOR =                             0x102C
DRIVER_VERSION =                            0x102D
DEVICE_PROFILE =                            0x102E
DEVICE_VERSION =                            0x102F
DEVICE_EXTENSIONS =                         0x1030
DEVICE_PLATFORM =                           0x1031
	
# cl_device_fp_config - bitfield
FP_DENORM =                                 (1 << 0)
FP_INF_NAN =                                (1 << 1)
FP_ROUND_TO_NEAREST =                       (1 << 2)
FP_ROUND_TO_ZERO =                          (1 << 3)
FP_ROUND_TO_INF =                           (1 << 4)
FP_FMA =                                    (1 << 5)

# cl_device_mem_cache_type
NONE =                                      0x0
READ_ONLY_CACHE =                           0x1
READ_WRITE_CACHE =                          0x2

# cl_device_local_mem_type
LOCAL =                                     0x1
GLOBAL =                                    0x2

# cl_device_exec_capabilities - bitfield
EXEC_KERNEL =                               (1 << 0)
EXEC_NATIVE_KERNEL =                        (1 << 1)

# cl_command_queue_properties - bitfield
QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE =       (1 << 0)
QUEUE_PROFILING_ENABLE =                    (1 << 1)

# cl_context_info
CONTEXT_REFERENCE_COUNT =                   0x1080
CONTEXT_DEVICES =                           0x1081
CONTEXT_PROPERTIES =                        0x1082

# cl_context_properties
CONTEXT_PLATFORM =                          0x1084

# cl_command_queue_info
QUEUE_CONTEXT =                             0x1090
QUEUE_DEVICE =                              0x1091
QUEUE_REFERENCE_COUNT =                     0x1092
QUEUE_PROPERTIES =                          0x1093

# cl_mem_flags - bitfield
MEM_READ_WRITE =                            (1 << 0)
MEM_WRITE_ONLY =                            (1 << 1)
MEM_READ_ONLY =                             (1 << 2)
MEM_USE_HOST_PTR =                          (1 << 3)
MEM_ALLOC_HOST_PTR =                        (1 << 4)
MEM_COPY_HOST_PTR =                         (1 << 5)

# cl_channel_order
R =                                       0x10B0
A =                                       0x10B1
RG =                                        0x10B2
RA =                                        0x10B3
RGB =                                       0x10B4
RGBA =                                      0x10B5
BGRA =                                      0x10B6
ARGB =                                      0x10B7
INTENSITY =                                 0x10B8
LUMINANCE =                                 0x10B9

# cl_channel_type
SNORM_INT8 =                                0x10D0
SNORM_INT16 =                               0x10D1
UNORM_INT8 =                                0x10D2
UNORM_INT16 =                               0x10D3
UNORM_SHORT_565 =                           0x10D4
UNORM_SHORT_555 =                           0x10D5
UNORM_INT_101010 =                          0x10D6
SIGNED_INT8 =                               0x10D7
SIGNED_INT16 =                              0x10D8
SIGNED_INT32 =                              0x10D9
UNSIGNED_INT8 =                             0x10DA
UNSIGNED_INT16 =                            0x10DB
UNSIGNED_INT32 =                            0x10DC
HALF_FLOAT =                                0x10DD
FLOAT =                                     0x10DE

# cl_mem_object_type
MEM_OBJECT_BUFFER =                         0x10F0
MEM_OBJECT_IMAGE2D =                        0x10F1
MEM_OBJECT_IMAGE3D =                        0x10F2

# cl_mem_info
MEM_TYPE =                                  0x1100
MEM_FLAGS =                                 0x1101
MEM_SIZE =                                  0x1102
MEM_HOST_PTR =                              0x1103
MEM_MAP_COUNT =                             0x1104
MEM_REFERENCE_COUNT =                       0x1105
MEM_CONTEXT =                               0x1106

# cl_image_info
IMAGE_FORMAT =                              0x1110
IMAGE_ELEMENT_SIZE =                        0x1111
IMAGE_ROW_PITCH =                           0x1112
IMAGE_SLICE_PITCH =                         0x1113
IMAGE_WIDTH =                               0x1114
IMAGE_HEIGHT =                              0x1115
IMAGE_DEPTH =                               0x1116

# cl_addressing_mode
ADDRESS_NONE =                              0x1130
ADDRESS_CLAMP_TO_EDGE =                     0x1131
ADDRESS_CLAMP =                             0x1132
ADDRESS_REPEAT =                            0x1133

# cl_filter_mode
FILTER_NEAREST =                            0x1140
FILTER_LINEAR =                             0x1141

# cl_sampler_info
SAMPLER_REFERENCE_COUNT =                   0x1150
SAMPLER_CONTEXT =                           0x1151
SAMPLER_NORMALIZED_COORDS =                 0x1152
SAMPLER_ADDRESSING_MODE =                   0x1153
SAMPLER_FILTER_MODE =                       0x1154

# cl_map_flags - bitfield
MAP_READ =                                  (1 << 0)
MAP_WRITE =                                 (1 << 1)

# cl_program_info
PROGRAM_REFERENCE_COUNT =                   0x1160
PROGRAM_CONTEXT =                           0x1161
PROGRAM_NUM_DEVICES =                       0x1162
PROGRAM_DEVICES =                           0x1163
PROGRAM_SOURCE =                            0x1164
PROGRAM_BINARY_SIZES =                      0x1165
PROGRAM_BINARIES =                          0x1166

# cl_program_build_info
PROGRAM_BUILD_STATUS =                      0x1181
PROGRAM_BUILD_OPTIONS =                     0x1182
PROGRAM_BUILD_LOG =                         0x1183

# cl_build_status
BUILD_SUCCESS =                             0
BUILD_NONE =                                -1
BUILD_ERROR =                               -2
BUILD_IN_PROGRESS =                         -3

# cl_kernel_info
KERNEL_FUNCTION_NAME =                      0x1190
KERNEL_NUM_ARGS =                           0x1191
KERNEL_REFERENCE_COUNT =                    0x1192
KERNEL_CONTEXT =                            0x1193
KERNEL_PROGRAM =                            0x1194

# cl_kernel_work_group_info
KERNEL_WORK_GROUP_SIZE =                    0x11B0
KERNEL_COMPILE_WORK_GROUP_SIZE =            0x11B1
KERNEL_LOCAL_MEM_SIZE =                     0x11B2

# cl_event_info
EVENT_COMMAND_QUEUE =                       0x11D0
EVENT_COMMAND_TYPE =                        0x11D1
EVENT_REFERENCE_COUNT =                     0x11D2
EVENT_COMMAND_EXECUTION_STATUS =            0x11D3

# cl_command_type
COMMAND_NDRANGE_KERNEL =                    0x11F0
COMMAND_TASK =                              0x11F1
COMMAND_NATIVE_KERNEL =                     0x11F2
COMMAND_READ_BUFFER =                       0x11F3
COMMAND_WRITE_BUFFER =                      0x11F4
COMMAND_COPY_BUFFER =                       0x11F5
COMMAND_READ_IMAGE =                        0x11F6
COMMAND_WRITE_IMAGE =                       0x11F7
COMMAND_COPY_IMAGE =                        0x11F8
COMMAND_COPY_IMAGE_TO_BUFFER =              0x11F9
COMMAND_COPY_BUFFER_TO_IMAGE =              0x11FA
COMMAND_MAP_BUFFER =                        0x11FB
COMMAND_MAP_IMAGE =                         0x11FC
COMMAND_UNMAP_MEM_OBJECT =                  0x11FD
COMMAND_MARKER =                            0x11FE
COMMAND_ACQUIRE_GL_OBJECTS =                0x11FF
COMMAND_RELEASE_GL_OBJECTS =                0x1200

# command execution status
COMPLETE =                                  0x0
RUNNING =                                   0x1
SUBMITTED =                                 0x2
QUEUED =                                    0x3
  
# cl_profiling_info
PROFILING_COMMAND_QUEUED =                  0x1280
PROFILING_COMMAND_SUBMIT =                  0x1281
PROFILING_COMMAND_START =                   0x1282
PROFILING_COMMAND_END =                     0x1283

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

default_ctx = None
default_que = None
default_pla = None


# The OpenCL Platform Layer
cdef extern from "CL/cl.h":
    # Platform
    cl_int clGetPlatformIDs(cl_uint, cl_platform_id *, cl_uint *)
    cl_int clGetPlatformInfo(cl_platform_id, cl_platform_info, size_t, void *, size_t *)

    # Device API
    cl_int clGetDeviceIDs(cl_platform_id, cl_device_type, cl_uint,
                          cl_device_id *, cl_uint *)
    cl_int clGetDeviceInfo(cl_device_id, cl_device_info, size_t,
                           void *, size_t *)

    # Contexts
    cl_context clCreateContext(cl_context_properties *, cl_uint, cl_device_id *,
                               void (*) (char *, void *, size_t, void *), void
                               *, cl_int *)
    cl_context clCreateContextFromType(cl_context_properties *,
                                       cl_device_type,
                                       void (*)(char *, void *, size_t, void *),
                                       void *,
                                       cl_int *)
    cl_int clRetainContext(cl_context)
    cl_int clReleaseContext(cl_context)
    cl_int clGetContextInfo(cl_context, cl_context_info, size_t, void*, size_t*)

    # Command Queues
    cl_command_queue clCreateCommandQueue(cl_context, cl_device_id,
                                          cl_command_queue_properties,
                                          cl_int *)
    cl_int clRetainCommandQueue(cl_command_queue)
    cl_int clReleaseCommandQueue(cl_command_queue)
    cl_int clGetCommandQueueInfo (cl_command_queue, cl_command_queue_info,
                                  size_t, void *, size_t *)
    cl_int clSetCommandQueueProperty(cl_command_queue,
                                     cl_command_queue_properties, cl_bool,
                                     cl_command_queue_properties *)
    cl_int clEnqueueWriteBuffer(cl_command_queue, cl_mem, cl_bool, size_t,
                                size_t, void *, cl_uint, cl_event *, cl_event *)

    # Memory Object APIs
    cl_mem clCreateBuffer(cl_context, cl_mem_flags, size_t, void *, cl_int *)
    #cl_mem clCreateImage2D(cl_context, cl_mem_flags, cl_image_format *, size_t,
    #                       size_t, size_t, void *, cl_int *)
    #cl_mem clCreateImage3D(cl_context, cl_mem_flags, cl_image_format *, size_t,
    #                       size_t, size_t, size_t, size_t, void *, cl_int *)
    cl_int clRetainMemObject(cl_mem)
    cl_int clReleaseMemObject(cl_mem)
    #cl_int clGetSupportedImageFormats(cl_context, cl_mem_flags,
    #                                  cl_mem_object_type, cl_uint,
    #                                  cl_image_format *, cl_uint *)
    cl_int clGetMemObjectInfo(cl_mem, cl_mem_info, size_t, void *, size_t *)

    # Sampler API
    cl_sampler clCreateSampler(cl_context, cl_bool, cl_addressing_mode,
                               cl_filter_mode, cl_int *)
    cl_int clRetainSampler(cl_sampler)
    cl_int clReleaseSampler(cl_sampler)
    cl_int clGetSamplerInfo(cl_sampler, cl_sampler_info, size_t, void *, size_t)

    # Program Objects
    cl_program clCreateProgramWithSource(cl_context, cl_uint, char **, size_t *,
                                         cl_int *)
    cl_program clCreateProgramWithBinary(cl_context, cl_uint, cl_device_id *,
                                         size_t *, unsigned char **, cl_int *,
                                         cl_int *)
    cl_int clRetainProgram(cl_program)
    cl_int clReleaseProgram(cl_program)
    cl_int clBuildProgram(cl_program, cl_uint, cl_device_id*, char *,
                          void (*)(cl_program, void *),
                          void *)
    cl_int clUnloadCompiler()
    cl_int clGetProgramInfo(cl_program, cl_program_info, size_t, void *, size_t
                            *)
    cl_int clGetProgramBuildInfo(cl_program, cl_device_id,
                                 cl_program_build_info, size_t, void *, size_t
                                 *)

    # Kernel and Event Objects
    cl_kernel clCreateKernel(cl_program, char *, cl_int *)
    cl_int clCreateKernelsInProgram(cl_program, cl_uint, cl_kernel *, cl_uint *)
    cl_int clRetainKernel(cl_kernel)
    cl_int clReleaseKernel(cl_kernel)
    cl_int clSetKernelArg(cl_kernel, cl_uint, size_t, void *)
    cl_int clGetKernelInfo(cl_kernel, cl_kernel_info, size_t, void *, size_t *)
    cl_int clGetKernelWorkGroupInfo(cl_kernel, cl_device_id,
                                    cl_kernel_work_group_info, size_t, void *,
                                    size_t *)

    # Event Object APIs
    cl_int clWaitForEvents(cl_uint, cl_event *)
    cl_int clGetEventInfo(cl_event, cl_event_info, size_t, void *, size_t *)
    cl_int clRetainEvent(cl_event)
    cl_int clReleaseEvent(cl_event)

    # Profiling APIs
    cl_int clGetEventProfilingInfo(cl_event, cl_profiling_info, size_t, void *,
                                   size_t *)

    # Flush and Finish APIs
    cl_int clFlush(cl_command_queue)
    cl_int clFinish(cl_command_queue)

    # Enqueue Command APIs
    cl_int clEnqueueReadBuffer(cl_command_queue, cl_mem, cl_bool, size_t,
                               size_t, void *, cl_uint, cl_event *, cl_event *)
    cl_int clEnqueueWriteBuffer(cl_command_queue, cl_mem, cl_bool, size_t,
                                size_t, void *, cl_uint, cl_event *, cl_event *)
    cl_int clEnqueueCopyBuffer(cl_command_queue, cl_mem, cl_mem, size_t,
                               size_t, size_t, cl_uint, cl_event *, cl_event *)
    cl_int clEnqueueNDRangeKernel(cl_command_queue, cl_kernel, cl_uint, size_t
                                  *, size_t *, size_t *, cl_uint, void *, void
                                  *)


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
             -40: 'Invalid image size',
             -41: 'Invalid sampler',
             -42: 'Invalid binary',
             -43: 'Invalid build options',
             -44: 'Invalid program',
             -45: 'Invalid program executable',
             -46: 'Invalid kernel name',
             -47: 'Invalid kernel definition',
             -48: 'Invalid kernel',
             -49: 'Invalid argument index',
             -50: 'Invalid argument value',
             -51: 'Invalid argument size',
             -52: 'Invalid kernel arguments',
             -53: 'Invalid work dimension',
             -54: 'Invalid work group size',
             -55: 'Invalid work item size',
             -56: 'Invalid global offset',
             -57: 'Invalid event wait list',
             -58: 'Invalid event',
             -59: 'Invalid operation',
             -60: 'Invalid GL object',
             -61: 'Invalid buffer size',
             -62: 'Invalid MIP level'}
    def __init__(self, code):
        self.code = code
    def __str__(self):
        if self.code in self.codes:
            return self.codes[self.code]
        if isinstance(self.code, str) or isinstance(self.code, unicode):
            return self.code
        return 'Unknown'

ctypedef cl_int (*InfoGrabber) (long, cl_uint, size_t, void *, size_t *)


cdef get_info(id, info, InfoGrabber func):
    cdef int err
    cdef size_t sz
    cdef char *c_val
    cdef InfoGrabber c_func
    # Query info size
    err = func(id, info, 0, NULL, &sz)
    if err:
        raise OpenCLError(err)
    # Allocate memory for the info
    c_val = <char *> malloc (sz * sizeof (char))
    # Fetch info
    err = func(id, info, sz, <void *> c_val, NULL)
    if err:
        raise OpenCLError(err)
    # Return a Python object
    ans = str(c_val)
    free(c_val)
    return ans

cdef class Platform:
    '''
    Abstraction for an OpenCL platform.
    '''
    info_id = {'profile': PLATFORM_PROFILE,
               'version': PLATFORM_VERSION,
               'name': PLATFORM_NAME,
               'vendor': PLATFORM_VENDOR,
              }

    cdef public object id
    cdef object devs

    def __cinit__(self, id):
        '''
        Wrap an OpenCL platform with the given ID.
        '''
        self.id = id
        self.devs = None
    def __getattr__(self, name):
        cdef size_t sz
        cdef char *c_val

        if name in self.info_id:
            return get_info(self.id, self.info_id[name], clGetPlatformInfo)
        if name == 'devices':
            return self._devices()
        raise AttributeError, name
    def _devices(self, type=DEVICE_TYPE_ALL):
        '''
        Return the list of devices associated with the platform.
        '''
        if self.devs:
            return self.devs
        self.devs = get_devices(self, type)
        return self.devs

cdef class Device:
    '''
    Abstraction class for OpenCL devices.
    '''
    cdef public object id

    info_id = {
        'type': ('cl_ulong', DEVICE_TYPE),
        'vendor_id': ('cl_uint', DEVICE_VENDOR_ID),
        'max_compute_units': ('cl_uint', DEVICE_MAX_COMPUTE_UNITS),
        'max_work_item_dimensions': ('cl_uint', DEVICE_MAX_WORK_ITEM_DIMENSIONS),
        'max_work_group_size': ('cl_uint', DEVICE_MAX_WORK_GROUP_SIZE),
        'platform': ('cl_ulong', DEVICE_PLATFORM),
        'preferred_vector_width_char': ('cl_uint', DEVICE_PREFERRED_VECTOR_WIDTH_CHAR),
        'preferred_vector_width_short': ('cl_uint', DEVICE_PREFERRED_VECTOR_WIDTH_SHORT),
        'preferred_vector_width_int': ('cl_uint', DEVICE_PREFERRED_VECTOR_WIDTH_INT),
        'preferred_vector_width_long': ('cl_uint', DEVICE_PREFERRED_VECTOR_WIDTH_LONG),
        'preferred_vector_width_float': ('cl_uint', DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT),
        'preferred_vector_width_double': ('cl_uint', DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE),
        'max_clock_frequency': ('cl_uint', DEVICE_MAX_CLOCK_FREQUENCY),
        'address_bits': ('cl_uint', DEVICE_ADDRESS_BITS),
        'max_mem_alloc_size': ('cl_uint', DEVICE_MAX_MEM_ALLOC_SIZE),
        'image_support': ('cl_bool', DEVICE_IMAGE_SUPPORT),
        'max_read_image_args': ('cl_uint', DEVICE_MAX_READ_IMAGE_ARGS),
        'max_write_image_args': ('cl_uint', DEVICE_MAX_WRITE_IMAGE_ARGS),
        'image2d_max_width': ('c_size_t', DEVICE_IMAGE2D_MAX_WIDTH),
        'image2d_max_height': ('c_size_t', DEVICE_IMAGE2D_MAX_HEIGHT),
        'image3d_max_width': ('c_size_t', DEVICE_IMAGE3D_MAX_WIDTH),
        'image3d_max_height': ('c_size_t', DEVICE_IMAGE3D_MAX_HEIGHT),
        'image3d_max_depth': ('c_size_t', DEVICE_IMAGE3D_MAX_DEPTH),
        'max_samplers': ('cl_uint', DEVICE_MAX_SAMPLERS),
        'max_parameters_size': ('c_size_t', DEVICE_MAX_PARAMETER_SIZE),
        'mem_base_addr_align': ('cl_uint', DEVICE_MEM_BASE_ADDR_ALIGN),
        'min_data_type_align_size': ('cl_uint', DEVICE_MIN_DATA_TYPE_ALIGN_SIZE),
        'single_fp_config': ('cl_uint', DEVICE_SINGLE_FP_CONFIG),
        'global_mem_cache_type': ('cl_uint', DEVICE_GLOBAL_MEM_CACHE_TYPE),
        'global_mem_cacheline_size': ('cl_uint', DEVICE_GLOBAL_MEM_CACHELINE_SIZE),
        'global_mem_cache_size': ('cl_ulong', DEVICE_GLOBAL_MEM_CACHE_SIZE),
        'global_mem_size': ('cl_ulong', DEVICE_GLOBAL_MEM_SIZE),
        'max_constant_buffer_size': ('cl_ulong', DEVICE_MAX_CONSTANT_BUFFER_SIZE),
        'max_constant_args': ('cl_uint', DEVICE_MAX_CONSTANT_ARGS),
        'local_mem_type': ('cl_uint', DEVICE_LOCAL_MEM_TYPE),
        'error_correction_support': ('cl_bool', DEVICE_ERROR_CORRECTION_SUPPORT),
        'profiling_timer_resolution': ('c_size_t', DEVICE_PROFILING_TIMER_RESOLUTION),
        'endian_little': ('cl_bool', DEVICE_ENDIAN_LITTLE),
        'available': ('cl_bool', DEVICE_AVAILABLE),
        'compiler_available': ('cl_bool', DEVICE_COMPILER_AVAILABLE),
        'execution_capabilities': ('cl_ulong', DEVICE_EXECUTION_CAPABILITIES),
        'queue_properties': ('cl_ulong', DEVICE_QUEUE_PROPERTIES),
    }
    str_info_id = {
        'name': DEVICE_NAME,
        'vendor': DEVICE_VENDOR,
        'version': DEVICE_VERSION,
        'profile': DEVICE_PROFILE,
        'extensions': DEVICE_EXTENSIONS,
    }

    def __cinit__(self, id):
        self.id = id
    def __getattr__(self, name):
        cdef int err
        cdef cl_ulong ul_ans
        cdef cl_uint ui_ans
        cdef InfoGrabber func = clGetDeviceInfo
        cdef size_t *svec

        if name in self.str_info_id:
            return get_info(self.id, self.str_info_id[name], func)
        if name in self.info_id:
            tp, info_id = self.info_id[name]
            if tp == 'cl_ulong':
                err = func(self.id, info_id, sizeof(cl_ulong), <void *> &ul_ans, NULL)
                if err:
                    raise OpenCLError(err)
                return ul_ans
            elif tp == 'cl_uint':
                err = func(self.id, info_id, sizeof(cl_uint), <void *> &ui_ans, NULL)
                if err:
                    raise OpenCLError(err)
                return ui_ans
            else:
                raise OpenCLError('Unknown info type: %s' % tp)
        if name == 'max_work_item_sizes':
            sz = self.max_work_item_dimensions
            svec = <size_t *> malloc (sz * sizeof (size_t))
            err = func(self.id, DEVICE_MAX_WORK_ITEM_SIZES,
                       sz * sizeof(size_t), svec, NULL)
            if err:
                raise OpenCLError(err)
            rans = []
            for i in range(sz):
                rans.append(svec[i])
            free(svec)
            return rans
        raise AttributeError, name
    def c_obj(self):
        return self.id

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

cdef class Context:
    cdef cl_context context
    cdef object devs
    cdef object buggy
    cdef object ctx_devs_op

    def __cinit__(self, cl_device_type type=DEVICE_TYPE_DEFAULT, buggy='auto'):
        cdef cl_int err
        self.context = clCreateContextFromType(<cl_context_properties*>0,
                                          type,
                                          <void (*)(char *, void *, size_t, void *)>0,
                                          <void*>0,
                                          &err)
        if err != 0:
            raise OpenCLError(err)

        self.devs = None

        # Fallback for bugged implementation (NVIDIA:)
        if buggy == 'auto':
            if 'PYTHON_OPENCL_BUGGY' in environ:
                buggy = True
            else:
                p = get_platforms()
                if len(p) == 1 and p[0].name == 'NVIDIA':
                    buggy = True
                else:
                    buggy = False
        self.buggy = buggy
        if self.buggy:
            self.ctx_devs_op = 0x1082
        else:
            self.ctx_devs_op = CONTEXT_DEVICES

    def __dealloc__(self):
        '''
        Decrements the context reference count.
        '''
        #cdef cl_int err
        #err = clReleaseContext(self.context)
        #if err != 0:
        #    raise OpenCLError(err)
        pass

    def c_obj(self):
        return self.context

    def get_devices_count(self):
        cdef cl_int err
        cdef size_t ret
        err = clGetContextInfo(self.context, self.ctx_devs_op,
                               <size_t>0, <void*>0, &ret)
        if err != 0:
            raise OpenCLError(err)
        return ret/sizeof(cl_device_id)

    def get_devices(self):
        dev_count = self.get_devices_count()

        cdef cl_int err
        cdef cl_device_id *dev_mem = <cl_device_id *> malloc (dev_count*sizeof(cl_device_id))
        err = clGetContextInfo(self.context, self.ctx_devs_op,
                               dev_count*sizeof(cl_device_id),
                               dev_mem, <size_t *>0)
        if err != 0:
            free(dev_mem)
            raise OpenCLError(err)

        devs = [Device(<unsigned long>dev_mem[i]) for i from 0<=i<dev_count]
        free(dev_mem)
        
        return devs

    def __getattr__(self, name):
        if name == 'devices':
            if self.devs:
                return self.devs
            self.devs = self.get_devices()
            return self.devs
            return self.devs
        raise AttributeError, name

cdef class CommandQueue:
    cdef cl_command_queue queue
    cdef object context
    cdef object device
    cdef object properties
    def __cinit__(self, device=None, out_of_order=False,
                 profiling=False, context=None):
        '''
        The devices if given must be associated with the context used
        or be of the same type as the type with which the context was
        created if no devices have been specified on context creation.

        :param device: Device on which to queue the commands.
        :param out_of_order: If set, commands are executed out of order.
        :param profiling: Enable the profiling of commands.
        '''
        cdef int err
        # Fill with default parameters
        if context is None:
            context = default_context()
        self.context = context
        if device is None:
            if len(context.devices):
                device = context.devices[0]
            else:
                raise OpenCLError('Default context has no devices')
        self.device = device
        # Properties to pass
        props = 0
        if out_of_order:
            props |= QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE
        if profiling:
            props |= QUEUE_PROFILING_ENABLE
        self.properties = props

        self.queue = clCreateCommandQueue(context.c_obj(),
                                          device.c_obj(), props, &err)
        if err:
            raise OpenCLError(err)

    def __dealloc__(self):
        '''
        Decrements the queue reference count.
        '''
        cdef int err
        #err = clReleaseCommandQueue(self.queue)
        #if err != 0:
        #    raise OpenCLError(err)

    def flush(self):
        '''
        Issues all previously queued OpenCL commands in the queue.
        '''
        cdef int err
        err = clFlush(self.queue)
        if err != 0:
            raise OpenCLError(err)

    def finish(self):
        '''
        Blocks until all previously queued OpenCL commands are issued.
        '''
        cdef int err
        err = clFinish(self.queue)
        if err != 0:
            raise OpenCLError(err)

    def enqueue_read_buffer(self, buffer, ndarray data, blocking=True):
        cdef int err
        err = clEnqueueReadBuffer(self.queue, buffer.c_obj(), blocking,
                                  0, data.nbytes, PyArray_DATA(data),
                                  0, NULL, NULL)
        if err != 0:
            raise OpenCLError(err)

    def enqueue_write_buffer(self, buffer, ndarray data, blocking=True):
        cdef int err
        err = clEnqueueWriteBuffer(self.queue, buffer.c_obj(), blocking,
                                   0, data.nbytes, PyArray_DATA(data),
                                   0, NULL, NULL)
        if err != 0:
            raise OpenCLError(err)

    def enqueue_nd_range_kernel(self, krnl, global_work_size=None,
                                local_work_size=None):
        '''
        Enqueue a command to execute a kernel on a device.
        '''
        cdef size_t *c_gws
        cdef size_t *c_lws
        work_dim = 0
        if global_work_size:
            work_dim = len(global_work_size)
            c_gws = <size_t *> malloc (work_dim * sizeof (size_t))
            for i, x in enumerate(global_work_size):
                c_gws[i] = x
        else:
            c_gws = NULL
        if local_work_size:
            #work_dim = len(local_work_size)
            c_lws = <size_t *> malloc (work_dim * sizeof (size_t))
            for i, x in enumerate(local_work_size):
                c_lws[i] = x
        else:
            c_lws = NULL
        args = [hex(self.queue), hex(krnl.c_obj), work_dim,
                None, global_work_size, local_work_size, 0, None, None]
        regs = 'rdi rsi rdx rcx r8 r9'.split()
        err = clEnqueueNDRangeKernel(self.queue, krnl.c_obj, work_dim,
                                     NULL, c_gws, c_lws,
                                     0, NULL, NULL)
        if c_gws:
            free(c_gws)
        if err:
            raise OpenCLError(err)


cdef class Buffer:
    cdef cl_mem mem
    cdef object ndarray
    cdef public long nbytes
    cdef object dtype
    cdef object shape

    def __cinit__(self, size_or_data, mem_flags=None, context=None):
        cdef void * c_data
        cdef int size
        cdef int err

        if context is None:
            context = default_context()

        # Handle NumPy array
        if isinstance(size_or_data, numpy.ndarray):
            # TODO: assert contiguousity
            #data = ascontiguousarray(size_or_data)
            if mem_flags is None:
                mem_flags = MEM_READ_WRITE | MEM_USE_HOST_PTR
            #data = <ndarray>size_or_data
            data = size_or_data
            self.ndarray = data
            c_data = PyArray_DATA(data)
            self.nbytes = data.nbytes
            self.dtype = data.dtype
            self.shape = data.shape
        else:
            if mem_flags is None:
                mem_flags = MEM_READ_WRITE | MEM_ALLOC_HOST_PTR
            c_data = NULL
            self.nbytes = int(size_or_data)
        self.mem = clCreateBuffer(context.c_obj(), <cl_mem_flags>mem_flags,
                                  self.nbytes,
                                  c_data, &err)
        if err != 0:
            raise OpenCLError(err)

    #def __dealloc__(self):
    #    cdef cl_int err
    #    print 'Dmem', self.mem
    #    err = clReleaseMemObject(self.mem)
    #    if err != 0:
    #        raise OpenCLError(err)

    def c_obj(self):
        return <int>self.mem

    def read(self, out=None, queue=None):
        if queue is None:
            queue = default_queue()
        if out is None:
            # TODO: try guessing nbytes and dtype
            out = ndarray(self.nbytes if self.shape is None else self.shape,
                          dtype='int8' if self.dtype is None else self.dtype)
            #print 'OUT', out.shape, out.nbytes
        queue.enqueue_read_buffer(self, out)
        queue.finish()
        return out

    def write(self, data, queue=None):
        '''
        Write memory data from host memory to this device buffer.
        '''
        if queue is None:
            queue = default_queue()
        queue.enqueue_write_buffer(self, data)
        queue.finish()

    def copy(self, src, queue=None):
        '''
        Copy the device memory data from the Buffer src to this one.

        :param src: Buffer to copy memory from.
        '''
        if queue is None:
            queue = default_queue()
        queue.enqueue_copy_buffer(self, src)
        queue.finish()


cdef class Program:
    cdef cl_program prog
    cdef bool built
    
    def __cinit__(self, src, Context context=None):
        '''
        Create a new program with the given source.
        '''
        cdef cl_int err
        if context is None:
            context = default_context()
        # Make sure src is a list
        if isinstance(src, str) or isinstance(src, unicode):
            src = [src]
        # Cast the list to a char **
        #c_src = (c_char_p * len(src))(*src)
        #*c_src = cython.pointer(char)[len(src)]
        cdef char ** c_src
        c_src = <char **> malloc (len(src) * sizeof (char *))
        for i, s in enumerate(src):
            c_src[i] = s
        # Create the OpenCL program
        self.built = False
        self.prog = clCreateProgramWithSource(context.context, len(src),
                                              c_src, <size_t *>0, &err)
        if err != 0:
            raise OpenCLError(err)

    def build(self, options=None, devices=None):
        '''
        Build a program executable from the program source or binary.
        '''
        cdef cl_int err
        dev_count = 0
        #if devices:
        #    dev_count = len(devices)
        #cdef cl_device_id *c_devs = \
        #        <cl_device_id *> malloc (dev_count * sizeof (cl_device_id))
        #cdef char* c_options = NULL
        #if options:
        #    c_options = options
        err = clBuildProgram(self.prog, dev_count, NULL, NULL,
                             NULL, NULL)
        if err:
            raise OpenCLError(err)
        self.built = True
 
    def create_kernel(self, name):
        '''
        Create a kernel object.
        '''
        if not self.built:
            self.build()
        return Kernel(self, name)

    def __getattr__(self, name):
        if name == 'prog':
            raise AttributeError, name
        return self.create_kernel(name)

    def c_obj(self):
        return self.prog

cdef class Kernel:
    cdef public cl_kernel c_obj
    cdef public long work_size
    def __cinit__(self, prog, name):
        cdef cl_int err
        self.c_obj = clCreateKernel(prog.c_obj(), name, &err)
        if err:
            raise OpenCLError(err)
        self.work_size = -1
    def set_arg(self, idx, arg):
        '''
        Set a single kernel arguments.
        '''
        cdef void *arg_value
        if isinstance(arg, Buffer):
            arg_size = sizeof(void *)
            arg_value = <void *> <long> arg.c_obj()
        elif isinstance(arg, int):
            arg_size = sizeof(int)
            arg_value = <void *><int>arg
        else:
            raise OpenCLError('Unmanaged type as kernel argument: %s' %
                              arg.__class__)
        err = clSetKernelArg(self.c_obj, idx, arg_size, &arg_value)
        if err:
            raise OpenCLError(err)
    def set_args(self, args):
        sz = 0
        for i, arg in enumerate(args):
            self.set_arg(i, arg)
            if hasattr(arg, 'nbytes'):
                sz += arg.nbytes
            else:
                print '!!!', arg, 'has not nbytes', arg.__class__
        self.work_size = sz
    def __call__(self, *args):
        '''
        Set the arguments of the kernel and call it.

        Calling the kernel means enqueing it to the queue. If no queue is
        specified, then the default queue is used.

        All Numpy arrays are first mapped into device memory through
        the Buffer class. At the end of the call, all automatically
        created NumPy arrays are read back to host memory.

        All the buffers are supposed to go to global memory in the device.
        The allocated global memory work size is simply the sum of all
        the sizes of the Buffer objects.
        '''
        # If we receive ndarrays, cast them
        rargs = []
        ro = []
        for arg in args:
            if isinstance(arg, ndarray):
                b = Buffer(arg)
                rargs.append(b)
                ro.append((arg, b))
            else:
                rargs.append(arg)
        # Define kernel arguments
        self.set_args(rargs)
        # Enqueue the call
        default_queue().enqueue_nd_range_kernel(self, [self.work_size])
        # Read back results if ndarrays given
        for arr, buf in ro:
            buf.read(arr)


def default_context():
    global default_ctx
    if default_ctx is None:
        default_ctx = Context()
    return default_ctx

def default_queue():
    global default_que
    if default_que is None:
        default_que = CommandQueue()
    return default_que


def get_platforms():
    '''
    Return the list of OpenCL platform availables.
    '''
    cdef int err

    # Get platform count
    cdef int count
    err = clGetPlatformIDs(0, NULL, <cl_uint *> &count)
    if err:
        raise OpenCLError(err)
    # Fetch platforms list
    cdef cl_platform_id *plats
    plats = <cl_platform_id *> malloc (count * sizeof (void *))
    err = clGetPlatformIDs(count, plats, NULL)
    if err:
        raise OpenCLError(err)
    #return [Platform(x) for x in plats]
    ans = []
    for i in range(count):
        ans.append(Platform(plats[i]))
    free(plats)
    return ans


def get_devices(platform=None, type=DEVICE_TYPE_ALL):
    '''
    Return list of devices available on a given platform.

    :param platform: Default OpenCL platform to use.
    :param type: OpenCL device type to list.
    '''
    if platform is None:
        platform = default_platform()

    # Get the device count
    cdef cl_uint dev_count
    cdef int err
    err = clGetDeviceIDs(platform.id, type, 0, NULL, &dev_count)
    if err:
        raise OpenCLError(err)
    # Allocate an array to store the results
    cdef cl_device_id *data
    data = <cl_device_id *> malloc (dev_count * sizeof(void *))
    # Fetch the device ids
    err = clGetDeviceIDs(platform.id, type, dev_count, data, &dev_count)
    if err:
        raise OpenCLError()
    ans = []
    for i in range(dev_count):
        ans.append(Device(data[i]))
    free(data)
    return ans

def default_platform():
    global default_pla
    if default_pla is None:
        default_pla = get_platforms()[0]
    return default_pla
