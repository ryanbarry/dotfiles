#!/bin/bash
############################
# This script creates symlinks from the home directory to wherever you checkout the repo
############################

########## Variables

# dotfiles directory
dir=$( cd "$( dirname "$0" )" && pwd )
# old dotfiles backup directory
olddir=~/dotfiles_old
# list of dotfiles to link in home folder
files=`find $dir -type f -depth 1 -name ".*" | xargs basename`

########## Action

for file in $files; do
  # backup existing version of file, if any
  if [ -f ~/$file ]; then
    echo "Moving $file from ~ to $olddir"
    mkdir -p $olddir
    mv ~/$file ~/dotfiles_old/
  fi
  # symlink to file in this repo
  echo "creating symlink to $file in home directory"
  ln -fs $dir/$file ~/$file
done
