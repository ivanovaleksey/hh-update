require 'logger'

module HHUpdate
  class Logger < Logger
  end
end

$logger = HHUpdate::Logger.new(ENV['LOG_FILE'])
$logger.level = Module.const_get(['Logger', ENV['LOG_LEVEL']].join('::'))
