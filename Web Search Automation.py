import webbrowser
import time
import os

# Define the URL to search
url = "https://www.bing.com/search?q="

# Define the list of terms to search
terms = ["python program", "webbrowser module", "time module", "pycharm ide", "embedded browser plugin", "python documentation", "python tutorial", "python examples", "python projects", "python libraries", "python frameworks", "python games", "python data analysis", "python machine learning", "python artificial intelligence", "python web development", "python web scraping", "python automation", "python testing", "python debugging", "python gui", "python graphics", "python networking", "python security", "python cryptography", "python natural language processing", "python speech recognition", "python image processing", "python computer vision", "python deep learning"]

# Define the number of searches to perform
num_searches = len(terms)

# Define the delay in seconds before closing the browser
delay = 5

# Define the Edge browser path
edge_path = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

# Register the Edge browser as a controller
webbrowser.register('edge', None, webbrowser.BackgroundBrowser(edge_path))

# Get the Edge browser controller
edge = webbrowser.get('edge')

# Open the first search in the Edge browser
edge.open(url + terms[0])

# Open the rest of the searches in new tabs of the same browser
for i in range(1, num_searches):
    time.sleep(delay)

    # Close the current tab by sending Ctrl+W to the Edge process
    os.system("taskkill /im msedge.exe /f /t /fi \"windowtitle eq Bing - " + terms[i-1] + "\"")
    # Open the next search in a new tab of the same browser
    edge.open_new_tab(url + terms[i])

# Wait for the delay
time.sleep(delay)

# Close the last tab by sending Ctrl+W to the Edge process
os.system("taskkill /im msedge.exe /f /t /fi \"windowtitle eq Bing - " + terms[num_searches-1] + "\"")
