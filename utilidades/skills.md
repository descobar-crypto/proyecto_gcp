---
name: customs-gcp-cdc-analytics
description: >
  Skill providing complete project context for the migration of the analytical
  ecosystem of a Customs Transit System from an On-Premise Oracle environment
  to Google Cloud Platform (GCP) using Change Data Capture (CDC), Datastream,
  BigQuery, Dataform and Looker Studio.

version: 1.0
status: Proposal
owner: Technical Architecture Team
domain: Customs Analytics
language: English
---

# Customs Analytics Migration to Google Cloud

## Overview

This skill describes the business context, architecture, objectives, assumptions and technical components of a proposal to modernize the analytical ecosystem of a Customs Transit System.

The project does **not** migrate the operational application. The transactional system remains On-Premise while the analytical platform is moved to Google Cloud Platform.

The solution is intended to provide operational dashboards, maps, reporting and analytical capabilities using information replicated from Oracle through Change Data Capture (CDC).

This document represents the selected preliminary architecture for the proposal phase.

---

# Purpose

The purpose of this skill is to provide another AI assistant with sufficient knowledge to understand the project without requiring previous conversations or additional documentation.

The AI should be able to:

- Understand the business domain.
- Understand the current architecture.
- Understand the proposed architecture.
- Explain the data flow.
- Explain each Google Cloud component.
- Answer architecture questions.
- Maintain consistent terminology.
- Avoid assumptions outside the documented scope.

---

# Business Context

The project belongs to a Customs Transit System.

The system manages the registration and monitoring of cargo entering the country under customs transit.

Every transit operation begins when cargo is registered at a customs office and continues through several checkpoints until the operation reaches its destination and is officially closed.

Throughout its lifecycle, the system records operational events that allow authorities to determine:

- Current transit status.
- Transit history.
- Customs origin.
- Customs destination.
- Transit duration.
- Operational traceability.
- Control points visited.

The information is currently used mainly through traditional reports generated from an On-Premise environment.

The objective is to modernize this analytical process while preserving Oracle as the official transactional database.

---

# Business Objectives

The proposal aims to:

- Modernize the analytical platform.
- Provide Near Real Time operational information.
- Replace scheduled reporting with interactive dashboards.
- Improve operational visibility.
- Enable geographical visualization through maps.
- Improve traceability analysis.
- Centralize analytical data inside Google Cloud.
- Reduce dependency on existing ETL execution for reporting.
- Preserve the existing transactional system.

---

# Current Environment

The current environment is composed of three major components.

## Oracle 12c

Oracle is the operational database of the Customs System.

Responsibilities include:

- Store transit information.
- Store operational events.
- Store traceability information.
- Support transactional workloads.
- Serve as the single source of truth.

The operational application writes directly into Oracle.

---

## SSIS

SQL Server Integration Services (SSIS) currently performs analytical preparation.

Responsibilities include:

- Execute ETL processes.
- Apply business rules.
- Clean data.
- Prepare reporting datasets.
- Feed existing reporting processes.

The proposal does not migrate SSIS itself.

Instead, the business logic currently implemented by SSIS will eventually be reproduced inside Google Cloud.

---

## Cognos

IBM Cognos is currently used for reporting.

Reports are generated according to scheduled executions.

The reporting process is not Near Real Time.

---

# Current Process

The current analytical process can be summarized as:

Operational System

↓

Oracle

↓

SSIS

↓

Prepared datasets

↓

Cognos Reports

The analytical process depends on scheduled executions.

---

# Proposed Architecture

The selected architecture is composed of the following components.

