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

    task :run => :environment do
      Rake::Task['resque:setup'].invoke rescue nil

      worker = Resque::Worker.new('*')
      worker.startup

      count = 0
      t0, r0 = Benchmark.times, Time.now

      while count <= 1000 do
        worker.process
        count += 1
      end

      t1, r1 = Benchmark.times, Time.now
      puts Benchmark::Tms.new(t1.utime - t0.utime,
                              t1.stime - t0.stime,
                              t1.cutime - t0.cutime,
                              t1.cstime - t0.cstime,
                              r1.to_f - r0.to_f,
                              '')

      worker.unregister_worker
    end

    task :run_multiple => :environment do
      Rake::Task['resque:setup'].invoke rescue nil

      number = 3
      number.times do
        fork do

          worker = Resque::Worker.new('*')
          worker.startup

          count = 0
          t0, r0 = Benchmark.times, Time.now

          while count <= 1000 / number do
            worker.process
            count += 1
          end

          t1, r1 = Benchmark.times, Time.now
          puts Benchmark::Tms.new(t1.utime - t0.utime,
                                  t1.stime - t0.stime,
                                  t1.cutime - t0.cutime,
                                  t1.cstime - t0.cstime,
                                  r1.to_f - r0.to_f,
                                  '')
          worker.unregister_worker
          
        end
      end


    end
  end

end