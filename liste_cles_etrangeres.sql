-- Liste des colonnes référencées par des contraintes de clé étrangère

BEGIN
    DBMS_OUTPUT.PUT_LINE('Colonnes référencées par des clés étrangères :');

    FOR rec IN (
        SELECT
            uc.constraint_name,
            ucc.table_name || '.' || ucc.column_name AS source_column,
            rc.owner || '.' || rc.table_name || '.' || rc.column_name AS referenced_column
        FROM
            user_constraints uc
            JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name
            JOIN user_cons_columns rc ON uc.r_constraint_name = rc.constraint_name
        WHERE
            uc.constraint_type = 'R'
        ORDER BY
            uc.constraint_name
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Contrainte: ' || rec.constraint_name ||
            ', Colonne source: ' || rec.source_column ||
            ', Colonne référencée: ' || rec.referenced_column
        );
    END LOOP;
END;
/
