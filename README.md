nvstats: The Linux Nvidia Statistics Library
============================================

This is a (very) simple libary created to allow easy GPU readout's through Conky.

Includes built-in functions to read the most popular values, including GPU utilisation, temperature, memory usage and the driver version. However, through the nvQuery function, any target listed under "nvidia-settings -q all" can be read and parsed nicely.

The code is sloppy, but it get's the job done. I plan to further update and optimise the library, as well as expose new values as they become available.
Obviously this is dependant on nvidia-settings (i.e. it uses the propietary Unix driver).
