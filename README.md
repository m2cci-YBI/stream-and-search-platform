# Running the application

and enter your github password and url on bootstrap.yml file of config-server
- create database and schema 'keycloak' with user , create user postgres for analytics service 
and create schema 'analytics' on default database postgres
- Then run mvn install -DskipTests command
- Then run docker-compose up command in docker-compose folder
- Remove some duplicates to free memory :
  -  docker stop docker-compose-elastic-3-1 docker-compose-kafka-broker-3-1 docker-compose-config-server-ha-1
