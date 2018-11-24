alias vi='vim'
complete -C aws_completer aws

if [[ $OSTYPE == 'darwin14' ]]; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
    source /usr/local/etc/bash_completion.d/git-completion.bash

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi
else
    . /usr/share/git-core/contrib/completion/git-prompt.sh
fi

Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\W"
PathFull="\w"
NewLine="\n"
Jobs="\j"

export PS1='$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$IRed'"$(__git_ps1 " {%s}"); \
  fi) '$Yellow$PathShort$Color_Off'\$ "; \
else \
  # @2 - Prompt when not in GIT repo
  echo " '$Yellow$PathShort$Color_Off'\$ "; \
fi)'



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


#######################################
# go path
#######################################
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:~/Library/Python/2.7/bin
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'


if [[ $OSTYPE == 'linux-gnu' || $OSTYPE == 'cygwin' ]]; then
    alias ls='ls --color=auto'
elif [[ $OSTYPE == 'darwin15' ]]; then
    alias ls='ls -G'
    export LSCOLORS=gxfxcxdxbxegedabagacad
fi



function awsssh(){
  SSH_TARGET_HOST="$(aws ec2 describe-instances|jq -r '.Reservations[].Instances[].Tags[].Value'|peco)"
  ssh -i ~/.ssh/"$( ls ~/.ssh/ |peco)" ec2-user@"$(aws ec2 describe-instances|jq -r --arg SSH_TARGET_HOST $SSH_TARGET_HOST '.Reservations[].Instances[]|select(.Tags[].Value == $SSH_TARGET_HOST )|.PrivateIpAddress'|peco)"
}

source ./.bash_profile.d/*

if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

