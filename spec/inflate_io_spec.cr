require "spec"
require "../src/zlib"

include Zlib

describe InflateIO do
  it "should be able to inflate" do
    io = StringIO.new
    "789c2bc9c82c5600a2448592d4e21285e292a2ccbc74054520e00200854f087b".scan(/../).each do |match|
      io.write_byte match[0].to_u8(16)
    end
    io.rewind

    inflate = InflateIO.new(io)

    str = String::Builder.build do |builder|
      IO.copy(inflate, builder)
    end

    str.should eq("this is a test string !!!!\n")
    inflate.read(Slice(UInt8).new(10)).should eq(0)
  end
end
