require 'net/http'
require 'json'

module Github
  class User
    attr_accessor :name

    def initialize name
      @name = name
    end

    #Instance methods
    def info
      Github::User.parse_info("https://api.github.com/users/#{@name}")
    end

    def id
      info[:id]
    end

    def repos
      res = Github::User.parse_info("https://api.github.com/users/#{@name}/repos")
      res.is_a?(Array) ? res : []
    end

    def total_repos_size
      repos.inject(0) { |sum, r| sum += r[:size] }
    end

    def repos_name
      repos.collect { |r| r[:name] }
    end

    def prefferable_languages
      rep = repos.map { |r| r[:language] }.compact
      res = Hash[rep.uniq.map { |m| [m, rep.count(m)] }]
      res.delete_if { |k, v| v < res.values.max }.keys
    end

    #Class methods
    def self.all_users
      parse_info.map { |r| r[:login] }
    end

    def self.parse_info(url = "https://api.github.com/users")
      uri = URI(url)
      JSON.parse(Net::HTTP.get(uri), symbolize_names: true)
    end
  end
end

# solandmedotru = Github::User.new('solandmedotru')
# puts solandmedotru.id
# puts solandmedotru.prefferable_languages
# puts solandmedotru.total_repos_size