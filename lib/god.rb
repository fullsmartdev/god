$:.unshift File.dirname(__FILE__)     # For use/testing when no gem is installed

require 'syslog'

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

$:.unshift File.join(File.dirname(__FILE__), *%w[.. ext god])

Syslog.open('god')

God::EventHandler.load

module God
  VERSION = '0.3.0'
    
  def self.meddle(options = {})  
    m = Meddle.new(options)
    
    # yeild to the config file
    yield m
    
    # start event handler system
    EventHandler.start if EventHandler.loaded?
    
    # start the timer system
    Timer.get

    # start monitoring
    m.monitor
    
    # join the timer thread so we don't exit
    Timer.get.join
  end  
end
