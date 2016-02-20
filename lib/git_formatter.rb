require "pry"
class GitFormatter
  def initialize(data)
    @data = data
  end

  def commit_array
    data = @data
    commit_array = []
    unless data.empty?
      commit_array = data.split(/git__title:/)
      commit_array.reject!(&:empty?)
    else
      []
    end
  end

  # TODO: Refactor
  def json_formatted
    commits = commit_array
    hash_array = []
    commits.each do |c|
      commit_hash = {}
      title = c[/.+?(?=git__description)/m]
      hours_logged = title[/(?<=\[)((\d*[.])?\d+)(?=\])/].to_f
      end_time = DateTime.parse(c[/(?<=git__date:)(.*)/])
      start_time = end_time - hours_logged/24.0

      commit_hash[:title] = title.gsub(/\[((\d*[.])?\d+)\]/, '')
      commit_hash[:description] = c[/(?<=git__description:)(.*)(?=git__date:)/m]
      commit_hash[:end_time] = end_time.to_s
      commit_hash[:start_time] = start_time.to_s
      hash_array.push(commit_hash)
    end
    hash_array.to_json
  end

  def to_clipboard
    
  end
end