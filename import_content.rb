require 'pry'
require 'yaml'
require 'active_support/inflector'

class Import
  attr_reader :filename

  def initialize(filename)
    @filename = filename
    @yaml = read_yaml
  end

  def testimonials
    new_yaml = @yaml.map do |entry|
      url = entry[:podcast_cover]
      ext = url.split('.').last
      podcast_name = entry[:podcast_name].parameterize
      cover_path = "/testimonials/#{podcast_name}.#{ext}"
      `curl #{url} > static#{cover_path}`
      entry[:cover_path] = cover_path
      entry
    end

    write_yaml(new_yaml)
  end

  def podcasts
    new_yaml = @yaml.map do |entry|
      url = entry[:cover]
      ext = url.split('.').last
      podcast_name = entry[:name].parameterize
      cover_path = "/podcasts/#{podcast_name}.#{ext}"
      `curl #{url} > static#{cover_path}`
      entry[:cover_path] = cover_path
      entry
    end

    write_yaml(new_yaml)
  end

  def read_yaml
    YAML.load_file(filename)
  end

  def write_yaml(yaml)
    File.open(filename, 'w') {|f| f.write(yaml.to_yaml)}
  end
end

Import.new(ARGV[0]).send ARGV[1]
