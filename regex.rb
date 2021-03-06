# ������ � ����������� �����������

# ��� ���� ����� ���������� ���������(�������)?
# ������� �������� ����������� ������, ������� ����� ������� ��������� �������. 

# ������� ������:

/(MyISAM|InnoDB)/
/^GET\s+(\S+)/i
# �������� ������=) �� ����� ���� �� �� ��� ������, ������� � �� �������.


# ������� ������� ��:

# ���������� ������
# ��������������
# ������������
# �����������
# ������������
# ���������� ������ ����� ��������

# ���������� ������
# ���������� ����� - ������ �������� ����� ��������.

/[abcde]/ #=> ������� ������������ ��������
/[A-Z�-�]/ #=> ��� ��������� � ������� ���������
/[0-9a-z]/ #=> ����� � �������� ��������
/[^0-9]/ #=> ��� �������, ����� ����

# ��� ����� ����� �������� �������������� ����������� �������� "[" � "]".
# ���� �� ����� ������� �������� ��������, �� �� ���������� ����� "-", ��� �� � ����� � ��������. 
# ������ "^" �������� ���������, �.�. ���� ������(�������� ��������) ����� ��������. 
# ��������� ��� �������� ����������� ����������� �������.

# ����������� ����������� ���������� �������
# \s       - [\f\t\n\r]           - ���������� ������
# \S      - [^\f\t\n\r]         - ����� ������, ����� �����������
# \d      - [0-9]                 - �����
# \D     - [^0-9]               - ����� ������, ����� �����
# \w     - [a-zA-Z0-9]     - �������� ��� �����
# \W    - [^a-zA-Z0-9]   - ����� ������, ����� �������� ��� �����
# [^\n\r]               - ����� ������, ����� �������� ������
# \b                                   - ������� �����
# \B                                  - �� ������� �����
# \A                                  - ������ ������
# \Z                                  - ����� ������
# �������������
# ������������� ���������� ������� ��� ����� ����������� ���������� ������(��� ������ ��������)

# /\d{3}/ #=> ��� �����
# /\d{1, 3}/ #=> ����, ��� ��� ��� �����
# /[a-zA-Z]{3, }/ #=> ��������� ����� ������� ��� ������� � ������
# �������������, ������� ������ ���� ��������, ���������� ������, �.�.��������� ������ ���������� ����������.
# �������������, ������� ��� ���������, ���������� ��������, �.�.��������� �������� ��������, � ������� ����������� ���������� ����������.
# �������������, ������� ���� �������� � �������, ���������� �����������, �.�.������������ ���������� ���������� ���� " ����� ".
# ����������� ����������� ���������������
# * - {0, } - ����� ����������
# + - {1, } - ���� � �����
# ? - {0, 1} - ���� ��� ���
# ������������
# �������, �������� � ������������, ����������� | (������������ ������, ������� � �������� �������������).
# ������������ �����, ����� ���������� ���������� ��������� ������ � ����.��� ���� ���������� �������������, ����� ���� ���������� ���� �� � ����� ��������.
# ������������ ���������� ��������� � ������.
                                                                                                                                                                                                                                                                                                   /(\w+|[�-��-�]+)/ #=> ��� ����� �� ��������, ��� �������
# �����������
# ����������� ������������, ����� ���������� ������������ ��������� �������.
# ��������, ��� ��������� ������ � HTML-��������� ������ �������� ������������ ����� ������ � URL.
# ����������� ����� ��� � ������������, ����������� � ������� ������.����� ����, ������������ �������������� ��� �����������.
# ������ � ���������� ���������� ������ ����������� �������������� ����������� ����������� ���������� $1, $2, ..., $9.
# " 2+7*3 ".gsub(/(\d+)\*(\d+)/) { $1.to_i * $2.to_i } #=> "2+21
# ���������� ����� ����� �����������.��������, (?: ...) - ����������� ��� ���������� ���������� � " ���������� ���������� "
# ��� (?! ...) - ���������� �����������.� ����� ������ ��� �������������� ����� ������� ������.

# ����������� ���������
# ����������� ��������� - ��� �������, ������� ����������� ������� � ���������� ��������.��������, � ����� ��� ������ ������.

# /^ \ d+/ #=> ������ ���������� � �����
# / \ w+$/ #=> ��������� ����� �� �������� ��� �����
# /^$/ #=> ������ ������
#  ^ - �������� � ������ ������,
#  $ - �������� � ����� ������.

# �����������
# ����������� ������������ ��� ��������� ��������� �������.�� ����������� ����� �� ����� ������� (����� ��������� ��������� �����).

# /(hello|world)/i #=> ��� "hello", ��� "world". ������ ���������� �� ��������
# /\s+/mix #=> ��������� ������ ������ ���������� ��������
# ������������:

# multiline - ������� ������ ��������� ������� ��������
# ignorcase - ����� ��� ����� ��������(������ ��� ��������)
# extended - ������������ ���������� �������