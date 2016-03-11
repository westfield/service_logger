require 'rails/railtie'
require 'action_view/log_subscriber'
require 'action_controller/log_subscriber'

module ServiceLogger
  class Railtie < Rails::Railtie
    config.service_logger = ActiveSupport::OrderedOptions.new

    config.before_initialize do |app|
      ServiceLogger.setup(app)
    end

    config.after_initialize do |app|
      config.lograge.enable = true
      config.lograge.formatter = Lograge::Formatters::Json.new
      config.lograge.custom_options = lambda do |request|
        { service_name: ServiceLogger.service_name, environment: ServiceLogger.environment }
      end

      Lograge.setup(app)
    end
  end
end
