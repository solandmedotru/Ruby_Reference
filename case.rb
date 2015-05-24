# Операторы контроля

# В этой заметке мы рассмотрим операторы контроля( это "?" и "case")

# 1) Использование условоного оператора "?"
age = 25
res = age < 18 ? "teenager" : "not teenager"
# Опишем нашу конструкцию
# В результат(res) запишется либо "teenager", либо "not teenager" — это зависит условия( age < 18) , если оно true, то записывается первое("teenager"), если false, то соответственно второе("not teenager").

# 2) Использование условного оператора case
# Case можно использовать в трёх видах:

# Многострочный
age = 25
case
  when age < 18
    puts "teenager"
  when age > 18
    puts "not teenaget"
  when age > 60 && age < 100
    puts "old people"
  else
    puts "very old people"
end

# Однострочный(первый вариант)
age = 25
case
  when age < 18; puts "teenager"
  when age > 18; puts "not teenaget"
  when age > 60 && age < 100; puts "old people"
  else puts "very old people"
end

# Одностроный(второй вариант)
age = 25
case
  when age < 18 then puts "teenager"
  when age > 18 then puts "not teenaget"
  when age > 60 && age < 100 then puts "old people"
  else puts "very old people"
end