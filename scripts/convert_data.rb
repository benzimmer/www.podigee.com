require 'yaml'
require 'json'
require 'pry'

class Converter

  def convert(type)
    unless %w(podcasts testimonials).include?(type)
      raise ArgumentError, "Unsupported type: #{type}"
    end
    data = YAML::load_file("data/#{type}.yml")

    File.open("content/api/#{type}.json", 'w') {|f| f.write(data.to_json)}
  end

end

Converter.new.convert(ARGV[0])
