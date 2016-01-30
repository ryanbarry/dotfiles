# purpose: prepare bash for interactive use

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases, ~/.functions and ~/.profile
# ~/.extra can be used for stuff you don’t want committed to the repo
for file in ~/.{extra,bash_prompt,aliases,functions,profile}; do
  [ -r "$file" ] && source "$file"
done
unset file

# node version manager
NVM_INSTALL_DIR=$(brew --prefix nvm) && export NVM_DIR=~/.nvm && \
[[ -s $NVM_INSTALL_DIR/nvm.sh ]] && source $NVM_INSTALL_DIR/nvm.sh

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -r "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# disable XON/XOFF since Ctrl-S is useful for searching forward in bash history
stty -ixon
# bind C-w to backward-kill-word so it stops at slashes and spaces (similar to emacs)
stty werase undef # first have to undefine binding from tty
bind '"\C-w": backward-kill-word' # now tell bash what to do with the key chord

####
##
##  the following came from .profile, it doesn't belong there
##
####

#PATH=/Users/rbarry/.rbenv/bin:/Users/rbarry/.rbenv/shims:/Users/rbarry/.rvm/gems/ruby-2.0.0-p247/bin:/Users/rbarry/.rvm/gems/ruby-2.0.0-p247@global/bin:/Users/rbarry/.rvm/rubies/ruby-2.0.0-p247/bin:/Users/rbarry/.rvm/bin:/Users/rbarry/.nvm/v0.8.26/bin:/usr/local/share/npm/bin:$PATH:/Users/rbarry/android-sdk/tools:/Users/rbarry/android-sdk/platform-tools

if `which rbenv`; then
  source "/usr/local/Cellar/rbenv/0.4.0/libexec/../completions/rbenv.bash"

  rbenv rehash 2>/dev/null
  rbenv() {
    typeset command
    command="$1"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
    rehash|shell)
      eval `rbenv "sh-$command" "$@"`;;
    *)
      command rbenv "$command" "$@";;
    esac
  }
fi
