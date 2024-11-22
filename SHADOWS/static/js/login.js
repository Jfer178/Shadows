document.querySelector("#loginForm").addEventListener("submit", function(event) {
    event.preventDefault();  

   
    const email = document.querySelector("#email").value;
    const password = document.querySelector("#password").value;

    
    if (email === "" || password === "") {
        document.querySelector("#errorMessage").textContent = "Por favor, ingrese ambos campos.";
        return;
    }

    
    fetch('/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            correo: email,
            contraseña: password
        })
    })
    .then(response => response.json()) 
    .then(data => {
        if (data.success) {
            
            sessionStorage.setItem("userName", data.nombre);

            
            window.location.href = '/';  
        } else {
            
            document.querySelector("#errorMessage").textContent = "Correo o contraseña incorrectos.";
        }
    })
    .catch(error => {
        console.error("Error al hacer login:", error);
        document.querySelector("#errorMessage").textContent = "Ocurrió un error al intentar iniciar sesión.";
    });
});