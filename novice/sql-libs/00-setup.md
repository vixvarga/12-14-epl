---
layout: lesson
root: ../..
---

# SQLite Setup 


This lesson will demonstrate how to install the example database to be used in the next chapters. In a later chapter, you will learn how to create and fill a database, but first we would like to demonstrate how an SQLite database works and therefore we provide the database up-front.


#### Objectives

*   Establish the example database to be used in the next chapters.
*   Check that the database is available and which tables are to be found.


## Setup - SQLite3


1) Download <a href="http://files.software-carpentry.org/sqlite3.exe">SQLite3</a> into a directory of your choice

2) Download the <a href="http://vixvarga.github.io/12-14-epl/novice/sql-libs/swclib.db">SWC-libs.db database file</a> into the same directory as above.


### Loading the database

From the command line, navigate to the folder you have saved SQLite3 and the database file to. To open the database, type:

<pre class="in"><code>sqlite3 swclib.db</code></pre>

The command "sqlite3 swclib.db" opens the database itself and drops you into the database command line prompt. In SQLite a database is a flat file, which needs to be explicitly opened. SQLite is then started which is indicated by the change of the command line prompt to "sqlite", as shown in the following output:


<pre class="in"><code>/novice/sql$ sqlite3 swclib.db 
SQLite version 3.7.15.2 2013-01-09 11:53:05
Enter &#34;.help&#34; for instructions
Enter SQL statements terminated with a &#34;;&#34;
sqlite&gt;  </code></pre>


Let us check the list the names and files of attached databases with the command ".databases", as shown in the following output:


<pre class="in"><code>sqlite&gt; .databases
seq  name             file                                                      
---  ---------------  ----------------------------------------------------------
0    main             ~/novice/sql/swclib.db </code></pre>

You can check that the necessary tables "Authors", "Items", "Works" and "Works_Authors" exist by typing:


<pre class="in"><code>.tables</code></pre>


and the output of ".tables" would look like this:


<pre class="in"><code>sqlite&gt; .tables
Authors   Items     Works   Works_Authors</code></pre>

It is also a good idea to run the following two commands to improve the readability of the output we generate:


<pre class="in"><code>sqlite&gt;.mode columns</code></pre>
<pre class="in"><code>sqlite&gt;.headers on</code></pre>


Now, you are done with the setup and you can proceed to the next lesson. You can conduct the following exercises in the current command line SQLite session. 

### How to exit the SQLite3 DB command line interface (CLI)


 To exit SQLite3, type:


<pre class="in"><code>sqlite&gt; .quit</code></pre>

