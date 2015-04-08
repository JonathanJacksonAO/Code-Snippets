<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <html>
            <head>
                <style>
                    .directory {
                    font-size: 1.0em;
                    color: #b23427;
                    font-family: Georgia,'Palatino Linotype','Times New Roman',Times,serif;
                    font-weight: normal;
                    padding-left: 22px; /* width of the image plus a little extra padding */
                    display: block; /* may not need this, but I've found I do */
                    }
                    li.d {
                    list-style-image: url("img/folder.jpg");
                    }
                    .file {
                    font-size: 1.0em;
                    color: #b23427;
                    font-family: Georgia,'Palatino Linotype','Times New Roman',Times,serif;
                    font-weight: normal;
                    padding-left: 40px; /* width of the image plus a little extra padding */
                    display: block; /* may not need this, but I've found I do */
                    }
                    li.f {
                    list-style-image: url("img/document.png");
                    }
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