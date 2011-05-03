#! /bin/sh

PATH=..:/bin:/usr/bin

# Regression tests for the template library
# Usage: ./test.sh [ -r ]
# The -r option causes the script to edit itself and renumber
# the tests in case any are added or removed.

# renumber the tests in this script

renumber() {
    cp $0 $0.old &&
    awk '/^TEST=[0-9].* ######/ {
        printf("TEST=%d  ########################################\n", ++i);
        next }
        { print }' $0.old > $0 &&
    /bin/rm $0.old
    exit
}

check () {
    if diff -c expected result; then
        echo "Test $TEST success"
    else
        echo "Test $TEST failure"
    fi
}

test "X$1" = X-r && renumber

TEST=1  ########################################

# Testing null input

cp /dev/null tmplfile

cp tmplfile expected

template tmplfile > result 2>&1

check

TEST=2  ########################################

# Testing one char input

printf X > tmplfile

cp tmplfile expected

template tmplfile > result 2>&1

check

TEST=3  ########################################

# Testing input with no tags

cat << "EOF" > tmplfile
Now is the time
for all good men
to come to the aid
of their country
EOF

cp tmplfile expected

template tmplfile var testvalue > result 2>&1

check

TEST=4  ########################################

# Testing tags with malformed attributes, which we consider ordinary text

cat << "EOF" > tmplfile

Testing a single bad attribute

<TMPL_LOOP name>
<TMPL_LOOP name >
<TMPL_LOOP =>
<TMPL_LOOP = >
<TMPL_LOOP "var">
<TMPL_LOOP "var" >
<TMPL_LOOP name=>
<TMPL_LOOP name = >
<TMPL_LOOP ="var">
<TMPL_LOOP = "var" >
<TMPL_LOOP name=*>      * needs quotes
<TMPL_LOOP name = * >   * needs quotes
<TMPL_LOOP name="var>
<TMPL_LOOP name = "var >
<TMPL_LOOP name='var>
<TMPL_LOOP name = 'var >
<TMPL_LOOP name=var">
<TMPL_LOOP name = var" >
<TMPL_LOOP name=var'>
<TMPL_LOOP name = var' >
<TMPL_LOOP name="var'>
<TMPL_LOOP name = "var' >
<TMPL_LOOP name='var">
<TMPL_LOOP name = 'var" >

<!--TMPL_LOOP name-->
<!-- TMPL_LOOP name -->
<!--TMPL_LOOP =-->
<!-- TMPL_LOOP = -->
<!--TMPL_LOOP "var"-->
<!-- TMPL_LOOP "var" -->
<!--TMPL_LOOP name=-->
<!-- TMPL_LOOP name = -->
<!--TMPL_LOOP ="var"-->
<!-- TMPL_LOOP = "var" -->
<!--TMPL_LOOP name=*-->      * needs quotes
<!-- TMPL_LOOP name = * -->   * needs quotes
<!--TMPL_LOOP name="var-->
<!-- TMPL_LOOP name = "var -->
<!--TMPL_LOOP name='var-->
<!-- TMPL_LOOP name = 'var -->
<!--TMPL_LOOP name=var"-->
<!-- TMPL_LOOP name = var" -->
<!--TMPL_LOOP name=var'-->
<!-- TMPL_LOOP name = var' -->
<!--TMPL_LOOP name="var'-->
<!-- TMPL_LOOP name = "var' -->
<!--TMPL_LOOP name='var"-->
<!-- TMPL_LOOP name = 'var" -->

Testing good attribute followed by bad

<TMPL_VAR default="value"name>
<TMPL_VAR default = "value" name >
<TMPL_VAR default="value"=>
<TMPL_VAR default = "value" = >
<TMPL_VAR default="value""var">
<TMPL_VAR default = "value" "var" >
<TMPL_VAR default="value"name=>
<TMPL_VAR default = "value" name = >
<TMPL_VAR default="value"="var">
<TMPL_VAR default = "value" = "var" >
<TMPL_VAR default="value"name=*>         * needs quotes
<TMPL_VAR default = "value" name = * >   * needs quotes
<TMPL_VAR default="value"name="var>
<TMPL_VAR default = "value" name = "var >
<TMPL_VAR default="value"name='var>
<TMPL_VAR default = "value" name = 'var >
<TMPL_VAR default="value"name=var">
<TMPL_VAR default = "value" name = var" >
<TMPL_VAR default="value"name=var'>
<TMPL_VAR default = "value" name = var' >
<TMPL_VAR default="value"name="var'>
<TMPL_VAR default = "value" name = "var' >
<TMPL_VAR default="value"name='var">
<TMPL_VAR default = "value" name = 'var" >

<TMPL_VAR default="value"name/>
<TMPL_VAR default = "value" name />
<TMPL_VAR default="value"=/>
<TMPL_VAR default = "value" = />
<TMPL_VAR default="value""var"/>
<TMPL_VAR default = "value" "var" />
<TMPL_VAR default="value"name=/>
<TMPL_VAR default = "value" name = />
<TMPL_VAR default="value"="var"/>
<TMPL_VAR default = "value" = "var" />
<TMPL_VAR default="value"name=*/>         * needs quotes
<TMPL_VAR default = "value" name = * />   * needs quotes
<TMPL_VAR default="value"name="var/>
<TMPL_VAR default = "value" name = "var />
<TMPL_VAR default="value"name='var/>
<TMPL_VAR default = "value" name = 'var />
<TMPL_VAR default="value"name=var"/>
<TMPL_VAR default = "value" name = var" />
<TMPL_VAR default="value"name=var'/>
<TMPL_VAR default = "value" name = var' />
<TMPL_VAR default="value"name="var'/>
<TMPL_VAR default = "value" name = "var' />
<TMPL_VAR default="value"name='var"/>
<TMPL_VAR default = "value" name = 'var" />

<!--TMPL_VAR default="value"name-->
<!-- TMPL_VAR default = "value" name -->
<!--TMPL_VAR default="value"=-->
<!-- TMPL_VAR default = "value" = -->
<!--TMPL_VAR default="value""var"-->
<!-- TMPL_VAR default = "value" "var" -->
<!--TMPL_VAR default="value"name=-->
<!-- TMPL_VAR default = "value" name = -->
<!--TMPL_VAR default="value"="var"-->
<!-- TMPL_VAR default = "value" = "var" -->
<!--TMPL_VAR default="value"name=*-->         * needs quotes
<!-- TMPL_VAR default = "value" name = * -->   * needs quotes
<!--TMPL_VAR default="value"name="var-->
<!-- TMPL_VAR default = "value" name = "var -->
<!--TMPL_VAR default="value"name='var-->
<!-- TMPL_VAR default = "value" name = 'var -->
<!--TMPL_VAR default="value"name=var"-->
<!-- TMPL_VAR default = "value" name = var" -->
<!--TMPL_VAR default="value"name=var'-->
<!-- TMPL_VAR default = "value" name = var' -->
<!--TMPL_VAR default="value"name="var'-->
<!-- TMPL_VAR default = "value" name = "var' -->
<!--TMPL_VAR default="value"name='var"-->
<!-- TMPL_VAR default = "value" name = 'var" -->

Testing bad attribute followed by good

<TMPL_VAR namedefault="value">
<TMPL_VAR name default = "value" >
<TMPL_VAR =default="value">
<TMPL_VAR = default = "value" >
<TMPL_VAR "var"default="value">
<TMPL_VAR "var" default = "value" >
<TMPL_VAR name=default="value">
<TMPL_VAR name = default = "value" >
<TMPL_VAR ="var"default="value">
<TMPL_VAR = "var" default = "value" >
<TMPL_VAR name=*default="value">         * needs quotes
<TMPL_VAR name = * default = "value" >   * needs quotes
<TMPL_VAR name="vardefault="value">
<TMPL_VAR name = "var default = "value" >
<TMPL_VAR name='vardefault="value">
<TMPL_VAR name = 'var default = "value" >
<TMPL_VAR name=var"default="value">
<TMPL_VAR name = var" default = "value" >
<TMPL_VAR name=var'default="value">
<TMPL_VAR name = var' default = "value" >
<TMPL_VAR name="var'default="value">
<TMPL_VAR name = "var' default = "value" >
<TMPL_VAR name='var"default="value">
<TMPL_VAR name = 'var" default = "value" >

<TMPL_VAR namedefault="value"/>
<TMPL_VAR name default = "value" />
<TMPL_VAR =default="value"/>
<TMPL_VAR = default = "value" />
<TMPL_VAR "var"default="value"/>
<TMPL_VAR "var" default = "value" />
<TMPL_VAR name=default="value"/>
<TMPL_VAR name = default = "value" />
<TMPL_VAR ="var"default="value"/>
<TMPL_VAR = "var" default = "value" />
<TMPL_VAR name=*default="value"/>         * needs quotes
<TMPL_VAR name = * default = "value" />   * needs quotes
<TMPL_VAR name="vardefault="value"/>
<TMPL_VAR name = "var default = "value" />
<TMPL_VAR name='vardefault="value"/>
<TMPL_VAR name = 'var default = "value" />
<TMPL_VAR name=var"default="value"/>
<TMPL_VAR name = var" default = "value" />
<TMPL_VAR name=var'default="value"/>
<TMPL_VAR name = var' default = "value" />
<TMPL_VAR name="var'default="value"/>
<TMPL_VAR name = "var' default = "value" />
<TMPL_VAR name='var"default="value"/>
<TMPL_VAR name = 'var" default = "value" />

<!--TMPL_VAR namedefault="value"-->
<!-- TMPL_VAR name default = "value" -->
<!--TMPL_VAR =default="value"-->
<!-- TMPL_VAR = default = "value" -->
<!--TMPL_VAR "var"default="value"-->
<!-- TMPL_VAR "var" default = "value" -->
<!--TMPL_VAR name=default="value"-->
<!-- TMPL_VAR name = default = "value" -->
<!--TMPL_VAR ="var"default="value"-->
<!-- TMPL_VAR = "var" default = "value" -->
<!--TMPL_VAR name=*default="value"-->         * needs quotes
<!-- TMPL_VAR name = * default = "value" -->   * needs quotes
<!--TMPL_VAR name="vardefault="value"-->
<!-- TMPL_VAR name = "var default = "value" -->
<!--TMPL_VAR name='vardefault="value"-->
<!-- TMPL_VAR name = 'var default = "value" -->
<!--TMPL_VAR name=var"default="value"-->
<!-- TMPL_VAR name = var" default = "value" -->
<!--TMPL_VAR name=var'default="value"-->
<!-- TMPL_VAR name = var' default = "value" -->
<!--TMPL_VAR name="var'default="value"-->
<!-- TMPL_VAR name = "var' default = "value" -->
<!--TMPL_VAR name='var"default="value"-->
<!-- TMPL_VAR name = 'var" default = "value" -->
EOF

cp tmplfile expected

template tmplfile > result 2> /dev/null

check

TEST=5  ########################################

# Testing tags with unsupported/missing/duplicated attribute names,
# which we consider ordinary text

cat << "EOF" > tmplfile
<TMPL_LOOP>
<TMPL_LOOP >
<TMPL_LOOP nam = "var">
<TMPL_LOOP namex = "var">
<TMPL_LOOP color = "red">
<TMPL_LOOP name = "var" name = "var">
<TMPL_LOOP name = "var" name = "var2">
<TMPL_LOOP name = "var" default = "value">
<TMPL_LOOP name = "var" fmt = "fmtname">
<TMPL_LOOP name = "var" value = "testvalue">

<!--TMPL_LOOP-->
<!-- TMPL_LOOP -->
<!--TMPL_LOOP nam = "var"-->
<!--TMPL_LOOP namex = "var"-->
<!--TMPL_LOOP color = "red"-->
<!--TMPL_LOOP name = "var" name = "var"-->
<!--TMPL_LOOP name = "var" name = "var2"-->
<!--TMPL_LOOP name = "var" default = "value"-->
<!--TMPL_LOOP name = "var" fmt = "fmtname"-->
<!--TMPL_LOOP name = "var" value = "testvalue"-->

<TMPL_INCLUDE>
<TMPL_INCLUDE >
<TMPL_INCLUDE nam = "var">
<TMPL_INCLUDE namex = "var">
<TMPL_INCLUDE color = "red">
<TMPL_INCLUDE name = "var" name = "var">
<TMPL_INCLUDE name = "var" name = "var2">
<TMPL_INCLUDE name = "var" default = "value">
<TMPL_INCLUDE name = "var" fmt = "fmtname">
<TMPL_INCLUDE name = "var" value = "testvalue">

