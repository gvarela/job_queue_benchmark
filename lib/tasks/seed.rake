namespace :seed do

  desc 'seed some image data for benchmark'
  task :images => :environment do
    5000.times do |i|
      Image.create(:name => "#{i}", :source_url => 'http://microsites.audiusa.com/ngw/09/images/sharedModelHomeTeasers/3teaser-Dealer.jpg')
    end
  end

  namespace :dj do

    desc 'seed some basic AR jobs'
    task :jobs_basic => :environment do
      500_000.times do |i|
        Image.send_later :find_by_name, rand( 5000 )
      end
    end

    desc 'seed some jobs that fetch and save images'
    task :jobs_fetch_and_save => :environment do
      500_000.times do |i|
        Image.send_later :find_and_fetch_by_name, rand( 5000 )
      end
    end

  end

  namespace :resque do
    
    desc 'seed some basic AR jobs'
    task :jobs_basic => :environment do
      500_000.times do |i|
        Image.async :find_by_name, rand( 5000 )
      end
    end

    desc 'seed some jobs that fetch and save images'
    task :jobs_fetch_and_save => :environment do
      500_000.times do |i|
        Image.async :find_and_fetch_by_name, rand( 5000 )
      end
    end
  end

end