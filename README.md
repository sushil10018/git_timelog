# GitTimelog

A tool to extract daily update from GIT commits.

The tool can return json of the tasks done along with start and end time. As well as simply copy the list of commits done as plain-text list which can be ordered or unordered.

## Installation

Execute this line to your root directory

```ruby
gem install 'git_timelog'
```

## Dependency for Linux

    sudo apt-get install xclip

## Usage

Executable:

    $ git_timelog
      => Copies the commit logs from 6am in the morning
    $ git_timelog --since=“6am”
      => Time can be specified since when through this option
    $ git_timelog -s “6am”
      => shortcode of —since [6am => :default]
    $ git_timelog --format=“json”
      => format = “json” || “ordered” || “unordered”
        “json” => returns the json formatted values
          title:
          description:
          start_time:
          end_time:
        “ordered” => Copies ordered list of daily log in clipboard.
        “unordered” => Copies un-ordered list of daily log in clipboard. [:default]
    $ git_timelog -f “json”
      => shortcode of --format
    $ git_timelog --help
      => helps you use the executables
    $ git_timelog -h
      => shortcode for help
    $ git_timelog --emitii
      => Sets emitii to true which updates the API and also asks for:
        access_token:
        emitii_subdomain:
        project_name:
    $ git_timelog -e
      => Shortcode for --emitii

## Features

- Get the commits throughout all branch in current repo for current author.
- The CLI accepts different parameters
time to be dynamically chosen.
- Hours can be specified through commit messages title with format => [2] for two hours.
- Copy the unordered list to clipboard for easy paste in any time-logger.
- Copy the ordered list to clipboard for easy paste in any time-logger if preferred.

## Future Enhancements

- Refactor! Refactor!! Refactor!!!
- YML to be set as hidden within project directory.
- Only the commits with [1] in title is logged in emitii.

## Few Assumptions (to be reduced gradually)

- need to be in the same repo for update.
- not to use following in git commits messages or descriptions:
  - git__title:
  - git__description:
  - git__date:


## Wanna Contribute? You're Welcome!

1. Fork it ( https://github.com/sushil10018/git_timelog/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
