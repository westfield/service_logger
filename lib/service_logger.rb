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

  private

  def self.default_service_name
    service_logger_config.service_name || Rails.application.class.to_s
  end

  def self.default_environment
    service_logger_config.environment || Rails.env
  end

  def service_log(service_message, service_details, tag_name="none")
    logger.tagged(tag_name) do
      message = { service_name: ServiceLogger.service_name, environment: ServiceLogger.environment, service_message: service_message, service_details: service_details}
      logger.info(message.to_json)
    end
  end
end

require 'service_logger/railtie' if defined?(Rails)
