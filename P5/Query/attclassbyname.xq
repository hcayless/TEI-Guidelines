declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace rng="http://relaxng.org/ns/structure/1.0";
let $class := request:request-parameter("class", "")
for $t in collection("/db/TEI")//tei:classSpec[@ident=$class]
return
<attClass>
 <className>{data($t/@ident)}</className>
 <classDesc>{$t/tei:desc}</classDesc>
 <module>{string($t/@module)}</module>
 <attributes>
{
for $a in $t//tei:attDef
return 
 <att>
    <name>
    {$a/@usage}
    {data($a/@ident)}</name>
    <default>{data($a/tei:defaultVal)}</default>
    <datatype>{
    if (tei:valList[@type='closed'])
    then
      'Closed list'
    else
      string($a/tei:datatype/*)
     }</datatype>
    <desc>{data($a/tei:desc)}</desc>
</att>
}
 </attributes>
</attClass>

