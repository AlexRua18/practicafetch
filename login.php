<?php
include('conexion.php');

if($_SERVER['REQUEST_METHOD'] == 'POST')
{
    $datos=json_decode( file_get_contents('php://input'), true );

    $usuario=$datos['usuario'];
    $contra=$datos['contra'];

    $consulta = $conexion->query("SELECT * FROM `usuarios` WHERE usuario = '$usuario' AND contrasena = '$contra';");
    $usuarios=$consulta->fetch_all(MYSQLI_ASSOC);
    echo json_encode($usuarios);

}



?>