<TMPL_INCLUDE/>
<TMPL_INCLUDE />
<TMPL_INCLUDE nam = "var" />
<TMPL_INCLUDE namex = "var" />
<TMPL_INCLUDE color = "red" />
<TMPL_INCLUDE name = "var" name = "var"/>
<TMPL_INCLUDE name = "var" name = "var2" />
<TMPL_INCLUDE name = "var" default = "value"/>
<TMPL_INCLUDE name = "var" fmt = "fmtname" />
<TMPL_INCLUDE name = "var" value = "testvalue" />

<!--TMPL_INCLUDE-->
<!-- TMPL_INCLUDE -->
<!--TMPL_INCLUDE nam = "var"-->
<!--TMPL_INCLUDE namex = "var"-->
<!--TMPL_INCLUDE color = "red"-->
<!--TMPL_INCLUDE name = "var" name = "var"-->
<!--TMPL_INCLUDE name = "var" name = "var2"-->
<!--TMPL_INCLUDE name = "var" default = "value"-->
<!--TMPL_INCLUDE name = "var" fmt = "fmtname"-->
<!--TMPL_INCLUDE name = "var" value = "testvalue"-->

<TMPL_VAR>
<TMPL_VAR >
<TMPL_VAR nam = "var">
<TMPL_VAR namex = "var">
<TMPL_VAR color = "red">
<TMPL_VAR default = "value">
<TMPL_VAR fmt = "fmtname">
<TMPL_VAR default = "value" fmt = "fmtname">
<TMPL_VAR name = "var" value = "testvalue">
<TMPL_VAR name = "var" color = "red">
<TMPL_VAR name = "var" default = "value" fmt = "fmtname" name = "var">
<TMPL_VAR name = "var" default = "value" fmt = "fmtname" name = "xxx">
<TMPL_VAR default = "xxx" name = "var" default = "value" fmt = "fmtname">
<TMPL_VAR fmt = "xxx" name = "var" default = "value" fmt = "fmtname">

<TMPL_VAR/>
<TMPL_VAR />
<TMPL_VAR nam = "var" />
<TMPL_VAR namex = "var" />
<TMPL_VAR color = "red" />
<TMPL_VAR default = "value" />
<TMPL_VAR fmt = "fmtname" />
<TMPL_VAR default = "value" fmt = "fmtname" />
<TMPL_VAR name = "var" value = "testvalue"/>
<TMPL_VAR name = "var" color = "red" />
<TMPL_VAR name = "var" default = "value" fmt = "fmtname" name = "var" />
<TMPL_VAR name = "var" default = "value" fmt = "fmtname" name = "xxx"/>
<TMPL_VAR default = "xxx" name = "var" default = "value" fmt = "fmtname" />
<TMPL_VAR fmt = "xxx" name = "var" default = "value" fmt = "fmtname"/>

<!--TMPL_VAR-->
<!-- TMPL_VAR -->
<!--TMPL_VAR nam = "var"-->
<!--TMPL_VAR namex = "var"-->
<!--TMPL_VAR color = "red"-->
<!--TMPL_VAR default = "value"-->
<!--TMPL_VAR fmt = "fmtname"-->
<!--TMPL_VAR default = "value" fmt = "fmtname"-->
<!--TMPL_VAR name = "var" value = "testvalue"-->
<!--TMPL_VAR name = "var" color = "red"-->
<!--TMPL_VAR name = "var" default = "value" fmt = "fmtname" name = "var"-->
<!--TMPL_VAR name = "var" default = "value" fmt = "fmtname" name = "xxx"-->
<!--TMPL_VAR default = "xxx" name = "var" default = "value" fmt = "fmtname"-->
<!--TMPL_VAR fmt = "xxx" name = "var" default = "value" fmt = "fmtname"-->

<TMPL_IF>
<TMPL_IF >
<TMPL_IF nam = "var">
<TMPL_IF namex = "var">
<TMPL_IF color = "red">
<TMPL_IF value = "testvalue">
<TMPL_IF name = "var" default = "value">
<TMPL_IF name = "var" fmt = "fmtname">
<TMPL_IF name = "var" color = "red">
<TMPL_IF name = "var" value = "testvalue" name = "var">
<TMPL_IF name = "var" value = "testvalue" name = "xxx">
<TMPL_IF value = "xxx" name = "var" value = "testvalue">

<!--TMPL_IF-->
<!-- TMPL_IF -->
<!--TMPL_IF nam = "var"-->
<!--TMPL_IF namex = "var"-->
<!--TMPL_IF color = "red"-->
<!--TMPL_IF value = "testvalue"-->
<!--TMPL_IF name = "var" default = "value"-->
<!--TMPL_IF name = "var" fmt = "fmtname"-->
<!--TMPL_IF name = "var" color = "red"-->
<!--TMPL_IF name = "var" value = "testvalue" name = "var"-->
<!--TMPL_IF name = "var" value = "testvalue" name = "xxx"-->
<!--TMPL_IF value = "xxx" name = "var" value = "testvalue"-->

<TMPL_ELSIF>
<TMPL_ELSIF >
<TMPL_ELSIF nam = "var">
<TMPL_ELSIF namex = "var">
<TMPL_ELSIF color = "red">
<TMPL_ELSIF value = "testvalue">
<TMPL_ELSIF name = "var" default = "value">
<TMPL_ELSIF name = "var" fmt = "fmtname">
<TMPL_ELSIF name = "var" color = "red">
<TMPL_ELSIF name = "var" value = "testvalue" name = "var">
<TMPL_ELSIF name = "var" value = "testvalue" name = "xxx">
<TMPL_ELSIF value = "xxx" name = "var" value = "testvalue">

<TMPL_ELSIF/>
<TMPL_ELSIF />
<TMPL_ELSIF nam = "var" />
<TMPL_ELSIF namex = "var" />
<TMPL_ELSIF color = "red" />
<TMPL_ELSIF value = "testvalue"/>
<TMPL_ELSIF name = "var" default = "value"/>
<TMPL_ELSIF name = "var" fmt = "fmtname" />
<TMPL_ELSIF name = "var" color = "red"/>
<TMPL_ELSIF name = "var" value = "testvalue" name = "var" />
<TMPL_ELSIF name = "var" value = "testvalue" name = "xxx"/>
<TMPL_ELSIF value = "xxx" name = "var" value = "testvalue" />

<!--TMPL_ELSIF-->
<!-- TMPL_ELSIF -->
<!--TMPL_ELSIF nam = "var"-->
<!--TMPL_ELSIF namex = "var"-->
<!--TMPL_ELSIF color = "red"-->
<!--TMPL_ELSIF value = "testvalue"-->
<!--TMPL_ELSIF name = "var" default = "value"-->
<!--TMPL_ELSIF name = "var" fmt = "fmtname"-->
<!--TMPL_ELSIF name = "var" color = "red"-->
<!--TMPL_ELSIF name = "var" value = "testvalue" name = "var"-->
<!--TMPL_ELSIF name = "var" value = "testvalue" name = "xxx"-->
<!--TMPL_ELSIF value = "xxx" name = "var" value = "testvalue"-->

<TMPL_ELSE name = "var">
<TMPL_ELSE color = "red">
<TMPL_ELSE name = "var" value = "testvalue">
<TMPL_ELSE name = "var" fmt = "fmtname">
<TMPL_ELSE name = "var" default = "value">

<TMPL_ELSE name = "var" />
<TMPL_ELSE color = "red"/>
<TMPL_ELSE name = "var" value = "testvalue" />
<TMPL_ELSE name = "var" fmt = "fmtname"/>
<TMPL_ELSE name = "var" default = "value" />

<!--TMPL_ELSE name = "var"-->
<!--TMPL_ELSE color = "red"-->
<!--TMPL_ELSE name = "var" value = "testvalue"-->
<!--TMPL_ELSE name = "var" fmt = "fmtname"-->
<!--TMPL_ELSE name = "var" default = "value"-->

</TMPL_IF name = "var">
</TMPL_IF color = "red">
</TMPL_IF name = "var" value = "testvalue">
</TMPL_IF name = "var" fmt = "fmtname">
</TMPL_IF name = "var" default = "value">

<!--/TMPL_IF name = "var"-->
<!--/TMPL_IF color = "red"-->
<!--/TMPL_IF name = "var" value = "testvalue"-->
<!--/TMPL_IF name = "var" fmt = "fmtname"-->
<!--/TMPL_IF name = "var" default = "value"-->

</TMPL_LOOP name = "var">
</TMPL_LOOP color = "red">
</TMPL_LOOP name = "var" value = "testvalue">
</TMPL_LOOP name = "var" fmt = "fmtname">
</TMPL_LOOP name = "var" default = "value">

<!--/TMPL_LOOP name = "var"-->
<!--/TMPL_LOOP color = "red"-->
<!--/TMPL_LOOP name = "var" value = "testvalue"-->
<!--/TMPL_LOOP name = "var" fmt = "fmtname"-->
<!--/TMPL_LOOP name = "var" default = "value"-->

<TMPL_BREAK lev = 1>
<TMPL_BREAK levelx = 1>
<TMPL_BREAK color = "red">
<TMPL_BREAK value = "testvalue">
<TMPL_BREAK level = "1" default = "value">
<TMPL_BREAK level = "2" fmt = "fmtname">
<TMPL_BREAK level = 1 name = "var">
<TMPL_BREAK level = 1 color = "red">
<TMPL_BREAK level = 1 level = 1>
<TMPL_BREAK name = "var" level = "1" >

<TMPL_BREAK lev = 1/>
<TMPL_BREAK levelx = 1/>
<TMPL_BREAK color = "red"/>
<TMPL_BREAK value = "testvalue"/>
<TMPL_BREAK level = "1" default = "value"/>
<TMPL_BREAK level = "2" fmt = "fmtname"/>
<TMPL_BREAK level = 1 name = "var"/>
<TMPL_BREAK level = 1 color = "red"/>
<TMPL_BREAK level = 1 level = 1/>
<TMPL_BREAK name = "var" level = "1" />

<!-- TMPL_BREAK lev = 1 -->
<!-- TMPL_BREAK levelx = 1 -->
<!-- TMPL_BREAK color = "red" -->
<!-- TMPL_BREAK value = "testvalue" -->
<!-- TMPL_BREAK level = "1" default = "value" -->
<!-- TMPL_BREAK level = "2" fmt = "fmtname" -->
<!-- TMPL_BREAK level = 1 name = "var" -->
<!-- TMPL_BREAK level = 1 color = "red" -->
<!-- TMPL_BREAK level = 1 level = 1 -->
<!-- TMPL_BREAK name = "var" level = "1"  -->

<TMPL_CONTINUE lev = 1>
<TMPL_CONTINUE levelx = 1>
<TMPL_CONTINUE color = "red">
<TMPL_CONTINUE value = "testvalue">
<TMPL_CONTINUE level = "1" default = "value">
<TMPL_CONTINUE level = "2" fmt = "fmtname">
<TMPL_CONTINUE level = 1 name = "var">
<TMPL_CONTINUE level = 1 color = "red">
<TMPL_CONTINUE level = 1 level = 1>
<TMPL_CONTINUE name = "var" level = "1" >

<TMPL_CONTINUE lev = 1/>
<TMPL_CONTINUE levelx = 1/>
<TMPL_CONTINUE color = "red"/>
<TMPL_CONTINUE value = "testvalue"/>
<TMPL_CONTINUE level = "1" default = "value"/>
<TMPL_CONTINUE level = "2" fmt = "fmtname"/>
<TMPL_CONTINUE level = 1 name = "var"/>
<TMPL_CONTINUE level = 1 color = "red"/>
<TMPL_CONTINUE level = 1 level = 1/>
<TMPL_CONTINUE name = "var" level = "1" />

<!-- TMPL_CONTINUE lev = 1 -->
<!-- TMPL_CONTINUE levelx = 1 -->
<!-- TMPL_CONTINUE color = "red" -->
<!-- TMPL_CONTINUE value = "testvalue" -->
<!-- TMPL_CONTINUE level = "1" default = "value" -->
<!-- TMPL_CONTINUE level = "2" fmt = "fmtname" -->
<!-- TMPL_CONTINUE level = 1 name = "var" -->
<!-- TMPL_CONTINUE level = 1 color = "red" -->
<!-- TMPL_CONTINUE level = 1 level = 1 -->
<!-- TMPL_CONTINUE name = "var" level = "1"  -->

