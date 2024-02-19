import webbrowser

# List of keywords for search queries
keywords = [
    "cybersecurity in AR/VR",
    "security threat in augmented reality",
    "security risk in virtual reality",
    "AR/VR/XR security",
    "augmented reality attack vectors",
    "virtual reality data protection",
    "mixed reality vulnerabilities"
]

# Base URL for arXiv search
base_url = "https://arxiv.org/search/?query="

# Iterate over the keywords to construct search URLs and open them in browser tabs
for keyword in keywords:
    # Replace spaces with '+' to construct the search query part of the URL
    search_query = "+".join(keyword.split())
    search_url = f"{base_url}{search_query}&searchtype=all&source=header"

    # Open the search URL in a new browser tab
    webbrowser.open_new_tab(search_url)
