<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$database = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $database);

$userEmail = $_POST['user_email'];
$eventName = $_POST['event_name'];

$sqlQuery = "DELETE FROM participation_table WHERE user_email = '$userEmail' AND event_name = '$eventName'";

$resultofQuery = mysqli_query($connectNow, $sqlQuery);

if($resultofQuery === TRUE){
    echo json_encode(array("success"=>true));
}
else {
    echo json_encode(array("success"=>false, "error"=> "Error in unregistering from event.", "errorCode"=>mysqli_errno($connectNow)));
}

?>