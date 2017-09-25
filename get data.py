import requests
res = requests.get('http://www.cwb.gov.tw/V7/forecast/')
print(res.text)
print(res.url)

print("--------------You can see the data under this dotted line--------------\n")
from selenium import webdriver
import time 
web = webdriver.Chrome('C:\Python34\chromedriver.exe')
web.get('http://www.cwb.gov.tw/V7/')
time.sleep(3)
web.find_element_by_link_text('天氣預報').click() #點擊頁面上"天氣預報"的連結
time.sleep(5)
text = web.find_element_by_tag_name("body")
post_elems = web.find_elements_by_tag_name("a")
for post in post_elems:
    print (post.text)
web.close()