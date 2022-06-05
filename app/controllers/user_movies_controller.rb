class UserMoviesController < ApplicationController

  def index
    if current_user
      if params[:top_rated]
        @movies = MovieFacade.top_rated
      elsif params[:keyword]
        @keyword = params[:keyword]
        @results = MovieFacade.search_for_movies(@keyword)
      end
    else
      if params[:top_rated]
        @movies = MovieFacade.top_rated
      elsif params[:keyword]
        @keyword = params[:keyword]
        @results = MovieFacade.search_for_movies(@keyword)
      end
    end 
  end

  def show
    if current_user
      conn = Faraday.new(url: "https://api.themoviedb.org")
      response1 = conn.get("/3/movie/#{params[:movie_id]}?api_key=#{ENV['movie_db_key']}")
      response2 = conn.get("/3/movie/#{params[:movie_id]}/credits?api_key=#{ENV['movie_db_key']}")
      data1 = JSON.parse(response1.body, symbolize_names: true)
      data2 = JSON.parse(response2.body, symbolize_names: true)

      @movie_data = {movie: data1, cast: data2[:cast][0..9]}
    else
      conn = Faraday.new(url: "https://api.themoviedb.org")
      response1 = conn.get("/3/movie/#{params[:movie_id]}?api_key=#{ENV['movie_db_key']}")
      response2 = conn.get("/3/movie/#{params[:movie_id]}/credits?api_key=#{ENV['movie_db_key']}")
      data1 = JSON.parse(response1.body, symbolize_names: true)
      data2 = JSON.parse(response2.body, symbolize_names: true)

      @movie_data = {movie: data1, cast: data2[:cast][0..9]}

    end 
  end
  
  


end 