<?php
require_once('db_selection.php');
require_once('db_connect.php');

function handleInsertRequest() {
    $error_msg = "<div class=\"error-msg\"> ";
    if (empty($_POST['bname']) || empty($_POST['bemail']) 
        || empty($_POST['bphone']) || empty($_POST['bcompname']) 
        || empty($_POST['baddress']) || empty($_POST['btype'])) {
        echo $error_msg . "Please fill in all fields. </div>";
    } else if (!is_numeric($_POST['bphone'])) {
        echo $error_msg . "Invalid phone number. </div>";
    } else {
        global $db_conn, $success;
        $c_ids_result = doSelection('Customer', null, array('customerID'));
        $c_ids = array();
        while (($row = oci_fetch_row($c_ids_result)) != false) {
            array_push($c_ids, $row[0]);
        }
        // try to generate a new customer ID that's not already taken
        $new_cid = rand(4500, 10000);
        while (in_array($new_cid, $c_ids)) {
            $new_cid = rand(4500, 10000);
        }

        $values = array(
            ":phone" => $_POST['bphone'],
            ":baddress" => $_POST['baddress']
        );

        $tuples = array(
            $values
        );

        executeBoundSQL("INSERT INTO CustomerPhoneAddress Values (:phone, :baddress)", $tuples);

        $values = array(
            ":cid" => $new_cid,
            ":bname" => $_POST['bname'],
            ":bemail" => $_POST['bemail'],
            ":phone" => $_POST['bphone']
        );

        $tuples = array(
            $values
        );

        executeBoundSQL("INSERT INTO Customer Values (:cid, :bname, :bemail, :phone)", $tuples);

        $values = array(
            ":cid" => $new_cid,
            ":bcompname" => $_POST['bcompname'],
            ":btype" => $_POST['btype']
        );

        $tuples = array(
            $values
        );

        executeBoundSQL("INSERT INTO Business Values (:cid, :bcompname, :btype)", $tuples);
        OCICommit($db_conn);

        if ($success) {
            echo "<div class=\"success-msg\"> Successfully added business! </div>";
        } else {
            echo $error_msg .= "Could not add new business. Please make sure the customer's new phone number is unique.</div>";
        }
    }

    
}
?>