# Запуск системного информера только в интерактивной оболочке.
if [[ -o interactive ]] && command -v nitch >/dev/null 2>&1; then
    nitch
fi

# Oh My Zsh.
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
    source "$ZSH/oh-my-zsh.sh"
else
    print -u2 "Предупреждение: Oh My Zsh не найден в $ZSH"
fi

if [[ -o interactive ]]; then
    if command -v zoxide >/dev/null 2>&1; then
        eval "$(zoxide init zsh)"
    fi

    export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$BUN_INSTALL/bin:$PATH"
    export EDITOR="${EDITOR:-nvim}"

    alias vim="nvim"
    alias c="clear"
    alias n="nvim"
    alias aa="startx"
    alias rm="trash -v"
    alias ff="fastfetch"

    alias ls="eza --color=always --group-directories-first"
    alias ll="eza -lh --git --group-directories-first"
    alias la="eza -lah --git --group-directories-first"
    alias lt="eza -T -L 2 --group-directories-first"
    alias cat="bat"
    alias find="fd"

    alias un='${aurhelper:-paru} -Rns'
    alias up='${aurhelper:-paru} -Syu'
    alias pl='${aurhelper:-paru} -Qs'
    alias pa='${aurhelper:-paru} -Ss'
    alias pc='${aurhelper:-paru} -Sc'
    alias po='${aurhelper:-paru} -Qtdq | xargs -r ${aurhelper:-paru} -Rns'
    alias mkdir="mkdir -p"
fi

# Starship должен инициализироваться только в интерактивной сессии.
if [[ -o interactive ]] && command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
