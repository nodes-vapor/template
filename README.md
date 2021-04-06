# Nodes Vapor Template
[![Swift Version](https://img.shields.io/badge/Swift-5.2-brightgreen.svg)](http://swift.org)
[![Vapor Version](https://img.shields.io/badge/Vapor-4-30B6FC.svg)](http://vapor.codes)
[![codebeat badge](https://codebeat.co/badges/3a24a136-5aa1-4622-a875-69d0552202c7)](https://codebeat.co/projects/github-com-nodes-vapor-template-master)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=https://github.com/nodes-vapor/template)](http://clayallsopp.github.io/readme-score?url=https://github.com/nodes-vapor/template)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/nodes-vapor/template/master/LICENSE)


A Vapor template for convenient and fast scaffolding 🏎


## 📦 Installation

### Creating a project

You can create a new project using the [Vapor toolbox](https://vapor.github.io/documentation/getting-started/install-toolbox.html).
```bash
vapor new MyApp --template https://www.github.com/nodes-vapor/template
```

## Getting started 🚀

### Project name

Before building your project you need to change the name of the project in `Package.swift`. Look for `name: "NodesTemplate"` and adjust it to fit your project.

### Environment variables

Before running your project, you need to make sure you have the environment variables set up. Use the included `.env.example` file. Copy the file to `.env`, enable your required environment variables and add their values.

Make sure to use unique and strong secrets for the signer keys (ie. the keys ending in `_SIGNER_KEY`). The keys should be unique within and across environments and projects. To generate the keys you can issue the following terminal command: `openssl rand -hex 64`.

#### PostgreSQL

For PostgreSQL you can either use a connection string (using the `POSTGRESQL_URL` key) or you can supply hostname, username, password and database individually.

#### Redis

Similar to PostgreSQL, you can either use a connection string (using the `REDIS_URL` key) or you can supply hostname and database individually.

#### Mailgun

In order to send out emails using Mailgun, the Mailgun environment variables need to be set.

#### JWT Keychain

For generating tokens, a couple of signers need to be set for JWT Keychain. These can be generated by using `openssl rand -base64 32`. Remember to generate different values for each environment.

#### Reset

For handling reset of passwords, Reset also needs a couple of signers to be set (similar to JWT Keychain).

#### Nodes SSO

To enable Nodes SSO on Admin Panel the project needs to be [created on Ournodes](https://github.com/nodes-projects/readme/blob/master/server-side/nodes-sso.md) (private link) and the environment variables needs to be set up in the project. Be aware when using SSO locally to specify the PROJECT_URL environment variable with `http`

#### Bugsnag

To support error reporting to Bugsnag, a project needs to be created on our organization and the API key needs to be added to the project.

## 🏆 Credits

This package is developed and maintained by the Vapor team at [Nodes](https://www.nodesagency.com).
