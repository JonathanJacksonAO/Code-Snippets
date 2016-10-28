<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <xsl:element name="CSA_PARTY">
            <xsl:for-each select="/sheet/head/headColumn">


                <xsl:if test="contains(current(), 'A.10 Contact details for CLIENT customer relationship manager')">
                    <xsl:variable name="A10POS" select="position()-1"/>
                    <xsl:for-each select="/sheet/data/item/column">
                        <xsl:if test="position()=$A10POS">
                            <xsl:element name="CLIENT_CONTACT_DETAILS">
                                <xsl:value-of select="rawData/text"/>
                            </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>


            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>