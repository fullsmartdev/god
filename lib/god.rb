$:.unshift File.dirname(__FILE__)     # For use/testing when no gem is installed
$:.unshift File.join(File.dirname(__FILE__), *%w[.. ext kqueue_handler])

# internal requires
require 'god/base'
require 'god/errors'

require 'god/system/process'

require 'god/behavior'
require 'god/behaviors/clean_pid_file'

require 'god/condition'
require 'god/conditions/timeline'
require 'god/conditions/process_running'
require 'god/conditions/process_exits'
require 'god/conditions/memory_usage'
require 'god/conditions/cpu_usage'
require 'god/conditions/always'

require 'god/reporter'
require 'god/server'
require 'god/timer'
require 'god/hub'

require 'god/metric'

require 'god/watch'
require 'god/meddle'

require 'god/event_handler'

module God
  VERSION = '0.1.0'
  
  case RUBY_PLATFORM
  when /darwin/i, /bsd/i
    require 'kqueue_handler'
    EventHandler.handler = KQueueHandler
  else
    raise NotImplementedError, "Platform not supported for EventHandler"
  end
  
  def self.meddle(options = {})
    m = Meddle.new(options)
    yield m
    m.monitor
    Timer.get.join
  end  
end
