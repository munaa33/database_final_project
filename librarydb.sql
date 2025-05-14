-- African Authors Library Database Schema
CREATE DATABASE librarydb;

USE librarydb;

-- Authors table to store information about African authors
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    death_date DATE NULL,
    gender VARCHAR(20),
    nationality VARCHAR(100),
    birth_place VARCHAR(200),
    biography TEXT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Countries table to store African countries information
CREATE TABLE countries (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL,
    region VARCHAR(100),
    language_official VARCHAR(100),
    independence_date DATE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Books table to store information about books written by African authors
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT NOT NULL,
    publisher_id INT,
    isbn VARCHAR(20) UNIQUE,
    publication_date DATE,
    edition VARCHAR(50),
    description TEXT,
    page_count INT,
    language VARCHAR(50),
    cover_image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

-- Publishers table to store information about publishing companies
CREATE TABLE publishers (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(255) NOT NULL,
    country_id INT,
    founding_date DATE,
    website VARCHAR(255),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(50),
    address TEXT,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- Alter books table to add the foreign key for publisher_id
ALTER TABLE books ADD FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id);

-- Genres table to categorize books
CREATE TABLE genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Book-Genre relationship (many-to-many)
CREATE TABLE book_genres (
    book_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE
);

-- Awards table to store literary awards information
CREATE TABLE awards (
    award_id INT PRIMARY KEY AUTO_INCREMENT,
    award_name VARCHAR(255) NOT NULL,
    description TEXT,
    established_year INT,
    awarding_organization VARCHAR(255),
    prestige_level ENUM('Regional', 'Continental', 'International') DEFAULT 'Continental',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Author-Award relationship (many-to-many with additional attributes)
CREATE TABLE author_awards (
    author_id INT NOT NULL,
    award_id INT NOT NULL,
    book_id INT,
    year_awarded INT NOT NULL,
    citation TEXT,
    PRIMARY KEY (author_id, award_id, year_awarded),
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE,
    FOREIGN KEY (award_id) REFERENCES awards(award_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE SET NULL
);

-- Literary movements table to store information about African literary movements
CREATE TABLE literary_movements (
    movement_id INT PRIMARY KEY AUTO_INCREMENT,
    movement_name VARCHAR(255) NOT NULL,
    start_year INT,
    end_year INT,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Author-Movement relationship (many-to-many)
CREATE TABLE author_movements (
    author_id INT NOT NULL,
    movement_id INT NOT NULL,
    contribution TEXT,
    PRIMARY KEY (author_id, movement_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE,
    FOREIGN KEY (movement_id) REFERENCES literary_movements(movement_id) ON DELETE CASCADE
);

-- Themes table to categorize recurring themes in African literature
CREATE TABLE themes (
    theme_id INT PRIMARY KEY AUTO_INCREMENT,
    theme_name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Book-Theme relationship (many-to-many)
CREATE TABLE book_themes (
    book_id INT NOT NULL,
    theme_id INT NOT NULL,
    PRIMARY KEY (book_id, theme_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (theme_id) REFERENCES themes(theme_id) ON DELETE CASCADE
);

-- Adaptations table to track adaptations of books to other media
CREATE TABLE adaptations (
    adaptation_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    adaptation_title VARCHAR(255) NOT NULL,
    adaptation_type ENUM('Film', 'TV Series', 'Play', 'Radio', 'Other') NOT NULL,
    director VARCHAR(255),
    production_company VARCHAR(255),
    release_date DATE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- Reviews table to store critical reviews of books
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    reviewer_name VARCHAR(255) NOT NULL,
    publication VARCHAR(255),
    review_date DATE,
    rating DECIMAL(3,1),
    review_text TEXT,
    review_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- Academic citations table to track scholarly references to authors/books
CREATE TABLE academic_citations (
    citation_id INT PRIMARY KEY AUTO_INCREMENT,
    author_id INT,
    book_id INT,
    cited_by VARCHAR(255) NOT NULL,
    citation_title VARCHAR(255) NOT NULL,
    publication VARCHAR(255),
    publication_date DATE,
    citation_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE SET NULL,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE SET NULL
);


-- Sample data for African Authors Library Database

-- Insert data into countries table
INSERT INTO countries (country_name, region, language_official, independence_date, description) VALUES
('Nigeria', 'West Africa', 'English', '1960-10-01', 'Most populous nation in Africa with rich literary tradition'),
('South Africa', 'Southern Africa', 'Multiple including English', '1961-05-31', 'Diverse nation with prominent literary voices'),
('Kenya', 'East Africa', 'English, Swahili', '1963-12-12', 'East African nation with strong literary heritage'),
('Egypt', 'North Africa', 'Arabic', '1922-02-28', 'Ancient civilization with long literary history'),
('Ghana', 'West Africa', 'English', '1957-03-06', 'First sub-Saharan African country to gain independence'),
('Zimbabwe', 'Southern Africa', 'English', '1980-04-18', 'Known for its rich storytelling traditions'),
('Senegal', 'West Africa', 'French', '1960-04-04', 'Hub of Francophone African literature'),
('Algeria', 'North Africa', 'Arabic, French', '1962-07-05', 'Influential in North African literature'),
('Ethiopia', 'East Africa', 'Amharic', '1941-05-05', 'Ancient kingdom with unique literary traditions'),
('Morocco', 'North Africa', 'Arabic', '1956-03-02', 'Rich tradition of oral and written literature');

-- Insert data into authors table
INSERT INTO authors (first_name, last_name, birth_date, death_date, gender, nationality, birth_place, biography) VALUES
('Chinua', 'Achebe', '1930-11-16', '2013-03-21', 'Male', 'Nigerian', 'Ogidi, Nigeria', 'Widely regarded as father of modern African literature. His novel "Things Fall Apart" is the most widely read book in modern African literature.'),
('Ngũgĩ wa', 'Thiong''o', '1938-01-05', NULL, 'Male', 'Kenyan', 'Limuru, Kenya', 'Distinguished Kenyan writer known for works like "Weep Not, Child" and his decision to write in his native Gikuyu language instead of English.'),
('Chimamanda Ngozi', 'Adichie', '1977-09-15', NULL, 'Female', 'Nigerian', 'Enugu, Nigeria', 'Award-winning author known for works like "Half of a Yellow Sun" and "Americanah" that explore Nigerian politics, immigration, and feminism.'),
('Nadine', 'Gordimer', '1923-11-20', '2014-07-13', 'Female', 'South African', 'Springs, South Africa', 'Nobel Prize-winning author whose works dealt with moral and racial issues in South Africa during apartheid.'),
('Wole', 'Soyinka', '1934-07-13', NULL, 'Male', 'Nigerian', 'Abeokuta, Nigeria', 'First African to be awarded the Nobel Prize in Literature. Poet, playwright and essayist known for works like "Death and the King''s Horseman".'),
('Naguib', 'Mahfouz', '1911-12-11', '2006-08-30', 'Male', 'Egyptian', 'Cairo, Egypt', 'First Arabic-language writer to win the Nobel Prize in Literature. Known for the "Cairo Trilogy" and numerous other novels.'),
('Ousmane', 'Sembène', '1923-01-01', '2007-06-09', 'Male', 'Senegalese', 'Ziguinchor, Senegal', 'Considered one of the greatest authors of Africa, also a filmmaker known as "the father of African film".'),
('Bessie', 'Head', '1937-07-06', '1986-04-17', 'Female', 'South African/Botswanan', 'Pietermaritzburg, South Africa', 'One of Africa''s most prominent writers, dealing with issues of identity and exile in works like "When Rain Clouds Gather".'),
('Tsitsi', 'Dangarembga', '1959-02-04', NULL, 'Female', 'Zimbabwean', 'Mutoko, Zimbabwe', 'Novelist and filmmaker known for her debut novel "Nervous Conditions" and its sequels examining colonialism and gender in Zimbabwe.'),
('Tayeb', 'Salih', '1929-07-12', '2009-02-18', 'Male', 'Sudanese', 'Northern Sudan', 'Author of the classic "Season of Migration to the North", considered one of the most important Arab novels of the 20th century.');

-- Insert data into publishers table
INSERT INTO publishers (publisher_name, country_id, founding_date, website) VALUES
('Heinemann African Writers Series', 1, '1962-01-01', 'www.heinemann.com'),
('Kwani Trust', 3, '2003-01-01', 'www.kwani.org'),
('Cassava Republic Press', 1, '2006-01-01', 'www.cassavarepublic.biz'),
('David Philip Publishers', 2, '1971-01-01', 'www.davidphilip.com'),
('East African Educational Publishers', 3, '1965-01-01', 'www.eastafricanpublishers.com'),
('Penguin Random House South Africa', 2, '1994-01-01', 'www.penguinrandomhouse.co.za'),
('Farafina Books', 1, '2004-01-01', 'www.farafinabooks.com'),
('New Horn Press', 1, '1977-01-01', NULL),
('Weaver Press', 6, '1998-01-01', 'www.weaverpresszimbabwe.com'),
('American University in Cairo Press', 4, '1960-01-01', 'www.aucpress.com');

-- Insert data into genres table
INSERT INTO genres (genre_name, description) VALUES
('Post-colonial Literature', 'Literature that responds to the discourse of colonization by the colonizer'),
('Historical Fiction', 'Fictional narrative set in a historical period'),
('Social Realism', 'Depicts contemporary social, political and economic conditions realistically'),
('Magical Realism', 'Realistic narrative with magical elements'),
('Political Fiction', 'Fiction with emphasis on political themes'),
('Feminist Literature', 'Works focusing on women''s issues and perspectives'),
('Afrofuturism', 'Intersection of African/African diaspora culture with technology and science fiction'),
('Autobiographical Fiction', 'Fiction incorporating autobiographical elements'),
('Oral Tradition', 'Literature based on oral storytelling traditions'),
('Modernism', 'Literature characterized by a break with traditional forms');

-- Insert data into literary_movements table
INSERT INTO literary_movements (movement_name, start_year, end_year, description) VALUES
('Négritude', 1930, 1960, 'Literary and ideological movement developed by francophone Black intellectuals that celebrated Black culture and identity'),
('African Postcolonialism', 1950, NULL, 'Literary movement addressing impact of colonialism and its aftermath'),
('Makerere Generation', 1962, 1970, 'Group of writers associated with Makerere University, often focused on decolonization themes'),
('Soweto Poetry', 1970, 1980, 'Poetry that emerged from South African townships during apartheid'),
('African Feminism', 1980, NULL, 'Literature focusing on experiences and rights of African women'),
('Afropolitanism', 2000, NULL, 'Perspective reflecting modern African diaspora identity and cosmopolitanism'),
('African Futurism', 2010, NULL, 'Science fiction rooted specifically in African perspectives and experiences'),
('Pan-African Literature', 1950, NULL, 'Works emphasizing African unity and solidarity across the continent'),
('African Magical Realism', 1980, NULL, 'African narratives incorporating elements of magic and fantasy into realistic settings'),
('African Renaissance', 1994, NULL, 'Cultural and literary movement promoting renewal of African art, culture and identity');

-- Insert data into themes table
INSERT INTO themes (theme_name, description) VALUES
('Colonialism and Independence', 'Exploration of colonial rule and the struggle for independence'),
('Cultural Identity', 'Examination of individual and community identity in relation to culture'),
('Tradition vs. Modernity', 'Tension between traditional practices and modern influences'),
('Social Justice', 'Focus on equity, fairness and human rights'),
('Gender Roles', 'Exploration of societal expectations based on gender'),
('Displacement and Exile', 'Experiences of forced migration and living away from homeland'),
('Power and Corruption', 'Examination of authority and its abuses'),
('Religious and Spiritual Beliefs', 'Role of religion and spirituality in African societies'),
('Family Dynamics', 'Relationships within family structures'),
('Environmental Concerns', 'Focus on ecological issues and sustainability');

-- Insert data into awards table
INSERT INTO awards (award_name, description, established_year, awarding_organization, prestige_level) VALUES
('Nobel Prize in Literature', 'International award for lifetime literary achievement', 1901, 'Swedish Academy', 'International'),
('Man Booker Prize', 'Award for fiction written in English and published in the UK', 1969, 'Booker Prize Foundation', 'International'),
('Caine Prize', 'Award for short story by African writer published in English', 2000, 'Caine Prize for African Writing', 'Continental'),
('Noma Award', 'Award for publishing in Africa (1980-2009)', 1980, 'Kodansha Ltd', 'Continental'),
('Commonwealth Writers'' Prize', 'Award for fiction by author from Commonwealth nation', 1987, 'Commonwealth Foundation', 'International'),
('Neustadt International Prize', 'International literary award', 1970, 'University of Oklahoma', 'International'),
('Grand Prix Littéraire d''Afrique Noire', 'Award for Francophone African literature', 1960, 'Association des écrivains de langue française', 'Continental'),
('Wole Soyinka Prize for Literature', 'Pan-African literary award', 2005, 'Lumina Foundation', 'Continental'),
('Etisalat Prize for Literature', 'Award for first-time fiction writers of African citizenship', 2013, 'Etisalat', 'Continental'),
('Windham-Campbell Prize', 'Award to support writers'' creative work', 2013, 'Yale University', 'International');

-- Insert data into books table
INSERT INTO books (title, author_id, publisher_id, isbn, publication_date, page_count, language) VALUES
('Things Fall Apart', 1, 1, '9780385474542', '1958-01-01', 209, 'English'),
('A Grain of Wheat', 2, 1, '9780141186993', '1967-01-01', 247, 'English'),
('Half of a Yellow Sun', 3, 7, '9780007200283', '2006-08-11', 433, 'English'),
('July''s People', 4, 6, '9780140061406', '1981-11-12', 160, 'English'),
('Death and the King''s Horseman', 5, 1, '9780413695505', '1975-01-01', 77, 'English'),
('Palace Walk', 6, 10, '9780385264662', '1956-01-01', 498, 'Arabic'),
('God''s Bits of Wood', 7, 1, '9780435909598', '1960-01-01', 248, 'French'),
('When Rain Clouds Gather', 8, 1, '9780435900311', '1968-01-01', 190, 'English'),
('Nervous Conditions', 9, 1, '9780954702335', '1988-01-01', 204, 'English'),
('Season of Migration to the North', 10, 1, '9780435900314', '1966-01-01', 169, 'Arabic'),
('No Longer at Ease', 1, 1, '9780385474559', '1960-01-01', 194, 'English'),
('Petals of Blood', 2, 1, '9780141187020', '1977-01-01', 432, 'English'),
('Americanah', 3, 7, '9780307455925', '2013-05-14', 477, 'English'),
('The Conservationist', 4, 6, '9780140047165', '1974-01-01', 267, 'English'),
('Ake: The Years of Childhood', 5, 4, '9780679725404', '1981-01-01', 230, 'English');

-- Insert data into book_genres
INSERT INTO book_genres (book_id, genre_id) VALUES
(1, 1), (1, 3), (1, 9),
(2, 1), (2, 2), (2, 5),
(3, 1), (3, 2), (3, 6),
(4, 1), (4, 3), (4, 5),
(5, 3), (5, 9), (5, 10),
(6, 2), (6, 3), (6, 9),
(7, 1), (7, 3), (7, 5),
(8, 1), (8, 3), (8, 6),
(9, 1), (9, 6), (9, 8),
(10, 1), (10, 8), (10, 10),
(11, 1), (11, 3), (11, 5),
(12, 1), (12, 3), (12, 5),
(13, 1), (13, 6), (13, 8),
(14, 3), (14, 5), (14, 10),
(15, 8), (15, 9);

-- Insert data into author_movements
INSERT INTO author_movements (author_id, movement_id, contribution) VALUES
(1, 2, 'Pioneering voice in postcolonial African literature'),
(1, 3, 'Founding member of the Makerere generation'),
(2, 2, 'Leading figure in postcolonial African literature'),
(2, 3, 'Key member of Makerere generation'),
(3, 5, 'Contemporary voice in African feminism'),
(3, 6, 'Prominent Afropolitan writer'),
(4, 2, 'Critical voice examining apartheid and its effects'),
(4, 4, 'Documented and supported township literature'),
(5, 2, 'Blended traditional Yoruba culture with postcolonial themes'),
(5, 8, 'Advocate for pan-African unity through literature'),
(6, 10, 'Pioneered modernist Arabic literature'),
(7, 1, 'Applied Négritude principles to both literature and film'),
(7, 2, 'Examined postcolonial challenges in West Africa'),
(8, 2, 'Explored exile and displacement in postcolonial context'),
(8, 5, 'Early contributor to African feminist literature'),
(9, 5, 'Contemporary voice in African feminist literature'),
(9, 10, 'Contributes to modern African literary renaissance'),
(10, 2, 'Examined cultural clash between Africa and the West');

-- Insert data into book_themes
INSERT INTO book_themes (book_id, theme_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 1), (2, 4), (2, 7),
(3, 1), (3, 2), (3, 9),
(4, 1), (4, 4), (4, 6),
(5, 2), (5, 3), (5, 8),
(6, 2), (6, 3), (6, 9),
(7, 1), (7, 4), (7, 7),
(8, 3), (8, 6), (8, 10),
(9, 3), (9, 5), (9, 9),
(10, 1), (10, 2), (10, 6),
(11, 1), (11, 3), (11, 7),
(12, 1), (12, 4), (12, 7),
(13, 2), (13, 5), (13, 6),
(14, 2), (14, 7), (14, 10),
(15, 2), (15, 8), (15, 9);

-- Insert data into author_awards
INSERT INTO author_awards (author_id, award_id, book_id, year_awarded, citation) VALUES
(1, 4, 1, 1975, 'For outstanding contribution to African literature'),
(1, 6, NULL, 1986, 'For lifetime achievement in literature'),
(2, 1, NULL, 2021, 'Nominated for the Nobel Prize in Literature'),
(3, 2, 13, 2013, 'Shortlisted for "Americanah"'),
(3, 5, 3, 2007, 'Best Book award for "Half of a Yellow Sun"'),
(4, 1, NULL, 1991, 'For her ethical vision and depiction of South African society'),
(4, 2, 14, 1974, 'For "The Conservationist"'),
(5, 1, NULL, 1986, 'For works that in a wide cultural perspective form poetry of harsh beauty'),
(6, 1, NULL, 1988, 'For works rich in nuance, with an Arabian narrative art that forms thought-provoking perspectives on human existence'),
(9, 5, 9, 1989, 'For "Nervous Conditions"'),
(10, 5, 10, 1969, 'For "Season of Migration to the North"');

-- Insert data into adaptations
INSERT INTO adaptations (adaptation_id, book_id, adaptation_title, adaptation_type, director, release_date) VALUES
(1, 1, 'Things Fall Apart', 'Film', 'Jason Pohland', '1971-03-15'),
(2, 3, 'Half of a Yellow Sun', 'Film', 'Biyi Bandele', '2013-09-08'),
(3, 5, 'Death and the King''s Horseman', 'Play', 'Various Directors', '1976-01-01'),
(4, 6, 'Cairo Trilogy', 'TV Series', 'Hassan Al Imam', '1988-10-05'),
(5, 10, 'Season of Migration to the North', 'Radio', 'BBC Radio', '1998-06-12');

-- Insert data into reviews
INSERT INTO reviews (book_id, reviewer_name, publication, review_date, rating, review_text) VALUES
(1, 'Time Magazine', 'Time', '1958-06-15', 9.5, 'A true classic of world literature. Achebe''s work remains one of the most significant books to come out of Africa.'),
(3, 'Michiko Kakutani', 'New York Times', '2006-09-22', 9.0, 'Adichie draws on history to create a powerful, moving portrait of Nigeria during the Biafran War.'),
(5, 'James Wood', 'The New Yorker', '2003-05-12', 9.2, 'Soyinka''s masterpiece remains one of the greatest plays from Africa, blending tragedy with native Yoruba culture.'),
(9, 'The Guardian', 'The Guardian', '2004-10-15', 8.7, 'A landmark work in African literature that explores the burden of colonization.'),
(13, 'NPR', 'NPR Books', '2013-05-24', 9.3, 'A powerful, tender story of race and identity that deserves to be read by everyone.');

-- Insert data into academic_citations
INSERT INTO academic_citations (author_id, book_id, cited_by, citation_title, publication, publication_date) VALUES
(1, 1, 'Simon Gikandi', 'Reading Chinua Achebe: Language & Ideology in Fiction', 'Academic Press', '1991-01-01'),
(2, 2, 'F. Abiola Irele', 'The African Imagination: Literature in Africa and the Black Diaspora', 'Oxford University Press', '2001-01-01'),
(3, 3, 'Jane Bryce', 'Half and Half Children: Third-Generation Women Writers and the New Nigerian Novel', 'Research in African Literatures', '2008-06-01'),
(4, NULL, 'Stephen Clingman', 'The Novels of Nadine Gordimer: History from the Inside', 'University of Massachusetts Press', '1992-01-01'),
(5, 5, 'Biodun Jeyifo', 'Wole Soyinka: Politics, Poetics, and Postcolonialism', 'Cambridge University Press', '2004-01-01');