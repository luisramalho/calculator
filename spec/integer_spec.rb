describe Integer do
  describe "#add" do
    it "should add the values" do
      expect(4.add(4)).to eq 8
    end
  end

  describe "#subtract" do
    it "should subtract the values" do
      expect(8.subtract(2)).to eq 6
    end
  end

  describe "#multiply_by" do
    it "should multiply the values" do
      expect(4.multiply_by(3)).to eq 12
    end
  end

  describe "#divide_by" do
    it "should divide the values" do
      expect(10.divide_by(2)).to eq 5
      expect(10.divide_by(4)).to eq 2.5
    end
  end

  describe "#calculate_input" do
    it "should calculate the values" do
      expect(3.calculate_input("+3")).to eq 6
      expect(3.calculate_input("+3-2.2")).to eq 3.8
    end
  end

  describe "#calculate" do
    it "returns a new Calculator instance with the result already set" do
      expect(4.calculate.add(2).result).to eq 6
    end
  end
end
