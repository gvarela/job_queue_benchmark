module ResqueAsync

  def self.included(base)
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def async(method, *args)
      Resque.enqueue(self.class, id, method, *args)
    end
  end

  module ClassMethods
    
    def queue
      :normal
    end

    # This will be called by a worker when a job needs to be processed
    def perform(id, method, *args)
      (id.nil? ? self : find(id)).send(method, *args)
    end

    # We can pass this any Repository instance method that we want to
    # run later.
    def async(method, *args)
      Resque.enqueue(self, nil, method, *args)
    end
  end
 end