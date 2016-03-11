# ServiceLogger

Structured Logging to support Westfield Api micro services

## Installation

Add the following lines to your application's Gemfile:

```ruby
  gem 'service_logger', git: "#{westfield_private}/service_logger"
```

And then execute:

    $ bundle

## Service Integration

  - Step 1 - Add the following to the Application Controller
    ```ruby
      include ServiceLogger
    ```

  - Step 2 - Add `service_logger.rb` initializer

  ```ruby
      ServiceLogger.configure do |config|
        config.service_name = "event_service" #example This will be included in the generator next round
      end
  ```


  - Step 3 - Add the following to `config/environments/development.rb` and/or `config/environments/production.rb`

    ```ruby
      # Supports Structured logging
      config.log_level = :info
      config.log_tags = [ :uuid,  lambda { |request| Time.now.utc } ]
    ```

  - Step 4 - Add `service_log` method to relevant controllers (OPTIONAL)

  ```ruby
    service_log("action_and_controller_name", { data_from_service } , tag_name)
  ```

    Example
  ```ruby
    service_log('show_event', { event: @event }, "analytics")
  ```


## Results

- Post integration of `service_logger`, your logs should be cleaner and contain the following:

```ruby
  #Example of the basics (based on Step 1)

  [e7521d93-4757-428f-85b4-f1f0e2460144] [2016-03-15 20:27:11 UTC] {"method":"GET","path":"/events","format":"json","controller":"api/v1/events","action":"index","status":200,"duration":217.51,"view":66.4,"db":25.91,"service_name":"event_service","environment":"development"}

```

```ruby
  #Example of additional optional logging for analytical purposes (based on Step 2)
[e7521d93-4757-428f-85b4-f1f0e2460144] [2016-03-15 20:27:11 UTC] [analytics] {"service_name":"event_service","environment":"development","service_message":"index_of_events","service_details":{"events_count":10}}
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT). -->
