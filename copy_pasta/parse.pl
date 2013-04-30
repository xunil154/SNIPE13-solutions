#!/usr/bin/perl

# This solution is rather ugly/hackish, but it works
# It works by separating out the individual <span> tags
# in index.php and sorting them based on their 'left' and 'top
# style elements

open(FILE,"index.php") or die "Cannot open file";

# This will hold the rows
%y;

while(<FILE>){
	# find the body tag
	if($_ =~ /<body>/){
		$line = <FILE>;
		@spans = split(/<span/,$line);
		for $span (@spans){
			if($span =~ /(\d+)px; left:(\d+)[^>]+>([^<]*)/){
				$cx = $2;
				$cy = $1;
				$c = $3;
				$ref = $y{$cy};
				unless($ref){
					# This will hold the columns
					$y{$cy} = {};
					$ref = $y{$cy};
				}elsif($ref != $last){
					$last = $ref;
				}
				$ref->{$cx} = $c;
			}
		}
	}
}

# Now sort them and print them out
# sort rows
for $row (sort {$a <=> $b} (keys %y)){
	$ref = $y{$row};
	%map = %$ref;
	# sort columns
	for $col (sort {$a <=> $b} (keys %map)){
		print $map{$col};
	}
	print "<br>\n";
}
