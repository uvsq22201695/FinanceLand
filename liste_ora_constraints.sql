-- Liste de toutes les contraintes d'intégrité définies

BEGIN
    DBMS_OUTPUT.PUT_LINE('Liste des contraintes par table et par type :');

    FOR rec IN (
        SELECT
            table_name,
            constraint_name,
            constraint_type,
            search_condition
        FROM
            user_constraints
        ORDER BY
            table_name, constraint_type
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Table: ' || rec.table_name ||
            ', Contrainte: ' || rec.constraint_name ||
            ', Type: ' || rec.constraint_type ||
            ', Définition: ' || COALESCE(rec.search_condition, 'N/A')
        );
    END LOOP;
END;
/
