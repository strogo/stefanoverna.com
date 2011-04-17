require 'nanoc3/tasks'
require 'fileutils'

desc 'Creates a new blog posts, and opens it on Textmate'
task :p do |t|

  puts "Titolo:"
  title = STDIN.gets.chomp

  puts "Link:"
  link = STDIN.gets.chomp

  path = "./content/blog/#{Time.now.strftime('%Y')}/#{Time.now.strftime('%m')}"
  filename = "#{title.gsub(/\W+/, "-").downcase}.md"
  filename_path = File.join(path, filename)

  yaml_header = {
    "kind" => "article",
    "created_at" => DateTime.now.strftime("%m/%d/%Y %H:%M"),
    "title" => title
  }
  yaml_header["external_link"] = link unless link.empty?

  FileUtils.mkdir_p path
  File.open filename_path, 'w' do |f|
    f.write [yaml_header.to_yaml, "---"].join
  end

  `mate #{filename_path}`
end
