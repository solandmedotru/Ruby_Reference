require 'net/http'
require "json"

uri = URI("https://api.github.com/users/solandmedotru")

result = JSON.parse(Net::HTTP.get(uri), symbolize_names: true)
puts result[:login]
puts result[:location]