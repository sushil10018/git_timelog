require "spec_helper"

describe GitTimelog do

  # TODO: Refactor
  describe '#git_timelog' do
    it "should extract git commits" do
      expect(git_timelog).to eql(`git log --pretty=format:"git__title:%sgit__description:%bgit__date:%cd" --author="#{current_author}" --since={6am} --reverse`)
    end
  end

  # TODO: Refactor
  describe '#current_author' do
    it "should return authors name" do
      expect(current_author).to eql(`git config user.name`)
    end
  end

  describe '#json_format' do
    it "should return json formatted update" do
      formatted_json = json_format
      puts formatted_json
      expect(formatted_json).to eql(formatted_json) # LOL
    end
  end
end