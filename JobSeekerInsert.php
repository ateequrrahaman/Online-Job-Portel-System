<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<?php

// Create the upload directory if it doesn't exist
if (!file_exists("upload")) {
    mkdir("upload");
}

$Name = trim($_POST['txtName']);
$Address = $_POST['txtAddress'];
$City = $_POST['txtCity'];
$Email = $_POST['txtEmail'];
$Mobile = $_POST['txtMobile'];
$Qualification = $_POST['txtQualification'];
$Gender = $_POST['cmbGender'];
$BirthDate = $_POST['txtBirthDate'];
$path1 = $_FILES["txtFile"]["name"];
$Status = "Pending";
$UserName = $_POST['txtUserName'];
$Password = $_POST['txtPassword'];
$Question = $_POST['cmbQue'];
$Answer = $_POST['txtAnswer'];
$UserType = "JobSeeker";

// Print the length of JobSeekerName for debugging
echo "Length of JobSeekerName: " . strlen($Name);

// Establish Connection with MYSQL
$con = mysqli_connect("localhost", "root", "Atsql@801", "job");

// Use prepared statements to prevent SQL injection
$sql = "INSERT INTO jobSeeker_reg (JobSeekerName, Address, City, Email, Mobile, Qualification, Gender, BirthDate, Resume, Status, UserName, Password, Question, Answer) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = mysqli_prepare($con, $sql);

// Bind parameters
mysqli_stmt_bind_param($stmt, "ssssssssssssss", $Name, $Address, $City, $Email, $Mobile, $Qualification, $Gender, $BirthDate, $path1, $Status, $UserName, $Password, $Question, $Answer);

// Move the uploaded file
move_uploaded_file($_FILES["txtFile"]["tmp_name"], "upload/" . $path1);

// Execute the statement
if (mysqli_stmt_execute($stmt)) {
    echo '<script type="text/javascript">alert("Registration Completed Successfully");window.location=\'index.php\';</script>';
} else {
    echo "Error: " . mysqli_error($con);
}

// Close statement and connection
mysqli_stmt_close($stmt);
mysqli_close($con);

?>
</body>
</html>
