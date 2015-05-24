# ��������� ��������

# � ���� ������� �� ���������� ��������� ��������( ��� "?" � "case")

# 1) ������������� ���������� ��������� "?"
age = 25
res = age < 18 ? "teenager" : "not teenager"
# ������ ���� �����������
# � ���������(res) ��������� ���� "teenager", ���� "not teenager" � ��� ������� �������( age < 18) , ���� ��� true, �� ������������ ������("teenager"), ���� false, �� �������������� ������("not teenager").

# 2) ������������� ��������� ��������� case
# Case ����� ������������ � ��� �����:

# �������������
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

# ������������(������ �������)
age = 25
case
  when age < 18; puts "teenager"
  when age > 18; puts "not teenaget"
  when age > 60 && age < 100; puts "old people"
  else puts "very old people"
end

# �����������(������ �������)
age = 25
case
  when age < 18 then puts "teenager"
  when age > 18 then puts "not teenaget"
  when age > 60 && age < 100 then puts "old people"
  else puts "very old people"
end