require "uri"
require "net/http"
require 'json'

url = URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY")

https = Net::HTTP.new(url.host, url.port);
https.use_ssl = true

request = Net::HTTP::Get.new(url)

response = https.request(request)
body=JSON.parse response.read_body

body['photos'].each do |hash|
  puts  hash['img_src']
end






