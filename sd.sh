#!/bin/bash

function show_usage() {
  local sd="sd"
  echo "Usage: $sd [-option]"
  echo "   or: $sd [-option] [arg...]"
  echo "where options include:"
  echo "   -h          show this help"
  echo "   -l          list all dirs"
  echo "   -s [no.]    select a dir to jump to, according to seq no."
  echo "   -a .        add current dir"
  echo "   -a [dir]    add absolute dir"
  echo "   -r [no.]    remove absolute dir, according to seq no."
  echo "   -rf         remove fake dirs"
  echo "   -R          remove all dirs"
}

user_home=`echo ~`
file="$user_home/.switch_dir/dirs.txt"

function read_file() {
  if [ -f $file ]; then
    while read line
    do
      echo $line
    done < $file
  else
    touch $file
  fi
}

function add_dir() {
  local d
  if [ "$1" = "." ]; then
    d=`pwd`
  else
    d=$1
  fi

  local array=(`read_file`)
  if [ "$array" = "" ]; then
    echo $d > $file
  else
    local exists="false"
    for dir in ${array[@]}
    do
      if [ "$dir" = "$d" ]; then
        exists="true"
        break
      fi
    done
    if [ "$exists" = "false" ]; then
      echo $d >> $file
    fi
  fi
}

function rem_dir() {
  local array=(`read_file`)
  local rem_idx=0
  let len=$[${#array[@]}+1]
  if [ $1 -lt $len -a $1 -gt 0 ]; then
    rem_idx=$1
  fi

  local i=0
  if [ "$rem_idx" != "0" ]; then
    rem_all_dirs
    for dir in ${array[@]}
    do
      ((i++))
      if [ "$rem_idx" != "$i" ]; then
        echo $dir >> $file
      fi
    done
  fi
}

function list_all_dirs() {
  echo "[#]    [dir]"
  local array=(`read_file`)
  local i=0
  for dir in ${array[@]}
  do
    ((i++))
    echo $i"      "$dir
  done
}

function sel_dir() {
  local array=(`read_file`)
  local i=0
  local sel_dir
  for dir in ${array[@]}
  do
    ((i++))
    if [ "$1" = "$i" ]; then
      sel_dir=$dir
      break
    fi
  done
  
  #alias 666="cd $sel_dir"
  shopt -s expand_aliases
  shopt expand_aliases
  alias 666="cd aa/bbb"
  source ~/.bashrc
  666
  #cd $sel_dir
}

function rem_all_dirs() {
  echo -n > $file
}

function rem_fake_dirs() {
  local array=(`read_file`)

  rem_all_dirs
  for dir in ${array[@]}
  do
    if [ -d $dir ]; then
      echo $dir >> $file
    fi
  done
}

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
  show_usage
fi

if [ $# -eq 1 ]; then
  if [ "$1" = "-h" ]; then
    show_usage
  elif [ "$1" = "-l" ]; then
    list_all_dirs
  elif [ "$1" = "-R" ]; then
    rem_all_dirs
  elif [ "$1" = "-rf" ]; then
    rem_fake_dirs
  else
    show_usage
  fi
fi

if [ $# -eq 2 ]; then
  if [ "$1" = "-a" ]; then
    add_dir $2
  elif [ "$1" = "-s" ]; then
    sel_dir $2
  elif [ "$1" = "-r" ]; then
    rem_dir $2
  else
    show_usage
  fi
fi