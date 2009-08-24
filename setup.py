#! /usr/bin/env python
# -*- coding: utf-8; -*-

'''
setup.py file for OpenCL module.

:author: Xīcòtēncatl <xicohtencatl@next-touch.com>
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
      version='0.2.1',
<<<<<<< HEAD
      author='In Tlapatlac',
      author_email='tlapatlac@next-touch.com',
=======
      author='Xīcòtēncatl',
      author_email='xicohtencatl@next-touch.com',
>>>>>>> kiribati/master
      description='OpenCL wrapper module',
      url='http://python-opencl.next-touch.com',
      classifiers=[
          'Development Status :: 2 - Pre-Alpha',
          'Intended Audience :: Developers',
          'Intended Audience :: Science/Research',
          'License :: OSI Approved :: GNU General Public License (GPL)',
          'Topic :: Multimedia :: Graphics',
          'Topic :: Scientific/Engineering',
          'Topic :: Software Development :: Libraries :: Python Modules',
          'Topic :: System :: Distributed Computing',
          'Topic :: System :: Hardware',
      ],
      cmdclass={'build_ext': build_ext},
      ext_modules=[opencl_module],
      py_modules=['opencl']
     )
