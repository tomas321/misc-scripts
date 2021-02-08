#!/bin/bash
#
# compare 2 json files, possibly generating a patch file (e.g. $0 -Naur file1.json file2.json)
#
# possible envirnment variables:
#
#  INDENT - json indent to use (optional)
#
#
# usage: $0 [DIFF_OPTIONS] FILE1 FILE2
#
#  DIFF_OPTIONS - valid options to the diff command (see `man diff`)
#                 e.g. -Naur
#

# ENVIRONMENTS:
[ -z $INDENT ] && INDENT=4

options=""
f1="$1"
f2="$2"
if [[ $# -ge 3 ]]; then
  options="$1"
  f1="$2"
  f2="$3"
fi


result=$(jq --argfile a "$f1" --argfile b "$f2" -n '($a | (.. | arrays) |= sort) as $a | ($b | (.. | arrays) |= sort) as $b | $a == $b')

if [[ "$result" == 'true' ]]; then
  exit 0
fi

diff $options <(jq --indent $INDENT -S . $f1) <(jq --indent $INDENT -S . $f2)
exit 1
