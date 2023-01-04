SPOOL Analysis2.txt
set echo on
set TIMING on
column column_name format a20
set linesize 200

--Analysis 2:
--year range 1964 to 1973
--This contains the maximum number of movies & minimum numbers of movies acted by the actor and actress totally in that year range which is a part of 2(a) analysis
--This also contains the maximum number of movies & minimum numbers of movies acted by the actor and actress in a year, in that year range which is a part of 2(b) analysis

--Below query will help us to find the actors and actresses who have acted in maximum number of movies in the entire year range from 1964 to 1973.
(
    SELECT
        nb.nconst
        || ','
        || nb.primaryname
        || ','
        || COUNT(*)
        || ','
        || tp.category as "Primary Key, Name, Maximum Number of Movies from 1964 to 1973, Profession"
    FROM
        imdb00.name_basics      nb,
        imdb00.title_principals tp,
        imdb00.title_basics     tb
    WHERE
            nb.nconst = tp.nconst
        AND tp.tconst = tb.tconst
        AND lower(tp.category) LIKE '%actor%'
        AND lower(tb.titletype) LIKE '%movie%'
        AND lower(tb.startyear) NOT LIKE '\n'
        AND tb.startyear BETWEEN '1964' AND '1973'
    GROUP BY
        nb.primaryname,
        nb.nconst,
        tp.category
    ORDER BY
        COUNT(*) DESC
    FETCH FIRST 1 ROW WITH TIES
)
UNION ALL
(
    SELECT
        nb.nconst
        || ','
        || nb.primaryname
        || ','
        || COUNT(*)
        || ','
        || tp.category as "Primary Key, Name, Maximum Number of Movies from 1964 to 1973, Profession"
    FROM
        imdb00.name_basics      nb,
        imdb00.title_principals tp,
        imdb00.title_basics     tb
    WHERE
            nb.nconst = tp.nconst
        AND tp.tconst = tb.tconst
        AND lower(tp.category) LIKE '%actress%'
        AND lower(tb.titletype) LIKE '%movie%'
        AND lower(tb.startyear) NOT LIKE '\n'
        AND tb.startyear BETWEEN '1964' AND '1973'
    GROUP BY
        nb.primaryname,
        nb.nconst,
        tp.category
    ORDER BY
        COUNT(*) DESC
    FETCH FIRST 1 ROW WITH TIES
);

--Below query will help us to find the actors and actresses who have acted in minimum number of movies in the entire year range from 1964 to 1973
--I have kept minimum number of movies count to be at least 3 in order to reduce the output count
(
    SELECT
        nb.nconst
        || ','
        || nb.primaryname
        || ','
        || COUNT(*)
        || ','
        || tp.category  as "Primary Key, Name, Minimum Number of Movies from 1964 to 1973, Profession"
    FROM
        imdb00.name_basics      nb,
        imdb00.title_principals tp,
        imdb00.title_basics     tb
    WHERE
            nb.nconst = tp.nconst
        AND tp.tconst = tb.tconst
        AND lower(tp.category) LIKE '%actor%'
        AND lower(tb.titletype) LIKE '%movie%'
        AND lower(tb.startyear) NOT LIKE '\n'
        AND tb.startyear BETWEEN '1964' AND '1973'
    GROUP BY
        nb.primaryname,
        nb.nconst,
        tp.category
    HAVING
        COUNT(*) >= 3
    ORDER BY
        COUNT(*)
    FETCH FIRST 10 ROW ONLY -- as there are 2510 actors who have acted in exactly 3 movies from 1964 to 1973 I am printing just 10 rows
)
UNION ALL
(
    SELECT
        nb.nconst
        || ','
        || nb.primaryname
        || ','
        || COUNT(*)
        || ','
        || tp.category  as "Primary Key, Name, Minimum Number of Movies from 1964 to 1973, Profession"
    FROM
        imdb00.name_basics      nb,
        imdb00.title_principals tp,
        imdb00.title_basics     tb
    WHERE
            nb.nconst = tp.nconst
        AND tp.tconst = tb.tconst
        AND lower(tp.category) LIKE '%actress%'
        AND lower(tb.titletype) LIKE '%movie%'
        AND lower(tb.startyear) NOT LIKE '\n'
        AND tb.startyear BETWEEN '1964' AND '1973'
    GROUP BY
        nb.primaryname,
        nb.nconst,
        tp.category
    HAVING
        COUNT(*) >= 3
    ORDER BY
        COUNT(*)
    FETCH FIRST 10 ROW ONLY -- as there are 1739 actresses who have acted in exactly 3 movies from 1964 to 1973 I am printing just 10 rows
);

-- Query to show number of actors/actresses who have done exactly 3 movies from the year 1964 to the year 1973
SELECT
    profession
    || ','
    || COUNT(*) AS "Profession, Number of acting professionals with 3 movies"
