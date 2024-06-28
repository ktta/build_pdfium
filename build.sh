#!/bin/bash
#
# arguments: config_selector step last_step
#
# running this without any arguments is equivalent to linux 0 8
#
# config_selector is one of:
#   linux
#
# more to be added later.
#
# if step is omitted, it's considered to be 0.
# next step to be done is recorded in pdfium/build/step.txt
#
# if last_step is given, only steps [step..last_step] are executed
#

CONFIG_SEL="$1"
STEP_NUMBER="$2"
LAST_STEP="$3"

cd `dirname $0`
BSRC=`pwd`
TOPDIR="$BSRC/pdfium"
step_file=$TOPDIR/build/step.txt

for X in funcs/*.sh; do
  source $X
done

getconfig

COMMON_COMPILE_FLAGS="-Wfatal-errors -DU_COMMON_IMPLEMENTATION $CFLAGS_ICU $CFLAGS_FREETYPE -I third_party/abseil-cpp -I . -fdiagnostics-color=never $CFLAGS_JPEG" 
CXXFLAGS="-std=c++17 $COMMON_COMPILE_FLAGS $CXXFLAGS_EXTRA"
CFLAGS="$COMMON_COMPILE_FLAGS $CFLAGS_EXTRA"

get_steps
run_steps

