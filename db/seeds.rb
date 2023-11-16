# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'json'

Movie.destroy_all

url = 'https://tmdb.lewagon.com/movie/top_rated?language=en-US'

response = URI.open(url).read
data = JSON.parse(response)
movies_arr = data['results']
movies_arr.each do |movie|
  title = movie['title']
  overview = movie['overview']
  poster_url = movie['poster_path']
  rating = movie['vote_average']
  Movie.create!(title: title, overview: overview, poster_url: poster_url, rating: rating)
end

List.destroy_all

List.create!(name: 'Classics')
List.create!(name: 'Fantasy')
List.create!(name: 'History')
