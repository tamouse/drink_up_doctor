$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'drink_up_doctor'

require 'minitest/autorun'
require "tempfile"
require "tmpdir"

def run_in_tmpdir
  raise "no block given" unless block_given?
  Dir.mktmpdir do |tmpdir|
    Dir.chdir tmpdir do |dir|

      yield dir

    end
  end
end
