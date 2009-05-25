#! /usr/bin/env python

import opencl


if __name__ == '__main__':
    ctx = opencl.Context(opencl.DEVICE_TYPE_GPU)
    print 'Device count', ctx.get_devices_count()
    print 'Devices', ctx.get_devices()
    
    queue = opencl.CommandQueue(ctx)
