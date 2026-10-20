-- Title: Unmapped valid CACLR addresses
-- Description: Valid official CACLR addresses that are not yet mapped in OpenStreetMap
-- include osm_potential_addresses.sql
SELECT
    a.id_caclr_bat,
    a.numero,
    a.rue,
    a.localite,
    a.code_postal,
    a.commune,
    i.ds_timestamp_modif
FROM addresses AS a
INNER JOIN immeuble AS i
    ON a.id_caclr_bat = i.numero_interne::text
LEFT JOIN osm_potential_addresses AS opa
    ON a.id_caclr_bat = opa."ref:caclr"
WHERE
    opa.osm_id IS NULL
    AND a.numero IS NOT NULL
    AND (i.indic_provisoire IS NULL OR i.indic_provisoire != 'O')
    AND (i.indic_no_indef IS NULL OR i.indic_no_indef != 'O')
    AND (i.date_fin_valid IS NULL OR i.date_fin_valid > CURRENT_DATE)
ORDER BY
    a.localite,
    a.rue,
    a.numero;
