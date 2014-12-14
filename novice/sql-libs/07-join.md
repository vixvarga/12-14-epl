---
layout: lesson
root: ../..
---

## Combining Data


<div class="objectives">
<h4 id="objectives">Objectives</h4>
<ul>
<li>Explain the operation of a query that joins two tables.</li>
<li>Explain how to restrict the output of a query containing a join to only include meaningful combinations of values.</li>
<li>Write queries that join tables on equal keys.</li>
<li>Explain what primary and foreign keys are, and why they are useful.</li>
<li>Explain what atomic values are, and why database fields should only contain atomic values.</li>
</ul>
</div>


<div>
<p>So far we haven't been able to display the authors' names in our query results, because those names are not in the <code>Works</code> but in the <code>Authors</code> table. What's worse, because there can be many authors to a title and many title associated with each author, there is a third table, <code>Works_Authors</code> that's taking care of this many-to-many relationship. How can these tables be joined?</p>
<p>The SQL command to do this is <code>JOIN</code>. To see how it works, let's start with the somewhat easier case of the <code>Items</code> table and try joining it to the <code>Works</code> table:</p>
</div>


<div class="in">
<pre>%load_ext sqlitemagic</pre>
</div>

<div class="in">
<pre>%%sqlite swclib.db
SELECT * FROM Items JOIN Works;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>1</TD>
	<TD>1</TD>
	<TD>081722942611</TD>
	<TD>2009</TD>
	<TD>Loaned</TD>
	<TD>1</TD>
	<TD>SQL in a nutshell</TD>
	<TD>9780596518844</TD>
	<TD>2009</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>3rd ed.</TD>
	<TD>578</TD>
	</TR>
	<TR><TD>1</TD>
	<TD>1</TD>
	<TD>081722942611</TD>
	<TD>2009</TD>
	<TD>Loaned</TD>
	<TD>2</TD>
	<TD>SQL for dummies</TD>
	<TD>9781118607961</TD>
	<TD>2013</TD>
	<TD>Hoboken</TD>
	<TD>Wiley</TD>
	<TD>8th ed.</TD>
	<TD></TD>
	</TR>
	<TR><TD>1</TD>
	<TD>1</TD>
	<TD>081722942611</TD>
	<TD>2009</TD>
	<TD>Loaned</TD>
	<TD>3</TD>
	<TD>PHP &amp; MySQL</TD>
	<TD>9781449325572</TD>
	<TD>2013</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>2nd ed.</TD>
	<TD>532</TD>
	</TR>
	<TR><TD>1</TD>
	<TD>1</TD>
	<TD>081722942611</TD>
	<TD>2009</TD>
	<TD>Loaned</TD>
	<TD>4</TD>
	<TD>Using SQLite</TD>
	<TD>9780596521189</TD>
	<TD>2010</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>1st ed.</TD>
	<TD>503</TD>
	</TR>
	<TR><TD>1</TD>
	<TD>1</TD>
	<TD>081722942611</TD>
	<TD>2009</TD>
	<TD>Loaned</TD>
	<TD>5</TD>
	<TD>Geek sublime</TD>
	<TD>9780571310302</TD>
	<TD>2014</TD>
	<TD>London</TD>
	<TD>Faber &amp; Faber</TD>
	<TD></TD>
	<TD>258</TD>
	</TR>
</table></pre>
</div>

