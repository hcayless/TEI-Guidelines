<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml" 
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
    xmlns:teix="http://www.tei-c.org/ns/Examples"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:estr="http://exslt.org/strings"
    xmlns:pantor="http://www.pantor.com/ns/local"
    xmlns:exsl="http://exslt.org/common"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:edate="http://exslt.org/dates-and-times"
    extension-element-prefixes="exsl estr edate"
    exclude-result-prefixes="exsl rng edate estr tei html a pantor teix xs xd" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="/usr/share/xml/tei/stylesheet/xhtml/odd2html.xsl"/>

  <xsl:output method="xml"
	      doctype-public="//W3C//DTD XHTML 1.1//EN"
	      doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
	      encoding="utf-8"
	      />  
  <xsl:param name="alignNavigationPanel">left</xsl:param>
  <xsl:param name="authorWord"></xsl:param>
  <xsl:param name="autoToc">false</xsl:param>
  <xsl:param name="bottomNavigationPanel">true</xsl:param>
  <xsl:param name="cssFile">http://www.tei-c.org/release/xml/tei/stylesheet/tei.css</xsl:param>
  <xsl:param name="dateWord"></xsl:param>
  <xsl:param name="footnoteBackLink">true</xsl:param>
  <xsl:param name="displayMode">rnc</xsl:param>
  <xsl:param name="feedbackURL">http://www.tei-c.org/Consortium/contact.xml</xsl:param>
  <xsl:param name="feedbackWords">Contact</xsl:param>
  <xsl:param name="parentWords">TEI Consortium</xsl:param>
  <xsl:param name="footnoteFile">false</xsl:param>
  <xsl:param name="homeLabel">TEI P5 Guidelines</xsl:param>
  <xsl:param name="homeURL">index.html</xsl:param>
  <xsl:param name="parentURL">http://www.tei-c.org/Consortium/</xsl:param>
  <xsl:param name="homeWords">TEI P5</xsl:param>
  <xsl:param name="indent-width" select="3"/>
  <xsl:param name="institution">Text Encoding Initiative</xsl:param>
  <xsl:param name="line-width" select="80"/>
  <xsl:param name="numberBackHeadings">A.1</xsl:param>
  <xsl:param name="numberFrontHeadings"></xsl:param>
  <xsl:param name="oddmode">html</xsl:param>
  <xsl:param name="outputDir">Guidelines</xsl:param>
  <xsl:param name="pageLayout">CSS</xsl:param>
  <xsl:param name="prenumberedHeadings">false</xsl:param>
  <xsl:param name="searchURL"/>
  <xsl:param name="searchWords"/>
  <xsl:param name="showTitleAuthor">1</xsl:param>
  <xsl:param name="splitBackmatter">yes</xsl:param>
  <xsl:param name="splitFrontmatter">yes</xsl:param>
  <xsl:param name="splitLevel">0</xsl:param>
  <xsl:param name="STDOUT">false</xsl:param>
  <xsl:param name="subTocDepth">-1</xsl:param>
  <xsl:param name="tocDepth">3</xsl:param>
  <xsl:param name="tocElement">div</xsl:param>
  <xsl:param name="topNavigationPanel"></xsl:param>
  <xsl:param name="useHeaderFrontMatter">true</xsl:param>
  <xsl:param name="showNamespaceDecls">false</xsl:param>
  <xsl:param name="verbose">false</xsl:param>
  <xsl:template name="copyrightStatement">Copyright TEI Consortium 2007</xsl:template>

  <xsl:template name="metaHook">
    <xsl:param name="title"/>
    <meta name="DC.Title" content="{$title}"/>
    <meta name="DC.Language" content="(SCHEME=iso639) en"/> 
    <meta name="DC.Creator" content="TEI,Oxford University Computing Services, 13 Banbury Road, Oxford OX2 6NN, United Kingdom"/>
    <meta name="DC.Creator.Address" content="tei@oucs.ox.ac.uk"/>
  </xsl:template>
  
  <xsl:template match="processing-instruction()"/>
 
  <xsl:template match="tei:docAuthor">
    <div class="center">
      <em>
	<xsl:value-of select="@n"/>
	<xsl:text> </xsl:text>
	<xsl:apply-templates/>
      </em>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:docImprint|tei:docDate">
    <div class="center">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:docTitle">
      <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:revisionDesc//tei:date">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:term">
      <!--
           <span>
             <xsl:attribute name="id">
               <xsl:text>TDX-</xsl:text>
               <xsl:number level="any"/>
             </xsl:attribute>
           </span>
      -->
      <em>
        <xsl:apply-templates/>
      </em>
  </xsl:template>
  
  <xsl:template match="tei:titlePart">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template name="logoPicture">
    <img src="jaco001d.gif" alt="" width="180" />
  </xsl:template>
  


