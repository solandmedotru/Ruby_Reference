# Модули
#
# Модули используются в двух случаях:


# 1) Когда имя вашего класса совпадает с именем стандартного класса библиотеки Ruby — namespaces

module Romantic
  class Date

  end
end
var = Romantic::Date.new #=> создастся ваш класс Date
date = Date.new #=>  создастся стандартный класс Date из библиотеки ruby

# 2) Когда модуль инклудится(присоединяется, include) к классу — mix-ins

module ContactInfo
  attr_accessor :first_name, :last_name, :phone_number
  def full_date
    self.first_name + ' ' + self.last_name + ': ' + self.phone_number
  end
end
class Friends
  include ContactInfo
end
class MyJob < Friends
  attr_accessor :profession
end
# Здесь мы создаём модуль ContactInfo,  его инклудим в класс Friends — все методы из модуля ContactInfo теперь доступны из класса Friends.
# Затем мы наследуем класс Friends классы MyJob, что так же говорит нам о том, что все методы класса Friends будут доступны из класса MyJob.