<div>
<p>The result above was truncated for display because... the query returned a list of 800 records! In fact, <code>JOIN</code> creates the <a href="../../gloss.html#cross-product">cross product</a> of two tables, i.e., it joins each record of one with each record of the other to give all possible combinations. Since there are 20 records in <code>Works</code> and 40 in <code>Items</code>, the join's output has 20*40=800 records. And since <code>Works</code> has 8 fields and <code>Items</code> has 5, the output has 8+5=13 fields.</p>
<p>What the join <em>hasn't</em> done is figure out if the records being joined have anything to do with each other. It has no way of knowing whether they do or not until we tell it how. To do that, we add a clause specifying that we're only interested in combinations where <code>Work_ID</code> matches in both tables:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT * FROM Items JOIN Works ON Items.Work_ID=Works.Work_ID;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>1</TD>
	<TD>1</TD>
	<TD>081722942611</TD>
	<TD>2009</TD>
	<TD>Loaned</TD>
	<TD>1</TD>
	<TD>SQL in a nutshell</TD>
	<TD>9780596518844</TD>
	<TD>2009</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>3rd ed.</TD>
	<TD>578</TD>
	</TR>
	<TR><TD>2</TD>
	<TD>1</TD>
	<TD>492437609065</TD>
	<TD>2011</TD>
	<TD>On shelf</TD>
	<TD>1</TD>
	<TD>SQL in a nutshell</TD>
	<TD>9780596518844</TD>
	<TD>2009</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>3rd ed.</TD>
	<TD>578</TD>
	</TR>
	<TR><TD>3</TD>
	<TD>2</TD>
	<TD>172480710952</TD>
	<TD>2013</TD>
	<TD>On shelf</TD>
	<TD>2</TD>
	<TD>SQL for dummies</TD>
	<TD>9781118607961</TD>
	<TD>2013</TD>
	<TD>Hoboken</TD>
	<TD>Wiley</TD>
	<TD>8th ed.</TD>
	<TD></TD>
	</TR>
	<TR><TD>4</TD>
	<TD>3</TD>
	<TD>708014968732</TD>
	<TD>2013</TD>
	<TD>Missing</TD>
	<TD>3</TD>
	<TD>PHP &amp; MySQL</TD>
	<TD>9781449325572</TD>
	<TD>2013</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>2nd ed.</TD>
	<TD>532</TD>
	</TR>
	<TR><TD>5</TD>
	<TD>3</TD>
	<TD>819783404942</TD>
	<TD>2014</TD>
	<TD>Loaned</TD>
	<TD>3</TD>
	<TD>PHP &amp; MySQL</TD>
	<TD>9781449325572</TD>
	<TD>2013</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>2nd ed.</TD>
	<TD>532</TD>
	</TR>
	<TR><TD>6</TD>
	<TD>4</TD>
	<TD>257370237291</TD>
	<TD>2010</TD>
	<TD>Missing</TD>
	<TD>4</TD>
	<TD>Using SQLite</TD>
	<TD>9780596521189</TD>
	<TD>2010</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>1st ed.</TD>
	<TD>503</TD>
	</TR>
	<TR><TD>7</TD>
	<TD>5</TD>
	<TD>002905925356</TD>
	<TD>2014</TD>
	<TD>Loaned</TD>
	<TD>5</TD>
	<TD>Geek sublime</TD>
	<TD>9780571310302</TD>
	<TD>2014</TD>
	<TD>London</TD>
	<TD>Faber &amp; Faber</TD>
	<TD></TD>
	<TD>258</TD>
	</TR>
	<TR><TD>8</TD>
	<TD>5</TD>
	<TD>964583604781</TD>
	<TD>2014</TD>
	<TD>Loaned</TD>
	<TD>5</TD>
	<TD>Geek sublime</TD>
	<TD>9780571310302</TD>
	<TD>2014</TD>
	<TD>London</TD>
	<TD>Faber &amp; Faber</TD>
	<TD></TD>
	<TD>258</TD>
	</TR>
	<TR><TD>9</TD>
	<TD>6</TD>
	<TD>701630524534</TD>
	<TD>2014</TD>
	<TD>Loaned</TD>
	<TD>6</TD>
	<TD>Capital in the 21st century</TD>
	<TD>9780674430006</TD>
	<TD>2014</TD>
	<TD>Cambridge</TD>
	<TD>Belknap Press</TD>
	<TD></TD>
	<TD>685</TD>
	</TR>
	<TR><TD>10</TD>
	<TD>6</TD>
	<TD>722040919616</TD>
	<TD>2014</TD>
	<TD>On shelf</TD>
	<TD>6</TD>
	<TD>Capital in the 21st century</TD>
	<TD>9780674430006</TD>
	<TD>2014</TD>
	<TD>Cambridge</TD>
	<TD>Belknap Press</TD>
	<TD></TD>
	<TD>685</TD>
	</TR>
	<TR><TD>11</TD>
	<TD>6</TD>
	<TD>026655281484</TD>
	<TD>2014</TD>
	<TD>On shelf</TD>
	<TD>6</TD>
	<TD>Capital in the 21st century</TD>
	<TD>9780674430006</TD>
	<TD>2014</TD>
	<TD>Cambridge</TD>
	<TD>Belknap Press</TD>
	<TD></TD>
	<TD>685</TD>
	</TR>
	<TR><TD>12</TD>
	<TD>7</TD>
	<TD>422970103061</TD>
	<TD>2010</TD>
	<TD>On shelf</TD>
	<TD>7</TD>
	<TD>SQL</TD>
	<TD>9780071548649</TD>
	<TD>2009</TD>
	<TD>New York</TD>
	<TD>McGraw-Hill</TD>
	<TD>3rd ed.</TD>
	<TD>534</TD>
	</TR>
	<TR><TD>13</TD>
	<TD>8</TD>
	<TD>655280484976</TD>
	<TD>2011</TD>
	<TD>Loaned</TD>
	<TD>8</TD>
	<TD>Discovering SQL</TD>
	<TD>9781118002674</TD>
	<TD>2011</TD>
	<TD>Indianapolis</TD>
	<TD>Wiley</TD>
	<TD></TD>
	<TD>400</TD>
	</TR>
	<TR><TD>14</TD>
	<TD>9</TD>
	<TD>610721228318</TD>
	<TD>2005</TD>
	<TD>Missing</TD>
	<TD>9</TD>
	<TD>SQL</TD>
	<TD>0321334175</TD>
	<TD>2005</TD>
	<TD>Berkeley</TD>
	<TD>Peachpit</TD>
	<TD>2nd ed.</TD>
	<TD>460</TD>
	</TR>
	<TR><TD>15</TD>
	<TD>10</TD>
	<TD>148164881245</TD>
	<TD>2008</TD>
	<TD>Missing</TD>
	<TD>10</TD>
	<TD>A guide to SQL</TD>
	<TD>9780324597684</TD>
	<TD>2008</TD>
	<TD>Mason</TD>
	<TD>South-Western</TD>
	<TD>8th ed.</TD>
	<TD>309</TD>
	</TR>
	<TR><TD>16</TD>
	<TD>10</TD>
	<TD>445317012796</TD>
	<TD>2010</TD>
	<TD>On shelf</TD>
	<TD>10</TD>
	<TD>A guide to SQL</TD>
	<TD>9780324597684</TD>
	<TD>2008</TD>
	<TD>Mason</TD>
	<TD>South-Western</TD>
	<TD>8th ed.</TD>
	<TD>309</TD>
	</TR>
	<TR><TD>17</TD>
	<TD>11</TD>
	<TD>291006691199</TD>
	<TD>2008</TD>
	<TD>On shelf</TD>
	<TD>11</TD>
	<TD>SQL bible</TD>
	<TD>9780470229064</TD>
	<TD>2008</TD>
	<TD>Indianapolis</TD>
	<TD>Wiley</TD>
	<TD>2nd ed.</TD>
	<TD>857</TD>
	</TR>
	<TR><TD>18</TD>
	<TD>12</TD>
	<TD>665741505651</TD>
	<TD>2009</TD>
	<TD>On shelf</TD>
	<TD>12</TD>
	<TD>Learning SQL</TD>
	<TD>9780596520830</TD>
	<TD>2009</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>2nd ed.</TD>
	<TD>320</TD>
	</TR>
	<TR><TD>19</TD>
	<TD>12</TD>
	<TD>623061160016</TD>
	<TD>2009</TD>
	<TD>Loaned</TD>
	<TD>12</TD>
	<TD>Learning SQL</TD>
	<TD>9780596520830</TD>
	<TD>2009</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>2nd ed.</TD>
	<TD>320</TD>
	</TR>
	<TR><TD>20</TD>
	<TD>13</TD>
	<TD>827361553957</TD>
	<TD>2010</TD>
	<TD>On shelf</TD>
	<TD>13</TD>
	<TD>SQL for dummies</TD>
	<TD>9780470557419</TD>
	<TD>2010</TD>
	<TD>Hoboken</TD>
	<TD>Wiley</TD>
	<TD>7th ed.</TD>
	<TD>440</TD>
	</TR>
	<TR><TD>21</TD>
	<TD>13</TD>
	<TD>228598347653</TD>
	<TD>2010</TD>
	<TD>Missing</TD>
	<TD>13</TD>
	<TD>SQL for dummies</TD>
	<TD>9780470557419</TD>
	<TD>2010</TD>
	<TD>Hoboken</TD>
	<TD>Wiley</TD>
	<TD>7th ed.</TD>
	<TD>440</TD>
	</TR>
	<TR><TD>22</TD>
	<TD>13</TD>
	<TD>585952782539</TD>
	<TD>2010</TD>
	<TD>On shelf</TD>
	<TD>13</TD>
	<TD>SQL for dummies</TD>
	<TD>9780470557419</TD>
	<TD>2010</TD>
	<TD>Hoboken</TD>
	<TD>Wiley</TD>
	<TD>7th ed.</TD>
	<TD>440</TD>
	</TR>
	<TR><TD>23</TD>
	<TD>13</TD>
	<TD>701532568017</TD>
	<TD>2011</TD>
	<TD>On shelf</TD>
	<TD>13</TD>
	<TD>SQL for dummies</TD>
	<TD>9780470557419</TD>
	<TD>2010</TD>
	<TD>Hoboken</TD>
	<TD>Wiley</TD>
	<TD>7th ed.</TD>
	<TD>440</TD>
	</TR>
	<TR><TD>24</TD>
	<TD>14</TD>
	<TD>989297622703</TD>
	<TD>2008</TD>
	<TD>On shelf</TD>
	<TD>14</TD>
	<TD>Beginning SQL queries</TD>
	<TD>9781590599433</TD>
	<TD>2008</TD>
	<TD>Berkeley</TD>
	<TD>Apress</TD>
	<TD></TD>
	<TD>218</TD>
	</TR>
	<TR><TD>25</TD>
	<TD>15</TD>
	<TD>640793136396</TD>
	<TD>2005</TD>
	<TD>On shelf</TD>
	<TD>15</TD>
	<TD>Beginning SQL</TD>
	<TD>0764577328</TD>
	<TD>2005</TD>
	<TD>Indianapolis</TD>
	<TD>Wiley</TD>
	<TD></TD>
	<TD>501</TD>
	</TR>
	<TR><TD>26</TD>
	<TD>15</TD>
	<TD>521089986565</TD>
	<TD>2005</TD>
	<TD>On shelf</TD>
	<TD>15</TD>
	<TD>Beginning SQL</TD>
	<TD>0764577328</TD>
	<TD>2005</TD>
	<TD>Indianapolis</TD>
	<TD>Wiley</TD>
	<TD></TD>
	<TD>501</TD>
	</TR>
	<TR><TD>27</TD>
	<TD>16</TD>
	<TD>139685507140</TD>
	<TD>2013</TD>
	<TD>Loaned</TD>
	<TD>16</TD>
	<TD>Microsoft SQL server 2012</TD>
	<TD>9780132977661</TD>
	<TD>2013</TD>
	<TD>Indianapolis</TD>
	<TD>Sams</TD>
	<TD></TD>
	<TD></TD>
	</TR>
	<TR><TD>28</TD>
	<TD>16</TD>
	<TD>853183712696</TD>
	<TD>2013</TD>
	<TD>Loaned</TD>
	<TD>16</TD>
	<TD>Microsoft SQL server 2012</TD>
	<TD>9780132977661</TD>
	<TD>2013</TD>
	<TD>Indianapolis</TD>
	<TD>Sams</TD>
	<TD></TD>
	<TD></TD>
	</TR>
	<TR><TD>29</TD>
	<TD>17</TD>
	<TD>257153081154</TD>
	<TD>2011</TD>
	<TD>On shelf</TD>
	<TD>17</TD>
	<TD>SQL all-in-one</TD>
	<TD>9780470929964</TD>
	<TD>2011</TD>
	<TD>Hoboken</TD>
	<TD>Wiley</TD>
	<TD>2nd ed.</TD>
	<TD>708</TD>
	</TR>
	<TR><TD>30</TD>
	<TD>18</TD>
	<TD>208546921091</TD>
	<TD>2013</TD>
	<TD>Loaned</TD>
	<TD>18</TD>
	<TD>Access 2013 all-in-one</TD>
	<TD>9781118510551</TD>
	<TD>2013</TD>
	<TD>Hoboken</TD>
	<TD>Wiley</TD>
	<TD></TD>
	<TD>760</TD>
	</TR>
	<TR><TD>31</TD>
	<TD>19</TD>
	<TD>921664426379</TD>
	<TD>2004</TD>
	<TD>On shelf</TD>
	<TD>19</TD>
	<TD>SQL in a nutshell</TD>
	<TD>0596004818</TD>
	<TD>2004</TD>
	<TD>Cambridge</TD>
	<TD>O&#39;Reilly</TD>
	<TD>2nd ed.</TD>
	<TD>691</TD>
	</TR>
	<TR><TD>32</TD>
	<TD>19</TD>
	<TD>298308111210</TD>
	<TD>2004</TD>
	<TD>Loaned</TD>
	<TD>19</TD>
	<TD>SQL in a nutshell</TD>
	<TD>0596004818</TD>
	<TD>2004</TD>
	<TD>Cambridge</TD>
	<TD>O&#39;Reilly</TD>
	<TD>2nd ed.</TD>
	<TD>691</TD>
	</TR>
	<TR><TD>33</TD>
	<TD>19</TD>
	<TD>210139559101</TD>
	<TD>2004</TD>
	<TD>Missing</TD>
	<TD>19</TD>
	<TD>SQL in a nutshell</TD>
	<TD>0596004818</TD>
	<TD>2004</TD>
	<TD>Cambridge</TD>
	<TD>O&#39;Reilly</TD>
	<TD>2nd ed.</TD>
	<TD>691</TD>
	</TR>
	<TR><TD>34</TD>
	<TD>20</TD>
	<TD>344919897556</TD>
	<TD>2005</TD>
	<TD>On shelf</TD>
	<TD>20</TD>
	<TD>MySQL in a nutshell</TD>
	<TD>0596007892</TD>
	<TD>2005</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>1st ed.</TD>
	<TD>321</TD>
	</TR>
	<TR><TD>35</TD>
	<TD>20</TD>
	<TD>035230397910</TD>
	<TD>2005</TD>
	<TD>On shelf</TD>
	<TD>20</TD>
	<TD>MySQL in a nutshell</TD>
	<TD>0596007892</TD>
	<TD>2005</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>1st ed.</TD>
	<TD>321</TD>
	</TR>
	<TR><TD>36</TD>
	<TD>20</TD>
	<TD>527524003500</TD>
	<TD>2005</TD>
	<TD>On shelf</TD>
	<TD>20</TD>
	<TD>MySQL in a nutshell</TD>
	<TD>0596007892</TD>
	<TD>2005</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>1st ed.</TD>
	<TD>321</TD>
	</TR>
	<TR><TD>37</TD>
	<TD>20</TD>
	<TD>467701665668</TD>
	<TD>2005</TD>
	<TD>Missing</TD>
	<TD>20</TD>
	<TD>MySQL in a nutshell</TD>
	<TD>0596007892</TD>
	<TD>2005</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>1st ed.</TD>
	<TD>321</TD>
	</TR>
	<TR><TD>38</TD>
	<TD>20</TD>
	<TD>082665141572</TD>
	<TD>2005</TD>
	<TD>On shelf</TD>
	<TD>20</TD>
	<TD>MySQL in a nutshell</TD>
	<TD>0596007892</TD>
	<TD>2005</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>1st ed.</TD>
	<TD>321</TD>
	</TR>
	<TR><TD>39</TD>
	<TD>20</TD>
	<TD>273837764866</TD>
	<TD>2006</TD>
	<TD>Loaned</TD>
	<TD>20</TD>
	<TD>MySQL in a nutshell</TD>
	<TD>0596007892</TD>
	<TD>2005</TD>
	<TD>Sebastopol</TD>
	<TD>O&#39;Reilly</TD>
	<TD>1st ed.</TD>
	<TD>321</TD>
	</TR>
	<TR><TD>40</TD>
	<TD>20</TD>
	<TD>582937020090</TD>
	<TD>2006</TD>
	<TD>On shelf</TD>
	<TD>20</TD>
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
<p><code>ON</code> does the same job as <code>WHERE</code>: it only keeps records that pass some test. (The difference between the two is that <code>ON</code> filters records as they're being created, while <code>WHERE</code> waits until the join is done and then does the filtering.) Once we add this to our query, the database manager throws away records that combined items with unrelated works, leaving us with just the ones we want.</p>
<p>Notice that we used <code>table.field</code> to specify field names in the output of the join. We do this because tables can have fields with the same name, and we need to be specific which ones we're talking about.</p>
<p>We can now use the same dotted notation to select only the columns we are interested in displaying:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Items.Barcode, Works.Title, Works.ISBN FROM Items JOIN Works ON Items.Work_ID=Works.Work_ID LIMIT 10;
</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>081722942611</TD>
	<TD>SQL in a nutshell</TD>
	<TD>9780596518844</TD>
	</TR>
	<TR><TD>492437609065</TD>
	<TD>SQL in a nutshell</TD>
	<TD>9780596518844</TD>
	</TR>
	<TR><TD>172480710952</TD>
	<TD>SQL for dummies</TD>
	<TD>9781118607961</TD>
	</TR>
	<TR><TD>708014968732</TD>
	<TD>PHP &amp; MySQL</TD>
	<TD>9781449325572</TD>
	</TR>
	<TR><TD>819783404942</TD>
	<TD>PHP &amp; MySQL</TD>
	<TD>9781449325572</TD>
	</TR>
	<TR><TD>257370237291</TD>
	<TD>Using SQLite</TD>
	<TD>9780596521189</TD>
	</TR>
	<TR><TD>002905925356</TD>
	<TD>Geek sublime</TD>
	<TD>9780571310302</TD>
	</TR>
	<TR><TD>964583604781</TD>
	<TD>Geek sublime</TD>
	<TD>9780571310302</TD>
	</TR>
	<TR><TD>701630524534</TD>
	<TD>Capital in the 21st century</TD>
	<TD>9780674430006</TD>
	</TR>
	<TR><TD>722040919616</TD>
	<TD>Capital in the 21st century</TD>
	<TD>9780674430006</TD>
	</TR>
</table></pre>
</div>


<div>
<p>We can now try to tackle the case of the <code>Authors</code> table. To list the contributors associated with the first item on the <code>Works</code> table (<code>Work_ID=1</code>, SQL in a nutshell 3rd ed.), we write:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT Works_Authors.Role, Authors.Personal, Authors.Family 
FROM   Works_Authors 
JOIN   Authors 
ON     Authors.Author_ID=Works_Authors.Author_ID 
WHERE  Works_Authors.Work_ID=1;
</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>Author</TD>
	<TD>Kevin E.</TD>
	<TD>Kline</TD>
	</TR>
	<TR><TD>Contributor</TD>
	<TD>Daniel</TD>
	<TD>Kline</TD>
	</TR>
	<TR><TD>Contributor</TD>
	<TD>Brand</TD>
	<TD>Hunt</TD>
	</TR>
</table></pre>
</div>

<div>
<p>Or inversely, if we want to list all the works that Allen G. Taylor (<code>Author_ID=4</code>) has authored or contributed to, we can write:</p>
</div>

<div class="in">
<pre>%%sqlite swclib.db
SELECT Works.Title, Works.Date, Works.Edition, Works_Authors.Role 
FROM   Works 
JOIN   Works_Authors 
ON     Works.Work_ID=Works_Authors.Work_ID 
WHERE  Works_Authors.Author_ID=4;
</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>SQL for dummies</TD>
	<TD>2013</TD>
	<TD>8th ed.</TD>
	<TD>Author</TD>
	</TR>
	<TR><TD>SQL for dummies</TD>
	<TD>2010</TD>
	<TD>7th ed.</TD>
	<TD>Author</TD>
	</TR>
	<TR><TD>SQL all-in-one</TD>
	<TD>2011</TD>
	<TD>2nd ed.</TD>
	<TD>Author</TD>
	</TR>
	<TR><TD>Access 2013 all-in-one</TD>
	<TD>2013</TD>
	<TD></TD>
	<TD>Contributor</TD>
	</TR>
</table></pre>
</div>

<div>
<p>If joining two tables is good, then joining more tables must be better. In fact, we can join any number of tables simply by adding more <code>JOIN</code> clauses to our query, and more <code>ON</code> tests to filter out combinations of records that don't make sense.</p>	
</div>

<div>
<p>We can tell which records from <code>Works</code>, <code>Authors</code>, <code>Items</code> and <code>Works_Authors</code> correspond with each other because those tables contain <a href="../../gloss.html#primary-key">primary keys</a> and <a href="../../gloss.html#foreign-key">foreign keys</a>. A primary key is a value, or combination of values, that uniquely identifies each record in a table. A foreign key is a value (or combination of values) from one table that identifies a unique record in another table. Another way of saying this is that a foreign key is the primary key of one table that appears in some other table. In our database, <code>Works.Work_ID</code> is the primary key in the <code>Works</code> table, while <code>Items.Work_ID</code> is a foreign key relating the <code>Items</code> table's entries to entries in <code>Works</code>. The <code>Authors_Works</code> table contains only foreign keys relating to entries in the <code>Works</code> and <code>Authors</code> tables.</p>
<p>Most database designers believe that every table should have a well-defined primary key. They also believe that this key should be separate from the data itself, so that if we ever need to change the data, we only need to make one change in one place. One easy way to do this is to create an arbitrary, unique ID for each record as we add it to the database. This is actually very common: those IDs have names like &quot;student numbers&quot; and &quot;library card numbers&quot;, and they almost always turn out to have originally been a unique record identifier in some database system or other. As the query below demonstrates, SQLite actually numbers records automatically as they're added to tables, and this number could have been used instead of the ID numbers that were specified in the example tables:</p>
</div>


<div class="in">
<pre>%%sqlite swclib.db
SELECT rowid, * from Items LIMIT 5;</pre>
</div>

<div class="out">
<pre><table>
	<TR><TD>1</TD>
	<TD>1</TD>
	<TD>1</TD>
	<TD>081722942611</TD>
	<TD>2009</TD>
	<TD>Loaned</TD>
	</TR>
	<TR><TD>2</TD>
	<TD>2</TD>
	<TD>1</TD>
	<TD>492437609065</TD>
	<TD>2011</TD>
	<TD>On shelf</TD>
	</TR>
	<TR><TD>3</TD>
	<TD>3</TD>
	<TD>2</TD>
	<TD>172480710952</TD>
	<TD>2013</TD>
	<TD>On shelf</TD>
	</TR>
	<TR><TD>4</TD>
	<TD>4</TD>
	<TD>3</TD>
	<TD>708014968732</TD>
	<TD>2013</TD>
	<TD>Missing</TD>
	</TR>
	<TR><TD>5</TD>
	<TD>5</TD>
	<TD>3</TD>
	<TD>819783404942</TD>
	<TD>2014</TD>
	<TD>Loaned</TD>
	</TR>
</table></pre>
</div>

### Data Hygiene


<div>
<p>Now that we have seen how joins work, we can see why the relational model is so useful and how best to use it. The first rule is that every value should be <a href="../../gloss.html#atomic-value">atomic</a>, i.e., not contain parts that we might want to work with separately. We store personal and family names in separate columns instead of putting the entire name in one column so that we don't have to use substring operations to get the name's components. More importantly, we store the two parts of the name separately because splitting on spaces is unreliable: just think of a name like &quot;Eloise St. Cyr&quot; or &quot;Jan Mikkel Steubart&quot;.</p>
<p>The second rule is that every record should have a unique primary key. This can be a serial number that has no intrinsic meaning, one of the values in the record (like the <code>Work_ID</code> field in the <code>Works</code> table), or even a combination of values.</p>
<p>The third rule is that there should be no redundant information. For example, we could get rid of the <code>Works</code> table and rewrite the <code>Items</code> table something like this:</p>
<table>
	<tr><th>Item_ID</th> <th>Title</th> <th>Publisher</th> <th>Date</th> <th>Barcode</th> <th>Acquired</th> <th>Status</th></tr>
	<TR><TD>1</TD>
	<TD>SQL in a nutshell</TD>
	<TD>Sebastopol: O'Reilly</TD>
	<TD>2009</TD>
	<TD>081722942611</TD>
	<TD>2009</TD>
	<TD>Loaned</TD>
	</TR>
	<TR><TD>2</TD>
	<TD>SQL in a nutshell</TD>
	<TD>Sebastopol: O'Reilly</TD>
	<TD>2009</TD>
	<TD>492437609065</TD>
	<TD>2011</TD>
	<TD>On shelf</TD>
	</TR>
	<TR><TD>3</TD>
	<TD>SQL for dummies</TD>
	<TD>Hoboken: Wiley</TD>
	<TD>2013</TD>
	<TD>172480710952</TD>
	<TD>2013</TD>
	<TD>On shelf</TD>
	</TR>
	<TR><TD>4</TD>
	<TD>PHP &amp; MySQL</TD>
	<TD>Sebastopol: O'Reilly</TD>
	<TD>2013</TD>
	<TD>708014968732</TD>
	<TD>2013</TD>
	<TD>Missing</TD>
	</TR>
	<TR><TD>5</TD>
	<TD>PHP &amp; MySQL</TD>
	<TD>Sebastopol: O'Reilly</TD>
	<TD>2013</TD>
	<TD>819783404942</TD>
	<TD>2014</TD>
	<TD>Loaned</TD>
	</TR>
</table>

<p>In fact, we could use a single table that recorded all the information about each item in each row, just as a spreadsheet would. The problem is that it's very hard to keep data organized this way consistent: if we realize that the bibliographic information associated with a series of items is wrong, we have to change multiple records in the database. Similarly, storing authors' and contributors' names in separate columns would mean adding an extra column every time we encounter a title that has more contributors than all the previous items. If we have only one item that has twenty contributors, a spreadsheet design would require twenty separate columns to store this information, and those columns would sit empty for the majority of the items. This is one of the reasons why authority files are in separate tables.</p>
<p>The fourth rule is that the units for every value should be stored explicitly. In this particular database, it's not very important (although we could specify that the <code>Pages</code> field contains the count of pages in any given book). This can be a problem in databases that contain scientific data, for example.</p>
<p>Stepping back, data and the tools used to store it have a symbiotic relationship: we use tables and joins because it's efficient, provided our data is organized a certain way, but organize our data that way because we have tools to manipulate it efficiently if it's in a certain form. As anthropologists say, the tool shapes the hand that shapes the tool.</p>
</div>


<div>
<h4 id="challenges">Challenges</h4>
<ol style="list-style-type: decimal">
<li><p>Write a query that lists all works written by people whose Family name start with the letter &quot;K&quot;.</p></li>
<li><p>Write a query that lists all authors that have written at least one book that is currently on loan from the library.</p></li>
<li><p>To which item does the barcode <code>722040919616</code> refer to, what is the title of this book and who are its authors?</p></li>
</ol>
</div>


<div class="keypoints">
<h4 id="key-points">Key Points</h4>
<ul>
<li>Every fact should be represented in a database exactly once.</li>
<li>A join produces all combinations of records from one table with records from another.</li>
<li>A primary key is a field (or set of fields) whose values uniquely identify the records in a table.</li>
<li>A foreign key is a field (or set of fields) in one table whose values are a primary key in another table.</li>
<li>We can eliminate meaningless combinations of records by matching primary keys and foreign keys between tables.</li>
<li>Keys should be atomic values to make joins simpler and more efficient.</li>
</ul>
</div>
