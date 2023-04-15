<?php
require_once('db_connect.php');
require_once('db_selection.php');
// in-progress
function handleDivisionRequest() {
    $error_msg = "<div class=\"error-msg\"> ";
    if (empty($_GET['date']) || empty($_GET['cid'])) {
        echo $error_msg .= "Please specify a date. </div>";
    } else {
        global $db_conn;
        $error_msg .= "Could not complete query. </div>";

        $success = False;
        $inputDate = new DateTime($_GET['date']);
        $inputTimeStart = $inputDate->format("Y-m-d H:i:s");

        $interval = new DateInterval('P1D');
        $inputDate->add($interval);
        $inputTimeEnd = $inputDate->format("Y-m-d H:i:s");
        $query = <<< QUERY
        SELECT DISTINCT dr1.licenseNumber, dr1.name FROM Drivers dr1, Delivery d3 
        WHERE dr1.licenseNumber = d3.driverLicenseNumber 
        AND d3.customerID = :cid 
        AND NOT EXISTS (
            (SELECT d1.driverLicenseNumber
            FROM Delivery d1
            WHERE d1.deliveryTime >= to_timestamp(:d1, 'yyyy-mm-dd hh24:mi:ss') 
            AND d1.deliveryTime < to_timestamp(:d2, 'yyyy-mm-dd hh24:mi:ss')
            AND d1.customerID = :cid)
            MINUS 
            (SELECT d2.driverLicenseNumber
            FROM Delivery d2
            WHERE d2.driverLicenseNumber = dr1.licenseNumber))
        QUERY;

        $stid = oci_parse($db_conn, $query);
        oci_bind_by_name($stid, ':cid', $_GET['cid']);
        oci_bind_by_name($stid, ':d1', $inputTimeStart);
        oci_bind_by_name($stid, ':d2', $inputTimeEnd);

        $success = oci_execute($stid);
        if (!$success) {
            echo $error_msg;
            $e = OCI_Error($stid);
            echo htmlentities($e['message']);
            echo "<br>";
        } else {
            outputResultTable($stid);
        }
        oci_free_statement($stid);
    }
}
?>