<?php
function handleAggregationRequest() {
    global $db_conn;

    $date_from = '2023-02-24';
    $date_to = '2023-02-26'; //date('Y-m-d', strtotime('+2 days'));

    $query = "SELECT warehouseName, COUNT(*)
              FROM Delivery 
              WHERE scheduledDate >= TO_DATE('$date_from', 'YYYY-MM-DD') 
              AND scheduledDate <= TO_DATE('$date_to', 'YYYY-MM-DD') 
              GROUP BY warehouseName 
              HAVING COUNT(*) > 0";

    $result = executePlainSQL($query);
    outputResultTable($result);

    // if (($row = oci_fetch_row($result)) != false) {
    //     echo "<table>";
    //     echo "<tr><th>Destination Address</th><th>Number of Deliveries</th></tr>";
    //     do {
    //         echo "<tr><td>" . $row[0] . "</td><td>" . $row[1] . "</td></tr>";
    //     } while (($row = oci_fetch_row($result)) != false);
    //     echo "</table>";
    // } else {
    //     echo "No deliveries found";
    // }
}
?>
