---
layout: lesson
root: ../..
---

## Sorting and Removing Duplicates


<div class="objectives">
<h4 id="objectives">Objectives</h4>
<ul>
<li>Write queries that display results in a particular order.</li>
<li>Write queries that eliminate duplicate values from data.</li>
</ul>
</div>


<div>
<p>Data is often redundant, so queries often return redundant information. For example, say we were interested in listing all the publishers that are represented in our catalogue. If we select the <code>Publisher</code> from the <code>Works</code> table, we get this:</p>
</div>


<div class="in">
<pre>%load_ext sqlitemagic</pre>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Publisher from Works;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>Wiley</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>Faber &amp; Faber</TD>
	</TR>
	<TR><TD>Belknap Press</TD>
	</TR>
	<TR><TD>McGraw-Hill</TD>
	</TR>
	<TR><TD>Wiley</TD>
	</TR>
	<TR><TD>Peachpit</TD>
	</TR>
	<TR><TD>South-Western</TD>
	</TR>
	<TR><TD>Wiley</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>Wiley</TD>
	</TR>
	<TR><TD>Apress</TD>
	</TR>
	<TR><TD>Wiley</TD>
	</TR>
	<TR><TD>Sams</TD>
	</TR>
	<TR><TD>Wiley</TD>
	</TR>
	<TR><TD>Wiley</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	</TR>
</table></pre>
</div>


<div>
<p>We can eliminate the redundant output to make the result more readable by adding the <code>DISTINCT</code> keyword to our query:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT DISTINCT Publisher from Works;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>Wiley</TD>
	</TR>
	<TR><TD>Faber &amp; Faber</TD>
	</TR>
	<TR><TD>Belknap Press</TD>
	</TR>
	<TR><TD>McGraw-Hill</TD>
	</TR>
	<TR><TD>Peachpit</TD>
	</TR>
	<TR><TD>South-Western</TD>
	</TR>
	<TR><TD>Apress</TD>
	</TR>
	<TR><TD>Sams</TD>
	</TR>
</table></pre>
</div>


<div>
<p>If we select more than one column—for example, both the place and publisher—then the distinct pairs of values are returned:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT DISTINCT Place, Publisher FROM Works;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>Hoboken</TD>
	<TD>Wiley</TD>
	</TR>
	<TR><TD>London</TD>
	<TD>Faber &amp; Faber</TD>
	</TR>
	<TR><TD>Cambridge</TD>
	<TD>Belknap Press</TD>
	</TR>
	<TR><TD>New York</TD>
	<TD>McGraw-Hill</TD>
	</TR>
	<TR><TD>Indianapolis</TD>
	<TD>Wiley</TD>
	</TR>
	<TR><TD>Berkeley</TD>
	<TD>Peachpit</TD>
	</TR>
	<TR><TD>Mason</TD>
	<TD>South-Western</TD>
	</TR>
	<TR><TD>Berkeley</TD>
	<TD>Apress</TD>
	</TR>
	<TR><TD>Indianapolis</TD>
	<TD>Sams</TD>
	</TR>
	<TR><TD>Cambridge</TD>
	<TD>O&#39;Reilly</TD>
	</TR>
</table></pre>
</div>


<div>
<p>Notice in both cases that duplicates are removed even if they didn't appear to be adjacent in the database. Again, it's important to remember that rows aren't actually ordered: they're just displayed that way.</p>
</div>


<div>
<h4 id="challenges">Challenge</h4>
<ol style="list-style-type: decimal">
<li>Write a query that displays all the distinct years in which items were purchased for the library. Hint, look at the <strong>Aquired</strong> column in the <code>Items</code> table.</li>
</ol>
</div>


<div>
<p>As we mentioned earlier, database records are not stored in any particular order. This means that query results aren't necessarily sorted, and even if they are, we often want to sort them in a different way, e.g., in alphabetical order instead of the order in which they were written into the database. We can do this in SQL by adding an <code>ORDER BY</code> clause to our query:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT DISTINCT Publisher FROM Works ORDER BY Publisher;
</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Apress</TD>
	</TR>
	<TR><TD>Belknap Press</TD>
	</TR>
	<TR><TD>Faber &amp; Faber</TD>
	</TR>
	<TR><TD>McGraw-Hill</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>Peachpit</TD>
	</TR>
	<TR><TD>Sams</TD>
	</TR>
	<TR><TD>South-Western</TD>
	</TR>
	<TR><TD>Wiley</TD>
	</TR>
