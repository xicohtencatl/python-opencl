#! /usr/bin/env python
# -*- coding: utf-8; -*-

'''
Display informations on all the devices for each OpenCL platform.
'''

from numpy import *
import opencl

dev_types = {
    opencl.DEVICE_TYPE_CPU: 'CPU',
    opencl.DEVICE_TYPE_GPU: 'GPU',
    opencl.DEVICE_TYPE_ACCELERATOR: 'Accelerator',
    opencl.DEVICE_TYPE_DEFAULT: 'Default',
}

if __name__ == '__main__':
    for p in opencl.get_platforms():
        print 'Platform', p.id
        print '  Name:', p.name
        print '  Vendor:', p.vendor
        print '  Version:', p.version
        print '  Profile:', p.profile
        print
        for d in p.devices:
            print '  Device', d.id
            print '    Name:', d.name
            print '    Vendor:', d.vendor
            print '    Version:', d.version
            print '    Profile:', d.profile
            print '    Extensions:', d.extensions
            print '    Type:', dev_types[d.type]
            print '    Vendor ID:', d.type
            print '    Max compute units:', d.max_compute_units
            print '    Max work item dimensions:', d.max_work_item_dimensions
            print '    Max work item sizes:', d.max_work_item_sizes
            #print '    Max mem alloc size:', d.max_mem_alloc_size
            #print '    Max work group size:', d.max_work_group_size
            print '    Global mem size:', d.global_mem_size
