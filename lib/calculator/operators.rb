module Operators
  def add(n)          perform(:+, n)    end
  def subtract(n)     perform(:-, n)    end
  def multiply_by(n)  perform(:*, n)    end
  def divide_by(n)    perform(:fdiv, n) end

  def calculate_input(n)
    eval("#{self} #{n}")
  end

  def calculate
    Calculator.new self
  end

  private

  def perform(s, n)
    return transmit(self, s, n) unless respond_to?(:result)
    self.result = transmit(result, s, n.to_f)
    self
  end

  def transmit(o, s, n)
    o.send(s, n)
  end
end
