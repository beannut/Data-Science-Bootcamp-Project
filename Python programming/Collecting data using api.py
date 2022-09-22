from requests import get
import time
# endpoint
url = "https://jsonplaceholder.typicode.com/users/"
response = get(url)
response.status_code

from requests import get
import time
base_url = "https://jsonplaceholder.typicode.com/users/"

username = []
email = []
company = []

for i in range(10):
    url = base_url + str(i+1)   
    response = get(url)
    username.append(response.json()['username'])
    email.append(response.json()['email'])
    company.append(response.json()['company'])
    time.sleep(2) #2seconds
    
    

import pandas as pd
df = pd.DataFrame(
    {"Username": username, "E-mail": email, "Company":company}
)
df.head()
