require 'nanoc3/tasks'
require 'fileutils'

desc 'Creates a new blog posts, and opens it on Textmate'
task :p, :title, :link do |t, args|
  path = "./content/blog/#{Time.now.strftime('%Y')}/#{Time.now.strftime('%m')}"
  filename = "#{args[:title].gsub(/\s+/, "-").downcase}.md"
  filename_path = File.join(path, filename)

  yaml_header = {
    "kind" => "article",
    "created_at" => DateTime.now.strftime("%m/%d/%Y %H:%M"),
    "title" => args[:title]
  }
  yaml_header["external_link"] = args[:link] if args[:link]

  FileUtils.mkdir_p path
  File.open filename_path, 'w' do |f|
    f.write [yaml_header.to_yaml, "---"].join
  end

  `mate #{filename_path}`
end
