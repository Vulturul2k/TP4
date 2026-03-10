# Radu Florea
## TP4


# 1 Comparing things

## 1.1 Questions

### 1  SHA-256 produces a 256-bit hash, meaning there are 2^{256} possible hash values. Because of this huge space, the probability of a collision (two different inputs having the same hash) is practically negligible, roughly 1 in 2^{256}. In practice, finding such a collision is considered computationally infeasible with current technology.

### 2   Using the provided checksum algorithm, it is possible to find collisions because the checksum is computed using a simple weighted sum of character values. For example, the strings “bbb” and “dab” can produce the same checksum. This illustrates the limitation of simple checksum algorithms, which are not designed to prevent collisions. In contrast, strong cryptographic hash functions such as SHA-256 are specifically designed to make collisions extremely unlikely.


# 2 Using your local machine

## 2.1 Building and running a trivial C program

### 1

-rwxr-xr-x@  1 radu  staff  33432 Mar 10 14:34 hello-world
-rw-r--r--@  1 radu  staff     99 Mar 10 14:36 hello-world.c
-rw-r--r--   1 radu  staff     13 Mar 10 13:59 hello-world.txt

### 2
The output may differ between students. Because it uses the current date and time to seed the random number generator.

### 3

No, compiling the program multiple times does not always produce the same binary. The program includes the macros __DATE__ and __TIME__, which insert the compilation date and time into the executable. Since these values change every time the program is compiled, the resulting binary will be different.

### 4

Yes. If the program is run multiple times without recompiling, the output remains the same because the compilation date and time embedded in the binary do not change.

### 5
Yes

### 6
It depends. If the program is intended for personal use, sharing the binary is acceptable. However, if the program is intended for distribution, sharing the source code is better because it allows users to verify the code and ensure it does not contain malicious content.

## 2.3 Building a Pseudo-Random Number Generator

### 1. Compare your output values with those of other students. Are the sequences identical even if compiled on different distributions? Why is this behavior observed with rand()?

No, the sequences are not identical even if compiled on different distributions. But on my pc I got the same sequence.

### 2. If you run the program multiple times (without recompiling), do you always get the same output? Is this “randomness” reproducible?

Yes, the output is reproducible.

## 2.4 Building a Pseudo-Random Number Generator, With a Seed

### 1. If you compile the program multiple times, do you always get the same output? Explain why (not).

It is another number because the seed is different for each compilation at different times.

### 2. If you run the program multiple times (without recompiling), do you always get the same output? Explain why (not).
No, because the seed is different for each run.

### 3. Does this version of the application behave differently (at runtime)? Explain why (not)? 
No but if I run the program fast times. I get the same output.