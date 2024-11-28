class MoviesController < ApplicationController
  def create
    puts "Parameters: #{params.inspect}" # This line will print all parameters to the log

    #Parameters: {"the_title"=>"1", "the_year"=>"1", "the_duration"=>"1", "the_description"=>"1", "the_image"=>"1", "the_director_id"=>"1"}
    
    #Create a new movie with parameters from the form
    m = Movie.new
    m.title = params.fetch("the_title")
    m.year = params.fetch("the_year")
    m.duration = params.fetch("the_duration")
    m.description = params.fetch("the_description")
    m.image = params.fetch("the_image")
    m.director_id = params.fetch("the_director_id")

    m.save

    #Redirect to the movies index page after saving
    redirect_to("/movies")
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Movie.where({:id => the_id})

    the_movie = matching_records.at(0)

    the_movie.destroy

    redirect_to("/movies")
  end

  def update
    m_id = params.fetch("the_id")

    matching_records = Movie.where({:id => m_id})
    the_movie = matching_records.at(0)

    the_movie.title = params.fetch("the_title")
    the_movie.year = params.fetch("the_year")
    the_movie.duration = params.fetch("the_duration")
    the_movie.description = params.fetch("the_description")
    the_movie.image = params.fetch("the_image")
    the_movie.director_id = params.fetch("the_director_id")

    the_movie.save

    redirect_to("/movies/#{the_movie.id}")

  end
  
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
