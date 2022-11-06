class ApplicationController < Sinatra::Base


   # Add this line to set the Content-Type header for all responses

    set :default_content_type,"application/json"

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
  
    #Get all the games from a database
    # games=Game.all.order(:title) #Sorting the game alphabetically

    #return the first 10 games
    games=Game.all.order(:title).limit(10)



    #Return a Json response with all the array of games data
    games.to_json


  end


  # use the :id syntax to create a dynamic route

  get '/games/:id' do
    # # look up the game in the database using its ID
    game=Game.find(params[:id])
    # # send a JSON-formatted response of the game data

    # game.to_json(include: {reviews:{include: :user}})


     # include associated reviews in the JSON response

#We can also be more selective about
#which attributes are returned from each model with the only option:
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
    

  end




end
