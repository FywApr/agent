<?php
$database = mysqli_connect("localhost", "root", "", "smak");
(!$database)? die("Connection failed" . mysqli_connect_error()): "Connection passed";

?>