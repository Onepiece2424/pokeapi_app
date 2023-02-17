require "test_helper"

class PokemonsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get pokemons_new_url
    assert_response :success
  end
end
