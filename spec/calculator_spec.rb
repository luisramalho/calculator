# encoding: utf-8

require 'spec_helper'

describe Calculator do

  context "Class" do
    it "should keep track of all instances" do
      Calculator.class_variable_set :@@instances, []
      calc1 = Calculator.new
      calc2 = Calculator.new
      expect(Calculator.instances).to eq [calc1, calc2]
    end
  end

  describe "Alias" do
    subject(:calculator) { Calculator.new }

    context "#plus" do
      it "is an alias for #add" do
        calculator.plus(4)
        expect(calculator.result).to eq 4
      end
    end

    context "#minus" do
      it "is an alias for #subtract" do
        calculator.minus(4)
        expect(calculator.result).to eq -4
      end
    end

  end

  describe "Memory" do
    subject(:calculator) { Calculator.new }

    it "returns nil if there is nothing stored in memory" do
      expect(calculator.get_memory).to eq nil
    end

    it "stores the current result in memory" do
      calculator.result = 10
      calculator.store_in_memory
      expect(calculator.get_memory).to eq 10
    end

    it 'performs operations on memory' do
      calculator.result = 10
      calculator.store_in_memory
      calculator.memory.add(10)
      calculator.memory.subtract(2)
      calculator.memory.multiply_by(3)
      calculator.memory.divide_by(2)
      expect(calculator.get_memory).to eq 27
    end

    it "adds the current result to memory" do
      calculator.result = 10
      calculator.store_in_memory
      calculator.memory.divide_by(2)
      calculator.result = 2
      calculator.add_to_memory
      expect(calculator.get_memory).to eql 7
    end

    it "subtracts the current result from memory" do
      calculator.result = 29
      calculator.store_in_memory
      calculator.result = 2
      calculator.subtract_from_memory
      expect(calculator.get_memory).to eq 27
    end

    context "namespace memory values" do
      before(:each) do
        calculator.result = 3
        calculator.store_in_memory
        calculator.result = 4
        calculator.store_in_memory :a
        calculator.result = 5
        calculator.store_in_memory :b
        calculator.result = 6
        calculator.store_in_memory :c
      end

      it "allows namespace memory values distinct from the default for all of the above memory methods" do
        expect(calculator.get_memory).to eq 3
        expect(calculator.get_memory :a).to eq 4
        expect(calculator.get_memory :b).to eq 5
        expect(calculator.get_memory 'c').to eq 6
      end

      it "can clear specific memories" do
        calculator.clear_memory
        calculator.clear_memory :a
        expect(calculator.get_memory).to eq nil
        expect(calculator.get_memory :a).to eq nil
        expect(calculator.get_memory :b).to eq 5
        expect(calculator.get_memory 'c').to eq 6
      end

      it "can clear all memory" do
        calculator.clear_memory
        calculator.clear_memory :a
        expect(calculator.get_memory).to eq nil
        expect(calculator.get_memory :a).to eq nil
        expect(calculator.get_memory :b).to eq 5
        expect(calculator.get_memory 'c').to eq 6
        calculator.clear_all_memory
        expect(calculator.get_memory :b).to eq nil
        expect(calculator.get_memory :c).to eq nil
      end
    end
  end

  describe "Operations" do
    subject(:calculator) { Calculator.new }

    it "can be chained" do
      expect(calculator.input("1+1").input("- 6").result).to eq -4
      expect(calculator.add(7).subtract(2).result).to eq 1
    end

    it "last operation can be undone" do
      expect(calculator.add(4).result).to eq 4
      expect(calculator.add(4).result).to eq 8
      expect(calculator.add(5).result).to eq 13
      expect(calculator.clear.result).to eq 8
    end
  end

  describe "#input" do
    subject(:calculator) { Calculator.new }

    it "interprets an indefinatly long string of operations" do
      expect(calculator.input("1+1").result).to eq 2
      expect(calculator.input("3 - 1").result).to eq 2
      expect(calculator.input("6 ÷ 5").result).to eq 1.2
      expect(calculator.input("6 / 5").result).to eq 1.2
      expect(calculator.input("3 + 4 * 2").result).to eq 11 # !14
      expect(calculator.input("3 + 4 × 2").result).to eq 11 # !14
      expect(calculator.input("1 - 1+1").result).to eq 1  # !0
    end

    it "can also take a block for custom operations" do
      calculator.result = 3
      calculator.input do |x|
        x**2
      end
      expect(calculator.result).to eq 9
    end
  end

  describe "#result" do
    it "is assumed to be 0" do
      expect(Calculator.new.result).to eq 0
    end

    it "can be set at initiation" do
      expect(Calculator.new(13).result).to eq 13
    end

    it "should be returned as integer if it is a whole number otherwise a float" do
      calculator = Calculator.new
      calculator.result = 5.0
      expect(calculator.result).to eq 5
      calculator.divide_by 2
      expect(calculator.result).to eq 2.5
    end

    context "current result" do
      subject(:calculator) { Calculator.new }

      it "can be set" do
        calculator.result = 10
        expect(calculator.result).to eq 10
      end

      it "can be reset" do
        calculator.result = 10
        calculator.clear_all
        expect(calculator.result).to eq 0
      end

      it "can be added to" do
        expect(calculator.add("5").result).to eq 5
        expect(calculator.add("5.3").result).to be_within(1.0e-05).of(10.3)
      end

      it "can be subtracted from" do
        calculator.result = 5
        expect(calculator.subtract("2").result).to eq 3
        expect(calculator.subtract("2.9").result).to be_within(1.0e-05).of(0.1)
      end

      it "can be multiplied by" do
        calculator.result = 3
        expect(calculator.multiply_by("4").result).to eq 12
        expect(calculator.multiply_by("0.1").result).to be_within(1.0e-05).of(1.2)
      end

      it "can be divided by" do
        calculator.result = 12
        expect(calculator.divide_by("3").result).to eq 4
        expect(calculator.divide_by("2.5").result).to be_within(1.0e-05).of(1.6)
      end

      it "is held" do
        calculator.input("1+1")
        calculator.input("- 6")
        calculator.multiply_by(3)
        expect(calculator.result).to eq -12
      end
    end
  end

end