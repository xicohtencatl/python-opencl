Installation
============
Requirements
------------
`Python::OpenCL`_ requires a working `OpenCL`_ platform to be built and run.
Moreorver it is tightly integrated to the `NumPy`_ library as a Python backed
for multi-dimensional arrays and scientific applications.

The library has been tested with the following platforms:

- `NVIDIA`_ Conformant Release 1.0 on GNU/Linux.
- `AMD`_ ATI Stream on GNU/Linux.

Build and install
-----------------
`Python::OpenCL`_ is a simple Python library managed thanks to `distutils`_.
After grabbing its sources, you can simply build and install it using a classical::

    $ python setup.py install

You may also want to specify include directories or library path with ``-I`` or ``-L``.
For more information, use the ``--help`` option.

.. _`Python::OpenCL`: http://python-opencl.next-touch.com
.. _OpenCL: http://www.khronos.org/opencl/
.. _`distutils`: http://docs.python.org/distutils/
.. _`NumPy`: http://www.scipy.org/
.. _NVIDIA: http://www.nvidia.com/object/cuda_opencl.html
.. _`AMD`: http://developer.amd.com/GPU/ATISTREAMSDKBETAPROGRAM