<xsl:template name="hdr2">
<xsl:comment>no nav </xsl:comment>
</xsl:template>


  <xsl:template name="stdfooter">
    <xsl:param name="style" select="'plain'"/>
    <xsl:variable name="date">
      <xsl:call-template name="generateDate"/>
    </xsl:variable>
    <xsl:variable name="author">
      <xsl:call-template name="generateAuthor"/>
    </xsl:variable>
    <div class="stdfooter">
      <hr/>
      <xsl:if test="$linkPanel='true'">
        <div class="footer">
          <xsl:if test="not($parentURL='')"><a class="{$style}"
              href="{$parentURL}">
              <xsl:value-of select="$parentWords"/>
            </a>  </xsl:if>
          <xsl:if test="$searchURL"> | <a class="{$style}" href="{$searchURL}"
              target="_top">
              <xsl:call-template name="searchWords"/>
            </a>
          </xsl:if>
          <xsl:if test="$feedbackURL"> | <a class="{$style}" href="{$feedbackURL}">
              <xsl:call-template name="feedbackWords"/>
            </a>
          </xsl:if>
        </div>
        <hr/>
      </xsl:if>
      <address>
        <xsl:call-template name="copyrightStatement"/>
        <xsl:text> </xsl:text>
        <a href="COPYING.txt">Licensed under the GPL.</a>
        <xsl:text> Copying and redistribution is permitted and encouraged. </xsl:text>
	<br/>
        <xsl:text>Version </xsl:text>
        <xsl:value-of 
select="ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition"/>
        <xsl:text>This page generated on </xsl:text> 
	<xsl:call-template name="whatsTheDate"/>

    </address>
    </div>
  </xsl:template>


  <xsl:template match="tei:ident">
    <xsl:choose>
      <xsl:when test="@type='class' and key('CLASSES',.)">
	  <a href="ref-{.}.html">
	      <xsl:value-of select="."/>
	  </a>
      </xsl:when>
      <xsl:when test="@type">
        <span class="ident-{@type}">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span class="ident">
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:gi">
    <xsl:choose>
      <xsl:when test="parent::tei:ref">
	<span class="gi">
	  <xsl:apply-templates/>
	</span>
      </xsl:when>
      <xsl:when test="key('ELEMENTS',.)">
	<xsl:for-each select="key('ELEMENTS',.)">
	  <a href="ref-{@ident}.html">
	    <span>
	      <xsl:attribute name="class">
		<xsl:text>gi</xsl:text>
	      </xsl:attribute>
	      <xsl:choose>
		<xsl:when test="tei:content/rng:empty">
		  <span class="emptySlash">
		    <xsl:value-of select="@ident"/>
		  </span>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="@ident"/>
		</xsl:otherwise>
	      </xsl:choose>
	    </span>
	  </a>
	</xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	<span class="gi">
	  <xsl:apply-templates/>
	</span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


