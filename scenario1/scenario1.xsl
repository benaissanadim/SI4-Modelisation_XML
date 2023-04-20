<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>Liste des séjours</title>
        <link rel="stylesheet" type="text/css" href="scenario1.css"/>
      </head>
      <body>
        <xsl:variable name="dateDebut" select="'2023-01-01'" />
        <xsl:variable name="dateDebutYear" select="substring($dateDebut, 1, 4)" />
        <xsl:variable name="dateDebutMonth" select="substring($dateDebut, 6, 2)" />
        <xsl:variable name="dateDebutDay" select="substring($dateDebut, 9, 2)" />
        <xsl:variable name="dateFin" select="'2023-04-30'" />
        <xsl:variable name="dateFinYear" select="substring($dateFin, 1, 4)" />
        <xsl:variable name="dateFinMonth" select="substring($dateFin, 6, 2)" />
        <xsl:variable name="dateFintDay" select="substring($dateFin, 9, 2)" />
        <h1>Liste des séjours disponibles du
          <xsl:value-of select="$dateDebut" /> au
          <xsl:value-of select="$dateFin" />
        </h1>
        <div class="cartes">
          <xsl:for-each select="//SEJOUR">
            <xsl:sort select="TARIF" data-type="text" order="ascending"/>
            <xsl:if test="count(SESSIONS/SESSION[substring(DEBUT, 1, 4) &gt;= $dateDebutYear 
    and substring(DEBUT, 6, 2) &gt;= $dateDebutMonth 
     and substring(DEBUT, 9, 2) &gt;= $dateDebutDay 
     and substring(FIN, 1, 4) &lt;= $dateFinYear 
     and substring(FIN, 6, 2) &lt;= $dateFinMonth 
     and substring(FIN, 9, 2)&lt;= $dateFintDay]) &gt; 0">
              <div class="sejour">
                <h2>
                  <xsl:value-of select="NOM"/>
                </h2>
                <xsl:variable name="villes" select="DESTINATIONS/DESTINATION_REF"/>
                <xsl:variable name="nb_villes" select="count($villes)"/>
                <xsl:variable name="pays" select="//DESTINATION[@id = $villes[1]/@idref]/PAYS"/>
                <p>
                  <span>
                    <xsl:text>Destination :  </xsl:text>
                  </span>
                  <xsl:choose>
                    <xsl:when test="$nb_villes = 1">
                      <xsl:value-of select="//DESTINATION[@id = $villes[1]/@idref]/VILLE"/>
                      <xsl:text>, </xsl:text>
                      <xsl:value-of select="$pays"/>
                    </xsl:when>
                    <xsl:when test="$nb_villes = 2">
                      <xsl:value-of select="//DESTINATION[@id = $villes[1]/@idref]/VILLE"/>
                      <xsl:text> et </xsl:text>
                      <xsl:value-of select="//DESTINATION[@id = $villes[2]/@idref]/VILLE"/>
                      <xsl:text>, </xsl:text>
                      <xsl:value-of select="$pays"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:for-each select="$villes">
                        <xsl:variable name="destination" select="//DESTINATION[@id = current()/@idref]"/>
                        <xsl:value-of select="$destination/VILLE"/>
                        <xsl:if test="position() != last()">
                          <xsl:text>, </xsl:text>
                        </xsl:if>
                      </xsl:for-each>
                      <xsl:text>, </xsl:text>
                      <xsl:value-of select="$pays"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </p>
                <p>
                  <span>Langue enseignée : </span>
                  <xsl:for-each select="LANGUES_ENSEIGNEES/LANGUE_ENSEIGNEE">
                    <xsl:variable name="langue_idref" select="@idref"/>
                    <xsl:variable name="langue_info" select="//LANGUE[@id = $langue_idref]"/>
                    <xsl:value-of select="concat($langue_info/NOM, ', niveau ', $langue_info/NIVEAU)"/>
                    <xsl:if test="position() != last()">, </xsl:if>
                  </xsl:for-each>
                </p>
                <p>
                  <span>Type de séjour: </span>
                  <xsl:value-of select="@type"/>
                </p>
                <p>
                  <span>
                    <xsl:text>Public destinés :  </xsl:text>
                  </span>
                  <xsl:value-of select="string-join(TYPES_PUBLIC/TYPE_PUBLIC, ', ')"/>
                </p>
                <p>
                  <span>Description: </span>
                  <xsl:value-of select="DESCRIPTION"/>
                </p>
                <p>
                  <span> Activités durant le séjour :</span>
                  <xsl:for-each select="ACTIVITEES/ACTIVITEE[not(@type = preceding-sibling::ACTIVITEE/@type)]">
                    <div class="activites">
                      <act>
                        <xsl:value-of select="@type"/>
                      </act>
                      <ul>
                        <xsl:for-each select="../ACTIVITEE[@type=current()/@type]">
                          <li>
                            <xsl:value-of select="DESCRIPTION"/>
                          </li>
                        </xsl:for-each>
                      </ul>
                    </div>
                  </xsl:for-each>
                </p>
                <p>
                  <span>Tarif: </span>
                  <xsl:value-of select="TARIF"/>
                </p>
                <xsl:variable name="sessions" select="SESSIONS/SESSION"/>
                <p>
                  <span>Sessions disponibles : </span>
                </p>
                <xsl:for-each select="$sessions">
                  <xsl:variable name="dateDebutYear1" select="substring(DEBUT, 1, 4)" />
                  <xsl:variable name="dateDebutMonth1" select="substring(DEBUT, 6, 2)" />
                  <xsl:variable name="dateDebutDay1" select="substring(DEBUT, 9, 2)" />
                  <xsl:if test="substring(DEBUT, 1, 4) &gt;= $dateDebutYear 
        and substring(DEBUT, 6, 2) &gt;= $dateDebutMonth 
         and substring(DEBUT, 9, 2) &gt;= $dateDebutDay 
         and substring(FIN, 1, 4) &lt;= $dateFinYear 
         and substring(FIN, 6, 2) &lt;= $dateFinMonth 
         and substring(FIN, 9, 2)&lt;= $dateFintDay">
                    <xsl:variable name="enseignants" select="count(PARTICIPANTS/PERSONNELS/ENSEIGNANTS/ENSEIGNANT_REF)"/>
                    <xsl:variable name="accompagnateurs" select="count(PARTICIPANTS/PERSONNELS/ACCOMPAGNATEURS/ACCOMPAGNATEUR_REF)"/>
                    <xsl:variable name="clients" select="count(PARTICIPANTS/CLIENTS/CLIENT_REF)"/>
                    <xsl:text>- Session </xsl:text>
                    <xsl:value-of select="position()"/>
                    <xsl:text> du </xsl:text>
                    <xsl:value-of select="DEBUT"/>
                    <xsl:text> au </xsl:text>
                    <xsl:value-of select="FIN"/>
                    <xsl:text> :</xsl:text>
                    <div class="activites">
                      <ul>
                        <li>
                          <xsl:text> Nombre de personnels :</xsl:text>
                          <xsl:value-of select="$enseignants"/>
                          <xsl:text> enseignants et </xsl:text>
                          <xsl:value-of select="$accompagnateurs"/>
                          <xsl:text> accompagnants</xsl:text>
                        </li>
                        <li>
                          <xsl:text>Nombre de clients inscrits : </xsl:text>
                          <xsl:value-of select="$clients"/>
                        </li>
                      </ul>
                    </div>
                  </xsl:if>
                </xsl:for-each>
                <h4>
Ce séjour est proposé par l'agence :
                  <xsl:text/>
                  <xsl:value-of select="concat(ancestor::AGENCE[1]/NOM, ' située à ',
    normalize-space(ancestor::AGENCE[1]/ADRESSE), ' ',
    ancestor::AGENCE[1]/CP, ' ',
    ancestor::AGENCE[1]/VILLE, ' ',
    ancestor::AGENCE[1]/PAYS)"/>
                </h4>
              </div>
            </xsl:if>
          </xsl:for-each>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>