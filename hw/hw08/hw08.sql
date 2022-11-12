CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size from dogs, sizes where height<=max and height>min ;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child from dogs,parents
    where parent = name order by height desc ;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child as first,b.child as second,c.size from parents as a,parents as b,size_of_dogs as c,size_of_dogs as d
    where a.parent = b.parent and a.child < b.child and a.child = c.name and b.child = d.name
      and c.size = d.size;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT first || " and " || second || " are " || size || " siblings" as description from siblings;


-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height, n);

-- Add your INSERT INTOs here
insert into stacks_helper select name, height, height,1 from dogs;
insert into stacks_helper select a.dogs || ", " || b.name, a.stack_height+b.height,b.height,n+1 from stacks_helper as a,dogs as b where b.height > a.last_height;
insert into stacks_helper select a.dogs || ", " || b.name, a.stack_height+b.height,b.height,n+1 from stacks_helper as a,dogs as b where b.height > a.last_height;
insert into stacks_helper select a.dogs || ", " || b.name, a.stack_height+b.height,b.height,n+1 from stacks_helper as a,dogs as b where b.height > a.last_height;
CREATE TABLE stacks AS
  SELECT dogs,stack_height from stacks_helper where stack_height > 170 order by stack_height;

