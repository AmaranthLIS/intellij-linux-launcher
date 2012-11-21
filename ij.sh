#!/usr/bin/env bash

# IMPORTANT!
#
# Acceptable performance requires using JDK 1.7 and setting the following
# property in $IDEA_HOME/bin/idea64.vmoptions :
#
#  -Dsun.java2d.xrender=true
#
# See: http://youtrack.jetbrains.com/issue/IDEA-18341

# This is Java 7
export IDEA_JDK=/usr/java/latest

IDEA_HOME=/local/$USER/intellij
INTELLIJ_BIN=$IDEA_HOME/bin/idea.sh
INTELLIJ_OPTION_FILE=$IDEA_HOME/bin/idea64.vmoptions

OPTION='-Dsun.java2d.xrender=true'

function check_for_option() {
  grep "\\$OPTION" $INTELLIJ_OPTION_FILE &> /dev/null
}

function update_options_file_if_needed() {
  check_for_option
  if [ ! "$?" == "0" ]; then
    echo $OPTION >> $INTELLIJ_OPTION_FILE
  fi
}

function run_intellij() {
  $INTELLIJ_BIN &> /dev/null &
}

update_options_file_if_needed
run_intellij
