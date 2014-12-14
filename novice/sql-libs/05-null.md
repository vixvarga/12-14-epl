---
layout: lesson
root: ../..
---

## Missing Data


<div class="objectives">
<h4 id="objectives">Objectives</h4>
<ul>
<li>Explain how databases represent missing information.</li>
<li>Explain the three-valued logic databases use when manipulating missing information.</li>
<li>Write queries that handle missing information correctly.</li>
</ul>
</div>

<div>
<p>Real-world data is never complete—there are always holes. Databases represent these holes using special value called <code>NULL</code>. <code>NULL</code> is not zero, <code>False</code>, or the empty string; it is a one-of-a-kind value that means &quot;nothing here&quot;. Dealing with <code>NULL</code> requires a few special tricks and some careful thinking.</p>
<p>To start, let's have a look at the <code>Works</code> table. There are a total of 20 records. The page number is missing for records #2 and #26—for them, the <code>Pages</code> field is null:</p>
</div>

<div class="in">
<pre>%load_ext sqlitemagic</pre>
</div>

<div class="in">
<pre>%%sqlite swclib.db
SELECT Work_ID, Title, Pages FROM Works;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>1</TD>
	<TD>SQL in a nutshell</TD>
	<TD>578</TD>
	</TR>
	<TR><TD>2</TD>
	<TD>SQL for dummies</TD>
	<TD bgcolor="red"></TD>
	</TR>
	<TR><TD>3</TD>
	<TD>PHP &amp; MySQL</TD>
	<TD>532</TD>
	</TR>
	<TR><TD>4</TD>
	<TD>Using SQLite</TD>
	<TD>503</TD>
	</TR>
	<TR><TD>5</TD>
	<TD>Geek sublime</TD>
	<TD>258</TD>
	</TR>
	<TR><TD>6</TD>
	<TD>Capital in the 21st century</TD>
	<TD>685</TD>
	</TR>
	<TR><TD>7</TD>
	<TD>SQL</TD>
	<TD>534</TD>
	</TR>
	<TR><TD>8</TD>
	<TD>Discovering SQL</TD>
	<TD>400</TD>
	</TR>
	<TR><TD>9</TD>
	<TD>SQL</TD>
	<TD>460</TD>
	</TR>
	<TR><TD>10</TD>
	<TD>A guide to SQL</TD>
	<TD>309</TD>
	</TR>
	<TR><TD>11</TD>
	<TD>SQL bible</TD>
	<TD>857</TD>
	</TR>
	<TR><TD>12</TD>
	<TD>Learning SQL</TD>
	<TD>320</TD>
	</TR>
	<TR><TD>13</TD>
	<TD>SQL for dummies</TD>
	<TD>440</TD>
	</TR>
	<TR><TD>14</TD>
	<TD>Beginning SQL queries</TD>
	<TD>218</TD>
	</TR>
	<TR><TD>15</TD>
	<TD>Beginning SQL</TD>
	<TD>501</TD>
	</TR>
	<TR><TD>16</TD>
	<TD>Microsoft SQL server 2012</TD>
	<TD bgcolor="red"></TD>
	</TR>
	<TR><TD>17</TD>
	<TD>SQL all-in-one</TD>
	<TD>708</TD>
	</TR>
	<TR><TD>18</TD>
	<TD>Access 2013 all-in-one</TD>
	<TD>760</TD>
	</TR>
	<TR><TD>19</TD>
	<TD>SQL in a nutshell</TD>
	<TD>691</TD>
	</TR>
	<TR><TD>20</TD>
	<TD>MySQL in a nutshell</TD>
	<TD>321</TD>
	</TR>
</table></pre>
</div>

<div>
<p>Null doesn't behave like other values. If we select the works that have less than 300 pages:</p>
</div>

<div class="in">
<pre>%%sqlite swclib.db
SELECT Work_ID, Title, Pages FROM Works WHERE Pages&lt;300</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>5</TD>
	<TD>Geek sublime</TD>
	<TD>258</TD>
	</TR>
	<TR><TD>14</TD>
	<TD>Beginning SQL queries</TD>
	<TD>218</TD>
	</TR>
