document.getElementById('carrito-acciones-comprar').addEventListener('click', function() {
   
    let productosEnCarrito = JSON.parse(localStorage.getItem("productos-en-carrito")) || [];

  
    fetch('/usuario_info')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const nombreUsuario = data.nombre;
                const direccionUsuario = data.direccion;
                const fechaHora = new Date().toLocaleDateString(); 

               
                let total = 0;
                let detalles = '';
                productosEnCarrito.forEach(producto => {
                    detalles += `<p>${producto.titulo} - ${producto.cantidad} x $${producto.precio}</p>`;
                    total += producto.precio * producto.cantidad;
                });

                
                document.getElementById('factura-detalles').innerHTML = detalles;
                document.getElementById('factura-total').textContent = total;

                
                document.getElementById('factura-nombre').textContent = nombreUsuario;
                document.getElementById('factura-direccion').textContent = direccionUsuario;
                document.getElementById('factura-fecha-hora').textContent = fechaHora;

               
                document.getElementById('factura').style.display = 'flex';

                
                const transaccionData = {
                    monto: total,
                    direccion_envio: direccionUsuario,
                    id_cliente: data.id_cliente,  
                    fecha: new Date().toISOString(),  
                    productos: productosEnCarrito.map(producto => ({
                        id_producto: producto.id,  
                        titulo: producto.titulo,  
                        nombre: producto.titulo,  
                        cantidad: producto.cantidad,  
                        precio: producto.precio,  
                        bruto: producto.precio * producto.cantidad,  
                        neto: producto.precio * producto.cantidad * 0.9, 
                        imp: producto.precio * producto.cantidad * 0.1 
                    }))
                };

                
                fetch('/guardar_transaccion', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(transaccionData),
                })
                .then(response => response.json())
                .then(result => {
                    if (result.success) {
                        console.log('Transacción guardada correctamente');
                        
                        localStorage.setItem("productos-en-carrito", JSON.stringify([]));
                    } else {
                        console.log('Error al guardar la transacción:', result.mensaje);
                    }
                })
                .catch(error => {
                    console.error('Error al enviar la transacción:', error);
                });

            } else {
                alert('No se pudo obtener la información del usuario.');
            }
        })
        .catch(error => console.error('Error:', error));
});


document.getElementById('cerrar-factura').addEventListener('click', function() {
    document.getElementById('factura').style.display = 'none';
});


document.getElementById('volver-a-comprar').addEventListener('click', function() {
    window.location.href = '/productos';
});
