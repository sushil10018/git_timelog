require "git_timelog/version"
require "git_formatter"

module GitTimelog
  def git_timelog
    `git log --pretty=format:"git__title:%sgit__description:%bgit__date:%cd" --author="#{current_author}" --since={6am} --reverse`
  end

  def current_author
    `git config user.name`
  end

  def json_format
    data = git_timelog
    gf = GitFormatter.new(data)
    gf.json_formatted
  end
end
