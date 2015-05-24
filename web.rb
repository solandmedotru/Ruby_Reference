# ������� �����������

# ������� ����������� ruby �� ��������� �� ������� ��������� web-servera.

# ����, �����

# ��� ������ ��� ����������� http://www.ruby-doc.org/core/ � �����, ��� ��������� ������� �������� - ������ ����� �������� ������ ����, 
# ����� �� ���������� ���������. ������ �������� ����� �����, �����, ���� ��� WebRick( ��� ��� ���������� ������������������� ��� ������ �� ����� ruby), 
# � �� ����� ��������  �����. �� �� ������� ���� web-������, ���� �������� ����������� ruby.
# ��� ����������� ��� ����������( 'socket' � 'logger'). 
# ������, ��� �� ���������� ��� ������ � ��������, ������ ��� ������������.
# ������ ��� ����� HttpServer � ������� ���������� �������������:
class HttpServer
  def initialize(session, request, basepath)
    @session = session
    @request = request
    @basepath = basepath
  end
end
# session - ����������, � ������� ������� ���� ������.
# 
# request - ����������, ���� ������� ������, ������� �������� �� ��������.
# 
# basepath - �������, ��� ����� ��� ����.

# ����� ��������� "���� ������� �����".�������� ��� ���������, ����� �����

def getfullpath()
  file_name = @request =~ /^GET\s+(\S+)/i ? $1 : "/"
  file_name = File.expand_path(file_name, @basepath)
  file_name << "index.html" if File.directory?(file_name)
  return file_name
end

# ��������� ���������� ��������� �� �������� ��� ����� � ���� �� ����, ������� ������ ������ �������.
# ����� ��� ����� ������ ���� �����, ���� ����� ��� �� ������ �����.
# ��� � ������������, ������� ��� � ��� ���� �� ������ � �������, ���, 
# ����� expand_path - ��� ������ ��, ��� ��� �����, ��������� ���, �������� ������ ����� � �����.
# � ���� � ��� ������������� �� ����, � �����? - ����� ����� - ���������, ������������� �� �����������? - ���� ��, �� ����� "index.html".

# ������ ���� ���������� ��, ��� �� ����� �������� ����� ��������.��� ����� ��� ���� �������� ��� ���.

def serve()
  temp = getfullpath()
  begin
    if File.exist?(@basepath + temp) and File.file?(@basepath + temp)
      @session.puts "HTTP/1.1 200 OK\r\nDate: #{Time.now.localtime.strftime("%a, %d %b %Y %H:%M:%S GTM")}\r\nServer: KriM\r\nContent-type: #{getcontenttype(temp)}; charset=utf-8\r\n\r\n"
      @session.puts IO.read(@basepath + temp)
      @session.puts Time.now.localtime.strftime("%a, %d %b %Y %H:%M:%S GTM")
    else
      @session.puts "HTTP/1.1 404 Object Not Found\r\nServer: KriM\r\n\r\n"
      @session.puts "page not found, 404"
    end
  ensure
    @session.close
  end
end

# ���������� � temp ���� � �����, ���� ���� ����, �� ���������� �������� ��������� 200(� ������� �� �������� �� ����).
# �� � ������ �� ��������� - �����, ��� �������, ��� ������(��� ����� ���� ������� getcontenttype - � ��� ���� �����),
# ����� ���������.

# �� ������ IO � ����������� � ���������� ��������.������ ���� � �������� ��� � ������(������ ������������ � �������),
# ����� �, ��� �������� ������ ������ �����.

# ���� ���� �� ������ �� ������ �����, �� ���� ������� ������ 404, ������� ������������ � ���, ��� ���� �� ������ �� �������.

# �� � ��������� ������=) ���� �� ������ ���������� �������, �� ����� �� ���� ��������� ����� ����� ����������� ���� begin
# -
# ensure
# -
# end.

# ���������� ������� getcontenttype.��� ����� �������, �������� ��� �������������� �����, ������ ��� ������
# (������� ���������� �������) � ������ ������(����) � ������������ ����� ��������(��������)

def getcontenttype(path)
  ext = File.extname(path)
  type = {
      ".html " => " text/html ",
      ".htm " => " text/plain ",
      ".txt " => " text/plain ",
      ".css " => " text/css ",
      ".jpeg " => " image/jpeg ",
      ".jpg " => " image/jpeg ",
      ".gif " => " image/gif ",
      ".bmp " => " image/bmp ",
      ".rb " => " text/plain ",
      ".xml " => " text/xml ",
      ".xsl " => " text/xml "
  }
  return type[ext] || " application/octet-stream "
end

# ������� ���� ��������� �������, ���������� �������� �� �����, ��� ���������� " application/octet-stream ", ���� ������ ����� ����.
# ��, ����� �������=)

