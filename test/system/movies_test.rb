require "application_system_test_case"

class MoviesTest < ApplicationSystemTestCase
  #test "visiting the index" do
  #  visit movies_url
  #  assert_selector "h1", text: "Mine film"
  #end
  test "adding a movie with omdb" do
    test_movies = ['Shawshank Redemption', 'Fast Five', 'Joker', 'Batman Begins', 'Venom', 'Ready Player One', '1917']
    test_movie = test_movies[rand(0..6)]
    visit movies_url

    click_on "Ny Film"

    fill_in "Titel", with: test_movie
    fill_in "Beskrivelse", with: "En kort beskrivelse til min test"

    find_field("OMDB link").send_keys test_movie
    #sleep 2 # Venter på ajax svar

    page.find('#suggestion-result').first('div').click
    #find('div', text: 'fast five').click
    click_on "Brug OMDB data"

    click_on "Gem"

    assert_text test_movie
    sleep 20
  end
end
