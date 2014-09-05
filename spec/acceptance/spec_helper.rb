require File.expand_path("../spec_helper", File.dirname(__FILE__))

$LOAD_PATH << File.dirname(__FILE__)
require 'acceptance_jobs'

RSpec.configure do |c|
  c.before(:all) do
    puts '---------- Starting Resque Worker ----------'
    system 'BACKGROUND=yes PIDFILE=resque.pid QUEUE=* NAMESPACE=resque-multi-step-task-testing INTERVAL=0.5 rake resque:work'
    sleep 3
  end

  c.after(:all) do
    sleep 1
    puts '---------- Stopping Resque Worker ----------'
    pid = File.read('resque.pid').to_i
    File.delete('resque.pid')
    Process.kill('TERM', pid)
  end
end
