require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Testtask
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.autoload_paths += %W[#{config.root}/lib]

    config.to_prepare do
      DeviseController.respond_to :html, :json
    end

    config.api_only = true
    # Load middlewares required by Rails Admin
    config.middleware.delete ActionDispatch::Session::CookieStore
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Flash
    config.middleware.use Rack::MethodOverride
    config.session_store :cookie_store, key: '_starter-backend_session'
    config.middleware.use config.session_store, config.session_options
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
