# TODO: should it be here?
require 'dotenv'
Dotenv.load

job_type :script, 'cd :path && :task :output'

set :path, Whenever.path
set :output, File.join(path, 'log/cron.log')
set :frequency, ENV['FREQUENCY'].to_i

every frequency.hours do
  # with rbenv it should be -c 'export PATH="$HOME/.rbenv/bin:$PATH"; eval "$(rbenv init -)"; ...'
  script 'bin/script'
end
