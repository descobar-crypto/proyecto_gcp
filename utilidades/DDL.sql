
CREATE TABLE "Dim_Transito" (
  "id_transito" INT PRIMARY KEY,
  "numero_transito" INT,
  "tipo_transito" VARCHAR(50),
  "mercancia" VARCHAR(255),
  "ruta" VARCHAR(255),
  "fecha_inicio" TIMESTAMP
);

CREATE TABLE "Dim_Aduana" (
  "id_aduana" INT PRIMARY KEY,
  "nombre_aduana" VARCHAR(255),
  "departamento" VARCHAR(255),
  "latitud" VARCHAR(50),
  "longitud" VARCHAR(50)
);

CREATE TABLE "Dim_Estado" (
  "id_estado" INT PRIMARY KEY,
  "tipo_estado" VARCHAR(50)
);

CREATE TABLE "Dim_Operacion" (
  "id_operacion" INT PRIMARY KEY,
  "nombre_Operacion" VARCHAR(50)
);

CREATE TABLE "Dim_Tiempo" (
  "id_tiempo" INT PRIMARY KEY,
  "fecha" DATE,
  "hora" VARCHAR(20),
  "anio" INT,
  "mes" INT,
  "dia" VARCHAR(20),
  "dia_semana" VARCHAR(20)
);

CREATE TABLE "Dim_Tipo_Transito" (
  "id_tipo_transito" INT PRIMARY KEY,
  "nombre_tipo" VARCHAR(255)
);

CREATE TABLE "Fact_Transito" (
  "id_transito" INT PRIMARY KEY,
  "numero_declaracion" VARCHAR(255),
  "id_aduanaInicio" INT,
  "id_aduana_destino" INT,
  "id_tiempo_registro" INT,
  "fecha_inicio" TIMESTAMP,
  "fecha_final_real" TIMESTAMP,
  "plazo_horas" VARCHAR(50),
  "estado_vigente" VARCHAR(50),
  "operacion_vigente" VARCHAR(50),
  "finalizado" BOOLEAN,
  "duracion_total_min" INT,
  "cantidad_rventos" INT,
  "cantidad_puntos_intermedios" INT,
  CONSTRAINT "fk_fact_transito_transito"
    FOREIGN KEY ("id_transito") REFERENCES "Dim_Transito"("id_transito"),
  CONSTRAINT "fk_fact_transito_aduana_inicio"
    FOREIGN KEY ("id_aduanaInicio") REFERENCES "Dim_Aduana"("id_aduana"),
  CONSTRAINT "fk_fact_transito_aduana_destino"
    FOREIGN KEY ("id_aduana_destino") REFERENCES "Dim_Aduana"("id_aduana"),
  CONSTRAINT "fk_fact_transito_tiempo_registro"
    FOREIGN KEY ("id_tiempo_registro") REFERENCES "Dim_Tiempo"("id_tiempo")
);

CREATE TABLE "FACT_EVENTO_TRAZABILIDAD" (
  "id_evento" INT PRIMARY KEY,
  "id_transito" INT,
  "id_aduana" INT,
  "id_tiempo" INT,
  "id_estado" INT,
  "id_operacion" INT,
  "secuencia" VARCHAR(255),
  "tiempo_desde_evento_anterior_min" INT,
  "tiempo_acumulado_min" INT,
  "es_punto_intermedio" BOOLEAN,
  "tiene_incidente" BOOLEAN,
  "observacion" VARCHAR(255),
  CONSTRAINT "fk_evento_transito"
    FOREIGN KEY ("id_transito") REFERENCES "Dim_Transito"("id_transito"),
  CONSTRAINT "fk_evento_aduana"
    FOREIGN KEY ("id_aduana") REFERENCES "Dim_Aduana"("id_aduana"),
  CONSTRAINT "fk_evento_tiempo"
    FOREIGN KEY ("id_tiempo") REFERENCES "Dim_Tiempo"("id_tiempo"),
  CONSTRAINT "fk_evento_estado"
    FOREIGN KEY ("id_estado") REFERENCES "Dim_Estado"("id_estado"),
  CONSTRAINT "fk_evento_operacion"
    FOREIGN KEY ("id_operacion") REFERENCES "Dim_Operacion"("id_operacion")
);

CREATE TABLE "Brige_estado_operacion" (
  "id_estado" INT NOT NULL,
  "id_operacion" INT NOT NULL,
  "combinaciones_validas" VARCHAR(255),
  PRIMARY KEY ("id_estado", "id_operacion"),
  CONSTRAINT "fk_bridge_estado"
    FOREIGN KEY ("id_estado") REFERENCES "Dim_Estado"("id_estado"),
  CONSTRAINT "fk_bridge_operacion"
    FOREIGN KEY ("id_operacion") REFERENCES "Dim_Operacion"("id_operacion")
);

CREATE TABLE "Dim_Producto" (
  "idEstado" VARCHAR(255) PRIMARY KEY,
  "nombreEstado" VARCHAR(255),
  "tipoEstado" VARCHAR(255),
  "estadoIncumplimiento" VARCHAR(255)
);

CREATE TABLE "Dim_Marca" (
  "idEstado" VARCHAR(255) PRIMARY KEY,
  "Empresa" VARCHAR(255)
);

CREATE TABLE "Dim_Detalle_Producto" (
  "idEstado" VARCHAR(255) PRIMARY KEY,
  "ID_Marca (FK)" VARCHAR(255),
  "tipoEstado" VARCHAR(255),
  "estadoIncumplimiento" VARCHAR(255)
);
