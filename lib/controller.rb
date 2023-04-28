require 'bundler' 
Bundler.require 
require 'gossip'


class ApplicationController < Sinatra::Base 

  get '/' do 
    erb:index
  end

  get'/gossips/new/'
    erb:new_gossip
  end

  # Route pour la création d'un nouveau gossip
  post '/gossips/new/' do
    author = params['gossip_author']# Récupération des données du formulaire
    content = params['gossip_content']
    new_gossip = Gossip.new(author, content)# Création d'une instance de Gossip
    new_gossip.save()# Sauvegarde des données dans un fichier CSV
    redirect '/'# Redirection vers la page d'accueil
  end

  get '/' do 
    erb:index, locals: {gossips: Gossip.all} 
  end
    
  get '/gossips/:id' do 
    erb:show, locals: {gossip: Gossip.find(params['id']), id: params['id']}
  end
 
  get '/gossips/:id/edit' do
    erb :edit, locals: {gossip: Gossip.all[params[:id].to_i ], id: params[:id].to_i}
  end

  post '/gossips/:id/edit/' do
		Gossip.upgrade(params["gossip_author"], params["gossip_content"], params[:id].to_i)
		redirect '/'
  end
end

#lancer le servuer shitgun-p 4567

