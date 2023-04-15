<?php
require_once('db_connect.php');
require_once('db_selection.php');
function handleFilteringRequest()
{
    global $db_conn;
    $error_msg = "<div class=\"error-msg\"> ";
    if (empty($_GET['status'])) {
        echo $error_msg .= "Please specify a transportation status. </div>";
    } else {
        $error_msg .= "No deliveries found. </div>";

        $success = False;
        $query = <<< QUERY
        SELECT * FROM DELIVERY WHERE TRANSPORTSTATUS = :status
        QUERY;

        $stid = oci_parse($db_conn, $query);
        oci_bind_by_name($stid, ':status', $_GET['status']);

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