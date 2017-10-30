<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:css="urn:ns:org.dita-community.css-pdf"
  exclude-result-prefixes="xs css"
  version="2.0">
  <!-- =============================================
       Overrides for adding elements that contribute
       to running heads and feet for CSS pagination.
       ============================================= -->

  <!-- Override from diat2html5Impl.xsl -->
  <!-- NESTED TOPIC TITLES (sensitive to nesting depth, but are still processed for contained markup) -->
  <!-- 1st level - topic/title -->
  <!-- Condensed topic title into single template without priorities; use $headinglevel to set heading.
       If desired, somebody could pass in the value to manually set the heading level -->
  <xsl:template match="*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]">
    <xsl:param name="headinglevel" as="xs:integer">
      <xsl:choose>
        <xsl:when test="count(ancestor::*[contains(@class, ' topic/topic ')]) > 6">6</xsl:when>
        <xsl:otherwise><xsl:sequence select="count(ancestor::*[contains(@class, ' topic/topic ')])"/></xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:element name="h{$headinglevel}">
      <xsl:attribute name="class">topictitle<xsl:value-of select="$headinglevel"/></xsl:attribute>
      <xsl:call-template name="commonattributes">
        <xsl:with-param name="default-output-class">topictitle<xsl:value-of select="$headinglevel"/></xsl:with-param>
      </xsl:call-template>
      <xsl:attribute name="id"><xsl:apply-templates select="." mode="return-aria-label-id"/></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
    <xsl:apply-templates select="." mode="css:edge-region-content">
      <xsl:with-param name="headinglevel" as="xs:integer" tunnel="yes" select="$headinglevel"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template mode="css:edge-region-content" match="*[contains(@class, ' topic/title ')]">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:variable name="doDebug" as="xs:boolean" select="true()"/>
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] css:edge-region-content: ancestors:</xsl:message>
      <xsl:for-each select="ancestor::*[contains(@class, ' topic/topic ')]">
        <xsl:message>    <xsl:value-of select="name(.)"/>, id="<xsl:value-of select="./@id"/></xsl:message>
      </xsl:for-each>
    </xsl:if>
    <xsl:text>&#x0a;</xsl:text>
    <runningHeads><xsl:text>&#x0a;</xsl:text>
      <xsl:apply-templates select="ancestor::*[contains(@class, ' topic/topic ')]" mode="css:running-heads"/>
    </runningHeads><xsl:text>&#x0a;</xsl:text>
    <runningFeet><xsl:text>&#x0a;</xsl:text>
      <xsl:apply-templates select="ancestor::*[contains(@class, ' topic/topic ')]" mode="css:running-feet"/>
    </runningFeet><xsl:text>&#x0a;</xsl:text>
    <runningSideRegions><xsl:text>&#x0a;</xsl:text>
      <xsl:apply-templates select="ancestor::*[contains(@class, ' topic/topic ')]" mode="css:side-regions"/>
    </runningSideRegions><xsl:text>&#x0a;</xsl:text>
  </xsl:template>
  
  <!-- FIXME: Need to get document title from root map. The input HTML is just the topics.
       Root element is <dita>
    -->
  <xsl:template mode="css:running-heads" match="*[contains(@class, ' topic/topic ')]">
    <xsl:apply-templates mode="#current" select="*[contains(@class, ' topic/title ')]"/>
  </xsl:template>

  <xsl:template mode="css:running-heads" match="*[contains(@class, ' topic/title ')]">
    <xsl:param name="headinglevel" as="xs:integer" tunnel="yes"/>
    <xsl:element name="{concat('heading', $headinglevel)}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template mode="css:edge-region-content css:running-heads css:running-feet css:side-regions" match="text() | *" 
    priority="-1"
  />
  
</xsl:stylesheet>