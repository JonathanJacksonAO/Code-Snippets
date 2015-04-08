<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <html>
            <head>
                <style>
                    .collapsibleList li{
                    list-style-image:url('img/document.png');
                    cursor:auto;
                    }

                    li.collapsibleListOpen{
                    list-style-image:url('img/folderOpen.png');
                    cursor:pointer;
                    }

                    li.collapsibleListClosed{
                    list-style-image:url('img/folderClosed.png');
                    cursor:pointer;
                    }
                </style>
                <script type="text/javascript" src="libs/CollapsibleLists.js"></script>
                <script type="text/javascript">
                    document.addEventListener('DOMContentLoaded', function() {
                    CollapsibleLists.apply();
                    }, false);
                </script>
            </head>
            <body>

            </body>
        </html>
        <xsl:apply-templates />
    </xsl:template>
    <xsl:template name="matter" match="matter">
        <ul class="collapsibleList">
            <li>
                <xsl:value-of select="@name"></xsl:value-of> (<xsl:value-of select="@id"></xsl:value-of>)
                <ul>
                    <xsl:for-each select="directory">
                        <xsl:call-template name="directory"></xsl:call-template>
                    </xsl:for-each>
                </ul>
            </li>
        </ul>
    </xsl:template>
    <xsl:template name="directory" match="directory">
        <ul class="collapsibleList">
            <li>
                <xsl:value-of select="@name"></xsl:value-of>
                <xsl:for-each select="directory">
                    <xsl:call-template name="directory"></xsl:call-template>
                </xsl:for-each>
                <ul>
                    <xsl:for-each select="file">
                        <li>
                            <xsl:value-of select="@name"></xsl:value-of>
                        </li>
                    </xsl:for-each>
                </ul>
            </li>
        </ul>
    </xsl:template>
</xsl:stylesheet>