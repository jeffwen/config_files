## define non-anaconda path
export SANS_ANACONDA='/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin'

## aliases
alias non_anaconda="export PATH="\$SANS_ANACONDA" && echo Remove Anaconda path."
alias with_anaconda="export PATH="/Users/jwen/anaconda/bin:\$SANS_ANACONDA" && echo Re-add Anaconda path."
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
alias vertica='ssh ec2-user@vertica-node1.datascience.pixability.com'
alias pixds_server='ssh pix@master.datascience.pixability.com'
alias coe_server='ssh centos@jenkins.vpcshared.pixability.com'

## added by Anaconda3 4.4.0 installer
export PATH="/Users/jwen/anaconda/bin:$PATH"
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')
export PS1="\u@\h: \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

## bash functions
brew_up() {
    non_anaconda
    echo $PATH
    brew update
    brew upgrade
    brew prune
    brew cleanup
    brew doctor
    with_anaconda
    echo $PATH
}

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
   cd ~/Pixability/coe; (sleep 20 && /usr/bin/open -a "/Applications/Google Chrome.app" 'http://localhost:9999') & docker run --env-file ~/.pixds/my.env -it --rm -v $(pwd):/app -v ~/Pixability/ds-scripts:/var/ds-scripts -v $HOME/.pixds/:/var/pixds -p 9999:8888 coe:testing /bin/bash /var/pixds/docker_notebook.sh
}

coe_docker() {
docker run --name test_coe --env-file ~/.pixds/my.env -it --rm -v $(pwd):/app -v ~/Pixability/ds-scripts:/var/ds-scripts -v $HOME/.pixds/:/root/.pixds coe:testing /bin/bash
}
