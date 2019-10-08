# Leather::Satchel

A simple IOC container based of off [silexphp/Pimple](https://github.com/silexphp/Pimple)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'leather-satchel'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install leather-satchel

## Usage

### Basic usage

```ruby
require 'leather/satchel'

container = Leather::Satchel::Container.new

# Insert a value into the container
container['integer'] = 0

# Retrieve a server from the container
value = container['integer']
```

### Defining Services

Passing a lamdba or proc to the container will define a service. Services accept the container as their only argument and return an instance of an object. Instantiation is done only once, further calls to the service return the same instance. As the container is passed to the callable, you can pull in other services and values for instantiating the object.

```ruby
container['host'] = 'localhost'
container['username'] = 'test_user'
container['password'] = '*********'

container['database'] = container.factory(proc { |c|
  Database.new(
    c['host'],
    c['username'],
    c['password']
  )
})

database = container['database']
```

### Defining Factory Services

Factory services are services that return a new instance of the object on each call instead of the same instance each time.

```ruby
container['database'] = container.factory(proc { |c|
  Database.new(
    c['host'],
    c['username'],
    c['password']
  )
})

database = container['database']
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chrisBirmingham/leather-satchel.
