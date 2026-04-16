const http = require('http');
const { Pool } = require('pg');

// Configuración de la conexión (Debe coincidir con main.tf)
const pool = new Pool({
  user: 'admin_user',
  host: 'bd',
  database: 'practica_db',
  password: 'password123',
  port: 5432,
});

const server = http.createServer(async (req, res) => {
  res.setHeader('Content-Type', 'application/json');
  
  try {
    // Prueba de conexión simple
    const result = await pool.query('SELECT NOW() as fechatiempo');
    res.statusCode = 200;
    res.end(JSON.stringify({ 
      mensaje: "¡Conexión Exitosa con Postgres!", 
      db_time: result.rows[0].fechatiempo 
    }));
  } catch (err) {
    res.statusCode = 500;
    res.end(JSON.stringify({ error: "Error de BD", detalles: err.message }));
  }
});

server.listen(3000, '0.0.0.0', () => {
  console.log('API lista en http://localhost:3000');
});
