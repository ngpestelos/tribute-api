module Tribute
  class App
    class << self

      def instance
        @instance ||= Rack::Builder.new do
          api = Tribute::API
          
          if ENV['RACK_ENV'] == 'development'
            api.logger.info "Loading NewRelic in developer mode ..."
            require 'new_relic/rack/developer_mode'
            use NewRelic::Rack::DeveloperMode
          end

          use Rack::Session::Cookie, secret: ENV['SESSION_COOKIE_SECRET'] || SecureRandom.base64(128)

          if [ 'development', 'test' ].include? ENV['RACK_ENV']
            api.logger.info "Enabling Developer authentication."
            use OmniAuth::Strategies::Developer
          end

          if ENV['GITHUB_KEY'] && ENV['GITHUB_SECRET']
            api.logger.info "Enabling Github authentication."
            use OmniAuth::Strategies::GitHub, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
          end

          run api
        end.to_app
      end

    end
  end
end
