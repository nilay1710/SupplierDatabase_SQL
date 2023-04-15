<!DOCTYPE html>
<html lang="">
    <head>
        <title>Group 93 Project</title>
        <style>
            <?php include "styles.css" ?>
        </style>
    </head>

    <body>
        <h1>Supplier Database</h1>
        <div class="page-menu" onclick="window.location.href = 'delivery_tables.php'">
            Delivery
        </div>
        <div class="page-menu" onclick="window.location.href = 'warehouse_tables.php'">
            Warehouse
        </div>
        <div class="page-menu" onclick="window.location.href = 'customer_tables.php'"> 
            Customer
        </div>
        <div class="page-menu" onclick="window.location.href = 'payments_tables.php'">
            Payments
        </div>
        <br />
        <div>
            <h2> Display any field from any table: </h2>
            <form method="GET" action="index.php">
                <input type="hidden" name="getFieldsForTableRequest">
                <select name="tableName" onchange="this.form.submit()">
                    <?php 
                        require_once('api/db_projection.php');
                        getTablesForProjection();
                    ?>
                </select>
            </form>
            <?php require_once('api/router.php'); ?>
        </div>
	</body>
</html>
