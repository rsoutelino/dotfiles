# Path to your oh-my-zsh installation.
  export ZSH=/home/rsoutelino/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# DISABLE_UNTRACKED_FILES_DIRTY="true"

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
plugins=(git)
#plugins=(zsh-wakatime)

# User configuration

  export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias py='ipython3 --pylab'
alias lt='ls -ltrh'
alias mat='matlab -nodesktop -nosplash'
alias matnew='/usr/local/matlab_metocean/bin/matlab -nodesktop -nosplash'
alias dc='docker-compose'
alias k='kubectl'

alias gst='git status'
alias pyeditmask="xhost + && docker run -u root -ti --rm --runtime=runc  -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:$HOME -v /source:/source  -v /static:/static rsoutelino/pyeditmask"

VIRTUALENVWRAPPER_PYTHON=python3
export WORKON_HOME=$HOME/Envs
# export VIRTUALENVWRAPPER_VIRTUALENV=/home/rsoutelino/.local/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
# source /home/rsoutelino/.local/bin/virtualenvwrapper.sh
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

export ANSIBLE_HOST_KEY_CHECKING=False
export GOOGLE_APPLICATION_CREDENTIALS='/config/swellmap-api/swellmap-web-servicekey.json'
export CLOUDSDK_PYTHON_SITEPACKAGES=1

wlog() {
    gcloud logging read "resource.type=k8s_container AND labels.k8s-pod/workflows_argoproj_io/workflow=$1" --format="table(timestamp:sort=1,textPayload)" | grep -v 'TotalAlloc'
}

plog() {
    gcloud logging read "resource.type=k8s_container AND resource.labels.pod_name=$1" --format="table(timestamp:sort=1,textPayload)" | grep -v 'TotalAlloc'
}

pylog() {
    gcloud logging read "resource.type=global AND logName=projects/$1/logs/python"  --format="table(timestamp:sort=1,jsonPayload.message)"
}

apilog() {
    gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$1" --format="table(timestamp:sort=1,textPayload)" | grep -v 'TotalAlloc'
}

flog() {
    gcloud logging read "resource.type=cloud_function AND resource.labels.function_name=$1" --format="table(timestamp:sort=1,textPayload)" | grep -v 'TotalAlloc'
}

billing() {
	gcloud config set project oceanum-prod && bq query "select sku.description, usage_start_time, cost, project.id from billing.gcp_billing_export_v1_0161AC_94A65A_1A5164 where usage_start_time > '$(date -d "1 day ago" '+%Y-%m-%d 00:00:00')' and usage_start_time < '$(date '+%Y-%m-%d 00:00:00')' order by cost DESC"
}

log-swellmap-api() {kubectl logs deployment/swellmap-api -f}

xset r rate 250 60

#if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#        source /etc/profile.d/vte.sh
#fi
