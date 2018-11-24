# Created by newuser for 5.0.2
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 

HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数

## auto comp
autoload -U compinit
compinit

### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# プロンプトに色を付ける
autoload -U colors; colors
# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n@%m%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

setopt transient_rprompt # 最後の行だけ右プロンプト表示

alias vi='vim'

# git リポジトリ表示
if [[ $OSTYPE != 'cygwin' ]]; then
    autoload -Uz vcs_info
    setopt prompt_subst
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
    zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
    zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
    zstyle ':vcs_info:*' actionformats '[%b|%a]'
    precmd () { vcs_info }
    RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
fi

if [[ $OSTYPE == 'linux-gnu' || $OSTYPE == 'cygwin' ]]; then
   alias ls='ls --color=auto'
elif [[ $OSTYPE == 'darwin12' ]]; then
   alias ls='ls -G'
fi
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


#######################################
# alias for git
#######################################

alias gs='git status'
alias gld='git log --decorate=full --oneline --graph'
alias glp='git log -p --decorate=full --graph'
alias gl='git log'
alias gf='git fetch --all'
alias gc='git commit'
alias gca='git commit --amend'
alias gap='git add -p'
alias gai='git add -i'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdh='git diff HEAD'
alias gdu='git diff -U1000'
alias gb='git branch -vv -a'
alias gri='git rebase -i'
alias glu='git ls-files -u'
alias grs='git rerere status'
alias grd='git rerere diff'
alias gcm='git commit -m'
alias gbm='git branch -r --list --merged'
alias gbnm='git branch -r --list --no-merged'

