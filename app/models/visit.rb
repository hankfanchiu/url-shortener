class Visit < ActiveRecord::Base
  validates :visitor_id, :shortened_url_id, presence: true

  belongs_to :visitor,
    foreign_key: :visitor_id,
    primary_key: :id,
    class_name: "User"

  belongs_to :shortened_url,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: "ShortenedUrl"

  def self.record_visit!(visitor, shortened_url)
    create!(visitor_id: visitor.id, shortened_url_id: shortened_url.id)
  end
end
