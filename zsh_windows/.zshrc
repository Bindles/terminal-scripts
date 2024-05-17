# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it willsoz
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME=avit

# Use the path where you installed Antigen
#source "${funcsourcetrace[1]%/*}/antigen/antigen.zsh"
# Load Oh My Zsh
#antigen use oh-my-zsh
# PLUGINS
#antigen bundle zsh-users/zsh-completions zsh-users/zsh-autosuggestions agkozak/zsh-z
#antigen apply

#Alias:
alias radmin="id -G | grep -qE '\<(114|544)\>' && echo admin || echo user"
alias gc="git commit -m 'Initial Commit'"
alias mydev='cd /c/dev'
alias soz='source ~/.zshrc'
alias sozz='source'
alias zx='git clone $gfile'
alias gitgitc='git clone $gfile $gpath'
alias sdir='vdir=$(pwd); echo $vdir'
#alias sv='$var1=${var2}
alias psd='echo $vdir'
alias e='echo'
alias p='echo'
alias cd-proj-r='cd /c/dev/project/_rails'
alias pysrc='python -m pypisearch'
alias pipi='pip install'
alias ps='python -m pypisearch'
alias pips='python -m pypisearch'
alias pipt='pipgrip --tree'
alias pipdep='pipgrip --tree'
alias piptree='pipgrip --tree'
alias pgtree='pipgrip --tree'
alias pgz='pipgrip'
alias sozext='source ~/ext.zshrc'
#DIRECTORYS
ddev="/c/Dev"
dproj="/c/Dev/Project"
ddj="/c/Dev/Project/_django"
drails="/c/Dev/Project/_rails"
dplug="/home/b1ndl/.oh-my-zsh/plugins"
dplugc="/home/b1ndl/.oh-my-zsh/custom/plugins"
dplugz="/home/b1ndl/.oh-my-zsh/custom/plugins"
dcust="/home/b1ndl/.oh-my-zsh/custom/"
dzshc="$ZSH_CUSTOM"
dwloads="/c/users/b1ndl/downloads"
downl="/c/users/b1ndl/downloads"
dthemes='/home/B1NDL/.oh-my-zsh/themes'
ddesk='/c/Users/B1NDL/OneDrive/Desktop/'
dfreq='/c/Users/B1NDL/OneDrive/Desktop/FrequentDev'
dfreqdev='/c/Users/B1NDL/OneDrive/Desktop/FrequentDev'
cfg='home/b1ndl'
#alias name='cd $'
alias ddev='cd $ddev'
alias dproj='cd $dproj'
alias ddj=' $cd $ddj'
alias drails='cd $drails'
alias dplugc='cd ~/.oh-my-zsh/custom/plugins'
alias dplugz='cd ~/.oh-my-zsh/custom/plugins'
alias dplug='cd ~/.oh-my-zsh/plugins'
alias dcust="/home/b1ndl/.oh-my-zsh/custom/"
alias dzshc="$ZSH_CUSTOM"
alias dwloads="cd /c/users/b1ndl/downloads"
alias downl="cd /c/users/b1ndl/downloads"
alias dthemes='cd /home/B1NDL/.oh-my-zsh/themes'
alias exph='explorer .'
alias cfg='cd ~/'
alias cfgg='cd ~/; explorer .'
alias cfgn='cd ~/; nano .zshrc'
alias cfgnp='cd ~/; notepad .zshrc'
alias ddesk='cd /c/Users/B1NDL/OneDrive/Desktop/'
alias dfreq='cd /c/Users/B1NDL/OneDrive/Desktop/FrequentDev'
alias dfreqdev='cd /c/Users/B1NDL/OneDrive/Desktop/FrequentDev'
alias dfreq='cd /c/Users/B1NDL/OneDrive/Desktop/FrequentDev'
alias fwm='start /c/Users/B1NDL/OneDrive/Desktop/FrequentDev/FWM.lnk'
alias qwm='taskkill /f /im PROGRA~1\WINDOW~1\FancyWM.exe'
alias dja='django-admin'
#OTHER
unziptargz='echo xzvf name.tar.gz | flags: --strip 1 (tar.gz)'
unziptar='echo tar -xvf file.tar'
source $HOME/"f.zshrc"

