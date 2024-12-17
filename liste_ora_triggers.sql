-- Liste de tous les triggers définis

BEGIN
    DBMS_OUTPUT.PUT_LINE('Liste des triggers par table :');

    FOR rec IN (
        SELECT
            table_name,
            trigger_name,
            description
        FROM
            user_triggers
        ORDER BY
            table_name
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Table: ' || rec.table_name ||
            ', Trigger: ' || rec.trigger_name ||
            ', Description: ' || rec.description
        );
    END LOOP;
END;
/