</table></pre>
</div>

<div>
<p>we get two results, and if we select the ones that have 300 or more pages:</p>
</div>

<div class="in">
<pre>%%sqlite swclib.db
SELECT Work_ID, Title, Pages FROM Works WHERE Pages&gt;=300</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>1</TD>
	<TD>SQL in a nutshell</TD>
	<TD>578</TD>
	</TR>
	<TR><TD>3</TD>
	<TD>PHP &amp; MySQL</TD>
	<TD>532</TD>
	</TR>
	<TR><TD>4</TD>
	<TD>Using SQLite</TD>
	<TD>503</TD>
	</TR>
	<TR><TD>6</TD>
	<TD>Capital in the 21st century</TD>
	<TD>685</TD>
	</TR>
	<TR><TD>7</TD>
	<TD>SQL</TD>
	<TD>534</TD>
	</TR>
	<TR><TD>8</TD>
	<TD>Discovering SQL</TD>
	<TD>400</TD>
	</TR>
	<TR><TD>9</TD>
	<TD>SQL</TD>
	<TD>460</TD>
	</TR>
	<TR><TD>10</TD>
	<TD>A guide to SQL</TD>
	<TD>309</TD>
	</TR>
	<TR><TD>11</TD>
	<TD>SQL bible</TD>
	<TD>857</TD>
	</TR>
	<TR><TD>12</TD>
	<TD>Learning SQL</TD>
	<TD>320</TD>
	</TR>
	<TR><TD>13</TD>
	<TD>SQL for dummies</TD>
	<TD>440</TD>
	</TR>
	<TR><TD>15</TD>
	<TD>Beginning SQL</TD>
	<TD>501</TD>
	</TR>
	<TR><TD>17</TD>
	<TD>SQL all-in-one</TD>
	<TD>708</TD>
	</TR>
	<TR><TD>18</TD>
	<TD>Access 2013 all-in-one</TD>
	<TD>760</TD>
	</TR>
	<TR><TD>19</TD>
	<TD>SQL in a nutshell</TD>
	<TD>691</TD>
	</TR>
	<TR><TD>20</TD>
	<TD>MySQL in a nutshell</TD>
	<TD>321</TD>
	</TR>
</table></pre>
</div>


<div>
<p>we get sixteen results. Records #2 and #16 aren't in either set of results. The reason is that <code>NULL&lt;300</code> is neither true nor false: null means, &quot;We don't know,&quot; and if we don't know the value on the left side of a comparison, we don't know whether the comparison is true or false. Since databases represent &quot;don't know&quot; as null, the value of <code>NULL&lt;300</code> is actually <code>NULL</code>. <code>NULL&gt;=300</code> is also null because we can't answer to that question either. And since the only records kept by a <code>WHERE</code> are those for which the test is true, records #2 and #16 aren't included in either set of results.</p>
<p>Comparisons aren't the only operations that behave this way with nulls. <code>1+NULL</code> is <code>NULL</code>, <code>5*NULL</code> is <code>NULL</code>, <code>log(NULL)</code> is <code>NULL</code>, and so on. In particular, comparing things to NULL with = and != produces NULL:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Work_ID, Title, Pages FROM Works WHERE Pages=NULL;</pre>
</div>

<div class="out">
<pre><table>

</table></pre>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Work_ID, Title, Pages FROM Works WHERE Pages!=NULL;</pre>
</div>

<div class="out">
<pre><table>

</table></pre>
</div>


<div>
<p>To check whether a value is <code>NULL</code> or not, we must use a special test <code>IS NULL</code>:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Work_ID, Title, Pages FROM Works WHERE Pages IS NULL</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>2</TD>
	<TD>SQL for dummies</TD>
	<TD bgcolor="red"></TD>
	</TR>
	<TR><TD>16</TD>
	<TD>Microsoft SQL server 2012</TD>
	<TD bgcolor="red"></TD>
	</TR>
</table></pre>
</div>


