#Calculator

##A basic non-scientific calculator

This gem allows you to make simple calculations.

    calc = Calculator.new
    calc.add("5").result # 5
    calc.subtract("2").result # 3
    calc.multiply_by("4").result # 12
    calc.divide_by("3").result # 4

##Short comings

###Use of `*` twice?

One of the restrictions of this code challenge was that I could only use the `*` operator/method once in the code, however, I had to use it to replace the `×` symbol. It is in reality a string, but not sure if it was against the rules.

    s.gsub!(/÷|\//, '.fdiv ')
    s.gsub!(/×/, '*')
---
    def multiply_by(n)  perform(:*, n)    end

###Undoing last operation

The requirements stated that

> The last operation can be undone

I wasn't sure how to go about undoing the last operation, so basically what I did was assign a temporary variable `@previous` and before the result was set I updated that variable with the last result set.
