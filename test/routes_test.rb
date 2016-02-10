require './test/test_helper.rb'

class RoutesTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    HTTPApp
  end

  def test_root
    get '/'
    assert last_response.ok?
    assert_match 'Your super cool Academy instructors are Leo and DDM', last_response.body
  end

  def test_squirrels_index__no_data
    get '/squirrels'
    assert_match 'You have no squirrels!', last_response.body
  end

  def test_squirrels_index__all_data
    set_up_all_squirrel_data
    get '/squirrels'
    assert_match @squirrel_1.name, last_response.body
    assert_match @squirrel_2.name, last_response.body
    assert_match @squirrel_3.name, last_response.body
  end

  def test_squirrels_show
    squirrel = set_up_squirrel_1
    get "/squirrels/#{squirrel.id}"
    assert_match 'This is Squeaker', last_response.body
    assert_match 'Squeaker squeaks.', last_response.body
  end

  private

  def set_up_all_squirrel_data
    @squirrel_1 = set_up_squirrel_1
    @squirrel_2 = set_up_squirrel_2
    @squirrel_3 = set_up_squirrel_3
  end

  def set_up_squirrel_1
    Models::Squirrel.new(name: 'Squeaker', description: 'Squeaker squeaks.')
  end

  def set_up_squirrel_2
    Models::Squirrel.new(name: 'Squeakly', description: 'Squeakly is a squeaker.')
  end

  def set_up_squirrel_3
    Models::Squirrel.new(name: 'Mr. Squeakington', description: 'Mr. Squeakington has a deep roar.')
  end
end

