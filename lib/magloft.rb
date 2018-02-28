require "her"

class AccessTokenAuthentication < Faraday::Middleware
  def call(env)
    env[:request_headers]["X-Magloft-Accesstoken"] = Magloft.access_token
    @app.call(env)
  end
end

module Magloft
  API = Her::API.new
  API.setup url: ENV['MAGLOFT_API_URL'] || "https://www.magloft.com" do |c|
    c.use AccessTokenAuthentication
    c.use Faraday::Request::UrlEncoded
    c.use Her::Middleware::DefaultParseJSON
    c.use Faraday::Adapter::NetHttp
  end

  @@app_id = nil
  def self.app_id
    @@app_id
  end

  @@access_token = nil
  def self.access_token
    @@access_token
  end

  def self.auth(access_token, app_id)
    @@access_token = access_token
    @@app_id = app_id
  end

  def self.users
    Model::User
  end

  def self.publications
    Model::Publication
  end

  def self.issues
    Model::Issue
  end

  def self.typeloft_themes
    Model::TypeloftTheme
  end

  def self.typeloft_pages
    Model::TypeloftPage
  end
end

require "magloft/model/base"
require "magloft/model/publication"
require "magloft/model/user"
require "magloft/model/issue"
require "magloft/model/typeloft_theme"
require "magloft/model/typeloft_page"
