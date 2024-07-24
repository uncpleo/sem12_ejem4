<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Procesando Inserción</title>
</head>
<body>
    <%
        // Obtener parámetros del formulario
        String nombre = request.getParameter("nombre");
        int edad = Integer.parseInt(request.getParameter("edad"));
        String grado = request.getParameter("grado");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // Cargar el driver de MySQL (esto puede omitirse si ya se ha cargado previamente)
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establecer la conexión con la base de datos
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/escuelita?useSSL=false", "root", "karen.100");
            
            // Query para insertar un nuevo alumno
            String sql = "INSERT INTO alumno (nombre, edad, grado) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nombre);
            pstmt.setInt(2, edad);
            pstmt.setString(3, grado);
            
            // Ejecutar la inserción
            int filasAfectadas = pstmt.executeUpdate();
            
            if (filasAfectadas > 0) {
                // Si se insertó correctamente, redireccionar al listado de alumnos
                response.sendRedirect("read.jsp");
            } else {
                // Manejar el caso donde no se insertó ningún registro (opcional)
                out.println("<p>No se pudo insertar el alumno.</p>");
            }
        } catch (SQLException e) {
            out.println("<p>Error al conectar a la base de datos.</p>");
            e.printStackTrace();
        } catch (Exception e) {
            out.println("<p>Ocurrió un error inesperado.</p>");
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>
