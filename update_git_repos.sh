#!/bin/bash
### verify the argument exists
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters. Need to set as argument the target github bransh name"
    echo "example:" $0 "master"
    exit 2
fi
### pass branch name
BRANCH=$1
echo "Branch to update is: "$BRANCH
### run from Git Colsole 
### store the current dir
CUR_DIR=$(pwd)
### Let the person running the script know what's going on.
echo ""
echo "Pulling in latest changes for all repositories..."
echo ""
### Find all git repositories and update it to the master latest revision
for i in $(find . -name ".git" | cut -c 3-); do
	echo "";
    echo $i;
    ### We have to go to the .git parent directory to call the pull command
    cd "$i";
    cd ..;
    
    # git hart reset the current changes and update
    git reset --hard HEAD
    git checkout .
    git fetch
    git checkout $BRANCH
    git pull origin $BRANCH;

    ### git credentioal saving 
    git config --global user.name Pavel-vovk
    git config credential.helper store
    
    ### finally pull	
    git pull
    ### lets get back to the CUR_DIR
    
    cd $CUR_DIR
done
echo ""
echo "Complete!"
echo ""
