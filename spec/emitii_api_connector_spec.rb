require "spec_helper"

describe EmitiiApiConnector do
  describe '#update_time_tracks' do
    it "should create time log on Emitii" do
      params = [{:title=>"gem initiated first commits spec setup second commit",
              :description=>"",
              :end_time=>"2016-02-20T13:23:59+00:00",
              :start_time=>"2016-02-20T13:22:55+00:00"}]
      obj = EmitiiApiConnector.new
      response = obj.update_time_tracks(params)
      expect(response["status"]).to eql(200)
    end
  end
end