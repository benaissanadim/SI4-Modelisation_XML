<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="html" indent="yes"/>
   <xsl:param name="client_count" select="0"/>
   <xsl:template match="/">
      <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
      <html>
         <head>
            <title>Liste des clients fidèles pour chaque agence</title>
            <link rel="stylesheet" type="text/css" href="scenario2.css"/>
         </head>
         <body>
            <h1> Liste des clients fidèles pour chaque agence </h1>
            <div class="body">
               <xsl:for-each select="ORGANISME/AGENCES/AGENCE">
                  <div class="agency">
                     <h2>
                        <xsl:value-of select="NOM"/>
                     </h2>
                     <xsl:text>&#10;</xsl:text>
                     <div class="clients">
                        <h3>
                           <xsl:text>Les clients ayant fait au moins 3 voyages</xsl:text>
                        </h3>
                        <xsl:text>&#10;</xsl:text>
                        <ul>
                           <xsl:for-each select="SEJOURS/SEJOUR/SESSIONS//CLIENT_REF">
                              <xsl:sort select="count(ancestor::AGENCE[1]//SESSION//CLIENT_REF[@idref=current()/@idref])" data-type="number" order="descending"/>
                              <xsl:variable name="client_id" select="@idref"/>
                              <xsl:variable name="redondances" select="count(ancestor::AGENCE[1]//SESSION//CLIENT_REF[@idref=$client_id])"/>
                              <xsl:if test=" $redondances &gt; 2 and not(preceding::CLIENT_REF[@idref=$client_id])">
                                 <xsl:for-each select="//CLIENT[@id=$client_id]">
                                    <xsl:sort select="../NOM" data-type="text" order="ascending"/>
                                    <xsl:sort select="$redondances" data-type="number" order="descending"/>
                                    <li>
                                       <span>
                                          <xsl:value-of select="concat(./NOM, ' ', ./PRENOM)"/>
                                       </span> : a voyage :
                                       <xsl:value-of select="$redondances"/> fois
                                    </li>
                                 </xsl:for-each>
                              </xsl:if>
                           </xsl:for-each>
                        </ul>
                     </div>
                  </div>
                  <xsl:text>&#10;</xsl:text>
               </xsl:for-each>
            </div>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>