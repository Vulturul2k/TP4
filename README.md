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


### 2.6 Monte Carlo 𝜋 Approximation

### 2. What happens when you increase the number of iterations?

When the number of iterations n increases, the approximation of π becomes more accurate and gets closer to the real value of π. At the same time, the execution time increases, because the program must generate and test more random points.

### 3
The implementation is not reproducible at build time. When compiling the program multiple times and computing the SHA-512 checksum of the resulting executable, the checksums are different for each compilation.

This occurs because the program includes the macros __DATE__ and __TIME__, which insert the compilation date and time into the binary. Since these values change every time the program is compiled, the resulting executable is different even if the source code remains identical.

To make the program build-time reproducible, these macros must be removed so that the binary does not depend on the compilation time.


```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {

    double x, y;
    int inside = 0;

    int n = 10000;

    srand(time(NULL));

    for(int i = 0; i < n; i++) {
        x = (double) rand() / RAND_MAX;
        y = (double) rand() / RAND_MAX;

        if(x*x + y*y <= 1)
            inside++;
    }

    double pi = 4.0 * inside / n;

    printf("Pi approximation: %f\n", pi);

    return 0;
}
```

### 4. Run-time reproducibility

The implementation is not reproducible at run time. When executing the program multiple times, the results are different because the random number generator is initialized with srand(time(NULL)). Since the seed depends on the current system time, each execution starts with a different seed and therefore generates a different sequence of random numbers.

To make the program runtime reproducible, the random generator must be initialized with a fixed seed (for example srand(42)). This ensures that the same sequence of pseudo-random numbers is generated each time the program runs, producing identical results.

### 5. Both build-time and run-time reproducible version
To make the program both build-time and run-time reproducible, all sources of non-determinism must be removed. The macros __DATE__ and __TIME__ were removed to avoid embedding compilation timestamps in the binary. Additionally, the random number generator was initialized with a fixed seed instead of the current time.

By eliminating compilation timestamps and using a constant seed for the pseudo-random generator, the compiled executable remains identical across builds and the program produces exactly the same output each time it is executed.
```c
#include <stdio.h>
#include <stdlib.h>

int main() {

    double x, y;
    int inside = 0;
    int n = 10000;

    srand(42);

    for(int i = 0; i < n; i++) {

        x = (double) rand() / RAND_MAX;
        y = (double) rand() / RAND_MAX;

        if(x*x + y*y <= 1)
            inside++;
    }

    double pi = 4.0 * inside / n;

    printf("Pi approximation using %d iterations: %f\n", n, pi);

    return 0;
}
```

# 3 Docker
### 1. How many parameters your version of the Monte Carlo application from Section 2.6.1 should accept to be reproducible at buildtime and at runtime ?
The application should accept two parameters to ensure reproducibility: the number of iterations (n) and the random seed. The number of iterations controls the number of random samples used in the simulation, while the seed determines the sequence of pseudo-random numbers generated by rand(). Using the same values for both parameters guarantees that the program produces the same output across executions and systems
### 2. Build the image using the Containerfile from Listing 7 and Listing 8, compare and report their sizes.
The image built from Listing 7 (single-stage build) is significantly larger than the image built from Listing 8 (multi-stage build). The reason for this difference is that the single-stage build contains all the build dependencies such as the GCC compiler and development tools (build-base). These tools remain inside the final image even though they are only needed during compilation.
### 3 Build the image using the Containerfile from Listing 8 and compare their sizes with the binary you obtained in Section 2.6.1. Why such a difference ?
The compiled binary (carlo) is 33,592 bytes, while the multi-stage Dockerfile (Dockerfile.multi) itself is only 293 bytes because it only contains the instructions used to build the container image, not the actual program or dependencies. The compiled binary contains the machine code of the program, which makes it larger, while the Dockerfile is just a small text configuration file describing the build steps.

### 4 In Listing 8, what is the purpose of the COPY --from=build-env instruction (line 8) ? Is it a good or bad idea to do that ? Motivate your answer.

COPY --from=buildtime-stage /app/montecarlopi /app/montecarlopi copies the compiled binary from the build stage into the runtime stage of the container. This means the program is compiled in the first stage and only the final executable is included in the second stage.

