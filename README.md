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

  - Step 3 - Add the following to `config/environments/development.rb` (if you want ) and/or `config/environments/production.rb`

    ```ruby
      #Supports Structured logging
      config.log_level = :info
      config.log_tags = [ :uuid,  lambda { |request| Time.now.utc } ]
    ```

## Service Integration for Analytics - [ Optional ]

  - Step 3a - Add `service_log` method to relevant controllers (This is OPTIONAL)

    ```ruby
      service_log("action_and_controller_name", { data_from_service })
      ```

    Example
    ```ruby
      service_log('show_event', { event: @event })
      ```

## Results

- Logs should be cleaner and contain the following:

```ruby
  #Example of Basic
  [aabf54d4-40a0-4082-a385-46d146006544] [2016-03-16 00:22:33 UTC] {"method":"GET","path":"/events","format":"json","controller":"api/v1/events","action":"index","status":200,"duration":80.08,"view":43.54,"db":12.6,"service_name":"event_service","environment":"development", params:{"name": "Bespoke Tech Talk" "sensitive_field": "[FILTERED]"}}
```

```ruby
  #Example of OPTIONAL logging to support analytics (Step 3a)
  [7450d124-cc42-434a-952e-09ff08f50044] [2016-03-16 00:20:45 UTC] [analytics] {"service_name":"event_service","environment":"development","event":"index_of_events","event_details":{"events_count":10}}
```

## Next Steps

 - TBD
