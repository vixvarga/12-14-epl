---
layout: lesson
root: ../..
---

## Aggregation


<div class="objectives">
<h4 id="objectives">Objectives</h4>
<ul>
<li>Define &quot;aggregation&quot; and give examples of its use.</li>
<li>Write queries that compute aggregated values.</li>
<li>Trace the execution of a query that performs aggregation.</li>
<li>Explain how missing data is handled during aggregation.</li>
</ul>
</div>


<div>
<p>To get an estimate of the amount of time it will take to digitize our collection, we now want to know how many books by a given publisher are in our collection, as well as calculate the total number of pages contained in the collection. We know how to select all of the page numbers from the <code>Works</code> table:</p>
</div>


<div class="in">
<pre>%load_ext sqlitemagic</pre>
</div>

<div class="in">
<pre>%%sqlite swclib.db
SELECT Pages FROM Works;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>578</TD>
	</TR>
	<TR><TD bgcolor="red">&nbsp;</TD>
	</TR>
	<TR><TD>532</TD>
	</TR>
	<TR><TD>503</TD>
	</TR>
	<TR><TD>258</TD>
	</TR>
	<TR><TD>685</TD>
	</TR>
	<TR><TD>534</TD>
	</TR>
	<TR><TD>400</TD>
	</TR>
	<TR><TD>460</TD>
	</TR>
	<TR><TD>309</TD>
	</TR>
	<TR><TD>857</TD>
	</TR>
	<TR><TD>320</TD>
	</TR>
	<TR><TD>440</TD>
	</TR>
	<TR><TD>218</TD>
	</TR>
	<TR><TD>501</TD>
	</TR>
	<TR><TD bgcolor="red">&nbsp;</TD>
	</TR>
	<TR><TD>708</TD>
	</TR>
	<TR><TD>760</TD>
	</TR>
	<TR><TD>691</TD>
	</TR>
	<TR><TD>321</TD>
	</TR>
</table></pre>
</div>


<div>
<p>but to combine them, wee must use an <a href="../../gloss.html#aggregation-function">aggregation function</a> such as <code>min</code> or <code>max</code>. Each of these functions takes a set of records as input, and produces a single record as output. For example, the following statements display the smallest and the largest books in our collection:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Title, min(Pages) FROM Works;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Beginning SQL queries</TD>
	<TD>218</TD>
	</TR>
</table></pre>
</div>


<!--<div>
<p><img src="img/sql-aggregation.svg" alt="SQL Aggregation" /></p>
</div>-->


<div class="in">
<pre>%%sqlite swclib.db
SELECT Title, max(Pages) FROM Works;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>SQL bible</TD>
	<TD>857</TD>
	</TR>
</table></pre>
</div>


<div>
<p><code>min</code> and <code>max</code> are just two of the aggregation functions built into SQL. Three others are <code>avg</code>, <code>count</code>, and <code>sum</code>:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT avg(Pages) FROM Works;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>504.166666666667</TD>
	</TR>
</table></pre>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT count(Title) FROM Works Where Publisher='Wiley';
</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>7</TD>
	</TR>
</table></pre>
</div>


<div class="in">
<pre>%%sqlite survey.db
SELECT sum(Pages) FROM Works Where Publisher='Wiley';</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>3666</TD>
	</TR>
</table></pre>
</div>


<div>
<p>We used <code>count(Title)</code> here, but we could just as easily have counted <code>ISBN</code> or any other field in the table, or even used <code>count(*)</code>, since the function doesn't care about the values themselves, just how many values there are.</p>
<p>SQL lets us do several aggregations at once. We can, for example, find the range of book sizes published by O'Reilly:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT min(Pages), max(Pages) FROM Works Where Publisher='O''Reilly';</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>320</TD>
	<TD>691</TD>
	</TR>
</table></pre>
</div>


<div>
<p>We can also combine aggregated results with raw results, although the output might surprise you:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Title, count(*) FROM Works Where Publisher='O''Reilly';</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>MySQL in a nutshell</TD>
	<TD>6</TD>
	</TR>
</table></pre>
</div>


