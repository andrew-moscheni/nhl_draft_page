# use the FastAPI to easily integrate the ACP model into the application
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Dict, List

app = FastAPI(
    title="Player Draft and Season Prediction API",
    description="API for predicting draft player success and stat predictions over the next few games.",
    version="1.0.0"
)

# Configure CORS (Cross-Origin Resource Sharing)
origins = [
    "http://localhost",
    "http://localhost:8000", # frontend is served from port 8000
    "http://localhost:5500", # Common for Live Server VS Code extension
    # Add the production URL of your frontend here when deployed, e.g., "https://your-frontend-domain.com"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,       # Allows specific origins
    allow_credentials=True,      # Allow cookies to be sent with requests
    allow_methods=["*"],         
    allow_headers=["*"],
)

# Pydantic models for response data
class PlayerTotals(BaseModel):
    total_goals: int
    total_assists: int
    games_played: int
    total_points: int
    total_plus_minus: int
    total_pims: int

class Game(BaseModel):
    goals: int
    assists: int
    points: int
    plus_minus: int
    pims: int

class PlayerGamePrediction(BaseModel):
    previous_games: List[Game]
    predicted_games: List[Game]

# get the predicted draft totals of a player
def get_predicted_draft_totals() -> Dict[str, str]:
    """
    Fetch the prediction of a player's draft totals. Then, use a simple regression model or 
    maybe a neural network to predict a prospective player's statlines.
    """
    # insert the machine learning model here to generate totals
    prediction = {
        "total_goals": 0,
        "total_assists": 0,
        "total_games_played": 0,
        "total_points": 0,
        "total_plus_minus": 0,
        "total_pims": 0
    }
    return prediction

# get the predicted statlines of a player over numerous games
def get_predicted_game_totals() -> Dict[str, str]:
    """
    Fetch the previous game statlines for a player. Then, use Autoregressive Conditional Poisson
    to predict the next few games for a player.
    """
    # insert the ACP model here to generate totals
    prediction = {
        "previous_games": [],
        "predicted_games": []
    }
    return prediction

# define routes to make the player predictions
@app.get("/predict_draft_totals", response_model=PlayerTotals, summary="Predict a player's career totals.")
async def predict_draft_totals_endpoint():
    """
    Retrieves the career totals of a prospective player.
    """
    try:
        draft_data = get_predicted_draft_totals()
        return draft_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Internal server error: {e}")
    
@app.get("/predict_game_stats", response_model=PlayerGamePrediction, summary="Predict a player's game stats.")
async def predict_game_stats_endpoint():
    """
    Retrieves the game statistics of a player.
    """
    try:
        game_data = get_predicted_game_totals()
        return game_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Internal server error: {e}")

@app.get("/")
async def read_root():
    return {"message": "Welcome to the NHL Player Prediction API! Access /docs for API documentation."}