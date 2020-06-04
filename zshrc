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
alias pyeditmask="docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /source:/source -v /home/rsoutelino:/home/rsoutelino  -v /static:/static metocean/roms_tools"
alias regargo='gcloud container clusters get-credentials argo --zone us-central1-b --project oceanum-dev'

VIRTUALENVWRAPPER_PYTHON=python3
export WORKON_HOME=$HOME/Envs
source /usr/local/bin/virtualenvwrapper.sh

export ANSIBLE_HOST_KEY_CHECKING=False
export GOOGLE_APPLICATION_CREDENTIALS='/source/ansible/secrets/keys/consultancy.json'

wlog() {
    gcloud logging read "resource.type=k8s_container AND labels.k8s-pod/workflows_argoproj_io/workflow=$1" --format="table(timestamp:sort=1,textPayload)" | grep -v 'TotalAlloc'
}

plog() {
    gcloud logging read "resource.type=k8s_container AND resource.labels.pod_name=$1" --format="table(timestamp:sort=1,textPayload)" | grep -v 'TotalAlloc'
}

apilog() {
    gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$1" --format="table(timestamp:sort=1,textPayload)" | grep -v 'TotalAlloc'
}


#if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#        source /etc/profile.d/vte.sh
#fi