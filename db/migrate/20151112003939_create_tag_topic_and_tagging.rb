class CreateTagTopicAndTagging < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :topic, null: false

      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :tag_topic_id, null: false
      t.integer :shortened_url_id, null: false

      t.timestamps
    end

    add_index(:tag_topics, :topic, unique: true)
  end
end
