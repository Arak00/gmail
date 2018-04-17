require "google_drive"
require 'nokogiri'
require 'open-uri'

#On appelle le GoogleDrive
session = GoogleDrive::Session.from_config("config.json")
# On appelle le spreadsheet et on y ajoute le nom des colonnes A et B
$ws = session.spreadsheet_by_key("1Iu8YETEK0J9lS1qaV8OIr0J939PyxTvt-IDjA5Y5XM4").worksheets[0]
$ws[1,1] = "Mairie"
$ws[1,2] = "Adresse email"
$ws.save
############## METHODE DE STOCKAGE EN HASH ################
#### Récupération de l'email depuis page web ####
def get_the_email_of_a_townhal_from_its_webpage(temporaire, hashage, name)
  temporaire.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  hashage[name] = temporaire.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end

#### Récupération des URLS DE MOSELLE ####
def get_all_the_urls_of_moselle_townhalls(liens)
  email = Hash.new(0)
  doc = Nokogiri::HTML(open(liens))
  size = doc.css('a.lientxt').length
### Réutilisation de la méthode précédente et stockage dans une array email"
  for n in 0...size
    tmp = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com#{doc.css('a.lientxt')[n]['href']}"))
    name = doc.css('a.lientxt')[n]['href'].tr('/57/', '').gsub('.html', '').tr('.', '').to_s
    get_the_email_of_a_townhal_from_its_webpage(tmp, email, name)
  end
  return email
end

#### Récupération des URLS DU FINISTERE ####

def get_all_the_urls_of_finistere_townhalls(liens)
  email = Hash.new(0)
  doc = Nokogiri::HTML(open(liens))
  size = doc.css('a.lientxt').length
### Réutilisation de la méthode précédente et stockage dans une array email"
  for n in 0...size
    tmp = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com#{doc.css('a.lientxt')[n]['href']}"))
    name = doc.css('a.lientxt')[n]['href'].tr('/29/', '').gsub('.html', '').tr('.', '').to_s
    get_the_email_of_a_townhal_from_its_webpage(tmp, email, name)
  end
  return email
end

#### Récupération des URLS DU DOUBS ####

def get_all_the_urls_of_doubs_townhalls(liens)
  email = Hash.new(0)
  doc = Nokogiri::HTML(open(liens))
  size = doc.css('a.lientxt').length
### Réutilisation de la méthode précédente et stockage dans une array email"
  for n in 0...size
    tmp = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com#{doc.css('a.lientxt')[n]['href']}"))
    name = doc.css('a.lientxt')[n]['href'].tr('/25/', '').gsub('.html', '').tr('.', '').to_s
    get_the_email_of_a_townhal_from_its_webpage(tmp, email, name)
  end
  return email
end

############# STOCKAGE DANS GOOGLE spreadsheet ##############

def stock_in_google_spreadsheet
  hash = get_all_the_urls_of_moselle_townhalls('http://www.annuaire-des-mairies.com/moselle.html')
  hash.each_with_index do |(key, value), index |
    $ws[index+2, 1] = key
    $ws[index+2, 2] = value
    end
  hash = get_all_the_urls_of_doubs_townhalls('http://www.annuaire-des-mairies.com/doubs.html')
  hash.each_with_index do |(key, value), index |
    $ws[index+389, 1] = key
    $ws[index+389, 2] = value
    end
  hash = get_all_the_urls_of_finistere_townhalls('http://www.annuaire-des-mairies.com/finistere.html')
  hash.each_with_index do |(key, value), index |
    $ws[index+245, 1] = key
    $ws[index+245, 2] = value
    end
  $ws.save
end

stock_in_google_spreadsheet