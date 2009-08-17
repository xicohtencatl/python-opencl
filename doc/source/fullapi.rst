=======================
Full Python::OpenCL API
=======================

.. currentmodule:: opencl

Platform Layer
==============

This section describes the wrapper around the OpenCL platform layer
corresponding to the Chapter 4 of the `OpenCL Specification`_.

.. autofunction:: get_platforms
.. autofunction:: get_devices

.. autoclass:: Platform
   :members: __init__
   :undoc-members:

.. autoclass:: Device
   :members: __init__
   :undoc-members:

.. autoclass:: Context
   :members: __init__
   :undoc-members:

Runtime Layer
=============

This section describes the wrapper around the OpenCL runtime layer
corresponding to the Chapter 5 of the `OpenCL Specification`_.

.. autoclass:: CommandQueue
   :members: __init__, flush, finish, enqueue_read_buffer, enqueue_nd_range_kernel
   :undoc-members:

.. autoclass:: Buffer
   :members: __init__, read
   :undoc-members:

.. autoclass:: Program
   :members: __init__, build, create_kernel, __getattr__
   :undoc-members:

.. autoclass:: Kernel
   :members: __init__, set_arg, set_args, __call__
   :undoc-members:

.. _`OpenCL Specification`: http://www.khronos.org/registry/cl/
