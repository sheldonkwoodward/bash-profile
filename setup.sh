#!/bin/bash

# get home directory
CD="$(pwd)"

# hard link files
ln -f $CD/.bash_profile $HOME/.bash_profile
ln -f $CD/.gitignore $HOME/.gitignore
ln -f $CD/.gitconfig $HOME/.gitconfig
ln -f $CD/.git_completion.sh $HOME/.git_completion.sh

# set better git cli colors
git config --global color.ui true
git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta       "yellow bold"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

# setup global gitignore
git config --global core.excludesfile ~/.gitignore_global

# autocompletion case insensitivity
if [ ! -a ~/.inputrc ];
then 
  echo '$include /etc/inputrc' > ~/.inputrc;
fi
echo 'set completion-ignore-case On' >> ~/.inputrc

# check for Mac or Linux
if [[ $(uname) == Darwin ]];
then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update && brew upgrade
  brew install bash-completion bat cowsay diff-so-fancy exa fd fzf git htop micro ncdu node pipenv prettyping python2 python3 tldr trash tree vim
  # install xcode command line tools
  xcode-select --install

  # TODO: link python3
else
  # TODO: linux installs
  echo "Linux"
fi

source ~/.bash_profile
