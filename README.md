# Ricoh Media Storage Sample

An Web Album App using Ricoh Storage API written in Ruby on Rails.

## Pre-requirements

You need

* Ricoh API Client Credentials (client_id & client_secret)
* Ricoh ID (user_id & password)

If you don't have them, please register them at [THETA Developers Website](http://contest.theta360.com/).

Since this sample app is written in Ruby on Rails, you also needs these ruby evironment on your machine.

* ruby (2.0 or higher)
* bundler

## Run on local

Clone this repository & install all required gems.

```
$ git clone git@github.com:ricohapi/media-storage-sample-app.git
$ cd media-storage-sample-app
$ bundle install
$ bundle exec rake db:migrate
```

Setup Ricoh Auth Client Credentials via environmental variables (or modify `config/secrets.yml`).

```
export RICOH_OAUTH_CLIENT_ID=<your-client-id>
export RICOH_OAUTH_CLIENT_SECRET=<your-client-secret>
```

Then run the app.

```sh
$ bundle exec rails server
```

Then it should be running at http://localhost:3000

## Run on Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/ricohapi/media-storage-sample-app)

and add `RICOH_OAUTH_CLIENT_ID` and `RICOH_OAUTH_CLIENT_SECRET` to the Heroku app's config.

## Where to read?

This rails app has no image data on local.  
All media data are stored in the Ricoh Storage API.

Ricoh-specific Auth Client and Media Storage API Client code are released as rubygems.
* [Ricoh Auth Client Gem](https://github.com/ricohapi/auth-rb)
* [Media Storage API Client Gem](https://github.com/ricohapi/media-storage-rb).

Those Ricoh-specific client codes are called from models and controllers via these concerns.

* app/models/concerns/ricoh_id.rb
* app/controllers/concerns/ricoh_api_access.rb

These controllers are accessing Media Storage API

* app/controllers/images_controller.rb
* app/controllers/image/contents_controller.rb

and Account model is accessing Ricoh Auth endpoints.

* app/models/account.rb
