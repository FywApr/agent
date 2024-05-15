<?php
$database = mysqli_connect("localhost", "root", "", "smak");
$database->query("SET NAMES utf8");
(!$database) ? die("Connection failed" . mysqli_connect_error()) : "Connection passed";
?>