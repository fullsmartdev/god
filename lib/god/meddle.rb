module God
  
  class Meddle < Base
    # config
    attr_accessor :interval
    
    # api
    attr_accessor :watches
    
    # Create a new instance that is ready for use by a configuration file
    def initialize
      self.watches = []
    end
      
    # Instantiate a new, empty Watch object and pass it to the mandatory
    # block. The attributes of the watch must be set by the configuration
    # file.
    def watch
      w = Watch.new
      yield(w)
      @watches << w
    end
    
    def monitor
      threads = []
      @watches.each do |w|
        t = Thread.new do
          while true do
            if a = w.run
              w.action(a)
            end
            sleep self.interval
          end
        end
        t.join
        threads << t
      end
    end
  end
  
end