require 'benchmark'
namespace :benchmark do

  desc 'run a dj benchmark based on already seeded data and queued jobs'  
  task :run => :environment do
    puts "user     system      total        real"
    puts Benchmark.measure { Delayed::Job.work_off(1000) }
  end

end