<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes" cdata-section-elements="text"/>

    <xsl:template match="/">
        <items>
            <xsl:for-each select="items/item">
                <item>
                    <xsl:attribute name="externalID">
                        <xsl:value-of select="@externalID"/>
                    </xsl:attribute>
                    <xsl:for-each select="column">
                        <column>
                            <xsl:attribute name="source">
                                <xsl:value-of select="@sequence"/>
                            </xsl:attribute>
                            <rawData>
                                <text>
                                    <xsl:value-of select="rawData/text"/>
                                </text>
                            </rawData>
                        </column>
                    </xsl:for-each>
                </item>
            </xsl:for-each>
        </items>
    </xsl:template>

</xsl:stylesheet>