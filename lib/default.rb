include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Rendering

module MyHelper
  def sorted_articles_by_day(page_index, per_page)

    articles = sorted_articles.slice(page_index*per_page, per_page)

    grouped = articles.group_by do |article|
      date = article.attributes[:created_at]
      date = DateTime.parse(date)
      DateTime.new(date.year, date.month, date.day)
    end

    grouped.keys.sort.reverse.each do |date|
      yield date, grouped[date].sort_by { |article| DateTime.parse(article.attributes[:created_at]) }
    end

  end
end

include MyHelper