User Manual
===========
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

Execution flow
--------------
Event objects
^^^^^^^^^^^^^
OpenCL provides ``Event`` objects as a way to manipulate the execution
flow, in particular to provide *dependencies* between commands. The
enqueueing commands of the class ``CommandQueue`` return an ``Event``
object which can be used to control the execution. In particular, since
OpenCL is asynchronous, you can explicitely ``wait()`` for an event
to be completed. Using ``wait_for()`` you can even wait for a bunch
of events to be completed.

Providing dependencies between the commands enqueued can be done
by passing a list of required events thanks to the ``wait_list``
attribute of enqueueing functions.

::
  queue = default_queue()
  evt_1 = queue.enqueue_xxx(...)
  evt_2 = queue.enqueue_yyy(...)
  evt_3 = queue.enqueue_zzz(..., wait_list=[evt_1, evt_2])

In this case, even if ``evt_1`` and ``evt_2`` are executed in
asynchronously, the third command is executed after both of them
are completed.

At any point in time you can query the ``status`` of an event
using the homonymous attribute returning a value in
``[QUEUED, SUBMITTED, RUNNING, COMPLETE]``.

Other event attributes are available if the queue has profiling
enabled.

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
