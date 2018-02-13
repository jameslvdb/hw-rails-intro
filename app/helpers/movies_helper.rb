module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  # def header_class(sort_column)
  #   if @sort_order == sort_column
  #     "hilite"
  #   else
  #     nil
  #   end
  # end
end
