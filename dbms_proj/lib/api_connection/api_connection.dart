class API {
  static const hostConnect = "http://192.168.29.222/api_dbms_proj";
  //static const hostConnect = "http://192.168.193.228/api_dbms_proj";
  static const hostConnectUser = "http://192.168.1.16/user";

  static const validateEmail = "$hostConnect/user/validate_email.php";
  static const signUp = "$hostConnect/user/signup.php";
  static const login = "$hostConnect/user/login.php";
  static const getevents = "$hostConnect/user/getevents.php";
  static const createEvent = "$hostConnect/user/createEvent.php";
  static const addParticipant = "$hostConnect/user/addParticipant.php";
  static const getUserEvents = "$hostConnect/user/getUserEvents.php";
  static const unregisterEvent = "$hostConnect/user/unregisterEvent.php";
  static const forgotPassword = "$hostConnect/user/forgotPassword.php";
  static const getAdminEvents = "$hostConnect/user/getAdminEvents.php";
  static const UpdateEvent = "$hostConnect/user/UpdateEvent.php";
  static const deleteEvent = "$hostConnect/user/deleteEvent.php";
  static const signupProc = "$hostConnectUser/signupproc.php";
}