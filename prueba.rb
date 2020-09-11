def request(adress,api_key)
    require 'uri'
    require 'net/http'
    require 'openssl'
    require 'json'
    url=URI(adress+api_key)
    http= Net::HTTP.new(url.host, url.port)
    request= Net::HTTP::Get.new(url)
    http.use_ssl=true
    http.verify_mode=OpenSSL::SSL::VERIFY_PEER
    response=http.request(request)
    return JSON.parse(response.read_body)
end
def build_web_page(json_response)
  list_items=""
  col_1=""
  col_2=""
  col_3=""
  json_response.each do |key,value|
    total=0
    value.each do |hash|
      total+=1
    end
    count=0
    value.each do |hash|
      count+=1
      col_1+= "\t\t\t\t\t<li>\n\t\t\t\t\t\t<div class='card' style='width: 18rem;'>\n\t\t\t\t\t\t\t<img src='#{hash['img_src']}'class='card-img-top' alt='...'>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</li>\n" if count<=total/3
      col_2+= "\t\t\t\t\t<li>\n\t\t\t\t\t\t<div class='card' style='width: 18rem;'>\n\t\t\t\t\t\t\t<img src='#{hash['img_src']}'class='card-img-top' alt='...'>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</li>\n" if count>=(total/3)+1 && count<=total/3*2 
      col_3+= "\t\t\t\t\t<li>\n\t\t\t\t\t\t<div class='card' style='width: 18rem;'>\n\t\t\t\t\t\t\t<img src='#{hash['img_src']}'class='card-img-top' alt='...'>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</li>\n" if count>=(total/3*2)+1 && count<=total  
      end
  end
  pre_list="<!doctype html>\n<html lang='en'>\n\t<head>\n\t\t<title>Prueba Modulo 2</title>\n\t\t<meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>\n\t\t<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css' integrity='sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T' crossorigin='anonymous'>\n\t</head>\n\t<body>\n\t\t<div class='container'>\n\t\t\t<div class='row'>\n\t\t\t\t<div class='col-4'>\n\t\t\t\t\t<ul>"
  post_list="</ul>\n</div>\n</div>\n</div>\n\n<script src='https://code.jquery.com/jquery-3.3.1.slim.min.js' integrity='sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo' crossorigin='anonymous'></script>\n<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js' integrity='sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1' crossorigin='anonymous'></script>\n<script src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js' integrity='sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM' crossorigin='anonymous'></script>\n</body>\n</html>"
  between_col="\t\t\t\t</ul>\n\t\t\t</div>\n\t\t\t\<div class='col-4'>\n\t\t\t\t<ul>"
  html="#{pre_list}\n#{col_1}\n#{between_col}\n#{col_2}\n#{between_col}\n#{col_3}\n#{post_list}"
  File.write("./index.html", html)
end
def photos_count(json_response)
  photos_count={"FHAZ"=>0,"RHAZ"=>0,"MAST"=>0,"CHEMCAM"=>0,"MAHLI"=>0,"MARDI"=>0,"NAVCAM"=>0,"PANCAM"=>0,"MINITES"=>0}
  json_response.each do |key,value|
    value.each do |hash|
      photos_count.each do |key,value|
        photos_count[key]+=1 if key==hash['camera']['name']
      end
    end
  end
  photos_count
end
build_web_page(request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=","QKP56G9b4L9oD7IjBxTJEa2zh1nhziTe4zxqGt5d"))
puts photos_count(request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=","QKP56G9b4L9oD7IjBxTJEa2zh1nhziTe4zxqGt5d"))