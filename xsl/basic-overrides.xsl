<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:css="urn:ns:org.dita-community.css-pdf"
  exclude-result-prefixes="xs css"
  version="2.0">
  <!-- ==============================================
       Overrides of basic element processing to 
       meet PDF requirements, e.g., putting
       figure titles at bottom of figure.
       
       NOTE: variable input.map contains the input
       map document.
       ============================================== -->
  
  <!-- Override of template from topic.xsl to add front and back cover articles. -->  
  <xsl:template match="*" mode="addContentToHtmlBodyElement">
    <main role="main">
      <!-- Override -->
      <xsl:call-template name="css:front-cover"/>      
      <xsl:call-template name="css:generate-main-toc"/>      
      <article role="article">
        <xsl:attribute name="aria-labelledby">
          <xsl:apply-templates select="*[contains(@class,' topic/title ')] |
            self::dita/*[1]/*[contains(@class,' topic/title ')]" mode="return-aria-label-id"/>
        </xsl:attribute>
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
        <xsl:apply-templates/> <!-- this will include all things within topic; therefore, -->
        <!-- title content will appear here by fall-through -->
        <!-- followed by prolog (but no fall-through is permitted for it) -->
        <!-- followed by body content, again by fall-through in document order -->
        <!-- followed by related links -->
        <!-- followed by child topics by fall-through -->
        <xsl:call-template name="gen-endnotes"/>    <!-- include footnote-endnotes -->
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
      </article>
      <!-- Override -->
      <xsl:call-template name="css:back-cover"/>
    </main>
  </xsl:template>
  
  
  <xsl:template name="css:front-cover">
    <article class="front-cover" id="front-cover">
      <xsl:apply-templates 
        mode="css:front-cover"
        select="$input.map/*/*[contains(@class, ' map/topicmeta ')]//*[contains(@class, ' map/prodname ')]" 
      />
      <xsl:apply-templates 
        mode="css:front-cover"
        select="$input.map/*/*[contains(@class, ' topic/title ')]" 
      />
      <xsl:apply-templates 
        mode="css:front-cover"
        select="$input.map/*/*[contains(@class, ' map/topicmeta ')] 
                except (.//*[contains(@class, ' map/prodname ')])" 
      />
    </article>          
  </xsl:template>
  
  <xsl:template mode="css:front-cover css:back-cover" 
    match="*[contains(@class, ' topic/prodnumber ')] | 
           *[contains(@class, ' topic/publisher ')] |
           *[contains(@class, ' topic/prodname ')]">
    <div class="{name(.)}">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template mode="css:front-cover css:back-cover" match="*[contains(@class, ' topic/title ')]">
    <div class="publication-title">
      <div class="main-title"><xsl:apply-templates/></div>
    </div>
  </xsl:template>
    
  <xsl:template mode="css:back-cover css:front-cover" match="*[contains(@class, ' map/topicmeta ')]">
    <div class="topicmeta">
      <xsl:apply-templates mode="#current"/>
    </div>
  </xsl:template>
  
  <xsl:template name="css:back-cover">
    <article class="back-cover" id="back-cover">
      <xsl:apply-templates 
        mode="css:back-cover"
        select="$input.map/*/*[contains(@class, ' topic/title ')]" 
      />
      <xsl:apply-templates 
        mode="css:back-cover"
        select="$input.map/*/*[contains(@class, ' map/topicmeta ')]" 
      />
    </article>      
  </xsl:template>
  
  <xsl:template mode="css:front-cover css:back-cover" 
    match="*[contains(@class, ' map/topicmeta ')]//*"
    priority="-1"
    >
    <div class="{name(.)}">
      <xsl:apply-templates mode="#current"/>
    </div>
  </xsl:template>
  
  <xsl:template mode="css:front-cover css:back-cover" match="text()">
    <!-- No text by default -->
  </xsl:template>
  
</xsl:stylesheet>