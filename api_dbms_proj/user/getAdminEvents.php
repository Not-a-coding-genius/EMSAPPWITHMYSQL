<?php
$serverhost = "localhost";
$user = "root";
$password = "";
$databae = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $databae);

$userEmail = isset($_POST['created_by']) ? $_POST['created_by'] : null;

if($userEmail) {
    $sqlQuery = "SELECT * FROM events_table WHERE created_by = '$userEmail'";

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