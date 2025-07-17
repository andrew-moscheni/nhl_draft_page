# collect player information from each draft from 1970 onward (more than 3 rounds in the draft)
# this is to fill DB with initial information, not to use when updating the DB
import pandas as pd
import numpy as np
import requests # type: ignore
from datetime import datetime

# directory links
OUTPUT_DIRECTORY = './server/web_scraping/player_draft_data/'
LINK = 'https://www.hockeydb.com/ihdb/draft/nhl{year:4d}{add}.html'
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36'}

# web scrape HockeyDB to get draft stats and totals
first_year = 1970
current_year = int(datetime.now().year)
for yr in range(first_year, current_year):
    add = 'a' if yr<1979 else 'e'
    try:
        df = pd.read_html(LINK.format(year=yr,add=add), storage_options={'User-Agent': headers['User-Agent']})[0]
        df.columns=df.columns.droplevel(0)
        df=df[df['Round'].str.contains('Round')==False]
        df['Drafted From'] = df['Drafted From'].apply(lambda input: input.split('[')[1].split(']')[0] if '[' in input else np.nan)
        df.to_csv(OUTPUT_DIRECTORY+str(yr)+add,index=False)
    except requests.exceptions.HTTPError as e:
        print(f"HTTP Error: {e}")
        raise