This is a good practice in my opinion because it removes the compiler and build tools from the final image. As a result, the container image is smaller, cleaner, and more secure, since it contains only what is necessary to run the application.

### 5 
We were not able to obtain the exact same image ID on both machines. One obstacle was the difference in system architecture: my machine uses ARM, while my partner’s machine uses x86_64. Because container images are built for a specific architecture, the resulting images were different and produced different hashes.

### 6 
Yes, when running the container with the same input parameters, all students should obtain the same output. This is because the container provides the same runtime environment and the program uses the same inputs, which results in identical behaviour.

### 7 
When using docker save and docker load, the entire container image is transferred, including its filesystem layers and metadata. This allows another user to run the same image on their machine. However, it does not fully guarantee identical environments, since the container still depends on the host system’s kernel and architecture.

# 4 Using Nix

### 1. Compare the resulting binary with other students. Is it the same?
Yes, when using Nix and the same system architecture, the resulting binary should be identical across different students’ machines. This happens because Nix builds software in an isolated and deterministic environment, using the same dependencies and inputs. As a result, the compiled binary is the same and produces the same checksum.

### 2. Compare the installation path of the binary with other students. Is it the same?
Yes, the installation path is the same when using Nix. The binary is stored in the Nix store (/nix/store), where the path includes a hash derived from all build inputs (source code, dependencies, compiler, etc.). If all inputs are identical, the hash and therefore the installation path will also be identical across different machines with the same architecture.

### 3. If you build it multiple times, do you get the same resulting output?
Yes, when using Nix, building the program multiple times produces the same resulting output. This is because Nix builds are deterministic and reproducible, meaning that if the inputs (source code, dependencies, and configuration) remain the same, the build process will generate the exact same binary and output each time.

### 4. What happens when you run nix shell nixpkgs#hello? How does it differ from nix profile add nixpkgs#hello?
When you run nix shell nixpkgs#hello, Nix creates a temporary environment where the hello package is available only for the current shell session. Once you exit the shell, the package is no longer available.

In contrast, nix profile add nixpkgs#hello installs the package permanently in the user’s profile, making it available every time you open a new shell until it is manually removed.
### 5 Briefly explain the role of the Nix store (/nix/store) and why it is immutable.
The Nix store (/nix/store) is the directory where Nix stores all built packages and their dependencies.
It is immutable (read-only) to prevent modifications after a package is built. This ensures that packages cannot be accidentally changed, which helps guarantee reproducibility, consistency, and reliability of builds across different systems.
### 6 What does nix flake lock do, and why is it critical for reproducibility?
nix flake lock creates or updates the flake.lock file, which records the exact versions (commits) of all dependencies used by the project.

This is critical for reproducibility because it ensures that every user builds the project with the same dependency versions, even if the upstream repositories change later. As a result, the build environment remains consistent across different machines and over time.

### 7 Purity & Sandboxing: Nix builds are executed in a “sandbox”. What would happen if your program tried to download a file or read your system’s /etc/passwd during the build phase in a Nix derivation? Why is this restriction important?
In a Nix sandboxed build, the program would not be able to download files from the internet or read system files such as /etc/passwd. These operations would fail because the build environment only allows access to explicitly declared inputs.

This restriction is important because it ensures that builds are pure and reproducible. By preventing access to external or system-specific resources, Nix guarantees that the build result depends only on the declared inputs, making the build deterministic and consistent across different machines.

### 8 Suppose an upstream package dependency updates unexpectedly. How does Nix ensure that your project remains reproducible?
Nix ensures reproducibility by pinning dependencies to specific versions or commits, which are recorded in files such as flake.lock. Even if an upstream package updates, Nix will continue using the exact same dependency versions specified in the lock file. This guarantees that the project can be built in the same way across different machines and at different times.

### 9 You need to share a reproducible development environment with Java and GCC with some students. What would a minimal flake.nix file look like? Should you share the flake.lock file too?
```c
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [
        pkgs.gcc
        pkgs.jdk
      ];
    };
  };
}
```
Yes, you should also share the flake.lock file, because it pins the exact versions of all dependencies. This ensures that every student will use the same package versions, making the development environment fully reproducible across different machines.
# 1.3 General questions