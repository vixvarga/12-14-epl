---
layout: lesson
root: ../..
---

## Selecting Data


A new library branch (The Meadows) opened in the city. Library planners made some educated guesses about which neighbourhoods would use this new location. However, now that the branch is open, the library administrators want to test their guesses and see if the customers who are using the library match the postal codes assigned to this catchement to ensure that staffing levels are appropriate. They want to use the circulation data from this branch to check trends in usage.

We basically have three options:
text files,
a spreadsheet,
or a database.
Text files are easiest to create,
and work well with version control,
but then we would then have to build search and analysis tools ourselves.
Spreadsheets are good for doing simple analysis,
they don't handle large or complex data sets very well.
We would therefore like to put this data in a database,
and these lessons will show how to do that.


<div class="objectives" markdown="1">
#### Objectives

*   Explain the difference between a table, a record, and a field.
*   Explain the difference between a database and a database manager.
*   Write a query to select all values for specific fields from a single table.
</div>

### A Few Definitions


A [relational database](../../gloss.html#relational-database)
is a way to store and manipulate information
that is arranged as [tables](../../gloss.html#table).
Each table has columns (also known as [fields](../../gloss.html#field)) which describe the data,
and rows (also known as [records](../../gloss.html#record)) which contain the data.
  
When we are using a spreadsheet,
we put formulas into cells to calculate new values based on old ones.
When we are using a database,
we send commands
(usually called [queries](../../gloss.html#query))
to a [database manager](../../gloss.html#database-manager):
a program that manipulates the database for us.
The database manager does whatever lookups and calculations the query specifies,
returning the results in a tabular form
that we can then use as a starting point for further queries.
  
> Every database manager&mdash;Oracle,
> IBM DB2, PostgreSQL, MySQL, Microsoft Access, and SQLite&mdash;stores
> data in a different way,
> so a database created with one cannot be used directly by another.
> However,
> every database manager can import and export data in a variety of formats,
> so it *is* possible to move information from one to another.

Queries are written in a language called [SQL](../../gloss.html#sql),
which stands for "Structured Query Language".
SQL provides hundreds of different ways to analyze and recombine data;
we will only look at a handful,
but that handful accounts for most of what scientists do.

The tables below show the database we will use in our examples:


<table>
<tr>
<td valign="top">
<strong>Branches</strong>: library locations within the city

<table>
  <tr> <th>Identity</th> <th>Branch name</th> <th>Address</th> </tr>
  <tr> <td>MEA</td> <td>Meadows</td> <td>2704 17 Street</td> </tr>
  <tr> <td>MLW</td> <td>Millwoods</td> <td>601 Mill Woods Town Centre, 2331 66 Street</td> </tr>
  <tr> <td>CPL</td> <td>Capilano</td> <td>201 Capilano Mall, 5004 98 Avenue</td> </tr>
  <tr> <td>IDY</td> <td>Idylwylde</td> <td>8310 88 Avenue</td> </tr>
  <tr> <td>LON</td> <td>Londonderry</td> <td>110 Londonderry Mall, 137 Avenue 66 Street</td> </tr>
</table>
<br/>
<strong>Catchements</strong>: postal codes that correspond to library catchement areas.

<table>
  <tr> <th>Identity</th> <th>Postal code</th> </tr>
<tr><td>LON</td> <td>T5A</td></tr>
<tr><td>LON</td> <td>T5W</td></tr>
<tr><td>LON</td> <td>T5B</td></tr>
<tr><td>LON</td> <td>T5C</td></tr>
<tr><td>IDY</td> <td>T6C</td></tr>
<tr><td>IDY</td> <td>T6E</td></tr>
<tr><td>CPL</td> <td>T6B</td></tr>
<tr><td>CPL</td> <td>T6P</td></tr>
<tr><td>MLW</td> <td>T6N</td></tr>
<tr><td>MLW</td> <td>T6K</td></tr>
<tr><td>MEA</td> <td>T6L</td></tr>
<tr><td>MEA</td> <td>t6x</td></tr>
<tr><td>mea</td> <td>t6t</td></tr>

</table>
<br/>
<strong>Customers</strong>: Identities of customers.

<table>
  <tr> <th>Card number</th> <th>Last name</th><th>First name</th> <th>Address</th><th>Postal code</th>  </tr>
<tr><td>212210152</td><td>Simpson</td><td>Homer</td><td>10439 16 Avenue</td><td>T6X 5T1</td></tr>
<tr><td>3210384</td><td>Stinson</td><td>Barney</td><td>4062 33A ST</td><td>T6T 1R4</td></tr>
<tr><td>212210235</td><td>Ludgate</td><td>April</td><td>5810 19a Ave Nw</td><td>T6L 1T1</td></tr>
<tr><td>212210918</td><td>Kelly</td><td>Charlie</td><td>3208 134 AV</td><td>T5A 5E4</td></tr>
<tr><td>212210824</td><td>Vonnegut</td><td>Kurt</td><td>12282 55 St</td><td>T5W 3R4</td></tr>
<tr><td>212210661</td><td>Miller</td><td>Avril</td><td bgcolor="red">		</td><td>T6E 5T6</td></tr>
<tr><td>212210938</td><td>Kent</td><td>Clark</td><td>12007 46 St Nw</td><td>T5W 2W1</td></tr>
<tr><td>212210444</td><td>Atwood</td><td>Maggie</td><td>5724 19 A avenue</td><td>T6L 1L8</td></tr>

</table>
</td>
<td valign="top">
<strong>Circulation</strong>: the borrowing patterns of users.

<table>
  <tr> <th>Card number</th> <th>Date</th>  <th>Title</th> </tr>
<tr><td>212210235</td><td>11/27/2014</td><td>A Brief History of Time</td></tr>
<tr><td>212210152</td><td>11/28/2014</td><td>The Corrections</td></tr>
<tr><td>3210384</td><td>11/28/2014</td><td>The Eyre Affair</td></tr>
<tr><td>212210661</td><td>11/27/2014</td><td>The New York Trilogy</td></tr>
<tr><td>212210152</td><td>11/29/2014</td><td>Men at Arms</td></tr>
<tr><td>3210384</td><td>11/27/2014</td><td>A Prayer for Owen Meany</td></tr>
<tr><td>212210824</td><td>11/29/2014</td><td>A Wrinkle in Time</td></tr>
<tr><td>212210918</td><td>11/29/2014</td><td>House of Leaves</td></tr>
<tr><td>212210938</td><td>11/30/2014</td><td>Italian Folktales</td></tr>
<tr><td>3210384</td><td>11/30/2014</td><td>Ficcones</td></tr>
<tr><td>212210938</td><td>11/27/2014</td><td>Everything is Illuminated</td></tr>
<tr><td>212210661</td><td>11/30/2014</td><td>Galatea 2.2</td></tr>
<tr><td>3210384</td><td>11/30/2014</td><td>Gravity's Rainbow</td></tr>
<tr><td>212210661</td><td>11/28/2014</td><td>Game of Thrones</td></tr>
<tr><td>212210661</td><td>12/1/2014</td><td>First Among Sequels</td></tr>
<tr><td>212210444</td><td>11/27/2014</td><td>Year of the Flood</td></tr>
<tr><td>212210235</td><td>12/1/2014</td><td>Foundation</td></tr>
<tr><td>212210235</td><td>11/30/2014</td><td>Ancillary Justice</td></tr>
<tr><td>212210938</td><td>12/1/2014</td><td>Where the Red Ferns Grow</td></tr>
<tr><td>212210938</td><td>11/27/2014</td><td>Pride and Prejudice</td></tr>
<tr><td>212210444</td><td>12/1/2014</td><td>Slaughterhouse Five</td></tr>
<tr><td>212210235</td><td>11/28/2014</td><td>Men at Arms</td></tr>
<tr><td>3210384</td><td>11/30/2014</td><td>Gravity's Rainbow</td></tr>
<tr><td>3210384</td><td>11/27/2014</td><td>Men at Arms</td></tr>
<tr><td>212210444</td><td>11/30/2014</td><td>Men at Arms</td></tr>
<tr><td>212210444</td><td>11/30/2014</td><td>Gravity's Rainbow</td></tr>
<tr><td>3210384</td><td>11/30/2014</td><td>Men at Arms</td></tr>
<tr><td>212210235</td><td>12/1/2014</td><td>Italian Folktales</td></tr>
<tr><td>212210938</td><td>11/28/2014</td><td>A Prayer for Owen Meany</td></tr>
<tr><td>3210384</td><td>11/27/2014</td><td>Year of the Flood</td></tr>
<tr><td>212210938</td><td>11/30/2014</td><td>A Prayer for Owen Meany</td></tr>
<tr><td>3210384</td><td>11/28/2014</td><td>Italian Folktales</td></tr>
<tr><td>212210938</td><td>11/30/2014</td><td>Italian Folktales</td></tr>
<tr><td>212210444</td><td>12/1/2014</td><td>Italian Folktales</td></tr>

</table>
</td>
</tr>
</table>


Notice that two entries in the `customers` table,
are shown in red
because they don't contain any actual data:
we'll return to these missing values [later](#s:null).
For now,
let's write an SQL query that displays customers' names.
We do this using the SQL command `select`,
giving it the names of the columns we want and the table we want them from.
Our query and its output look like this:


<pre class="in"><code>%load_ext sqlitemagic</code></pre>


<pre class="in"><code>%%sqlite survey.db
select last, first from Customers;</code></pre>

<div class="out"><table>
<tr><td>Simpson</td><td>Homer</td></tr>
<tr><td>Stinson</td><td>Barney</td></tr>
<tr><td>Ludgate</td><td>April</td></tr>
<tr><td>Kelly</td><td>Charlie</td></tr>
<tr><td>Vonnegut</td><td>Kurt</td></tr>
<tr><td>Miller</td><td>Avril</td></tr>
<tr><td>Kent</td><td>Clark</td></tr>
<tr><td>Atwood</td><td>Maggie</td></tr>

</table></div>


The semi-colon at the end of the query
tells the database manager that the query is complete and ready to run.
We have written our commands and column names in lower case,
and the table name in Title Case,
but we don't have to:
as the example below shows,
SQL is [case insensitive](../../gloss.html#case-insensitive).


<pre class="in"><code>%%sqlite survey.db
SeLeCt LaST, FiRsT FrOm CusToMerS;</code></pre>

<div class="out"><table>
<tr><td>Simpson</td><td>Homer</td></tr>
<tr><td>Stinson</td><td>Barney</td></tr>
<tr><td>Ludgate</td><td>April</td></tr>
<tr><td>Kelly</td><td>Charlie</td></tr>
<tr><td>Vonnegut</td><td>Kurt</td></tr>
<tr><td>Miller</td><td>Avril</td></tr>
<tr><td>Kent</td><td>Clark</td></tr>
<tr><td>Atwood</td><td>Maggie</td></tr>
</table></div>


Whatever casing convention you choose,
please be consistent:
complex queries are hard enough to read without the extra cognitive load of random capitalization.


Going back to our query,
it's important to understand that
the rows and columns in a database table aren't actually stored in any particular order.
They will always be *displayed* in some order,
but we can control that in various ways.
For example,
we could swap the columns in the output by writing our query as:


<pre class="in"><code>
select first, last from customer;</code></pre>

<div class="out"><table>
<tr><td>Homer</td><td>Simpson</td></tr>
<tr><td>Barney</td><td>Stinson</td></tr>
<tr><td>April</td><td>Ludgate</td></tr>
<tr><td>Charlie</td><td>Kelly</td></tr>
<tr><td>Kurt</td><td>Vonnegut</td></tr>
<tr><td>Avril</td><td>Miller</td></tr>
<tr><td>Clark</td><td>Kent</td></tr>
<tr><td>Maggie</td><td>Atwood</td></tr>

</table></div>


or even repeat columns:


<pre class="in"><code>%%sqlite survey.db
select first, first, first from Customer;</code></pre>

<div class="out"><table>
<tr><td>Homer</td><td>Homer</td><td>Homer</td></tr>
<tr><td>Barney</td><td>Barney</td><td>Barney</td></tr>
<tr><td>April</td><td>April</td><td>April</td></tr>
<tr><td>Charlie</td><td>Charlie</td><td>Charlie</td></tr>
<tr><td>Kurt</td><td>Kurt</td><td>Kurt</td></tr>
<tr><td>Avril</td><td>Avril</td><td>Avril</td></tr>
<tr><td>Clark</td><td>Clark</td><td>Clark</td></tr>
<tr><td>Maggie</td><td>Maggie</td><td>Maggie</td></tr>

</table></div>


As a shortcut,
we can select all of the columns in a table using `*`:


<pre class="in"><code>
select * from Customer;</code></pre>

<div class="out"><table>
<tr><td>212210152</td><td>Simpson</td><td>Homer</td><td>10439 16 Avenue</td><td>T6X 5T1</td></tr>
<tr><td>3210384</td><td>Stinson</td><td>Barney</td><td>4062 33A ST</td><td>T6T 1R4</td></tr>
<tr><td>212210235</td><td>Ludgate</td><td>April</td><td>5810 19a Ave Nw</td><td>T6L 1T1</td></tr>
<tr><td>212210918</td><td>Kelly</td><td>Charlie</td><td>3208 134 AV</td><td>T5A 5E4</td></tr>
<tr><td>212210824</td><td>Vonnegut</td><td>Kurt</td><td>12282 55 St</td><td>T5W 3R4</td></tr>
<tr><td>212210661</td><td>Miller</td><td>Avril</td><td></td><td>T6E 5T6</td></tr>
<tr><td>212210938</td><td>Kent</td><td>Clark</td><td>12007 46 St Nw</td><td>T5W 2W1</td></tr>
<tr><td>212210444</td><td>Atwood</td><td>Maggie</td><td>5724 19 A avenue</td><td>T6L 1L8</td></tr>

</table></div>


#### Challenges

1.  Write a query that selects only names from the `branches` table.

2.  Many people format queries as:

    ~~~
    SELECT first, last FROM customers;
    ~~~

    or as:

    ~~~
    select First, Last from CUSTOMERS;
    ~~~

    What style do you find easiest to read, and why?


<div class="keypoints" markdown="1">
#### Key Points

*   A relational database stores information in tables,
    each of which has a fixed set of columns and a variable number of records.
*   A database manager is a program that manipulates information stored in a database.
*   We write queries in a specialized language called SQL to extract information from databases.
*   SQL is case-insensitive.
</div>
