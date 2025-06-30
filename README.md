# Running the application
- Please enter the correct credentials in twitter4j.properties file in twitter-to-kafka-service 
and enter your github password and url on bootstrap.yml file of config-server
- create database and schema 'keycloak' with user , create user postgres for analytics service 
and create schema 'analytics' on default database postgres
- Then run mvn install -DskipTests command
- Then run docker-compose up command in docker-compose folder