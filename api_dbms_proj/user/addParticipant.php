<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$databae = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $databae);

$userEmail = $_POST['user_email'];
$eventName = ($_POST['event_name']);
$eventId = $_POST['event_id'];

$sqlQuery = "INSERT INTO participation_table (user_email, event_name,event_id) VALUES ('$userEmail', '$eventName','$eventId')";

$resultofQuery = mysqli_query($connectNow, $sqlQuery);

if($resultofQuery === TRUE){
    echo json_encode(array("success"=>true));
}
else {
    echo json_encode(array("success"=>false, "error"=> "Error in adding participant."));
}

?>