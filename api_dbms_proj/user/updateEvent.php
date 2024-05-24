<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$database = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $database);

$eventId = $_POST['event_id'];

// Check if there's an event with the provided event_id
$checkQuery = "SELECT * FROM events_table WHERE event_id = '$eventId'";
$checkResult = mysqli_query($connectNow, $checkQuery);

if(mysqli_num_rows($checkResult) > 0){
    $eventName = $_POST['event_name'];
    $eventDesc = $_POST['event_desc'];
    $eventDate = $_POST['event_date'];
    $eventAddress = $_POST['event_address'];
    $eventTime = $_POST['event_time'];

    $sqlQuery = "UPDATE events_table SET event_name = '$eventName', event_desc = '$eventDesc', event_date = '$eventDate', event_address = '$eventAddress', event_time = '$eventTime' WHERE event_id = '$eventId'";

    $resultofQuery = mysqli_query($connectNow, $sqlQuery);

    if($resultofQuery === TRUE){
        echo json_encode(array("success"=>true));
    }
    else {
        echo json_encode(array("success"=>false, "error"=> "Error in updating event.", "errorCode"=>mysqli_errno($connectNow)));
    }
} else {
    echo json_encode(array("success"=>false, "error"=> "No event found with the provided event_id."));
}

?>