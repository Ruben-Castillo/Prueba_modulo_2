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
json_response.each do |key,value|
  value.each do |hash|
    list_items+= "\t\t\t<li><img src='#{hash['img_src']}'></li>\n"
  end
end
pre_list="<html>\n\t<head>\n\t</head>\n\t<body>\n\t\t<ul>"
post_list="\t\t</ul>\n\t</body>\n</html>"
html="#{pre_list}\n#{list_items}#{post_list}"
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