```
Customs System
        │
        ▼
Oracle 12c On-Premise
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

# Solution Overview

The operational application continues using Oracle as its transactional database.

Whenever changes occur inside Oracle, Change Data Capture detects the committed transactions.

Those changes are securely transferred into Google Cloud.

Datastream continuously replicates those changes into BigQuery.

BigQuery stores the replicated information inside the RAW layer.

Dataform applies business transformations over RAW data.

The transformed information becomes available inside curated datasets.

Looker Studio consumes curated information for dashboards and maps.

---

# Architectural Principles

The proposal follows the following principles.

## Oracle remains the authoritative source

Oracle continues being the official transactional database.

No application writes directly into Google Cloud analytical datasets.

---

## Non-invasive analytics

The proposal separates transactional processing from analytical processing.

Operational workloads continue running On-Premise.

Analytics execute independently inside Google Cloud.

---

## ELT approach

Raw information is replicated first.

Business transformations occur inside BigQuery using SQL.

---

## Incremental replication

Only committed database changes are replicated after the initial load.

---

# Google Cloud Components

## HA VPN

Provides secure encrypted communication between the On-Premise environment and Google Cloud.

Responsibilities:

- Secure connectivity
- Encrypted communication
- Private network integration

---

## Virtual Private Cloud (VPC)

Acts as the logical private network hosting cloud resources.

Responsibilities:

- Resource isolation
- Network segmentation
- Private routing

---

## Private Service Connect

Provides private connectivity between Google Cloud services.

Responsibilities:

- Private communication
- Service isolation
- Internal routing

---

## Datastream

Datastream performs continuous Change Data Capture replication.

Responsibilities:

- Read Oracle CDC events.
- Capture inserts.
- Capture updates.
- Capture deletes.
- Replicate changes.
- Maintain continuous synchronization.

---

## BigQuery

BigQuery acts as the analytical data platform.

Responsibilities include:

- Store replicated data.
- Execute SQL transformations.
- Support analytical workloads.
- Feed dashboards.
- Feed reporting tools.

---

## Dataform

Dataform manages SQL transformations.

Responsibilities include:

- Organize SQL models.
- Apply business rules.
- Build curated datasets.
- Create views.
- Manage dependencies between transformations.

---

## Looker Studio

Looker Studio provides visualization.

Responsibilities include:

- Operational dashboards.
- Analytical dashboards.
- Geographic visualization.
- KPI reporting.
- Interactive filtering.

---

# Data Flow

The logical flow is:

1. User performs an operation.
2. Operational application writes into Oracle.
3. Oracle commits the transaction.
4. CDC detects the committed change.
5. Datastream captures the modification.
6. Changes travel through the secure VPN connection.
7. BigQuery receives replicated records.
8. Dataform executes SQL transformations.
9. Curated datasets are updated.
10. Dashboards display the latest available information.

---

# Data Layers

The architecture separates analytical data into logical layers.

## RAW Layer

Purpose:

Store replicated Oracle information without business transformations.

Characteristics:

- Closest representation of source data.
- Historical replication.
- Minimal modifications.
- Supports auditing.
- Supports reconciliation.

---

## Curated Layer

Purpose:

Provide business-ready analytical datasets.

Characteristics:

- Clean data.
- Business logic applied.
- Standardized attributes.
- Optimized queries.
- Dashboard consumption.

---

# Business Rules

Business rules are conceptually derived from the existing SSIS implementation.

Examples include:

- Duplicate removal.
- Null handling.
- Data standardization.
- Attribute normalization.
- Data validation.
- Derived fields.
- Business classifications.

The exact implementation will be defined after complete rule discovery.

---

# Preliminary Data Model

Current knowledge indicates the existence of:

## Core Tables

### Transit

Stores the main transit operation.

Typical information includes:

- Transit identifier
- Origin customs office
- Destination customs office
- Current status
- Registration timestamp

---

### Traceability

Stores operational events associated with each transit.

Typical information includes:

- Transit identifier
- Event
- Timestamp
- Operational status
- Control point

---

## Supporting Tables

Current information indicates approximately three lookup or reference tables supporting operational processing.

Their exact structure will be identified during implementation.

---

# Expected Data Volume

Current operational estimates indicate:

Historical maximum:

- Approximately 1,200 records per day.

Average workload:

- Approximately 600–800 records per day.

Some days may generate no operational records.

These volumes represent relatively small analytical workloads.

---

# Near Real Time Objective

The proposal aims to reduce the delay between operational transactions and analytical availability.

Expected outcome:

- Operational dashboards updated within minutes.
- Analytical datasets refreshed continuously through CDC replication.
- Reporting significantly more current than scheduled batch reporting.

The objective is Near Real Time rather than strict real-time processing.

---

# Deliverables

The proposal focuses on the analytical ecosystem.

Expected deliverables include:

- Secure Oracle connectivity.
- Continuous CDC replication.
- Google Cloud analytical environment.
- RAW datasets.
- Curated datasets.
- SQL transformation models.
- Operational dashboards.
- Analytical dashboards.
- Geographic visualization.
- Documentation.

---

# Scope

Included:

- Oracle connectivity.
- CDC replication.
- Google Cloud analytical environment.
- Data ingestion.
- Data transformation.
- Dashboard generation.
- Reporting platform.

---

# Out of Scope

The proposal does not include:

- Migration of the operational application.
- Migration of Oracle.
- Backend modernization.
- Frontend modernization.
- Operational system redesign.
- Transaction processing changes.

---

# Assumptions

The proposal assumes:

- Oracle remains operational.
- Oracle continues acting as the source of truth.
- Network connectivity between environments is available.
- Required database permissions can be granted.
- Business rules can be extracted from current ETL processes.
- Existing timestamps are available.
- Primary keys exist for replicated entities.

---

# Constraints

Known constraints include:

- Oracle remains On-Premise.
- Limited visibility into the complete data model.
- Preliminary understanding of business rules.
- Proposal phase only.
- Final implementation details remain subject to validation.

---

# Terminology

## Transit

Movement of cargo under customs control.

---

## Traceability

Chronological sequence of operational events associated with a transit.

---

## Customs Office

Authorized location where customs operations occur.

---

## Control Point

Intermediate checkpoint where operational events are registered.

---

## CDC

Change Data Capture.

Mechanism that captures committed database modifications.

---

## RAW Dataset

Dataset containing replicated information with minimal transformation.

---

## Curated Dataset

Dataset containing business-ready analytical information.

---

## ELT

Extract, Load and Transform.

Data is loaded first, transformed afterwards.

---

## Source of Truth

The official system responsible for maintaining authoritative operational information.

Within this project, Oracle remains the Source of Truth.

---

# AI Guidance

When responding about this project, an AI assistant should follow these principles:

- Treat Oracle as the authoritative transactional database.
- Assume Google Cloud is exclusively responsible for analytics.
- Use terminology consistent with customs transit operations.
- Distinguish clearly between RAW and Curated datasets.
- Treat SSIS as the origin of business rules, not as part of the target analytical architecture.
- Consider the architecture preliminary and proposal-oriented.
- Avoid assuming implementation details that have not been documented.
- Explain the solution using an ELT analytical perspective.
- Maintain consistency between business objectives and technical architecture.
- Preserve the separation between transactional processing and analytical processing.