<xsl:template name="generateChildren">
  <xsl:variable name="name" select="@ident"/>
  <xsl:choose>
    <xsl:when test="tei:content/rng:empty">
      <xsl:text>Empty element</xsl:text>
    </xsl:when>
    <xsl:when test="tei:content/rng:text and count(tei:content/*)=1">
      <xsl:text>Character data only</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="Children">
	<Children xmlns="">
	  <xsl:for-each select="tei:content">
	    <xsl:call-template name="followRef"/>
	  </xsl:for-each>
	</Children>
      </xsl:variable>
      <xsl:for-each select="exsl:node-set($Children)/Children">
	
	<xsl:choose>
	  <xsl:when test="count(Element)=0">
	    <xsl:text>Empty element</xsl:text>
	  </xsl:when>
	  <xsl:otherwise>
	    <div class="specChildren">
	      <xsl:for-each select="Element">
		<xsl:sort select="@module"/>
		<xsl:sort select="@name"/>
		<xsl:if
		    test="generate-id(.)=generate-id(key('CHILDMOD',@module)[1])">
		  <div class="specChild">
		    <span class="specChildModule">
		      <xsl:value-of select="@module"/>:
		    </span>
		    <span class="specChildElements">
		      <xsl:for-each select="key('CHILDMOD',@module)">
			<xsl:sort select="@name"/>
			<xsl:variable name="me">
			  <xsl:value-of select="@name"/>
			</xsl:variable>
			<xsl:if test="not(preceding-sibling::Element/@name=$me)">
			  <a href="ref-{@name}.html">
			    <xsl:value-of select="@name"/>
			  </a>
			  <xsl:text> </xsl:text>
			</xsl:if>
		      </xsl:for-each>
		    </span>
		  </div>
		</xsl:if>
	      </xsl:for-each>
	    </div>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:for-each>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template name="followRef">
  <xsl:for-each select=".//rng:ref">
    <xsl:for-each select="key('IDENTS',@name)">
      <xsl:choose>
	<xsl:when test="self::tei:elementSpec">
	  <Element  xmlns="" name="{@ident}" module="{@module}"/>
	</xsl:when>
	<xsl:when test="self::tei:macroSpec">
	  <xsl:for-each select="tei:content">
	    <xsl:call-template name="followRef"/>
	  </xsl:for-each>
	</xsl:when>
	<xsl:when test="self::tei:classSpec">
	  <xsl:call-template name="followMembers"/>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>

<xsl:template name="followMembers">
  <xsl:for-each select="key('CLASSMEMBERS',@ident)">
    <xsl:choose>
      <xsl:when test="self::tei:elementSpec">
	<Element xmlns="" name="{@ident}" module="{@module}"/>
      </xsl:when>
      <xsl:when test="self::tei:classSpec">
	<xsl:call-template name="followMembers"/>
      </xsl:when>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>

  <xsl:template match="tei:specGrp"/>

  <xsl:template match="tei:specGrpRef"> </xsl:template>

  <xsl:template match="a:documentation" mode="verbatim"/>



  <xsl:template match="tei:elementSpec" mode="weavebody">
    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="tei:altIdent">
          <xsl:value-of select="tei:altIdent"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@ident"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <h2>
      <xsl:text>&lt;</xsl:text>
      <span>
	<xsl:choose>
	  <xsl:when test="tei:content/rng:empty">
	    <span class="emptySlash">
	      <xsl:value-of select="$name"/>
	    </span>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$name"/>
	  </xsl:otherwise>
	</xsl:choose>
      </span>
      <xsl:text>&gt;</xsl:text> 
    </h2>
    <table class="wovenodd" border="1">
      <tr>
        <td class="wovenodd-col2" colspan="2">
	    <xsl:text>&lt;</xsl:text>
	    <span>
	      <xsl:attribute name="class">
		<xsl:text>label</xsl:text>
	      </xsl:attribute>
	      <xsl:choose>
		<xsl:when test="tei:content/rng:empty">
		  <span class="emptySlash">
		    <xsl:value-of select="$name"/>
		  </span>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="$name"/>
		</xsl:otherwise>
	      </xsl:choose>
	    </span>
	    <xsl:text>&gt; </xsl:text>
          <xsl:call-template name="makeDescription"/>
          <xsl:if test="tei:listRef">
            <xsl:for-each select="tei:listRef/tei:ptr">
              <xsl:text> </xsl:text>
              <xsl:apply-templates mode="weave" select="."/>
            </xsl:for-each>
          </xsl:if>
        </td>
      </tr>
      <xsl:if test="@module">
        <xsl:call-template name="moduleInfo"/>
      </xsl:if>
      <tr>
        <td class="wovenodd-col1">
          <span class="label">
            <xsl:call-template name="i18n">
              <xsl:with-param name="word">Attributes</xsl:with-param>
            </xsl:call-template>
          </span>
        </td>
        <td class="wovenodd-col2">
          <xsl:choose>
            <xsl:when test="not(tei:attList)">
              <xsl:call-template name="showAttClasses"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:for-each select="tei:attList">
                <xsl:call-template name="displayAttList">
                  <xsl:with-param name="mode">all</xsl:with-param>
                </xsl:call-template>
              </xsl:for-each>
            </xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
      <xsl:apply-templates mode="weave"/>
      <tr>
        <td class="wovenodd-col1">
          <span class="label">Contained by</span>
        </td>
        <td class="wovenodd-col2">
          <xsl:call-template name="generateParents"/>
        </td>
      </tr>

      <tr>
        <td class="wovenodd-col1">
          <span class="label">
	  <xsl:call-template name="i18n">
            <xsl:with-param name="word">
	      <xsl:text>May contain</xsl:text>
	    </xsl:with-param>
	  </xsl:call-template>
	  </span>
        </td>
        <td class="wovenodd-col2">
          <xsl:call-template name="generateChildren"/>
        </td>
      </tr>


    </table>

  </xsl:template>


  <xsl:template match="tei:hi[@rend='math']">
    <span class="math">
      <xsl:apply-templates/>
    </span>
  </xsl:template>


