require 'bundler'
Bundler.require

require 'gossip'

class ApplicationController < Sinatra::Base

  # Route qui affiche la liste de tous les gossips
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  # Route qui affiche le formulaire pour créer un nouveau gossip
  get '/gossips/new/' do
    erb :new_gossip
  end

  # Route qui reçoit les données du formulaire de création de gossip et crée le gossip correspondant
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  # Route qui affiche le détail d'un gossip
  get '/gossips/:id/' do 
    erb :show, locals: {gossip: Gossip.find(params['id']), id: params['id']}
  end

  # Route qui affiche le formulaire pour éditer un gossip existant
  get '/gossips/:id/edit/' do
    erb :edit, locals: {gossip: Gossip.find(params['id']), id: params['id']}
  end

  # Route qui reçoit les données du formulaire d'édition de gossip et met à jour le gossip correspondant
  post '/gossips/:id/edit/' do
    Gossip.update(params["id"], params["gossip_author"], params["gossip_content"])
    redirect "/"
  end

  # Lancement de l'application
  run! if app_file == $0
end




#lancer le servuer shotgun-p 4567