EOF

cp tmplfile expected

template tmplfile > result 2> /dev/null

check

TEST=6  ########################################

# Testing tags with illegal white space, which we consider ordinary text

cat << "EOF" > tmplfile

< TMPL_VAR name = "var">
<TMPL_VARname = "var">
< TMPL_VAR name = "var" />
<TMPL_VARname = "var"/>
< TMPL_VARname = "var">
< !--TMPL_VAR name = "var"-->
<! --TMPL_VAR name = "var"-->
<!- -TMPL_VAR name = "var"-->
<!--TMPL_VAR name = var-->
<!--TMPL_VAR name = "var"- ->
<!--TMPL_VAR name = "var"-- >
<!--TMPL_VARname = "var"-->
<!-- TMPL_VARname = "var"-->

< TMPL_INCLUDE name = "var">
<TMPL_INCLUDEname = "var">
< TMPL_INCLUDE name = "var" />
<TMPL_INCLUDEname = "var"/>
< !--TMPL_INCLUDE name = "var"-->
<! --TMPL_INCLUDE name = "var"-->
<!- -TMPL_INCLUDE name = "var"-->
<!--TMPL_INCLUDE name = "var"- ->
<!--TMPL_INCLUDE name = "var"-- >
< TMPL_INCLUDEname = "var">
<!--TMPL_INCLUDEname = "var"-->
<!-- TMPL_INCLUDEname = "var"-->

< TMPL_LOOP name = "var">
<TMPL_LOOPname = "var">
< TMPL_LOOPname = "var">
< !--TMPL_LOOP name = "var"-->
<! --TMPL_LOOP name = "var"-->
<!- -TMPL_LOOP name = "var"-->
<!--TMPL_LOOP name = var-->
<!--TMPL_LOOP name = "var"- ->
<!--TMPL_LOOP name = "var"-- >
<!--TMPL_LOOPname = "var"-->
<!-- TMPL_LOOPname = "var"-->

< TMPL_IF name = "var">
<TMPL_IFname = "var">
< TMPL_IFname = "var">
< !--TMPL_IF name = "var"-->
<! --TMPL_IF name = "var"-->
<!- -TMPL_IF name = "var"-->
<!--TMPL_IF name = var-->
<!--TMPL_IF name = "var"- ->
<!--TMPL_IF name = "var"-- >
<!--TMPL_IFname = "var"-->
<!-- TMPL_IFname = "var"-->

< TMPL_ELSIF name = "var">
<TMPL_ELSIFname = "var">
< TMPL_ELSIFname = "var">
< TMPL_ELSIF name = "var" />
<TMPL_ELSIFname = "var"/>
< TMPL_ELSIFname = "var" />
< !--TMPL_ELSIF name = "var"-->
<! --TMPL_ELSIF name = "var"-->
<!- -TMPL_ELSIF name = "var"-->
<!--TMPL_ELSIF name = var-->
<!--TMPL_ELSIF name = "var"- ->
<!--TMPL_ELSIF name = "var"-- >
<!--TMPL_ELSIFname = "var"-->
<!-- TMPL_ELSIFname = "var"-->

< TMPL_ELSE>
< TMPL_ELSE >
< TMPL_ELSE/>
< TMPL_ELSE />
< !--TMPL_ELSE-->
<! --TMPL_ELSE-->
<!- -TMPL_ELSE-->
<!--TMPL_ELSE- ->
<!--TMPL_ELSE-- >

< /TMPL_IF>
< /TMPL_IF >
</ TMPL_IF>
</ TMPL_IF >
< !--/TMPL_IF-->
<! --/TMPL_IF-->
<!- -/TMPL_IF-->
<!--/TMPL_IF- ->
<!--/TMPL_IF-- >
<!--/ TMPL_IF-->
<!-- / TMPL_IF -->

< /TMPL_LOOP>
< /TMPL_LOOP >
</ TMPL_LOOP>
</ TMPL_LOOP >
< !--/TMPL_LOOP-->
<! --/TMPL_LOOP-->
<!- -/TMPL_LOOP-->
<!--/TMPL_LOOP- ->
<!--/TMPL_LOOP-- >
<!--/ TMPL_LOOP-->
<!-- / TMPL_LOOP -->

< TMPL_BREAK>
< TMPL_BREAK level=1>
<TMPL_BREAKlevel=1>
< TMPL_BREAK />
< TMPL_BREAK level=1/>
<TMPL_BREAKlevel=1/>
< !--TMPL_BREAK -->
< !--TMPL_BREAK level=1 -->
<! --TMPL_BREAK -->
<! --TMPL_BREAK level = "1"-->
<!- -TMPL_BREAK -->
<!- -TMPL_BREAK level = 1 -->
<!--TMPL_BREAK - ->
<!--TMPL_BREAK level = "1"- ->
<!--TMPL_BREAK-- >
<!--TMPL_BREAK level = "1"-- >
<!--TMPL_BREAK level=1-->
<!--TMPL_BREAKlevel=1 -->
<!-- TMPL_BREAKlevel=1 -->

< TMPL_CONTINUE>
< TMPL_CONTINUE level=1>
<TMPL_CONTINUElevel=1>
< TMPL_CONTINUE />
< TMPL_CONTINUE level=1/>
<TMPL_CONTINUElevel=1/>
< !--TMPL_CONTINUE -->
< !--TMPL_CONTINUE level=1 -->
<! --TMPL_CONTINUE -->
<! --TMPL_CONTINUE level = "1"-->
<!- -TMPL_CONTINUE -->
<!- -TMPL_CONTINUE level = 1 -->
<!--TMPL_CONTINUE - ->
<!--TMPL_CONTINUE level = "1"- ->
<!--TMPL_CONTINUE-- >
<!--TMPL_CONTINUE level = "1"-- >
<!--TMPL_CONTINUE level=1-->
<!--TMPL_CONTINUElevel=1 -->
<!-- TMPL_CONTINUElevel=1 -->

EOF

cp tmplfile expected

template tmplfile > result 2> /dev/null

check

TEST=7  ########################################

# Testing tags with incorrect delimiters, which we consider ordinary text

cat << "EOF" > tmplfile

<TMPL_VAR name = "var"-->
<TMPL_VAR name = "var" -->
<!--TMPL_VAR name = "var">
<!-- TMPL_VAR name = "var" >
<!--TMPL_VAR name = "var"/>
<!-- TMPL_VAR name = "var" />

<TMPL_INCLUDE name = "var"-->
<TMPL_INCLUDE name = "var" -->
<!--TMPL_INCLUDE name = "var">
<!-- TMPL_INCLUDE name = "var" >
<!--TMPL_INCLUDE name = "var"/>
<!-- TMPL_INCLUDE name = "var" />

<TMPL_LOOP name = "var"/>
<TMPL_LOOP name = "var" />
<TMPL_LOOP name = "var"-->
<TMPL_LOOP name = "var" -->
<!--TMPL_LOOP name = "var">
<!-- TMPL_LOOP name = "var" >

<TMPL_IF name = "var"/>
<TMPL_IF name = "var" />
<TMPL_IF name = "var"-->
<TMPL_IF name = "var" -->
<!--TMPL_IF name = "var">
<!-- TMPL_IF name = "var" >

<TMPL_ELSIF name = "var"-->
<TMPL_ELSIF name = "var" -->
<!--TMPL_ELSIF name = "var">
<!-- TMPL_ELSIF name = "var" >
<!--TMPL_ELSIF name = "var"/>
<!-- TMPL_ELSIF name = "var" />

<TMPL_ELSE-->
<TMPL_ELSE -->
<!--TMPL_ELSE>
<!-- TMPL_ELSE >
<!--TMPL_ELSE/>
<!-- TMPL_ELSE />

</TMPL_IF/>
</TMPL_IF />
</TMPL_IF-->
</TMPL_IF -->
<!--/TMPL_IF>
<!-- /TMPL_IF >

</TMPL_LOOP/>
</TMPL_LOOP />
</TMPL_LOOP-->
</TMPL_LOOP -->
<!--/TMPL_LOOP>
<!-- /TMPL_LOOP >

<TMPL_BREAK-->
<TMPL_BREAK -->
<!--TMPL_BREAK>
<!-- TMPL_BREAK >
<!--TMPL_BREAK/>
<!-- TMPL_BREAK />
<TMPL_BREAK level="2"-->
<TMPL_BREAK level="2" -->
<!--TMPL_BREAK level=2>
<!-- TMPL_BREAK level=2>
<!--TMPL_BREAK level=2 />
<!-- TMPL_BREAK level=2 />

<TMPL_CONTINUE-->
<TMPL_CONTINUE -->
<!--TMPL_CONTINUE>
<!-- TMPL_CONTINUE >
<!--TMPL_CONTINUE/>
<!-- TMPL_CONTINUE />
<TMPL_CONTINUE level="2"-->
<TMPL_CONTINUE level="2" -->
<!--TMPL_CONTINUE level=2>
<!-- TMPL_CONTINUE level=2>
<!--TMPL_CONTINUE level=2 />
<!-- TMPL_CONTINUE level=2 />
EOF

cp tmplfile expected

template tmplfile > result 2> /dev/null

check

TEST=8  ########################################

# Testing TMPL_VAR tag with just "name =" attribute

cat << "EOF" > tmplfile

X<TMPL_VAR name="bogus">X
X<TMPL_VAR name ="bogus">X
X<TMPL_VAR name= "bogus">X
X<TMPL_VAR name="bogus" >X
X<TMPL_VAR name = "bogus" >X
X<TMPL_VAR     name      =      "bogus"    >X
X<TMPL_VAR
  name
  =
  "bogus"
  >X
X<TMPL_VAR name = "bogus"><TMPL_VAR name = "bogus">X
X<TmPl_vAr NaMe = "bogus">X

X<TMPL_VAR name="bogus"/>X
X<TMPL_VAR name ="bogus"/>X
X<TMPL_VAR name= "bogus"/>X
X<TMPL_VAR name="bogus" />X
X<TMPL_VAR name = "bogus" />X
X<TMPL_VAR     name      =      "bogus"    />X
X<TMPL_VAR
  name
  =
  "bogus"
  />X
X<TMPL_VAR name = "bogus"/><TMPL_VAR name = "bogus"/>X
X<TmPl_vAr NaMe = "bogus"/>X

X<!--TMPL_VAR name="bogus"-->X
X<!-- TMPL_VAR name="bogus"-->X
X<!--TMPL_VAR name ="bogus"-->X
X<!--TMPL_VAR name= "bogus"-->X
X<!--TMPL_VAR name="bogus" -->X
X<!-- TMPL_VAR name = "bogus" -->X
X<!--   TMPL_VAR     name      =      "bogus"    -->X
X<!--
  TMPL_VAR
  name
  =
  "bogus"
  -->X
X<!--TMPL_VAR name = "bogus"--><!--TMPL_VAR name = "bogus"-->X
X<!--TmPl_vAr NaMe = "bogus"-->X

X<TMPL_VAR name="var">X
X<TMPL_VAR name ="var">X
X<TMPL_VAR name= "var">X
X<TMPL_VAR name="var" >X
X<TMPL_VAR name = "var" >X
X<TMPL_VAR     name      =      "var"    >X
X<TMPL_VAR
  name
  =
  "var"
  >X
X<TMPL_VAR name = "var"><TMPL_VAR name = "var">X
X<TmPl_vAr NaMe = "var">X

X<TMPL_VAR name="var"/>X
X<TMPL_VAR name ="var"/>X
X<TMPL_VAR name= "var"/>X
X<TMPL_VAR name="var" />X
X<TMPL_VAR name = "var" />X
X<TMPL_VAR     name      =      "var"    />X
X<TMPL_VAR
  name
  =
  "var"
  />X
X<TMPL_VAR name = "var"/><TMPL_VAR name = "var"/>X
X<TmPl_vAr NaMe = "var"/>X

