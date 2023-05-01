require_relative 'gossip'

class ApplicationController < Sinatra::Base

  # route GET pour afficher la page d'accueil
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
 
  # route GET pour afficher le formulaire de création d'un nouveau gossip
  get '/gossips/new' do
    erb :new_gossip
  end

  # route POST pour enregistrer un nouveau gossip dans la base de données
  post '/gossips/new' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  # route GET pour afficher les détails d'un gossip spécifique
  get '/gossips/:id' do 
    erb :show, locals: {gossip: Gossip.find(params['id'].to_i), id: params['id'].to_i}
  end
  
  # route GET pour afficher le formulaire de mise à jour d'un gossip spécifique
  get '/gossips/:id/edit' do
    erb :edit, locals: {gossip: Gossip.find(params['id'].to_i), id: params['id'].to_i}
  end

  # route POST pour mettre à jour un gossip spécifique dans la base de données
  post '/gossips/:id/edit' do
    Gossip.upgrade(params["gossip_author"], params["gossip_content"], params[:id].to_i)
    puts "La base de données CSV a été mise à jour"
    redirect '/'
  end
end


#lancer le servuer shotgun-p 4567

