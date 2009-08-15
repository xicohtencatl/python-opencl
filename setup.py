#! /usr/bin/env python
# -*- coding: utf-8; -*-

'''
setup.py file for OpenCL module.

:author: Émilien Tlapale <emilien@tlapale.com>
'''

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

#opencl_module = Extension('_opencl',
#                          sources=['opencl_wrap.c'],
#                         include_dirs=['include'])
#
#setup(name='opencl',
#      version='0.0.1',
#      author='Émilien Tlapale',
#      description='OpenCL wrapper module',
#      ext_modules=[opencl_module],
#      py_modules=['opencl']
#     )

opencl_module = Extension('opencl', ['opencl.pyx'],
                          include_dirs=['/usr/lib64/python2.6/site-packages/numpy/core/include',
                                       '/usr/lib64/python2.5/site-packages/numpy/core/include',
                                       '/home/etlapale/NVIDIA_GPU_Computing_SDK/OpenCL/common/inc'],
                          libraries=['OpenCL'],
                          library_dirs=['/home/etlapale/nosave/ati-stream-sdk-v2.0-beta2-lnx64/lib/x86_64'],
                          extra_link_args=['-g'],
                          extra_compile_args=['-g'])

setup(name='opencl',
      version='0.0.1',
      author='Émilien Tlapale',
      description='OpenCL wrapper module',
      cmdclass={'build_ext': build_ext},
      ext_modules=[opencl_module],
      py_modules=['opencl']
     )
