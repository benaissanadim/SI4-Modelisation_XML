<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>
  <xsl:template match="/">
    <xsl:text>{ "tests": [</xsl:text>
    <xsl:apply-templates select="//TEST"/>
    <xsl:text>]}</xsl:text>
  </xsl:template>
  <xsl:template match="TEST">
    <xsl:text>{ "nom": "</xsl:text>
    <xsl:value-of select="NOM"/>
    <xsl:text>",</xsl:text>
    <xsl:text>"questions": [</xsl:text>
    <xsl:apply-templates select="QUESTIONS/QUESTION"/>
    <xsl:text>]</xsl:text>
    <xsl:text>}</xsl:text>
    <xsl:if test="position() != last()">
      <xsl:text>,</xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="QUESTION">
    <xsl:text>{ "type": "</xsl:text>
    <xsl:value-of select="@type"/>
    <xsl:text>",</xsl:text>
    <xsl:text>"contenu": "</xsl:text>
    <xsl:value-of select="CONTENU"/>
    <xsl:text>",</xsl:text>
    <xsl:if test="@type = 'avec choix'">
      <xsl:text>"liste_choix": [</xsl:text>
      <xsl:for-each select="LISTE_CHOIX/CHOIX">
      {"choix" :
      "
        <xsl:value-of select="."/>"}
        <xsl:if test="position() != last()">
          <xsl:text>,</xsl:text>
        </xsl:if>
      </xsl:for-each>
      <xsl:text>],</xsl:text>
    </xsl:if>
    <xsl:text>"points": </xsl:text>
    <xsl:value-of select="POINTS"/>
    <xsl:text>}</xsl:text>
    <xsl:if test="position() != last()">
      <xsl:text>,</xsl:text>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>