<xsl:template match="tei:ptr[@type='cit']">
 <a class="citlink">
  <xsl:for-each select="key('IDS',substring-after(@target,'#'))">
    <xsl:attribute name="href">
      <xsl:apply-templates select="."  mode="generateLink"/>
    </xsl:attribute>
    <xsl:apply-templates select="." mode="xref"/>
  </xsl:for-each>
 </a>
</xsl:template>




  <xsl:template name="makeHTMLHeading">
    <xsl:param name="text"/>
    <xsl:param name="class">title</xsl:param>
    <xsl:param name="level">1</xsl:param>
    <xsl:if test="not($text='')">
      <xsl:choose>
        <xsl:when test="$level='1'">
          <xsl:element name="h1">
            <xsl:attribute name="class">
              <xsl:value-of select="$class"/>
            </xsl:attribute>
            <a href="index.html"><xsl:value-of select="$text"/></a>
          </xsl:element>
          </xsl:when>
          <xsl:otherwise>
      <xsl:element name="h{$level}">
        <xsl:attribute name="class">
          <xsl:value-of select="$class"/>
        </xsl:attribute>
        <xsl:value-of select="$text"/>
      </xsl:element>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:if>
  </xsl:template>
  


<xsl:template match="tei:divGen[@type='macrocat']">

  <h3>Alphabetical list</h3>
  <xsl:apply-templates mode="weave" select="key('MACRODOCS',1)">
    <xsl:sort select="@ident"/>
  </xsl:apply-templates>

  <xsl:for-each select="key('MACRODOCS',1)">
    <xsl:sort select="@module"/>
    <xsl:if
	test="generate-id(.)=generate-id(key('MACRO-MODULE',@module)[1])">
      <div id='macro-{@module}'>
      <h3>
	<xsl:for-each select="key('MODULES',@module)">
	  <xsl:text>[</xsl:text>
	  <xsl:value-of select="@ident"/>
	  <xsl:text>] </xsl:text>
	  <xsl:value-of select="tei:desc"/>
	</xsl:for-each>
      </h3>
      <xsl:apply-templates mode="weave"
			   select="key('MACRO-MODULE',@module)">
	<xsl:sort select="@ident"/>
      </xsl:apply-templates>
      </div>
    </xsl:if>
  </xsl:for-each>
</xsl:template>


<xsl:template match="tei:divGen[@type='elementcat']">
  <div class="atozwrapper">
   <xsl:call-template name="atozHeader">
     <xsl:with-param name="Key">ELEMENT-ALPHA</xsl:with-param>
   </xsl:call-template>
    <xsl:for-each select="key('ELEMENTDOCS',1)">
    <xsl:sort select="translate(@ident,$uc,$lc)"/>
    <xsl:variable name="letter">
      <xsl:value-of select="substring(@ident,1,1)"/>
    </xsl:variable>
    <xsl:if
	test="generate-id(.)=generate-id(key('ELEMENT-ALPHA',$letter)[1])">
      <div  id="element-{$letter}" class="atoz">	
	<span class="listhead">
	  <xsl:value-of select="$letter"/>
	</span>
      <ul class="atoz">	
	<xsl:for-each select="key('ELEMENT-ALPHA',$letter)">
	  <xsl:sort select="@ident"/>
	  <li>
	    <xsl:apply-templates select="." mode="weave"/>
	  </li>
	</xsl:for-each>
      </ul>
      </div>
    </xsl:if>

    </xsl:for-each>
  </div>
  <div id="byMod">
    <xsl:for-each select="key('ELEMENTDOCS',1)">
      <xsl:sort select="@module"/>
      <xsl:if
	  test="generate-id(.)=generate-id(key('ELEMENT-MODULE',@module)[1])">
	<div>
	  <h3>
	    <xsl:for-each select="key('MODULES',@module)">
	      <xsl:text>[</xsl:text>
	      <xsl:value-of select="@ident"/>
	      <xsl:text>] </xsl:text>
	      <xsl:value-of select="tei:desc"/>
	    </xsl:for-each>
	  </h3>
	  <xsl:apply-templates mode="weave"
			       select="key('ELEMENT-MODULE',@module)">
	    <xsl:sort select="@ident"/>
	  </xsl:apply-templates>
	</div>
      </xsl:if>
    </xsl:for-each>
  </div>
