# Notifhome-api

Notifhome-api is the API for the Notifhome project.

The Notifhome project is divided into 3 projects:

- Notifhome-api (this project)
- Notifhome-frontend (todo)
- Notifhome-omega2 (todo)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.3.4

After cloning this project:

run bundle to install the Gems
run rake db:migrate
run bundle exec rspec to run the tests

## API

### POST /auth

Register an account.

#### Request

##### Parameters

* email
* name
* password

#### Response
##### Headers
````
access-token
client
expiry
uid
token-type
````
##### Body
````
{
    "status": "success",
    "data": {
        "email": "alex2@gmail.com",
        "name": "alex2"
    }
}
````

### POST /signin
Sign in.
#### Request
##### Parameters
* email
* password

#### Response
##### Headers
````
access-token
client
expiry
uid
token-type
````
##### Body
````
{
    "data": {
        "id": 2,
        "email": "alex@gmail.com",
        "provider": "email",
        "name": "alex",
        "uid": "alex@gmail.com"
    }
}
````

### GET /devices

Return all the devices.

#### Request
##### Headers
* access-token
* client
* expiry
* uid
* token-type

#### Response
##### Headers
````
access-token
client
expiry
uid
token-type
````

##### Body

````
{
    "devices": [
        {
            "id": 1,
            "name": "Omega2",
            "token": "$2a$10$nozcKqPqRuvvubKfKPwdyu6UCmloWsNTQcQsbOmV8DkaI97BfwU82",
            "last_request_at": "2018-05-10T13:25:04.668Z",
            "created_at": "2018-05-10T13:25:04.669Z",
            "updated_at": "2018-05-10T13:25:04.669Z"
        },
        {
            "id": 2,
            "name": "Omega3",
            "token": "$2a$10$37zps/ybbM.bZoEnrANSB.hM5D5yg/0a2x5hYaHlcgh9nX49N16j2",
            "last_request_at": "2018-05-10T13:31:34.995Z",
            "created_at": "2018-05-10T13:31:34.996Z",
            "updated_at": "2018-05-10T13:31:34.996Z"
        },

````

### POST /devices

Create a device.

#### Request
##### Headers
* access-token
* client
* expiry
* uid
* token-type
##### Parameters
* name

#### Response
##### Headers
````
access-token
client
expiry
uid
````
##### Body

````
{
    "device": {
        "id": 4,
        "name": "Omega233",
        "token": "$2a$10$nuU68/6Fha5gzVMIy8vWr.g5S44Q0IXqjjEeUSd4XD3HA1iHHaxhu",
        "last_request_at": "2018-05-10T13:55:48.050Z",
        "created_at": "2018-05-10T13:55:48.050Z",
        "updated_at": "2018-05-10T13:55:48.050Z"
    }
}
````
### DELETE /devices/:id

Delete a device.

#### Request
##### Headers
* access-token
* client
* expiry
* uid
* token-type

#### Parameters
* id

#### Response
##### Headers
````
access-token
client
expiry
uid
````
##### Status
Succes: 204

### PUT /devices
Update a device.
#### Request
##### Headers
* access-token
* client
* expiry
* uid
* token-type

#### Parameters
* name
#### Response
##### Headers
````
access-token
client
expiry
uid
````
##### Body
````
{
    "device": {
        "id": 4,
        "name": "Omega233",
        "token": "$2a$10$nuU68/6Fha5gzVMIy8vWr.g5S44Q0IXqjjEeUSd4XD3HA1iHHaxhu",
        "last_request_at": "2018-05-10T13:55:48.050Z",
        "created_at": "2018-05-10T13:55:48.050Z",
        "updated_at": "2018-05-10T13:55:48.050Z"
    }
}
````

### GET /notifications

Get all the notifications.

#### Headers

* access-token
* client
* expiry
* uid
* token-type

#### Parameters
#### Response
##### Headers
````
access-token
client
expiry
uid
````

### POST /notifications

Create a notification.

#### Headers

* access-token
* client
* expiry
* uid

#### Parameters
#### Response
##### Headers
````
access-token
client
expiry
uid
````

### GET /device/notification

Get the notification for the device (accessible only for a device).

#### Headers

* access-token

#### Parameters
#### Response
