require "spec_helper"

describe "git_timelog" do
  it "should extract git commits" do
    expect(git_timelog).to eql("Hello")
  end
end