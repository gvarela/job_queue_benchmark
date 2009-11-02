namespace :seed do

  desc 'seed some image data for benchmark'
  task :images => :environment do
    5000.times do |i|
      Image.create(:name => "image number #{i}", :source_url => 'http://microsites.audiusa.com/ngw/09/images/sharedModelHomeTeasers/3teaser-Dealer.jpg')
    end
  end

end