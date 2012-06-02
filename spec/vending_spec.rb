# -*- encoding: utf-8 -*-
require "rubygems"
require "rspec"
require "./vending"

describe Vending do
  before do
    @vending = Vending.new
  end
  subject { @vending }

  context '何も入れていないとき' do
    its(:show) { should == 0 }
  end

  context '5円を入れたとき' do
    before do
      @change = @vending.enter([5])
    end
    it { @change.should == [5] }
    its(:show) { should == 0 }
  end

  describe "Enterのとき" do
    it "金額を受け付ける" do
      vending = Vending.new
      vending.enter([]).should be == []
      vending.enter([1]).should be == [1]
      vending.enter([5]).should be == [5]
      vending.enter([5, 5, 5]).should be == [5, 5, 5]
      vending.enter([1000]).should be == []
      vending.enter([10, 50, 100, 500, 1000]).should be == []
      vending.enter([1, 5, 10, 50, 100, 500, 1000]).should be == [1, 5]
    end
  end

  describe "払い戻し" do
    it "合計金額が戻ってくる" do
      vending = Vending.new
      vending.enter([10, 5, 5, 5])
      vending.enter([10, 5, 100])
      vending.cancel.should be == 120
      vending.show.should be == 0
    end
  end

  describe "投入金額に注目" do
    before do
      @vending = Vending.new
      @change = @vending.enter(input)
    end
    subject { @vending }

    describe '最初は' do
      let(:input) { [] }
      its(:show) { should == 0 }
      its(:stock) { should == [120, "Cola", 5] }
      its(:cancel) { should == 0 }
    end

    describe "投入金額増えるかな" do
      context "だめな硬貨だけのとき" do
        let(:input) { [1,5,2000] }
	it { @change.should == [1,5,2000] }
	its(:show) { should == 0 }
      end
      context "受け入れる硬貨があるとき" do
        let(:input) { [1000] }
	it { @change.should == [] }
	its(:show) { should == 1000 }
      end
    end

    context "投入金額が0のとき" do
      let(:input) { [] }
      its(:juice_menu) { should be == [] }
    end

    context "投入金額が120より少ない時" do
      let(:input) { [10] }
      its(:juice_menu) { should be == [] }
    end

    context "投入金額が120" do
      let(:input) { [10, 10, 100] }
      its(:juice_menu) { should be == [[120, "Cola"]] }
    end

    context "投入金額が120より多い" do
      let(:input) { [10, 100, 100] }
      its(:juice_menu) { should be == [[120, "Cola"]] }
    end

    context "投入金額が0より多く払い戻すとき" do
      let(:input) { [10, 100] }
      its(:cancel) { should be == 110 }
    end
  end

end
