<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>
    <xsl:key name="langue-id" match="langue" use="@id"/>
    <xsl:template match="/">
        <LANGUES_ENSEIGNEES>
            <xsl:apply-templates select="//LANGUE_ENSEIGNEE"/>
        </LANGUES_ENSEIGNEES>
    </xsl:template>
    <xsl:template match="LANGUE_ENSEIGNEE">
        <xsl:variable name="agenceId" select="ancestor::AGENCE/@id"/>
        <xsl:variable name="langueId" select="@idref"/>S
        <xsl:variable name="langue" select="//LANGUES/LANGUE[@id = $langueId]" />
        <xsl:if test="$langue/NIVEAU ='A1'">
            <xsl:variable name="enseignant" select="//ENSEIGNANT[ENSEIGNEMENTS/LANGUE_REF[@idref = $langueId]]"/>
            <LANGUE_ENSEIGNEE>
                <INTITULE>
                    <xsl:value-of select="$langue/NOM"/>
                </INTITULE>
                <xsl:copy-of select="COURS"/>
                <xsl:copy-of select="TEST"/>
                <ENSEIGNANT>
                    <NOM>
                        <xsl:value-of select="$enseignant/NOM"/>
                    </NOM>
                    <PRENOM>
                        <xsl:value-of select="$enseignant/PRENOM"/>
                    </PRENOM>
                </ENSEIGNANT>
            </LANGUE_ENSEIGNEE>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>