module Nanoc3::Filters
  class Slim < Nanoc3::Filter
    identifier :slim
    type :text
    # Runs the content through [Slim](http://slim-lang.com/).
    # Parameters passed to this filter will be passed on to Haml.
    #
    # @param [String] content The content to filter
    #
    # @return [String] The filtered content
    def run(content, params={})
      require 'slim'

      # Get options
      options = params.merge(:filename => filename)

      # Create context
      context = ::Nanoc3::Context.new(assigns)

      ::Slim::Template.new { content }.render(context, assigns) { assigns[:content] }
    end

  end
end
