# encoding: UTF-8
require 'open3'
require 'debugger'
require './lib/flipit.rb'

describe Flipit do
  def pbpaste
    Open3.capture2('pbpaste')[0]
  end

  describe "run" do
    it "flips a table without any args" do
      flipit = Flipit::App.new ['-p']
      flipit.run
      flipit.result.should == "(╯°□°)╯︵ ┻━┻"
    end

    it "flips any text passed in" do
      flipit = Flipit::App.new ['-p', 'rails can\'t scale']
      flipit.run
      flipit.result.should == "(╯°□°)╯︵ ǝlɐɔs ʇ,uɐɔ slı̣ɐɹ"
    end

    it "flips any text passed in" do
      flipit = Flipit::App.new ['I hate bacon']
      flipit.run
      pbpaste.should == "(╯°□°)╯︵ uoɔɐq ǝʇɐɥ I"
    end
  end

  describe "private methods" do
    let(:flipit){Flipit::App.new ['-p']}
    it "#table returns the table characters" do
      flipit.send(:table).should == "┻━┻"
    end

    it "#flipper returns the \"flip guy\" " do
      flipit.send(:flipper).should == "(╯°□°)╯︵"
    end

    it "#flip returns flipped strings" do
      flipit.send(:flip, "hello").should == "ollǝɥ"
      flipit.send(:flip, "jello").should == "ollǝɾ"
      flipit.send(:flip, "great").should == "ʇɐǝɹƃ"
      flipit.send(:flip, "what?").should == "¿ʇɐɥʍ"
      flipit.send(:flip, "ruby's pretty cool.").should == "˙looɔ ʎʇʇǝɹd s,ʎqnɹ"
      flipit.send(:flip, "{lang:javascript};").should == "؛{ʇdı̣ɹɔsɐʌɐɾ:ƃuɐl}"
      flipit.send(:flip, "6_9").should == "6‾9"
    end
  end
end
