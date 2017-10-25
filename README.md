# DeviseSessionable
Devise Sessionable extends the  [Simple Token Authentication](https://github.com/gonzalo-bulnes/simple_token_authentication) gem into a `Session` object to allow for easier and more secure token authentication.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'devise_sessionable'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install devise_sessionable
```

## Getting Started

First things first, run the installer:

```bash 
rails generate devise_sessionable:install
```

This will generate a migration for the session object.

**NOTE:** This gem is setup to work with UUIDs as default. If you are _NOT_ using uuids you will need to update the migration to reflect this correctly. 

Then simply run:

```bash 
rails db:migrate
```

## Adding Session Authentication on a Model

simply add `acts_as_sessionable` to the devise enabled model that you wish to be session authable.

```ruby
class User < ApplicationRecord
  acts_as_sessionable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
```

## Enabling Session Authentication in the Controller

Once you have a model with session authentication enabled on a model, you can start using it in your controller with just a few simple steps. 

First, you need to put your controllers behind a layer of token authentication:

```ruby 
module Api
  module V1
    class ApiController < ApplicationController
      acts_as_token_authentication_handler_for DeviseSessionable::Session,
                                               as: :session,
                                               fallback: :exception
    end
  end
end
```

Secondly, because we are using the `Session` to authenticate, but are actually authenticating a `User`, we need to define the `current_authable` scope in our `ApiController`

```ruby
private 

def current_authable
  current_user
end
```

Finally, we need to setup our Simple Token Authentication to refer to the sessions `id` when authenticating

```ruby 
# config/initializers/simple_token_authentication.rb

SimpleTokenAuthentication.configure do |config|
  config.identifiers = { session: 'id' }
end
```

_(This is something that we plan to integrate into the gem itself in a future release)_

## Using Sessions for Authentication

Now that we have everything in place, we can authenticate using our new session objects. How you want to handle the creation, deletion and expiration of sessions is up to you, all the gem cares about is that a valid session is passed through to authenticate.

Underneath the gem we are still using the Simple Token Authentication gem to handle authentication, the usage is essentially the same, and you can refer to their documentation [here](https://github.com/gonzalo-bulnes/simple_token_authentication#usage)

Default Header Keys:

```ruby  
  'X-Session-Id' => session.id,
  'X-Session-Token' => session.authentication_token
```

These can be overidden in the `SimpleTokenAuthentication` initializer, using the same methods the base gem uses.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
