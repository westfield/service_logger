require 'task_logger'

Rake::TaskManager.record_task_metadata = true
include TaskLogger

namespace :demo do
  desc "Test rake"
  task :test => :environment do |t, args|
    task_log(t, args) do
    end
  end

  desc "Test rake with exception"
  task :test_error => :environment do |t, args|
    task_log(t, args) do
      raise RuntimeError.new('Error Message')
    end
  end
end
