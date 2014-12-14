---
layout: lesson
root: ../..
---

## Calculating New Values


<div class="objectives">
<h4 id="objectives">Objectives</h4>
<ul>
<li>Write queries that calculate new values for each selected record.</li>
</ul>
</div>


<div>
<p>The library is embarking on a digitization project. In order to estimate how long it would take to scan books, you want to look up what the total number of pages for all library books are. Prior experience has shown that due to poor quality binding, up to 2% of the pages will fail to be scanned for books published by Wiley and will have to be scanned anew. The total number of pages has therefore to be adjusted accordingly for this publisher:</p>
</div>


<div class="in">
<pre>%load_ext sqlitemagic</pre>
</div>

<div class="in">
<pre>%%sqlite swclib.db
SELECT 1.02*Pages FROM Works WHERE Publisher = "Wiley"</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD bgcolor="red">&nbsp;</TD>
	</TR>
	<TR><TD>408.0</TD>
	</TR>
	<TR><TD>874.14</TD>
	</TR>
	<TR><TD>448.8</TD>
	</TR>
	<TR><TD>511.02</TD>
	</TR>
	<TR><TD>722.16</TD>
	</TR>
	<TR><TD>775.2</TD>
	</TR>
</table></pre>
</div>

<div>Remember those empty cells we had in the database? Seems like one of them is showing up again here. We'll have to deal with it later so that it doesn't mess up our computations.</div>

<div>
<p>When we run the query, the expression <code>1.02 * Pages</code> is evaluated for each row. Expressions can use any of the fields, all of usual arithmetic operators, and a variety of common functions. (Exactly which ones depends on which database manager is being used.) For example, knowing that scanning two pages takes exactly 13 seconds, we can compute how many hours would be necessary to scan each Wiley book. Since this is an estimate, more than one decimal place doesn't make much sense and so we use a rounding function:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Title, round(13/2*(1.02*Pages)/3600,1) FROM Works WHERE Publisher = "Wiley"</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>SQL for dummies</TD>
	<TD bgcolor="red"></TD>
	</TR>
	<TR><TD>Discovering SQL</TD>
	<TD>0.7</TD>
	</TR>
	<TR><TD>SQL bible</TD>
	<TD>1.5</TD>
	</TR>
	<TR><TD>SQL for dummies</TD>
	<TD>0.7</TD>
	</TR>
	<TR><TD>Beginning SQL</TD>
	<TD>0.9</TD>
	</TR>
	<TR><TD>SQL all-in-one</TD>
	<TD>1.2</TD>
	</TR>
	<TR><TD>Access 2013 all-in-one</TD>
	<TD>1.3</TD>
	</TR>
</table></pre>
</div>


<div>
<p>We can also combine values from different fields, for example by using the string concatenation operator <code>||</code>:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Personal || " " || Family FROM Authors LIMIT 5;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Kevin E. Kline</TD>
	</TR>
	<TR><TD>Daniel Kline</TD>
	</TR>
	<TR><TD>Brand Hunt</TD>
	</TR>
	<TR><TD>Allen G. Taylor</TD>
	</TR>
	<TR><TD>Brett McLaughlin</TD>
	</TR>
</table></pre>
</div>

<div>
<h4 id="challenges">Challenges</h4>
<ol style="list-style-type: decimal">
<li><p>After further testing, we realize that the average time to scan every two pages of books published by O'Reilly is 25 seconds, because the operator seems to like reading a few paragraphs now and then. Fortunately, they do not suffer from the binding issue, though. Write a query that returns the number of hours necessary to scan each O'Reilly book, given those circumstances.</p></li>
<li><p>The <code>UNION</code> operator combines the results of two queries:</p></li>
</ol>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT * FROM Works WHERE Publisher='Peachpit' UNION SELECT * FROM Works WHERE Publisher='Faber &amp; Faber';</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>5</TD>
	<TD>Geek sublime</TD>
	<TD>9780571310302</TD>
	<TD>2014</TD>
	<TD>London</TD>
	<TD>Faber &amp; Faber</TD>
	<TD></TD>
	<TD>258</TD>
	</TR>
	<TR><TD>9</TD>
	<TD>SQL</TD>
	<TD>0321334175</TD>
	<TD>2005</TD>
	<TD>Berkeley</TD>
	<TD>Peachpit</TD>
	<TD>2nd ed.</TD>
	<TD>460</TD>
	</TR>
