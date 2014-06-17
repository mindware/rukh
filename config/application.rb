#config/application.rb
require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rukh
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'America/Puerto_Rico'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es
    config.i18n.available_locales = [:es] # For REP
    
    # For Bootstrap Sass
    config.assets.precompile = config.assets.precompile + %w(*.png *.jpg *.jpeg *.gif)
    
    # For Warble
    config.assets.enabled = true
    config.assets.initialize_on_precompile = false
    
    # Rspec Generators
    config.generators do |g|
      g.test_framework :rspec, 
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
    
    # Email Preview path 
    config.action_mailer.preview_path = "#{Rails.root}/lib/mailer_previews/"
    
    console do
      begin
        require 'pry'
        config.console = Pry if defined? Pry
      rescue LoadError
      end
      # Below seems unneccesary left for just in case.
      # unless defined? Pry::ExtendCommandBundle
      #   Pry::ExtendCommandBundle = Module.new
      # end
      # require "rails/console/app"
      # require "rails/console/helpers"
      # TOPLEVEL_BINDING.eval('self').extend ::Rails::ConsoleMethods
    end
    
    
  end
end