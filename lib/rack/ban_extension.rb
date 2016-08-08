require 'rack/ban_extension/version'

module Rack
  class BanExtension
    def initialize(app, banned_extensions)
      @app = app
      @banned_extensions = Array(banned_extensions)
    end

    def call(env)
      if @banned_extensions.include? extension(env)
        Rack::Response.new([], 403).finish
      else
        @app.call(env)
      end
    end

    private

    def extension(env)
      path_extension(env['PATH_INFO'].to_s)
    end

    def path_extension(path)
      ::File.extname(path).downcase.gsub(/^\./, '')
    end
  end
end
