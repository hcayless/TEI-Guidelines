<?xml version="1.0" encoding="UTF-8"?>
<!-- 
 #  The Contents of this file are made available subject to the terms of
 # the GNU Lesser General Public License Version 2.1

 # Sebastian Rahtz / University of Oxford
 # copyright 2003

 # This stylesheet is derived from the OpenOffice to Docbook conversion
 #  Sun Microsystems Inc., October, 2000

 #  GNU Lesser General Public License Version 2.1
 #  =============================================
 #  Copyright 2000 by Sun Microsystems, Inc.
 #  901 San Antonio Road, Palo Alto, CA 94303, USA
 #
 #  This library is free software; you can redistribute it and/or
 #  modify it under the terms of the GNU Lesser General Public
 #  License version 2.1, as published by the Free Software Foundation.
 #
 #  This library is distributed in the hope that it will be useful,
 #  but WITHOUT ANY WARRANTY; without even the implied warranty of
 #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 #  Lesser General Public License for more details.
 #
 #  You should have received a copy of the GNU Lesser General Public
 #  License along with this library; if not, write to the Free Software
 #  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 #  MA  02111-1307  USA
 #
 #
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:office="http://openoffice.org/2000/office" xmlns:style="http://openoffice.org/2000/style" xmlns:text="http://openoffice.org/2000/text" xmlns:table="http://openoffice.org/2000/table" xmlns:draw="http://openoffice.org/2000/drawing" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="http://openoffice.org/2000/meta" xmlns:number="http://openoffice.org/2000/datastyle" xmlns:svg="http://www.w3.org/2000/svg" xmlns:chart="http://openoffice.org/2000/chart" xmlns:dr3d="http://openoffice.org/2000/dr3d" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="http://openoffice.org/2000/form" xmlns:script="http://openoffice.org/2000/script" xmlns:config="http://openoffice.org/2001/config" version="1.0" office:class="text" office:version="1.0">
  <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
  <xsl:decimal-format name="staff" digit="D"/>
  <xsl:variable name="doc_type">TEI.2</xsl:variable>
  

<xsl:template match="/">
    <office:document>
      <office:meta>
        <meta:generator>Open Office TEI to OO XSLT</meta:generator>
        <dc:title>
          <xsl:value-of select="/TEI.2/teiHeader/fileDesc/titleStmt/title"/>
        </dc:title>
        <dc:description/>
        <dc:subject/>
        <meta:creation-date>
 <xsl:value-of select="/TEI.2/teiHeader/fileDesc/editionStmt/edition/date"/>
        </meta:creation-date>
        <dc:date>
          <xsl:value-of select="/TEI.2/teiHeader/revisionDesc/change/date"/>
        </dc:date>
        <dc:language>
          <xsl:value-of select="/TEI.2/@lang"/>
        </dc:language>
        <meta:editing-cycles>21</meta:editing-cycles>
        <meta:editing-duration>P1DT0H11M54S</meta:editing-duration>
        <meta:user-defined meta:name="Info 1"/>
        <meta:user-defined meta:name="Info 2"/>
        <meta:user-defined meta:name="Info 3"/>
        <meta:user-defined meta:name="Info 4"/>
        <meta:document-statistic meta:table-count="1" meta:image-count="0" meta:object-count="0" meta:page-count="1" meta:paragraph-count="42" meta:word-count="144" meta:character-count="820"/>
      </office:meta>
      <!--
      <xsl:copy-of select="document('styles.xml')/office:document-styles"/>
-->
      <office:body>
        <xsl:call-template name="entities"/>
        <xsl:apply-templates select="(.//TEI.2|text|div)[1]"/>
      </office:body>
    </office:document>
  </xsl:template>
  

<xsl:template name="entities">
    <text:variable-decls>
      <xsl:for-each select="/descendant::entity">
        <xsl:variable name="entname">
          <xsl:value-of select="@name"/>
        </xsl:variable>
        <xsl:if test="not(preceding::entity[@name = $entname])">
          <text:variable-decl>
            <xsl:attribute name="text:value-type">
              <xsl:text>string</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="text:name">
              <xsl:text>entitydecl_</xsl:text>
              <xsl:value-of select="@name"/>
            </xsl:attribute>
          </text:variable-decl>
        </xsl:if>
      </xsl:for-each>
    </text:variable-decls>
  </xsl:template>
  

