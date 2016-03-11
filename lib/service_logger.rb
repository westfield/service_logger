require 'rails/railtie'
require 'service_logger/version'
require 'active_support/concern'
require 'lograge'

module ServiceLogger
  mattr_accessor :configuration, :application

  def self.configure
    self.configuration ||= service_logger_config
    yield service_logger_config
  end

  def self.setup(app)
    self.application = app

    Lograge.setup(app)
  end


  def self.service_logger_config
    application.config.service_logger
  end

  private
  def service_log(info, service_message, service_details, tag_name="none")
    logger.tagged(tag_name, "#{Time.now.utc}") do
      message = { service_name: info[:name], environment: info[:environment], service_message: service_message, service_details: service_details }
      logger.info(message.to_json)
    end
  end
end

require 'service_logger/railtie' if defined?(Rails)
