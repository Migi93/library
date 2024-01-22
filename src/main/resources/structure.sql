CREATE TABLE USUARIOS (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    NOMBRE VARCHAR2(50) NOT NULL,
    APELLIDO1 VARCHAR2(50) NOT NULL,
    APELLIDO2 VARCHAR2(50),
    DNI VARCHAR2(9) UNIQUE NOT NULL,
    TELEFONO_MOVIL VARCHAR2(15) NOT NULL,
    TELEFONO_FIJO VARCHAR2(15),
    CORREO VARCHAR2(50) UNIQUE NOT NULL,
    FECHA_CREACION DATE
);

CREATE TABLE EDITORIALES (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    NOMBRE VARCHAR2(50) NOT NULL,
    DIRECCION VARCHAR2(100) NOT NULL,
    TELEFONO VARCHAR2(20) NOT NULL,
    CORREO VARCHAR2(50),
    FECHA_CREACION DATE
);

CREATE TABLE LIBROS (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    TITULO VARCHAR2(100) NOT NULL,
    EDITORIAL_ID NUMBER NOT NULL,
    FECHA_PUBLICACION DATE,
    ISBN VARCHAR2(17) UNIQUE NOT NULL,
    CONSTRAINT FK_EDITORIAL_ID FOREIGN KEY (EDITORIAL_ID) REFERENCES EDITORIALES(ID) ON DELETE CASCADE
);

CREATE TABLE CATEGORIAS (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    NOMBRE VARCHAR2(50) NOT NULL,
    DESCRIPCION VARCHAR2(255) NOT NULL
);

CREATE TABLE LIBROS_CATEGORIAS (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    LIBRO_ID NUMBER NOT NULL,
    CATEGORIA_ID NUMBER NOT NULL,
    CONSTRAINT FK_LIBRO_ID FOREIGN KEY (LIBRO_ID) REFERENCES LIBROS(ID) ON DELETE CASCADE,
    CONSTRAINT FK_CATEGORIA_ID FOREIGN KEY (CATEGORIA_ID) REFERENCES CATEGORIAS(ID) ON DELETE CASCADE
);

CREATE TABLE RESENAS (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    LIBRO_ID NUMBER NOT NULL,
    USUARIO_ID NUMBER NOT NULL,
    CALIFICACION NUMBER(3,2) NOT NULL,
    COMENTARIO VARCHAR2(255),
    FECHA_RESENA DATE,
    CONSTRAINT FK_LIBRO_ID_RESENAS FOREIGN KEY (LIBRO_ID) REFERENCES LIBROS(ID) ON DELETE CASCADE,
    CONSTRAINT FK_USUARIO_ID_RESENAS FOREIGN KEY (USUARIO_ID) REFERENCES USUARIOS(ID) ON DELETE CASCADE,
    CONSTRAINT CHK_CALIFICACION CHECK (CALIFICACION >= 0 AND CALIFICACION <= 10)
);


CREATE TABLE PRESTAMOS (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    LIBRO_ID NUMBER NOT NULL,
    USUARIO_ID NUMBER NOT NULL,
    FECHA_PRESTAMO DATE,
    FECHA_DEVOLUCION DATE,
    ESTADO VARCHAR2(20) NOT NULL,
    CONSTRAINT FK_LIBRO_ID_PRESTAMOS FOREIGN KEY (LIBRO_ID) REFERENCES LIBROS(ID) ON DELETE CASCADE,
    CONSTRAINT FK_USUARIO_ID_PRESTAMOS FOREIGN KEY (USUARIO_ID) REFERENCES USUARIOS(ID) ON DELETE CASCADE
);

CREATE TABLE AUTORES (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    NOMBRE VARCHAR2(50) NOT NULL,
    APELLIDO1 VARCHAR2(50) NOT NULL,
    APELLIDO2 VARCHAR2(50),
    BIOGRAFIA VARCHAR2(255)
);

CREATE TABLE LIBROS_AUTORES (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    LIBRO_ID NUMBER NOT NULL,
    AUTOR_ID NUMBER NOT NULL,
    CONSTRAINT FK_LIBRO_ID_LIBROS_AUTORES FOREIGN KEY (LIBRO_ID) REFERENCES LIBROS(ID) ON DELETE CASCADE,
    CONSTRAINT FK_AUTOR_ID_LIBROS_AUTORES FOREIGN KEY (AUTOR_ID) REFERENCES AUTORES(ID) ON DELETE CASCADE
);


