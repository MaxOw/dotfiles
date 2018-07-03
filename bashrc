
set -o vi
bind -m vi-insert '"ô":"\C-t"'
bind -m vi-insert '"ò":"\C-r"'
bind -m vi-insert '"æ": "\ec"'

bind -m vi-command '"ô":"\C-t"'
bind -m vi-command '"ò":"\C-r"'
bind -m vi-command '"æ": "\ec"'

# fzf options
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
#export FZF_DEFAULT_OPTIONS='--reverse'
export FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_OPTS='--preview "
[[ $(file -bL --mime {}) =~ binary ]] && echo {} is a binary file! ||
(highlight -O ansi -l {} || cat {}) 2>/dev/null | head -500
"
--select-1
--exit-0
--height 100%
--preview-window=down:70%
'
export FZF_CTRL_R_OPTS='--reverse'


if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
fi

# aliases
alias ll='ls -l'
alias la='ls -a'
hi() {
  [[ $(file -bL --mime "$1") =~ binary ]] && echo "$1" is a binary file! ||
  (highlight -O ansi -l "$1" || cat "$1") 2>/dev/null
}

alias rg="rg -S --colors 'path:fg:cyan' --colors 'line:fg:cyan' --colors 'line:style:intense'"
alias ag='rg'

colors() {
  echo -e "\033[0mNC (No color)"
  echo -e "\033[1;37mWHITE\t\033[0;30mBLACK"
  echo -e "\033[0;34mBLUE\t\033[1;34mLIGHT_BLUE"
  echo -e "\033[0;32mGREEN\t\033[1;32mLIGHT_GREEN"
  echo -e "\033[0;36mCYAN\t\033[1;36mLIGHT_CYAN"
  echo -e "\033[0;31mRED\t\033[1;31mLIGHT_RED"
  echo -e "\033[0;35mPURPLE\t\033[1;35mLIGHT_PURPLE"
  echo -e "\033[0;33mYELLOW\t\033[1;33mLIGHT_YELLOW"
  echo -e "\033[1;30mGRAY\t\033[0;37mLIGHT_GRAY"
}
