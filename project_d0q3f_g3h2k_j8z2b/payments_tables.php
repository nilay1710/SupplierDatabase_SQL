<!DOCTYPE html>
<html>

<head>
    <title>Payments and contracts Information</title>
    <style>
        <?php include "styles.css" ?>
    </style>
</head>

<body>
<h2> Payments and contracts Information </h2>
<div class="page-menu" onclick="window.location.href = 'index.php'"> Back</div>

<?php
require_once('api/router.php');
require_once('api/db_selection.php');
require_once('api/db_connect.php');

if (connectToDB()) {
    handleSelectionRequest("Pays_Bill");
    handleSelectionRequest("Signs_Contract");
    handleSelectionRequest("Contract_Dates");
    disconnectFromDB();
}

?>


</body>
</html>

