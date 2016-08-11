require 'rubygems'
require 'bundler/setup'

require 'minitest/autorun'
require 'rack/test'
require 'rack/ban_extension'

class TestBanExtension < Minitest::Test
  include Rack::Test::Methods

  def app
    Rack::Builder.new {
      use Rack::BanExtension, %w(php aspx)
      run ->(_) { [200, {}, ['Hello World!']] }
    }.to_app
  end

  def test_valid_request_without_extension
    get '/'
    assert last_response.ok?
  end

  def test_valid_request
    get '/index.html'
    assert last_response.ok?
  end

  def test_valid_params_featuring_extension
    get '/index.html?.php'
    assert last_response.ok?
  end

  def test_valid_anchor_featuring_extension
    get '/index.html#.php'
    assert last_response.ok?
  end

  def test_valid_but_similar_to_banned_extension
    get '/index.php3'
    assert last_response.ok?
  end

  def test_banned_extension
    get '/index.php'
    assert last_response.bad_request?
  end

  def test_uppercase_banned_extension
    get '/index.PHP'
    assert last_response.bad_request?
  end

  def test_additional_banned_extension
    get '/index.aspx'
    assert last_response.bad_request?
  end

  def test_banned_extension_with_params
    get '/index.php?.html'
    assert last_response.bad_request?
  end

  def test_banned_extension_with_anchor
    get '/index.php#.html'
    assert last_response.bad_request?
  end
end