</xsl:template>

<xsl:template match="tei:divGen[@type='modelclasscat']">
<div class="atozwrapper">
   <xsl:call-template name="atozHeader">
     <xsl:with-param name="Key">MODEL-CLASS-ALPHA</xsl:with-param>
   </xsl:call-template>

    <xsl:for-each select="key('MODELCLASSDOCS',1)">
    <xsl:sort select="translate(substring-after(@ident,'model.'),$uc,$lc)"/>
    <xsl:variable name="letter">
      <xsl:value-of select="substring(@ident,7,1)"/>
    </xsl:variable>
    <xsl:if
	test="generate-id(.)=generate-id(key('MODEL-CLASS-ALPHA',$letter)[1])">
      <div  id="element-{$letter}" class="atoz">		
	<span class="listhead">
	  <xsl:value-of select="$letter"/>
	</span>
	<ul class="atoz">	
	  <xsl:for-each select="key('MODEL-CLASS-ALPHA',$letter)">
	    <xsl:sort select="translate(substring-after(@ident,'model.'),$lc,$uc)"/>
	    <li>
	      <xsl:apply-templates select="." mode="weave"/>
	    </li>
	  </xsl:for-each>
	</ul>
      </div>
    </xsl:if>
  </xsl:for-each>
</div>
  <div id="byMod">
    <xsl:for-each select="key('MODELCLASSDOCS',1)">
      <xsl:sort select="@module"/>
      <xsl:if
	  test="generate-id(.)=generate-id(key('MODEL-CLASS-MODULE',@module)[1])">
	<div>
	  <h3>
	    <xsl:for-each select="key('MODULES',@module)">
	      <xsl:text>[</xsl:text>
	      <xsl:value-of select="@ident"/>
	      <xsl:text>] </xsl:text>
	      <xsl:value-of select="tei:desc"/>
	    </xsl:for-each>
	  </h3>
	  <xsl:apply-templates mode="weave"
			       select="key('MODEL-CLASS-MODULE',@module)">
	    <xsl:sort select="@ident"/>
	  </xsl:apply-templates>
	</div>
      </xsl:if>
    </xsl:for-each>
  </div>

</xsl:template>

<xsl:template match="tei:divGen[@type='attclasscat']">
  <div class="atozwrapper">
   <xsl:call-template name="atozHeader">
     <xsl:with-param name="Key">ATT-CLASS-ALPHA</xsl:with-param>
   </xsl:call-template>

   <xsl:for-each select="key('ATTCLASSDOCS',1)">
     <xsl:sort select="translate(substring-after(@ident,'att.'),$uc,$lc)"/>
     <xsl:variable name="letter">
       <xsl:value-of select="substring(@ident,5,1)"/>
     </xsl:variable>
     <xsl:if
	 test="generate-id(.)=generate-id(key('ATT-CLASS-ALPHA',$letter)[1])">
      <div  id="element-{$letter}" class="atoz">		
	<span class="listhead">
	  <xsl:value-of select="$letter"/>
	</span>
       <ul class="atoz">	
	 <xsl:for-each select="key('ATT-CLASS-ALPHA',$letter)">
	   <xsl:sort select="translate(substring-after(@ident,'att.'),$lc,$uc)"/>
	   <li>
	     <xsl:apply-templates select="." mode="weave"/>
	   </li>
	 </xsl:for-each>
       </ul>
      </div>
     </xsl:if>
   </xsl:for-each>
  </div>
   <div id="byMod">
     <xsl:for-each select="key('ATTCLASSDOCS',1)">
       <xsl:sort select="@module"/>
       <xsl:if
	   test="generate-id(.)=generate-id(key('ATT-CLASS-MODULE',@module)[1])">
	 <div>
	   <h3>
	     <xsl:for-each select="key('MODULES',@module)">
	      <xsl:text>[</xsl:text>
	      <xsl:value-of select="@ident"/>
	      <xsl:text>] </xsl:text>
	      <xsl:value-of select="tei:desc"/>
	     </xsl:for-each>
	   </h3>
	   <xsl:apply-templates mode="weave"
				select="key('ATT-CLASS-MODULE',@module)">
	     <xsl:sort select="@ident"/>
	   </xsl:apply-templates>
	 </div>
       </xsl:if>
     </xsl:for-each>
  </div>

