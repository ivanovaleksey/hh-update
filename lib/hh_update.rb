require 'dotenv'
require 'faraday'
require 'slack-notifier'

Dotenv.load

require 'hh_update/api'
require 'hh_update/logger'
require 'hh_update/notifier'
require 'hh_update/script'
