require_relative '../../app/models/shortened_url'
require_relative '../../app/models/visit'

namespace :cleanup do
  desc "Deletes unvisited URLs every 60 minutes"
  task :prune_urls do
    puts "Pruning old URLs..."
    ShortenedUrl.prune(60)
    puts "Old URLs pruned!"
  end
end
