# -*- encoding: utf-8 -*-

require 'rubygems'

$LOAD_PATH << File.dirname(__FILE__)
require 'app_store_review'
require 'google_play_review'

class AppReview

  def initialize
    super
  end

  def fetch
    Apps.all.each do |app|
      n = (Reviews.filter(:app_id => app[:app_id]).count==0)?10:2
      fetch_reviews(app[:app_id].to_s, n)
    end
  end

  def fetch_reviews(app_id, pages)
    if is_app_store_app(app_id)
      task = AppStoreReview.new
    else
      task = GooglePlayReview.new
    end
    task.fetch_reviews(app_id, pages)
  end

  def is_app_store_app(id)
    return (/\A\d+\Z/ =~ id) ? true : false
  end

end
