zmodload zsh/zprof
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

export PATH=/opt/homebrew/bin:$PATH

alias vi="nvim"
alias vim="nvim"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins=(zsh-nvm git npm docker docker-compose terraform)

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EDITOR='nvim'
export VISUAL='nvim'

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Function to insert a file path using fzf
insert_path_with_fzf() {
    local file
    file=$(find . -type f | fzf)
    LBUFFER+=$file
}

eval "$(zoxide init zsh)"
alias cd="z"
# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --max-depth 2 --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
# Bind Ctrl-T to the function
zle -N insert_path_with_fzf
bindkey '^T' insert_path_with_fzf

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/aryanrahman/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/aryanrahman/Downloads/google-cloud-sdk/path.zsh.inc'; fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/Users/aryanrahman/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/aryanrahman/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
function fzfo() {
    local selected=$(find . -type f -o -type d 2> /dev/null | fzf)
    if [ -d "$selected" ]; then
        cd "$selected"
    elif [ -f "$selected" ]; then
        open "$selected"
    fi
}

export BAT_THEME=tokyonight_night
alias cat="bat"
alias ld="eza -lD"
alias lf="eza -lf --color=always | grep -v /"
alias lh="eza -dl .* --group-directories-first"
alias ll="eza -al --group-directories-first"
alias ls="eza -alf --color=always --sort=size | grep -v /"
alias lt="eza -al --sort=modified"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit;
promptinit
prompt pure
