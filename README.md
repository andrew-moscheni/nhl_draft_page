# NHL Draft and Player Predictions Page
This is a personal project of mine to predict NHL statistics of draft-eligible players. This page will be comprised of a welcome page, a draft predictions page, and a player page to predict the next few games' worth of statistics.

This page will be connected to a PostgreSQL database to store all the data. Each player will have their stats recorded and updated as the season progresses, ensuring accurate and updated predictions are captured.


# Current Stage
Web-scraping hockey sites for the data is in progress.


# Next Steps
- Once the database is populated, then the draft prediction model can be developed. The exact model has yet to be determined.
- After the draft prediction model, then we would use an Autoregressive Conditional Poisson (ACP) model to predict the next games' worth of data for a specific player based upon their previous game stats.
