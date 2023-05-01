require 'bundler'
Bundler.require


require './lib/controller'

run ApplicationController

#rackup -p 4567 commande afin de lancer le serveur sous les conv de sinatra
