-- Liste toutes les vues définies

BEGIN
    DBMS_OUTPUT.PUT_LINE('Liste des vues dans la base de données :');

    FOR rec IN (
        SELECT
            view_name,
            text AS view_definition
        FROM
            user_views
        ORDER BY
            view_name
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Vue : ' || rec.view_name ||
            ', Définition : ' || SUBSTR(rec.view_definition, 1, 100) || '...'
        );
    END LOOP;
END;
/