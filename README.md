# Enigma Machine

Welcome to a digital version of Enigma!

## About

This Enigma Machine is an encryption and decryption creator. It uses a Caesar Cypher to change each letter in a message by rotating along the alphabet based on one of four character offset values that are calculated using a 5-digit key and a 6-digit date. It's the final individual (solo) project in Module 1 at Turing School of Software and Design.

The project is inspired by Alan Turing and his work deciphering Nazi messages during WWII with his "universal machine."

Just like in Turing's real-life scenario, we are able to crack the code and decipher text using only a date because there is a known, consistent series of characters - in this case, " end" at the conclusion of each cypher text.

## Written Using:
Ruby v. 2.7.2

## How To:

First, clone this repo.

From the enigma-machine directory, enter the following into your command line to encrypt a message.txt file using a random key and today's date; the encryption will be written to encrypted.txt:
```
ruby ./lib/encrypt.rb message.txt encrypted.txt
```

Optionally, you can specify the key and date as two additional arguments, in the encrypt.rb file, line 13 - for example:
```
encrypted = enigma.encrypt(message, "02715", "040895")
```

To decrypt, use this CLI command including the key; you can either include the date used to encrypt, or eliminate that last argument to automatically use today's date:
```
ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 02715 040895
```

Finally, this command will "crack the code" and find the key. You can optionally provide the date used in the encryption, or eliminate that argument to crack using today's date:
```
ruby ./lib/crack.rb encrypted.txt cracked.txt 040895
```

> Please note! These assumptions are built in to the functionality: 

1. The CLI commands are all run on the same date or provided the same date values.
1. Cracking will only work if the message has " end" as the last four characters.

### Self-Evaluation

Per the project requirements, here is a self-evaluation of my work on Enigma.

- **Functionality: 4**, Cracking method and command line interface successfully implemented.

- **Object-Oriented Programming: 4**, Student has implemented either inheritance or at least one module in a logical manner. Students can speak as to how/why inheritance and modules made sense for the given implementations, why they improve the organization of the code, and the distinction between the two.

- **Ruby Conventions and Mechanics: 3**, Code is mostly properly indented, spaced, and lines are not excessively long. Class, method, variable, and file names follow convention. Some enumerables/data structures chosen are the most efficient tool for a given job, and students can speak as to why those enumerables/data structures were chosen. At least one hash is implemented in a way that makes logical sense.
 -- I didn't give myself 4 points here because I do have a couple of methods longer than 10 lines, and I'd be interested in hearing from my instructors whether a different enum was better for the job where I used one.

- **Test-Driven Development: 4**, Mocks and/or stubs are used appropriately to ensure two or more of the following: testing is more robust (i.e., testing methods that might not otherwise be tested due to factors like randomness or user input), testing is more efficient, or that classes can be tested without relying on functionality from other classes. Students are able to speak as to how mocks and/or stubs are fulfilling the above conditions. Test coverage metrics show 100% coverage.
