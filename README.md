Script and Program Examples
===========================

This repository contains various scripts and programs which are
either just serve as examples or are too trivial to be distributed
individually.

Shell Scripts
-------------

The `shell` subdirectory contains various shell scripts:

-    The `mbset.sh` script show the Mandelbrot set rendered on the terminal (Unicode required).
     It is an example of using math in shell scripts, using specialized programs (in this case
     `bc`) in a pipeline, terminal handling, and pseudo-graphics in terminals.

-    The `mpmbset.sh` script is the next version of `mbset.h`.  It performs the same operations
     but roughly four times.  This is achieved by using four processes which do the computation.
     The script shows how to create parallelism in shell scripts, string handling, and how to
     handle multiple different data streams.  Note that the display part of the script is
     identical to that in `mbset.sh`.
