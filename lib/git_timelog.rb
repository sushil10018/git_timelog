require "git_timelog/version"
require "git_formatter"
require "json"
require "pry"

module GitTimelog
  # TODO: make the time changeable

  def user_input
    options = {}
    option_parse = OptionParser.new do |option|
        option.banner = "Usage: opt_parser COMMAND [OPTIONS]"
        option.on("-s n", "--since=n", "since") do |v|
            options[:since] = v
            git_timelog(options[:since])
          option.on("-h","--help","help") do 
            puts opt_parser
          end    
        end
    end
    begin option_parse.parse! ARGV
    rescue OptionParser::ParseError => e
      puts e 
      puts "Type -h or --help for help"
    end   
  end

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