X<!--TMPL_VAR name="var"-->X
X<!-- TMPL_VAR name="var"-->X
X<!--TMPL_VAR name ="var"-->X
X<!--TMPL_VAR name= "var"-->X
X<!--TMPL_VAR name="var" -->X
X<!-- TMPL_VAR name = "var" -->X
X<!--    TMPL_VAR     name      =      "var"    -->X
X<!--
  TMPL_VAR
  name
  =
  "var"
  -->X
X<!--TMPL_VAR name = "var"--><!--TMPL_VAR name = "var"-->X
X<!--TmPl_vAr NaMe = "var"-->X

X<TMPL_VAR name = "var"><TMPL_VAR name = "bogus">X
X<TMPL_VAR name = "bogus"><TMPL_VAR name = "var">X

X<TMPL_VAR name =
  "This variable has an extremely long, but nevertheless legal, name">X

EOF

cat << "EOF" > expected

XX
XX
XX
XX
XX
XX
XX
XX
XX

XX
XX
XX
XX
XX
XX
XX
XX
XX

XX
XX
XX
XX
XX
XX
XX
XX
XX
XX

XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvaluetestvalueX
XtestvalueX

XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvaluetestvalueX
XtestvalueX

XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvaluetestvalueX
XtestvalueX

XtestvalueX
XtestvalueX

Xvariable with long nameX

EOF

template tmplfile var testvalue \
  "This variable has an extremely long, but nevertheless legal, name" \
  "variable with long name" > result 2>&1

check

TEST=9  ########################################

# Testing tmpl_var tag with "default=" attribute

cat << "EOF" > tmplfile

X<TMPL_VAR name="bogus"default="DEFAULT">X
X<TMPL_VAR name ="bogus"default="DEFAULT">X
X<TMPL_VAR name= "bogus"default="DEFAULT">X
X<TMPL_VAR name="bogus" default="DEFAULT">X
X<TMPL_VAR name="bogus"default ="DEFAULT">X
X<TMPL_VAR name="bogus"default= "DEFAULT">X
X<TMPL_VAR name="bogus"default="DEFAULT" >X
X<TMPL_VAR   name   =   "bogus"   default   =   "DEFAULT"   >X
X<TMPL_VAR
  name
  =
  "bogus"
  default
  =
  "DEFAULT"
  >X
X<TmPl_VaR nAmE="bogus" DefAUlT="DEFAULT" />X
X<TMPL_VAR default="DEFAULT" name = "bogus"/>X

X<TMPL_VAR name="bogus"default="DEFAULT"/>X
X<TMPL_VAR name ="bogus"default="DEFAULT"/>X
X<TMPL_VAR name= "bogus"default="DEFAULT"/>X
X<TMPL_VAR name="bogus" default="DEFAULT"/>X
X<TMPL_VAR name="bogus"default ="DEFAULT"/>X
X<TMPL_VAR name="bogus"default= "DEFAULT"/>X
X<TMPL_VAR name="bogus"default="DEFAULT" />X
X<TMPL_VAR   name   =   "bogus"   default   =   "DEFAULT"   />X
X<TMPL_VAR
  name
  =
  "bogus"
  default
  =
  "DEFAULT"
  />X
X<TmPl_VaR nAmE="bogus" DefAUlT="DEFAULT" />X
X<TMPL_VAR default="DEFAULT" name = "bogus"/>X

X<!--TMPL_VAR name="bogus"default="DEFAULT"-->X
X<!-- TMPL_VAR name="bogus"default="DEFAULT"-->X
X<!--TMPL_VAR name ="bogus"default="DEFAULT"-->X
X<!--TMPL_VAR name= "bogus"default="DEFAULT"-->X
X<!--TMPL_VAR name="bogus" default="DEFAULT"-->X
X<!--TMPL_VAR name="bogus"default ="DEFAULT"-->X
X<!--TMPL_VAR name="bogus"default= "DEFAULT"-->X
X<!--TMPL_VAR name="bogus"default="DEFAULT" -->X
X<!--  TMPL_VAR   name   =   "bogus"   default   =   "DEFAULT"   -->X
X<!--
  TMPL_VAR
  name
  =
  "bogus"
  default
  =
  "DEFAULT"
  -->X
X<!--TmPl_VaR nAmE="bogus" DefAUlT="DEFAULT"-->X
X<!--TMPL_VAR default="DEFAULT" name = "bogus"-->X

X<TMPL_VAR name="var"default="DEFAULT">X
X<TMPL_VAR name ="var"default="DEFAULT">X
X<TMPL_VAR name= "var"default="DEFAULT">X
X<TMPL_VAR name="var" default="DEFAULT">X
X<TMPL_VAR name="var"default ="DEFAULT">X
X<TMPL_VAR name="var"default= "DEFAULT">X
X<TMPL_VAR name="var"default="DEFAULT" >X
X<TMPL_VAR   name   =   "var"   default   =   "DEFAULT"   >X
X<TMPL_VAR
  name
  =
  "var"
  default
  =
  "DEFAULT"
  >X
X<TmPl_VaR nAmE="var" DefAUlT="DEFAULT">X
X<TMPL_VAR default="DEFAULT" name="var">X

X<TMPL_VAR name="var"default="DEFAULT"/>X
X<TMPL_VAR name ="var"default="DEFAULT"/>X
X<TMPL_VAR name= "var"default="DEFAULT"/>X
X<TMPL_VAR name="var" default="DEFAULT"/>X
X<TMPL_VAR name="var"default ="DEFAULT"/>X
X<TMPL_VAR name="var"default= "DEFAULT"/>X
X<TMPL_VAR name="var"default="DEFAULT" />X
X<TMPL_VAR   name   =   "var"   default   =   "DEFAULT"   />X
X<TMPL_VAR
  name
  =
  "var"
  default
  =
  "DEFAULT"
  />X
X<TmPl_VaR nAmE="var" DefAUlT="DEFAULT"/>X
X<TMPL_VAR default="DEFAULT" name="var"/>X

X<!--TMPL_VAR name="var"default="DEFAULT"-->X
X<!-- TMPL_VAR name="var"default="DEFAULT"-->X
X<!--TMPL_VAR name ="var"default="DEFAULT"-->X
X<!--TMPL_VAR name= "var"default="DEFAULT"-->X
X<!--TMPL_VAR name="var" default="DEFAULT"-->X
X<!--TMPL_VAR name="var"default ="DEFAULT"-->X
X<!--TMPL_VAR name="var"default= "DEFAULT"-->X
X<!--TMPL_VAR name="var"default="DEFAULT" -->X
X<!--  TMPL_VAR   name   =   "var"   default   =   "DEFAULT"   -->X
X<!--
  TMPL_VAR
  name
  =
  "var"
  default
  =
  "DEFAULT"
  -->X
X<!--TmPl_VaR nAmE="var" DefAUlT="DEFAULT"-->X
X<!--TMPL_VAR default="DEFAULT" name="var"-->X

EOF

cat << "EOF" > expected

XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX

XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX

XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX
XDEFAULTX

XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX

XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX

XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX
XtestvalueX

EOF

template tmplfile var testvalue > result 2>&1

check

TEST=10  ########################################

# Testing tmpl_var tag with "fmt=" attribute

cat << "EOF" > tmplfile

X<TMPL_VAR name="bogus"fmt="entity">X
X<TMPL_VAR name ="bogus"fmt="entity">X
X<TMPL_VAR name= "bogus"fmt="entity">X
X<TMPL_VAR name="bogus" fmt="entity">X
X<TMPL_VAR name="bogus"fmt ="entity">X
X<TMPL_VAR name="bogus"fmt= "entity">X
X<TMPL_VAR name="bogus"fmt="entity" >X
X<TMPL_VAR   name   =   "bogus"   fmt   =   "entity"   >X
X<TMPL_VAR
  name
  =
  "bogus"
  fmt
  =
  "entity"
  >X
X<TmPl_VaR nAmE="bogus" fMt="entity" >X
X<TMPL_VAR fmt="entity" name = "bogus">X

X<TMPL_VAR name="bogus"fmt="entity"/>X
X<TMPL_VAR name ="bogus"fmt="entity"/>X
X<TMPL_VAR name= "bogus"fmt="entity"/>X
X<TMPL_VAR name="bogus" fmt="entity"/>X
X<TMPL_VAR name="bogus"fmt ="entity"/>X
X<TMPL_VAR name="bogus"fmt= "entity"/>X
X<TMPL_VAR name="bogus"fmt="entity" />X
X<TMPL_VAR   name   =   "bogus"   fmt   =   "entity"   />X
X<TMPL_VAR
  name
  =
  "bogus"
  fmt
  =
  "entity"
  />X
X<TmPl_VaR nAmE="bogus" fMt="entity" />X
X<TMPL_VAR fmt="entity" name = "bogus"/>X

X<!--TMPL_VAR name="bogus"fmt="entity"-->X
X<!-- TMPL_VAR name="bogus"fmt="entity"-->X
X<!--TMPL_VAR name ="bogus"fmt="entity"-->X
X<!--TMPL_VAR name= "bogus"fmt="entity"-->X
X<!--TMPL_VAR name="bogus" fmt="entity"-->X
X<!--TMPL_VAR name="bogus"fmt ="entity"-->X
X<!--TMPL_VAR name="bogus"fmt= "entity"-->X
X<!--TMPL_VAR name="bogus"fmt="entity" -->X
X<!--  TMPL_VAR   name   =   "bogus"   fmt   =   "entity"   -->X
X<!--
  TMPL_VAR
  name
  =
  "bogus"
  fmt
  =
  "entity"
  -->X
X<!--TmPl_VaR nAmE="bogus" FmT="entity"-->X
X<!--TMPL_VAR fmt="entity" name = "bogus"-->X

X<TMPL_VAR name="var"fmt="entity">X
X<TMPL_VAR name ="var"fmt="entity">X
X<TMPL_VAR name= "var"fmt="entity">X
X<TMPL_VAR name="var" fmt="entity">X
X<TMPL_VAR name="var"fmt ="entity">X
X<TMPL_VAR name="var"fmt= "entity">X
X<TMPL_VAR name="var"fmt="entity" >X
X<TMPL_VAR   name   =   "var"   fmt   =   "entity"   >X
X<TMPL_VAR
  name
  =
  "var"
  fmt
  =
  "entity"
  >X
X<TmPl_VaR nAmE="var" fmT="entity">X
X<TMPL_VAR fmt="entity" name="var">X

X<TMPL_VAR name="var"fmt="entity"/>X
X<TMPL_VAR name ="var"fmt="entity"/>X
X<TMPL_VAR name= "var"fmt="entity"/>X
X<TMPL_VAR name="var" fmt="entity"/>X
X<TMPL_VAR name="var"fmt ="entity"/>X
X<TMPL_VAR name="var"fmt= "entity"/>X
X<TMPL_VAR name="var"fmt="entity" />X
X<TMPL_VAR   name   =   "var"   fmt   =   "entity"   />X
X<TMPL_VAR
  name
  =
  "var"
  fmt
  =
  "entity"
  />X
X<TmPl_VaR nAmE="var" fmT="entity"/>X
X<TMPL_VAR fmt="entity" name="var"/>X

X<!--TMPL_VAR name="var"fmt="entity"-->X
X<!-- TMPL_VAR name="var"fmt="entity"-->X
X<!--TMPL_VAR name ="var"fmt="entity"-->X
X<!--TMPL_VAR name= "var"fmt="entity"-->X
X<!--TMPL_VAR name="var" fmt="entity"-->X
X<!--TMPL_VAR name="var"fmt ="entity"-->X
X<!--TMPL_VAR name="var"fmt= "entity"-->X
X<!--TMPL_VAR name="var"fmt="entity" -->X
X<!--  TMPL_VAR   name   =   "var"   fmt   =   "entity"   -->X
X<!--
  TMPL_VAR
  name
  =
  "var"
  fmt
  =
  "entity"
  -->X
X<!--TmPl_VaR nAmE="var" fMt="entity"-->X
X<!--TMPL_VAR fmt="entity" name="var"-->X

EOF

cat << "EOF" > expected

XX
XX
XX
XX
XX
XX
XX
XX
XX
XX
XX

XX
XX
XX
XX
XX
XX
XX
XX
XX
XX
XX

XX
XX
XX
XX
XX
XX
XX
XX
XX
XX
XX
XX

X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X

X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X

X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X

EOF

template tmplfile var '<"test&value">' > result 2>&1

check

TEST=11  ########################################

# Testing TMPL_VAR with "fmt =" and "default ="

cat << "EOF" > tmplfile

