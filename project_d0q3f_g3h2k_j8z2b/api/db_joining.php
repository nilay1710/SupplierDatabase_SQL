<?php
require_once('db_connect.php');
require_once('db_selection.php');
function handleJoiningRequest()
{
    global $db_conn;
    $error_msg = "<div class=\"error-msg\"> ";
    if (empty($_GET['date'])) {
        echo $error_msg .= "Please specify a date. </div>";
    } else {
        $error_msg .= "No deliveries found. </div>";
        $inputDate = new DateTime($_GET['date']);
        $dateString = $inputDate->format('Y-m-d');
        

        $success = False;
        $query = <<< QUERY
        SELECT Customer.name, CustomerPhoneAddress.address
        FROM Customer, Delivery, CustomerPhoneAddress
        WHERE Customer.customerID = Delivery.customerID AND Delivery.scheduledDate = to_date(:day, 'yyyy-mm-dd') 
        AND CustomerPhoneAddress.phoneNumber = Customer.phoneNumber
        QUERY;

        $stid = oci_parse($db_conn, $query);
        oci_bind_by_name($stid, ':day', $_GET['date']);

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
