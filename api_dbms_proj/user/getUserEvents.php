<?php
$serverhost = "localhost";
$user = "root";
$password = "";
$databae = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $databae);

$userEmail = isset($_POST['user_email']) ? $_POST['user_email'] : null;

if($userEmail) {
    $sqlQuery = "SELECT event_name FROM participation_table WHERE user_email = '$userEmail'";

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