# WordPress source for [Gulp Workflow](https://github.com/ripe-gulp-workflow/gulp-workflow)

1. Create local virtual host
2. Set up local MySQL database
2. Download WordPress core (wp core download)
4. Install any plugins 
5. Pull in any uploads
6. cd to wp-content
7. Pull in this repo as "themes" folder
8. Run `npm install`
9. 

## Installing a new project
##### Step 0—Navigate to where you would like your project to be located
Open the terminal (we prefer iTerm) and navigate to your desired location

```
cd you/can/go/anywhere
```

##### Step 1— Run the install script
To install a new static site run the install script command followed by the name of your new project

*Note replace [project-name] with the name of your project*

```
bash <(curl -s https://raw.githubusercontent.com/ripe-gulp-workflow/src--wordpress/master/install.bash) [project name]
```

##### Step 2—Install Node Modules
The install script will prompt if you would like to install the node modules for the new project

*Keep in mind the node modules are close to 200mb*

##### Step 3—Enjoy
Carry forth and make something awesome!
