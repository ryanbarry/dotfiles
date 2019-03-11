#!/bin/bash
############################
# This script creates symlinks from the home directory to wherever you checkout the repo
############################

########## Variables

set -e

# dotfiles directory
dir=$( cd "$( dirname "$0" )" && pwd )
# old dotfiles backup directory
olddir=~/dotfiles_old
# list of dotfiles to link in home folder
files=$( find $dir -type f -depth 1 -name ".*" | xargs basename )

########## Action

for file in $files; do
  # backup existing version of file, if any
  if [ -f ~/$file ] && [ ! -L ~/$file ]; then
    echo "Moving $file from ~ to $olddir"
    mkdir -p $olddir
    mv ~/$file $olddir/
  fi
  # symlink to file in this repo
  echo "creating symlink to $file in home directory"
  ln -fs $dir/$file ~/$file
done

# now do this for the scripts in ./bin
scripts=$( find $dir/bin -type f -depth 1 | xargs basename )
for script in $scripts; do
    if [ -f ~/bin/$script ] && [ ! -L ~/bin/$script ]; then
        mkdir -p $olddir/bin
        mv ~/bin/$script $olddir/bin/
    fi
    echo "creating symlink to $script in home bin directory"
    ln -fs $dir/bin/$script ~/bin/$script
done
