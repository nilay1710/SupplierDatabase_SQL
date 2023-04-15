<?php
require_once('db_connect.php');

function doSelection($table, $condition = null, $fields = null) {
    global $db_conn;
    if (is_null($condition)) {
        if (is_null($fields)) {

            // Basic select : everything
            $result = executePlainSQL("SELECT * FROM $table");
        } else {

            // projection with different fields
            $selected_fields = implode(", ", $fields);
            $result = executePlainSQL("SELECT $selected_fields FROM $table");
        }
    } else {
        if (is_null($fields)) {

            //Select with a condition (no projection)
            $result = executePlainSQL("SELECT * FROM $table WHERE $condition");
        } else {

            // Select with condition  and projection
            $selected_fields = implode(", ", $fields);
            $result = executePlainSQL("SELECT $selected_fields FROM $table WHERE $condition");
        }
    }

    return $result;
}

function outputResultTable($result) {
    $num_fields = oci_num_fields($result);
    $output = "<table>";
    $output .=  "<tr>";
    for ($i = 1; $i <= $num_fields; $i++) {
        $output .=  "<th> " . oci_field_name($result, $i) . " </th>";
    }
    $output .=  "</tr>";
    while (($row = oci_fetch_row($result)) != false) {
        $output .=  "<tr>";
        for ($i = 0; $i < $num_fields; $i++) { 
            $output .=  "<td> " . $row[$i] . " </td>";
        }
        $output .=  "</tr>";
    }
    $output .=  "</table>";
    echo $output;
}

function handleSelectionRequest($table, $condition = null, $fields = null) {
    echo "<h2> Table: $table </h2>";
    $result = doSelection($table, $condition, $fields);
    outputResultTable($result);
}


?>