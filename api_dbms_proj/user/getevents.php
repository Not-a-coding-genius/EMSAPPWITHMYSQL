<?php
$serverhost = "localhost";
$user = "root";
$password = "";
$databae = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $databae);

$eventDate = isset($_POST['event_date']) ? $_POST['event_date'] : null;

if($eventDate) {
    $sqlQuery = "SELECT * FROM events_table WHERE event_date = '$eventDate'";

    $resultofQuery = mysqli_query($connectNow, $sqlQuery);

    $arr = [];

    while($rowFound = $resultofQuery->fetch_assoc()){
        $arr[] = $rowFound;
    }
    print(json_encode($arr));
} else {
    echo "Event date is not provided.";
}
?>