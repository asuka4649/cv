import praw
import requests
import os

reddit = praw.Reddit(
    client_id='BwYNczneOb2YsX69nXMt9A',
    client_secret='x-SvD14yMOoXOyE8XewBD2vXQGeWhA',
    user_agent='reditAPI (by /u/grabthemomentum)'
)

subreddit = reddit.subreddit('memes')

# Directory where you want to save the images
save_dir = 'C:/Users/xxoox/OneDrive/'

# Ensure the save directory exists
if not os.path.exists(save_dir):
    os.makedirs(save_dir)

# Fetch top posts from the subreddit
for submission in subreddit.top(time_filter='day', limit=50):
    # Check if the URL points to an image
    if submission.url.endswith(('.jpg', '.png')):
        # Get the image content
        response = requests.get(submission.url)
        if response.status_code == 200:
            # Create a file path with the submission ID as the filename
            file_path = os.path.join(save_dir, f"{submission.id}.jpg")
            # Write the image data to a file
            with open(file_path, 'wb') as file:
                file.write(response.content)
            print(f"Saved image {submission.id} to {file_path}")

print("Finished downloading images.")
