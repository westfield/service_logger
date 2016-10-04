require 'rails/railtie'
require 'service_logger/version'
require 'active_support/concern'
require 'lograge'

module ServiceLogger
  mattr_accessor :configuration, :application, :service_name, :environment

  def self.configure
    self.configuration ||= service_logger_config
    yield service_logger_config
  end

  def self.setup(app)
    self.application = app
  end

  def self.service_name
    @service_name ||= default_service_name
  end

  def self.environment
    @environment ||= default_environment
  end

  def self.service_logger_config
    application.config.service_logger
  end

  def self.default_custom_options
    { service_name: ServiceLogger.service_name, environment: ServiceLogger.environment, version: ServiceLogger::VERSION }
  end

  private

  def self.default_service_name
    service_logger_config.service_name || Rails.application.class.to_s
  end

  def self.default_environment
    { name: service_logger_config.environment || Rails.env }
  end

  def service_log(event, event_details, tag_name="analytics")
    logger.tagged(tag_name) do
      message = { service_name: ServiceLogger.service_name, environment: ServiceLogger.environment, version: ServiceLogger::VERSION, event: event, event_details: event_details }
      logger.info(message.to_json)
    end
  end

  def logger
    raise NotImplementedError unless defined?(Rails)
    Rails.logger
  end
end

require 'service_logger/railtie' if defined?(Rails)