</table></pre>
</div>


<div>
<p>Use <code>UNION</code> to create a consolidated list of Wiley and O'Reilly titles, along with the estimated time it would take to digitize them according to the two formulas discussed above. The output should be something like:</p>
<table>
	<TR><TD>Access 2013 all-in-one</TD>
	<TD>1.3</TD>
	</TR>
	<TR><TD>Beginning SQL</TD>
	<TD>0.9</TD>
	</TR>
	<TR><TD>Discovering SQL</TD>
	<TD>0.7</TD>
	</TR>
	<TR><TD>Learning SQL</TD>
	<TD>1.0</TD>
	</TR>
	<TR><TD>MySQL in a nutshell</TD>
	<TD>1.0</TD>
	</TR>
	<TR><TD>PHP &amp; MySQL</TD>
	<TD>1.0</TD>
	</TR>
	<TR><TD>SQL all-in-one</TD>
	<TD>1.2</TD>
	</TR>
	<TR><TD>SQL bible</TD>
	<TD>1.5</TD>
	</TR>
	<TR><TD>SQL for dummies</TD>
	<TD></TD>
	</TR>
	<TR><TD>SQL for dummies</TD>
	<TD>0.7</TD>
	</TR>
	<TR><TD>SQL in a nutshell</TD>
	<TD>1.0</TD>
	</TR>
	<TR><TD>SQL in a nutshell</TD>
	<TD>2.0</TD>
	</TR>
	<TR><TD>Using SQLite</TD>
	<TD>1.0</TD>
	</TR>
</table>


</div>


<div>
<ol start="3" style="list-style-type: decimal">
<li><p>The <code>Works</code> table contains <a href="https://en.wikipedia.org/wiki/ISBN">ISBN</a> numbers that are either in 10-digit or 13-digit format. The 13-digit numbers all start with the '978' prefix. The two digits following the prefix (or the first two digits in ISBN-10) form the &quot;registration group element&quot; (to simplify: language or country), the next four digits are the &quot;registrant element&quot; (publisher) and the next three are the &quot;publication element&quot; (title). The last digit in both formats is a checksum character.</p>
<p><a href="https://commons.wikimedia.org/wiki/File:ISBN_Details.svg#mediaviewer/File:ISBN_Details.svg"><img src="https://upload.wikimedia.org/wikipedia/commons/8/84/ISBN_Details.svg" alt="ISBN Details.svg" height="480" width="312"></a><br>"<a href="https://commons.wikimedia.org/wiki/File:ISBN_Details.svg#mediaviewer/File:ISBN_Details.svg">ISBN Details</a>" by <a href="//en.wikipedia.org/wiki/User:Sakurambo" class="extiw" title="wikipedia:User:Sakurambo">Sakurambo</a> at <a href="//en.wikipedia.org/wiki/" class="extiw" title="wikipedia:">English Wikipedia</a> - Own work, based on <a href="//en.wikipedia.org/wiki/Image:ISBN_Details.jpg" class="extiw" title="en:Image:ISBN Details.jpg">en::Image:ISBN Details.jpg</a>. Licensed under <a href="http://creativecommons.org/licenses/by-sa/3.0/" title="Creative Commons Attribution-Share Alike 3.0">CC BY-SA 3.0</a> via <a href="//commons.wikimedia.org/wiki/">Wikimedia Commons</a>.</p>
<p>The substring function <code>substr(X, I, L)</code> returns the substring of X starting at index I and of length L (L is optional). The <code>length()</code> function can be used in a <code>WHERE</code> clause to test against the length of a field. Use these functions and the <code>UNION</code> statement to output a list of publishers and the 4-digit publisher codes (registrant elements) appearing in the <code>Works</code> table. The result should help dissolve whatever hope you still held on the usefulness of ISBNs for collection analysis...</p> 
</li></ol>
</div>


<div class="keypoints">
<h4 id="key-points">Key Points</h4>
<ul>
<li>SQL can perform calculations using the values in a record as part of a query.</li>
</ul>
</div>
