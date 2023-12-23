#This python code is prompt engineered by using ChatGPT4 of Bing browser.

import pandas as pd
import numpy as np
import yfinance as yf
import matplotlib.pyplot as plt

# Define your trading parameters
symbol = "SPY"  # Ticker symbol for SPY500
rsi_period = 14  # RSI period
rsi_overbought = 70
rsi_oversold = 30

# Download historical data
data = yf.download(symbol, start="2020-01-01", end="2023-12-31")

# Calculate price differences
delta = data["Close"].diff()

# Calculate gains (up) and losses (down)
up = delta.clip(lower=0)
down = -delta.clip(upper=0)

# Calculate rolling averages
ma_up = up.rolling(window=rsi_period).mean()
ma_down = down.rolling(window=rsi_period).mean()

# Calculate RSI
rsi = 100 - (100 / (1 + ma_up / ma_down))

# Generate trading signals
data["LongSignal"] = np.where(rsi < rsi_oversold, 1, 0)
data["ShortSignal"] = np.where(rsi > rsi_overbought, -1, 0)

# Calculate position
data["Position"] = data["LongSignal"] + data["ShortSignal"]

# Backtesting
data["Returns"] = data["Position"].shift(1) * data["Close"].pct_change()
cumulative_returns = (1 + data["Returns"]).cumprod()

# Plot RSI and trading signals
plt.figure(figsize=(10, 6))
plt.subplot(2, 1, 1)
plt.plot(data.index, rsi, label="RSI", color="blue")
plt.axhline(rsi_overbought, color="red", linestyle="--", label="Overbought")
plt.axhline(rsi_oversold, color="green", linestyle="--", label="Oversold")
plt.title("Relative Strength Index (RSI)")
plt.legend()

plt.subplot(2, 1, 2)
plt.plot(data.index, cumulative_returns, label="Cumulative Returns", color="purple")
plt.axhline(1, color="gray", linestyle="--", label="Baseline")
plt.title("Cumulative Returns")
plt.legend()

plt.tight_layout()
plt.show()