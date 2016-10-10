require 'spec_helper'

RSpec.describe "TaskLogger" do
  Dummy::Application.load_tasks

  let(:time) { Time.now }

  before do
    allow(Time).to receive(:now).and_return(time)
  end

  context 'without error' do
    it 'logs information about the rake task' do
      log_message = {
        service_name: "Dummy::Application",
        environment: { name: "test" },
        version: ServiceLogger::VERSION,
        event: "RAKE_TASK",
        event_details: {
          task_name: "demo:test",
          arguments: ["some args"],
          starts_at: time.to_s(:iso8601),
          ends_at: time.to_s(:iso8601),
          duration: 0.0,
          errors: nil
        }
      }.to_json

      expect_any_instance_of(ActiveSupport::Logger).to receive(:info).with(log_message)

      Rake::Task["demo:test"].invoke('some args')
    end
  end

  context 'with error' do
    it 'logs information about the rake task with error information' do
      log_message = {
        service_name: "Dummy::Application",
        environment: { name: "test" },
        version: ServiceLogger::VERSION,
        event: "RAKE_TASK",
        event_details: {
          task_name: "demo:test_error",
          arguments: ["some args"],
          starts_at: time.to_s(:iso8601),
          ends_at: time.to_s(:iso8601),
          duration: 0.0,
          errors: { message: 'Error Message', error_type: 'RuntimeError'}
        }
      }.to_json

      expect_any_instance_of(ActiveSupport::Logger).to receive(:info).with(log_message)

      Rake::Task["demo:test_error"].invoke('some args')
    end
  end
end