class HttpServer
  def initialize(session, request, basepath)
    @session = session
    @request = request
    @basepath = basepath
  end

  def getfullpath()
    file_name = @request =~ /^GET\s+(\S+)/i ? $1 : "/"
    file_name = File.expand_path(file_name, @basepath)
    file_name << " index.html " if File.directory?(file_name)
    return file_name
  end

  def serve()
    temp = getfullpath()
    begin
      if File.exist?(@basepath + temp) and File.file?(@basepath + temp)
        @session.puts " HTTP/1.1 200 OK \r\nDate : #{Time.now.localtime.strftime("%a, %d %b %Y %H:%M:%S GTM")}\r\nServer: KriM\r\nContent-type: #{getcontenttype(temp)}; charset=utf-8\r\n\r\n"
        @session.puts IO.read(@basepath + temp)
        @session.puts Time.now.localtime.strftime("%a, %d %b %Y %H:%M:%S GTM")
      else
        @session.puts "HTTP/1.1 404 Object Not Found\r\nServer: KriM\r\n\r\n"
        @session.puts "page not found, 404"
      end
    ensure
      @session.close
    end
  end

  def getcontenttype(path)
    ext = File.extname(path)
    type = {
        ".html " => " text/html ",
        ".htm " => " text/plain ",
        ".txt " => " text/plain ",
        ".css " => " text/css ",
        ".jpeg " => " image/jpeg ",
        ".jpg " => " image/jpeg ",
        ".gif " => " image/gif ",
        ".bmp " => " image/bmp ",
        ".rb " => " text/plain ",
        ".xml " => " text/xml ",
        ".xsl " => " text/xml "
    }
    return type[ext] || " application/octet-stream " unless type.key?(ext)
  end
end
# ���������� ������ ����������� � ������ �������.

$log = Logger.new('server.log')
base_path = "/home/krim/web "
server = TCPServer.new('localhost', 9191)
loop do
  session = server.accept
  request = session.gets
  logs = " \n=================================================== \n "
  logs += " #{session.peeraddr[2]} (#{session.peeraddr[3]})\n"
  logs += "\n#{request}"
  $log.info(logs)
  puts logs
  Thread.start(session, request) do |session, request|
    HttpServer.new(session, request, base_path).serve()
  end
end
# ������ ��� ������� ����� ������� � ������� "�������"=).������ ����, ���� ����� ������������ ��� ����� �������� � �.�.,
# � base_path ������� ���� �� ������ �������� � ������, �� � � server ������� ��� ����� �� 9191 �����
# (�� ������ ������� ����� ������, ���������).

# ������ ����������� ����, � session �� ����� �������� � ����� �������, � request ����� �������, ���������� �� ��������,
# ���������� ��, ��� ����� ���������� � ���������� logs � ����� � ���� server.log
# � ������� $log.info(logs) + ������� � �������, ��, ��� ������������.

# ����� ����� ��� � ����������� � ������� ���.
# ������� �� ����� start, ���������� new.��������� ����� � ��� ������=).�� ������=)

# ������ ��� ���-������� :


require 'socket'
require 'logger'
class HttpServer
  def initialize(session, request, basepath)
    @session = session
    @request = request
    @basepath = basepath
  end

  def getfullpath()
    file_name = @request =~ /^GET\s+(\S+)/i ? $1 : "/"
    file_name = File.expand_path(file_name, @basepath)
    file_name << "index.html" if File.directory?(file_name)
    return file_name
  end

  def serve()
    temp = getfullpath()
    begin
      if File.exist?(@basepath + temp) and File.file?(@basepath + temp)
        @session.puts "HTTP/1.1 200 OK\r\nDate: #{Time.now.localtime.strftime("%a, %d %b %Y %H:%M:%S GTM")}\r\nServer: KriM\r\nContent-type: #{getcontenttype(temp)}; charset=utf-8\r\n\r\n"
        @session.puts IO.read(@basepath + temp)
        @session.puts Time.now.localtime.strftime("%a, %d %b %Y %H:%M:%S GTM")
      else
        @session.puts "HTTP/1.1 404 Object Not Found\r\nServer: KriM\r\n\r\n"
        @session.puts "page not found, 404"
      end
    ensure
      @session.close
    end
  end

  def getcontenttype(path)
    ext = File.extname(path)
    type = {
        ".html " => " text/html ",
        ".htm " => " text/plain ",
        ".txt " => " text/plain ",
        ".css " => " text/css ",
        ".jpeg " => " image/jpeg ",
        ".jpg " => " image/jpeg ",
        ".gif " => " image/gif ",
        ".bmp " => " image/bmp ",
        ".rb " => " text/plain ",
        ".xml " => " text/xml ",
        ".xsl " => " text/xml "
    }
    return type[ext] || " application/octet-stream " unless type.key?(ext)
  end
end
$log = Logger.new('server.log')
base_path = "/home/krim/web "
server = TCPServer.new('localhost', 9191)
loop do
  session = server.accept
  request = session.gets
  logs = " \n=================================================== \n "
  logs += " #{session.peeraddr[2]} (#{session.peeraddr[3]})\n"
  logs += "\n#{request}"
  $log.info(logs)
  puts logs
  Thread.start(session, request) do |session, request|
    HttpServer.new(session, request, base_path).serve()
  end
end