</xsl:template>

<xsl:template name="atozHeader">
  <xsl:param name="Key"/>
  <div id="azindex">
    <span>Sorted alphabetically, starting with:</span>
    <ul class="index">     
      <xsl:if test="count(key($Key,'a'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-a');" href="#">a</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'b'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-b');" href="#">b</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'c'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-c');" href="#">c</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'d'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-d');" href="#">d</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'e'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-e');" href="#">e</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'f'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-f');" href="#">f</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'g'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-g');" href="#">g</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'h'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-h');" href="#">h</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'i'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-i');" href="#">i</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'j'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-j');" href="#">j</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'k'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-k');" href="#">k</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'l'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-l');" href="#">l</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'m'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-m');" href="#">m</a>
      </li>      
      </xsl:if>
      <xsl:if test="count(key($Key,'n'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-n');" href="#">n</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'o'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-o');" href="#">o</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'p'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-p');" href="#">p</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'q'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-q');" href="#">q</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'r'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-r');" href="#">r</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'s'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-s');" href="#">s</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'t'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-t');" href="#">t</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'u'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-u');" href="#">u</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'v'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-v');" href="#">v</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'w'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-w');" href="#">w</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'x'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-x');" href="#">x</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'y'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-y');" href="#">y</a>
      </li>
      </xsl:if>
      <xsl:if test="count(key($Key,'z'))&gt;0">
      <li>
	<a onclick="hideallExcept('element-z');" href="#">z</a>
      </li>
      </xsl:if>
      <li class="showall">
	<a onclick="showall();" href="#">Show All</a>
      </li>
      <li class="showall">
	<a onclick="showByMod();" href="#">Show by Module</a>
      </li>
    </ul>
  </div>
</xsl:template>

<xsl:template name="formatHeadingNumber">
  <xsl:param name="text"/>
  <xsl:param name="toc"/>
  <span class="headingNumber">
    <xsl:choose>
      <xsl:when test="$toc =''">
	<xsl:copy-of select="$text"/>
      </xsl:when>
      <xsl:when test="number(normalize-space($text))&lt;10">
	<xsl:text>&#8194;</xsl:text>
	<xsl:copy-of select="$text"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </span>
</xsl:template>




<xsl:template name="teiTOP">
<xsl:param name="name"/>
               
<script type="text/javascript" src="udm-dom.js">
    <xsl:comment>&#160;</xsl:comment>
</script>
<script type="text/javascript" src="udm-mod-keyboard.js">
  <xsl:comment>&#160;</xsl:comment>
</script>

<div id="container">
   <a href="#contentstart" 
      title="Skip to content" 
      class="skip">skip to content</a>
   <div id="banner">
     <img src="Images/banner.jpg"
	  alt="Text Encoding Initiative logo and banner"/>
   </div>
   
   <xsl:copy-of select="document('staticnav.xml')/html:ul"/>
</div>
<div
 class="mainhead">
  <h1>P5: Guidelines for Electronic Text Encoding and Interchange</h1>
</div>
</xsl:template>

<xsl:template name="lineBreak">
  <xsl:param name="id"/>
  <xsl:text disable-output-escaping="yes">&lt;br/&gt;</xsl:text>
</xsl:template>

<!-- link from bibl back to egXML -->
<xsl:template match="tei:listBibl/tei:biblStruct|tei:listBibl/tei:bibl">
  <xsl:apply-templates/>
  <xsl:for-each select="key('BACKLINKS',@xml:id)">
    <xsl:if test="self::teix:egXML">
      <xsl:text> </xsl:text>
      <a class="link_return"
	 title="Go back to text">
	<xsl:attribute name="href">
	  <xsl:apply-templates select="." mode="generateLink"/>
	</xsl:attribute>
	<xsl:text>&#8629;</xsl:text>
      </a>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template name="egXMLHook">
  <xsl:if test="@corresp and key('IDS',substring-after(@corresp,'#'))">
    <div style="float: right;">
	<a>
	  <xsl:attribute name="href">
	    <xsl:apply-templates mode="generateLink"
				 select="key('IDS',substring-after(@corresp,'#'))"/>
	  </xsl:attribute>
	  <xsl:text>bibliography</xsl:text>
