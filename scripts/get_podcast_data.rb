#!/usr/bin/env ruby

require 'yaml'
require 'json'
require 'pry'
require 'feedjira'
require './scripts/convert_data'

class Podcast
  attr_reader :feed, :update_images

  def initialize(url, update_images)
    @feed = get_feed(url)
    @update_images = update_images
  end

  def as_yaml
    {
      'name' => feed.title,
      'url' => feed.url,
      'cover_path' => image
    }
  end

  def get_feed(url)
    puts "Fetching #{url}"
    Feedjira::Feed.fetch_and_parse(url)
  end

  def image
    path = "/podcasts/#{image_name}"
    url = feed.image.url.sub('0x', '250x')
    local_path = "./static#{path}"
    if !File.exist?(local_path) || update_images
      puts "\tGetting image"
      `wget #{url} -O #{local_path} --quiet`
    else
      puts "\tSkipping image"
    end
    path
  end

  def image_name
    name = parameterize(feed.title)
    extension = feed.image.url.split('.').last
    "#{name}.#{extension}"
  end

  def parameterize(string, sep = '-')
    # replace accented chars with their ascii equivalents
    parameterized_string = string.downcase
    # Turn unwanted chars into the separator
    parameterized_string.gsub!(/[^a-z0-9\-_]+/, sep)
    unless sep.nil? || sep.empty?
      re_sep = Regexp.escape(sep)
      # No more than one of the separator in a row.
      parameterized_string.gsub!(/#{re_sep}{2,}/, sep)
      # Remove leading/trailing separator.
      parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/, '')
    end
    parameterized_string.downcase
  end
end

UPDATE_IMAGES = false
FEEDS = %w[
  https://wasjetzt.podigee.io/feed/mp3
  http://istdasnormal.podigee.io/feed/mp3
  http://servusgruezihallo.podigee.io/feed/mp3
  http://zeit-wissen.podigee.io/feed/mp3
  http://frischandiearbeit.podigee.io/feed/mp3
  http://mikrodilettanten.podigee.io/feed/mp3
  http://frequenz-4000.podigee.io/feed/mp3
  http://elementarfragen.podigee.io/feed/mp3
  http://systemfehler.podigee.io/feed/mp3
  http://durch-die-gegend.podigee.io/feed/mp3
  http://kiezrekorder.podigee.io/feed/mp3
  http://podcastaef052.podigee.io/feed/mp3
  http://fuenfminutenberlin.podigee.io/feed/mp3
  http://gaestelistegeisterbahn.podigee.io/feed/mp3
  http://songpoeten.podigee.io/feed/mp3
  http://dunkleheimat.podigee.io/feed/mp3
  http://sz-das-thema.podigee.io/feed/mp3
  http://fumsgraetsch.podigee.io/feed/mp3
].freeze

podcasts = []
FEEDS.each do |feed|
  podcasts << Podcast.new(feed, UPDATE_IMAGES).as_yaml
end

File.open('./data/podcasts.yml', 'w') do |f|
  hash = { 'podcasts' => podcasts }
  f.write(hash.to_yaml)
end

Converter.new.convert
