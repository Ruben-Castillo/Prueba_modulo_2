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
  json_response['photos'].each do |hash|
    list_items+= "\t\t\t<li><img src='#{hash['img_src']}'></li>\n"
  end
  pre_list="<html>\n\t<head>\n\t</head>\n\t<body>\n\t\t<ul>"
  post_list="\t\t</ul>\n\t</body>\n</html>"
  html="#{pre_list}\n#{list_items}#{post_list}"
  File.write("./index.html", html)
end

puts build_web_page(request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=","QKP56G9b4L9oD7IjBxTJEa2zh1nhziTe4zxqGt5d"))
