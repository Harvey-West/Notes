# OAuth 2.0

Evolved from OAuth 1.0a which encrypted every message back and
forth. OAuth2.0 simply says well once you have at least agreed
that they are who they say they are, then rely on SSL/TLS to
encrypt the messages back and forth.

## Steps

1. The client app needs a request token. The purpose is to
   receive the user's approval and then request an access
   token. To get the request token, a specific URL must be
   provided by the server; in this step, the consumer key and
   the consumer secret are used.
2. Once the request token is obtained, the client must make a
   request using the token on a specific server URL to get
   authorization from the end user. This is the authorization
   server.
3. After authorization from the user is given, then the client
   app makes a request to the provider for an access token and
   a secret key.
4. Once the access token and secret token are obtained, the
   client app is able to request protected resources for the
   provider on behalf of the user until the token expires.

[OAuth2.0_Process](./Pictures/OAuth-Process.PNG)

## Roles & Types

- Resource Owner
  - Can be a person who application which owns/manages the data.
- Resource Server
  - The server which is hosting the access to protected data. Like a secured API for example.
- Client
- Authorization server
  - Provides and validates access tokens to clients to access the resource server.
- Scope
  - Specifies the access rights (read/write) for protected resources.

## Grant types

### Client Credentials Grant

    Resource Owner

### Authorization Code Grant

    If client code is executing server side, this means the token is kept within the network and does not go through the end user's browser.

### Password Credential Grant

    If you've logged in and you are then passing credentials to the system to get a grant.

### Implicit Grant

### Refresh Grant

    If your token is abou to expire and you wish to refresh your access you can use this grant.