<xsl:template match="entity">
    <xsl:variable name="entname">
      <xsl:value-of select="@name"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="not(preceding::entity[@name = $entname])">
        <text:variable-set>
          <xsl:attribute name="text:value-type">
            <xsl:text>string</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="text:name">
            <xsl:text>entitydecl_</xsl:text>
            <xsl:value-of select="@name"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </text:variable-set>
      </xsl:when>
      <xsl:otherwise>
        <text:variable-get>
          <xsl:attribute name="text:value-type">
            <xsl:text>string</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="text:name">
            <xsl:text>entitydecl_</xsl:text>
            <xsl:value-of select="@name"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </text:variable-get>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<xsl:template match="teiHeader"/> <!-- suppress header content -->

<!-- table start -->
  

<xsl:template match="table">
  <xsl:call-template name="startHook"/>
    <xsl:variable name="tablenum">
      <xsl:choose>
        <xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
        <xsl:otherwise>table<xsl:number level="any"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <table:table 
      table:name="{$tablenum}"
      table:style-name="Table1">
<table:table-column 
  table:style-name="Table1.col1">
  <xsl:attribute name="table:number-columns-repeated">
    <xsl:value-of select="count(row[1]/cell)"/>
  </xsl:attribute>
</table:table-column>
      <xsl:apply-templates/>
    </table:table>
    <xsl:if test="head">
      <text:p text:style-name="Table">
         <xsl:apply-templates select="head" mode="ok"/>
      </text:p>
    </xsl:if>
  <xsl:call-template name="endHook"/>
</xsl:template>
  

<xsl:template match="row[@role='label']">
  <table:table-header-rows>
   <table:table-row>
      <xsl:apply-templates/>
    </table:table-row>
  </table:table-header-rows>
</xsl:template>
  

<xsl:template match="row">
    <table:table-row>
      <xsl:apply-templates/>
    </table:table-row>
  </xsl:template>
  

<xsl:template match="cell">
    <table:table-cell>
         <xsl:choose>
           <xsl:when test="parent::row[@role='label']">
            <xsl:attribute name="text:style-name">Table1.cellheading</xsl:attribute>
           </xsl:when>
           <xsl:when test="@role='label'">
            <xsl:attribute name="text:style-name">Table1.cellheading</xsl:attribute>
           </xsl:when>
           <xsl:otherwise>
            <xsl:attribute name="text:style-name">Table1.cellcontents</xsl:attribute>
           </xsl:otherwise>
         </xsl:choose>
    <xsl:choose>
      <xsl:when test="not(child::p)">
       <text:p>
         <xsl:choose>
           <xsl:when test="parent::row[@role='label']">
            <xsl:attribute name="text:style-name">Table Heading</xsl:attribute>
           </xsl:when>
           <xsl:when test="@role='label'">
            <xsl:attribute name="text:style-name">Table Heading</xsl:attribute>
           </xsl:when>
           <xsl:otherwise>
            <xsl:attribute name="text:style-name">Table Contents</xsl:attribute>
           </xsl:otherwise>
         </xsl:choose>
         <xsl:apply-templates/>
       </text:p>
      </xsl:when>
      <xsl:otherwise>
         <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </table:table-cell>
</xsl:template>
  

<xsl:template match="head">
    <xsl:choose>
      <xsl:when test="parent::figure"/>
      <xsl:when test="parent::list"/>
      <xsl:when test="parent::table"/>
      <xsl:when test="parent::div"/>
      <xsl:when test="parent::div0"/>
      <xsl:when test="parent::div1"/>
      <xsl:when test="parent::div2"/>
      <xsl:when test="parent::div3"/>
      <xsl:when test="parent::div4"/>
      <xsl:when test="parent::div5"/>
      <xsl:when test="parent::table">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <text:p>
          <xsl:choose>
            <xsl:when test="parent::appendix">
              <xsl:attribute name="text:style-name">Appendix Title</xsl:attribute>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates/>
        </text:p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



<xsl:template match="author">
    <xsl:apply-templates/>
</xsl:template>




