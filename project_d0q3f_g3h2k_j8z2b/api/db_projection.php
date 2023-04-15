<?php
require_once('db_selection.php');
require_once('db_connect.php');

function handleProjectionRequest($table, $condition, $fields) {
    if($fields) {
        $result = doSelection($table, $condition, $fields);
        outputResultTable($result);
    }else{
        echo "No fields entered";
    }
}

function getTablesForProjection() {
    if (connectToDB()) {
        $tablesQuery = "select table_name from user_tables";
        $result = executePlainSQL($tablesQuery);
        while (($row = oci_fetch_row($result)) != false) { 
            echo "<option value=\"{$row[0]}\"> {$row[0]} </option>";
        }
        disconnectFromDB();
    }
}

function handleGetFieldsForTableRequest() {
    global $db_conn;
    
    $table = $_GET['tableName'];
    $fieldsQuery = "select column_name from USER_TAB_COLUMNS WHERE table_name = :t1";

    $stid = oci_parse($db_conn, $fieldsQuery);
    oci_bind_by_name($stid, ':t1', $table);
    
    $success = oci_execute($stid);

    if ($success) {
        echo "<br />";
        echo "<p> Use CMD or CTRL to select multiple fields </p>";
        echo "<form method=\"GET\" action=\"\">";
        echo "<input type=\"hidden\" name=\"projectionRequest\">";
        echo "<input type=\"hidden\" name=\"projectionTable\" value=\"{$table}\">";
        echo "<select name=\"fields[]\" multiple>";
        while (($row = oci_fetch_row($stid)) != false) { 
            echo "<option value=\"{$row[0]}\"> {$row[0]} </option>";
        }
        echo "</select>";
        echo "<br />";
        echo "<input type=\"submit\" value=\"Show\">";
        echo "</form>";
    }

    oci_free_statement($stid);
}
?>