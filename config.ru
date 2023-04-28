require 'bundler' 
Bundler.require 

$:.unshift File.expand_path("./../lib", __FILE__) 
require 'controller' 

run ApplicationController

#rackup -p 4567 commande afin de lancer le serveur sous les conv de sinatra
