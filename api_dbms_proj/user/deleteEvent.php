<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$database = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $database);

$eventId = $_POST['event_id'];

$sqlQuery = "DELETE FROM events_table WHERE event_id = '$eventId'";

$resultofQuery = mysqli_query($connectNow, $sqlQuery);

if($resultofQuery === TRUE){
    echo json_encode(array("success"=>true));
}
else {
    echo json_encode(array("success"=>false, "error"=> "Error in deleting event.", "errorCode"=>mysqli_errno($connectNow)));
}

?>