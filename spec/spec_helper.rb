require "git_timelog"
require "pry"
require "json"

RSpec.configure do |c|
  c.include(GitTimelog)
end