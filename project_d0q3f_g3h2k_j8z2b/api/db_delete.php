<?php
require_once('db_connect.php');

function handleDeleteRequest($id) {
    global $db_conn, $success;

    $query = "DELETE FROM Customer WHERE customerID = :cid";
    $values = array(
        ':cid' => $id
    );
    $tuples = array(
        $values
    );
    $result = executeBoundSQL($query, $tuples);
    

    if ($success) {
        echo "Successfully deleted the selected rows.";
    } else {
        echo "Error deleting rows from the table.";
    }

    OCICommit($db_conn);
}
?>
