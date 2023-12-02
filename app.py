import requests
import pandas as pd

def fetch_covid_data():
    url = 'https://disease.sh/v3/covid-19/historical/all?lastdays=30'
    response = requests.get(url)
    data = response.json()

    df = pd.DataFrame(data)
    df = df.melt(ignore_index=False, var_name='Category').reset_index()
    df.rename(columns={'index': 'Date', 'value': 'Count'}, inplace=True)

    return df

def save_data_as_html(df):
    html_table = df.to_html(index=False, border=0, classes='table table-striped')

    with open('covid_data_table.html', 'w') as file:
        file.write(html_table)

# Main execution
df = fetch_covid_data()
save_data_as_html(df)
