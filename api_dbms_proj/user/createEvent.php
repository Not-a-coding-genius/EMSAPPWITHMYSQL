<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$database = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $database);

$userEmail = $_POST['user_email'];

// Fetch the is_admin value for the user
$adminQuery = "SELECT IsAdmin FROM users_table WHERE user_email = '$userEmail'";
$adminResult = mysqli_query($connectNow, $adminQuery);
$adminRow = mysqli_fetch_assoc($adminResult);

if($adminRow['IsAdmin'] == 'Yes') {
    $eventName = $_POST['event_name'];
    $eventDesc = $_POST['event_desc'];
    $eventDate = $_POST['event_date'];
    $eventAddress = $_POST['event_address'];
    $eventTime = $_POST['event_time'];
    $createdBy = $_POST['user_email'];

    $sqlQuery = "INSERT INTO events_table (event_name, event_desc, event_date, event_address, event_time,created_by) VALUES ('$eventName', '$eventDesc', '$eventDate', '$eventAddress', '$eventTime', '$createdBy')";

    $resultofQuery = mysqli_query($connectNow, $sqlQuery);

    if($resultofQuery === TRUE){
        echo json_encode(array("success"=>true));
    }
    else {
        echo json_encode(array("success"=>false, "error"=> "Error in creating event.", "errorCode"=>mysqli_errno($connectNow)));
    }
} else {
    echo json_encode(array("success"=>false, "error"=> "Only admins can create events."));
}

?>