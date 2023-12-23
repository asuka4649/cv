from datetime import datetime
from lumibot.backtesting import YahooDataBacktesting
from lumibot.strategies import Strategy

class MyStrategy(Strategy):
  def initialize(self):
    self.sleeptime = "1D"

  def on_trading_iteration(self):
    if self.first_iteration:
      aapl_price = self.get_last_price("AAPL")
      cash = self.get_cash()
      quantity = cash
      order = self.create_order("AAPL", quantity, "buy")
      self.submit_order(order)

if __name__ == "__main__":
  backtesting_start = datetime(2022, 11, 1)
  backtesting_end = datetime(2023, 12, 22)

  MyStrategy.backtest(

    YahooDataBacktesting,
    backtesting_start,
    backtesting_end,
  )