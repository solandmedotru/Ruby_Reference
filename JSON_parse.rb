require 'net/http'
require "json"

uri = URI("https://api.github.com/users/solandmedotru")

result = JSON.parse(Net::HTTP.get(uri), symbolize_names: true)

if result.is_a?(Array)
  result.each { |hsh| puts hsh[:login] }
elsif result.is_a?(Hash)
  puts result[:login]
else
  puts "Неверные входные данные. Необходим массив хэшей или хэш."
end
