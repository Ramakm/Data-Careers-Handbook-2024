import requests
import pandas as pd
import json

# We will be parsing data for 2019/20 Season 
SEASON_ID = 274
#Url to get id of all players that played in the season
URL = "https://footballapi.pulselive.com/football/players"
#Empty DataFrame
df = pd.DataFrame()

# Headers required for making a GET request

headers = {
    "content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
    "DNT": "1",
    "Origin": "https://www.premierleague.com",
    "Referer": "https://www.premierleague.com/players",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36"
}
# Query parameters required to make get request
queryParams = {
    "pageSize": 1500,
    "compSeasons": SEASON_ID,
    "altIds": True,
    "page": 0,
    "type": "player",
    
}
# Sending the request with url, headers, and query params
response = requests.get(url = URL, headers = headers, params = queryParams,verify=False)

# if response status code is 200 OK, then
if response.status_code == 200:
    # load the json data
    data = json.loads(response.text)
    # Iterating each player
    for player in data["content"]:
        # Excluding Players on loan
        if 'loan' not in player['info']:
            
            stat_dict={}

            stat_dict.update( {'id':player['id'] ,'Position':player['info']['positionInfo'] ,'Position_info':player['info']['position'],'First_Name':player['name']['first'] ,'Last_Name':player['name']['last'] } )
            # Adding player id as query to get in-depth stat for the player
            stat_url='https://footballapi.pulselive.com/football/stats/player/'+str(int(player['id']))
            stat_queryParams = {
                "comps": 1,
                "compSeasons": SEASON_ID,
   
            }
            response = requests.get(url = stat_url, headers = headers, params = stat_queryParams,verify=False)
            if response.status_code == 200:
                # load the json data
                data = json.loads(response.text)
                # Checking if stats are available
                if data['stats'] and len(data)==2:
                    for stat in data['stats']:
                        stat_dict.update( {stat['name']:stat['value']})
            
            df = df.append(stat_dict,ignore_index=True,sort=False)
df.to_csv('player_data.csv')
print(df)