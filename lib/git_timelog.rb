require "git_timelog/version"
require "git_formatter"
require "json"
require "pry"

module GitTimelog
  # TODO: make the time changeable

  def user_input
    options = {}
    option_parse = OptionParser.new do |option|
        option.banner = "Hint: options -s 3:30"
          option.on("-f=n","--format=n","help") do |b| 
            format_option = b
            to_clipboard(format_option)
          end   
        option.on("-s=n", "--since=n") do |v|
            options[:since] = v
            git_timelog(options[:since]) 
        end
        option.on("-h","--help","help") do 
            puts opt_parser
        end
    end
    begin option_parse.parse! ARGV
    rescue OptionParser::InvalidOption, OptionParser::MissingArgument , OptionParser::ParseError => e
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
    puts gf.json_formatted.to_json
  end

  # list_style = 'ordered' || 'unordered'
  def to_clipboard(list_style = 'ordered')
    data = git_timelog
    gf = GitFormatter.new(data)
    `echo "#{gf.title_list(list_style)}"`
  end
end
