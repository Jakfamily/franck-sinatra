require 'csv'

class Gossip
  attr_accessor :author, :content

  def initialize(author,content)
    @author = author
    @content = content
  end

  def save # On définit une méthode pour sauvegarder un Gossip dans un fichier CSV
    CSV.open("./db/gossip.csv", "ab") do |csv| # On ouvre le fichier en mode écriture (ab pour ajouter à la fin du fichier)
      csv << [@content, @author] # On ajoute une ligne au fichier CSV avec le contenu et l'auteur du Gossip
    end
  end

  def self.all # On définit une méthode pour récupérer tous les Gossips stockés dans le fichier CSV
    all_gossips = [] 
    CSV.read("./db/gossip.csv").each do |csv_line| # On parcourt toutes les lignes du fichier CSV
      all_gossips << Gossip.new(csv_line[0], csv_line[1]) # On crée un nouvel objet Gossip avec le contenu et l'auteur de la ligne, et on l'ajoute au tableau
    end
    return all_gossips # On retourne le tableau rempli d'objets Gossip
  end

  def self.find(id) # On définit une méthode pour récupérer un Gossip spécifique en fonction de son identifiant
    return Gossip.all[id.to_i-1] # On récupère tous les Gossips, et on retourne celui qui correspond à l'identifiant (en enlevant 1 car les identifiants commencent à 1)
  end

  def self.upgrade(author, content, id) # On définit une méthode pour mettre à jour un Gossip existant en fonction de son identifiant
    gossip_array = self.all # On récupère tous les Gossips dans un tableau
		gossip_array[id.to_i].content = content # On met à jour le contenu du Gossip correspondant à l'identifiant
		gossip_array[id.to_i].author = author # On met à jour l'auteur du Gossip correspondant à l'identifiant
		File.open("./db/gossip.csv", 'w') {|file| file.truncate(0) } # On vide le fichier CSV
		gossip_array.each do |gossip| # On parcourt tous les Gossips dans le tableau
			gossip.save # On sauvegarde chaque Gossip dans le fichier CSV
		end	
  end

end