<xsl:template match="p">
  <text:p>
    <xsl:choose>
      <xsl:when test="ancestor::varlistentry">
          <xsl:attribute name="text:style-name">VarList Term</xsl:attribute>
      </xsl:when>
      <xsl:when test="ancestor::footnote">
          <xsl:attribute name="text:style-name">
                <xsl:text>Footnote</xsl:text>
          </xsl:attribute>
      </xsl:when>
      <xsl:when test="ancestor::row[@role='label']">
        <xsl:attribute name="text:style-name">Table Heading</xsl:attribute>
      </xsl:when>
  <xsl:when test='@rend="it"'>
   <xsl:attribute name="text:style-name">Emphasis</xsl:attribute>
  </xsl:when>
      <xsl:when test="ancestor::row">
        <xsl:attribute name="text:style-name">Table Contents</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="text:style-name">Text body</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="test.id"/>
    <xsl:apply-templates/>
   </text:p>
</xsl:template>
  

<xsl:template match="div">
      <xsl:variable name="depth">
        <xsl:value-of select="count(ancestor::div)"/>
      </xsl:variable>
      <text:h>
      <xsl:attribute name="text:level">
        <xsl:value-of select="$depth + 1"/>
      </xsl:attribute>
      <xsl:attribute name="text:style-name">
        <xsl:text>Heading </xsl:text><xsl:value-of select="$depth + 1"/>
      </xsl:attribute>
      <xsl:call-template name="test.id"/>
      <xsl:apply-templates select="head" mode="ok"/>
    </text:h>
    <xsl:apply-templates/>
  </xsl:template>
  
<xsl:template match="div0|div1|div2|div3|div4|div5">
      <xsl:variable name="depth">
        <xsl:value-of select="substring-after(name(.),'div')"/>
      </xsl:variable>
      <text:h>
      <xsl:attribute name="text:level">
        <xsl:value-of select="$depth + 1"/>
      </xsl:attribute>
      <xsl:attribute name="text:style-name">
        <xsl:text>Heading </xsl:text><xsl:value-of select="$depth + 1"/>
      </xsl:attribute>
      <xsl:call-template name="test.id"/>
      <xsl:apply-templates select="head" mode="ok"/>
    </text:h>
    <xsl:apply-templates/>
  </xsl:template>
  
<xsl:template match="figure">
  <xsl:variable name="id">
    <xsl:choose>
      <xsl:when test="@id">
        <xsl:value-of select="@id"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>Figure</xsl:text><xsl:number level="any"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="image">
<draw:image draw:style-name="fr3" 
  draw:name="{$id}" 
  text:anchor-type="paragraph" 
  svg:x="0inch" 
  svg:y="0inch" 
  draw:z-index="3" 
  xlink:type="simple" 
  xlink:show="embed" 
  xlink:actuate="onLoad" >
  <xsl:attribute name="xlink:href">
    <xsl:choose>
      <xsl:when test="@url|@file">
        <xsl:value-of select="@url|@file"/>   
      </xsl:when>
      <xsl:when test="@entity">
        <xsl:value-of select="unparsed-entity-uri(@entity)"/>
      </xsl:when>
    </xsl:choose>
   </xsl:attribute>
   <xsl:choose>
     <xsl:when test="@rend='display' or head">
     <xsl:attribute name="style:rel-height">scale</xsl:attribute>
     <xsl:attribute name="style:rel-width">100%</xsl:attribute>
   </xsl:when>
   <xsl:otherwise>
    <xsl:attribute name="style:rel-width">scale</xsl:attribute>
    <xsl:attribute name="style:rel-height">scale</xsl:attribute>
    <xsl:attribute name="svg:width">
     <xsl:choose>
           <xsl:when test="@width">
             <xsl:value-of select="@width"/>
             <xsl:call-template name="checkunit">
               <xsl:with-param name="dim" select="@width"/>
             </xsl:call-template>
           </xsl:when>
           <xsl:otherwise>
             <xsl:text>6inch</xsl:text>
           </xsl:otherwise>
     </xsl:choose>
   </xsl:attribute>
    <xsl:attribute name="svg:height">
     <xsl:choose>
           <xsl:when test="@height">
             <xsl:value-of select="@height"/>
             <xsl:call-template name="checkunit">
               <xsl:with-param name="dim" select="@height"/>
             </xsl:call-template>
           </xsl:when>
           <xsl:otherwise>
             <xsl:text>6inch</xsl:text>
           </xsl:otherwise>
     </xsl:choose>
   </xsl:attribute>
   </xsl:otherwise>
   </xsl:choose>
 </draw:image>
</xsl:variable>

