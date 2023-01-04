SPOOL Analysis1a.txt
set echo on
set TIMING on
column column_name format a20
set linesize 200

--Query: to find the NCONST of an actor giving the name
--you can also get NCONST info by searching the IMDB_Actors.txt file given to you

--Below queries are used to get primary keys which is NCONST for each of the actors/actresses that I have been given as well as chosen
SELECT
    nconst
    || ','
    || primaryname AS "Primary Key, Name"
FROM
    imdb00.name_basics
WHERE
    lower(primaryname) LIKE 'tom cruise' --nm0000129
UNION ALL
SELECT
    nconst
    || ','
    || primaryname AS "Primary Key, Name"
FROM
    imdb00.name_basics
WHERE
    lower(primaryname) LIKE 'katharine hepburn' --nm0000031
UNION ALL
SELECT
    nconst
    || ','
    || primaryname AS "Primary Key, Name"
FROM
    imdb00.name_basics
WHERE
    lower(primaryname) LIKE 'kate winslet' --nm0000701
UNION ALL
SELECT
    nconst
    || ','
    || primaryname AS "Primary Key, Name"
FROM
    imdb00.name_basics
WHERE
    lower(primaryname) LIKE 'brad pitt';--nm0000093

--Below query will give us the year range the actor Tom Cruise has worked along with number of movies he has released each year:
SELECT
    nb.primaryname
    || ','
    || tb.startyear
    || ','
    || COUNT(*) AS "Name, Year, Yearly Movie Count"
FROM
    imdb00.name_basics      nb,
    imdb00.title_principals tp,
    imdb00.title_basics     tb
WHERE
        nb.nconst = tp.nconst
    AND tp.tconst = tb.tconst
    AND nb.nconst = 'nm0000129'
    AND lower(tb.titletype) LIKE '%movie%'
    AND lower(tp.category) LIKE '%actor%'
    AND lower(tb.startyear) NOT LIKE '\n'
GROUP BY
    nb.nconst,
    nb.primaryname,
    tb.startyear
ORDER BY
    tb.startyear;

--Below query will give us the year range the actress Katharine Hepburn has worked along with number of movies she has released each year:    
SELECT
    nb.primaryname
    || ','
    || tb.startyear
    || ','
    || COUNT(*) AS "Name, Year, Yearly Movie Count"
FROM
    imdb00.name_basics      nb,
    imdb00.title_principals tp,
    imdb00.title_basics     tb
WHERE
        nb.nconst = tp.nconst
    AND tp.tconst = tb.tconst
    AND nb.nconst = 'nm0000031'
    AND lower(tb.titletype) LIKE '%movie%'
    AND lower(tp.category) LIKE '%actress%'
    AND lower(tb.startyear) NOT LIKE '\n'
GROUP BY
    nb.nconst,
    nb.primaryname,
    tb.startyear
ORDER BY
    tb.startyear;

--Below query will give us the year range the actress Kate Winslet has worked along with number of movies she has released each year:
SELECT
    nb.primaryname
    || ','
    || tb.startyear
    || ','
    || COUNT(*) AS "Name, Year, Yearly Movie Count"
FROM
    imdb00.name_basics      nb,
    imdb00.title_principals tp,
    imdb00.title_basics     tb
WHERE
        nb.nconst = tp.nconst
    AND tp.tconst = tb.tconst
    AND nb.nconst = 'nm0000701'
    AND lower(tb.titletype) LIKE '%movie%'
    AND lower(tp.category) LIKE '%actress%'
    AND lower(tb.startyear) NOT LIKE '\n'
GROUP BY
    nb.nconst,
    nb.primaryname,
    tb.startyear
ORDER BY
    tb.startyear;

--Below query will give us the year range the actor Brad Pitt has worked along with number of movies he has released each year:    
SELECT
    nb.primaryname
    || ','
    || tb.startyear
    || ','
    || COUNT(*) AS "Name, Year, Yearly Movie Count"
FROM
    imdb00.name_basics      nb,
    imdb00.title_principals tp,
    imdb00.title_basics     tb
WHERE
        nb.nconst = tp.nconst
    AND tp.tconst = tb.tconst
    AND nb.nconst = 'nm0000093'
    AND lower(tb.titletype) LIKE '%movie%'
    AND lower(tp.category) LIKE '%actor%'
    AND lower(tb.startyear) NOT LIKE '\n'
GROUP BY
    nb.nconst,
    nb.primaryname,
    tb.startyear
ORDER BY
    tb.startyear;
    
--Year Span for the above actors and actresses
SELECT
    nb.primaryname
    || ','
    || MAX(tb.startyear)
    || ','
    || MIN(tb.startyear)
    || ','
    || ( MAX(tb.startyear) - MIN(tb.startyear) ) AS "Name, Latest Movie Year, First Acted Movie Year, Total Span of Acting Career in Years"
FROM
    imdb00.name_basics      nb,
    imdb00.title_principals tp,
    imdb00.title_basics     tb
WHERE
        nb.nconst = tp.nconst
    AND tp.tconst = tb.tconst
    AND nb.nconst IN ( 'nm0000093', 'nm0000129' )
    AND lower(tb.titletype) LIKE '%movie%'
    AND lower(tp.category) LIKE '%actor%'
    AND lower(tb.startyear) NOT LIKE '\n'
GROUP BY
    nb.nconst,
    nb.primaryname
UNION ALL
SELECT
    nb.primaryname
    || ','
    || MAX(tb.startyear)
    || ','
    || MIN(tb.startyear)
    || ','
    || ( MAX(tb.startyear) - MIN(tb.startyear) ) AS "Name, Latest Movie Year, First Acted Movie Year, Total Span of Acting Career in Years"
FROM
    imdb00.name_basics      nb,
    imdb00.title_principals tp,
    imdb00.title_basics     tb
WHERE
        nb.nconst = tp.nconst
    AND tp.tconst = tb.tconst
    AND nb.nconst IN ( 'nm0000701', 'nm0000031' )
    AND lower(tb.titletype) LIKE '%movie%'
    AND lower(tp.category) LIKE '%actress%'
    AND lower(tb.startyear) NOT LIKE '\n'
GROUP BY
    nb.nconst,
    nb.primaryname;

set timing off
Set echo OFF
SPOOL OFF