X<TMPL_VAR name="var" fmt="entity" default="<<DEFAULT>>">X
X<TMPL_VAR name="var" default="<<DEFAULT>>" fmt="entity">X
X<TMPL_VAR default="<<DEFAULT>>" name="var" fmt="entity">X
X<TMPL_VAR default="<<DEFAULT>>" fmt="entity" name="var">X
X<TMPL_VAR fmt="entity" name="var" default="<<DEFAULT>>">X
X<TMPL_VAR fmt="entity" default="<<DEFAULT>>" name="var">X

X<TMPL_VAR name="var" fmt="entity" default="<<DEFAULT>>"/>X
X<TMPL_VAR name="var" default="<<DEFAULT>>" fmt="entity"/>X
X<TMPL_VAR default="<<DEFAULT>>" name="var" fmt="entity"/>X
X<TMPL_VAR default="<<DEFAULT>>" fmt="entity" name="var"/>X
X<TMPL_VAR fmt="entity" name="var" default="<<DEFAULT>>"/>X
X<TMPL_VAR fmt="entity" default="<<DEFAULT>>" name="var"/>X

X<!--TMPL_VAR name="var" fmt="entity" default="<<DEFAULT>>"-->X
X<!--TMPL_VAR name="var" default="<<DEFAULT>>" fmt="entity"-->X
X<!--TMPL_VAR default="<<DEFAULT>>" name="var" fmt="entity"-->X
X<!--TMPL_VAR default="<<DEFAULT>>" fmt="entity" name="var"-->X
X<!--TMPL_VAR fmt="entity" name="var" default="<<DEFAULT>>"-->X
X<!--TMPL_VAR fmt="entity" default="<<DEFAULT>>" name="var"-->X

X<TMPL_VAR name="bogus" fmt="entity" default="<<DEFAULT>>">X
X<TMPL_VAR name="bogus" default="<<DEFAULT>>" fmt="entity">X
X<TMPL_VAR default="<<DEFAULT>>" name="bogus" fmt="entity">X
X<TMPL_VAR default="<<DEFAULT>>" fmt="entity" name="bogus">X
X<TMPL_VAR fmt="entity" name="bogus" default="<<DEFAULT>>">X
X<TMPL_VAR fmt="entity" default="<<DEFAULT>>" name="bogus">X

X<TMPL_VAR name="bogus" fmt="entity" default="<<DEFAULT>>"/>X
X<TMPL_VAR name="bogus" default="<<DEFAULT>>" fmt="entity"/>X
X<TMPL_VAR default="<<DEFAULT>>" name="bogus" fmt="entity"/>X
X<TMPL_VAR default="<<DEFAULT>>" fmt="entity" name="bogus"/>X
X<TMPL_VAR fmt="entity" name="bogus" default="<<DEFAULT>>"/>X
X<TMPL_VAR fmt="entity" default="<<DEFAULT>>" name="bogus"/>X

X<!--TMPL_VAR name="bogus" fmt="entity" default="<<DEFAULT>>"-->X
X<!--TMPL_VAR name="bogus" default="<<DEFAULT>>" fmt="entity"-->X
X<!--TMPL_VAR default="<<DEFAULT>>" name="bogus" fmt="entity"-->X
X<!--TMPL_VAR default="<<DEFAULT>>" fmt="entity" name="bogus"-->X
X<!--TMPL_VAR fmt="entity" name="bogus" default="<<DEFAULT>>"-->X
X<!--TMPL_VAR fmt="entity" default="<<DEFAULT>>" name="bogus"-->X

EOF

cat << "EOF" > expected

X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X

X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X

X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X

X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X

X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X

X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X
X&lt;&lt;DEFAULT&gt;&gt;X

EOF

template tmplfile var '<"test&value">' > result 2>&1

check

TEST=12  ########################################

# Testing attribute quoting styles with TMPL_VAR

cat << "EOF" > tmplfile

X<TMPL_VAR name="var" fmt="entity" default="DEFAULT">X
X<TMPL_VAR name='var' fmt='entity' default='DEFAULT'>X
X<TMPL_VAR name=var   fmt=entity   default=DEFAULT>X
X<TMPL_VAR name="var" fmt='entity' default=DEFAULT>X
X<TMPL_VAR name=var   fmt="entity" default='DEFAULT'>X

EOF

cat << "EOF" > expected

X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X
X&lt;&quot;test&amp;value&quot;&gt;X

EOF

template tmplfile var '<"test&value">' > result 2>&1

check

TEST=13  ########################################

# Testing TMPL_VAR with undefined format function

cat << "EOF" > tmplfile

<TMPL_VAR name = "var" fmt="entity">
<TMPL_VAR name = "var" fmt="bogus1" />
<TMPL_VAR fmt="entity" name = "var">
<TMPL_VAR fmt="bogus2" name = "var">
<!--



TMPL_VAR



fmt="bogus3"



name="var"



-->

EOF

cat << "EOF" > expected
Ignoring bad TMPL_VAR tag (bad "fmt=" attribute) in file "tmplfile" line 3
Ignoring bad TMPL_VAR tag (bad "fmt=" attribute) in file "tmplfile" line 5
Ignoring bad TMPL_VAR tag (bad "fmt=" attribute) in file "tmplfile" line 10
EOF

template tmplfile var '<"test&value">' > /dev/null 2> result

check

TEST=14  ########################################

# Testing accepted TMPL_LOOP tag syntax

cat << "EOF" > tmplfile

X<TMPL_LOOP name="loop">X</TMPL_LOOP>X
X<TMPL_LOOP name='loop'>X</TMPL_LOOP>X
X<TMPL_LOOP name=loop>X</TMPL_LOOP>X
X<TMPL_LOOP   name  =  "loop"  >X</TMPL_LOOP>X
X<TMPL_LOOP

  name

  =

  "loop"

  >X</TMPL_LOOP>X
X<TmPl_LoOp NaMe = "loop">X</TMPL_LOOP>X

X<!--TMPL_LOOP name="loop"-->X</TMPL_LOOP>X
X<!--TMPL_LOOP name='loop'-->X</TMPL_LOOP>X
X<!--TMPL_LOOP name=loop -->X</TMPL_LOOP>X
X<!--   TMPL_LOOP   name  =  "loop"  -->X</TMPL_LOOP>X
X<!--

  TMPL_LOOP
  
  name

  =

  "loop"

  -->X</TMPL_LOOP>X
X<!--TmPl_LoOp NaMe = "loop"-->X</TMPL_LOOP>X

EOF

cat << "EOF" > expected

XXX
XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX
XXX

EOF

template tmplfile loop { var testvalue } >result 2>&1

check

TEST=15  ########################################

# Testing accepted </TMPL_LOOP> tag syntax

cat << "EOF" > tmplfile

X<TMPL_LOOP name=loop>X</TMPL_LOOP>X
X<TMPL_LOOP name=loop>X</TMPL_LOOP >X
X<TMPL_LOOP name=loop>X</TMPL_LOOP   >X
X<TMPL_LOOP name=loop>X</TMPL_LOOP

>X
X<TMPL_LOOP name=loop>X</tMpL_LooP>X

X<TMPL_LOOP name=loop>X<!--/TMPL_LOOP-->X
X<TMPL_LOOP name=loop>X<!-- /TMPL_LOOP -->X
X<TMPL_LOOP name=loop>X<!--   /TMPL_LOOP   -->X
X<TMPL_LOOP name=loop>X<!--


/TMPL_LOOP

-->X
X<TMPL_LOOP name=loop>X<!--/tMpL_lOOp-->X

EOF

cat << "EOF" > expected

XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX

EOF

template tmplfile loop { var testvalue } >result 2>&1

check

TEST=16  ########################################

# Testing accepted TMPL_INCLUDE tag syntax

cp /dev/null inclfile1

cat << "EOF" > tmplfile

X<TMPL_INCLUDE name="inclfile1">X
X<TMPL_INCLUDE name='inclfile1'>X
X<TMPL_INCLUDE name=inclfile1>X
X<TMPL_INCLUDE   name  =  "inclfile1"  >X
X<TMPL_INCLUDE

  name
  
  =

  "inclfile1"

  >X
X<tMPl_InCluDe NAMe="inclfile1">X

X<TMPL_INCLUDE name="inclfile1"/>X
X<TMPL_INCLUDE name='inclfile1'/>X
X<TMPL_INCLUDE name=inclfile1/>X
X<TMPL_INCLUDE   name  =  "inclfile1"  />X
X<TMPL_INCLUDE

  name
  
  =

  "inclfile1"

  />X
X<tMPl_InCluDe NAMe="inclfile1"/>X

X<!--TMPL_INCLUDE name="inclfile1"-->X
X<!--TMPL_INCLUDE name='inclfile1'-->X
X<!--TMPL_INCLUDE name=inclfile1 -->X
X<!--TMPL_INCLUDE   name  =  "inclfile1"  -->X
X<!--

  TMPL_INCLUDE

  name

  =

  "inclfile1"

  -->X
X<!--tMPl_InClUDe NaMe="inclfile1"-->X

EOF

cat << "EOF" > expected

XX
XX
XX
XX
XX
XX

XX
XX
XX
XX
XX
XX

XX
XX
XX
XX
XX
XX

EOF

template tmplfile loop { var testvalue } >result 2>&1

check

TEST=17  ########################################

# Testing accepted TMPL_IF tag syntax

cat << "EOF" > tmplfile

X<TMPL_IF name="var">X</TMPL_IF>X
X<TMPL_IF name='var'>X</TMPL_IF>X
X<TMPL_IF name=var>X</TMPL_IF>X
X<TMPL_IF   name  =  "var"  >X</TMPL_IF>X
X<TMPL_IF

  name

  =

  "var"

  >X</TMPL_IF>X
X<TmPl_if NaMe = "var">X</TMPL_IF>X

X<!--TMPL_IF name="var"-->X</TMPL_IF>X
X<!--TMPL_IF name='var'-->X</TMPL_IF>X
X<!--TMPL_IF name=var -->X</TMPL_IF>X
X<!--   TMPL_IF   name  =  "var"  -->X</TMPL_IF>X
X<!--

  TMPL_IF
  
  name

  =

  "var"

  -->X</TMPL_IF>X
X<!--TmPl_iF NaMe = "var"-->X</TMPL_IF>X

X<TMPL_IF name="var" value="testvalue">X</TMPL_IF>X
X<TMPL_IF name="var" value='testvalue'>X</TMPL_IF>X
X<TMPL_IF name="var" value=testvalue>X</TMPL_IF>X
X<TMPL_IF name=var value=testvalue>X</TMPL_IF>X
X<TMPL_IF   name  =  "var"  value   =  "testvalue"  >X</TMPL_IF>X
X<TMPL_IF

  name

  =

  "var"

  value

  =

  "testvalue"

  >X</TMPL_IF>X
X<TmPl_if NaMe = "var" vAluE="testvalue">X</TMPL_IF>X
X<TMPL_IF value="testvalue" name="var">X</TMPL_IF>X

X<!--TMPL_IF name="var" value="testvalue"-->X</TMPL_IF>X
X<!--TMPL_IF name="var" value='testvalue'-->X</TMPL_IF>X
X<!--TMPL_IF name="var" value=testvalue -->X</TMPL_IF>X
X<!--TMPL_IF name=var value=testvalue -->X</TMPL_IF>X
X<!--TMPL_IF   name  =  "var"  value   =  "testvalue"   -->X</TMPL_IF>X
X<!--
  TMPL_IF

  name

  =

  "var"

  value

  =

  "testvalue"

  -->X</TMPL_IF>X
X<!--TmPl_if NaMe = "var" vAluE="testvalue"-->X</TMPL_IF>X
X<!--TMPL_IF value="testvalue" name="var"-->X</TMPL_IF>X

EOF

cat << "EOF" > expected

XXX
XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX
XXX
XXX
XXX

EOF

template tmplfile var testvalue >result 2>&1

check

TEST=18  ########################################

# Testing accepted TMPL_ELSIF tag syntax

cat << "EOF" > tmplfile

X<TMPL_IF name=x>X<TMPL_ELSIF name="var">X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF name='var'>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF name=var>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF   name  =  "var"  >X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF

  name

  =

  "var"

  >X</TMPL_IF>X
X<TMPL_IF name=x>X<TmPl_ElSif NaMe = "var">X</TMPL_IF>X

