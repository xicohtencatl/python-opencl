F.A.Q.
======
About OpenCL and python-opencl
------------------------------
What are python-opencl and OpenCL?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
`python-opencl`_ aims at being an easy to use pythonic wrapper around the
`OpenCL`_ standard library. `OpenCL`_ is a specification for computing on
heterogenous devices such as GPUs or multi-core CPUs. By using highly
parallel devices, you can greatly improve the execution speed of your
algorithms, providing they are designed for it.

Why should I choose OpenCL?
^^^^^^^^^^^^^^^^^^^^^^^^^^^
`OpenCL`_ is the emerging standard for parallel computing on heterogenous
devices. It provides a common programming language and supporting library
for all kind of different devices. The time spent porting one application
from one kind of device to another is then greatly reduced.

You may already have heard of CUDA, the proprietary platform of NVIDIA
dealing with graphic card. CUDA is limited to NVIDIA graphic cards
and thus provides no porting possibilites to other graphic cards,
not to say about other kind of devices. On the contrary, OpenCL
provides a standard platform for all devices. Moreover NVIDIA is part of
the OpenCL consortium and they do provide an OpenCL platform for
NVIDIA graphic cards.

Should I start using OpenCL now?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The short answer is: **Yes!** OpenCL is trully emerging as a standard
with the version 1.0 published, and some implementations already
exists: AMD and NVIDIA releases theirs, respectively for x86 CPUs and for
GPUs. Apple is also releasing an OpenCL ready operating system with
Mac OS X 10.6 "Snow Leopard".

However OpenCL is still not yet mainly supported by all potential
platforms, in particular certain OS or drivers are necessary to support it.
So do not expect high performance with OpenCL on all platforms,
in particular if you fall back to the x86 CPUs implementation.

First steps
-----------
How do I move to OpenCL?
^^^^^^^^^^^^^^^^^^^^^^^^
To fully use the power of parallel devices, you need to redesign your
algorithms so that they work in parallel. Here is an easy example:
assume your algorithm does the same operation at each point on a
2D image independantly (e.g. a convolution). You can then removed
the ``for`` loop iterating over the coordinates with an OpenCL
call which will used in parallel by the device.

For a gentle introduction see the Tutorial.

.. _python-opencl: http://python-opencl.next-touch.com
.. _OpenCL: http://www.khronos.org/opencl/
