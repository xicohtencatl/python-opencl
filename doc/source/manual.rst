Manual
======
Working with different toolkits
-------------------------------
Various vendors propose their own different implementations of the OpenCL
standard. As the `Python::OpenCL`_ extension should be a shared library,
it relies on standard dynamic linking procedure to find the OpenCL platform.
For instance on GNU/Linux, you can set the ``LD_LIBRARY_PATH`` environment
variable to the directory containing the OpenCL library (eg. ATI or NVIDIA)
you want to use.

.. _`Python::OpenCL`: http://python-opencl.next-touch.com
