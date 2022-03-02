# purpose: exports & loading more when actually interactive

export AWS_CONFIG_FILE=~/.boto

# Make emacs-in-a-new-frame the default editor
export EDITOR='emacsclient'

# Larger bash history (default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

#export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
export PATH="$HOME/bin:$PATH"
[ -d /usr/local/opt/google-cloud-sdk ] && . /usr/local/opt/google-cloud-sdk/path.bash.inc && . /usr/local/opt/google-cloud-sdk/completion.bash.inc
[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Bash doesn't load its interactive initialization file if it's invoked as
# a login shell, so do it manually.
case $- in
    *i*) if [[ -n "$BASH" ]]; then
           source $HOME/.bashrc
         fi
esac