X<TMPL_IF name=x>X<TMPL_ELSIF name="var"/>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF name='var'/>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF name=var/>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF   name  =  "var"  />X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF

  name

  =

  "var"

  />X</TMPL_IF>X
X<TMPL_IF name=x>X<TmPl_ElSif NaMe = "var"/>X</TMPL_IF>X

X<TMPL_IF name=x>X<!--TMPL_ELSIF name="var"-->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--TMPL_ELSIF name='var'-->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--TMPL_ELSIF name=var -->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--   TMPL_ELSIF   name  =  "var"  -->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--

  TMPL_ELSIF
  
  name

  =

  "var"

  -->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--TmPl_eLSiF NaMe = "var"-->X</TMPL_IF>X

X<TMPL_IF name=x>X<TMPL_ELSIF name="var" value="testvalue">X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF name="var" value='testvalue'>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF name="var" value=testvalue>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF name=var value=testvalue>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF   name  =  "var"  value   =  "testvalue"  >X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF

  name

  =

  "var"

  value

  =

  "testvalue"

  >X</TMPL_IF>X
X<TMPL_IF name=x>X<TmPl_eLSif NaMe = "var" vAluE="testvalue">X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF value="testvalue" name="var">X</TMPL_IF>X

X<TMPL_IF name=x>X<TMPL_ELSIF name="var" value="testvalue"/>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF name="var" value='testvalue'/>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF name="var" value=testvalue/>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF name=var value=testvalue/>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF   name  =  "var"  value   =  "testvalue"  />X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF

  name

  =

  "var"

  value

  =

  "testvalue"

  />X</TMPL_IF>X
X<TMPL_IF name=x>X<TmPl_eLSif NaMe = "var" vAluE="testvalue"/>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSIF value="testvalue" name="var"/>X</TMPL_IF>X

X<TMPL_IF name=x>X<!--TMPL_ELSIF name="var" value="testvalue"-->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--TMPL_ELSIF name="var" value='testvalue'-->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--TMPL_ELSIF name="var" value=testvalue -->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--TMPL_ELSIF name=var value=testvalue -->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--TMPL_ELSIF   name  =  "var"  value   =  "testvalue"   -->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--
  TMPL_ELSIF

  name

  =

  "var"

  value

  =

  "testvalue"

  -->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--TmPl_ElSif NaMe = "var" vAluE="testvalue"-->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--TMPL_ELSIF value="testvalue" name="var"-->X</TMPL_IF>X

EOF

cat << "EOF" > expected

XXX
XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX
XXX
XXX
XXX

EOF

template tmplfile var testvalue >result 2>&1

check

TEST=19  ########################################

# Testing accepted <TMPL_ELSE> tag syntax

cat << "EOF" > tmplfile

X<TMPL_IF name=x>X<TMPL_ELSE>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSE >X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSE   >X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSE

>X</TMPL_IF>X
X<TMPL_IF name=x>X<tMpL_eLSe>X</TMPL_IF>X

X<TMPL_IF name=x>X<TMPL_ELSE/>X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSE />X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSE   />X</TMPL_IF>X
X<TMPL_IF name=x>X<TMPL_ELSE

/>X</TMPL_IF>X
X<TMPL_IF name=x>X<tMpL_eLSe/>X</TMPL_IF>X

X<TMPL_IF name=x>X<!--TMPL_ELSE-->X</TMPL_IF>X
X<TMPL_IF name=x>X<!-- TMPL_ELSE -->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--   TMPL_ELSE   -->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--

TMPL_ELSE

-->X</TMPL_IF>X
X<TMPL_IF name=x>X<!--tMpL_ElSe-->X</TMPL_IF>X

EOF

cat << "EOF" > expected

XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX

EOF

template tmplfile var testvalue > result 2>&1

check

TEST=20  ########################################

# Testing accepted </TMPL_IF> tag syntax

cat << "EOF" > tmplfile

X<TMPL_IF name=var>X</TMPL_IF>X
X<TMPL_IF name=var>X</TMPL_IF >X
X<TMPL_IF name=var>X</TMPL_IF   >X
X<TMPL_IF name=var>X</TMPL_IF

>X
X<TMPL_IF name=var>X</tMpL_iF>X

X<TMPL_IF name=var>X<!--/TMPL_IF-->X
X<TMPL_IF name=var>X<!-- /TMPL_IF -->X
X<TMPL_IF name=var>X<!--   /TMPL_IF   -->X
X<TMPL_IF name=var>X<!--

/TMPL_IF

-->X
X<TMPL_IF name=var>X<!--/tMpL_If-->X

EOF

cat << "EOF" > expected

XXX
XXX
XXX
XXX
XXX

XXX
XXX
XXX
XXX
XXX

EOF

template tmplfile var testvalue > result 2>&1

check

TEST=21  ########################################

# Testing setting variable multiple times

cat << "EOF" > tmplfile
var1 = <tmpl_var name = "var1">
var2 = <tmpl_var name = "var2">
EOF

cat << "EOF" > expected
var1 = value 4
var2 = value 3
EOF

template tmplfile var1 "value 1" var2 "value 2" var2 "value 3" \
  var1 "value 4" > result 2>&1

check

TEST=22  ########################################

# Testing comments

cat << "EOF" > tmplfile
<*
 * Let's start
 * off with a
 * comment
 *>Before comment<*
  Inside comment
  <TMPL_VAR name = "var">
  </tmpl_if>
  </tmpl_loop>
*>After comment<*
another comment *>
Before comment<*
  testing three comments in a row
*><*
  second comment
  here *><* and a
  third comment
  here*>After comment<*

  And let's finish with a comment
*>
EOF

cat << "EOF" > expected
Before commentAfter comment
Before commentAfter comment
EOF

template tmplfile var testvalue > result 2>&1

check

TEST=23  ########################################

# Testing nested comments, which do not work

cat << "EOF" > tmplfile
Before outer comment
<*
  Begin outer comment
  <TMPL_VAR name = "var">
  Before inner comment
  <* Inside inner comment *>
  After inner comment
  End outer comment
*>
After outer comment
EOF

cat << "EOF" > expected
Before outer comment

  After inner comment
  End outer comment
*>
After outer comment
EOF

template tmplfile var testvalue > result 2>&1

check

TEST=24  ########################################

# Testing file inclusion

cat << "EOF" > inclfile1
Begin include file 1
<tmpl_var name = "var">
End include file 1
EOF

cat << "EOF" > inclfile2
Begin include file 2
Including file 1 from file 2
<tmpl_include name = "./inclfile1">
End include file 2
EOF

cat << "EOF" > tmplfile
Begin template
Including file 1
<TMPL_INCLUDE name="inclfile1">
Including file 2
<TMPL_INCLUDE name = "./inclfile2">
End template
EOF

cat << "EOF" > expected
Begin template
Including file 1
Begin include file 1
testvalue
End include file 1

Including file 2
Begin include file 2
Including file 1 from file 2
Begin include file 1
testvalue
End include file 1

End include file 2

End template
EOF

template tmplfile var testvalue > result 2>&1

check

TEST=25  ########################################

# Testing file inclusion with .../

cat << "EOF" > inclfile1
Begin include file 1
<tmpl_var name = "var">
End include file 1
EOF

cat << "EOF" > inclfile2
Begin include file 2
Including file 1 from file 2
<tmpl_include name = ".../inclfile1">
End include file 2
EOF

cat << "EOF" > tmplfile
Begin template
Including file 1
<TMPL_INCLUDE name=".../inclfile1">
Including file 2
<TMPL_INCLUDE name = ".../inclfile2">
End template
EOF

cat << "EOF" > expected
Begin template
Including file 1
Begin include file 1
testvalue
End include file 1

Including file 2
Begin include file 2
Including file 1 from file 2
Begin include file 1
testvalue
End include file 1

End include file 2

End template
Begin template
Including file 1
Begin include file 1
testvalue
End include file 1

Including file 2
Begin include file 2
Including file 1 from file 2
Begin include file 1
testvalue
End include file 1

End include file 2

End template
EOF

template `pwd`/tmplfile var testvalue > result 2>&1
template tmplfile var testvalue >> result 2>&1

check

TEST=26  ########################################

# Testing direct cyclic file inclusion

cat << "EOF" > tmplfile
Begin template
Including file 1
<TMPL_include name = "inclfile1" >
End template
EOF

cat << "EOF" > inclfile1
Begin include file 1
Including file 1 from file 1
<TMPL_INCLUDE name="inclfile1">
End include file 1
EOF

cat << "EOF" > expected
Ignoring bad TMPL_INCLUDE tag (check for include cycle) in file "inclfile1" line 3
EOF

template tmplfile var testvalue > /dev/null 2> result

check

TEST=27  ########################################

# Testing indirect cyclic file inclusion

cat << "EOF" > inclfile1
Begin include file 1
Including file 2 from file 1
<tmpl_include name = "inclfile2">
End include file 1
EOF

cat << "EOF" > inclfile2
Begin include file 2
Including file 1 from file 2
<tmpl_include name = "./inclfile1">
End include file 2
EOF

cat << "EOF" > tmplfile
Begin template
Including file 1
<TMPL_INCLUDE name="inclfile1">
End template
EOF

cat << "EOF" > expected
Ignoring bad TMPL_INCLUDE tag (check for include cycle) in file "inclfile2" line 3
EOF

template tmplfile var testvalue > /dev/null 2> result

check

TEST=28  ########################################

# Testing include of nonexistent file

cat << "EOF" > tmplfile
Begin template
Including nonexistent file
<tmpl_include name = "non existent file">
End template
EOF

cat << "EOF" > expected
C Template library: failed to read template from file "non existent file"
EOF

template tmplfile var testvalue > /dev/null 2> result

check

TEST=29  ########################################

# Testing bypassing of bad include

cat << "EOF" > tmplfile
Begin template
<tmpl_if name = "bogus">
  Including nonexistent file
  <tmpl_include name = "non existent file">
</tmpl_if>
End template
EOF

cat << "EOF" > expected
Begin template

End template
EOF

template tmplfile var testvalue > result 2>&1

check

TEST=30  ########################################

# Testing \ escapes

cat << "EOF" > tmplfile
\
\
Begin template
This \ is ordinary
Ordinary \\ double
Ordinary \\\ triple
Here is a continued \
line.
At end of line we should have a single \\
At end of line we should have a double \\\
<tmpl_var name = "var">\
<tmpl_var name = "var">\
\
\
\
<tmpl_var name = "var">\
End template
\
\
\
EOF

cat << "EOF" > expected
Begin template
This \ is ordinary
Ordinary \\ double
Ordinary \\\ triple
Here is a continued line.
At end of line we should have a single \
At end of line we should have a double \\
testvaluetestvaluetestvalueEnd template
EOF

template tmplfile var testvalue > result 2>&1

check

TEST=31  ########################################

# Testing \ escapes resulting in null output

cat << "EOF" > tmplfile
\
\
\
<tmpl_var name = "bogus"><*

Inside the comment

*>\
\
\
EOF

cp /dev/null expected

template tmplfile var testvalue > result 2>&1

check

TEST=32  ########################################

# Testing input that results in no output

printf '<*
  Inside the comment
  *><tmpl_var name = "bogus">' > tmplfile

cp /dev/null expected

template tmplfile var testvalue > result 2>&1

check

TEST=33  ########################################

# Testing if statement

cat << "EOF" > tmplfile

Testing simple if statement

X<TMPL_IF name = "var">TRUE</TMPL_IF>X
X<TMPL_IF name = "bogus">TRUE</TMPL_IF>X
X<TMPL_IF name = "null">TRUE</TMPL_IF>X
X<tmpl_if name = "var" value = "">TRUE</tmpl_if>X
X<tmpl_if name = "var" value = "wrong">TRUE</tmpl_if>X
X<tmpl_if name = "var" value = "testvalue">TRUE</tmpl_if>X
X<tmpl_if value = "testvalue" name = "var">TRUE</tmpl_if>X
X<tmpl_if name = "null" value = "">TRUE</tmpl_if>X
X<tmpl_if name = "null" value = "wrong">TRUE</tmpl_if>X
X<tmpl_if name = "bogus" value = "">TRUE</tmpl_if>X
X<tmpl_if name = "bogus" value = "wrong">TRUE</tmpl_if>X
X<tmpl_if name = "var"></tmpl_if>X
X<tmpl_if name = "bogus"></tmpl_if>X

