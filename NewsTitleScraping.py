import requests
from bs4 import BeautifulSoup

def scrape_news_titles(url):
    response = requests.get(url)

    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        titles = soup.find_all('h2')

        for title in titles:
            print(title.get_text().strip())
    else:
        print("Failed to retrieve the webpage")

url = "https://www.cnn.com/"
scrape_news_titles(url)
