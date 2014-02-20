require 'delegate'

class Traversable < SimpleDelegator
  def traverse(*args, &block)
    args.inject(self) { |obj, arg|
      arg = Float(arg).to_i if obj.kind_of? Array
      obj.fetch(arg, &block)
    }
  end

  def class
    __getobj__.class
  end
end
