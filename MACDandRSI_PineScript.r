MACDandRSI_PineScript
indicator("MACD and RSI Strategy", overlay=true)

// Calculate MACD
fastLength = 12
slowLength = 26
signalLength = 9
ema12 = ta.ema(close, fastLength)
ema26 = ta.ema(close, slowLength)
macdLine = ema12 - ema26
signalLine = ta.ema(macdLine, signalLength)

// Calculate RSI
rsiLength = 14
rsi = ta.rsi(close, rsiLength)

// Generate buy/sell signals
buySignal = ta.crossover(macdLine, signalLine) and rsi > 30
sellSignal = ta.crossunder(macdLine, signalLine) and rsi < 70

// Plot signals
plotshape(buySignal, style=shape.triangleup, location=location.belowbar, color=color.green, size=size.small, title="Buy Signal")
plotshape(sellSignal, style=shape.triangledown, location=location.abovebar, color=color.red, size=size.small, title="Sell Signal")

// Plot MACD and RSI
plot(macdLine, color=color.blue, title="MACD")
plot(signalLine, color=color.orange, title="Signal Line")
plot(rsi, color=color.purple, title="RSI")