require 'csv'

class Gossip
  attr_accessor :content, :author

  # Initialise une instance de Gossip avec un auteur et un contenu
  def initialize(author, content)
    @author = author
    @content = content
  end

  # Enregistre le gossip dans le fichier CSV "db/gossip.csv"
  def save
    CSV.open("./db/gossip.csv", "a") do |csv|
      csv << [author, content] # ajoute le gossip à la fin du fichier
    end
  end

  # Retourne tous les gossips stockés dans le fichier CSV
  def self.all
    all_gossips = []
    CSV.foreach("./db/gossip.csv", "r") do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1]) # crée une instance de Gossip pour chaque ligne du fichier CSV
    end
    return all_gossips # retourne un tableau contenant toutes les instances de Gossip créées
  end

  # Retourne le gossip correspondant à l'ID passé en paramètre
  def self.find(id)
    return Gossip.all[id.to_i - 1] # retourne l'instance de Gossip à l'index correspondant à l'ID (-1 car les index commencent à 0)
  end

  # Met à jour le gossip correspondant à l'ID passé en paramètre avec un nouvel auteur et contenu
  def self.update(id, author, content)
    all_gossips = Gossip.all # récupère tous les gossips
    all_gossips[id.to_i - 1].author = author # modifie l'auteur du gossip correspondant
    all_gossips[id.to_i - 1].content = content # modifie le contenu du gossip correspondant
  
    CSV.open("./db/gossip.csv", "w") do |csv| # ouvre le fichier CSV en mode "écriture" (overwrite)
      all_gossips.each do |gossip|
        csv << [gossip.author, gossip.content] # réécrit tous les gossips dans le fichier
      end
    end
    return all_gossips[id.to_i - 1] # retourne le gossip mis à jour
  end
end