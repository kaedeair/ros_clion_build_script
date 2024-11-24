#!/bin/bash
# this script working directory must be ${your workspace}
colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -G Ninja
