include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Rendering

module MyHelper
  def sorted_articles_by_day(page_index, per_page)

    articles = sorted_articles.slice(page_index*per_page, per_page)

    grouped = articles.group_by do |article|
      date = article.attributes[:created_at].getlocal
      Time.local(date.year, date.month, date.day)
    end

    grouped.keys.sort.reverse.each do |date|
      yield date, grouped[date].sort_by { |article| article.attributes[:created_at] }.reverse
    end

  end
end

include MyHelper