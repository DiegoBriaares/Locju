import os
import re
import sys
import shutil
import json, requests
import urllib, urllib3
from bs4 import BeautifulSoup

inp = input().split()

Round = inp[0]
PurePath = inp[1]

def CleanPath (ToClean):
	Path = list(ToClean)
	for i in range (0, len(Path)):
		if Path[i] == "\\":
			Path[i] = "/";
	return Path

Path = ""
Path = Path.join(CleanPath(PurePath))
url = "http://codeforces.com/contest/"+Round+"/problems"
flag=0
try:
    data = requests.get(url)
    flag = 1
except Exception as e:
    print ("Direct Connection Failed, trying Proxy")
    fo = open("proxy.txt", "r+")
    http_proxy = fo.read(100)
    fo.close()

    proxyDict = { 
                   "http"  : "http://"+http_proxy
                }

    data = requests.get(url, proxies=proxyDict)
    flag=1

if flag==0:
    print ("Error in Connection to Internet")
    exit(1)

soup = BeautifulSoup (data.text, "lxml")

present=1

for x in soup.findAll('li', 'current'):
    present=0

if present == 0:
	os.chdir("C:/Locju/utilities/visual")
	os.system("unsuccess_round.bat")	
	sys.exit(0)
        
counter = 0
RoundName = Round
for title in soup.findAll('div', 'caption'):
	reg = re.compile(".*>(.+Div\. \d).*<")
	if reg.match(str(title)) is not None: 
		RoundName = str(reg.match(str(title)).group(1))
RoundName = re.sub("Codeforces", "", RoundName)
RoundName = re.sub("Round", "", RoundName)
RoundName = re.sub("Rated", "", RoundName)
RoundName = re.sub("for", "", RoundName)
RoundName = re.sub("\(", "", RoundName)
RoundName = re.sub("\)", "", RoundName)
RoundName = re.sub("\.", "", RoundName)
RoundName = re.sub("^\s+", "", RoundName)
RoundName = re.sub(r"\s+", "_", RoundName)
RoundName = re.sub("#", "", RoundName)
RoundName = re.sub(r"(.*)_(Div_\d)", r"\1-\2", RoundName)
os.chdir("C:/Locju/utilities/visual")
os.system("color_name_round.bat "+ RoundName)
if len(RoundName) >= 30:
	RoundName = Round
Problems = []
for problem in soup.findAll('div', 'problemindexholder'):
	Problems.append(str(problem.get('problemindex')))

print("------------------------------------------------------------------------------")
for div in soup.findAll('div', 'problemindexholder'):
	if (os.path.exists(Path+"/"+RoundName+"/"+Problems[counter]+"/tests")):
		print ("Rewriting on folder "+Problems[counter])
	else:
		os.makedirs(Path+"/"+RoundName+"/"+Problems[counter] + "/tests")
	detach_dir = Path+"/"+RoundName+"/"+Problems[counter] + "/tests/"
	os.chdir(Path+"/"+RoundName+"/"+Problems[counter])
	os.system("locju start")
	incounter = 1
	for item in div.findAll('pre'):
		if incounter%2 == 1:
			att_path = os.path.join(detach_dir, "in"+str(int((incounter + 1)/2)) + ".in")
			f = open(att_path, "w")
		else:
			att_path = os.path.join(detach_dir, "out"+str(int((incounter/2))) + ".out")
			f = open(att_path, "w")
		incounter+=1
		item = str(item).replace("<pre>", "")
		item = str(item).replace("</pre>", "")
		item = str(item).replace("<br/>", "\n")
		allok=1
		if item[0] == '\n':
			f.write(item[1:])
		else:
			f.write(item)
		f.close()
	print ("Parsing problem " + Problems[counter]+"..")
	counter += 1
print ("------------------------------------------------------------------------------")
if counter <= 1:
	os.chdir("C:/Locju/utilities/visual")
	os.system("unsuccess_round.bat")
else:
	os.chdir("C:/Locju/utilities/visual")
	os.system("success_round.bat")

counter = 0
for time_l in soup.findAll('div', 'time-limit'):
	if (not os.path.exists(Path+"/"+RoundName+"/"+Problems[counter]+"/tests/time-limit")):
		os.makedirs(Path+"/"+RoundName+"/"+Problems[counter]+"/tests/time-limit")
	detach_dir = Path+"/"+RoundName+"/"+Problems[counter]+"/tests/time-limit/"
	att_path = os.path.join(detach_dir, "time-limit.out")
	f = open(att_path, "w")
	reg = re.compile(".*>(\d*) second")
	limit = "0"
	if reg.match(str(time_l)) is not None: 
		limit = str(reg.match(str(time_l)).group(1))
	f.write(str(limit));
	f.close()
	counter += 1
