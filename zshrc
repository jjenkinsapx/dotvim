# Path to your oh-my-zsh installation.
export ZSH=/Users/naveen/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sonicradish"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
 export UPDATE_ZSH_DAYS=13
 export HISTCONTROL=ignoreboth:erasedups

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
 DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git osx docker kubectl ssh-agent)

# User configuration

export GOPATH=$HOME/Go
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

#go path
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin



# export MANPATH="/usr/local/man:$MANPATH"

source /Users/naveen.srinivasan/.oh-my-zsh/oh-my-zsh.sh
# aws 

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='mvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="${EDITOR} ~/.zshrc"
alias ohmyzsh="${EDITOR} ~/.oh-my-zsh"

#tmux alias
#tl: list sessions
alias tl='tmux ls'
#tn <name>: create a session named <name>
alias tn='tmux -CC -2 new -s'
#ta <name>: attach to a session named <name>
alias ta='tmux -CC -2 attach -t'

#alias hub 
alias git=hub


# Kubernetes
alias k='kubectl'
alias kap='kubectl get po --all-namespaces'
alias kp='kubectl get po'


klog() {kubectl get pod -l $1  -o name | cut -d'/' -f2 | xargs -I{} kubectl log {}}

ksecret() { k get secret jenkins -o yaml | grep $1| awk -F"$1:" '{print $2}' |base64 -D}


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# ------------------------------------
# Docker alias and function
# ------------------------------------

#rm removes all docker images
alias drm='docker rm $(docker ps -a -q)'
#dps
alias dps='docker ps'
# Get latest container ID
alias dl="docker ps -l -q"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Docker tag
alias dtag="docker tag"

#grep alias 
alias ga="alias | grep"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }


# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

newgoprj() {mkdir -p $GOPATH/src/github.com/naveensrinivasan/$1}
goprj() {cd $GOPATH/src/github.com/naveensrinivasan/$1}

# Remove all images
dri() { docker rmi --force $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# show all alias realted kubectl
kalias() { alias | grep 'kubectl' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# show all alias realted kubectl
galias() { alias | grep 'git' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }


# Get docker machine ip
docker-ip() {
  docker-machine ip 2> /dev/null
}

#doker linter
#https://github.com/lukasmartinelli/hadolint
alias dlint="docker run --rm -i lukasmartinelli/hadolint <"
alias python='python3'

cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}


#sourcing kubectl 
source ~/.vim/zsh/zsh-kube

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
kubecontext=$(kubectl config current-context)

PROMPT='%{$ROOT_ICON_COLOR%}$ROOT_ICON%{$reset_color%}%{$MACHINE_NAME_COLOR%}%m➜  %{$reset_color%}%{$PROMPT_SUCCESS_COLOR%}%c%{$reset_color%} %{$GIT_PROMPT_INFO%}$(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status) %{$reset_color%}%{$PROMPT_PROMPT%}%{$kubecontext ᐅ %{$reset_color%} '

