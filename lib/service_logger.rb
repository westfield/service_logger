require 'service_logger/version'
require 'active_support/concern'

module ServiceLogger
  extend ActiveSupport::Concern
  included do
    private

    def service_log(info, service_message, service_details, tag_name="none")
      logger.tagged(tag_name, "#{Time.now.utc}") do
        message = { service_name: info[:name], environment: info[:environment], service_message: service_message, service_details: service_details }
        logger.info(message.to_json)
      end
    end
  end
end
