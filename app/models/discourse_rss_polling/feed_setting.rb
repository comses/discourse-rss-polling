# frozen_string_literal: true

module DiscourseRssPolling
  class FeedSetting
    include ActiveModel::Serialization

    attr_accessor(
      :feed_url,
      :author_username,
      :author_username_embed_key,
    )

    def initialize(feed_url:, author_username:, author_username_embed_key:)
      @feed_url = feed_url
      @author_username = author_username
      @author_username_embed_key = author_username_embed_key
    end

    def poll(inline: false)
      if inline
        Jobs::DiscourseRssPolling::PollFeed.new.execute(feed_url: feed_url, author_username: author_username, author_username_embed_key: author_username_embed_key)
      else
        Jobs.enqueue('DiscourseRssPolling::PollFeed', feed_url: feed_url, author_username: author_username, author_username_embed_key: author_username_embed_key)
      end
    end
  end
end
