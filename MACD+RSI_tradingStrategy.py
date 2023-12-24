import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Load historical price data (e.g., from a CSV file)
df = pd.read_csv("historicalData.csv")

# Calculate MACD
df["12-day EMA"] = df["Close"].ewm(span=12).mean()
df["26-day EMA"] = df["Close"].ewm(span=26).mean()
df["MACD"] = df["12-day EMA"] - df["26-day EMA"]

# Calculate RSI
delta = df["Close"].diff()
gain = np.where(delta > 0, delta, 0)
loss = np.where(delta < 0, -delta, 0)
avg_gain = pd.Series(gain).rolling(window=14).mean()
avg_loss = pd.Series(loss).rolling(window=14).mean()
rs = avg_gain / avg_loss
df["RSI"] = 100 - (100 / (1 + rs))

# Calculate MACD signal line
df["Signal"] = df["MACD"].ewm(span=9).mean()

# Generate buy/sell signals
df["Buy Signal"] = (df["MACD"] > df["Signal"]) & (df["RSI"] > 30)
df["Sell Signal"] = (df["MACD"] < df["Signal"]) & (df["RSI"] < 70)

# Backtest and visualize
# ... (implement your backtesting and visualization logic)

# Print summary statistics
print(df.head())

# Plot MACD, RSI, and buy/sell signals
plt.figure(figsize=(10, 6))
plt.plot(df["Date"], df["MACD"], label="MACD")
plt.plot(df["Date"], df["RSI"], label="RSI")
plt.scatter(df["Date"][df["Buy Signal"]], df["MACD"][df["Buy Signal"]], color="green", marker="^", label="Buy Signal")
plt.scatter(df["Date"][df["Sell Signal"]], df["MACD"][df["Sell Signal"]], color="red", marker="v", label="Sell Signal")
plt.legend()
plt.show()