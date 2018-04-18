require "google_drive"
require 'nokogiri'
require 'open-uri'
require 'gmail'
require 'dotenv'
##def city_names()
#y = 1
#city_names = $ws[y, 1]
#puts city_names
##end
def send_emails_to_line()
  # On appelle le Google Spreadsheet
    session = GoogleDrive::Session.from_config("config.json")
    $ws = session.spreadsheet_by_key("1Iu8YETEK0J9lS1qaV8OIr0J939PyxTvt-IDjA5Y5XM4").worksheets[0]
  # On appelle l'utilisateur à s'authentifier
    puts "Gmail username (or email):"
    login = gets.chomp
    puts "Gmail password for '#{login}':"
    pw = gets.chomp
    gmail = Gmail.connect(login, pw)
  #On vérifie si l'authentification a réussi
    puts "*Successfully logged in to Gmail servers!" if gmail.logged_in? == true
# On fait ensuite une boucle qui va chercher
# les informations sur chaque ligne de la colonne B
# jusqu'à ce que la ligne soit vide
y = 2
until ($ws[y, 1] == '' || $ws[y, 2] == '')
  gmail.deliver do
    to $ws[y, 2]
    subject "Projet THP"
    # On va tester d'enlever cette partie pour voir
    # si ça marche
    # text_part do
    #  body "Text of plaintext message."
    # end
    html_part do
      content_type 'text/html; charset=UTF-8'
      body "<p>Bonjour,
Je m'appelle Alex, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.
Déjà 300 personnes sont passées par The Hacking Project. Est-ce que la mairie de [city_names] veut changer le monde avec nous ?
Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80
</p>"
    end
  end
end
end
send_emails_to_line()
