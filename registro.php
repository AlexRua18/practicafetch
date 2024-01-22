<?php
include('conexion.php');

// Verificar si la solicitud es de tipo POST y si se recibió el archivo 'archivoimagen'
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['archivoimagen'])) {
    // Obtener datos del formulario
    $marca = $_POST['marca'];
    $tipo = $_POST['tipo'];
    $descripcion = $_POST['descripcion'];
    $nombre = $_POST['nombre'];
    $valor = $_POST['valor'];
    $idproducto ="";

    // Obtener información sobre la imagen
    $imagen = $_FILES['archivoimagen'];
    $nombreImagen = $imagen['name'];
    $tipoImagen = $imagen['type'];
    $tamañoImagen = $imagen['size'];
    $rutaTemporal = $imagen['tmp_name'];

    // Verificar si la carpeta 'fotos' existe y, si no, crearla
    $carpetaFotos = 'fotos';
    if (!is_dir($carpetaFotos)) {
        mkdir($carpetaFotos, 0777, true); // Asegurar que los permisos permitan la escritura
    }

    // Generar un nombre único para la imagen
     
    $nuevoNombre = $nombre . '_' . $marca . '_' .'.png';

    // Construir la ruta completa donde se guardará la imagen
    $rutaImagen = $carpetaFotos . '/' . $nuevoNombre;

    // Mover la imagen al servidor
    if (move_uploaded_file($rutaTemporal, $rutaImagen)) {
        // Insertar datos en la base de datos
        $query = "INSERT INTO `producto` (`tipo`, `descripcion`, `marca`, `nombre`, `valor`, `ruta`) VALUES ('$tipo', '$descripcion', '$marca', '$nombre', '$valor', '$rutaImagen')";
        
        if ($conexion->query($query) === TRUE) {
            // Enviar una respuesta JSON de éxito
            $idproducto = $conexion->insert_id;
           $seriales = json_decode($_POST['seriales'], true);
            $mensajes ="";
           foreach ($seriales as $clave => $serial) {
            $query ="INSERT INTO `seriales`( `id_prooducto`, `serial`) VALUES ('$idproducto','$serial')";
            if ($conexion->query($query) === TRUE){
                $mensajes = "Seriales  agregado con éxito";
    
            }else{
                echo json_encode(['error' => 'Error al ejecutar la consulta SQL de seriales: ' . $conexion->error]);
            }
        }
        echo json_encode(['mensaje' => $mensajes]);
        




        } else {
            // Enviar una respuesta JSON de error si hay un problema con la base de datos
            echo json_encode(['error' => 'Error al ejecutar la consulta SQL: ' . $conexion->error]);
        }
    } else {
        // Enviar una respuesta JSON de error si hay un problema al mover el archivo
        echo json_encode(['error' => 'Error al mover el archivo al servidor']);
    }
}elseif($_SERVER['REQUEST_METHOD'] === 'POST')
{
    $data = json_decode(file_get_contents("php://input"), true);
    $accion = $data['accion'];

    if (isset($data['accion'])) {
        if ($data['accion'] == 'eliminarSerial') {
            $serial = $data['serial'];
            $query = "DELETE FROM `seriales` WHERE id_serial = $serial;";
            if ($conexion->query($query) === TRUE) {
                $mensaje = "Seriales eliminado con éxito";
                echo json_encode(['mensaje' => $mensaje]);
            } else {
                $mensaje = 'Error al ejecutar la consulta SQL de seriales: ' .strip_tags($conexion->error);
                echo json_encode(['error' => $mensaje]);
            }
        } elseif ($data['accion'] == 'listarSeriales') {
            $id_producto = $data['id_producto'];
            $resultados = $conexion->query("SELECT * FROM `seriales` WHERE id_prooducto = $id_producto;");
            $seriales = $resultados->fetch_all(MYSQLI_ASSOC);
            echo json_encode($seriales);
        } elseif ($data['accion'] == 'EditarRegistro') {

            $marca = $_POST['marca'];
    $tipo = $_POST['tipo'];
    $descripcion = $_POST['descripcion'];
    $nombre = $_POST['nombre'];
    $valor = $_POST['valor'];
    $idproducto = $_POST['idProducto'];
    if (isset($_FILES['archivoimagen'])) {
        $imagen = $_FILES['archivoimagen'];
        $nombreImagen = $imagen['name'];
        $tipoImagen = $imagen['type'];
        $tamañoImagen = $imagen['size'];
        $rutaTemporal = $imagen['tmp_name'];
    
        // Verificar si la carpeta 'fotos' existe y, si no, crearla
        $carpetaFotos = 'fotos';
        if (!is_dir($carpetaFotos)) {
            mkdir($carpetaFotos, 0777, true); // Asegurar que los permisos permitan la escritura
        }
    
        // Generar un nombre único para la imagen
         
        $nuevoNombre = $nombre . '_' . 'mod' . '_' .'.png';
    
        // Construir la ruta completa donde se guardará la imagen
        $rutaImagen = $carpetaFotos . '/' . $nuevoNombre;
        if (move_uploaded_file($rutaTemporal, $rutaImagen)) {
            $query = "UPDATE `producto` SET `tipo`='$tipo',`descripcion`='$descripcion',`marca`='$marca',`nombre`='$nombre',`valor`=$valor,`ruta`='$rutaImagen' WHERE `id_prooducto` = $idproducto";
           
            if ($conexion->query($query) === TRUE) {
                $mensaje = "actualizado correcto con imagen ";
                echo json_encode(['mensaje' => $mensaje]);
            } else {
                $mensaje = 'Error al ejecutar la consulta SQL de seriales: ' .strip_tags($conexion->error);
                echo json_encode(['error' => $mensaje]);
            }
            
        }else {
            // Enviar una respuesta JSON de error si hay un problema con la base de datos
            echo json_encode(['error' => 'Error al mover la imagen ' . $conexion->error]);
        }

    }else{
        $query = "UPDATE `producto` SET `tipo`='$tipo',`descripcion`='$descripcion',`marca`='$marca',`nombre`='$nombre',`valor`='$valor' WHERE `id_prooducto` = $idproducto";
           
            if ($conexion->query($query) === TRUE) {
                $mensaje = "actualizado correcto con imagen ";
                echo json_encode(['mensaje' => $mensaje]);
            } else {
                $mensaje = 'Error al ejecutar la consulta SQL de seriales: ' .strip_tags($conexion->error);
                echo json_encode(['error' => $mensaje]);
            }
    }


        }else {
            echo json_encode(['error' => 'Acción no válida']);
        }
    } else {
        echo json_encode(['error' => 'Formato de datos incorrecto']);
    }
}elseif($_SERVER['REQUEST_METHOD'] == 'GET')
{

    $accion = $_GET['accion'];
    if ($accion === 'listarproductos')
    {
        $resultados = $conexion->query("SELECT producto.*, COUNT(seriales.id_serial) AS seriales FROM producto LEFT JOIN seriales ON producto.id_prooducto = seriales.id_prooducto GROUP BY producto.id_prooducto ORDER BY seriales DESC;");
        $productos=$resultados->fetch_all(MYSQLI_ASSOC);
        echo json_encode($productos);
    }else{
        echo json_encode(['error' => 'error en la url']);
    }


    
    
}else {
    // Enviar una respuesta JSON de error si la solicitud no es correcta
    echo json_encode(['error' => 'Solicitud incorrecta']);

   
}
?>