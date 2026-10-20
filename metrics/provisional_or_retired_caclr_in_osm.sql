-- Title: Provisional or retired CACLR in OSM
-- Description: OSM addresses referencing CACLR entries that are provisional or no longer valid
-- include osm_potential_addresses.sql
SELECT
    opa.osm_id,
    opa.osm_type,
    opa.url,
    opa.josmuid,
    opa."addr:housenumber",
    opa."addr:street",
    opa."addr:city",
    opa."ref:caclr",
    opa."note:caclr",
    i.indic_provisoire,
    i.date_fin_valid,
    i.ds_timestamp_modif,
    opa.osm_timestamp
FROM osm_potential_addresses AS opa
INNER JOIN immeuble AS i
    ON opa."ref:caclr" = i.numero_interne::text
WHERE
    i.indic_provisoire = 'O'
    OR (i.date_fin_valid IS NOT NULL AND i.date_fin_valid <= CURRENT_DATE)
ORDER BY
    opa."addr:city",
    opa."addr:street",
    opa."addr:housenumber";