<div>
<p>Why does this title appear rather than any other published by O'Reilly? The answer is that when it has to aggregate a field, but isn't told how to, the database manager chooses an actual value from the input set. It might use the first one processed, the last one, or something else entirely.</p>
<p>Another important fact is that when there are no values to aggregate, aggregation's result is &quot;don't know&quot; rather than zero or some other arbitrary value:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT min(Pages), max(Pages) FROM Works Where Publisher='Hachette';</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD bgcolor="red">&nbsp;</TD>
	<TD bgcolor="red">&nbsp;</TD>
	</TR>
</table></pre>
</div>


<div>
<p>One final important feature of aggregation functions is that they are inconsistent with the rest of SQL in a very useful way. If we add two values, and one of them is null, the result is null. By extension, if we use <code>sum</code> to add all the values in a set, and any of those values are null, the result should also be null. It's much more useful, though, for aggregation functions to ignore null values and only combine those that are non-null. This behavior lets us write our queries as:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Title, min(Pages) FROM Works;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Beginning SQL queries</TD>
	<TD>218</TD>
	</TR>
</table></pre>
</div>


<div>
<p>instead of always having to filter explicitly:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Title, min(Pages) FROM Works WHERE Pages IS NOT NULL;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Beginning SQL queries</TD>
	<TD>218</TD>
	</TR>
</table></pre>
</div>

<div>
<p>Aggregating all records at once doesn't always make sense. For example, if we want to get a breakdown of how many books are in the collection for each publisher, we cannot write:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Publisher, count(Title) FROM Works;
</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>O&#39;Reilly</TD>
	<TD>20</TD>
	</TR>
</table></pre>
</div>


<div>
<p>because the database manager selects a single arbitrary publisher name rather than aggregating results separately for each publisher. Since in our small example there are only ten different publishers, we could write ten statements like:<code>SELECT Publisher, count(Title) FROM Works WHERE Publisher='Faber & Faber';</code> but this would be tedious, and it wouldn't be practical against a real-life database containing many thousands different publishers.</p>
<p>What we need to do is tell the database manager to aggregate the number of titles for each publisher separately using a <code>GROUP BY</code> clause:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Publisher, count(Title) FROM Works GROUP BY Publisher</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Apress</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Belknap Press</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Faber &amp; Faber</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>McGraw-Hill</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	<TD>6</TD>
	</TR>
	<TR><TD>Peachpit</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Sams</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>South-Western</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Wiley</TD>
	<TD>7</TD>
	</TR>
</table></pre>
</div>


<div>
<p><code>GROUP BY</code> does exactly what its name implies: groups all the records with the same value for the specified field together so that aggregation can process each batch separately. Since all the records in each batch have the same value for <code>Publisher</code>, it no longer matters that the database manager is picking an arbitrary one to display alongside the count of <code>Title</code> values.</p>
</div>

<div>
<p>Just as we can sort by multiple criteria at once, we can also group by multiple criteria. To get a yearly breakdown of the number of titles published by each publisher, we just add another field to the <code>GROUP BY</code> clause:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Publisher, Date, count(Title) FROM Works GROUP BY Publisher, Date;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Apress</TD>
	<TD>2008</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Belknap Press</TD>
	<TD>2014</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Faber &amp; Faber</TD>
	<TD>2014</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>McGraw-Hill</TD>
	<TD>2009</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	<TD>2004</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	<TD>2005</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	<TD>2009</TD>
	<TD>2</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	<TD>2010</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	<TD>2013</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Peachpit</TD>
	<TD>2005</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Sams</TD>
	<TD>2013</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>South-Western</TD>
	<TD>2008</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Wiley</TD>
	<TD>2005</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Wiley</TD>
	<TD>2008</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Wiley</TD>
	<TD>2010</TD>
	<TD>1</TD>
	</TR>
	<TR><TD>Wiley</TD>
	<TD>2011</TD>
	<TD>2</TD>
	</TR>
	<TR><TD>Wiley</TD>
	<TD>2013</TD>
	<TD>2</TD>
	</TR>
</table></pre>
</div>

<div>
<p>Note that we have added <code>Date</code> to the list of fields displayed, since the results wouldn't make much sense otherwise. Let's wrap up our collection analysis query:</p>
</div>

