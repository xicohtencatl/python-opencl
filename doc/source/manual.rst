Manual
======
Working with different toolkits
-------------------------------
Various vendors propose their own different implementations of the OpenCL
standard. By default `Python::OpenCL`_ choose the first library named
``libOpenCL.so`` found by the dynamic linker. However you can directly
specify which OpenCL library to use by setting the ``PYTHON_OPENCL_LIB``
library variable. You might thus get the following results::

    $ PYTHON_OPENCL_LIB=/path/to/nvidia-opencl/libOpenCL.so ./device_query.py 
    Platform 12289
      Name: NVIDIA
      ...
      Device 65536
        Name: Quadro NVS 135M
        Type: GPU
        ...

    $ PYTHON_OPENCL_LIB=/path/to/ati-opencl/libOpenCL.so ./device_query.py 
    Platform None
      Name: ATI Stream
      ...
      Device 23218550
        Name: Intel(R) Core(TM)2 Duo CPU     T7500  @ 2.20GHz
        Type: CPU
        ...

Future versions may allow you to mix different implementation at the same time.

.. _`Python::OpenCL`: http://python-opencl.next-touch.com
