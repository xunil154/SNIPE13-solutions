#!/usr/bin/perl

open(F,$ARGV[0]) or die "Cannot open wordlist $ARGV[0]";
$file = $ARGV[1];
if($file =~ /([^.]+).zip/){}
$nozip = $1;

print "Looking for $nozip\n";
if(-e $nozip){
	print "File already exists!\n";
}
sleep 1;

$i = 0;
$thresh = 100;
$count = 1;
while(<F>){
	chomp;
	if($i++ > $thresh){
		print $count*$thresh.": $_\n";
		$i = 0;
		$count++;
	}
	$key = $_;
	$command ="unzip -B -P '$key' $file &> /dev/null; echo \$?"; 
	$ret = `$command`;
	if ($ret == 0){
		print "Possible key: $key\n";
		if(-e $nozip){
			print "File unzipped!\n";
			open(T, $nozip);
			if(<T> =~ /^[a-z0-9A-Z~!@#\$%^&*(): \w]+$/){
				print "KEY FOUND: $key\n";
				exit 1;
			}
			close T;
			$a = `rm -f $nozip`;
			unlink $nozip;
		}else{
			print "Does not exist!\n";
		}
	}
	$a = `rm -f $nozip`;
	unlink $nozip;
}
