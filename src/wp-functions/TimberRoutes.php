<?php
/*
Among its other special powers, Timber implements modern routing in the Express.js/Ruby on Rails mold, making it easy
for you to implement custom pagination--and anything else you might imagine in your wildest dreams of URLs and
parameters. OMG so easy!

https://github.com/jarednova/timber/wiki/Routes
*/

Timber::add_route('submit', function($params){
    //$query = 'posts_per_page=10&post_type=resources&taxonomy=subject&term='.$params['subject'];
    Timber::load_template('submit-inquiry.php');
});
