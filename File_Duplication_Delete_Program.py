import os
import hashlib


def file_hash(filepath):
    """Compute MD5 hash of the contents of a file."""
    md5 = hashlib.md5()
    with open(filepath, 'rb') as f:
        while chunk := f.read(8192):
            md5.update(chunk)
    return md5.hexdigest()


# Define your directory path
directory_path = 'C:/Users/xxoox/OneDrive/reddit_memes'

# Track encountered hash values
encountered_hashes = set()

# Iterate over all files in the directory
for filename in os.listdir(directory_path):
    file_path = os.path.join(directory_path, filename)

    # Skip if it's a directory
    if os.path.isdir(file_path):
        continue

    # Compute the file's hash
    hash_val = file_hash(file_path)

    # Check if the hash has already been encountered
    if hash_val in encountered_hashes:
        # If encountered, remove the duplicate file
        os.remove(file_path)
        print(f"Removed duplicate file based on content: {file_path}")
    else:
        # If not encountered, add the hash to the set
        encountered_hashes.add(hash_val)

print("Finished removing duplicate files based on content.")
