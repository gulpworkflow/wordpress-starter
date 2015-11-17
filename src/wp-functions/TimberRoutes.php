<?php
// aka http://yourwebsite.com/foobar
// params are query parameters
Timber::add_route('foobar', function($params){
    // you can set a query string from paramters and pass to template:
    //$query = 'posts_per_page=10&post_type=resources&taxonomy=subject&term='.$params['subject'];
    Timber::load_template('index.php');
});

// aka http://yourwebsite.com/foo/this-will-be-bar
Timber::add_route('foo/:bar', function($params){
    // you can set a query string from paramters and pass to template:
    /*
    $query = 'posts_per_page=10&post_type=resources&taxonomy=subject&term='.$params['subject'];
    Timber::load_template('submit-inquiry.php',$query);
    */
});
