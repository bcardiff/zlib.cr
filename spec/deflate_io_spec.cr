require "spec"
require "../src/zlib"

include Zlib

describe ZStream do
  it "should be able to deflate" do
    deflate = DeflateIO.new(StringIO.new("this is a test string !!!!\n"))
    slice = Slice(UInt8).new(60)
    read = deflate.read(slice)

    slice[0, read.to_i32].hexstring.should eq("789c2bc9c82c5600a2448592d4e21285e292a2ccbc74054520e00200854f087b")
    deflate.read(slice).should eq(0)
  end
end