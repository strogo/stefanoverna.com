require 'nokogiri'

module Nanoc3
  module Filters
    # A nanoc filter which pre-processes code elements for special tags.
    #
    # For example:
    #
    #     [@language="ruby"]
    #     [@caption="lorem ipsum"]
    class CodeClassifier < Nanoc3::Filter
      identifier :code_classifier
      type :text

      def run(content, params = {})
        params = {
          :caption => {},
          :pre     => {}
        }.update(params)

        html = Nokogiri::HTML.fragment(content)

        html.xpath("pre/code").each do |code|
          pre = code.parent

          # Set the class on the <pre>.
          append_class(pre, params[:pre_class]) if params[:pre_class]

          process_language_tag(code, params)
          process_caption_tag(code, params[:caption])
        end

        html.to_s
      end

    private

      def process_language_tag(element, params)
        match = element.content.match /\[\s*@language\s*=\s*"([^"]+)"\s*\]/
        if match
          append_class(element, "language-#{match[1]}")
          element.content = element.content.gsub /\[\s*@language\s*=\s*"([^"]+)"\s*\]/, ''
        end
      end

      def process_caption_tag(element, params)
        params = {
          :position => :top
        }.update(params)

        element.content = element.content.sub(/\[\s*@caption\s*=\s*"([^"]+)"\s*\]/) do
          # Wrap in a <figure>.
          figure = Nokogiri::XML::Node.new("figure", element.document)
          element.parent.add_next_sibling(figure)
          element.parent.parent = figure

          # Add a <figcaption>.
          figcaption = Nokogiri::XML::Node.new("figcaption", element.document)
          figcaption.content = $1

          position = params[:position].to_sym

          if position == :top
            element.parent.add_previous_sibling(figcaption)
          elsif position == :bottom
            element.parent.add_next_sibling(figcaption)
          else
            raise "Unknown position: #{position}"
          end

          nil
        end.strip!
      end

      def append_class(element, klass)
        element["class"] = ((element["class"] || "") + " " + klass).strip
      end
    end
  end
end