savev() {
echo "$1 is set to $2 | value="
eval echo \$$2
eval $1=\$$2
 
}

ssv() {
    local arg1=$1
    local arg2=$2
    local value_of_arg2=$(eval echo \$$arg2)
    eval $arg1='$value_of_arg2'
    echo "$arg1 >>> $arg2 ($value_of_arg2)"
}

cdmk() {
echo mkdir: $1 in $(pwd) '\n' ch
mkdir $1;cd $1
}

usefulcmd() {
echo 'rmdir -r | remove folder and components'
echo 'ls -la - ls vertically'
}

ufcmds() {
  if [ -n "$1" ]; then
    if [ "$1" == "add" ]; then
      echo "$1" >> cmdbook.txt
    fi
  else
    cat "cmdbook.txt"
  fi
}



nullargz() {
    echo "hi my name is $1"
    if [ -z "$2" ]; then
        echo "i have no last name"
    fi
}



isadmin()
{
    net session > /dev/null 2>&1
    if [ $? -eq 0 ]; then echo "admin"
    else echo "user"; fi
}


unzi() {
  case "$1" in
    tar) echo tar -xf "$2" "$3";tar -xf "$2" "$3" "$4";;
    targz) tar -xzf "$2" "$3";;
    *) echo "Invalid file type. Use 'tar' or 'targz'."; exit 1;;
  esac
}


dd() {
    cd "${(P)1}"
}


unziptar() {
    if [ $# -lt 2 ]; then
        echo "Error: at least 2 arguments are required (filetype and filename)"
        return 1
    fi
    ftype=$1
    filename=$2
    folder=${3:-.}
    ismake=${4:-}

    if [ "$ftype" == "tar" ]; then
        cmd="tar -xf" tar -xf "$filename" -C "$folder"
    elif [ "$ftype" == "targz" ]; then
        cmd="tar -xzf"
    else
        echo "Error: invalid file type. Supported types are 'tar' and 'targz'"
        return 1
    fi

    if [ -n "$ismake" ]; then
        if [ "$ismake" == "make" ] || [ "$ismake" == "mk" ]; then
            mkdir -p "$folder" 2>/dev/null || {
                read -r -p "Directory '$folder' already exists. Extract $filename here? [y/n] " response
                if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
                    cmd="$cmd $filename -C $folder"
                else
                    return 0
                fi
            }
        else
            echo "Error: invalid argument for 'ismake'. Supported arguments are 'make' or 'mk'"
            return 1
        fi
    else
        cmd="$cmd $filename -C $folder"
    fi

    eval "$cmd"
}


supergitclone() {
  url=$1
  dirname=$(echo $url | sed -E 's|.*/(.*)\.git|\1|')
  mkdir $dirname
  cd $dirname
  git clone $url $ZSH_CUSTOM/plugins
}

gccp() {
  vardirt=$(pwd)
  echo $vardirt
  echo -n "..."; sleep 0.6; echo "...";
  echo '(Moving to proper dir for git clone... $ZSH_CUSTOM/plugins)'
  cd $ZSH_CUSTOM/plugins
  git clone $1
  echo $(pwd) '>>' $vardirt
  cd $vardirt
}
#git clone https://github.com/agkozak/agkozak-zsh-prompt $ZSH_CUSTOM/themes/agkozak


ssearch() {
  local package_name=$1
  local max_results=${2:-10}
  curl -s "https://api.github.com/search/repositories?q=$package_name" | jq -r ".items[] | {name, html_url} | select(.name != null) | [.name, .html_url]" | head -n $max_results
}


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#cc3300"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom? /// ZSH-COMPLETIONS FPATH *REQ:
# ZSH_CUSTOM=/path/to/new-custom-folder
#fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fpath+=${ZSH_CUSTOM:-${ZSH:-~/oh-my-zsh}/custom}/plugins/zsh-completions/src

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
#Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rails zsh-autosuggestions zsh-syntax-highlighting zsh-completions z zsh-navigation-tools  web-search themes clipboard dirpersist dirhistory dircycle safe-paste python httpie)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
