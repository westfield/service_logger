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
        defaults = ServiceLogger.default_custom_options
        exceptions = %w(controller action format id)
        params = { params: request.payload[:params].except(*exceptions) }

        defaults.merge(params)
      end

      Lograge.setup(app)
    end
  end
end
