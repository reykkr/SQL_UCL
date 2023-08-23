CREATE TABLE Attractions (
  id_attraction INT PRIMARY KEY,
  name_attraction TEXT,
  category TEXT,
  duration_attarction TEXT,
  age_limit INT,
  height_limit NUMERIC,
  access_for_pregnant BOOLEAN,
  ride_duration TEXT,
  opening_date DATE,
  manufacturer TEXT,
  hourly_capacity INT		
);

CREATE TABLE Seasons (
  id_season INT PRIMARY KEY,
  name_season TEXT,
  start_date DATE,
  end_date DATE
);

CREATE TABLE Attraction_Seasons (
  id_attseas INT PRIMARY KEY,
  attraction_id INT,
  season_id INT,
  FOREIGN KEY (attraction_id) REFERENCES Attractions (id_attraction),
  FOREIGN KEY (season_id) REFERENCES Seasons (id_season)
);


SELECT name_attraction
FROM Attractions
WHERE category = 'family'
  AND age_limit < 12
  AND height_limit < 145
  AND access_for_pregnant = true
  AND manufacturer = 'Mack Rides'
  AND ride_duration = '6 minutes';