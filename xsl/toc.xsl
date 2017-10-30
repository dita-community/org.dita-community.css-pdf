<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:css="urn:ns:org.dita-community.css-pdf"
  exclude-result-prefixes="xs css"
  version="2.0">
  <!-- =================================================
       ToC and other generated list generation
       
       NOTE: variable input.map contains the input
       map document.
       ================================================= -->
  
  <!-- TBD -->
  
  <!-- See template:
    
    <xsl:template match="*[contains(@class, ' map/map ')]" mode="toc">
    
    In map2html5Impl.xsl
   -->
  <xsl:template name="css:generate-main-toc">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <article class="main-toc" id="main-toc">
      <h1 class="title topictitle1" >
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'Contents'"/>
        </xsl:call-template>        
      </h1>
      <div class="toc">
        <ul>
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates select="$input.map" mode="toc">
            <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
          </xsl:apply-templates>
        </ul>
      </div>
    </article>
  </xsl:template>
</xsl:stylesheet>