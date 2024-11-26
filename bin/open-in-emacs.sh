#!/bin/bash
# echo $0 $1 $2 $3 $4
ext=(txt json h hh hpp c cc cpp sh ham nip ni niw md cni java xml py mm)
# echo ${1: -4}
containsExt () {
  if [[ "${1[@]}" =~ "${2##*.}" ]]; then
    return 1
  else
    return 0
  fi
}

isNumber() {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    return 0
  else
    return 1
  fi
}

EMACS_CLIENT=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient

if [[ "${ext[@]}" =~ "${1##*.}" ]]; then
  # echo "$2"
  isNumber $2
  if [[ $? == 1 ]] ; then
    # echo "A $1 $2"
    $EMACS_CLIENT -nq +$2 $1
    # CMD="/usr/local/bin/emacsclient -nq +$2 $1"
    # echo $CMD
  else
    # echo "B [$1] [$2]"
    $EMACS_CLIENT -nq $1
    # CMD="/usr/local/bin/emacsclient -nq $1"
    # echo $CMD
  fi
else
  # echo "C $1"
  open "$1"
fi