<!--	  <span class="citLink">&#x270d;</span>-->
	</a>
    </div>
  </xsl:if>
</xsl:template>


<xsl:template name="figureHook">
  <xsl:if test="@corresp and key('IDS',substring-after(@corresp,'#'))">
    <div style="float: right;">
      <a>
	<xsl:attribute name="href">
	  <xsl:apply-templates mode="generateLink"
			       select="key('IDS',substring-after(@corresp,'#'))"/>
	</xsl:attribute>
	<xsl:text>bibliography</xsl:text>
      </a>
    </div>
  </xsl:if>
</xsl:template>


  <xsl:template name="myi18n">
    <xsl:param name="word"/>
    <xsl:choose>
      <xsl:when test="$word='previousWord'">
        <span class="icon">
          <xsl:text>&#xab; </xsl:text>
        </span>
      </xsl:when>
      <xsl:when test="$word='upWord'">
        <span class="icon">
          <xsl:text>&#8593; </xsl:text>
        </span>
      </xsl:when>
      <xsl:when test="$word='nextWord'">
        <span class="icon">
          <xsl:text>&#xbb; </xsl:text>
        </span>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="navInterSep"> </xsl:template>

<xsl:key name="BACKLINKS" match="teix:egXML[@corresp]"
	 use="substring-after(@corresp,'#')"/>

<xsl:key name="BACKLINKS" match="tei:ptr[@type='cit']"
	 use="substring-after(@target,'#')"/>


  <xsl:key name="MODEL-CLASS-MODULE" match="tei:classSpec[@type='model']"  use="@module"/>
  <xsl:key name="ATT-CLASS-MODULE" match="tei:classSpec[@type='atts']"  use="@module"/>
  <xsl:key name="ELEMENT-MODULE" match="tei:elementSpec"
	   use="@module"/>
  <xsl:key name="MACRO-MODULE" match="tei:macroSpec"
	   use="@module"/>

  <xsl:key name="ELEMENT-ALPHA" match="tei:elementSpec"
	   use="substring(translate(@ident,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),1,1)"/>

  <xsl:key name="MODEL-CLASS-ALPHA" match="tei:classSpec[@type='model']"
	   use="substring(translate(@ident,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),7,1)"/>

  <xsl:key name="ATT-CLASS-ALPHA" match="tei:classSpec[@type='atts']"
	   use="substring(translate(@ident,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),5,1)"/>


  <xsl:template name="includeCSS">
    <link href="{$cssFile}" rel="stylesheet" type="text/css"/>
    <xsl:if test="not($cssPrintFile='')">
      <link href="{$cssPrintFile}" media="print" rel="stylesheet"
        type="text/css"/>
    </xsl:if>
    <xsl:if test="not($cssSecondaryFile = '')">
      <link href="{$cssSecondaryFile}" rel="stylesheet" type="text/css"/>
    </xsl:if>

  </xsl:template>

  <xsl:template name="generateSubTitle">
    <xsl:value-of select="tei:head"/>
  </xsl:template>


  <xsl:template name="printLink"/>


  <xsl:template match="tei:titlePage" mode="paging">
    <xsl:apply-templates select="."/>
  </xsl:template>

  <xsl:template match="/div"> </xsl:template>

  <xsl:template name="bitOut">
    <xsl:param name="grammar"/>
    <xsl:param name="content"/>
    <xsl:param name="element">pre</xsl:param>
    <xsl:choose>
      <xsl:when test="$displayMode='both'">
        <div class="displayRelax">
          <button class="displayRelax" onclick="togglerelax(this)"
            >Compact to XML format</button>
          <pre class="eg_rng" style="display:none">
            <xsl:apply-templates mode="verbatim"
              select="exsl:node-set($content)/*/*"/>
          </pre>
          <pre class="eg_rnc" style="display:block">
            <xsl:call-template name="make-body-from-r-t-f">
              <xsl:with-param name="schema">
                <xsl:for-each select="exsl:node-set($content)/*">
                  <xsl:call-template name="make-compact-schema"/>
                </xsl:for-each>
              </xsl:with-param>
            </xsl:call-template>
          </pre>
        </div>
      </xsl:when>
      <xsl:when test="$displayMode='rng'">
        <xsl:element name="{$element}">
          <xsl:attribute name="class">eg</xsl:attribute>
          <xsl:apply-templates mode="verbatim"
            select="exsl:node-set($content)/*/*"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$displayMode='rnc'">
        <xsl:element name="{$element}">
          <xsl:attribute name="class">eg</xsl:attribute>
          <xsl:call-template name="make-body-from-r-t-f">
            <xsl:with-param name="schema">
              <xsl:for-each select="exsl:node-set($content)/*">
                <xsl:call-template name="make-compact-schema"/>
              </xsl:for-each>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$element}">
          <xsl:attribute name="class">eg</xsl:attribute>
          <xsl:for-each select="exsl:node-set($content)/*">
            <xsl:apply-templates mode="literal"/>
          </xsl:for-each>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="javascriptHook">

  <script type="text/javascript" src="udm-all.js">
    <xsl:comment>&#160;</xsl:comment>
  </script>

    <script type="text/javascript">
      <xsl:comment>
        <xsl:text disable-output-escaping="yes">
