# collect player information from each draft from 1970 onward (more than 3 rounds in the draft)
import pandas as pd
import numpy as np
import requests # type: ignore

# directory links
OUTPUT_DIRECTORY = './server/web_scraping/player_draft_data/'
LINK = 'https://www.hockeydb.com/ihdb/draft/nhl{year:4d}{add}.html'
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36'}

# web scrape HockeyDB to get draft stats and totals
for yr in range(1970, 2025):
    add = 'a' if yr<1979 else 'e'
    try:
        df = pd.read_html(LINK.format(year=yr,add=add), storage_options={'User-Agent': headers['User-Agent']})[0]
        df.columns=df.columns.droplevel(0) # remove the round from the table
        df=df[df['Round'].str.contains('Round')==False] # remove non-data rows
        df.to_csv(OUTPUT_DIRECTORY+str(yr)+add,index=False) # export CSV to directory
    except requests.exceptions.HTTPError as e:
        print(f"HTTP Error: {e}") # close out of application if this happens
        raise