<xsl:choose>
  <xsl:when test="@rend='display' or head">
   <text:p text:style-name="Text body">
   <draw:text-box
    draw:style-name="fr2" 
    draw:name="Frame2" 
    text:anchor-type="paragraph"
    draw:z-index="2">
    <xsl:attribute name="svg:width">
      <xsl:choose>
       <xsl:when test="@width">
        <xsl:value-of select="@width"/>
             <xsl:call-template name="checkunit">
               <xsl:with-param name="dim" select="@width"/>
             </xsl:call-template>
           </xsl:when>
           <xsl:otherwise>
             <xsl:text>6inch</xsl:text>
           </xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>
    <xsl:attribute name="svg:height">
      <xsl:choose>
       <xsl:when test="@height">
        <xsl:value-of select="@height"/>
             <xsl:call-template name="checkunit">
               <xsl:with-param name="dim" select="@height"/>
             </xsl:call-template>
           </xsl:when>
           <xsl:otherwise>
             <xsl:text>6inch</xsl:text>
           </xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>
    <text:p text:style-name="Illustration">
    <xsl:copy-of select="$image"/>
    Figure <text:sequence
    text:ref-name="refIllustration0" text:name="Illustration"
    text:formula="Illustration+1"
    style:num-format="1"><xsl:number level="any"/>. </text:sequence>
    <xsl:apply-templates select="head"/>
    </text:p></draw:text-box></text:p>      
   </xsl:when>
   <xsl:otherwise>
      <xsl:copy-of select="$image"/>
   </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="list">
  <xsl:call-template name="startHook"/>
  <xsl:if test="head">
    <text:p><xsl:apply-templates select="head" mode="ok"/></text:p>
  </xsl:if>
    <text:unordered-list text:style-name="Unordered List">
      <xsl:apply-templates/>
    </text:unordered-list>
  <xsl:call-template name="endHook"/>
</xsl:template>
  

<xsl:template match="list[@type='unordered']">
  <xsl:call-template name="startHook"/>
    <text:unordered-list text:style-name="Unordered List">
      <xsl:apply-templates/>
    </text:unordered-list>
  <xsl:call-template name="endHook"/>
  </xsl:template>
  

<xsl:template match="list[@type='ordered']">
  <xsl:call-template name="startHook"/>
    <text:ordered-list text:style-name="Ordered List">
      <xsl:apply-templates/>
    </text:ordered-list>
  <xsl:call-template name="endHook"/>
  </xsl:template>
  
<xsl:template match="list[@type='gloss']">
  <xsl:call-template name="startHook"/>
      <xsl:apply-templates/>
  <xsl:call-template name="endHook"/>
</xsl:template>
  

<xsl:template match="list[@type='gloss']/item">
  <text:p text:style-name="List Contents">
      <xsl:apply-templates/>
  </text:p>
</xsl:template>

<xsl:template match="list[@type='gloss']/label">
  <text:p text:style-name="List Heading">
      <xsl:apply-templates/>
  </text:p>
</xsl:template>

<xsl:template name="endHook">
  <xsl:if test="parent::p">
    <xsl:text disable-output-escaping="yes">&lt;text:p&gt;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template name="startHook">
  <xsl:if test="parent::p">
    <xsl:text disable-output-escaping="yes">&lt;/text:p&gt;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="item">
        <text:list-item>
          <xsl:choose>
            <xsl:when test="list">
            <xsl:apply-templates/>              
            </xsl:when>
            <xsl:otherwise>
          <text:p>
            <xsl:apply-templates/>
          </text:p>
            </xsl:otherwise>
          </xsl:choose>
        </text:list-item>
 </xsl:template>
  

<xsl:template match="emph">
    <text:span text:style-name="Highlight">
          <xsl:apply-templates/>
    </text:span>
  </xsl:template>

<xsl:template match="name">
    <text:span text:style-name="Highlight">
          <xsl:apply-templates/>
    </text:span>
  </xsl:template>

<xsl:template match="q">
    <text:span text:style-name="q">
      <xsl:text>&#x2018;</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>&#x2019;</xsl:text>
    </text:span>
</xsl:template>


<xsl:template match="note[@place='foot']">
    <text:footnote>
      <text:footnote-body>
        <xsl:apply-templates/>
      </text:footnote-body>
    </text:footnote>
  </xsl:template>
  

