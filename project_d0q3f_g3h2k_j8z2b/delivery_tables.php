<!DOCTYPE html>
<html>
<head>
    <title>Delivery Information</title>
    <style>
        <?php include "styles.css" ?>
    </style>
</head>
<body>
<h2> Delivery Information </h2>
<div class="page-menu" onclick="window.location.href = 'index.php'"> Back</div>

<?php
require_once('api/db_selection.php');
require_once('api/db_connect.php');

if (connectToDB()) {
    handleSelectionRequest("Delivery");
    handleSelectionRequest("Drivers");
    disconnectFromDB();
}
?>
<br/>

<h3>Choose a related table to display:</h3>
<form method="GET" action="delivery_tables.php">
    <input type="hidden" id="selectRequest" name="selectRequest">
    <select name="tableName">
        <option value="transportvehicle"> Transport Vehicles</option>
        <option value="items"> Items</option>
        <option value="itemcosts"> Item Costs</option>
        <option value="deliveryreceived"> Delivery Received</option>
    </select>
    <input type="submit" value="Go">
</form>
<h3>Find drivers who made all deliveries to a certain customer on a certain day:</h3>
<form method="GET" action="delivery_tables.php">
    <input type="hidden" name="divisionRequest">
    Date:<input type="date" name="date" style="margin: 10px;"><br/>
    Customer ID: <input type="text" name="cid" style="margin: 10px;"><br/>
    <input type="submit" value="Find Deliveries">
</form>
<br/>
<h3>Find counts and total weights of each item by name:</h3>
<form method="GET" action="delivery_tables.php">
    <input type="hidden" name="groupByRequest">
    <input type="submit" value="Go">
</form>

<br/>
<br/>
<!--<h3>Enter only the fields you would like to see for the delivery tables-->
<!--    (in capitals and seperated by a comma) and submit!</h3>-->
<!--<form method="GET" action="delivery_tables.php">-->
<!--    <input type="hidden" name="projectionRequest">-->
<!--    Fields: <input type="text" name="fields" style="margin: 10px;">-->
<!--    <input type="submit" value="Submit">-->
<!--</form>-->

<!-- <h3> Select only the fields you would like to see (press command or control to select multiple) </h3>
<form method="GET" action="delivery_tables.php">
    <input type="hidden" id="projectionRequest" name="projectionRequest">
    <input type="hidden" name="projectionTable" value="Delivery">
    <select name="fields" multiple size="12">
        <option value="DELIVERYID"> Delivery ID</option>
        <option value="DELIVERYTIME"> Delivery time </option>
        <option value="TOTALWEIGHT"> Total weight </option>
        <option value="TOTALCOST"> Total cost </option>
        <option value="CUSTOMERID"> Customer ID </option>
        <option value="TRANSPORTSTATUS"> transport status </option>
        <option value="DRIVERLICENSENUMBER"> driver license number </option>
        <option value="TRANSPORTVEHICLENAME"> Transport vehicle name </option>
        <option value="STOREDSINCE"> stored since </option>
        <option value="WAREHOUSENAME"> warehouse name</option>
        <option value="SCHEDULEDDATE"> scheduled date </option>
        <option value="DESTINATION"> destination </option>

    </select>
    <input type="submit" value="Go">
</form> -->
    
<!-- <h3>Delete deliveries based on id</h3>
<form method="GET" action="delivery_tables.php">
    <input type="hidden" id="deleteRequest" name="deleteRequest">
    ID:<input id="id" name="id" style="margin: 10px;"><br/>
    <input type="submit" value="Go">
</form>
<br/> -->
 

<h3>Find the license number and the total weight transported by the best driver
(driver with the maximum average weight transported</h3>
<form method="GET" action="delivery_tables.php">
    <input type="hidden" name="nestedGroupByRequest">
    <input type="submit" value="Go">
</form>

<br/>
 

<h3>Find the deliveries within two days of current day</h3>
<form method="GET" action="delivery_tables.php">
    <input type="hidden" name="aggregationRequest">
    <input type="submit" value="Go">
</form>
    
<h3>Find deliveries based on transport status (filtering/selection) </h3>
<form method="GET" action="delivery_tables.php">
    <input type="hidden" id="filterRequest" name="filterRequest">
    <select name="status">
        <option value="in-delivery"> In delivery</option>
        <option value="in warehouse"> In warehouse </option>
        <option value="delayed"> Delayed </option>
        <option value="delivered"> Delivered </option>
    </select>
    <input type="submit" value="Go">

</form>
    
<h3>Find deliveries and sort based on a sorting value (customerID or Total cost) and order (ASC/DESC) </h3>
<form method="GET" action="delivery_tables.php">
    <input type="hidden" id="sortRequest" name="sortRequest">
    <select name="sortValue">
        <option value="customerID"> customer ID</option>
        <option value="totalCost"> total CoSt </option>
    </select>
    <input type="hidden" id="orderRequest" name="orderRequest">
    <select name="order">
        <option value="ASC"> ascending order</option>
        <option value="DESC"> descending order </option>
    </select>
    
    <input type="submit" value="Go">

</form>
    
<h3> Join the Delivery Table and Customer table to find the names and addresses of all customers who have scheduled delivery on a specific day </h3>
<form method="GET" action="delivery_tables.php">
    <input type="hidden" id="joinRequest" name="joinRequest">
    DATE: <input type="date" name="date" style="margin: 10px;">
    <input type="submit" value="Go">

</form>
<br/>
<br/>
<?php
require_once('api/router.php');
?>
<br/>
<br/>
</body>
</html>
