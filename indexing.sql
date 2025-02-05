
--Index on year and state
--To ensure that the queries that filter by year and state (WHERE YEAR = 2015 AND STATE = 'Maharashtra') will run significantly faster.
CREATE INDEX IDX_YEAR_STATE ON SUICIDE_STATISTICS (YEAR, STATE);


