# Customs Analytics — Migración a Google Cloud Platform

**Célula:** Párvulos  
**Estado:** Propuesta  

---

## Descripción

Este repositorio contiene el desarrollo de la migración del ecosistema analítico del Sistema de Tránsito Aduanero desde un ambiente On-Premise con Oracle hacia Google Cloud Platform (GCP).

El sistema transaccional permanece On-Premise. El alcance del proyecto es exclusivamente la capa analítica.

---

## Arquitectura
![Imagen arquitectura](/utilidades/arquitectura.drawio.png)

---

## Componentes principales

| Componente | Rol |
|---|---|
| Oracle 12c | Fuente de verdad transaccional (On-Premise) |
| CDC | Captura de cambios comprometidos en Oracle |
| HA VPN | Conectividad segura entre On-Premise y GCP |
| Datastream | Replicación continua hacia BigQuery |
| BigQuery RAW | Almacenamiento de datos replicados sin transformación |
| Dataform | Transformaciones SQL y reglas de negocio |
| BigQuery Curated | Datasets listos para consumo analítico |
| Looker Studio | Dashboards operacionales y visualización geográfica |

---

## Capas de datos

- **RAW** — Réplica fiel de Oracle. Sin transformaciones de negocio. Soporta auditoría y reconciliación.
- **Curated** — Datos limpios con reglas de negocio aplicadas. Optimizados para dashboards y reportes.

---

## Objetivos del proyecto

- Proveer información operacional Near Real Time
- Reemplazar reportes programados por dashboards interactivos
- Habilitar visualización geográfica de tránsitos
- Centralizar datos analíticos en Google Cloud
- Preservar el sistema transaccional existente sin modificaciones

---

## Fuera de alcance

- Migración de la aplicación operacional
- Migración de Oracle
- Modernización de backend o frontend
- Cambios en el procesamiento transaccional

---


---

## Equipo

| Integrante | Rol |
|---|---|
| Daniel Navarro | Célula Párvulos |
| Luis Escobar | Célula Párvulos |
| Eunice Beltran | Célula Párvulos |
| Gerardo Quintanilla | Célula Párvulos |
| Edwin Edenilsson | Célula Párvulos |
| Diego Escobar | Célula Párvulos |

---

## Notas

- Oracle permanece como la base de datos transaccional oficial durante todo el proyecto.
- El enfoque de integración es **ELT**: los datos se replican primero y se transforman dentro de BigQuery.
- Debido a limitaciones en informacion, existen partes que se implementaron teniendo en cuenta esa precariedad, por tanto tambien sujetas a una evaluacion cuando se conozcan todos los detalles tecnicos de la base de datos.
