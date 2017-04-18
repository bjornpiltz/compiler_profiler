#!/bin/bash
# if environment variable 'LOG_DIR' is not set, use the temp location to write the logging data
[ -z $LOG_DIR ] && LOG_DIR=$(dirname $(mktemp -u))
[ -z $PROFILING_LOG ] && PROFILING_LOG="${LOG_DIR}/profiling_data.log"

if [[ ! -a $PROFILING_LOG ]] 
then
echo a
  touch $PROFILING_LOG
  echo -e "\n!!! logging compilation profile to $PROFILING_LOG\n"
  echo "Filename;Time (s);Memory (KB);Path" >> $PROFILING_LOG
fi

# get the absolute path to the default g++ compiler
if [ ! $ACTUAL_COMPILER ]
then
  COMPILER=$(which g++)
else
  COMPILER=$ACTUAL_COMPILER
fi

# get the absolute path to the time command
if [ ! $TIME_CMD ]
then
 TIME_CMD=$(which time)
fi

# get the name of the compilation unit by searching the "-c <filename>" part of the compiler commandline
# (for linker calls $UNIT will be empty)
UNIT=`echo "$@"| grep -o "\-c .*" | cut -d ' ' -f2`

if [ $UNIT ]
then
  NAME=$UNIT
  SHORTNAME=`basename $NAME`
else
  NAME="Linker/"
  SHORTNAME="Linker"
fi

$TIME_CMD -o $PROFILING_LOG -a -f "$SHORTNAME,%U,%M,$NAME" $COMPILER "$@"