<div class="in">
<pre>%%sqlite swclib.db
SELECT	 Publisher, Date, count(Title), sum(Pages) FROM Works 
WHERE 	 Pages IS NOT NULL 
GROUP BY Publisher, Date 
ORDER BY Publisher ASC, Date DESC;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Apress</TD>
	<TD>2008</TD>
	<TD>1</TD>
	<TD>218</TD>
	</TR>
	<TR><TD>Belknap Press</TD>
	<TD>2014</TD>
	<TD>1</TD>
	<TD>685</TD>
	</TR>
	<TR><TD>Faber &amp; Faber</TD>
	<TD>2014</TD>
	<TD>1</TD>
	<TD>258</TD>
	</TR>
	<TR><TD>McGraw-Hill</TD>
	<TD>2009</TD>
	<TD>1</TD>
	<TD>534</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	<TD>2013</TD>
	<TD>1</TD>
	<TD>532</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	<TD>2010</TD>
	<TD>1</TD>
	<TD>503</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	<TD>2009</TD>
	<TD>2</TD>
	<TD>898</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	<TD>2005</TD>
	<TD>1</TD>
	<TD>321</TD>
	</TR>
	<TR><TD>O&#39;Reilly</TD>
	<TD>2004</TD>
	<TD>1</TD>
	<TD>691</TD>
	</TR>
	<TR><TD>Peachpit</TD>
	<TD>2005</TD>
	<TD>1</TD>
	<TD>460</TD>
	</TR>
	<TR><TD>South-Western</TD>
	<TD>2008</TD>
	<TD>1</TD>
	<TD>309</TD>
	</TR>
	<TR><TD>Wiley</TD>
	<TD>2013</TD>
	<TD>1</TD>
	<TD>760</TD>
	</TR>
	<TR><TD>Wiley</TD>
	<TD>2011</TD>
	<TD>2</TD>
	<TD>1108</TD>
	</TR>
	<TR><TD>Wiley</TD>
	<TD>2010</TD>
	<TD>1</TD>
	<TD>440</TD>
	</TR>
	<TR><TD>Wiley</TD>
	<TD>2008</TD>
	<TD>1</TD>
	<TD>857</TD>
	</TR>
	<TR><TD>Wiley</TD>
	<TD>2005</TD>
	<TD>1</TD>
	<TD>501</TD>
	</TR>
</table></pre>
</div>


<div>
<p>Looking more closely, this query:</p>
<ol style="list-style-type: decimal">
<li><p>selected records from the <code>Works</code> table where the <code>Pages</code> field was not null;</p></li>
<li><p>grouped those records into subsets so that the <code>Publisher</code> and <code>Date</code> values in each subset were the same;</p></li>
<li><p>ordered those subsets first by <code>Publisher</code>, and then within each sub-group by <code>Date</code>; and</p></li>
<li><p>counted the number of records in each subset, calculated the sum of <code>Pages</code> in each, and chose a <code>Publisher</code> and <code>Date</code> value from each to display (it doesn't matter which ones, since they're all equal in each subset).</p></li>
</ol>
</div>


<div>
<h4 id="challenges">Challenges</h4>
<ol style="list-style-type: decimal">
<li><p>How many books were published in 2011, and what was their average length?</p></li>
<li><p>The average of a set of values is the sum of the values divided by the number of values. Does this mean that the <code>avg</code> function returns 2.0 or 3.0 when given the values 1.0, <code>NULL</code>, and 5.0?</p></li>
<li><p>The function <code>group_concat(field, separator)</code> concatenates all the values in a field using the specified separator character (or ',' if the separator isn't specified). Use this to produce a one-line list of publishers' names, such as:</p>
<pre><code>O'Reilly, Wiley, Faber &amp; Faber, Belknap Press, ...</code></pre>
<p>Can you find a way to order the list alphabetically?</p></li>
</ol>
</div>


<div class="keypoints">
<h4 id="key-points">Key Points</h4>
<ul>
<li>An aggregation function combines many values to produce a single new value.</li>
<li>Aggregation functions ignore <code>null</code> values.</li>
<li>Aggregation happens after filtering.</li>
</ul>
</div>
