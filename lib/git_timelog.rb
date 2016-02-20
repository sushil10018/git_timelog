require "git_timelog/version"
require "git_formatter"
require "json"

module GitTimelog
  # TODO: make the time changeable
  def git_timelog(from_time = '6am')
    `git log --pretty=format:"git__title:%sgit__description:%bgit__date:%cd" --author="#{current_author}" --since={#{from_time}} --reverse --all`
  end

  def current_author
    `git config user.name`
  end

  def json_format
    data = git_timelog
    gf = GitFormatter.new(data)
    gf.json_formatted.to_json
  end

  # list_style = 'ordered' || 'unordered'
  def to_clipboard(list_style = 'ordered')
    data = git_timelog
    gf = GitFormatter.new(data)
    `echo "#{gf.title_list(list_style)}" | pbcopy`
  end
end
