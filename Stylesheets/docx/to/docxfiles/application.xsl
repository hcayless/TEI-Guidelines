<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
    xmlns:cals="http://www.oasis-open.org/specs/tm9901"
    xmlns:contypes="http://schemas.openxmlformats.org/package/2006/content-types"
    xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcmitype="http://purl.org/dc/dcmitype/"
    xmlns:dcterms="http://purl.org/dc/terms/" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:iso="http://www.iso.org/ns/1.0" xmlns:its="http://www.w3.org/2005/11/its"
    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"
    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    xmlns:tbx="http://www.lisa.org/TBX-Specification.33.0.html"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
    xmlns:teix="http://www.tei-c.org/ns/Examples" xmlns:v="urn:schemas-microsoft-com:vml"
    xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
    xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:w10="urn:schemas-microsoft-com:office:word"
    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="cp ve o r m v wp w10 w wne mml tbx iso its
    tei a xs pic fn xsi dc dcterms dcmitype
    contypes teidocx teix html cals xd">

    <xsl:import href="../parameters.xsl"/>
    <xsl:import href="../placeholders.xsl"/>
    <xsl:import href="../../utils/functions.xsl"/>

    <xd:doc type="stylesheet">
        <xd:short> TEI stylesheet for making Word docx files from TEI XML </xd:short>
        <xd:detail> This library is free software; you can redistribute it and/or modify it under
            the terms of the GNU Lesser General Public License as published by the Free Software
            Foundation; either version 2.1 of the License, or (at your option) any later version.
            This library is distributed in the hope that it will be useful, but WITHOUT ANY
            WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
            PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details. You
            should have received a copy of the GNU Lesser General Public License along with this
            library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite
            330, Boston, MA 02111-1307 USA </xd:detail>
        <xd:author>See AUTHORS</xd:author>
        <xd:cvsId>$Id: to.xsl 6832 2009-10-12 22:42:59Z rahtz $</xd:cvsId>
        <xd:copyright>2008, TEI Consortium</xd:copyright>
    </xd:doc>

    <xsl:template name="write-docxfile-docprops-core">
        <xsl:variable name="now" select="teidocx:whatsTheDate()"/>

        <xsl:variable name="coreFile">
            <xsl:value-of select="$word-directory"/>
            <xsl:text>/docProps/core.xml</xsl:text>
        </xsl:variable>

        <xsl:variable name="createdDate">
            <xsl:choose>
                <xsl:when test="doc-available($coreFile)">
                    <xsl:for-each select="document($coreFile)">
                        <xsl:value-of select="cp:coreProperties/dcterms:created"/>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$now"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="revision">
            <xsl:choose>
                <xsl:when test="doc-available($coreFile)">
                    <xsl:for-each select="document($coreFile)">
                        <xsl:value-of select="cp:coreProperties/cp:revision + 1"/>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- after opening core.xml, we cannot write back to it; so save
            under new name -->
	<xsl:if test="$debug='true'">
	  <xsl:message>Writing out <xsl:value-of select="concat($word-directory,'/docProps/newcore.xml')"/></xsl:message>
	</xsl:if>

        <xsl:result-document href="{concat($word-directory,'/docProps/newcore.xml')}"
            standalone="yes">
            <cp:coreProperties>
                <dc:title>
                    <xsl:call-template name="generateTitle"/>
                </dc:title>
                <dc:creator>
                    <xsl:call-template name="created-by"/>
                </dc:creator>
                <cp:lastModifiedBy>TEIISO</cp:lastModifiedBy>
                <cp:revision>
                    <xsl:value-of select="$revision"/>
                </cp:revision>
                <dcterms:created xsi:type="dcterms:W3CDTF">
                    <xsl:value-of select="$createdDate"/>
                </dcterms:created>
                <dcterms:modified xsi:type="dcterms:W3CDTF">
                    <xsl:value-of select="$now"/>
                </dcterms:modified>
            </cp:coreProperties>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="write-docxfile-docprops-app">
	<xsl:if test="$debug='true'">
	  <xsl:message>Writing out <xsl:value-of select="concat($word-directory,'/docProps/app.xml')"/></xsl:message>
	</xsl:if>

        <xsl:result-document href="{concat($word-directory,'/docProps/app.xml')}" standalone="yes">
            <Properties
                xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties"
                xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
                <Template>Iso_Template.dotx</Template>
                <Application>TEIISO tei-docx.xsl</Application>
                <DocSecurity>0</DocSecurity>
                <SharedDoc>true</SharedDoc>
                <AppVersion>1.0</AppVersion>
            </Properties>
        </xsl:result-document>
    </xsl:template>

    <!-- after opening custom.xml, we cannot write back to it; so save
	 under new name -->
    <xsl:template name="write-docxfile-docprops-custom">
	<xsl:if test="$debug='true'">
	  <xsl:message>Writing out <xsl:value-of select="concat($word-directory,'docProps/newcustom.xml')"/></xsl:message>
	</xsl:if>

        <xsl:result-document href="{concat($word-directory,'/docProps/newcustom.xml')}"
            standalone="yes">
            <Properties
                xmlns="http://schemas.openxmlformats.org/officeDocument/2006/custom-properties"
                xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
                <property pid="2" name="DocIdentSDO">
                    <xsl:attribute name="fmtid">
                        <xsl:text>{D5CDD505-2E9C-101B-9397-08002B2CF9AE}</xsl:text>
                    </xsl:attribute>
                    <vt:lpwstr>
                        <xsl:value-of select="key('ISOMETA','organization')"/>
                    </vt:lpwstr>
                </property>
                <property pid="3" name="DocIdentProjectId">
                    <xsl:attribute name="fmtid">
                        <xsl:text>{D5CDD505-2E9C-101B-9397-08002B2CF9AE}</xsl:text>
                    </xsl:attribute>
                    <vt:lpwstr>
                        <xsl:value-of select="key('ISOMETA','projectId')"/>
                    </vt:lpwstr>
                </property>
                <property pid="4" name="DocIdentLanguage">
                    <xsl:attribute name="fmtid">
                        <xsl:text>{D5CDD505-2E9C-101B-9397-08002B2CF9AE}</xsl:text>
                    </xsl:attribute>
                    <vt:lpwstr>
                        <xsl:value-of select="/tei:TEI/@xml:lang"/>
                    </vt:lpwstr>
                </property>
                <property pid="5" name="DocIdentStage">
                    <xsl:attribute name="fmtid">
                        <xsl:text>{D5CDD505-2E9C-101B-9397-08002B2CF9AE}</xsl:text>
                    </xsl:attribute>
                    <vt:lpwstr>
                        <xsl:value-of select="key('ISOMETA','stage')"/>
                    </vt:lpwstr>
                </property>
                <property pid="6" name="DocIdentDate">
                    <xsl:attribute name="fmtid">
                        <xsl:text>{D5CDD505-2E9C-101B-9397-08002B2CF9AE}</xsl:text>
                    </xsl:attribute>
                    <vt:lpwstr>
                        <xsl:value-of select="key('ISOMETA','docdate')"/>
                    </vt:lpwstr>
                </property>
                <xsl:for-each select="key('ALLMETA',1)">
                    <xsl:if test="@iso:meta != 'projectId'">
                        <property name="{@iso:meta}">
                            <xsl:attribute name="pid">
                                <xsl:value-of select="position()+6"/>
                            </xsl:attribute>
                            <xsl:attribute name="fmtid">
                                <xsl:text>{D5CDD505-2E9C-101B-9397-08002B2CF9AE}</xsl:text>
                            </xsl:attribute>
                            <vt:lpwstr>
                                <xsl:value-of select="."/>
                            </vt:lpwstr>
                        </property>
                    </xsl:if>
                </xsl:for-each>
                <property pid="1000" name="TEI_toDOCX">
                    <xsl:attribute name="fmtid">
                        <xsl:text>{D5CDD505-2E9C-101B-9397-08002B2CF9AE}</xsl:text>
                    </xsl:attribute>
                    <vt:lpwstr>2.6.0</vt:lpwstr>
                </property>
                <property pid="1001" name="WordTemplateURI">
                    <xsl:attribute name="fmtid">
                        <xsl:text>{D5CDD505-2E9C-101B-9397-08002B2CF9AE}</xsl:text>
                    </xsl:attribute>
                    <vt:lpwstr>
                        <xsl:value-of
                            select="ancestor-or-self::tei:TEI/tei:teiHeader/tei:encodingDesc/tei:appInfo/tei:application[@ident='WordTemplate']/tei:ptr/@target"
                        />
                    </vt:lpwstr>
                </property>
                <xsl:for-each
                    select="ancestor-or-self::tei:TEI/tei:teiHeader/tei:encodingDesc/tei:appInfo/tei:application">
                    <xsl:if test="not(@ident='TEI_toDOCX')">
                        <property name="{@ident}">
                            <xsl:attribute name="pid">
                                <xsl:value-of select="position()+1001"/>
                            </xsl:attribute>
                            <xsl:attribute name="fmtid">
                                <xsl:text>{D5CDD505-2E9C-101B-9397-08002B2CF9AE}</xsl:text>
                            </xsl:attribute>
                            <vt:lpwstr>
                                <xsl:value-of select="@version"/>
                            </vt:lpwstr>
                        </property>
                    </xsl:if>
                </xsl:for-each>
            </Properties>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>
