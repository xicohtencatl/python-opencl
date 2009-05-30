#! /usr/bin/env python

import opencl

if __name__ == '__main__':
    devices = opencl.get_device_ids(opencl.PLATFORM_NVIDIA,
                                    opencl.DEVICE_TYPE_GPU)
    print 'Running on...'
    for dev in devices:
        print ' Device %s (from %d)' % (opencl.device_name(dev), dev)
