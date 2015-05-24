# ������
#
# ������ ������������ � ���� �������:


# 1) ����� ��� ������ ������ ��������� � ������ ������������ ������ ���������� Ruby � namespaces

module Romantic
  class Date

  end
end
var = Romantic::Date.new #=> ��������� ��� ����� Date
date = Date.new #=>  ��������� ����������� ����� Date �� ���������� ruby

# 2) ����� ������ ����������(��������������, include) � ������ � mix-ins

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
# ����� �� ������ ������ ContactInfo,  ��� �������� � ����� Friends � ��� ������ �� ������ ContactInfo ������ �������� �� ������ Friends.
# ����� �� ��������� ����� Friends ������ MyJob, ��� ��� �� ������� ��� � ���, ��� ��� ������ ������ Friends ����� �������� �� ������ MyJob.