# NHL Rookie Year Predictions
This is a personal project of mine to predict the statline of NHL rookies the year they entered the league.

Right now there is only an iPYNB file in the repository because it is easier to visualize the data during the preprocessing phase. Later iterations of this project include CLI to look up a rookie and their predicted statlines, as well as entering a rookie with certain details and predicting their statlines.

# Current Stage
The pre-processing phase has currently been completed, combining the draft information from Kaggle with the data from each player's rookie year.

Phase 2 is underway, taking the statistics and running ANOVA tests to figure out which statistics are significant between different variables that will be regressed on.

# Future Plans
- Phase 3 will be creating the models, beginning with "straightforward" models, such as SVMs and Decision Trees, and then branching to a neural network.
- Phase 4 will be training the models and tuning the hyperparameters.
- Phase 5 will be analysis of the models' performances and plotting how the model performed in projecting statistics.
- Phase 6 wil be what was mentioned before--creating a CLI for this project and migrating it from a iPYNB file to a formal python file, creating a CLI for access to the projections.
- Phase 7 will be putting "finishing touches" on the program.
