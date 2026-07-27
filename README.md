# Customs Analytics — Migración a Google Cloud Platform

**Célula:** Párvulos  
**Estado:** Propuesta  
**Dominio:** Analítica Aduanera  

---

## Descripción

Este repositorio contiene el desarrollo de la migración del ecosistema analítico del Sistema de Tránsito Aduanero desde un ambiente On-Premise con Oracle hacia Google Cloud Platform (GCP).

El sistema transaccional permanece On-Premise. El alcance del proyecto es exclusivamente la capa analítica.

---

## Arquitectura

```
Sistema Aduanero
      │
      ▼
Oracle 12c (On-Premise)
      │
      ▼
Change Data Capture (CDC)
      │
      ▼
HA VPN
      │
      ▼
Google Cloud VPC
      │
      ▼
Private Service Connect
      │
      ▼
Datastream
      │
      ▼
BigQuery RAW
      │
      ▼
Dataform
      │
      ▼
BigQuery Curated
      │
      ▼
Looker Studio
```

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

## Estructura del repositorio

```
proyecto_gcp/
├── actividades/
│   ├── actividad_1/
│   ├── actividad_2/
│   │   ...
│   └── actividad_15/
├── utilidades/
│   └── skills.md
└── README.md
```

---

## Equipo

| Rol | Responsabilidad |
|---|---|
| Célula Párvulos | Desarrollo e implementación |
| Arquitectura Técnica | Diseño de solución y decisiones de arquitectura |

---

## Notas

- Oracle permanece como la base de datos transaccional oficial durante todo el proyecto.
- El enfoque de integración es **ELT**: los datos se replican primero y se transforman dentro de BigQuery.
- Los volúmenes operacionales estimados son de 600–800 registros diarios en promedio.
