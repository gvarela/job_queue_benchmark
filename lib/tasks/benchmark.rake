require 'benchmark'
namespace :benchmark do

  desc 'run with no queue'
  task :run_no_queue => :environment do
    puts "user     system      total        real"
    puts Benchmark.measure { 1000.times { Image.find_and_fetch_by_name rand(5000) } }
  end

  namespace :dj do
    desc 'run a dj benchmark based on already seeded data and queued jobs'
    task :run => :environment do
      puts "user     system      total        real"
      puts Benchmark.measure { Delayed::Job.work_off(1000) }
    end

    desc 'run a dj benchmark based on already seeded data and queued jobs'
    task :run_multiple => :environment do
      puts "user     system      total        real"
      number = 3
      number.times do
        fork do
          results = Benchmark.measure { Delayed::Job.work_off( 1000 / number) }
          print "#{Process.pid} => #{results}"
        end
      end
#    Process.wait 0
    end
  end

  namespace :resque do

    task :run do
      Rake::Task['resque:setup'].invoke rescue nil

      worker = Resque::Worker.new('*')
      worker.startup

      count = 0
      Benchmark.measure do
        while count <= 1000 do
          if worker.process
            count += 1
          else
            break
          end
        end
      end
      worker.unregister_worker
    end
  end

end