<div>
<p>or its inverse <code>IS NOT NULL</code>:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Work_ID, Title, Pages FROM Works WHERE Pages IS NOT NULL</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>1</TD>
	<TD>SQL in a nutshell</TD>
	<TD>578</TD>
	</TR>
	<TR><TD>3</TD>
	<TD>PHP &amp; MySQL</TD>
	<TD>532</TD>
	</TR>
	<TR><TD>4</TD>
	<TD>Using SQLite</TD>
	<TD>503</TD>
	</TR>
	<TR><TD>5</TD>
	<TD>Geek sublime</TD>
	<TD>258</TD>
	</TR>
	<TR><TD>6</TD>
	<TD>Capital in the 21st century</TD>
	<TD>685</TD>
	</TR>
	<TR><TD>7</TD>
	<TD>SQL</TD>
	<TD>534</TD>
	</TR>
	<TR><TD>8</TD>
	<TD>Discovering SQL</TD>
	<TD>400</TD>
	</TR>
	<TR><TD>9</TD>
	<TD>SQL</TD>
	<TD>460</TD>
	</TR>
	<TR><TD>10</TD>
	<TD>A guide to SQL</TD>
	<TD>309</TD>
	</TR>
	<TR><TD>11</TD>
	<TD>SQL bible</TD>
	<TD>857</TD>
	</TR>
	<TR><TD>12</TD>
	<TD>Learning SQL</TD>
	<TD>320</TD>
	</TR>
	<TR><TD>13</TD>
	<TD>SQL for dummies</TD>
	<TD>440</TD>
	</TR>
	<TR><TD>14</TD>
	<TD>Beginning SQL queries</TD>
	<TD>218</TD>
	</TR>
	<TR><TD>15</TD>
	<TD>Beginning SQL</TD>
	<TD>501</TD>
	</TR>
	<TR><TD>17</TD>
	<TD>SQL all-in-one</TD>
	<TD>708</TD>
	</TR>
	<TR><TD>18</TD>
	<TD>Access 2013 all-in-one</TD>
	<TD>760</TD>
	</TR>
	<TR><TD>19</TD>
	<TD>SQL in a nutshell</TD>
	<TD>691</TD>
	</TR>
	<TR><TD>20</TD>
	<TD>MySQL in a nutshell</TD>
	<TD>321</TD>
	</TR>
</table></pre>
</div>

<div>
<p>Null values cause headaches wherever they appear. For example, suppose we want to find all books about SQL that have less than 500 pages. It's natural to write the query like this:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT * FROM Works WHERE Title LIKE "%SQL%" AND Pages&lt;500;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>8</TD>
	<TD>Discovering SQL</TD>
	<TD>9781118002674</TD>
	<TD>2011</TD>
	<TD>Indianapolis</TD>
	<TD>Wiley</TD>
	<TD></TD>
	<TD>400</TD>
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
	<TR><TD>10</TD>
	<TD>A guide to SQL</TD>
	<TD>9780324597684</TD>
	<TD>2008</TD>
	<TD>Mason</TD>
	<TD>South-Western</TD>
	<TD>8th ed.</TD>
	<TD>309</TD>
	</TR>
	<TR><TD>12</TD>
	<TD>Learning SQL</TD>
	<TD>9780596520830</TD>
	<TD>2009</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>2nd ed.</TD>
	<TD>320</TD>
	</TR>
	<TR><TD>13</TD>
	<TD>SQL for dummies</TD>
	<TD>9780470557419</TD>
	<TD>2010</TD>
	<TD>Hoboken</TD>
	<TD>Wiley</TD>
	<TD>7th ed.</TD>
	<TD>440</TD>
	</TR>
	<TR><TD>14</TD>
	<TD>Beginning SQL queries</TD>
	<TD>9781590599433</TD>
	<TD>2008</TD>
	<TD>Berkeley</TD>
	<TD>Apress</TD>
	<TD></TD>
	<TD>218</TD>
	</TR>
	<TR><TD>20</TD>
	<TD>MySQL in a nutshell</TD>
	<TD>0596007892</TD>
	<TD>2005</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>1st ed.</TD>
	<TD>321</TD>
	</TR>
