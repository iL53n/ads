# Ads Microservice(from course by thinknetica.com)

Sinatra microservice

# Dependencies

- Ruby `2.6.6`
- Bundler `2.1.4`
- Sinatra `2.0.0`
- Sequel `5.32.0`
- Puma `4.3+`
- PostgreSQL `9.3+`

# Install and run application

1. Clone repo:

```
git clone https://github.com/iL53n/ads-microservice && cd auth-microservice
```

2. Install dependencies and create db:

```
bundle install

createdb -h localhost -U postgres auth_microservice_development
bin/rake db:migrate

createdb -h localhost -U postgres auth_microservice_test
RACK_ENV=test bin/rake db:migrate
```

3. Run app:

```
bin/puma
```

# Run console

```
bin/console
```

# Run tests

```
bin/rspec
```
