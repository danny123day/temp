import random
string_length = 32

#zfill回傳32bit長度值並且以0補齊
def _bin_string(num):
	return bin(num)[2:].zfill(string_length)

# ^ 二進位位元互斥
def _invert_at(s,index):
	return bin(int(s,2) ^ 2 ** (index))[2:].zfill(string_length)

def _int_from_bin(s):
	return int(s,2)

#分數函數
def score(num):
	return num | N

#交配
def f1(num1 , num2):
	s1 = _bin_string(num1)
	s2 = _bin_string(num2)
	return _int_from_bin(s1[0:15] + s2[16:31])

#突變
def f2(num):
	i = random.randint(0,31)
	s = _bin_string(num)
	ss = _invert_at(s,i)
	return _int_from_bin(ss)

#存活函數
def is_conceptable(num):
	if num > U :
		return False
	elif num < L :
		return False
	else : return True

L = 201310 
U = 3567891 
N = 30951344

p1 = L
p2 = U

i = 0 
for j in range(1000):
	m1 = f2(f1(p1,p2)) #上下界交配
	m2 = f2(m1)	#交配後突變

	if not is_conceptable(m1) :
		print(j,"m1 is not conceptable")
		continue
	if not is_conceptable(m2) :
		print(j,"m2 is not conceptable")
		continue

	score0 = score(p1) #下界分數
	score1 = score(m1) #交配分數
	score2 = score(m2) #突變分數
	#判斷判斷突變前後哪個分數高 (來判斷是否要突變)
	if score1 > score2 :
		d = m1
	elif score1 < score2 :
		d = m2
	else :
		d = min(m1,m2)
	score3 = score(d) #最佳解分數

	if score0 > score3 :#下界分數大於最佳解分數
		p2 = d #上界替換為最佳解 範圍 : L < m < d
	elif score0 < score3 :#下界分數小於最佳解分數 (d 已小於下屆)
		p2 = p1 
		p1 = d
	else :
		p1 = min(p1,d)
		p2 = max(p1,d)

	i += 1
	print(j ,"L :", p1 ,"U :", p2 )
print("\n" , i , p1 , p2)




















