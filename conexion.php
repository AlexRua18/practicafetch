<?php
$host = 'localhost';
$user = 'root';
$password = '';
$database = 'musicart';

$conexion= new mysqli($host,$user,$password,$database);

if ($conexion->connect_errno)
{
    die("Connection error:".$conexion->connect_errno);
}

?>