require 'spec_helper'

describe Tribute::API do
  include Rack::Test::Methods

  def app
    Tribute::API
  end

  it "root" do
    get "/"
    last_response.status.should == 200
    last_response.body.should == {
      current_user_url: "http://example.org/user",
      status_url: "http://example.org/status/{scope}",
      user_url: "http://example.org/users/{user}"
    }.to_json
  end

end

