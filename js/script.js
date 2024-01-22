
let registros = [];
let registroActual = null;
let tabla = document.getElementById("seriales");

let seriales = [];
function guardarRegistro() {
    const marca = document.getElementById('marca').value;
    const tipo = document.getElementById('tipo').value;
    const descripcion = document.getElementById('descripcion').value;
    const nombre = document.getElementById('nombre').value;
    const valor = document.getElementById('valor').value;
    var imagen = document.getElementById('imagen');
    var archivoimagen;

    var nuevoNombre;

    if (imagen.files && imagen.files[0]) {
        archivoimagen = imagen.files[0];

        nuevoNombre = `${nombre}` + archivoimagen.name;

    }
    var formatoimagen = new FormData();
    formatoimagen.append('archivoimagen', archivoimagen, nuevoNombre);

    formatoimagen.append('marca', marca);
    formatoimagen.append('tipo', tipo);
    formatoimagen.append('descripcion', descripcion);
    formatoimagen.append('nombre', nombre);
    formatoimagen.append('valor', valor);

    formatoimagen.append('seriales', JSON.stringify(seriales));

    var urlGuardar = 'registro.php';

    // Enviar la solicitud Fetch
    fetch(urlGuardar, {
        method: 'POST',
        body: formatoimagen
    })
        .then(response => response.json())
        .then(data => {
            console.log('Imagen y datos guardados con éxito:', data);
        })
        .catch(error => {
            console.error('Error al guardar la imagen y datos:', error);
        });
    limpiarFormulario();
}


function mostrarFormulario() {
    document.getElementById('formulario').style.display = 'block';
}

function cerrarFormulario() {
    document.getElementById('formulario').style.display = 'none';
    limpiarFormulario();
}

function limpiarFormulario() {
    document.getElementById('marca').value = "";
    document.getElementById('tipo').value = "";
    document.getElementById('descripcion').value = "";
    document.getElementById('nombre').value = "";
    document.getElementById('valor').value = "";
    document.getElementById('imagen').value = "";


   // limpiarSeriales();
   // limpiarTablaser();
   // pintarSerial(seriales);

}
function limpiarSeriales() {
    seriales.splice(0, seriales.length);
    // O simplemente: seriales = [];
}
function limpiarTablaser() {
    let dataTable = document.querySelectorAll("#seriales tbody tr")

    for (let x = 0; x < dataTable.length; x++) {
        dataTable[x].remove();
    }
}
function agregarSerial() {

    const serial = document.getElementById('serial').value;
    if (serial != '') {
        seriales.push(serial);
    } else (
        alert('Agregar serial')
    )
    pintarSerial(seriales);
    document.getElementById('serial').value = '';

}
function eliminarSerial(ser) {
   
   
    var accion = "eliminarSerial";
        
var  serial= ser.id_serial;
    

    var urlGuardar = 'registro.php';
   
    // Enviar la solicitud Fetch
    fetch(urlGuardar, {
        method: 'POST',
        headers:{ //los headers en Javascript son componentes de solicitudes y respuestas HTTP, es un tipo de API Fecht 
            'Content-Type':'application/json',//Tipo de contenido que se esta enviando (en este caso JSON)
        },
        body: JSON.stringify({accion,serial})
    })
        .then(response => response.json())
        .then(data => {
            console.log('serial eliminado', data);
        })
        .catch(error => {
            console.log('Error al eliminar serial:', error);
        });

    
}
function pintarSerial(ser) {

    
   
    const tabla = document.getElementById('seriales');
    const tbody = document.getElementsByTagName('tbody')[0];
    tbody.innerHTML = '';

    ser.forEach(function(indice, valor) {
        const fila = document.createElement('tr');
        const serial = document.createElement('td');
        const eliminar = document.createElement('td');
        const botonEliminar = document.createElement('button');
        serial.textContent = indice.serial;
        botonEliminar.type = 'submit';
        botonEliminar.textContent = 'Eliminar'; 
        botonEliminar.addEventListener('click', function () {
           eliminarSerial(indice.id_prooducto);
        });
        eliminar.appendChild(botonEliminar);
        fila.appendChild(serial);
        fila.appendChild(eliminar);
        tbody.appendChild(fila);
        tabla.appendChild(tbody);

    });


}