<xsl:template match="xref">
    <text:a>
      <xsl:attribute name="xlink:type">
        <xsl:text>simple</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="xlink:href">
        <xsl:value-of select="@url"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </text:a>
  </xsl:template>
  

<xsl:template match="ref">
 <text:a xlink:type="simple" xlink:href="#{@target}">
  <xsl:apply-templates/>
 </text:a>
</xsl:template>
  
<xsl:template match="ptr">
 <text:a xlink:type="simple" xlink:href="#{@target}">
   <xsl:value-of select="@target"/>
 </text:a>
</xsl:template>
  
<xsl:template match="xref">
 <text:a xlink:type="simple" xlink:href="{@url}">
  <xsl:apply-templates/>
 </text:a>
</xsl:template>
  
<xsl:template match="xptr">
 <text:a xlink:type="simple" xlink:href="{@url}">
   <xsl:value-of select="@url"/>
 </text:a>
</xsl:template>
  


<xsl:template name="test.id">
  <xsl:if test="@id">
     <text:bookmark text:name="{@id}"/>
  </xsl:if>
</xsl:template>
  
 

<xsl:template match="note">
    <office:annotation>
      <text:p>
        <xsl:apply-templates/>
      </text:p>
    </office:annotation>
  </xsl:template>
  

<xsl:template match="imageobject">
    <xsl:apply-templates/>
  </xsl:template>
  

<xsl:template match="textobject"/>
  

<xsl:template match="caption">
    <xsl:apply-templates/>
  </xsl:template>

<xsl:template match="title">
<text:span text:style-name="Emphasis">
<xsl:apply-templates/>
</text:span>

</xsl:template>

  
<xsl:template match="hi">
  <text:span>
  <xsl:attribute name="text:style-name">
   <xsl:choose>
    <xsl:when test="@rend='sup'">
        <xsl:text>SuperScript</xsl:text>
    </xsl:when>
    <xsl:when test="@rend='sub'">
        <xsl:text>SubScript</xsl:text>
    </xsl:when>
    <xsl:when test="@rend='bold'">
        <xsl:text>Highlight</xsl:text>
    </xsl:when>
    <xsl:when test="@rend='it'">
        <xsl:text>Emphasis</xsl:text>
    </xsl:when>
    <xsl:when test="@rend='i'">
        <xsl:text>Emphasis</xsl:text>
    </xsl:when>
    <xsl:when test="@rend='ul'">
        <xsl:text>Underline</xsl:text>
    </xsl:when>
    <xsl:when test="@rend='sc'">
        <xsl:text>SmallCaps</xsl:text>
    </xsl:when>
    <xsl:otherwise>
        <xsl:text>Highlight</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:attribute>
<xsl:apply-templates/>
</text:span>
  </xsl:template>
  
<xsl:template match="date">
   <text:span text:style-name="{name(.)}">
    <xsl:apply-templates/>
   </text:span>
</xsl:template>

<xsl:template match="signed">
   <text:p text:style-name="{name(.)}">
    <xsl:apply-templates/>
   </text:p>
</xsl:template>


<xsl:template match="Filespec|gi|Code|Input">
   <text:span text:style-name="{name(.)}">
    <xsl:apply-templates/>
   </text:span>
</xsl:template>

<xsl:template match="Screen|Output">
   <text:p text:style-name="{name(.)}">
    <xsl:apply-templates/>
   </text:p>
</xsl:template>

<!-- safest to drop comments entirely, I think -->
<xsl:template match="comment()"/>

<xsl:template match="head" mode="ok">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="signed">
    <text:p text:style-name="signed">
      <xsl:apply-templates/>
    </text:p>
  </xsl:template>

<xsl:template match="lb">
  <text:line-break/>
</xsl:template>

<xsl:template name="checkunit">
   <xsl:param name="dim"/>
   <xsl:if test="contains($dim,'in')">
     <xsl:text>ch</xsl:text>
   </xsl:if>
</xsl:template>

<!-- curiously, no apparent markup for a page break -->
<xsl:template match="pb"/>

<xsl:template match="lg">
  <text:p text:style-name="lg"><xsl:apply-templates/></text:p>
</xsl:template>

<xsl:template match="l">
 <text:span text:style-name="l">
   <xsl:apply-templates/>  
   <text:line-break/>
 </text:span>
</xsl:template>

</xsl:stylesheet>
