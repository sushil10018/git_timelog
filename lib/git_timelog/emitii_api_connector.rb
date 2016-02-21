require "httparty"

class EmitiiApiConnector
  attr_accessor :access_token, :params, :project_name, :emitii_subdomain

  def initialize(access_token='amhVvo8j8MCVzWS6kxuvQg', project_name='git_timelog', emitii_subdomain='jhackathon')
    @access_token = access_token
    @project_name = project_name
    @emitii_subdomain = emitii_subdomain
  end

  def update_time_tracks(params)
    params = {
      timetrack: params
    }
    response = HTTParty.post("http://#{@emitii_subdomain}.emitii.com/api/timetracks?access_token=#{@access_token}&project=#{@project_name}&format=json",
      { 
        :body => params.to_json,
        :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
      })
    return response
  end
end