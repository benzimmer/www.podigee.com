#!/usr/bin/env ruby

require 'yaml'
require 'json'
require 'pry'

class Converter
  def convert
    %w[podcasts testimonials].each do |type|
      data = YAML.load_file("data/#{type}.yml")

      File.open("content/content-api/#{type}.json", 'w') { |f| f.write(data.to_json) }
    end
  end
end

Converter.new.convert
