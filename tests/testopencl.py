#! /usr/bin/env python
# -*- coding: utf-8; -*-

import unittest
from numpy import * #arange, ndarray
import opencl


class TestOpenCL(unittest.TestCase):
    SIZE = 32*(1<<20)

    def setUp(self):
        pass
    # Context stuff
    def test_context_create(self):
        ctx = opencl.Context()

    # Queue stuff
    def test_queue_create(self):
        ctx = opencl.Context()
        queue = opencl.CommandQueue(context=ctx)

    # Memory stuff
    def test_buffer_create(self):
        hdata = ndarray(32*(1<<20), dtype='int8')
        buf = opencl.Buffer(hdata)

    def test_buffer_create_from_data(self):
        ctx = opencl.Context()
        h_idata = arange(32*(1<<10), dtype='int8')
        h_odata = ndarray(h_idata.shape, dtype=h_idata.dtype)
        buf = opencl.Buffer(h_idata, context=ctx)
        queue = opencl.CommandQueue(context=ctx)
        queue.enqueue_read_buffer(buf, h_odata)
        queue.finish()
        self.assert_((h_idata == h_odata).prod())

    def test_buffer_create_from_data_implicit(self):
        h_idata = arange(32*(1<<10), dtype='int8')
        buf = opencl.Buffer(h_idata)
        h_odata = buf.read()
        self.assert_((h_idata == h_odata).prod())

    def test_buffer_create_from_type(self):
        SZ = 128
        h_idata = arange(SZ, dtype='float32')
        buf = opencl.Buffer(h_idata)
        h_odata = buf.read()
        for i in range(SZ):
            print h_idata[i], h_odata[i]
        print h_odata.shape, h_odata.dtype
        self.assert_((0. + (h_idata == h_odata)).prod())

    def test_buffer_read_write(self):
        a = random.random(32*(1<<20)).astype('float32')
        b = random.random(32*(1<<20)).astype('float32')
        buf = opencl.Buffer(a)
        buf.write(b)
        o = buf.read()
        self.assert_((0. + (b == o)).prod())

    #def test_buffer_copy(self):
    #    a = random.random(self.SIZE).astype('float32')
    #    b = zeros_like(a)
    #    b1 = opencl.Buffer(a)
    #    b2 = opencl.Buffer(b)
    #    b2.copy(b1)
    #    o = b2.read()
    #     self.assert_((0. + (a == o)).prod())

if __name__ == '__main__':
    unittest.main()
