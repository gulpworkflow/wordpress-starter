#!/usr/bin/env bash

# WORDPRESS STARTER
# -------------------
# This script allows you to create a new WordPress site utilizing the ripe gulp workflow
# 
#
# The scripts executes the following actions:
# 1) Download Gulp Workflow
# 2) Get Starter Base
# 3) Sanatize Base Files
# 4) Download Node Modules
# 5) Remove install scripts & files so you never knew this existed

###########################################################
#
# Script Variables
#
##########################################################

# Project naming Variables
PROJECT_NAME="$1"                                                                    # Get first argument from command line for name of new project
CURRENT_PROJECTS=`ls -l`                                                             # Get list of all current projects in current directory

# Gulp Workflow Variables
GULP_WORKFLOW_URL="https://github.com/gulpworkflow/core/archive/master.zip"  # Github URL of gulp workflow repository
GULP_WORKFLOW_NAME="core-master"                                            # Name of repository

# Starter Base Variables
STARTER_BASE_CLONE_URL="https://github.com/gulpworkflow/wordpress-starter.git"             # Github SSH clone URL of starter base repository
STARTER_BASE_NAME="wordpress-starter"                                                 # Starter base repository name

# Formatting stuff
bold=$(tput bold)
normal=$(tput sgr0)

# Check to see if project with same name already exist before we use that name
for PROJECT in $CURRENT_PROJECTS
do
  if [ "$PROJECT" == "$PROJECT_NAME" ]; then
    echo  "Error: project '${PROJECT}'' already exists"
    exit
  fi
done

###########################################################
#
# 1) Download Gulp Workflow
#
##########################################################

# Download gulp-starter
echo -e "\n--> Download gulp-starter\n"
curl -L  $GULP_WORKFLOW_URL > $PROJECT_NAME.zip
# Unzip gulp-starter
echo -e "\n--> Extract\n"
unzip $PROJECT_NAME.zip
mv ./$GULP_WORKFLOW_NAME ./$PROJECT_NAME

###########################################################
#
# 2) Get Starter Base
#
##########################################################
# Download Starter Base
echo -e "\n--> Downloading Static Starter\n"
cd $PROJECT_NAME
git clone $STARTER_BASE_CLONE_URL
# Get Submodules
echo -e "\n--> Getting Submodules\n"
cd $STARTER_BASE_NAME
git submodule init
git submodule update

###########################################################
#
# 3) Sanatize Base Files
#
##########################################################

echo -e "\n--> Removing Submodule meta\n"
# Remove git directory
rm -rf .git
# Remove all git module meta
find . -type f -name ".git" -exec rm -f {} \;
find . -type f -name ".gitmodules" -exec rm -f {} \;
# Move src folder up one level & then move up one level
mv src ..
cd ../

###########################################################
#
# 4) Download Node Modules
#
##########################################################

# Choose if user would like to install node modules because the full snap-on toolbox weighs a bit
while true; do
  read -p "${bold}Would you like to install node modules? *Warning the install is around 200MB* (yes/no)${normal}" yn
  case $yn in
    # If yes download run npm install
    [Yy]* ) echo -e "\n--> Install node modules\n"; npm install; break;;
    # If not we continue
    [Nn]* ) break;;
    * ) echo "${bold}Please answer yes or no.${normal}";;
  esac
done

###########################################################
#
# 5) Remove install scripts & files
#
##########################################################

echo -e "\n--> Removing install files\n"
# Remove original starter base directory
rm -rf $STARTER_BASE_NAME
cd ../
# Remove Original Gulp Workflow ZIP
rm -rf $PROJECT_NAME.zip
# Rename Project in config file and remove the sample
cd $PROJECT_NAME/src
sed "/projectName/ s/hello-world/$PROJECT_NAME/" config-sample.yml > config.yml
rm -rf config-sample.yml
# Now everything is nice & clean

###########################################################
#
# Install Complete!!!!!!!
#
##########################################################
echo -e "${bold}Install Complete${normal}"
echo -e "${bold}Enjoy!${normal}"
