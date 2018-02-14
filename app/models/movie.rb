class Movie < ActiveRecord::Base

  def self.all_ratings
    movie_array = self.all
    ratings = []
    movie_array.each do |m|
      ratings.push(m.rating)
    end
    ratings = ratings.uniq!
  end

end
