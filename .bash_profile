## aliases 
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'

## added by Anaconda3 4.4.0 installer
export PATH="/Users/jwen/anaconda/bin:$PATH"
export PS1="\u@\h: \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

## bash functions
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

git() {
  case $* in
    lg* ) shift 1; command git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s" ;;
    * ) command git "$@" ;;
  esac
}

coe_notebook() {
   cd ~/Pixability/coe; (sleep 20 && /usr/bin/open -a "/Applications/Google Chrome.app" 'http://localhost:9999') & docker run --env-file ~/.pixds/my.env -it -rm -v $(pwd):/app -v ~/Pixability/ds-scripts:/var/ds-scripts -v $HOME/.pixds/:/var/pixds -p 9999:8888 coe:local /bin/bash /var/pixds/docker_notebook.sh
}
