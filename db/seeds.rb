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

URI.open(url) do |f|
  f.each_line do |line|
    movie = JSON.parse(line)
    movie['results'].each do |m|
      title = m['title']
      overview = m['overview']
      poster_url = m['poster_path']
      rating = m['vote_average']
      Movie.create!(title: title, overview: overview, poster_url: poster_url, rating: rating)
    end
  end
end

List.create!(name: 'Classics')
List.create!(name: 'Fantasy')
List.create!(name: 'History')
