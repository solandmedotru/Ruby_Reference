# ������� ������ � �����
# Hash

hash = {5 => 3, 1 => 6, 3 => 2}
hash[5] #=> 3
hash[2] #=> nil
hash[3] #=> 2

#������ ������ ������������ ����: ���� � ������� ���������� ��������
#������������� (�� ���� ����������� nil) �������, �� �������������� ������������
#��� � ������������� ��������.
#��������� ������� ���������� ������ ����� ( inject )
array = [1, 2, 1, 2, 3, 2, 1, 2, 4, 5]
array.inject(Hash.new { 0 }) { |result, i|
  result[i] += 1
  result
} #=> {5=>1, 1=>3, 2=>4, 3=>1, 4=>1}

#������ ������ ������������ ����: ���� ��������� ���������� ����� ���������
#�������, �� �������������� ��������� ���. ������, ������ �������� ����������,
#����� ������������ ������������ �������� ��� �����. �� ��� ��� ����� �������
#������, ������� ����� ����������� �����.
hash = {"comp1.mydomen.ru" => "192.168.0.3",
        "comp2.mydomen.ru" => "192.168.0.1",
        "comp3.mydomen.ru" => "192.168.0.2"}
hash["comp1.mydomen.ru"] #=> "192.168.0.3"

#������ ������ ������������ ����: ����� ��������� ����������� ���� �����
#������ � ������, �� �������������� ������������ ���.
array = [1, 2, 1, 2, 3, 2, 1, 2, 4, 5]
array.inject({}) { |result, i| result.update({i => 1}) { |key, old, new| old+new } } #=> {5=>1, 1=>3, 2=>4, 3=>1, 4=>1}

# ��� ������������ � �������� ������? (rehash)
array1 = ["�", "�"]
array2 = ["�", "�"]
hash = {array1 => 100, array2 => 300}
hash[array1] #=> 100
array1[0] = "�"
hash[array1] #=> nil
hash.rehash #=> {["�", "�"]=>100, ["�", "�"]=>300}
hash[array1] #=> 100

# ����������� (hash)
[1, 2, 3].hash #=> 25

# �������� HASH
# �� ����������� �������
array = [1, 4, 5, 3, 2, 2]
Hash[*array] #=> {5=>3, 1=>4, 2=>2}

# �� ���������� �������
array = [[1, 4], [5, 3], [2, 2]]
Hash[*array.flatten] #=> {5=>3, 1=>4, 2=>2}
array = [[1, 5, 2], [4, 3, 2]]
Hash[*array.transpose.flatten] #=> {5=>3, 1=>4, 2=>2}

# ���� ��� ������
hash = {}
hash[1] = 4
hash[5] = 3
hash[2] = 2
hash #=> {5=>3, 1=>4, 2=>2}

# �������� ������ ��� ��������
hash = Hash.new("")
hash["������� ��� ������"] += "� ����-����� ����, "
hash["������� ��� ������"] += "��� �������� �����"
hash #=> {"������� ��� ������"=>"� ���������� ����, ��� �������� �����"}

hash = Hash.new(0)
hash["��������"] += 60
hash["��������"] *= 21
hash #=> {"��������"=>1260}
# �� �������� � ����
{"����" => 400, "������" => 350, "�������" => 200}

# ***************************************

# ������� ���������(������ � �����, ���������)

# ��������� ������� �������� � ������� ������ ( keys � values )
{1=>4, 5=>3, 2=>2}.keys   #=> [1, 2, 5]
{1=>4, 5=>3, 2=>2}.values #=> [4, 3, 2]

# ������ ������ �� �������� ( invert )
hash = {"������ ����"=>4, "������ ����"=>5}
hash.invert                                 #=> {4=>"������ ����", 5=>"������ ����"}

hash = {"������ ����"=>10, "������ ����"=>10}
hash.invert                                      #=> {10=>"������ ����"}
#��������� ��������:   hash.invert.invert  ���������  ���  ���  �  ����������� ����������.

