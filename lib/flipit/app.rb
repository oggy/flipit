# -*- coding: utf-8 -*-
require 'optparse'
require 'open3'

module Flipit
  class App
    def initialize(args, output=STDOUT, error=STDERR)
      @args = args
      @output = output
      @error = error
      @print = false

      parser = OptionParser.new do |parser|
        parser.banner = "USAGE: flipit [options] [text ...]"
        parser.separator ''
        parser.separator 'Options:'
        parser.on '-p', '--print' do
          @print = true
        end
      end
      parser.parse!(args)
    end

    attr_reader :args

    def run
      if args.empty?
        flipped = "#{flipper} #{table}"
      elsif
        text = args.join(' ')
        flipped = "#{flipper} #{flip(text)}"
      end
      if @print
        @output.puts flipped
      else
        pbcopy(flipped)
      end
      0
    end

    def pbcopy(string)
      Open3.popen2('pbcopy') do |stdin, stdout, wait_thread|
        stdin.print string
      end
    end

    private

    def flipper
      "(╯°□°)╯︵"
    end

    def table
      "┻━┻"
    end

    def flip(text)
      text.chars.map { |c| CHARS[c] || c }.reverse.join
    end

    CHARS = {
      'a' => 'ɐ',
      'b' => 'q',
      'c' => 'ɔ',
      'd' => 'p',
      'e' => 'ǝ',
      'f' => 'ɟ',
      'g' => 'b',
      'h' => 'ɥ',
      'i' => 'ı̣',
      'j' => 'ظ',
      'k' => 'ʞ',
      'l' => 'ן',
      'm' => 'ɯ',
      'n' => 'u',
      'o' => 'o',
      'p' => 'd',
      'q' => 'b',
      'r' => 'ɹ',
      's' => 's',
      't' => 'ʇ',
      'u' => 'n',
      'v' => 'ʌ',
      'w' => 'ʍ',
      'x' => 'x',
      'y' => 'ʎ',
      'z' => 'z',
      '[' => ']',
      ']' => '[',
      '(' => ')',
      ')' => '(',
      '{' => '}',
      '}' => '{',
      '?' => '¿',
      '\u00BF' => '?',
      '!' => '¡',
      "\'" => ',',
      ',' => "\'",
      '.' => '˙',
      '_' => '‾',
      ';' => '؛',
      '9' => '6',
      '6' => '9',
    }
  end
end