states=new Array()
states[0]="element-a"
states[1]="element-b"
states[2]="element-c"
states[3]="element-d"
states[4]="element-e"
states[5]="element-f"
states[6]="element-g"
states[7]="element-h"
states[8]="element-i"
states[9]="element-j"
states[10]="element-k"
states[11]="element-l"
states[12]="element-m"
states[13]="element-n"
states[14]="element-o"
states[15]="element-p"
states[16]="element-q"
states[17]="element-r"
states[18]="element-s"
states[19]="element-t"
states[20]="element-u"
states[21]="element-v"
states[22]="element-w"
states[23]="element-x"
states[24]="element-y"
states[25]="element-z"

function startUp() {
 hideallExcept('');
}

function hideallExcept(elm) {
for (var i = 0; i &lt; states.length; i++) {
 var layer;
 if (layer = document.getElementById(states[i]) ) {
  if (states[i] != elm) {
    layer.style.display = "none";
  }
  else {
   layer.style.display = "block";
      }
  }
 }
 var mod;
 if ( mod = document.getElementById('byMod') ) {
     mod.style.display = "none";
 }
}

function showall() {
 for (var i = 0; i &lt; states.length; i++) {
   var layer;
   if (layer = document.getElementById(states[i]) ) {
      layer.style.display = "block";
      }
  }
}

function showByMod() {
  hideallExcept('');
  var mod;
  if (mod = document.getElementById('byMod') ) {
     mod.style.display = "block";
     }
}

function toggleToc(el){
   var item = el.parentNode; 
   for (j=0;j&lt;item.childNodes.length;j++)
   {
     if (item.childNodes[j].nodeType != 1) continue;
     if (item.childNodes[j].nodeName != 'UL') continue;
     var thisone=item.childNodes[j];
     var state=thisone.style.display;
     if (state == 'block')
      {  
        thisone.style.display='none'; 
	el.className="collapsed";
	el.title="Click here to expand list";
      }
     else
      {  
        thisone.style.display='block';
	el.className="expanded";
	el.title="Click here to collapse list";
      }
    }
  }

function togglerelax (el) {
    if (el.innerHTML == 'XML format to compact') {
         el.innerHTML = 'Compact to XML format';
      }
   else
     {
      el.innerHTML = 'XML format to compact';
   }
   var div = el.parentNode; 
   for (j=0;j&lt;div.childNodes.length;j++)
     {
       if (div.childNodes[j].nodeType != 1) continue;
       if (div.childNodes[j].nodeName != 'PRE') continue;
       var thisone=div.childNodes[j];
       var state=thisone.style.display;
       if (state == 'block')
        {  
       thisone.style.display='none'; 
        }
       else
        {  
       thisone.style.display='block';
       }
      }
  }
      </xsl:text>
      </xsl:comment>
    </script>
  </xsl:template>
  <xsl:template name="sectionHeadHook">
    <xsl:variable name="ident">
      <xsl:apply-templates mode="ident" select="."/>
    </xsl:variable>
    <xsl:variable name="d">
      <xsl:apply-templates mode="depth" select="."/>
    </xsl:variable>
    <xsl:if test="$d &gt; 0">
    <span class="bookmarklink">
      <a class="bookmarklink" href="#{$ident}">
	<xsl:attribute name="title">
	  <xsl:text>link to this section </xsl:text>
	</xsl:attribute>
	<span class="invisible">
	  <xsl:text>TEI: </xsl:text>
	  <xsl:value-of select="tei:head[1]"/>
	</span>
	<xsl:text>&#x00B6;</xsl:text>
      </a>
    </span>
    </xsl:if>
  </xsl:template>



</xsl:stylesheet>

