require 'logger'

module HHUpdate
  class Logger < Logger
  end
end

log_file = begin
  Module.const_get(ENV['LOG_FILE'])
rescue NameError
  ENV['LOG_FILE']
end
$logger = HHUpdate::Logger.new(log_file)
$logger.level = Module.const_get(['Logger', ENV['LOG_LEVEL']].join('::'))
