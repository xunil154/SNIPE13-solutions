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

$i = 0;
$my_diff = 2;
$str = "SNIPE-2013!";
while(true){
	$diff = proof_of_work($str, "".($i));
	if($diff >= $my_diff){
		echo "$diff:   $str$i\n";
		$hash = hash("sha256",$str.$i);
		echo $hash."\n";
		$my_diff++;
	}
	$i++;
}

?>

