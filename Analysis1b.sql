SPOOL Analysis1b.txt
set echo on
set TIMING on
column column_name format a20
set linesize 200

--Below query is used to find the number of movies in a date range of 10 years for actors and actresses I have got and chosen in 1a analysis
SELECT
    name
    || ','
    || date_range
    || ','
    || (SUM(number_of_movies)) as "Name, Date Range, Number of Movies in the Range"
FROM
    (
        SELECT
            nb.primaryname AS name,
            tb.startyear,
            COUNT(*)       AS number_of_movies,
            CASE
                WHEN tb.startyear BETWEEN 2011 AND 2020 THEN
                    '2011- 2020'
                WHEN tb.startyear BETWEEN 2001 AND 2010 THEN
                    '2001-2010'
                WHEN tb.startyear BETWEEN 1991 AND 2000 THEN
                    '1991-2000'
                WHEN tb.startyear BETWEEN 1981 AND 1990 THEN
                    '1981-1990'
                WHEN tb.startyear BETWEEN 1971 AND 1980 THEN
                    '1971-1980'
                WHEN tb.startyear BETWEEN 1961 AND 1970 THEN
                    '1961-1970'
                WHEN tb.startyear BETWEEN 1951 AND 1960 THEN
                    '1951-1960'
                WHEN tb.startyear BETWEEN 1941 AND 1950 THEN
                    '1941-1950'
                WHEN tb.startyear BETWEEN 1931 AND 1940 THEN
                    '1931-1940'
                WHEN tb.startyear BETWEEN 1921 AND 1930 THEN
                    '1921-1930'
                ELSE
                    '2021-2030'
            END            AS date_range
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
            nb.primaryname,
            tb.startyear
        UNION ALL
        SELECT
            nb.primaryname AS name,
            tb.startyear,
            COUNT(*)       AS number_of_movies,
            CASE
                WHEN tb.startyear BETWEEN 2011 AND 2020 THEN
                    '2011- 2020'
                WHEN tb.startyear BETWEEN 2001 AND 2010 THEN
                    '2001-2010'
                WHEN tb.startyear BETWEEN 1991 AND 2000 THEN
                    '1991-2000'
                WHEN tb.startyear BETWEEN 1981 AND 1990 THEN
                    '1981-1990'
                WHEN tb.startyear BETWEEN 1971 AND 1980 THEN
                    '1971-1980'
                WHEN tb.startyear BETWEEN 1961 AND 1970 THEN
                    '1961-1970'
                WHEN tb.startyear BETWEEN 1951 AND 1960 THEN
                    '1951-1960'
                WHEN tb.startyear BETWEEN 1941 AND 1950 THEN
                    '1941-1950'
                WHEN tb.startyear BETWEEN 1931 AND 1940 THEN
                    '1931-1940'
                WHEN tb.startyear BETWEEN 1921 AND 1930 THEN
                    '1921-1930'
                ELSE
                    '2021-2030'
            END            AS date_range
        FROM
            imdb00.name_basics      nb,
            imdb00.title_principals tp,
            imdb00.title_basics     tb
        WHERE
                nb.nconst = tp.nconst
            AND tp.tconst = tb.tconst
            AND nb.nconst IN ( 'nm0000031', 'nm0000701' )
            AND lower(tb.titletype) LIKE '%movie%'
            AND lower(tp.category) LIKE '%actress%'
            AND lower(tb.startyear) NOT LIKE '\n'
        GROUP BY
            nb.nconst,
            nb.primaryname,
            tb.startyear
    )
GROUP BY
    name,
    date_range
ORDER BY
    name,
    date_range;

--Below query is used to find the number of movies along with their average ratings in a date range of 10 years for actors and actresses I have got and chosen in 1a analysis
SELECT
    name
    || ','
    || date_range
    || ','
    || AVG(average_rating)
    || ','
    || (SUM(number_of_movies)) as "Name, Date Range, Average Movies Rating in the Range, Number of Movies in the Range"
