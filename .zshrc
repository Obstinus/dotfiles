# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'pc'

# Don't start tmux.
zstyle ':z4h:' start-tmux       no

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'no'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return
z4h install casonadams/alacritty-shell || return
# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
z4h load ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/ Shift+Tab  # undo the last command line change
z4h bindkey redo Alt+/             # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory

# Autoload functions.
autoload -Uz zmv
autoload -Uz compinit && compinit

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.

## File exploring aliases

### Remove Trash
alias emptytrash='sudo rm -rf ~/.Trash/*'

## "ls" to "exa"

alias ls="exa -al --color=always --group-directories-first --icons"
alias la="exa -a --color=always --group-directories-first --icons"
alias ll="exa -l --color=always --group-directories-first --icons"
alias lt="exa -aT --color=always --group-directories-first --icons"
alias lo="exa --reverse --sort=size --long"
alias tree="exa --tree"
alias cat="bat --style=auto"
alias skp="rg --files | sk --preview='bat {} --color=always'"
## Git aliases
alias gs="git status "
alias ga="git add "
alias gb="git branch "
alias gc="git commit"
alias gd="git diff"
alias gco="git checkout"
alias gk="gitk --all&"
alias gx="gitx --all"

### Common mistaken when typing covered
alias got="git "
alias get="git "

## Dotfiles git bare repository management alias
alias config='/opt/homebrew/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

## LunarVim alias

alias lv='lvim'

## Misc aliases
alias vd='python /Users/guirdias/down.py'
### Linux man-pages

lman() { man -M $HOME/man-pages/ "$@" }

### My MPV Apple Silicon build

alias mpv='~/mpv/build/mpv'

### Image viewer in kitty terminal
alias icat="kitty +kitten icat"

### Alacritty themes

alias at='alacritty-themes'

### NET

alias myip='~/intnet.sh'

# Add flags to existing aliases.
#alias ls="${aliases[ls]:-ls} -A"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# New paths below

## asdf-vm
. "$HOME/.asdf/asdf.sh"

### Add cargo installs coming from asdf-vm to the command line
export PATH=$PATH:~/.asdf/installs/rust/1.67.1/bin/

## Zoxide

eval "$(zoxide init zsh)"

## Pager

export PAGER="most"


## Enconding
export LANG="en_US.UTF-8"
export LC_ALL="POSIX"
export RUSTC_WRAPPER="/Users/guirdias/.asdf/installs/rust/1.67.1/bin//sccache"
export EDITOR='lvim'
