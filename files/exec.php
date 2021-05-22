<?php
$script = $_GET['script'];
$output = shell_exec("/var/www/html/" .$script);
echo "<pre>$output</pre>";
?>