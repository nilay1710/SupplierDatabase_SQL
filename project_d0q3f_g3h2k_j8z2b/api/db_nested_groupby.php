<?php

require_once('db_connect.php');
require_once('db_selection.php');

function handleNestedGroupByRequest()
{
    global $db_conn;
    $query = <<< QUERY
SELECT D.driverLicenseNumber, AVG(totalWeight) AS avg_total_weight
FROM Delivery D
GROUP BY D.driverLicenseNumber
HAVING AVG(totalWeight) >= ALL (SELECT AVG(D2.totalWeight)
                                FROM Delivery D2
                                GROUP BY driverLicenseNumber)

QUERY;

    $result = executePlainSQL($query);
    outputResultTable($result);
}

