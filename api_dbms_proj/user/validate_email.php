<?php


$serverhost = "localhost";
$user = "root";
$password = "";
$databae = "dbmsproj";



$connectNow =  mysqli_connect($serverhost, $user, $password, $databae);

$userEmail = $_POST['user_email'];

$sqlquery = "SELECT * FROM users_table WHERE user_email = '$userEmail'";

$resultofQuery = mysqli_query($connectNow, $sqlquery);

if($resultofQuery->num_rows>0){
    echo json_encode(array("emailFound"=>true));
}
else {
    echo json_encode(array("emailFound"=>false));
}

?>