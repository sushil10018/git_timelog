require "git_timelog/version"
require "git_timelog/emitii_api_connector"
require "git_formatter"
require "json"
require 'optparse'
require 'ostruct'
require 'pry'

module GitTimelog
  # TODO: make the time changeable

  def user_input
    options = OpenStruct.new
    options.format = "unordered"
    options.since = "6am"
    options.emitii = false
    options.install = false
    option_parse = OptionParser.new do |option|
      option.banner = "Hint: git_timelog -s 6am -f json"
      option.on("-f","--format=FORMAT","which format do you want to get returned") do |format|
        options.format = format
      end  
      option.on("-s", "--since=SINCE", "When do you want your time logged.") do |since|
        options.since = since
      end
      option.on("-e", "--emitii", "update time log in emitii?") do |since|
        options.emitii = true
      end
      option.on("-i", "--install", "configure your project for emitii with access_tokens") do |since|
        options.install = true
      end
      option.on("-h","--help","help") do 
        puts option_parse
      end
    end
    begin
      option_parse.parse! ARGV
      if options.emitii == true
        if options.install == true
          set_project_setting
        end
        to_emitii(options.since)
      else
        if options.format == "json"
          json_format(options.since)
        elsif options.format == "ordered" || options.format == "unordered"
          to_clipboard(options.format, options.since)
          puts 'Copied to clipboard. Please paste as required.'
        else
          puts 'invalid format'
        end
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
    `git config user.name`.chomp
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

  def to_emitii(from_time = '6am')
    require 'yaml'
    unless File.exist?('setting.yml')
      puts "Configure your project for emitii with access_tokens"
      set_project_setting
    end    
    thing = YAML.load_file('setting.yml')
    obj = EmitiiApiConnector.new(thing["access_token"], thing["project_name"], thing["emitii_subdomain"])
    data = git_timelog(from_time)
    gf = GitFormatter.new(data)
    response = obj.update_time_tracks(gf.json_formatted)
    if response["status"] == 200
      puts "Emitii Successfully Updated."
    else
      puts "Something went wrong. Please try again."
    end
  end

  def set_project_setting
    require 'yaml' # Built in, no gem required
    File.new("setting.yml", "w")
    d = Hash.new
    puts "Your Access Token Please:"
    d['access_token']  = gets.chomp
    puts "Your Subdomain Please:"
    d['emitii_subdomain'] = gets.chomp
    puts "Your Project Name Please:"
    d['project_name'] = gets.chomp
    File.open("setting.yml","w") do |file|
      file.write d.to_yaml
    end
  end
end