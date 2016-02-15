#!/usr/bin/env bash

# WORDPRESS INSTALL SCRIPT
# -------------------
# This script allows you to create a new site utilizing the ripe gulp workflow
# 
#
# The scripts executes the following actions:
# 
# 1) Download core from wordpress.com
# 2) Sanitize themes folder
# 3) Download gulp-workflow core and install into themes directory
# 4.1) If core already exsits delete src directory
# 4.2) Download wp-starter repository into wp-content/themes/src
# 5) Sanatize wp-starter
# 6) Download plugins repository into wp-content/plugins
# 7) Download Node modules
# 8) Rename project in config file and remove sample

###########################################################
#
# Script Variables
#
##########################################################

# Project naming Variables
PROJECT_NAME="$1"                                                                    # Get first argument from command line for name of new project
CURRENT_PROJECTS=`ls -l`                                                             # Get list of all current projects in current directory

# Wordpress Variables
WORDPRESS_CORE_URL="https://wordpress.org/latest.zip"                                # Latest WordPress core
WORDPRESS_CORE_NAME="wordpress"                                                      # Default WordPress core directory name

# Gulp Workflow Variables
GULP_WORKFLOW_URL="https://github.com/gulpworkflow/core/archive/master.zip"          # Github URL of gulp core
GULP_WORKFLOW_NAME="core-master"                                                     # Name of repository

# Starter Base Variables
STARTER_BASE_CLONE_URL="git@github.com:gulpworkflow/wordpress-starter.git"           # Github SSH clone URL of starter base repository
STARTER_BASE_NAME="wordpress-starter"                                                # Starter base repository name

# Plugins variables
CORE_PLUGINS_URL="https://github.com/ripestudios/wp-plugins/archive/master.zip"      # Github URL of wp-plugins repository
CORE_PLUGINS_NAME="wp-plugins-master"

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
# 1) Download core from wordpress.com
#
##########################################################

# Download Core
echo -e "\n--> Download latest WordPress core\n"
curl -L $WORDPRESS_CORE_URL > $PROJECT_NAME.zip
# Unzip Core
echo -e "\n--> Extract\n"
unzip $PROJECT_NAME.zip
# Remove zip
rm -rf $PROJECT_NAME.zip
# Reaneme Core Directory to project name
mv ./$WORDPRESS_CORE_NAME ./$PROJECT_NAME

###########################################################
#
# 2) Sanitize themes folder
#
##########################################################

echo -e "\n--> Removing default themes"
# Navigate to directory
cd $PROJECT_NAME/wp-content/themes/
# Delete themes
rm -R -- */

###########################################################
#
# 3) Download Gulp Workflow
#
##########################################################

# Download gulp-starter
echo -e "\n--> Download Gulp core\n"
curl -L  $GULP_WORKFLOW_URL > $PROJECT_NAME.zip
# Unzip gulp-starter
echo -e "\n--> Extract\n"
unzip $PROJECT_NAME.zip
# Remove zip
rm -rf $PROJECT_NAME.zip
mv ./$GULP_WORKFLOW_NAME ./$PROJECT_NAME

###########################################################
#
# 4) Get Starter Base
#
##########################################################

# Download Starter Base
echo -e "\n--> Downloading WordPress Starter\n"
cd $PROJECT_NAME
# Check if src folder already exsits, if so remove it
if [ -d src ]; then
  rm -rf src
fi
# Get WordPress starter base
git clone $STARTER_BASE_CLONE_URL
# Get Submodules
echo -e "\n--> Getting Submodules\n"
cd $STARTER_BASE_NAME
git submodule init
git submodule update

###########################################################
#
# 5) Sanatize Base Files
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
# Remove original directory
rm -rf $STARTER_BASE_NAME

###########################################################
#
# 6) Download plugins repository into wp-content/plugins
#
##########################################################

# Navigate to directory
cd ../../plugins/
# Remove hello dolly plugin
rm -rf hello.php
# Download core plugins
echo -e "\n--> Download core plugins\n"
curl -L  $CORE_PLUGINS_URL > $CORE_PLUGINS_NAME.zip
# Unzip gulp-starter
echo -e "\n--> Extract\n"
unzip $CORE_PLUGINS_NAME.zip
# Remove zip
rm -rf $CORE_PLUGINS_NAME.zip
# Remove RREADME
rm -rf $CORE_PLUGINS_NAME/README.md
# Move all plugins into plugins directory
mv $CORE_PLUGINS_NAME/* .
# Remove core plugins directory
rm -rf $CORE_PLUGINS_NAME

###########################################################
#
# 7) Download Node Modules
#
##########################################################

# Navigate to Gulp workflow
cd ../themes/$PROJECT_NAME/
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
# 8) Rename project in config file and remove sample
#
##########################################################

# Rename Project in config file and remove the sample
echo -e "\n--> Updating config file\n"
cd src/
touch here.txt
sed "/projectName/ s/hello-world/$PROJECT_NAME/" config-sample.yml > config.yml
rm -rf config-sample.yml

###########################################################
#
# Install Complete!!!!!!!
#
##########################################################
echo -e "\n \n"
echo -e "${bold}####################################################################################${normal}\n"
echo -e "${bold}Install Complete${normal}"
echo -e "${bold}Enjoy!${normal}\n"
echo -e "${bold}####################################################################################${normal}\n"
