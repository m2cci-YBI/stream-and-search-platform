# Microservices Demo – Twitter → Kafka → Elastic Search Pipeline

This repository implements a **microservices architecture** that ingests
real-time tweets, enriches them and exposes powerful search capabilities via REST and a Web UI.
It is meant as a **reference implementation** showcasing the Spring Boot & Spring Cloud ecosystem,
Kafka, Elasticsearch, Keycloak, Grafana/Prometheus and modern DevOps practices.

The code base is intentionally split into **blocking** _and_ **reactive** service flavours so that
you can compare both programming models side by side.

---

## Table of Contents
1. Features
2. Technology Stack
3. Service Landscape
4. Prerequisites
5. Getting Started


---

## 1. Features
• Collect live tweets and push them to Kafka then index them in Elasticsearch
• Expose **blocking** & **reactive** query APIs to search tweets in Elasticsearch
• Role-based document filtering powered by Spring Security & Keycloak  
• Web clients (Thymeleaf & WebFlux) demonstrating OAuth2 → backend-for-frontend pattern  
• analytics service using Kafka Streams + Postgres  
• Observability using Prometheus, Grafana dashboards, Zipkin tracing
• Fully externalised configuration using Spring Cloud Config Server  
• Docker-Compose orchestration


## 2. Technology Stack
• **Java 17**, Maven multi-module build  
• **Spring Boot 3**, Spring Cloud (NETFLIX Eureka, Gateway, Config Server)  
• **Apache Kafka 3** (producers, consumers, Kafka Streams)  
• **Elasticsearch 8** with blocking `RestHighLevelClient` _and_ reactive `ReactiveElasticsearchClient`  
• **Keycloak** (OIDC) for identity & access management
• **Redis** (Kafka Streams state store)  
• **PostgreSQL** for analytics output  
• **Docker-Compose** for local deployments  
• **Prometheus**, **Grafana**, **Zipkin** for monitoring / tracing


## 3. Service Landscape

The architecture is built around a set of independent Spring-Boot microservices that communicate
through Kafka topics and expose data that ultimately lands in Elasticsearch.  Below is a brief
textual overview of the most important runtime components:

- **Gateway Service** – central edge component that exposes a single entry point and forwards
  requests to downstream services.
- **Elastic Query Service** – blocking REST API that executes synchronous searches against
  Elasticsearch.
- **Reactive Elastic Query Service** – WebFlux based variant using the non-blocking reactive ES
  client.
- **Elastic Query Web Clients** – Thymeleaf (Servlet) and WebFlux front-ends that authenticate via
  Keycloak and call the query services on behalf of the user.
- **Twitter-to-Kafka Service** – connects to the Twitter Streaming API and publishes raw tweets to
  Kafka.
- **Kafka-to-Elastic Service** – consumes the tweet topic and indexes the records into
  Elasticsearch.
- **Analytics Service** – optional Kafka Streams application that aggregates tweet statistics and
  stores the results in PostgreSQL.
- **Infrastructure** – Spring Cloud Config & Discovery Server (Eureka), Apache Kafka & Zookeeper,
  Elasticsearch, Redis (state store), PostgreSQL, Keycloak (OIDC), Prometheus, Grafana and
  Zipkin.

All services are containerised and wired together via Docker-Compose networks.  You can start the
complete landscape with the helper script located in `docker-compose/docker-start.sh`.


## 4. Prerequisites
1. **Java 17+** – `java -version`
2. **Maven 3.9+** – `mvn -v`
3. **Docker 20+ & Docker Compose v2** – `docker compose version`

> NOTE: Required local postgres database for KeyCloack and the analytics service

## 5. Getting Started : Running services locally from your IDE

1. create database and schema 'keycloak' with user , create user postgres for analytics service
   and create schema 'analytics' on default database postgres

2. Then run mvn install -DskipTests command

3. Start infrastructure only:
   ```bash
   cd docker-compose
   ./docker-start.sh      
   ```
4.Configure keycloak clients and resource servers , and the users and roles
* `ROLE_USER` – can query own tweets only
* `ROLE_PREMIUM_USER` – may query any document
* `ROLE_SUPER_USER` – full access to every endpoint

5. In case of low memory issues remove some duplicates to free memory : docker stop docker-compose-elastic-3-1 docker-compose-kafka-broker-3-1 docker-compose-config-server-ha-1