</table></pre>
</div>


<div>
<p>By default, results are sorted in ascending order (i.e., from least to greatest or for A to Z). We can sort in the opposite order using <code>DESC</code> (for &quot;descending&quot;):</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT DISTINCT Publisher FROM Works ORDER BY Publisher DESC;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Wiley</TD>
	</TR>
	<TR><TD>South-Western</TD>
	</TR>
	<TR><TD>Sams</TD>
	</TR>
	<TR><TD>Peachpit</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>McGraw-Hill</TD>
	</TR>
	<TR><TD>Faber &amp; Faber</TD>
	</TR>
	<TR><TD>Belknap Press</TD>
	</TR>
	<TR><TD>Apress</TD>
	</TR>
</table></pre>
</div>

<div>
<p>(And if we want to make it clear that we're sorting in ascending order, we can use <code>ASC</code> instead of <code>DESC</code>.)</p>
<p>We can also sort on several fields at once. For example, this query sorts the <code>Works</code> table first by <code>Date</code> (in descending order), then by <code>Publisher</code> in ascending order:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Title, Date, Publisher FROM Works ORDER BY Date DESC, Publisher ASC;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Capital in the 21st century</TD>
	<TD>2014</TD>
	<TD>Belknap Press</TD>
	</TR>
	<TR><TD>Geek sublime</TD>
	<TD>2014</TD>
	<TD>Faber &amp; Faber</TD>
	</TR>
	<TR><TD>PHP &amp; MySQL</TD>
	<TD>2013</TD>
	<TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>Microsoft SQL server 2012</TD>
	<TD>2013</TD>
	<TD>Sams</TD>
	</TR>
	<TR><TD>SQL for dummies</TD>
	<TD>2013</TD>
	<TD>Wiley</TD>
	</TR>
	<TR><TD>Access 2013 all-in-one</TD>
	<TD>2013</TD>
	<TD>Wiley</TD>
	</TR>
	<TR><TD>Discovering SQL</TD>
	<TD>2011</TD>
	<TD>Wiley</TD>
	</TR>
	<TR><TD>SQL all-in-one</TD>
	<TD>2011</TD>
	<TD>Wiley</TD>
	</TR>
	<TR><TD>Using SQLite</TD>
	<TD>2010</TD>
	<TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>SQL for dummies</TD>
	<TD>2010</TD>
	<TD>Wiley</TD>
	</TR>
	<TR><TD>SQL</TD>
	<TD>2009</TD>
	<TD>McGraw-Hill</TD>
	</TR>
	<TR><TD>SQL in a nutshell</TD>
	<TD>2009</TD>
	<TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>Learning SQL</TD>
	<TD>2009</TD>
	<TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>Beginning SQL queries</TD>
	<TD>2008</TD>
	<TD>Apress</TD>
	</TR>
	<TR><TD>A guide to SQL</TD>
	<TD>2008</TD>
	<TD>South-Western</TD>
	</TR>
	<TR><TD>SQL bible</TD>
	<TD>2008</TD>
	<TD>Wiley</TD>
	</TR>
	<TR><TD>MySQL in a nutshell</TD>
	<TD>2005</TD>
	<TD>O&#39;Reilly</TD>
	</TR>
	<TR><TD>SQL</TD>
	<TD>2005</TD>
	<TD>Peachpit</TD>
	</TR>
	<TR><TD>Beginning SQL</TD>
	<TD>2005</TD>
	<TD>Wiley</TD>
	</TR>
	<TR><TD>SQL in a nutshell</TD>
	<TD>2004</TD>
	<TD>O&#39;Reilly</TD>
	</TR>
</table></pre>
</div>


<div>
<h4 id="challenges">Challenge</h4>
<ol style="list-style-type: decimal">
<li><p>Write a query that displays the Personal and Family name of the authors in the <code>Authors</code> table, ordered by Family name.</p></li>
</ol>
</div>


<div class="keypoints">
<h4 id="key-points">Key Points</h4>
<ul>
<li>The records in a database table are not intrinsically ordered: if we want to display them in some order, we must specify that explicitly.</li>
<li>The values in a database are not guaranteed to be unique: if we want to eliminate duplicates, we must specify that explicitly as well.</li>
</ul>
</div>
