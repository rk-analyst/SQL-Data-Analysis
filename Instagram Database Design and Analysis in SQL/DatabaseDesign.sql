

/* Create new database instagram if it doesn't exist */
CREATE DATABASE IF NOT EXISTS instagram;

/* If we want to view existing databases, use command 
SHOW DATABASES; */

/* For our case, we want to use the database "instagram" */
USE instagram;

/*In order to create instagram RDBMS, we will create different tables within the database. */

/* Creating table Users in instagram db */
CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY,    
	username VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);
/* column_name id is of type INT, auto incrementing by 1 starting at 1. We have added constraint PRIMARY KEY.*/
/* column_name username is of type varchar with maximum length of 255 characters and with constraint UNIQUE and NOT NULL. */
/* column_name created_at is of type TIMESTAMP with sysdate at the time of creation of the record. */
/* INDEX: In this table, via PK, we have clustered index for column id by default. */ 
/* In this example we haven't created an index on column username.*/

/* Creating index for username column (we can also create it within the create table query)*/
CREATE INDEX username_idx
ON users(username);


/*Creating table photos in instagram db */
CREATE TABLE photos(
	id INT AUTO_INCREMENT PRIMARY KEY,
	image_url VARCHAR(355) NOT NULL,
	user_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id)
);
/* column_name id is of type INT, auto incrementing by 1 starting at 1. We have added constraint PRIMARY KEY.*/
/* We have a foreign key user_id which references to field id in table users. */
/* There is a very valid use case to get photos by user_id. So, we should create an index on user_id for better read performance.
But since foreign key constraint by default creates an index, we don't need to specifically create an index for user_id column. */
/* INDEX: In this table, via PK, we have clustered index for column id by default. */ 


/*Creating table comments in instagram db */
CREATE TABLE comments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(photo_id) REFERENCES photos(id)
);
/* column_name id is of type INT, auto incrementing by 1 starting at 1. We have added constraint PRIMARY KEY.*/
/* We have a foreign key user_id which references to field id in table users. */
/* We have a foreign key photo_id which references to field id in table photos. */
/* INDEX: In this table, via PK, we have clustered index for column id by default. */


/*Creating table likes in instagram db */
CREATE TABLE likes(
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	PRIMARY KEY(user_id,photo_id)
);
/* We have a foreign key user_id which references to field id in table users. */
/* We have a foreign key photo_id which references to field id in table photos. */
/* Here, PK is a composite key with columns user_id and photo_id */


/*Creating table follows in instagram db */
CREATE TABLE follows(
	follower_id INT NOT NULL,
	followee_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY (follower_id) REFERENCES users(id),
	FOREIGN KEY (followee_id) REFERENCES users(id),
	PRIMARY KEY(follower_id,followee_id)
);
/* We have a foreign key follower_id which references to field id in table users. */
/* We have a foreign key followee_id which references to field id in table users. */
/* Here, PK is a composite key with columns follower_id and followee_id */


/*Creating table tags in instagram db */
CREATE TABLE tags(
	id INT AUTO_INCREMENT PRIMARY KEY,
	tag_name VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

/* column_name id is of type INT, auto incrementing by 1 starting at 1. We have added constraint PRIMARY KEY.*/
/* column_name tag_name is of type varchar with maximum length of 255 characters and with 2 constraints: UNIQUE and NOT NULL. */


/*Creating junction table photo_tags in instagram db which establishes many to many relationship between tables photos and tags */
CREATE TABLE photo_tags(
	photo_id INT NOT NULL,
	tag_id INT NOT NULL,
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	FOREIGN KEY(tag_id) REFERENCES tags(id),
	PRIMARY KEY(photo_id,tag_id)
);
/* We have a foreign key photo_id which references to field id in table photos. */
/* We have a foreign key tag_id which references to field id in table tags. */
/* Here, PK is a composite key with columns tag_id and photo_id */


