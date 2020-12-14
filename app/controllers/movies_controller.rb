require 'omdb/api'
class MoviesController < ApplicationController
  @@client = Omdb::Api::Client.new(api_key: "6e69484d")
  def index
    @movies = Movie.all.sort{|a, b| a.title <=> b.title}
  end

  def show
    @movie = Movie.find(params[:id])
    if @movie.omdb_id
      @omdb = @@client.find_by_id(@movie.omdb_id)
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to @movie
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
    if @movie.omdb_id
      @omdb = @@client.find_by_id(@movie.omdb_id)
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to @movie
    else
      render :edit
    end
  end

  def destroy
     @movie = Movie.find(params[:id])
     @movie.destroy

     redirect_to root_path
  end

  def search
    @movies = @@client.search(params[:term])

    respond_to do |format|
      format.json { render json: @movies }
    end
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :description, :poster, :omdb_id)
    end
end