function limpiarTabla() {
    let dataTable = document.querySelectorAll("#registros tbody tr")

    for (let x = 0; x < dataTable.length; x++) {
        dataTable[x].remove();
    }
}
function actualizarTabla() {
    const tablaregistros = document.getElementById('registros');
    const tbodyregistros = document.getElementsByTagName('tbody')[0];


    fetch('registro.php?accion=listarproductos')//fecth se usa para realizar una solicitud HTTP GET al archivo crud.php, esta devuelve la respuesta a esa solicitud
        .then(response => response.json()) //Encadena un bloque para manejar la respuesta de la solicitud. Convierte la respuesta a un formato JSON usando el metodo json()
        .then(productos => {
            // => es el simbolo de una funcion
            tbodyregistros.innerHTML = '';
            
            productos.forEach(function (indice, valores2) {
                const filaR = document.createElement('tr');
                const marca = document.createElement('td');
                const tipo = document.createElement('td');
                const cantidad = document.createElement('td');
                const editar = document.createElement('td');
    
    
                const editarBoton = document.createElement('button');
                const eliminarBoton = document.createElement('button');
                filaR.style.textAlign = 'center';
                marca.textContent = indice.marca;
                tipo.textContent = indice.tipo;
                cantidad.textContent = indice.seriales.length;
                editarBoton.textContent = 'Editar';
                editarBoton.className = 'btn btn-primary m-2';
                editarBoton.addEventListener('click', function () {
                    editarRegistro(indice);
                });
                eliminarBoton.textContent = 'Eliminar';
                eliminarBoton.className = 'btn btn-primary m-2';
                eliminarBoton.addEventListener('click', function () {
                    eliminarRegistro(indice);
                });
                editar.appendChild(editarBoton);
                editar.appendChild(eliminarBoton);
                filaR.appendChild(marca);
                filaR.appendChild(tipo);
                filaR.appendChild(cantidad);
                filaR.appendChild(editar);
                tbodyregistros.appendChild(filaR);
                tablaregistros.appendChild(tbodyregistros);
            });
        });
}

window.onload=actualizarTabla();

function eliminarRegistro(index) {
    registros.splice(index, 1);
    actualizarTabla();
}

function editarRegistro(index) {

    
    const registro = index;

    document.getElementById('marca').value = registro.marca;
    document.getElementById('tipo').value = registro.tipo;
    document.getElementById('descripcion').value = registro.descripcion;
    document.getElementById('nombre').value = registro.nombre;
    document.getElementById('valor').value = registro.valor;
    var idproducto = document.getElementById('idProducto');
    idproducto.dataset.id = registro.id_prooducto;
    //document.getElementById('imagen').value = registro.ruta;
    var imagenPrevia = document.getElementById('imagenPrevia');
    imagenPrevia.src = registro.ruta;
    imagenPrevia.style.display ='block';
   // seriales = registro.lista_seriales;
  // pintarSerial(seriales);
  
   const id_producto = registro.id_prooducto;
   var accion = "editarSerial";
   
   var urlGuardar = 'registro.php';
   var accion = "listarSeriales";
   fetch(urlGuardar, {
    method: 'POST',
    headers:{ //los headers en Javascript son componentes de solicitudes y respuestas HTTP, es un tipo de API Fecht 
        'Content-Type':'application/json',//Tipo de contenido que se esta enviando (en este caso JSON)
    },
    body: JSON.stringify({accion,id_producto}),
})
    .then(response => response.json())
    .then(serialesdb => {
        pintarSerial(serialesdb);
        
    })
    .catch(error => {
        console.log('Error al eliminar serial:', error);
    });
   mostrarFormulario();
  


}
function modificarregistro(){

    const marca = document.getElementById('marca').value;
    const tipo = document.getElementById('tipo').value;
    const descripcion = document.getElementById('descripcion').value;
    const nombre = document.getElementById('nombre').value;
    const valor = document.getElementById('valor').value;
    const idProducto = document.getElementById('idProducto').dataset.id;
    console.log(idProducto);
    var formatoActualizar = new FormData();
    var accion = "EditarRegistro";
   formatoActualizar.append('accion', accion);
   formatoActualizar.append('marca', marca);
   formatoActualizar.append('tipo', tipo);
   formatoActualizar.append('descripcion', descripcion);
   formatoActualizar.append('nombre', nombre);
   formatoActualizar.append('valor', valor);
   formatoActualizar.append('idProducto', idProducto);
   var imagen = document.getElementById('imagen');
   var archivoimagen;

   var nuevoNombre;

   if (imagen.files && imagen.files.length > 0) {
       archivoimagen = imagen.files[0];

       nuevoNombre = `${nombre}`+'_mod_' + archivoimagen.name;

       formatoActualizar.append('archivoimagen', archivoimagen, nuevoNombre);

   }
    
   
   var urlGuardar = 'registro.php';

   // Enviar la solicitud Fetch
   fetch(urlGuardar, {
       method: 'POST',
       body: formatoActualizar
   })
       .then(response => response.json())
       .then(data => {
           console.log('Imagen y datos guardados con éxito:', data);
       })
       .catch(error => {
           console.log('Error al guardar la imagen y datos:', error);
       });

    
}
