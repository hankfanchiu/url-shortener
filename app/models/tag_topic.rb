class TagTopic < ActiveRecord::Base
  validates :topic, presence: true, uniqueness: true

  has_many :taggings,
    foreign_key: :tag_topic_id,
    primary_key: :id,
    class_name: "Tagging"

  has_many :short_urls,
    through: :taggings,
    source: :short_url
end
