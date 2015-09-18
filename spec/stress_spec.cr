require "spec"
require "../src/zlib"

include Zlib

describe Zlib do
  it "inflate deflate should be inverse with file" do
    filename = "#{__DIR__}/../src/lib_zlib.cr"
    file = File.new(filename)

    expected = file.read
    file = File.new(filename)
    # file.rewind
    actual = InflateIO.new(DeflateIO.new(file)).read
    expected.should eq(actual)
  end

  it "inflate deflate should be inverse with random string" do
    expected = String.build do |io|
      1_000_000.times { rand(2000).to_i.to_s(32, io) }
    end
    actual = InflateIO.new(DeflateIO.new(StringIO.new(expected))).read
    expected.should eq(actual)
  end
end