FROM
    (
        SELECT
            nb.nconst      AS actor_id,
            nb.primaryname AS name,
            COUNT(*)       AS number_of_movies_from_1964_to_1973,
            tp.category    AS profession
        FROM
            imdb00.name_basics      nb,
            imdb00.title_principals tp,
            imdb00.title_basics     tb
        WHERE
                nb.nconst = tp.nconst
            AND tp.tconst = tb.tconst
            AND lower(tp.category) LIKE '%actor%'
            AND lower(tb.titletype) LIKE '%movie%'
            AND lower(tb.startyear) NOT LIKE '\n'
            AND tb.startyear BETWEEN '1964' AND '1973'
        GROUP BY
            nb.primaryname,
            nb.nconst,
            tp.category
        HAVING
            COUNT(*) = 3
    )
GROUP BY
    profession
UNION ALL
SELECT
    profession
    || ','
    || COUNT(*) AS "Profession, Number of acting professionals with 3 movies"
FROM
    (
        SELECT
            nb.nconst      AS actor_id,
            nb.primaryname AS name,
            COUNT(*)       AS number_of_movies_from_1964_to_1973,
            tp.category    AS profession
        FROM
            imdb00.name_basics      nb,
            imdb00.title_principals tp,
            imdb00.title_basics     tb
        WHERE
                nb.nconst = tp.nconst
            AND tp.tconst = tb.tconst
            AND lower(tp.category) LIKE '%actress%'
            AND lower(tb.titletype) LIKE '%movie%'
            AND lower(tb.startyear) NOT LIKE '\n'
            AND tb.startyear BETWEEN '1964' AND '1973'
        GROUP BY
            nb.primaryname,
            nb.nconst,
            tp.category
        HAVING
            COUNT(*) = 3
    )
GROUP BY
    profession;

--2b)
--the maximum number of movies acted by the actors and actresses in a year, in the year range 1964 to 1973

(
    SELECT
        *
    FROM
        (
            SELECT
                actor_id
                || ','
                || name
                || ','
                || year
                || ','
                || number_of_movies_in_a_year
                || ','
                || profession  as "Primary Key, Name, Year, Maximum Number of Movies in a Year from 1964 to 1973, Profession"
            FROM
                (
                    SELECT
                        nb.nconst      AS actor_id,
                        nb.primaryname AS name,
                        tb.startyear   AS year,
                        COUNT(*)       AS number_of_movies_in_a_year,
                        tp.category    AS profession
                    FROM
                        imdb00.name_basics      nb,
                        imdb00.title_principals tp,
                        imdb00.title_basics     tb
                    WHERE
                            nb.nconst = tp.nconst
                        AND tp.tconst = tb.tconst
                        AND lower(tp.category) LIKE '%actor%'
                        AND lower(tb.titletype) LIKE '%movie%'
                        AND lower(tb.startyear) NOT LIKE '\n'
                        AND tb.startyear BETWEEN '1964' AND '1973'
                    GROUP BY
                        nb.primaryname,
                        tb.startyear,
                        nb.nconst,
                        tp.category
                    ORDER BY
                        COUNT(*) DESC
                    FETCH FIRST 1 ROW WITH TIES
                )
            GROUP BY
                name,
                year,
                actor_id,
                profession,
                number_of_movies_in_a_year
            ORDER BY
                year
        )
)
UNION ALL
(
    SELECT
        *
    FROM
        (
            SELECT
                actor_id
                || ','
                || name
                || ','
                || year
                || ','
                || number_of_movies_in_a_year
                || ','
                || profession as "Primary Key, Name, Year, Maximum Number of Movies in a Year from 1964 to 1973, Profession"
            FROM
                (
                    SELECT
                        nb.nconst      AS actor_id,
                        nb.primaryname AS name,
                        tb.startyear   AS year,
                        COUNT(*)       AS number_of_movies_in_a_year,
                        tp.category    AS profession
                    FROM
                        imdb00.name_basics      nb,
                        imdb00.title_principals tp,
                        imdb00.title_basics     tb
                    WHERE
                            nb.nconst = tp.nconst
                        AND tp.tconst = tb.tconst
                        AND lower(tp.category) LIKE '%actress%'
                        AND lower(tb.titletype) LIKE '%movie%'
                        AND lower(tb.startyear) NOT LIKE '\n'
                        AND tb.startyear BETWEEN '1964' AND '1973'
                    GROUP BY
                        nb.primaryname,
                        tb.startyear,
                        nb.nconst,
                        tp.category
                    ORDER BY
                        COUNT(*) DESC
                    FETCH FIRST 1 ROW WITH TIES
                )
            GROUP BY
                name,
                year,
                actor_id,
                profession,
                number_of_movies_in_a_year
            ORDER BY
                year
        )
);
   

