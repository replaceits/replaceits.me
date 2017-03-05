<?php
    if(   !isset($_POST['g-recaptcha-response']) || !isset($_POST['email']) || !isset($_POST['name']) || !isset($_POST['message'])
        || empty($_POST['g-recaptcha-response']) ||  empty($_POST['email']) ||  empty($_POST['name']) ||  empty($_POST['message'])){
        header('Location: ' . dirname($_SERVER['REQUEST_URI']));
        exit(0);
    }

    $email = stripslashes(
                htmlspecialchars(
                    trim(
                        $_POST['email']
             )));
    $name = stripslashes(
                htmlspecialchars(
                    trim(
                        $_POST['name']
             )));
    $message = stripslashes(
                htmlspecialchars(
                    trim(
                        $_POST['message']
             )));

    $valid_captcha  = false;
    $valid_email    = false;
    $valid_name     = false;
    $valid_message  = false;
    $valid_database = false;

    $api_key = file_get_contents('/api-keys/recaptcha.key');
    $database_key = file_get_contents('/api-keys/database.key');

    $valid_email = strlen($email) > 0 && strlen($email) <= 255 && filter_var($email, FILTER_VALIDATE_EMAIL);
    $valid_name = strlen($name) > 0 && strlen($name) <= 255;
    $valid_message = strlen($message) > 0 && strlen($message) <= 5000;

    if( !$valid_email || !$valid_name || !$valid_message ){
        http_response_code(400);
        if( !$valid_email ){
            echo("Invalid email");
        }
        if( !$valid_name ){
            echo("Invalid name");
        }
        if( !$valid_message ){
            echo("Invalid message");
        }
        exit(0);
    }

    try {
        $url = 'https://www.google.com/recaptcha/api/siteverify';
        $data = ['secret'   => $api_key,
                'response' => $_POST['g-recaptcha-response'],
                'remoteip' => $_SERVER['REMOTE_ADDR']];

        $options = [
            'http' => [
                'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
                'method'  => 'POST',
                'content' => http_build_query($data) 
            ]
        ];

        $context  = stream_context_create($options);
        $result = file_get_contents($url, false, $context); 
        $valid_captcha = json_decode($result)->success;
    }
    catch (Exception $e) {
        $valid_captcha = false;
    }

    if( !$valid_captcha ){
        http_response_code(400);
        echo "Invalid captcha";
        exit(0);
    }

    $mysqli_con = new mysqli("localhost","http",$database_key,"replaceits");

    if(!mysqli_connect_errno()){
        $valid_database = true;

        $sql = "INSERT IGNORE INTO contact_form (full_name, email_address, message, message_date) VALUES ( ? , ? , ? ,'" . date("Y-m-d H:i:s") . "');";

        if($stmt = $mysqli_con->prepare($sql)){
            $stmt->bind_param('sss', $name, $email, $message);
            $stmt->execute();
            $stmt->store_result();
            $stmt->close();
        } else {
            $valid_database = false;
        }
    }
    $mysqli_con->close();

    if( !$valid_database ){
        http_response_code(500);
        echo("Invalid database");
        exit(0);
    }

    mail("sharpcut2231@gmail.com", "Contact Form - " . $name, $email . "\n" . $message, 
        'From: contact@replaceits.me' . "\r\n" .
        'Reply-To: contact@replaceits.me' . "\r\n" .
        'MIME-Version: 1.0' . "\r\n" .
        'Content-Type: text/plain; charset=utf-8' . "\r\n" .
        'X-Priority: 1' . "\r\n" .
        'X-Mailer: PHP/' . phpversion() . "\r\n"
    );

    http_response_code(200);

    echo("Success");
    exit(0);
?>