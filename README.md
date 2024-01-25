# NHL Rookie Year Predictions
This is a personal project of mine to predict the statline of NHL rookies the year they entered the league.

Right now there is only an iPYNB file in the repository because it is easier to visualize the data during the preprocessing phase. Later iterations of this project include CLI to look up a rookie and their predicted statlines, as well as entering a rookie with certain details and predicting their statlines.

# Current Stage
Currently, this project is still in the pre-processing phase, but once the web scraping is complete and all the tables are merged, then the next phase of this project can commence. 

Phase 2 is taking the statistics and running ANOVA tests to figure out which statistics are significant between different variables that will be regressed on

# Future Plans
- Phase 2, as mentioned before, is finding significance between mutliple variables and the expected outputs.
- Phase 3 will be creating the models, beginning with "straightforward" models, such as SVMs and Decision Trees, and then branching to a neural network
- Phase 4 will be training the models and tuning the hyperparameters.
- Phase 5 will be analysis of the models' performances and plotting how the model performed in projecting statistics
- Phase 6 wil be what was mentioned before--creating a CLI for this project and migrating it from a iPYNB file to a formal python file, creating a CLI for access to the projections.
- Phase 7 will be putting "finishing touches" on the program.
