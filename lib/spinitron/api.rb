require "spinitron/api/version"
require "faraday"
require "happymapper"

class Track
  include HappyMapper

  element :title, String
  element :description, String
  element :date, Time, tag: 'pubDate'
end

class Channel
  include HappyMapper

  has_many :tracks, Track, tag: 'item'
end

module Spinitron
  module Api
    def self.request(station,show)
      connection = Faraday.new(:url => 'https://spinitron.com')
      connection.get('/radio/rss.php?station=wdrt&showid=689').body
    end

    ONE_DAY = 86400

    def self.playlist(station,show,date)
      date = Time.parse(date)
      channel = Channel.parse(request(station,show), single: true)
      channel.tracks.find_all do |track|
        (track.date - date).abs < ONE_DAY
      end
    end
  end
end

# Make web request to spinitron: https://spinitron.com/radio/rss.php?station=wdrt&showid=689
# `curl https://spinitron.com/radio/rss.php?station=wdrt&showid=689`


# Store that XML
# Process it to turn into items
# items from the same day
