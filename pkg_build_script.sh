#!/bin/bash
# this script working directory must be ${your workspace}/build/${your package name}
WORKSPACE_DIR=$(realpath ../../)
PKG_NAME=${PWD##*/}
CPU_LOGIC_CORE_NUM=$(grep -c processor /proc/cpuinfo)
if [ "$ROS_DISTRO" == "" ];then
#manual
ROS_DISTRO=jazzy
fi

if [ "$CPU_LOGIC_CORE_NUM" == "" ];then
  CPU_LOGIC_CORE_NUM=1
fi

source "/opt/ros/$ROS_DISTRO/setup.bash"

PKG_SRC_PATH="$WORKSPACE_DIR/src/$PKG_NAME"
PKG_BUILD_PATH="$WORKSPACE_DIR/build/$PKG_NAME"
PKG_INSTALL_PATH="$WORKSPACE_DIR/install/$PKG_NAME"


export CMAKE_PREFIX_PATH="/opt/ros/$ROS_DISTRO"
cmake "$PKG_SRC_PATH" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -G Ninja -DCMAKE_INSTALL_PREFIX="$PKG_INSTALL_PATH"
cmake --build "$PKG_BUILD_PATH" -- "-j$CPU_LOGIC_CORE_NUM" "-l$CPU_LOGIC_CORE_NUM"
cmake --install "$PKG_INSTALL_PATH"


cp "$PKG_BUILD_PATH"/compile_commands.json "$WORKSPACE_DIR"/build/
