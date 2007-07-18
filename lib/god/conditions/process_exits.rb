module God
  module Conditions
    
    class ProcessExits < EventCondition
      attr_accessor :pid_file
      
      def valid?
        valid = true
        valid &= complain("You must specify the 'pid_file' attribute for :process_exits") if self.pid_file.nil?
        valid
      end
    
      def register
        pid = File.open(self.pid_file).read.strip.to_i
        
        EventHandler.register(pid, :proc_exit) {
          Hub.trigger(self)
        }
      end
      
      def deregister
        pid = File.open(self.pid_file).read.strip.to_i
        EventHandler.deregister(pid, :proc_exit)
      end
    end
    
  end
end