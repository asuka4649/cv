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
save_dir = 'C:/Users/xxoox/OneDrive/reddit_memes'

if not os.path.exists(save_dir):
    os.makedirs(save_dir)

for submission in subreddit.hot(limit=1000):  # Example: using 'hot' posts
    file_extension = os.path.splitext(submission.url)[1] if os.path.splitext(submission.url)[1] in ['.jpg', '.png',
                                                                                                    '.gif'] else '.jpg'
    file_path = os.path.join(save_dir, f"{submission.id}{file_extension}")

    if not os.path.exists(file_path):
        response = requests.get(submission.url)
        if response.status_code == 200:
            with open(file_path, 'wb') as file:
                file.write(response.content)
            print(f"Saved image {submission.id} to {file_path}")
        else:
            print(f"Failed to download {submission.url}")
    else:
        print(f"Image {submission.id} already exists. Skipping.")

print("Finished downloading images.")
