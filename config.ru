require_relative 'lib/torb/web'
require 'rack-lineprof'

use Rack::Lineprof, profile: 'active_support/core_ext/string'
run Torb::Web