Testing if with else clause

X<TMPL_IF name = "var">TRUE<tmpl_else>FALSE</tmpl_if>X
X<TMPL_IF name = "bogus">TRUE<tmpl_else>FALSE</tmpl_if>X
X<TMPL_IF name = "null">TRUE<tmpl_else>FALSE</tmpl_if>X
X<tmpl_if name = "var" value = "">TRUE<tmpl_else>FALSE</tmpl_if>X
X<tmpl_if name = "var" value = "wrong">TRUE<tmpl_else>FALSE</tmpl_if>X
X<tmpl_if name = "var" value = "testvalue">TRUE<tmpl_else>FALSE</tmpl_if>X
X<tmpl_if value = "testvalue" name = "var">TRUE<tmpl_else>FALSE</tmpl_if>X
X<tmpl_if name = "null" value = "">TRUE<tmpl_else>FALSE</tmpl_if>X
X<tmpl_if name = "null" value = "wrong">TRUE<tmpl_else>FALSE</tmpl_if>X
X<tmpl_if name = "bogus" value = "">TRUE<tmpl_else>FALSE</tmpl_if>X
X<tmpl_if name = "bogus" value = "wrong">TRUE<tmpl_else>FALSE</tmpl_if>X
X<tmpl_if name = "var"><tmpl_else></tmpl_if>X
X<tmpl_if name = "bogus"><tmpl_else></tmpl_if>X

Testing if with elseif clauses

X<TMPL_IF name = "var">
  IF BRANCH
<TMPL_ELSIF name = "var" >
  ELSIF BRANCH 1
<TMPL_ELSIF name = "var" value = "testvalue">
  ELSIF BRANCH 2
<TMPL_ELSE>
  ELSE BRANCH
</TMPL_IF>X

X<TMPL_IF name = "bogus">
  IF BRANCH
<TMPL_ELSIF name = "var" >
  ELSIF BRANCH 1
<TMPL_ELSIF name = "var" value = "testvalue">
  ELSIF BRANCH 2
<TMPL_ELSE>
  ELSE BRANCH
</TMPL_IF>X

X<TMPL_IF name = "bogus">
  IF BRANCH
<TMPL_ELSIF name = "var" value = "wrong">
  ELSIF BRANCH 1
<TMPL_ELSIF value = "testvalue2" name = "var2">
  ELSIF BRANCH 2
<TMPL_ELSE>
  ELSE BRANCH
</TMPL_IF>X

X<TMPL_IF name = "bogus">
  IF BRANCH
<TMPL_ELSIF name = "var" value = "wrong">
  ELSIF BRANCH 1
<TMPL_ELSIF name = "var2" value = "">
  ELSIF BRANCH 2
<TMPL_ELSE>
  ELSE BRANCH
</TMPL_IF>X

X<tmpl_if name = "var"><tmpl_elsif name = "var2"><tmpl_else></tmpl_if>X

Testing nested simple if statements

X<TMPL_IF name = "var">
  Inside IF 1
  X<TMPL_IF name = "var2" value = "testvalue2">
    Inside IF 2
  </tmpl_if>X
</tmpl_if>X

X<TMPL_IF name = "bogus">
  Inside IF 1
  X<TMPL_IF name = "var2" value = "testvalue2">
    Inside IF 2
  </tmpl_if>X
</tmpl_if>X

Testing nested if with else clauses

X<TMPL_IF name = "bogus">
  Inside IF BRANCH 1
  X<TMPL_IF name = "var" value = "testvalue">
    Inside IF BRANCH 2
  </tmpl_else>
    Inside ELSE BRANCH 2
  </tmpl_if>X
<tmpl_else>
  Inside ELSE BRANCH 1
  X<tmpl_if name = "bogus">
    Inside IF BRANCH 3
  <tmpl_else>
    Inside ELSE BRANCH 3
  </tmpl_if>X
</tmpl_if>X

X<TMPL_IF name = "var">
  Inside IF BRANCH 1
  X<TMPL_IF name = "var" value = "wrong">
    Inside IF BRANCH 2
  <tmpl_else>
    Inside ELSE BRANCH 2
  </tmpl_if>X
<tmpl_else>
  Inside ELSE BRANCH 1
  X<tmpl_if name = "bogus">
    Inside IF BRANCH 3
  <tmpl_else>
    Inside ELSE BRANCH 3
  </tmpl_if>X
</tmpl_if>X
EOF

cat << "EOF" > expected

Testing simple if statement

XTRUEX
XX
XX
XX
XX
XTRUEX
XTRUEX
XTRUEX
XX
XTRUEX
XX
XX
XX

Testing if with else clause

XTRUEX
XFALSEX
XFALSEX
XFALSEX
XFALSEX
XTRUEX
XTRUEX
XTRUEX
XFALSEX
XTRUEX
XFALSEX
XX
XX

Testing if with elseif clauses

X
  IF BRANCH
X

X
  ELSIF BRANCH 1
X

X
  ELSIF BRANCH 2
X

X
  ELSE BRANCH
X

XX

Testing nested simple if statements

X
  Inside IF 1
  X
    Inside IF 2
  X
X

XX

Testing nested if with else clauses

X
  Inside ELSE BRANCH 1
  X
    Inside ELSE BRANCH 3
  X
X

X
  Inside IF BRANCH 1
  X
    Inside ELSE BRANCH 2
  X
X
EOF

template tmplfile var testvalue var2 testvalue2 null "" > result 2>&1

check

TEST=34  ########################################

# Testing loop statement

cat << "EOF" > tmplfile
Begin template
var1 = <tmpl_var name = "var1">

X<tmpl_loop name = "loop1"></tmpl_loop>X
X<tmpl_loop name = "bogus"></tmpl_loop>X

X<tmpl_loop name = "loop1">
  var1 = <tmpl_var name = "var1">
  var2 = <tmpl_var name = "var2">
</tmpl_loop>X

X<tmpl_loop name = "bogus">
  var1 = <tmpl_var name = "var1">
  var2 = <tmpl_var name = "var2">
</tmpl_loop>X

X<tmpl_loop name = "var1">
  var1 = <tmpl_var name = "var1">
  var2 = <tmpl_var name = "var2">
</tmpl_loop>X

X<tmpl_loop name = "loop1">
  Begin outer loop
  var1 = <tmpl_var name = "var1">
  var2 = <tmpl_var name = "var2">
  X<tmpl_loop name = "loop1">
    Begin inner loop
    var1 = <tmpl_var name = "var1">
    var2 = <tmpl_var name = "var2">
    End inner loop
  </tmpl_loop>X
  End outer loop
</tmpl_loop>X
End template
EOF

cat << "EOF" > expected
Begin template
var1 = outervalue

XX
XX

X
  var1 = value1
  var2 = value2

  var1 = value3
  var2 = value4

  var1 = value5
  var2 = 

  var1 = outervalue
  var2 = value6
X

XX

XX

X
  Begin outer loop
  var1 = value1
  var2 = value2
  X
    Begin inner loop
    var1 = value1
    var2 = value2
    End inner loop
  
    Begin inner loop
    var1 = value3
    var2 = value4
    End inner loop
  
    Begin inner loop
    var1 = value5
    var2 = 
    End inner loop
  
    Begin inner loop
    var1 = outervalue
    var2 = value6
    End inner loop
  X
  End outer loop

  Begin outer loop
  var1 = value3
  var2 = value4
  X
    Begin inner loop
    var1 = value1
    var2 = value2
    End inner loop
  
    Begin inner loop
    var1 = value3
    var2 = value4
    End inner loop
  
    Begin inner loop
    var1 = value5
    var2 = 
    End inner loop
  
    Begin inner loop
    var1 = outervalue
    var2 = value6
    End inner loop
  X
  End outer loop

  Begin outer loop
  var1 = value5
  var2 = 
  X
    Begin inner loop
    var1 = value1
    var2 = value2
    End inner loop
  
    Begin inner loop
    var1 = value3
    var2 = value4
    End inner loop
  
    Begin inner loop
    var1 = value5
    var2 = 
    End inner loop
  
    Begin inner loop
    var1 = outervalue
    var2 = value6
    End inner loop
  X
  End outer loop

  Begin outer loop
  var1 = outervalue
  var2 = value6
  X
    Begin inner loop
    var1 = value1
    var2 = value2
    End inner loop
  
    Begin inner loop
    var1 = value3
    var2 = value4
    End inner loop
  
    Begin inner loop
    var1 = value5
    var2 = 
    End inner loop
  
    Begin inner loop
    var1 = outervalue
    var2 = value6
    End inner loop
  X
  End outer loop
X
End template
EOF

template tmplfile var1 outervalue \
  loop1 { var1 value1 var2 value2 } { var1 value3 var2 value4 } \
    { var1 value5 } { var2 value6 } > result 2>&1

check

TEST=35  ########################################

# Testing nested loop statements

cat << "EOF" > tmplfile
Begin template
var1 = <tmpl_var name = "var1">

X<tmpl_loop name = "outer">
  Begin outer loop
  var1 = <tmpl_var name = "var1">
  var2 = <tmpl_var name = "var2">
  X<tmpl_loop name = "inner">
    Begin inner loop
    var1 = <tmpl_var name = "var1">
    var2 = <tmpl_var name = "var2">
    var3 = <tmpl_var name = "var3">
    End inner loop
  </tmpl_loop>X
  End outer loop
</tmpl_loop>X
End template
EOF

cat << "EOF" > expected
Begin template
var1 = outervalue

X
  Begin outer loop
  var1 = val1
  var2 = val2
  X
    Begin inner loop
    var1 = val1
    var2 = val3
    var3 = val4
    End inner loop
  
    Begin inner loop
    var1 = val1
    var2 = val5
    var3 = val6
    End inner loop
  X
  End outer loop

  Begin outer loop
  var1 = val7
  var2 = val8
  X
    Begin inner loop
    var1 = val7
    var2 = val9
    var3 = val10
    End inner loop
  
    Begin inner loop
    var1 = val7
    var2 = val11
    var3 = val12
    End inner loop
  X
  End outer loop

  Begin outer loop
  var1 = val13
  var2 = val14
  X
    Begin inner loop
    var1 = val13
    var2 = val15
    var3 = val16
    End inner loop
  
    Begin inner loop
    var1 = val13
    var2 = val17
    var3 = val18
    End inner loop
  X
  End outer loop

  Begin outer loop
  var1 = val19
  var2 = 
  XX
  End outer loop
X
End template
EOF

template tmplfile var1 outervalue \
  outer \
    { \
      var1 val1 var2 val2 \
      inner \
        { var2 val3 var3 val4 } \
        { var2 val5 var3 val6 } \
    } \
    { \
      var1 val7 var2 val8 \
      inner \
        { var2 val9 var3 val10 } \
        { var2 val11 var3 val12 } \
    } \
    { \
      var1 val13 var2 val14 \
      inner \
        { var2 val15 var3 val16 } \
        { var2 val17 var3 val18 } \
    } \
    { \
      var1 val19 \
    } > result 2>&1

check

TEST=36  ########################################

# Testing include inside of loop

cat << "EOF" > inclfile1
Begin include file
var1 = <tmpl_var name = "var1">
var2 = <tmpl_var name = "var2">
End include file
EOF

cat << "EOF" > tmplfile
Begin template
<tmpl_loop name = "loop">
  Begin loop
  Including file 1
  <tmpl_include name = "inclfile1">
  End loop
</tmpl_loop>
End template
EOF

cat << "EOF" > expected
Begin template

  Begin loop
  Including file 1
  Begin include file
var1 = testvalue
var2 = value 1
End include file

  End loop

  Begin loop
  Including file 1
  Begin include file
var1 = testvalue
var2 = value 2
End include file

  End loop

  Begin loop
  Including file 1
  Begin include file
var1 = testvalue
var2 = value 3
End include file

  End loop

End template
EOF

template tmplfile var1 testvalue \
  loop { var2 "value 1" } { var2 "value 2" } { var2 "value 3" } \
  > result 2>&1

check

TEST=37  ########################################

# Testing if and loop nesting

cat << "EOF" > tmplfile

X<tmpl_if name = "var"><tmpl_loop name = "loop"></tmpl_loop></tmpl_if>X
X<tmpl_if name = "bogus"><tmpl_loop name = "loop"></tmpl_loop></tmpl_if>X
X<tmpl_loop name = "loop"><tmpl_if name = "var"></tmpl_if></tmpl_loop>X
X<tmpl_loop name = "bogus"><tmpl_if name = "var"></tmpl_if></tmpl_loop>X

