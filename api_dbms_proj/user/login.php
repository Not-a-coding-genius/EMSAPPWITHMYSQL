<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$databae = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $databae);

$userEmail = $_POST['user_email'];
$userPassword = ($_POST['user_password']);

$sqlQuery = "SELECT * FROM users_table WHERE user_email = '$userEmail' AND user_password = '$userPassword'";

$resultofQuery = mysqli_query($connectNow, $sqlQuery);

if($resultofQuery->num_rows > 0){
    $userRecord = array();
    while($rowFound = $resultofQuery->fetch_assoc()){
        $userRecord = $rowFound;
    }
    echo json_encode(array("login"=>true, "userData"=>$userRecord));
}
else {
    echo json_encode(array("login"=>false));
}

?>