#! /usr/bin/env bash
#
# This file is part of AirStashPlayer.
# Copyright (c) 2016 Wearable Inc.
#
# AirStashPlayer is based on ijkPlayer:
# Copyright (c) 2013-2014 Zhang Rui <bbcallen@gmail.com>
#
# Portions of ijkPlayer are based on kxmovie:
# Copyright (c) 2012 Konstantin Boukreev. All rights reserved.
#
# AirStashPlayer is free software: you can redistribute it and/or
# modify it under the terms of version 3 of the GNU Lesser General
# Public License as published by the Free Software Foundation.
#
# AirStashPlayer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with AirStashPlayer.  If not, see
# <http://www.gnu.org/licenses/>.

#! /usr/bin/env bash

#--------------------
# Standard options:
export COMMON_FF_CFG_FLAGS=
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --prefix=PREFIX"

# Licensing options:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-gpl"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-version3"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-nonfree"

# Configuration options:
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-static"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-shared"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-small"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-runtime-cpudetect"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-gray"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-swscale-alpha"

# Program options:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-programs"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-ffmpeg"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-ffplay"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-ffprobe"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-ffserver"

# Documentation options:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-doc"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-htmlpages"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-manpages"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-podpages"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-txtpages"

# Component options:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-avdevice"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-avcodec"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-avformat"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-avutil"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-swresample"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-swscale"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-postproc"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-avfilter"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-avresample"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-pthreads"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-w32threads"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-os2threads"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-network"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-dct"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-dwt"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-lsp"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-lzo"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mdct"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-rdft"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-fft"

# Hardware accelerators:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-dxva2"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-vaapi"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-vda"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-vdpau"

# Individual component options:
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-everything"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-encoders"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-decoders"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-hwaccels"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-muxers"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-demuxers"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-parsers"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsfs"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocols"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-devices"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-filters"

# External library support:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-iconv"
# ...

export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=async"

# Advanced options (experts only):
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --cross-prefix=${FF_CROSS_PREFIX}-"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-cross-compile"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --sysroot=PATH"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --sysinclude=PATH"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --target-os=TAGET_OS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --target-exec=CMD"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --target-path=DIR"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --toolchain=NAME"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --nm=NM"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --ar=AR"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --as=AS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --yasmexe=EXE"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --cc=CC"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --cxx=CXX"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --dep-cc=DEPCC"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --ld=LD"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-cc=HOSTCC"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-cflags=HCFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-cppflags=HCPPFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-ld=HOSTLD"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-ldflags=HLDFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-libs=HLIBS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-os=OS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --extra-cflags=ECFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --extra-cxxflags=ECFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --extra-ldflags=ELDFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --extra-libs=ELIBS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --extra-version=STRING"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --optflags=OPTFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --build-suffix=SUFFIX"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --malloc-prefix=PREFIX"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --progs-suffix=SUFFIX"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --arch=ARCH"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --cpu=CPU"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-pic"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-sram"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-thumb"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-symver"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-hardcoded-tables"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-safe-bitstream-reader"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-memalign-hack"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-lto"

# Optimization options (experts only):
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-asm"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-altivec"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-amd3dnow"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-amd3dnowext"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mmx"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mmxext"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-sse"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-sse2"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-sse3"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-ssse3"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-sse4"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-sse42"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-avx"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-fma4"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-armv5te"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-armv6"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-armv6t2"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-vfp"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-neon"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-vis"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-inline-asm"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-yasm"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mips32r2"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mipsdspr1"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mipsdspr2"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mipsfpu"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-fast-unaligned"

# Developer options (useful when working on FFmpeg itself):
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-coverage"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-debug"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-debug=LEVEL"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-optimizations"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-extra-warnings"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-stripping"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --assert-level=level"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-memory-poisoning"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --valgrind=VALGRIND"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-ftrapv"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --samples=PATH"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-xmm-clobber-test"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-random"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-random"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-random=LIST"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-random=LIST"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --random-seed=VALUE"