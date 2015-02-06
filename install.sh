#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# dotfiles directory
dir=$( cd "$( dirname "$0" )" && pwd )
# old dotfiles backup directory
olddir=~/dotfiles_old
# list of dotfiles to link in home folder
files=`find $dir -type f -depth 1 -name ".*" | xargs basename`

##########

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
  if [ -f ~/$file ]; then
    echo "Moving $file from ~ to $olddir"
    mkdir -p $olddir
    mv ~/$file ~/dotfiles_old/
  fi
  echo "creating symlink to $file in home directory"
  ln -fs $dir/$file ~/$file
done