</table></pre>
</div>

<div>
<p>but this query filters omits the records where we don't know the number of pages. Once again, the reason is that when <code>Pages</code> is <code>NULL</code>, the <code>&lt;</code> comparison produces <code>NULL</code>, so the record isn't kept in our results. If we want to keep these records we need to add an explicit check:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT * FROM Works WHERE Title LIKE "%SQL%" AND (Pages<500 OR Pages IS NULL);</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>2</TD>
	<TD>SQL for dummies</TD>
	<TD>9781118607961</TD>
	<TD>2013</TD>
	<TD>Hoboken</TD>
	<TD>Wiley</TD>
	<TD>8th ed.</TD>
	<TD bgcolor="red"></TD>
	</TR>
	<TR><TD>8</TD>
	<TD>Discovering SQL</TD>
	<TD>9781118002674</TD>
	<TD>2011</TD>
	<TD>Indianapolis</TD>
	<TD>Wiley</TD>
	<TD></TD>
	<TD>400</TD>
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
	<TR><TD>10</TD>
	<TD>A guide to SQL</TD>
	<TD>9780324597684</TD>
	<TD>2008</TD>
	<TD>Mason</TD>
	<TD>South-Western</TD>
	<TD>8th ed.</TD>
	<TD>309</TD>
	</TR>
	<TR><TD>12</TD>
	<TD>Learning SQL</TD>
	<TD>9780596520830</TD>
	<TD>2009</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>2nd ed.</TD>
	<TD>320</TD>
	</TR>
	<TR><TD>13</TD>
	<TD>SQL for dummies</TD>
	<TD>9780470557419</TD>
	<TD>2010</TD>
	<TD>Hoboken</TD>
	<TD>Wiley</TD>
	<TD>7th ed.</TD>
	<TD>440</TD>
	</TR>
	<TR><TD>14</TD>
	<TD>Beginning SQL queries</TD>
	<TD>9781590599433</TD>
	<TD>2008</TD>
	<TD>Berkeley</TD>
	<TD>Apress</TD>
	<TD></TD>
	<TD>218</TD>
	</TR>
	<TR><TD>16</TD>
	<TD>Microsoft SQL server 2012</TD>
	<TD>9780132977661</TD>
	<TD>2013</TD>
	<TD>Indianapolis</TD>
	<TD>Sams</TD>
	<TD bgcolor="red"></TD>
	<TD bgcolor="red"></TD>
	</TR>
	<TR><TD>20</TD>
	<TD>MySQL in a nutshell</TD>
	<TD>0596007892</TD>
	<TD>2005</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>1st ed.</TD>
	<TD>321</TD>
	</TR>
</table></pre>
</div>

<div>
<p>We still have to decide whether this is the right thing to do or not. If we want to be absolutely sure that we aren't including any books with less than 500 pages, we need to exclude all the records for which we don't know the number of pages.</p>
</div>


<div>
<h4 id="challenges">Challenges</h4>
<ol style="list-style-type: decimal">
<li><p>Write a query that sorts the records in <code>Works</code> by the number of pages, omitting entries for which this information is not known (i.e., is null).</p></li>
<li><p>What do you expect the query:</p>
<pre><code>SELECT * FROM Works WHERE Edition in (&#39;1st ed.&#39;, null);</code></pre>
<p>to produce? What does it actually produce?</p></li>
<li><p>Some database designers prefer to use a <a href="../../gloss.html#sentinel-value">sentinel value</a> to mark missing data rather than <code>NULL</code>. For example, they will use the date &quot;0000-00-00&quot; to mark a missing date, or -1 to mark a missing page number. What does this simplify? What burdens or risks does it introduce?</p></li>
</ol>
</div>


<div class="keypoints">
<h4 id="key-points">Key Points</h4>
<ul>
<li>Databases use <code>null</code> to represent missing information.</li>
<li>Any arithmetic or Boolean operation involving <code>null</code> produces <code>null</code> as a result.</li>
<li>The only operators that can safely be used with <code>null</code> are <code>is null</code> and <code>is not null</code>.</li>
</ul>
</div>
