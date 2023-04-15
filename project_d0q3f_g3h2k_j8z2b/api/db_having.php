<?php
require_once('db_connect.php');
require_once('db_selection.php');

function handleHavingByRequest() {
    global $db_conn;

    $query = <<< QUERY
    SELECT ITEMS.name, SUM(weight * quantity)
    FROM Items, ITEMCOSTS
    GROUP BY ITEMS.name
    HAVING AVG(cost) > 10 
    QUERY;

    $result = executePlainSQL($query);
    outputResultTable($result);
}

?>
