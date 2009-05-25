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
                          libraries=['OpenCL'],
                          library_dirs=['/usr/lib/nvidia-opencl/'])

setup(name='opencl',
      version='0.0.1',
      author='Émilien Tlapale',
      description='OpenCL wrapper module',
      cmdclass={'build_ext': build_ext},
      ext_modules=[opencl_module],
      py_modules=['opencl']
     )
