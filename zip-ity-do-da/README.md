This challenge required decrypting a zip file. Normally people will use fcrackzip for this
but I was running into issues using it with my dictionary file. It would segfault upon loading

So of course my solution was to roll my own zip cracker. It does make some VERY broad assumptions
of which are probably not true for any other zip files in existance. 

Assumptions:
  If the file is 'file.zip' it assumes the decrypted file will be named 'file'
  It also assumes the content of that file will only be alpha-numeric

How it works:
  It reads your dictionary file line by line and runs 'unzip -B -P <password> file.zip'
  for each password in the dictionary.

  It then checks to see if the file 'file' was created. If it was created, it lets you know
  that a possible solution exists, and will then read the file to check if it contains only
  alpha-numeric. If it is only alpha-numeric, then it assumes you found the key and exits.

Running:
  $ decrypt.pl /path/to/dictionary/file.txt encrypted.zip

