require_relative 'lib/torb/web'

require "clogger"
use Clogger,
    :format => '$request_time $request $query_string',
    :path => "./log/web/development.log",
    :reentrant => true
run Torb::Web
