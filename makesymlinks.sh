#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotFiles in ~/dotFiles
############################

########## Variables

dir=~/dotFiles                                         # dotFiles directory
olddir=~/dotFiles_old                                  # old dotFiles backup directory
files="bashrc gitconfig tmux.conf vimrc zshrc bin vim" # list of files/folders to symlink in homedir

##########

# create dotFiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotFiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotFiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotFiles in homedir to dotFiles_old directory, then create symlinks from the homedir to any files in the ~/dotFiles directory specified in $files
for file in $files; do
	echo "Moving any existing dotFiles from ~ to $olddir"
	mv ~/.$file ~/dotFiles_old/
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/.$file
done

install_zsh() {
	# Test to see if zshell is installed.  If it is:
	if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
		# Clone my oh-my-zsh repository from GitHub only if it isn't already present
		if [[ ! -d $dir/oh-my-zsh/ ]]; then
			git clone http://github.com/robbyrussell/oh-my-zsh.git
		fi
		# Set the default shell to zsh if it isn't currently set to zsh
		if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
			chsh -s $(which zsh)
		fi
	else
		# If zsh isn't installed, get the platform of the current machine
		platform=$(uname)
		# If the platform is Linux, try an apt-get to install zsh and then recurse
		if [[ $platform == 'Linux' ]]; then
			sudo apt-get install zsh
			install_zsh
		# If the platform is OS X, tell the user to install zsh :)
		elif [[ $platform == 'Darwin' ]]; then
			echo "Please install zsh, then re-run this script!"
			exit
		fi
	fi
}

install_zsh
