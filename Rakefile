require 'rake'
require 'rspec/core/rake_task'

namespace :test do
  desc "Test for refactoring exercise #1: 'magic_numbers'"
  RSpec::Core::RakeTask.new(:magic) do |t|
    t.pattern = Dir.glob('exercises/01_magic_squares/spec/*_spec.rb')
    t.rspec_opts = ['--format nested', '-c']
  end
end