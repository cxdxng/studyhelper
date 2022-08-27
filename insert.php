<?php

include "../../php/studyhelper/conn.php";

$title = $_POST["title"];
$date = $_POST["date"];
$start = $_POST["start"];

$sql = "INSERT INTO Appointments (title, date, start)
VALUES ('$title', $date, '$start')";

if ($conn->query($sql) === TRUE) {

} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();

?>