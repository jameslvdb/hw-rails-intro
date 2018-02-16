class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    update = false   # flag for a redirect_to
    @all_ratings = Movie.all_ratings.sort
    @movies = Movie.all

    # :ratings
    if params[:ratings].present?
      @current_ratings = params[:ratings].keys
      session[:ratings] = params[:ratings]
      @movies = @movies.where(rating: @current_ratings)
    elsif session[:ratings].present?
      params[:ratings] = session[:ratings]
      update = true
    else
      @current_ratings = Movie.all_ratings
    end

    # :sort_column
    if params[:sort_column].present?
      @sort_column = params[:sort_column]
      session[:sort_column] = params[:sort_column]
      @movies = @movies.order(@sort_column)
    elsif session[:sort_column].present?
      params[:sort_column] = session[:sort_column]
      update = true
    end

    if update
      flash.keep
      redirect_to movies_path(params.slice(:ratings, :sort_column))
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
