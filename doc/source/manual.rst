Manual
======
Environment
-----------
Working with different toolkits
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Various vendors propose their own different implementations of the OpenCL
standard. As the `Python::OpenCL`_ extension should be a shared library,
it relies on standard dynamic linking procedure to find the OpenCL platform.
For instance on GNU/Linux, you can set the ``LD_LIBRARY_PATH`` environment
variable to the directory containing the OpenCL library (eg. ATI or NVIDIA)
you want to use.

Performances
------------
Timers
^^^^^^
Since OpenCL instructions can be executed asynchonously, you cannot rely
on standard CPU functions to time them. OpenCL provides profiling mechanisms.
In `Python::OpenCL`_ you can easily use them.

First you need to have profiling enable for the queue you want to set.
This can be done when you create a new ``CommandQueue`` by setting the
``profiling`` attribute to ``True``.

Commands enqueued return an ``Event`` object whose ``start`` and ``end``
fields give an information on its duration. Here is an example::

  queue = CommandQueue(profiling=True)
  event = queue.enqueue_read_buffer(buf, h_odata)
  print 'Duration: %f ms' % ((evt.end - evt.start) * 1.0e-6)

.. _`Python::OpenCL`: http://python-opencl.next-touch.com
