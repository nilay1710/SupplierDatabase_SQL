<?php
require_once('db_connect.php');
require_once('db_selection.php');
function handleSortingRequest()
{
    global $db_conn;
    $error_msg = "<div class=\"error-msg\"> ";
    if (empty($_GET['sortValue']) || empty($_GET['order'])) {
        echo $error_msg .= "Please specify a sort value and the order . </div>";
    } else {
        $error_msg .= "No deliveries found. </div>";

        $success = False;
        $query = <<< QUERY
        SELECT * FROM DELIVERY ORDER BY :sortValue :order
        QUERY;

        if ($_GET['sortValue'] == 'customerID' && $_GET['order'] == "ASC") {

            $query = <<< QUERY
            SELECT * FROM DELIVERY ORDER BY customerID ASC
            QUERY;

        } else if ($_GET['sortValue'] == 'customerID' && $_GET['order'] == "DESC") {
            $query = <<< QUERY
            SELECT * FROM DELIVERY ORDER BY customerID DESC
            QUERY;

        } else if ($_GET['sortValue'] == 'totalCost' && $_GET['order'] == "ASC") {
            $query = <<< QUERY
            SELECT * FROM DELIVERY ORDER BY totalCost ASC
            QUERY;

        } else if ($_GET['sortValue'] == 'totalCost' && $_GET['order'] == "DESC") {
            $query = <<< QUERY
            SELECT * FROM DELIVERY ORDER BY totalCost DESC
            QUERY;

        }

        $stid = oci_parse($db_conn, $query);


        $success = oci_execute($stid);
        if (!$success) {
            echo $error_msg;
//            $e = OCI_Error($statement);
//            echo htmlentities($e['message']);
            echo "<br>";
        } else {
            outputResultTable($stid);
        }
        oci_free_statement($stid);
    }
}

?>
