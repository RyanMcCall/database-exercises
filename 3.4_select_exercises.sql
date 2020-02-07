# Use the albums_db database.
USE albums_db;

# Explore the structure of the albums table.
DESCRIBE albums;
SELECT * FROM albums;

# Find the name of all albums by Pink Floyd
SELECT * FROM albums
WHERE artist = 'Pink Floyd';

# The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT NAME, release_date FROM albums
WHERE NAME = "Sgt. Pepper's Lonely Hearts Club Band";

# The genre for the album Nevermind
SELECT NAME, genre FROM albums
WHERE NAME = 'Nevermind';

# Which albums were released in the 1990s
SELECT * FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

# Which albums had less than 20 million certified sales
SELECT * FROM albums
WHERE sales < 20;

# All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT * FROM albums
WHERE genre = 'Rock';
# Because it is looking for an exact match