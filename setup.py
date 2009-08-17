#! /usr/bin/env python
# -*- coding: utf-8; -*-

'''
setup.py file for OpenCL module.

:author: In Tlapatlac <tlapatlac@next-touch.com>
'''

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext


opencl_module = Extension('opencl', ['opencl.pyx'],
                          include_dirs=['/usr/lib64/python2.6/site-packages/numpy/core/include',
                                       '/usr/lib64/python2.5/site-packages/numpy/core/include',
                                       ],
                          libraries=['OpenCL'],
                         )

setup(name='python-opencl',
      version='0.2',
      author='In Tlapatlac',
      description='OpenCL wrapper module',
      cmdclass={'build_ext': build_ext},
      ext_modules=[opencl_module],
      py_modules=['opencl']
     )