X<tmpl_if name = "loop">
  Inside if 1
  <tmpl_loop name = "loop">
    Inside loop 1
    <tmpl_if name = "bogus">
      Inside if 2: bogus = <tmpl_var name = "bogus">
    </tmpl_if>
    <tmpl_if name = "var2">
      Inside if 3: var2 = <tmpl_var name = "var2">
    </tmpl_if>
  </tmpl_loop>
</tmpl_if>X
X<tmpl_if name = "bogus">
  Inside if 4
  <tmpl_loop name = "loop">
    Inside loop 2
    <tmpl_if name = "bogus">
      Inside if 5: bogus = <tmpl_var name = "bogus">
    </tmpl_if>
    <tmpl_if name = "var2">
      Inside if 6: var2 = <tmpl_var name = "var2">
    </tmpl_if>
  </tmpl_loop>
</tmpl_if>X
EOF

cat << "EOF" > expected

XX
XX
XX
XX

X
  Inside if 1
  
    Inside loop 1
    
    
      Inside if 3: var2 = value 1
    
  
    Inside loop 1
    
    
      Inside if 3: var2 = value 2
    
  
X
XX
EOF

template tmplfile var testvalue \
  loop { var2 "value 1" } { var2 "value 2" } > result 2>&1

check

TEST=38  ########################################

# Testing break and continue

cat << "EOF" > tmplfile
BEGIN
<tmpl_loop name=outer>\
  BEGIN outer        (CONTINUE 3 comes here)
  o = <tmpl_var name=o>
<tmpl_loop name=middle>\
    BEGIN middle     (CONTINUE 2 comes here)
    m = <tmpl_var name=m>
<tmpl_loop name=inner>\
      BEGIN inner    (CONTINUE 1 comes here)
      i = <tmpl_var name=i>
<tmpl_if name=i value=b1>\
      BREAK 1
<tmpl_break></tmpl_if>\
<tmpl_if name=i value=b2>\
      BREAK 2
<tmpl_break level=2></tmpl_if>\
<tmpl_if name=i value=b3>\
      BREAK 3
<tmpl_break level=3></tmpl_if>\
<tmpl_if name=i value=c1>\
      CONTINUE 1
<tmpl_continue></tmpl_if>\
<tmpl_if name=i value=c2>\
      CONTINUE 2
<tmpl_continue level=2></tmpl_if>\
<tmpl_if name=i value=c3>\
      CONTINUE 3
<tmpl_continue level=3></tmpl_if>\
      END inner
</tmpl_loop>\
    END middle       (BREAK 1 comes here)
</tmpl_loop>\
  END outer          (BREAK 2 comes here)
</tmpl_loop>\
END                  (BREAK 3 comes here)
EOF

cat << "EOF" > expected
BEGIN
  BEGIN outer        (CONTINUE 3 comes here)
  o = o1
    BEGIN middle     (CONTINUE 2 comes here)
    m = m1
      BEGIN inner    (CONTINUE 1 comes here)
      i = c1
      CONTINUE 1
      BEGIN inner    (CONTINUE 1 comes here)
      i = i1
      END inner
    END middle       (BREAK 1 comes here)
    BEGIN middle     (CONTINUE 2 comes here)
    m = m2
    END middle       (BREAK 1 comes here)
  END outer          (BREAK 2 comes here)
  BEGIN outer        (CONTINUE 3 comes here)
  o = o2
  END outer          (BREAK 2 comes here)
  BEGIN outer        (CONTINUE 3 comes here)
  o = o3
    BEGIN middle     (CONTINUE 2 comes here)
    m = m3
      BEGIN inner    (CONTINUE 1 comes here)
      i = b1
      BREAK 1
    END middle       (BREAK 1 comes here)
    BEGIN middle     (CONTINUE 2 comes here)
    m = m4
    END middle       (BREAK 1 comes here)
  END outer          (BREAK 2 comes here)
  BEGIN outer        (CONTINUE 3 comes here)
  o = o4
  END outer          (BREAK 2 comes here)
  BEGIN outer        (CONTINUE 3 comes here)
  o = o5
    BEGIN middle     (CONTINUE 2 comes here)
    m = m5
      BEGIN inner    (CONTINUE 1 comes here)
      i = c2
      CONTINUE 2
    BEGIN middle     (CONTINUE 2 comes here)
    m = m6
    END middle       (BREAK 1 comes here)
  END outer          (BREAK 2 comes here)
  BEGIN outer        (CONTINUE 3 comes here)
  o = o6
  END outer          (BREAK 2 comes here)
  BEGIN outer        (CONTINUE 3 comes here)
  o = o7
    BEGIN middle     (CONTINUE 2 comes here)
    m = m7
      BEGIN inner    (CONTINUE 1 comes here)
      i = b2
      BREAK 2
  END outer          (BREAK 2 comes here)
  BEGIN outer        (CONTINUE 3 comes here)
  o = o8
  END outer          (BREAK 2 comes here)
  BEGIN outer        (CONTINUE 3 comes here)
  o = o9
    BEGIN middle     (CONTINUE 2 comes here)
    m = m9
      BEGIN inner    (CONTINUE 1 comes here)
      i = c3
      CONTINUE 3
  BEGIN outer        (CONTINUE 3 comes here)
  o = o10
  END outer          (BREAK 2 comes here)
  BEGIN outer        (CONTINUE 3 comes here)
  o = o11
    BEGIN middle     (CONTINUE 2 comes here)
    m = m11
      BEGIN inner    (CONTINUE 1 comes here)
      i = b3
      BREAK 3
END                  (BREAK 3 comes here)
EOF

template tmplfile outer \
  { o o1 middle { m m1 inner { i c1 } { i i1 } } { m m2 } } \
  { o o2 } \
  { o o3 middle { m m3 inner { i b1 } { i i2 } } { m m4 } } \
  { o o4 } \
  { o o5 middle { m m5 inner { i c2 } { i i3 } } { m m6 } } \
  { o o6 } \
  { o o7 middle { m m7 inner { i b2 } { i i4 } } { m m8 } } \
  { o o8 } \
  { o o9 middle { m m9 inner { i c3 } { i i5 } } { m m10 } } \
  { o o10 } \
  { o o11 middle { m m11 inner { i b3 } { i i6 } } { m m12 } } \
  { o o12 } \
  { o o13 } > result 2>&1

check

TEST=39  ########################################

# Testing missing statement terminators

cat << "EOF" > tmplfile
<tmpl_if name = "var">
  Inside if 1
<tmpl_elsif name = "var">
  Inside elsif 1
<tmpl_else>
  Inside else 1
<tmpl_loop name = "loop">
  Inside the loop statement
  <*
</tmpl_loop> *><* this
comment is not terminated
EOF

cat << "EOF" > expected
"<*" in file "tmplfile" line 10 has no "*>"
TMPL_LOOP tag in file "tmplfile" line 7 has no /TMPL_LOOP tag
TMPL_IF tag in file "tmplfile" line 1 has no /TMPL_IF tag
EOF

template tmplfile var testvalue > /dev/null 2> result

check

TEST=40  ########################################

# Testing missing statement terminators

cat << "EOF" > tmplfile
<tmpl_if name = "var">
  Inside if 1
  <tmpl_loop name = "loop">
    Inside loop 1
</tmpl_if>
<tmpl_loop name = "loop">
  Inside loop 2
  <tmpl_if name = "var">
    Inside if 2
</tmpl_loop>
EOF

cat << "EOF" > expected
TMPL_LOOP tag in file "tmplfile" line 3 has no /TMPL_LOOP tag
TMPL_IF tag in file "tmplfile" line 8 has no /TMPL_IF tag
EOF

template tmplfile var testvalue > /dev/null 2> result

check

TEST=41  ########################################

# Testing extraneous and misplaced tags

cat << "EOF" > tmplfile
<tmpl_if name = "var">
  Inside if 1
<tmpl_else>
  Inside else 1
<tmpl_elsif name = "var">
  Inside misplaced tmpl_elsif
</tmpl_if>

<tmpl_if name = "var">
  Inside if 2
<tmpl_elsif name = "var">
  Inside elsif 2
<tmpl_else>
  Inside else 2
<tmpl_else>
  Inside misplaced else
</tmpl_if>

<tmpl_elsif name = "var">
  Inside elsif 3
<tmpl_else>
  Inside else 3
</tmpl_if>

</tmpl_loop>

<tmpl_break>
<tmpl_break level=2 />
<tmpl_continue>
<tmpl_continue level=2/>

<tmpl_loop name="outer">
  <tmpl_break level = 0>
  <tmpl_break level = 2>
  <tmpl_break level = "non-numeric">
  <tmpl_continue level = 0>
  <tmpl_continue level = 2>
  <tmpl_continue level = "non-numeric">
  <tmpl_loop name="inner">
    <tmpl_break level = 3>
    <tmpl_continue level = 3>
  </tmpl_loop>
</tmpl_loop>

<*
  Inside comment
*>
more stuff
*>
EOF

cat << "EOF" > expected
Unexpected TMPL_ELSIF tag in file "tmplfile" line 5
Unexpected TMPL_ELSE tag in file "tmplfile" line 15
Unexpected TMPL_ELSIF tag in file "tmplfile" line 19
Unexpected TMPL_ELSE tag in file "tmplfile" line 21
Unexpected /TMPL_IF tag in file "tmplfile" line 23
Unexpected /TMPL_LOOP tag in file "tmplfile" line 25
Ignoring bad TMPL_BREAK tag (not inside a loop) in file "tmplfile" line 27
Ignoring bad TMPL_BREAK tag (not inside a loop) in file "tmplfile" line 28
Ignoring bad TMPL_CONTINUE tag (not inside a loop) in file "tmplfile" line 29
Ignoring bad TMPL_CONTINUE tag (not inside a loop) in file "tmplfile" line 30
Ignoring bad TMPL_BREAK tag (bad "level=" attribute) in file "tmplfile" line 33
Ignoring bad TMPL_BREAK tag (bad "level=" attribute) in file "tmplfile" line 34
Ignoring bad TMPL_BREAK tag (bad "level=" attribute) in file "tmplfile" line 35
Ignoring bad TMPL_CONTINUE tag (bad "level=" attribute) in file "tmplfile" line 36
Ignoring bad TMPL_CONTINUE tag (bad "level=" attribute) in file "tmplfile" line 37
Ignoring bad TMPL_CONTINUE tag (bad "level=" attribute) in file "tmplfile" line 38
Ignoring bad TMPL_BREAK tag (bad "level=" attribute) in file "tmplfile" line 40
Ignoring bad TMPL_CONTINUE tag (bad "level=" attribute) in file "tmplfile" line 41
EOF

template tmplfile var testvalue > /dev/null 2> result

check

TEST=42  ########################################

# Testing incorrect statement nesting

cat << "EOF" > tmplfile
<tmpl_if name = "var">
  Inside  if 1
  <tmpl_loop name = "loop">
    Inside loop 1
  </tmpl_if>
</tmpl_loop>

<tmpl_loop name = "loop">
  Inside loop 2
  <tmpl_if name = "var">
    Inside if 2
  </tmpl_loop>
</tmpl_if>

<tmpl_if name = "var">
  Inside if 3
<tmpl_elsif name = "bogus">
  Inside elsif 1
  <tmpl_if name = "var">
    Inside if 4
  <tmpl_else>
    Inside else 1
  <tmpl_elsif name = "var">
    Inside elsif 2
  </tmpl_if>
</tmpl_if>
EOF

cat << "EOF" > expected
TMPL_LOOP tag in file "tmplfile" line 3 has no /TMPL_LOOP tag
Unexpected /TMPL_LOOP tag in file "tmplfile" line 6
TMPL_IF tag in file "tmplfile" line 10 has no /TMPL_IF tag
Unexpected /TMPL_IF tag in file "tmplfile" line 13
TMPL_IF tag in file "tmplfile" line 19 has no /TMPL_IF tag
Unexpected /TMPL_IF tag in file "tmplfile" line 26
EOF

template tmplfile var testvalue > /dev/null 2> result

check

# clean up

/bin/rm -f expected inclfile1 inclfile2 result tmplfile
