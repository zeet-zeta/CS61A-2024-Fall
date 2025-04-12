CREATE TABLE parents AS
  SELECT "ace" AS parent, "bella" AS child UNION
  SELECT "ace"          , "charlie"        UNION
  SELECT "daisy"        , "hank"           UNION
  SELECT "finn"         , "ace"            UNION
  SELECT "finn"         , "daisy"          UNION
  SELECT "finn"         , "ginger"         UNION
  SELECT "ellie"        , "finn";

CREATE TABLE dogs AS
  SELECT "ace" AS name, "long" AS fur, 26 AS height UNION
  SELECT "bella"      , "short"      , 52           UNION
  SELECT "charlie"    , "long"       , 47           UNION
  SELECT "daisy"      , "long"       , 46           UNION
  SELECT "ellie"      , "short"      , 35           UNION
  SELECT "finn"       , "curly"      , 32           UNION
  SELECT "ginger"     , "short"      , 28           UNION
  SELECT "hank"       , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child
  FROM parents
  JOIN dogs ON parents.parent = dogs.name
  ORDER BY dogs.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size
  FROM dogs
  JOIN sizes ON dogs.height > sizes.min AND dogs.height <= sizes.max;


-- [Optional] Filling out this helper table is recommended
-- CREATE TABLE siblings AS
 

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT 'The two siblings, ' || a.name || ' and ' || b.name || ', have the same size: ' || s.size
  FROM dogs as a
  JOIN dogs as b ON a.name < b.name
  JOIN parents as pa ON a.name = pa.child
  JOIN parents as pb ON b.name = pb.child
  JOIN sizes as s ON a.height > s.min AND a.height <= s.max AND b.height > s.min AND b.height <= s.max
  WHERE pa.parent = pb.parent;

-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  WITH fur_stats AS (
    SELECT 
      fur,
      AVG(height) AS avg_height,
      MIN(height) AS min_height,
      MAX(height) AS max_height,
      MAX(height) - MIN(height) AS height_range
    FROM dogs
    GROUP BY fur
  )
  SELECT fur, height_range
  FROM fur_stats
  WHERE max_height <= 1.3 * avg_height AND min_height >= 0.7 * avg_height; 