FROM
    (
        SELECT
            nb.primaryname        AS name,
            AVG(tr.averagerating) AS average_rating,
            tb.startyear,
            COUNT(*)              AS number_of_movies,
            CASE
                WHEN tb.startyear BETWEEN 2011 AND 2020 THEN
                    '2011- 2020'
                WHEN tb.startyear BETWEEN 2001 AND 2010 THEN
                    '2001-2010'
                WHEN tb.startyear BETWEEN 1991 AND 2000 THEN
                    '1991-2000'
                WHEN tb.startyear BETWEEN 1981 AND 1990 THEN
                    '1981-1990'
                WHEN tb.startyear BETWEEN 1971 AND 1980 THEN
                    '1971-1980'
                WHEN tb.startyear BETWEEN 1961 AND 1970 THEN
                    '1961-1970'
                WHEN tb.startyear BETWEEN 1951 AND 1960 THEN
                    '1951-1960'
                WHEN tb.startyear BETWEEN 1941 AND 1950 THEN
                    '1941-1950'
                WHEN tb.startyear BETWEEN 1931 AND 1940 THEN
                    '1931-1940'
                WHEN tb.startyear BETWEEN 1921 AND 1930 THEN
                    '1921-1930'
                ELSE
                    '2021-2030'
            END                   AS date_range
        FROM
            imdb00.title_ratings    tr,
            imdb00.name_basics      nb,
            imdb00.title_principals tp,
            imdb00.title_basics     tb
        WHERE
                nb.nconst = tp.nconst
            AND tp.tconst = tb.tconst
            AND nb.nconst IN ( 'nm0000093', 'nm0000129' )
            AND tp.tconst = tr.tconst
            AND lower(tb.titletype) LIKE '%movie%'
            AND lower(tp.category) LIKE '%actor%'
            AND lower(tb.startyear) NOT LIKE '\n'
        GROUP BY
            nb.nconst,
            nb.primaryname,
            tb.startyear
        UNION ALL
        SELECT
            nb.primaryname        AS name,
            AVG(tr.averagerating) AS average_rating,
            tb.startyear,
            COUNT(*)              AS number_of_movies,
            CASE
                WHEN tb.startyear BETWEEN 2011 AND 2020 THEN
                    '2011- 2020'
                WHEN tb.startyear BETWEEN 2001 AND 2010 THEN
                    '2001-2010'
                WHEN tb.startyear BETWEEN 1991 AND 2000 THEN
                    '1991-2000'
                WHEN tb.startyear BETWEEN 1981 AND 1990 THEN
                    '1981-1990'
                WHEN tb.startyear BETWEEN 1971 AND 1980 THEN
                    '1971-1980'
                WHEN tb.startyear BETWEEN 1961 AND 1970 THEN
                    '1961-1970'
                WHEN tb.startyear BETWEEN 1951 AND 1960 THEN
                    '1951-1960'
                WHEN tb.startyear BETWEEN 1941 AND 1950 THEN
                    '1941-1950'
                WHEN tb.startyear BETWEEN 1931 AND 1940 THEN
                    '1931-1940'
                WHEN tb.startyear BETWEEN 1921 AND 1930 THEN
                    '1921-1930'
                ELSE
                    '2021-2030'
            END                   AS date_range
        FROM
            imdb00.title_ratings    tr,
            imdb00.name_basics      nb,
            imdb00.title_principals tp,
            imdb00.title_basics     tb
        WHERE
                nb.nconst = tp.nconst
            AND tp.tconst = tb.tconst
            AND nb.nconst IN ( 'nm0000031', 'nm0000701' )
            AND tp.tconst = tr.tconst
            AND lower(tb.titletype) LIKE '%movie%'
            AND lower(tp.category) LIKE '%actress%'
            AND lower(tb.startyear) NOT LIKE '\n'
        GROUP BY
            nb.nconst,
            nb.primaryname,
            tb.startyear
    )
GROUP BY
    name,
    date_range
ORDER BY
    name,
    date_range;

set timing off
Set echo OFF
SPOOL OFF