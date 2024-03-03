
import json
import requests


#api calls in python

print("output of 1 python script")
#1
url = "https://api.carbonintensity.org.uk/intensity/factors"

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)

print("output of 2 python script")


#2
url = "https://api.carbonintensity.org.uk/regional/england"

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)

print("output of 3 python script")
#3
url = "https://api.carbonintensity.org.uk/regional/postcode/RG10"

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)

print("output of 4 python script")
#4
url = "https://api.carbonintensity.org.uk/regional/regionid/6"

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)

print("output of 5 python script")
#5
url = "https://api.carbonintensity.org.uk/regional/intensity/2021-11-27T05:00Z/fw24h"

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)

print("output of 6 python script")
#6
url = "https://api.carbonintensity.org.uk/regional/intensity/2021-11-27T05:00Z/fw24h/regionid/3"

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)

print("output of 7 python script")
#7
url = "https://api.carbonintensity.org.uk/intensity/stats/2018-01-20T12:00Z/2018-01-20T12:30Z"

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)

print("output of 8 python script")
#8
url = "https://api.carbonintensity.org.uk/intensity/stats/2018-01-20T12:00Z/2018-01-20T12:30Z/10"

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)

print("output of 9 python script")
#9
url = "https://api.carbonintensity.org.uk/intensity/2018-01-20T12:00Z/pt24h"

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)

print("output of 10 python script")
#10
url = "https://api.carbonintensity.org.uk/regional/intensity/2021-11-27T05:00Z/pt24h/regionid/3"

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)







# pytest start from here
#1
def test_fasctors_url():
    url = "https://api.carbonintensity.org.uk/intensity/factors"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    assert type(data['data'][0]['Biomass']) is int
    print(response.text)
#2
def test_enngland_url():
    url = "https://api.carbonintensity.org.uk/regional/england"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    assert response.status_code == 200 , 'Something wrong with url'
    print(response.text)
#3
def test_postcode_url():
        url = "https://api.carbonintensity.org.uk/regional/postcode/RG10"
        payload = {}
        headers = {}
        response = requests.request("GET", url, headers=headers, data=payload)
        data = json.loads(response.text)
        assert data['data'][0]['postcode'] == 'RG10', 'not Matching'
        print('postcode :', data['data'][0]['postcode'])

#4
def test_regiodid_url():
    url = "https://api.carbonintensity.org.uk/regional/regionid/6"
    payload = {}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    assert response.status_code == 200, 'Something wrong with url'
    print(response.text)

#5
def test_date_url():
    url = "https://api.carbonintensity.org.uk/regional/intensity/2021-11-27T05:00Z/fw24h"
    payload = {}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    assert data['data'][0]['from'] == "2021-11-27T04:30Z", 'not Matching'
    print(response.text)

#6
def test_dateregfwd_url():
    url = "https://api.carbonintensity.org.uk/regional/intensity/2021-11-27T05:00Z/fw24h/regionid/3"
    payload = {}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    assert response.status_code == 200, 'Something wrong with url'
    print(response.text)

#7
def test_fromto_url():
    url = "https://api.carbonintensity.org.uk/intensity/stats/2018-01-20T12:00Z/2018-01-20T12:30Z"
    payload = {}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    assert response.status_code != 300, 'Something wrong with url'
    print(response.text)

#8
def test_fromtoblock_url():
    url = "https://api.carbonintensity.org.uk/intensity/stats/2018-01-20T12:00Z/2018-01-20T12:30Z/10"
    payload = {}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    assert response.status_code != 500, 'Something wrong with url'
    print(response.text)

#9
def test_frompast_url():
    url = "https://api.carbonintensity.org.uk/intensity/2018-01-20T12:00Z/pt24h"
    payload = {}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    assert data['data'][0]['intensity']['forecast'] == 264, 'not Matching'
    print(response.text)

#10
def test_frompastdate_url():
    url = "https://api.carbonintensity.org.uk/regional/intensity/2021-11-27T05:00Z/pt24h/regionid/3"
    payload = {}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    assert response.status_code == 500, 'Something wrong with url'
    print(response.text)

#11
def test_regscot_url():
    url = "https://api.carbonintensity.org.uk/regional"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    assert type(data['data'][0]['regions']) is list
    print(response.text)

#12
def test_regwales_url():
    url = "https://api.carbonintensity.org.uk/regional"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    assert type(data['data'][0]['from']) == type(data['data'][0]['to'])
    print(response.text)

#13
def test_intensreg_url():
    url = "https://api.carbonintensity.org.uk/regional/intensity/2021-01-20T12:00Z/fw48h"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    true = type(data['data'][0]['from']) is str
    assert true is True
    print(response.text)

#14

def test_intens_url():
    url = "https://api.carbonintensity.org.uk/intensity/2018-01-20T12:00Z"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    list_one = data['data'][0]
    assert 5 not in list_one
    print(response.text)
#15

def test_intenscount_url():
    url = "https://api.carbonintensity.org.uk/intensity"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    list_one = data['data'][0].keys()
    assert len(list_one) == 3
    print(response.text)

#16

def test_datepriod_url():
    url = "https://api.carbonintensity.org.uk/intensity/date/2018-01-20T12:00Z/20"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    list_one = data['data'][0]['intensity'].keys()
    assert len(list_one) == 3
    print(response.text)
#17
def test_dategenom_url():
    url = "https://api.carbonintensity.org.uk/generation/2021-01-20T10:30Z/2021-01-20T11:00Z"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    list_one = data['data'][0]
    assert any(list_one) == True
    print(response.text)
#18

def test_genom_url():
    url = "https://api.carbonintensity.org.uk/generation"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    assert len(data) <= 3
    print(response.text)
#19
def test_fw2h_url():
    url = "https://api.carbonintensity.org.uk/regional/intensity/2021-11-27T05:00Z/fw24h"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    s=data['data'][0]['regions']
    assert type(s) is list
    assert s[0]['dnoregion']=='Scottish Hydro Electric Power Distribution'
    print(response.text)

# 20
def test_perc_url():
    url = "https://api.carbonintensity.org.uk/generation/2021-01-19T12:00Z/pt24h"
    payload = {}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    data = json.loads(response.text)
    s = data['data'][0]['generationmix']
    assert type(s[0]['perc']) == float
    print(response.text)