# Сетевые возможности

# Сетевые возможности ruby мы рассмотри на примере написания web-servera.

# Итак, начнём

# Для начала нам понадобится http://www.ruby-doc.org/core/ и далее, при написании хороших программ - всегда будем смотреть именно туда, 
# чтобы не изобретать велосипед. Многие читатели моего блога, думаю, знаю про WebRick( это уже написанный полнофункциональный веб сервер на языке ruby), 
# о нём можно почитать  здесь. Но мы напишем свой web-сервер, дабы показать возможности ruby.
# Нам понадобятся две библиотеки( 'socket' и 'logger'). 
# Первая, как вы догадались для работы с сокетами, вторая для логгирования.
# Назовём наш класс HttpServer и добавим переменные инициализации:
class HttpServer
  def initialize(session, request, basepath)
    @session = session
    @request = request
    @basepath = basepath
  end
end
# session - переменная, в которую пишется наша сессия.
# 
# request - переменная, куда пишется запрос, который приходит от браузера.
# 
# basepath - каталог, где лежит наш сайт.

# Начнём разбирать "путь запроса файла".Почитать про заголовки, можно здесь

def getfullpath()
  file_name = @request =~ /^GET\s+(\S+)/i ? $1 : "/"
  file_name = File.expand_path(file_name, @basepath)
  file_name << "index.html" if File.directory?(file_name)
  return file_name
end

# Используя регулярное выражение мы получаем имя файла и путь до него, который нужный отдать серверу.
# Далее нам нужен полный путь файла, чтоб найти его на жёстком диске.
# Идём в документацию, смотрим что у нас есть по работе с файлами, опа, 
# нашли expand_path - это именно то, что нам нужно, используя его, получаем полный пусть к файлу.
# А если у нас запрашивается не файл, а папка? - выход прост - проверяем, запрашивается ли дирректория? - если да, то отдаём "index.html".

# Теперь надо расмотреть то, как мы будем отдавать файлы браузеру.Для этого нам надо почитать ещё это.

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

# Записываем в temp путь к файлу, Если файл есть, то отправляем браузеру состояние 200(я надеюсь вы почитали об этом).
# Ну и дальше по стандарту - время, имя сервера, тип данных(для этого есть функция getcontenttype - о ней чуть позже),
# затем кодировка.

# Об классе IO я рассказывал в предыдущих заметках.Читаем файл и печатаем его в сессию(данные отправляются в бразуер),
# далее я, для проверки просто вывожу время.

# Если файл не найден на жёстком диске, то надо вывести ошибку 404, сказать пользователю о том, что файл не найден на сервере.

# Ну и закрываем сессию=) Если вы читали предыдущую заметку, то думаю не надо объяснять зачем нужна конструкция вида begin
# -
# ensure
# -
# end.

# Рассмотрим функцию getcontenttype.Она очень простая, получаем тип запрашиваемого файла, создаём хэш массив
# (смотрим предыдущие заметки) с типами файлов(ключ) и возвращаемым типом контента(значение)

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

# Объясню лишь последнюю строчку, возвращаем значение по ключу, или возвращаем " application/octet-stream ", если такого ключа нету.
# Всё, класс написан=)

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
# Рассмотрим теперь логирование и запуск сервера.

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
# Первые три строчки можно отнести к разряду "конфига"=).Создаём файл, куда будет записываться лог наших запросов и т.д.,
# в base_path запишем путь до нашего каталога с сайтом, ну а в server запишем наш сокет на 9191 порту
# (вы можете выбрать любой другой, свободный).

# Создаём бесконечный цикл, в session мы будем работать с нашей сессией, в request пишем запросы, получаемые от браузера,
# записываем то, что хотим логировать в переменную logs и пишем в файл server.log
# с помощью $log.info(logs) + выводим в консоль, то, что залогировали.

# Далее опять идём в документаци и смотрим тут.
# Смотрим на метод start, аналогичен new.Запускаем поток и сам сервер=).Всё готово=)

# Полный код веб-сервера :


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