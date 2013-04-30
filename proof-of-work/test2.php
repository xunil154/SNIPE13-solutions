<?php
function proof_of_work($str,$nonce) {
	// nonce = $_GET['nonce']
	$hash = hash("sha256",$str.$nonce);
	$diff = 0;
	for($i = 0; $i < 256; $i++) {
		if($hash[$i] === '0') $diff++;
		else {
			return $diff;
		}
	}
}

function randstr($length = 10) {
	$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	$randomString = '';
	for ($i = 0; $i < $length; $i++) {
		$randomString .= $characters[rand(0, strlen($characters) - 1)];
	}
	return $randomString;
}

$i = 0;
$my_diff = 2;
$str = "SNIPE-2013!";
while(true){
	$i = randstr(200);
	$diff = proof_of_work($str, "".($i));
	if($diff >= $my_diff){
		echo "========================================\n";
		echo "$diff:   $str$i\n";
		$hash = hash("sha256",$str.$i);
		echo "Hash: $hash\n";
		$my_diff++;
	}
}

?>

