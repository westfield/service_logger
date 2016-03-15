# ServiceLogger

Structured Logging to support Westfield Api micro services

## Installation

Add the following lines to your application's Gemfile:

```ruby
  gem 'service_logger', git: "#{westfield_private}/service_logger"
```

And then execute:

    $ bundle

## Service Integration - Basics

  - Step 1 - Add `initializer/service_logger.rb`
    ```ruby
      ServiceLogger.configure do |config|
        config.service_name = "name_of_service" #Example: event_service
      end
    ```

  - Step 2 - Add the following to the Application Controller
    ```ruby
      include ServiceLogger
    ```

  - Step 3 - Add the following to `config/environments/development.rb` and/or `config/environments/production.rb`

    ```ruby
      #Supports Structured logging
      config.log_level = :info
      config.log_tags = [ :uuid,  lambda { |request| Time.now.utc } ]
    ```

## Service Integration - Optional

  - Step 3a - Add `service_log` method to relevant controllers (OPTIONAL)

    ```ruby
      service_log("action_and_controller_name", { data_from_service } , tag_name)
      ```

    Example
    ```ruby
      service_log('show_event', { event: @event }, "analytics")
      ```

## Results

- Logs should be cleaner and contain the following:

```ruby
  #Example of the basics (based on Step 1)
  [6ef968c5-f2d9-428c-8c16-1b54fb42ad4c] [2016-03-15 21:06:11 UTC] {"method":"GET","path":"/events","format":"json","controller":"api/v1/events","action":"index","status":200,"duration":91.27,"view":45.45,"db":14.95,"service_name":"EventService::Application","time":"2016-03-15T21:06:11.398Z","environment":"development"}
```

```ruby
  #Example of Optional logging for analytical purposes (based on Step 2)
  [6ef968c5-f2d9-428c-8c16-1b54fb42ad4c] [2016-03-15 21:06:11 UTC] [analytics] {"service_name":"event_service","environment":"development","service_message":"index_of_events","service_details":{"events_count":10}}
```


## Next Steps

 - TBD
