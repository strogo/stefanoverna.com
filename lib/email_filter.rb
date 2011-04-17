require 'nokogiri'

module Nanoc3
  module Filters
    class EmailFilter < Nanoc3::Filter
      identifier :email_filter
      type :text

      def run(content, params = {})
        require 'base64'
        html = Nokogiri::HTML.fragment(content)

        html.css("a[href^=mailto]").each do |link|
          mail = link["href"].gsub("mailto:", "")
          link["data-mail-local-part"] = mail.split("@").first.reverse
          link["data-mail-domain"] = mail.split("@").last.reverse
          link["href"] = "#"
        end

        html.to_s
      end
    end
  end
end