# ���������� ���� ( inject )
array = [1, 2, 1, 2, 3, 2, 1, 2, 4, 5]
array.inject({}){ |result, i| result.update({i=>1}){ |key, old, new| old + new } }   #=> {5=>1, 1=>3, 2=>4, 3=>1, 4=>1}

# ������� ���� �������� ( merge! ��� merge )
hash1 = {3 => "a", 4 => "c"}
hash2 = {5 => "r", 7 => "t"}
hash1.merge!(hash2)          #=> {5=>"r", 7=>"t", 3=>"a", 4=>"c"}
#���� �� ������ ������� ���� ����� ��������� � �����-���� ������ �� ������� �������, �������� ����� �������� �� �������� �� ������� �������.

# ������ �������������� ������� ( size )
hash = {5=>1, 1=>3, 2=>4, 3=>1, 4=>1}
hash.size                             #=> 5

# �������� ���� �� ����� ( delete )
hash = {5=>1, 1=>3, 2=>4, 3=>1, 4=>1}
hash.delete(5)                        #=> 1
hash                                  #=> {1=>3, 2=>4, 3=>1, 4=>1}
hash.delete(5)                        #=> nil

# �������� ������������ ���� ( shift )
hash = {5=>3, 1=>6, 3=>2}
hash.shift                #=> [5, 3]
hash                      #=> {1=>6, 3=>2}

# ������������� � ��������� ������ ( to_a )
hash = {"������� ����"=>10, "��������� ����"=>22}
hash.to_a    #=> [["������� ����", 10], ["��������� ����", 22]]

# ������������ ���� ( sort � sort_by )
hash = {"������� ����"=>4, "��������� ����"=>10}
hash.sort    #=> [["������� ����", 4], ["��������� ����", 10]]

hash = {"������� ����"=>4, "��������� ����"=>10}
hash.sort_by{ |key, value| value } #=> [["������� ����", 4], ["��������� ����", 10]]

# ����� ������������/ ����������� ���� ( max, max_by, min, min_by )
hash = {"������� ����"=>10, "��������� ����"=>22}
hash.max    #=> ["��������� ����", 22]
hash.min    #=> ["������� ����" , 10]

hash = {"������� ����"=>10, "��������� ����"=>22}
hash.max_by{ |key, value| value }                 #=> ["��������� ����", 22]
hash.min_by{ |array| array[0] }                   #=> ["������� ����" , 10]

# ��� ������? ( empty? )
empty_hash = {}
filled_hash = {"�������"=>20, "��������"=>"����������", "���������"=>34}
empty_hash .empty?    #=> true
filled_hash.empty?    #=> false

# ���� ����� ����? ( key? )
pocket = {"�������"=>20, "��������"=>"����������", "���������"=>34}
pocket.key?("�������")    #=> true

# ���� ����� ��������? ( value? )
pocket = {"�������"=>20, "��������"=>"����������", "���������"=>34}
pocket.value?("����������")    #=> true

# ������ � ����������� ( map, find_all, inject )
hash = {"������� ����"=>4, "��������� ����"=>10}
hash.find_all{ |array| array[1] < 5 }    #=> [["������� ����", 4]]
hash.map { |array| "#{array[0]} �� #{array[1]}" }    #=> ["������� ���� �� 4", "��������� ���� �� 10"]
hash.inject(0){ |result, array| result + array[1] }    #=> 14

hash = {"������� ����"=>4, "��������� ����"=>10}
hash.find_all{ |key, value| value < 5 }    #=> [["������� ����", 4]]
hash.map{ |key, value| "#{key} �� #{value}" }    #=> ["������� ���� �� 4", "��������� ���� �� 10"]
hash.inject(0){ |result, (key, value)| result + value }    #=> 14

hash = {"������� ����"=>4, "��������� ����"=>10}
hash.map { | key, value | "#{key} �� #{value}" } #=> ["������� ���� �� 4", "��������� ���� �� 10"]
hash.map                                         #=> [["������� ����", 4], ["��������� ����", 10]]