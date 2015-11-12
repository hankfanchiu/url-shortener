class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :submitter_id, presence: true

  validates :short_url, uniqueness: true

  validates_length_of :long_url, maximum: 255, allow_blank: false

  validate :too_many_recent_submissions

  belongs_to :submitter,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: "User"

  has_many :visits,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: "Visit"

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor

  has_many :taggings,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: "Tagging"

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic

  def self.random_code
    random_code = SecureRandom.urlsafe_base64
    while exists?(short_url: random_code)
      random_code = SecureRandom.urlsafe_base64
    end

    random_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    options = {
      submitter_id: user.id,
      long_url: long_url,
      short_url: random_code
    }

    create!(options)
  end

  def self.prune(n)
    distinct_url_ids = Visit.select(:shortened_url_id).distinct
    expired_url_ids = distinct_url_ids.where('created_at < ?', n.minutes.ago)

    expired_url_ids.each do |hash|
      expired_url_id = hash[:shortened_url_id]
      destroy(expired_url_id)
    end
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    unique_visitors = visits.select(:visitor_id).distinct
    recent_visits = unique_visitors.where('created_at > ?', 10.minutes.ago)
    recent_visits.count
  end

  private
  def recent_submission_count
    submissions = self.class.where(submitter_id: submitter_id)
    recent_submissions = submissions.where('created_at > ?', 1.minutes.ago)
    recent_submissions.count
  end

  def too_many_recent_submissions
    if recent_submission_count >= 5
      errors[:oversubmissions] << "too many submissions in the last minute!"
    end
  end
end
