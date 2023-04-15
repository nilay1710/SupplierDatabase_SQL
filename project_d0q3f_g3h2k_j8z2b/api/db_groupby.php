<?php
require_once('db_connect.php');
require_once('db_selection.php');

function handleGroupByRequest() {
    global $db_conn;

    $query = <<< QUERY
    SELECT name, COUNT(*) as count, SUM(weight * quantity) as totalWeight
    FROM Items
    GROUP BY name
    QUERY;

    $result = executePlainSQL($query);
    outputResultTable($result);
}

?>