<!DOCTYPE html>
<html>
    <head>
		<meta charset="utf-8">
		<meta http-equiv="x-ua-compatible" content="ie=edge">

		<title>404 Not found - Sidney Williams</title>

		<base href="https://www.replaceits.me/">

		<link rel="stylesheet" href="css/replaceits.me.css?v=0.4">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
		<link rel="shortcut icon" href="favicon.ico">

		<script async src="js/console.js"></script>
	</head>

	<body>
		<div class="body-wrapper">
			<div class="content-container">
				<div class="header-name">404 - Not found!</div>
				<div class="description center">
					We're sorry but the page "<?php echo(htmlspecialchars(strip_tags($_SERVER['REQUEST_URI']))); ?>" couldn't be found on this server!
				</div>
			</div>
		</div>
		<div class="footer">
			<a href="/">Click here to go back</a>
		</div>
	</body>
</html>
