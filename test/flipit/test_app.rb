# -*- coding: utf-8 -*-
require_relative '../test_helper'

require 'stringio'

describe Flipit::App do
  let(:output) { StringIO.new }
  let(:error) { StringIO.new }

  describe "when no arguments are given" do
    it "flips a table" do
      app = Flipit::App.new(['-p'], output, error)
      app.run.must_equal 0
      output.string.must_equal "(╯°□°）╯︵ ┻━┻\n"
      error.string.must_equal ""
    end
  end

  describe "when arguments are given" do
    it "flips them" do
      app = Flipit::App.new(['-p', 'my', 'life'], output, error)
      app.run.must_equal 0
      output.string.must_equal "(╯°□°）╯︵ ǝɟı̣ן ʎɯ\n"
      error.string.must_equal ""
    end
  end
end
