<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <html>
            <head>
                <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
                <script type="text/javascript">
                    $(function(){
                    $('#example_tree').find('SPAN').click(function(e){
                    $(this).parent().find('UL').toggle();
                    });
                    });
                </script>
                <script type="text/javascript">
                    document.addEventListener('DOMContentLoaded', function() {
                    CollapsibleLists.apply();
                    }, false);
                </script>
            </head>
            <body>

            </body>
        </html>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template name="matter" match="matter">
        <ul class="collapsibleList">
            <li>
                <span>
                    <xsl:value-of select="@name"></xsl:value-of> (<xsl:value-of select="@id"></xsl:value-of>)
                    <ul>
                        <xsl:for-each select="directory">
                            <xsl:call-template name="directory"></xsl:call-template>
                        </xsl:for-each>
                    </ul>
                </span>
            </li>
        </ul>
    </xsl:template>
    <xsl:template name="directory" match="directory">
        <ul class="collapsibleList">
            <li>
                <span>
                    <xsl:value-of select="@name"></xsl:value-of>
                    <xsl:for-each select="directory">
                        <xsl:call-template name="directory"></xsl:call-template>
                    </xsl:for-each>
                    <ul>
                        <xsl:for-each select="file">
                            <li>
                                <span>
                                    <xsl:value-of select="@name"></xsl:value-of>
                                </span>
                            </li>
                        </xsl:for-each>
                    </ul>
                </span>
            </li>
        </ul>
    </xsl:template>
</xsl:stylesheet>