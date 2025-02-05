--get yearly summary procedure
CREATE OR REPLACE PROCEDURE GET_YEARLY_SUMMARY (p_year IN NUMBER) 
IS
    CURSOR cur_summary IS 
        SELECT STATE, SUM(TOTAL) AS TOTAL_SUICIDES
        FROM SUICIDE_STATISTICS
        WHERE YEAR = p_year
        GROUP BY STATE
        ORDER BY TOTAL_SUICIDES DESC;

    v_state SUICIDE_STATISTICS.STATE%TYPE;
    v_total_suicides NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Suicide Statistics for Year ' || p_year || ' ---');

    FOR rec IN cur_summary LOOP
        DBMS_OUTPUT.PUT_LINE('State: ' || rec.STATE || ' | Total Suicides: ' || rec.TOTAL_SUICIDES);
    END LOOP;
END;
/


SET SERVEROUTPUT ON;
EXEC GET_YEARLY_SUMMARY(2003);


--comapare_years procedure

CREATE OR REPLACE PROCEDURE COMPARE_YEARS (p_year1 NUMBER, p_year2 NUMBER) 
IS
    CURSOR cur_compare IS 
        SELECT STATE, 
               SUM(CASE WHEN YEAR = p_year1 THEN TOTAL ELSE 0 END) AS SUICIDES_YEAR_1,
               SUM(CASE WHEN YEAR = p_year2 THEN TOTAL ELSE 0 END) AS SUICIDES_YEAR_2,
               ROUND(((SUM(CASE WHEN YEAR = p_year2 THEN TOTAL ELSE 0 END) - 
                       SUM(CASE WHEN YEAR = p_year1 THEN TOTAL ELSE 0 END)) /
                       NULLIF(SUM(CASE WHEN YEAR = p_year1 THEN TOTAL ELSE 0 END), 0)) * 100, 2) AS PERCENT_CHANGE
        FROM SUICIDE_STATISTICS
        WHERE YEAR IN (p_year1, p_year2)
        GROUP BY STATE
        ORDER BY PERCENT_CHANGE DESC;

    v_state SUICIDE_STATISTICS.STATE%TYPE;
    v_suicides_1 NUMBER;
    v_suicides_2 NUMBER;
    v_percent_change NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Suicide Comparison: ' || p_year1 || ' vs ' || p_year2 || ' ---');

    FOR rec IN cur_compare LOOP
        DBMS_OUTPUT.PUT_LINE('State: ' || rec.STATE ||
                             ' | ' || p_year1 || ': ' || rec.SUICIDES_YEAR_1 ||
                             ' | ' || p_year2 || ': ' || rec.SUICIDES_YEAR_2 ||
                             ' | % Change: ' || rec.PERCENT_CHANGE || '%');
    END LOOP;
END;
/

EXEC COMPARE_YEARS(2010, 2012);

