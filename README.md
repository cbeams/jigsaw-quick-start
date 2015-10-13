# Java Module System Quick-Start Guide

This repository is based on Project Jigsaw's [Module System Quick-Start Guide](http://openjdk.java.net/projects/jigsaw/quick-start). The sections there have been reworked here into a series of commits and runnable code, each demonstrating a key aspect of Java's new module system.

Along the way, you'll transform a traditional Java main class into a _Java module_ that makes use of all the major features Jigsaw has to offer. Each step can be run using the `step.sh` script, but the steps can also simply be read in order using `git log`. See below for instructions on both approaches.

## How to use this guide

The commits in this repository are meant to be read in order like a tutorial, and the best way to do that is at the command line on your local machine.

First, clone the repo:

    $ git clone https://github.com/cbeams/jigsaw-quick-start.git
    $ cd jigsaw-quick-start

Then set up these two `git` aliases:

    $ git config alias.steps 'log --oneline --reverse step0^..step7'
    $ git config alias.read 'log -p --reverse step0^..step7'

The first alias, `git steps` shows you an overview of each step in the guide:

	$ git steps
	b78eb99 (tag: step0) Introduce com.greetings package and main class
	4826e81 (tag: step1) Transform com.greetings source into a Java module
	cb1cc8f (tag: step2) Assemble com.greetings into executable modular jar
	5c652c1 (tag: step3) Introduce org.astro module dependency
	5a0e223 (tag: step4) Remove requires statement and fail at compile time
	3d0346a (tag: step5) Remove exports statement and fail at compile time
	a39456b (tag: step6) Introduce SPI without provider and fail at runtime
	90ea23e (tag: step7) Introduce service provider and bind successfully

The second alias, `git read` displays the log of each commit, in order, including both comment and patch. This allows you to see exactly what changes in each step and why:

```diff
$ git read
commit b78eb99a458645368e4324ba22867edce62440e4 (tag: step0)
Author: Chris Beams <chris@gradle.com>
Date:   Tue Oct 13 16:09:44 2015 +0200

    Introduce com.greetings package and main class

    This step adds a simple main class, compiles it with javac and runs it
    with java in the usual fashion. No Jigsaw and no modules yet; that will
    come in the next step.

    When this step is run, it should print the following to the console:

        $ ./step.sh
        Greetings from main!

    See http://openjdk.java.net/projects/jigsaw/quick-start#greeting

diff --git src/com.greetings/com/greetings/Main.java
new file mode 100644
index 0000000..4f5991f
--- /dev/null
+++ src/com.greetings/com/greetings/Main.java
@@ -0,0 +1,9 @@
+package com.greetings;
+
+public class Main {
+
+    public static void main(String[] args) {
+        Object name = "main";
+        System.out.format("Greetings from %s!\n", name);
+    }
+}
diff --git step.sh step.sh
index 59bf8a3..b20a0fe 100755
--- step.sh
+++ step.sh
@@ -7,9 +7,12 @@ cat << task

 task
 (rm -rf bin && mkdir bin) || exit
-echo '(nothing to compile yet)'
+mkdir bin/com.greetings
 set -x

+javac -d bin/com.greetings \
+    $(find src/com.greetings -name '*.java') || exit
+
 find bin -type f

@@ -30,5 +33,8 @@ cat << task
     Run

 task
-echo '(nothing to run yet)'
 set -x
+
+java \
+    -classpath bin/com.greetings \
+    com.greetings.Main

commit 4826e81531342ad9a423bd5196ffd69a633f5235 (tag: step1)
Author: Chris Beams <chris@gradle.com>
Date:   Thu Oct 8 16:12:50 2015 +0200

    Transform com.greetings source into a Java module

    This step transforms the existing `com.greetings` source into a Java
    module simply by introducing an empty `module-info.java` file at the
    source directory root.

    With this _module declaration_ file in place and compiled along with the
    rest of the sources, `java` can now be invoked with its new `--module-path`
    option as opposed to the traditional `-classpath` option. Note how the
    modulepath now need only contain the top-level `bin` output directory,
    while the path to the main class (the new `-m` option) needs to be fully
    qualified by both module and package.

    When this step is run, the output should remain the same as the previous
    step. Nothing has changed in the program itself; only how the compiled
    artifacts are structured and invoked has changed:

        $ ./step.sh
        Greetings from main!

    See http://openjdk.java.net/projects/jigsaw/quick-start#greetings

diff --git src/com.greetings/module-info.java
new file mode 100644
index 0000000..4a27728
--- /dev/null
+++ src/com.greetings/module-info.java
@@ -0,0 +1,2 @@
+module com.greetings {
+}
diff --git step.sh step.sh
index b20a0fe..37b0c9f 100755
--- step.sh
+++ step.sh
@@ -36,5 +36,5 @@ task
 set -x

 java \
-    -classpath bin/com.greetings \
-    com.greetings.Main
+    --module-path bin \
+    -m com.greetings/com.greetings.Main
```

## Run the steps

The [step.sh](step.sh) script is present at each step in the guide, and you can run it to see Jigsaw in action.

To do this, you'll first need a [JDK 9 early access build that includes project Jigsaw](https://jdk9.java.net/jigsaw/). Build 81 or better will work.

Once properly installed, `java -version` should tell you something like this:

	$ java -version
	java version "1.9.0-ea"
	Java(TM) SE Runtime Environment (build 1.9.0-ea-jigsaw-nightly-h3391-20150915-b81)
	Java HotSpot(TM) 64-Bit Server VM (build 1.9.0-ea-jigsaw-nightly-h3391-20150915-b81, mixed mode)

At this point you're ready to run through each step using the following commands:

 1. Check out a step
	```
	$ git checkout step0
	```

 2. Read the commit to understand what's changed
    ```
    $ git show
    ```

 3. Run the demo script to see it all in action
    ```
    $ ./step.sh
    ```

then repeat for each of the remaining steps

    $ git checkout step1
    $ git show
    $ ./step.sh
	...

and remember to use `git steps` as a table of contents if you want to jump around.
