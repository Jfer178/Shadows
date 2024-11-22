from datetime import datetime
import json
from flask import Flask, request, jsonify, render_template, session
import mysql.connector

app = Flask(__name__)


db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'shadows',
    'port': 3306
}

app.secret_key = 'tu_clave_secreta_aqui'

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/productos')
def productos():
    return render_template('productos.html')

@app.route('/sobre_nosotros')
def sobre_nosotros():
    return render_template('sobre_nosotros.html')

@app.route('/contacto')
def contacto():
    return render_template('contacto.html')

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/registroUsuario')
def registro_usuario():
    return render_template('registroUsuario.html')

@app.route('/carrito')
def carrito():
    return render_template('carrito.html')

@app.route('/registro', methods=['POST'])
def registrar_usuario():
    
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    
    datos = request.json
    id_cliente = datos['id_cliente']
    nombre = datos['nombre']
    direccion = datos['direccion']
    correo = datos['correo']
    password = datos['password']

    try:
     
        query = """
        INSERT INTO cliente (id_cliente, nombre, Direccion, correo, password)
        VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(query, (id_cliente, nombre, direccion, correo, password))
        conn.commit()

        return jsonify({'mensaje': 'Usuario registrado exitosamente'}), 200
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return jsonify({'mensaje': 'Error al registrar el usuario'}), 500
    finally:
        cursor.close()
        conn.close()


@app.route('/login', methods=['POST'])
def login_post():
    
    datos = request.json
    correo = datos['correo']
    contraseña = datos['contraseña']

    
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    try:
       
        query = """
        SELECT id_cliente, nombre, correo, direccion, password FROM cliente WHERE correo = %s
        """
        cursor.execute(query, (correo,))
        usuario = cursor.fetchone()

        if usuario:
            
            stored_password = usuario[4].encode('utf-8')  

            if contraseña == stored_password.decode('utf-8'):  
               
                session['user_id'] = usuario[0]  
                session['nombre'] = usuario[1]   
                session['correo'] = usuario[2]  
                session['direccion'] = usuario[3]  
                return jsonify({'success': True, 'nombre': usuario[1]})  
            else:
                return jsonify({'success': False, 'mensaje': 'Correo o contraseña incorrectos'}), 400
        else:
            return jsonify({'success': False, 'mensaje': 'Correo o contraseña incorrectos'}), 400

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return jsonify({'success': False, 'mensaje': 'Error al procesar la solicitud'}), 500

    finally:
        cursor.close()
        conn.close()


@app.route('/usuario_info')
def usuario_info():
    
    if 'user_id' in session:
        
        user_id = session['user_id']
        nombre = session['nombre']
        direccion = session['direccion']

        return jsonify({
            'success': True,
            'id_cliente': user_id,
            'nombre': nombre,
            'direccion': direccion
        })
    else:
        return jsonify({'success': False, 'mensaje': 'No estás autenticado'}), 401


@app.route('/guardar_transaccion', methods=['POST'])
def guardar_transaccion():
    
    data = request.json
    monto = data['monto']
    direccion_envio = data['direccion_envio']
    id_cliente = data['id_cliente']
    fecha = data['fecha']  
    productos = data['productos'] 

    
    try:
        fecha = datetime.fromisoformat(fecha)  
    except ValueError as e:
        return jsonify({'success': False, 'mensaje': 'Formato de fecha incorrecto'}), 400

    
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    try:
       
        query = """
        INSERT INTO transaccion (Monto, direccion_envio, id_cliente, fecha) 
        VALUES (%s, %s, %s, %s)
        """
        cursor.execute(query, (monto, direccion_envio, id_cliente, fecha))
        conn.commit()

      
        transaccion_id = cursor.lastrowid
        
       
        for producto in productos:
            titulo_producto = producto['titulo']  
            nombre_producto = producto['nombre']  
            cantidad = producto['cantidad']
            precio = producto['precio']
            bruto = producto['bruto']
            neto = producto['neto']
            imp = producto['imp']

            
            query_detalle = """
            INSERT INTO detalle_trans (cantidad, id_transaccion_fk, bruto, neto, id_producto, precio, imp, nombre) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(query_detalle, (cantidad, transaccion_id, bruto, neto, titulo_producto, precio, imp, nombre_producto))
            conn.commit()

       
        return jsonify({'success': True, 'mensaje': 'Transacción guardada exitosamente'}), 200

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return jsonify({'success': False, 'mensaje': 'Error al guardar la transacción'}), 500
    finally:
        cursor.close()
        conn.close()


@app.route('/insertar_productos', methods=['POST'])
def insertar_productos():
    conn = None
    cursor = None
    try:
        # Obtener los datos enviados en el JSON
        data = request.get_json()
        productos = data.get('productos', [])

        # Validar si hay productos
        if not productos:
            return jsonify({'success': False, 'mensaje': 'No se proporcionaron productos'}), 400

        # Conexión a la base de datos
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        for producto in productos:
            nombre = producto['titulo']
            descripcion = producto.get('descripcion')
            img = producto['imagen']
            id_producto = producto['id']
            precio = producto['precio']

            # Consulta para insertar producto
            query = """
                INSERT INTO producto (nombre, Descripcion, img, id_producto, precio)
                VALUES (%s, %s, %s, %s, %s)
            """
            cursor.execute(query, (nombre, descripcion, img, id_producto, precio))

        conn.commit()

        return jsonify({'success': True, 'mensaje': 'Productos insertados correctamente.'}), 200

    except mysql.connector.Error as err:
        # Log para errores específicos de MySQL
        print(f"Error en la base de datos: {err}")
        return jsonify({'success': False, 'mensaje': f'Error al insertar productos: {err}'}), 500

    finally:
        # Cerrar conexión
        if cursor:
            cursor.close()
        if conn:
            conn.close()


@app.route('/insertar_contacto', methods=['POST'])
def insertar_contacto():
    conn = None
    cursor = None
    try:
        # Obtener los datos del formulario (JSON)
        data = request.get_json()

        # Obtener los valores del JSON
        nombre = data.get('nombre')
        correo = data.get('correo')
        telefono = data.get('telefono')
        mensaje = data.get('mensaje')

        # Obtener el id_cliente de la sesión
        id_cliente_fk = session['user_id']

        # Establecemos la conexión con la base de datos
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Ejecutamos la consulta para insertar los datos en la tabla 'conctame'
        query = """
            INSERT INTO conctame (id_cliente_fk, nombre, correo, telefono, mensaje)
            VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(query, (id_cliente_fk, nombre, correo, telefono, mensaje))
        conn.commit()  # Confirmamos los cambios en la base de datos

        return jsonify({'success': True, 'mensaje': 'Mensaje enviado correctamente'}), 200

    except mysql.connector.Error as err:
        # Capturamos errores específicos de MySQL
        print(f"Error MySQL: {err}")
        return jsonify({'success': False, 'mensaje': 'Error al insertar los datos en la base de datos'}), 500

    except Exception as e:
        # Capturamos cualquier otro error
        print(f"Error: {str(e)}")
        return jsonify({'success': False, 'mensaje': f'Error: {str(e)}'}), 500

    finally:
        # Cerramos el cursor y la conexión si se abrieron
        if cursor:
            cursor.close()
        if conn:
            conn.close()

if __name__ == '__main__':
    app.run(debug=True)