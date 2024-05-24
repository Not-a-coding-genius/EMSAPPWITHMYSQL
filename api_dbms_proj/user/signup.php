<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$databae = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $databae);

$userName = $_POST['user_name'];
$userEmail = $_POST['user_email'];
$userPassword = ($_POST['user_password']);

$sqlQuery = "INSERT INTO users_table SET user_name = '$userName', user_email = '$userEmail', user_password = '$userPassword'";

$resultofQuery = mysqli_query($connectNow, $sqlQuery);

if($resultofQuery === TRUE){
    echo json_encode(array("success"=>true));
}
else {
    echo json_encode(array("success"=>false));
}

?>
