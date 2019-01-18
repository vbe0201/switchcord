#!/bin/sh

# @file
# To compile for with the aarch64 toolkit provided by DevkitPro, you
# need to set all the tools you need as exports, then CMake will cache
# those settings properly. Therefore this file exists to automate this
# process to help people with compiling for the Switch.
#
# @see https://stackoverflow.com/a/17275650

if [[ -z "$DEVKITPRO" ]]
then
      echo "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>/devkitpro"
fi

PREFIX=$DEVKITPRO/devkitA64/bin/aarch64-none-elf-

export CC=${PREFIX}gcc
export CXX=${PREFIX}g++
export AS=${PREFIX}as
export AR=${PREFIX}gcc-ar
export OBJCOPY=${PREFIX}objcopy
export STRIP=${PREFIX}strip
export NM=${PREFIX}gcc-nm
export RANLIB=${PREFIX}gcc-ranlib

export LD=${CXX}

cmake .