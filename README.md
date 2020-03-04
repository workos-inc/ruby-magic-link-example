# ruby-sso-example

An example Sinatra application demonstrating how SSO works with WorkOS and Ruby.

## Clone and Install

Clone this repo and install dependencies:

```sh
git clone https://github.com/workos-inc/ruby-sso-example.git && cd ruby-sso-example && bundle install
```

## Configure your environment

1. Grab your [API Key](https://dashboard.workos.com/api-keys). The `workos` gem will read your API key from the ENV variable `WORKOS_KEY`. You may also set the API key yourself by adding `WorkOS.key = $YOUR_API_KEY` to `app.rb`.
2. Create an [SSO Connection](https://dashboard.workos.com/sso/connections).
3. Add a [Redirect URI](https://dashboard.workos.com/sso/configuration) with the value `http://localhost:4567/callback`.
4. Get your [Project ID](https://dashboard.workos.com/sso/configuration).
5. Update `app.rb`:

```ruby
DOMAIN = "$YOUR_CONNECTIONS_DOMAIN"
PROJECT_ID = "$YOUR_PROJECT_ID"
REDIRECT_URI = "$YOUR_REDIRECT_URI"
```

## Run the app and log in using SSO

```sh
ruby app.rb
```

Head to `http://localhost:4567` and click Sign In to authenticate!

For more information, see the [WorkOS Ruby SDK documentation](https://docs.workos.com/sdk/ruby).

