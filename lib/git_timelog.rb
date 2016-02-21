require "git_timelog/version"
require "git_timelog/emitii_api_connector"
require "git_formatter"
require "json"
require 'optparse'
require 'ostruct'

module GitTimelog
  # TODO: make the time changeable

  def user_input
    options = OpenStruct.new
    options.format = "unordered"
    options.since = "6am"
    option_parse = OptionParser.new do |option|
      option.banner = "Hint: git_timelog -s 6am -f json"
      option.on("-f","--format=FORMAT","which format do you want to get returned") do |format|
        options.format = format
      end  
      option.on("-s", "--since=SINCE") do |since|
        options.since = since
      end
      option.on("-h","--help","help") do 
        puts option_parse
      end
    end
    begin
      option_parse.parse! ARGV
      if options.format == "json"
        json_format(options.since)
      elsif options.format == "ordered" || options.format == "unordered"
        to_clipboard(options.format, options.since)
        puts 'Copied to clipboard. Please paste as required.'
      else
        puts 'invalid format'
      end
    rescue OptionParser::InvalidOption, OptionParser::MissingArgument , OptionParser::ParseError => e
      puts e 
      puts "Type -h or --help for help"
    end
  end

  def git_timelog(from_time = '6am')
    `git log --pretty=format:"git__title:%sgit__description:%bgit__date:%cd" --author="#{current_author}" --since={#{from_time}} --reverse --all`
  end

  def current_author
    `git config user.name`.gsub("\n",'')
  end

  def json_format(from_time = '6am')
    data = git_timelog(from_time)
    gf = GitFormatter.new(data)
    puts gf.json_formatted.to_json
  end

  # list_style = 'ordered' || 'unordered'
  def to_clipboard(list_style = 'ordered', from_time = '6am')
    data = git_timelog(from_time)
    gf = GitFormatter.new(data)
    if `uname` == "Darwin\n"
      `echo "#{gf.title_list(list_style)}" | pbcopy`
    elsif `uname` == "Linux\n"
      `echo "#{gf.title_list(list_style)}" | xclip -selection clipboard`
    end
  end
end