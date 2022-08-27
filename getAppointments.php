<?php

$dbUser = $_POST["dbUser"];
$passwd = $_POST["passwd"];

$conn = new mysqli("localhost", $dbUser, $passwd, "Studyhelper");

if(!$conn){
    echo "connection failed!";
    exit();
}

$queryResult = $conn->query("SELECT * FROM Appointments");

$result = array();

while($fetchdata=$queryResult->fetch_assoc()){
    $result[] = $fetchdata;
}

echo json_encode($result)

?>