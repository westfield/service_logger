module TaskLogger
  include ServiceLogger

  def task_log(task, args)
    begin
      start_time = Time.now
      errors = nil

      yield

    rescue => e
      errors = { message: e.message, error_type: e.class.to_s }
    ensure
      end_time = Time.now
      duration = end_time - start_time

      service_log(
        'RAKE_TASK',
        {
          task_name: task.name,
          arguments: args,
          starts_at: start_time.to_s(:iso8601),
          ends_at: end_time.to_s(:iso8601),
          duration: duration,
          errors: errors
        }
      )
    end
  end

  module_function :task_log
end
