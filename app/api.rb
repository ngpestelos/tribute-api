module Tribute
  class API < Grape::API
    
    version 'v1', using: :header, vendor: 'tribute', strict: false
    format :json
        
    helpers Tribute::Helpers::Urls
    helpers Tribute::Helpers::Auth
    
    desc "Hypermedia API root."
    get do
      {
        status_url: url('status')
      }
    end
    
    mount Tribute::Api::Status
    mount Tribute::Api::Auth
    mount Tribute::Api::User

  end
end