--The Minimum number of movies acted by the actors and actresses in a year, in the year range 1964 to 1973
--I have kept minimum number of movies count to be at least 3 in order to reduce the output count
(
    SELECT
        *
    FROM
        (
            SELECT
                actor_id
                || ','
                || name
                || ','
                || year
                || ','
                || number_of_movies_in_a_year
                || ','
                || profession  as "Primary Key, Name, Year, Minimum 3 Number of Movies in a Year from 1964 to 1973, Profession"
            FROM
                (
                    SELECT
                        nb.nconst      AS actor_id,
                        nb.primaryname AS name,
                        tb.startyear   AS year,
                        COUNT(*)       AS number_of_movies_in_a_year,
                        tp.category    AS profession
                    FROM
                        imdb00.name_basics      nb,
                        imdb00.title_principals tp,
                        imdb00.title_basics     tb
                    WHERE
                            nb.nconst = tp.nconst
                        AND tp.tconst = tb.tconst
                        AND lower(tp.category) LIKE '%actor%'
                        AND lower(tb.titletype) LIKE '%movie%'
                        AND lower(tb.startyear) NOT LIKE '\n'
                        AND tb.startyear BETWEEN '1964' AND '1973'
                    GROUP BY
                        nb.primaryname,
                        tb.startyear,
                        nb.nconst,
                        tp.category
                    HAVING
                        COUNT(*) >= 3
                    ORDER BY
                        COUNT(*)
                    FETCH FIRST 10 ROW ONLY -- as there are 4721 actors who have acted in exactly 3 movies each year from 1964 to 1973 I am printing just 10 rows
                )
            GROUP BY
                name,
                year,
                actor_id,
                profession,
                number_of_movies_in_a_year
            ORDER BY
                year
        )
)
UNION ALL
(
    SELECT
        *
    FROM
        (
            SELECT
                actor_id
                || ','
                || name
                || ','
                || year
                || ','
                || number_of_movies_in_a_year
                || ','
                || profession  as "Primary Key, Name, Year, Minimum 3 Number of Movies in a Year from 1964 to 1973, Profession"
            FROM
                (
                    SELECT
                        nb.nconst      AS actor_id,
                        nb.primaryname AS name,
                        tb.startyear   AS year,
                        COUNT(*)       AS number_of_movies_in_a_year,
                        tp.category    AS profession
                    FROM
                        imdb00.name_basics      nb,
                        imdb00.title_principals tp,
                        imdb00.title_basics     tb
                    WHERE
                            nb.nconst = tp.nconst
                        AND tp.tconst = tb.tconst
                        AND lower(tp.category) LIKE '%actress%'
                        AND lower(tb.titletype) LIKE '%movie%'
                        AND lower(tb.startyear) NOT LIKE '\n'
                        AND tb.startyear BETWEEN '1964' AND '1973'
                    GROUP BY
                        nb.primaryname,
                        tb.startyear,
                        nb.nconst,
                        tp.category
                    HAVING
                        COUNT(*) >= 3
                    ORDER BY
                        COUNT(*)
                    FETCH FIRST 10 ROW ONLY -- as there are 2704 actresses who have acted in exactly 3 movies each year from 1964 to 1973 I am printing just 10 rows
                )
            GROUP BY
                name,
                year,
                actor_id,
                profession,
                number_of_movies_in_a_year
            ORDER BY
                year
        )
);

-- Query to show number of actors/actresses who have done exactly 3 movies in a year from 1964 to 1973
SELECT
    profession
    || ','
    || COUNT(*) AS "Profession, Number of acting professionals with 3 movies in a year from 1964 to 1973"
FROM
    (
        SELECT
            nb.nconst      AS actor_id,
            nb.primaryname AS name,
            tb.startyear   AS year,
            COUNT(*)       AS number_of_movies_in_a_year,
            tp.category    AS profession
        FROM
            imdb00.name_basics      nb,
            imdb00.title_principals tp,
            imdb00.title_basics     tb
        WHERE
                nb.nconst = tp.nconst
            AND tp.tconst = tb.tconst
            AND lower(tp.category) LIKE '%actor%'
            AND lower(tb.titletype) LIKE '%movie%'
            AND lower(tb.startyear) NOT LIKE '\n'
            AND tb.startyear BETWEEN '1964' AND '1973'
        GROUP BY
            nb.primaryname,
            tb.startyear,
            nb.nconst,
            tp.category
        HAVING
            COUNT(*) = 3
    )
GROUP BY
    profession
UNION ALL
SELECT
    profession
    || ','
    || COUNT(*) as "Profession, Number of acting professionals with 3 movies in a year from 1964 to 1973"
FROM
    (
        SELECT
            nb.nconst      AS actor_id,
            nb.primaryname AS name,
            tb.startyear   AS year,
            COUNT(*)       AS number_of_movies_in_a_year,
            tp.category    AS profession
        FROM
            imdb00.name_basics      nb,
            imdb00.title_principals tp,
            imdb00.title_basics     tb
        WHERE
                nb.nconst = tp.nconst
            AND tp.tconst = tb.tconst
            AND lower(tp.category) LIKE '%actress%'
            AND lower(tb.titletype) LIKE '%movie%'
            AND lower(tb.startyear) NOT LIKE '\n'
            AND tb.startyear BETWEEN '1964' AND '1973'
        GROUP BY
            nb.primaryname,
            tb.startyear,
            nb.nconst,
            tp.category
        HAVING
            COUNT(*) = 3
    )
GROUP BY
    profession;

set echo off;
set timing off;
spool off;