<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$database = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $database);

$userId = $_POST['userid'];
$newPassword = $_POST['user_password'];

$sqlQuery = "UPDATE users_table SET user_password = '$newPassword' WHERE userid = '$userId'";

$resultofQuery = mysqli_query($connectNow, $sqlQuery);

if($resultofQuery === TRUE){
    echo json_encode(array("success"=>true));
}
else {
    echo json_encode(array("success"=>false, "error"=> "Error in updating password.", "errorCode"=>mysqli_errno($connectNow)));
}

?>