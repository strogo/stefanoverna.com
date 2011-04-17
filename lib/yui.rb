module Nanoc3::Filters
  class YUI < Nanoc3::Filter
    identifier :yui

    type :text
    def run(content, params={})
      require "yui/compressor"
      compressor = ::YUI::JavaScriptCompressor.new(:munge => true)
      compressor.compress(content)
    end

  end
end

