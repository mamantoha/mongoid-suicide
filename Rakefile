require "bundler/gem_tasks"

require "bundler"
Bundler.setup

require "rake"
require "rspec/core/rake_task"

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "mongoid/suicide/version"

task :gem => :build
task :build do
  system "gem build mongoid-suicide.gemspec"
end

task :install => :build do
  system "gem install mongoid-suicide-#{Mongoid::VERSION}.gem"
end

task :release => :build do
  system "git tag -a v#{Mongoid::Suicide::VERSION} -m 'Tagging #{Mongoid::Suicide::VERSION}'"
  system "git push --tags"
  system "gem push mongoid-#{Mongoid::Suicide::VERSION}.gem"
  system "rm mongoid-#{Mongoid::Suicide::VERSION}.gem"
end

RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

RSpec::Core::RakeTask.new('spec:progress') do |spec|
  spec.rspec_opts = %w(--format progress)
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
