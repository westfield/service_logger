# ServiceLogger

Structured Logging to support Westfield Api micro services

## Installation

Add the following lines to your application's Gemfile:

```ruby
  gem 'lograge'
  gem 'logstash-event'
  gem 'logstash-logger'
  gem 'service_logger', git: "#{westfield_private}/service_logger"
```

And then execute:

    $ bundle

## Service Integration

  - Step 1 - Add the following to the Application Controller
    ```ruby
      include ServiceLogger
    ```

    ```ruby
      def service_info
        return { service_name: "name_of_service", environment: "#{Rails.env}" }
      end
    ```

  - Step 2 - Add the following to `config/environments/development.rb` && `config/environments/production.rb`

    ```ruby
      # Supports Structured logging
      config.log_level = :info
      config.log_tags = [ :uuid ]

      config.lograge.formatter = Lograge::Formatters::Json.new
      config.lograge.enabled = true
      config.lograge.custom_options = lambda do |request|
        { service_name: "name_of_service", environment: "#{Rails.env}", time: request.time }
      end
    ```

  - Step 3 - Add `service_log` method to relevant controllers (This is an Optional Step)

  ```ruby
    service_log(service_info, "action_and_controller_name", { data_from_service } , tag_name)
  ```

    Example
  ```ruby
    service_log(service_info, 'show_event', { event: @event }, "analytics")
  ```


## Results

- Post integration of `service_logger`, your logs should be cleaner and contain the following:

```ruby
  #Example of the basics (based on Step 1)
  [b0164c88-b972-4b75-84c2-286e4704839e]
  {"method":"GET","path":"/events","format":"json","controller":"api/v1/events","action":"index","status":200,"duration":207.57,"view":72.67,"db":23.61,"service_name":"events","environment":"development","time":"2016-03-07T15:18:12.752-08:00"}
```

```ruby
  #Example of additional optional logging for analytical purposes (based on Step 2)
  [b0164c88-b972-4b75-84c2-286e4704839e] [analytics] [2016-03-07 23:18:12 UTC] {"service_name":null,"environment":"development","service_message":"index_of_events","service_details":{"events_count":10}}
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT). -->
