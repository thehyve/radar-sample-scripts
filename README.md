# RADAR-base scripts

## Table of contents

- [Access RADAR-base entities](#Access-RADAR-base-entities)
    * [Create a new OAuthClient](#Create-a-new-OAuthClient)
    * [Script](#script)
- [Access Data via Minio API](#Access-Data-via-Minio-API)

## Access RADAR-base Entities

### Create a new OAuthClient

* Log into `ManagementPortal`
* View the `OAuth Clients` page (Top Menu/`Administration`/`OAuth Clients`)
* Register a new OAuth Client
  * Enter the `Client ID`, and `Client Secret`
  * Enter the Scope
    * `SOURCETYPE.READ, MEASUREMENT.CREATE, PROJECT.READ, OAUTHCLIENTS.READ, SOURCEDATA.READ, SUBJECT.READ`
  * Enter the Resources
    * `res_ManagementPortal, res_gateway`
  * Check Grant Type `client_credentials`
  * Enter `Access Token Validity` (a value in seconds, e.g. 900 = 15 minutes) 

### Script

* Run the script in `scripts` folder:
```shell
./scripts/main.sh
```

## Access Data via Minio API

* Install the app dependencies
```shell
npm install
```
* Run the NodeJs Application
```shell
node app.mjs
```
