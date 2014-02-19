# encoding: utf-8

require 'calculator/operators'
require 'calculator/integer'
require 'calculator/float'

class Calculator
  include Operators

  attr_accessor :result, :previous

  @@instances = []

  def initialize(result = 0)
    @result = result
    @@instances << self
  end

  alias_method :plus, :add
  alias_method :minus, :subtract

  def input(s = nil)
    self.result = if block_given?
      yield result
    else
      str = sanitize(s)
      starts_with_digit?(str) ? eval(str) : eval("#{result} #{str}")
    end
    self
  end

  def memory
    @memory ||= InMemoryCalculator.new
  end

  def get_memory(key = nil)
    return memory.result unless key
    memory.values[key.to_sym]
  end

  def store_in_memory(key = nil)
    return memory.result = result unless key
    memory.values[key] = result
  end

  def add_to_memory
    memory.add(result)
  end

  def subtract_from_memory
    memory.subtract(result)
  end

  def clear_memory(key = nil)
    return memory.result = nil unless key
    memory.values.delete(key)
  end

  def clear_all_memory
    memory.result = nil
    memory.values = {}
  end

  def clear
    self.result = previous
    self
  end

  def clear_all
    self.result = 0
  end

  def result=(n)
    @previous = @result
    @result = n ? (is_int?(n) ? n.to_i : n.to_f) : n
  end

  private

  def sanitize(s)
    s.gsub!(/÷|\//, '.fdiv ')
    s.gsub!(/×/, '*')
    s
  end

  def starts_with_digit?(str)
    str[0] =~ /\d/
  end

  def self.instances
    @@instances
  end

  def is_int?(n)
    n % 1 == 0
  end
end

class InMemoryCalculator < Calculator
  attr_accessor :values

  def initialize
    @values = {}
  end
end
