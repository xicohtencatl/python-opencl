#! /usr/bin/env python
# -*- coding: utf-8; -*-

from numpy import *
import opencl

if __name__ == '__main__':
    h_idata = arange(32*(1<<20), dtype='uint8')
    buf = opencl.Buffer(h_idata)
    h_odata = buf.read()

    print 'OK' if ((h_idata == h_odata).prod()) else 'Error'
