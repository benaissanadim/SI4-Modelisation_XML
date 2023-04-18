<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- Define a variable to hold the number of reviews to display -->
  <xsl:variable name="numReviews" select="3" />
  
  <xsl:template match="/">
    <html>
      <head>
         <title>Liste des avis</title>
         <link rel="stylesheet" type="text/css" href="scenario3.css"/>
      </head>
      <body>
         <h1> Les avis des différents séjours pour chaque agence </h1>
        <xsl:for-each select="//AGENCE">

        <div class="agence">
         <h2> <xsl:value-of select="NOM"/> </h2> 

        <xsl:for-each select="SEJOURS/SEJOUR">
        <xsl:variable name="numAvis" select="count(LISTE_AVIS/AVIS)" />
        <xsl:if test="$numAvis &gt; 0">

         <div class="sejour">

        <h4> <xsl:value-of select="NOM"/> </h4> 

          <div class="global">
            <p>Nombre d'avis: <xsl:value-of select="$numAvis"/></p>

          <xsl:if test="$numAvis &gt; 0">

          <p>Note globale <span class="note"><xsl:value-of select="sum(LISTE_AVIS/AVIS/NOTE) div count(LISTE_AVIS/AVIS)"/>/10</span></p>
          </xsl:if>
          </div>
          <!-- Select the last N reviews to display -->
          <xsl:if test="$numAvis &gt;= 3">
            <h5>Affichage des 3 derniers avis disponibles :</h5>
            </xsl:if>
            <xsl:if test="$numAvis = 2 ">
               <h5>Affichage des 2 avis disponibles :</h5>
               </xsl:if>

               <xsl:if test="$numAvis = 1 ">
                  <h5>Affichage de l'avis disponible :</h5>
            </xsl:if>


                  <xsl:if test="$numAvis &gt; 0">

            <xsl:for-each select="LISTE_AVIS/AVIS">
                  <xsl:sort select="DATE" order="descending" />
                  <xsl:if test="position() &lt;= 3">

               <xsl:variable name="clientId" select="CLIENT_REF/@idref" />
               <xsl:variable name="client" select="//CLIENTS/CLIENT[@id = $clientId]" />

               <div class="client">
                  <p><span class="nom"> <xsl:value-of select="$client/PRENOM" /> 
                     <xsl:text> </xsl:text>
                     <xsl:value-of select="$client/NOM" /></span> : ajoutée le <xsl:value-of select="DATE"/> </p>
                     <p>Note : <span class="note"><xsl:value-of select="NOTE"/>/10</span></p>
                     <p>Commentaire : <span class="commentaire"><xsl:value-of select="COMMENTAIRE"/></span></p>
                 </div>
              </xsl:if>
            </xsl:for-each>
          </xsl:if>
         </div>
      </xsl:if>
        </xsl:for-each>
        </div>
      </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>