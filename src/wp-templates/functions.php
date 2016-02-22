<?php
// Include all our functions!
$themeDir = get_template_directory();
foreach (glob($themeDir."/includes/*.php") as $filename) {
    include $filename;
}
// Check if Timber is active
if ( ! class_exists( 'Timber' ) ) {
  add_action( 'admin_notices', function() {
      echo '<div class="error"><p>Timber not activated. Make sure you activate the plugin in <a href="' . esc_url( admin_url( 'plugins.php#timber' ) ) . '">' . esc_url( admin_url( 'plugins.php' ) ) . '</a></p></div>';
    } );
  return;
}
// init our Timber Class
new StarterSite();
// Set directories where Timber can find twig templates
Timber::$dirname = array('templates', 'views');
