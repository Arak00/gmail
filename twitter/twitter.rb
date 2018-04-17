require 'twitter'
require 'GoogleDrive'
equire 'dotenv'      							 # J'appelle dotenv
Dotenv.load          							 # Je lui demande de charger mon fichier contenant mes infos perso 

session = GoogleDrive::Session.from_config("config.json")
$ws = session.spreadsheet_by_key("1Iu8YETEK0J9lS1qaV8OIr0J939PyxTvt-IDjA5Y5XM4").worksheets[0]

def client 										 # 
client = Twitter::REST::Client.new do |config|   # Connexion à l'API
    config.consumer_key        = puts ENV['MY_CONSUMER_KEY']
    config.consumer_secret     = puts ENV['MY_CONSUMER_SECRET']
    config.access_token        = puts ENV['MY_ACCESS_TOKEN']
    config.access_token_secret = puts ENV['MY_ACCESS_TOKEN_SECRET']
  end
end
  end
end

#client.update("Deuxième tweet, c'est génial !") # C'était un text, ca marche, cool ! 


# > Premier_programme - Sélectionner et ajouter dans mon spreadsheet les handles Twitter correspondant aux mairies.

def search_mairie                       # Je fais la recherche de comptes Twitter de mairies
  										# appeler fichier mairie, nom de la ville
  hash_array = [] 						# Pour y ranger les résultats de ma recherche

  client.search(
end

=begin
def send_to_spreadsheet(hash_array)    # On appelle le spreadsheet et on y ajoute le @Twitter_des_mairies en colonne C
  $ws[1, 3] = "Twitter"
  i = 2
  hash_array.each{ |x|
  $ws[i, 3] = x[:twitter]
  $ws.save
  i += 1
  }
end

# > Second_programme -  Follow les users concernés

def follow_mairie                       # Récupérer les users et créer une loop
end 
client.follow(user)
=end
