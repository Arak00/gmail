require 'twitter'
#require_relative 'twitter.env'     		     # J'appelle mon fichier twitter.env dans lesquel est stocké mes infos perso
#OU 
require 'dotenv'      							 # J'appelle dotenv
Dotenv.load          							 # Je lui demande de charger mon fichier contenant mes infos perso (twitter.env)


client = Twitter::REST::Client.new do |config|   # Connexion à l'API
    config.consumer_key        = puts ENV['MY_CONSUMER_KEY']
    config.consumer_secret     = puts ENV['MY_CONSUMER_SECRET']
    config.access_token        = puts ENV['MY_ACCESS_TOKEN']
    config.access_token_secret = puts ENV['MY_ACCESS_TOKEN_SECRET']
  end

  client.update("Premier tweet en Ruby, que d'émotions!")

=begin
#premier_programme Sélectionner et ajouter dans mon spreadsheet les handles Twitter correspondant aux mairies.

def search_mairie                                # Je fais la recherche de comptes Twitter de mairies

  client.search("to:justinbieber marry me", result_type: "recent").take(1).collect do |tweet|
  "#{tweet.user.screen_name}: #{tweet.text}"
end

les enregistrer dans hash_array
end

def send_to_spreadsheet (hash_array)

# On appelle le spreadsheet et on y ajoute le nom des colonnes A et B
  session = GoogleDrive::Session.from_config("config.json")
  $ws = session.spreadsheet_by_key("1Iu8YETEK0J9lS1qaV8OIr0J939PyxTvt-IDjA5Y5XM4").worksheets[0]
  $ws[1, 3] = "Twitter"
  i = 2
  hash_array.each{ |x|
  $ws[i, 3] = x[:twitter]
  $ws.save
  i += 1
  }
end
#second_programme follow les users concernés
=end