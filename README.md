# Compiler/Profiler
A drop in replacement for g++ which measures compilation times and memory usage.

# Usage
```sh
$ export ACTUAL_COMPILER=/usr/bin/clang++
$ export PROFILING_LOG=~/log.csv
$ time-g++ -c main.cpp
> !!! logging compilation profile to ~/log.csv
$ cat log.csv
> Filename;Time (s);Memory (B);Path
> main.cpp;1.03;30949376;main.cpp
$
```

# Credits
Thanks to Ralf Berger (DLR) for initial implementation.
