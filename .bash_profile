# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases, ~/.functions and ~/.profile
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,bash_prompt,exports,aliases,functions,profile}; do
  [ -r "$file" ] && source "$file"
done
unset file

if [ -r "$HOME/.nvm/nvm.sh" ]; then
  source ~/.nvm/nvm.sh # load node version manager
fi

export EDITOR="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -r "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

export PATH="/Users/rbarry/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

# disable XON/XOFF since Ctrl-S is useful for searching forward in bash history
stty -ixon
# bind C-w to backward-kill-word so it stops at slashes and spaces (similar to emacs)
stty werase undef # first have to undefine binding from tty
bind '"\C-w": backward-kill-word' # now tell bash what to do with the key chord
