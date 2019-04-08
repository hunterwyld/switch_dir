#!/bin/bash

usr_local_bin="/usr/local/bin"
usr_bin="/usr/bin"

function check_bin {
  if [ ! -f 'sd.sh' ]; then
    echo 'sd.sh not found'
    exit -1
  else
    chmod a+x sd.sh
  fi
}

function create_data_dir {
  local user_home=`echo ~`
  local data_dir="$user_home/.switch_dir"
  if [ ! -d $data_dir ]; then
    mkdir $data_dir
    chmod a+w $data_dir
  fi
}

function install {
  if [ -d $usr_local_bin ]; then
    install_bin $usr_local_bin
  elif [ -d $usr_bin ]; then
    install_bin $usr_bin
  else
    echo '/usr/local/bin and /usr/bin not found'
    exit -1
  fi
}

function install_bin {
  local dir=`pwd`
  cd $1
  if [ -h sd ]; then
    rm sd
  fi
  ln -s $dir/sd.sh sd
  cd $dir
}

check_bin

create_data_dir

install
