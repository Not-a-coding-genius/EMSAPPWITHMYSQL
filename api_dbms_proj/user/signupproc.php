<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$database = "dbmsproj";

$connectNow = mysqli_connect($serverhost, $user, $password, $database);

if ($connectNow->connect_error) {
    die("Connection failed: " . $connectNow->connect_error);
}

$userName = $_POST['user_name'];
$userEmail = $_POST['user_email'];
$userPassword = $_POST['user_password'];

$sqlQuery = "CALL RegisterUser($userName, $userEmail, $userPassword)";

if ($connectNow->query($sqlQuery) === TRUE) {
    echo json_encode(array("success"=>true));
} else {
    echo "Error: " . $sqlQuery . "<br>" . $connectNow->error;
}

$connectNow->close();

?>