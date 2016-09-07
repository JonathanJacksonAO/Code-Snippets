<?xml version="1.0" encoding="UTF-8"?>
<!--
Version	Date		Author				Notes
RC 3	2005-08-16	Sebastian Rogers	When context menu's are displayed they handle the edge of the screen
RC 4	2005-10-17	Chris Morgan		Prevent the AO images wrapping on a browser resize
										Add the bibe title as a TD tooltip
-->
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:asp="remove">
    <xsl:output indent="yes" method="html" media-type="text/xhtml" omit-xml-declaration="yes" />

    <xsl:template match="/">

        <html>
            <title>Bible TOC</title>
            <head>
                <meta http-equiv="Content-Type" content="TEXT/html; charset=UTF-8" />
            </head>

            <body oncontextmenu="return false;">


                <!-- Issue with viewing a transformed xml AND using the viewer -->
                <!-- Not an isssue with HTML -->
                <!-- have to set the fulview.enabled property to prevent ie crashing -->
                <!-- after a document is viewed. -->
                <xsl:apply-templates select="BIBLE"/>

                <div id="dialogContent" style="display:none;"></div>
            </body>

        </html>

    </xsl:template>

    <xsl:template match="BIBLE">

        <xsl:variable name="imagePath" select="@IMAGE_PATH" />
        <xsl:variable name="docPath" select="@DOC_PATH" />
        <xsl:variable name="previewPath" select="@PREVIEW_PATH" />
        <xsl:variable name="profilePath" select="@PROFILE_PATH" />
        <xsl:variable name="bibleProfilePath" select="@BIBLE_PROFILE_PATH" />
        <xsl:variable name="clientID" select="@CLIENT_ID" />
        <xsl:variable name="matterID" select="@MATTER_ID" />
        <xsl:variable name="createDate" select="@CREATION_DATE" />
        <xsl:variable name ="bibleId" select="@BIBLE_ID"/>
        <xsl:variable name="appID" select="@APP_ID" />
        <xsl:variable name="parent_level" select="' '" />
        <xsl:variable name="bibleName" select="text()" />

        <link href="{$imagePath}Style.css" rel="stylesheet" type="text/css" />
        <link href="{$imagePath}jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
        <link href="{$imagePath}toc.css" rel="stylesheet" type="text/css" />
        <script src="{$imagePath}scripts/jquery-1.5.1.min.js" type="text/javascript" ></script>
        <script src="{$imagePath}scripts/jquery-ui-1.8.13.custom.min.js" language="JavaScript" type="text/javascript" ></script>
        <script src="{$imagePath}scripts/pdfobject_min.js" type="text/javascript" ></script>
        <script src="{$imagePath}scripts/toc.js" language="JavaScript" type="text/javascript" ></script>

        <script type="text/javascript">
            var profilePath = '<xsl:value-of select="$profilePath" />' ;
            var bibleProfilePath = '<xsl:value-of select="$bibleProfilePath" />' ;
        </script>



        <div border="1" id="navmenu" onclick="clickNavMenu()" onmouseover="toggleMenu()" onmouseout="toggleMenu()" oncontextmenu="contextTwice()" style="position:absolute;display:none;width:100;background-Color:menu">
            <div class="menuItem" id="ExpandAll">Expand All</div>
            <div class="menuItem" id="CollapseAll">Collapse All</div>
            <div class="menuItem" id="Expand">Expand</div>
            <div class="menuItem" id="Collapse">Collapse</div>
        </div>



        <table style="table-layout:fixed" border="0" width="100%" cellpadding="0" cellspacing="0" >
            <tr>

                <td style="background-repeat:no-repeat" width="177px" height="57px" background="{$imagePath}images/banner1.gif"></td>
                <td title="{$bibleName}" class="title" nowrap="true" background="{$imagePath}images/banners.gif"  >
                    <div id="bibletitle" >
                        <xsl:value-of select="$bibleName" />
                    </div>
                </td>

                <td style="background-repeat:no-repeat" width="186px" valign="bottom" background="{$imagePath}images/banner2.gif" align="right">
                </td>

            </tr>
        </table>

        <!--<div class="topStrip"></div>-->

        <!-- Table contains three TD left contains tree, middle splitter bar, right image viewer -->
        <table border="0" height="89%" width="100%" CELLSPACING="0" CELLPADDING="0" style="table-layout: fixed;">
            <tr>
                <td style="white-space: no-wrap;" width="252px" id="idFrame" valign="top">

                    <div id="divLeft" style="overflow: auto; height: 100%; width: 100%; border: thick;">


                        <xsl:if test="$appID='BIBLE'">


                            <table width="100%" CELLSPACING="0" CELLPADDING="0" style="table-layout: fixed;">
                                <tr>
                                    <td class="toolbar">

                                        <button title="Print TOC" onclick="printTOC();">
                                            <img src="{$imagePath}images/print.png" width="24" height="24"/>
                                        </button>

                                        <button title="View bible's generic profile" onclick="viewBibleProfile('{$bibleProfilePath}','{$bibleId}')">

                                            <img src="{$imagePath}images/bibleprofile.png" width="24" height="24"/>
                                            <!--</button>-->
                                        </button>

                                        <button href="#" title="View bible's DM doc profile" onclick="viewProfile('{$profilePath}' ,'{$bibleId}')">
                                            <img src="{$imagePath}images/dmprofile.png" width="24" height="24"/>
                                        </button>

                                        <button href="#" title="View the DM profile of the selected document" onclick="viewSelectedProfile('{$profilePath}')">

                                            <img src="{$imagePath}images/pprofile.png" width="24" height="24"/>
                                            <!--</button>-->
                                        </button>


                                        <button title="Expand" onclick="toggleAll(true);">
                                            <img src="{$imagePath}images/expand.png" width="24" height="24"/>
                                        </button>
                                        <button title="Collapse" onclick="toggleAll(false);">
                                            <img src="{$imagePath}images/collapse.png" width="24" height="24"/>
                                        </button>



                                    </td>
                                </tr>
                                <tr>
                                    <input type="hidden" name="library" id="library" />
                                    <input type="hidden" name="docnumber" id="docnumber" />
                                </tr>
                            </table>

                        </xsl:if>

                        <xsl:apply-templates select="*">
                            <xsl:with-param name="depth" select="1"/>
                            <xsl:with-param name="parent-level" select=" ' ' "/>
                            <xsl:with-param name="imagePath" select="@IMAGE_PATH"/>
                            <xsl:with-param name="docPath" select="@DOC_PATH"/>
                            <xsl:with-param name="appID" select="@APP_ID"/>
                            <xsl:with-param name="previewPath" select="@PREVIEW_PATH"/>
                            <xsl:with-param name="profilePath" select="@PROFILE_PATH" />
                            <xsl:with-param name="bibleId" select="@BIBLE_ID" />


                        </xsl:apply-templates>

                    </div>

                </td>

                <td height="2" width="2" class="HandleY" style="cursor:w-resize;" align="center"
                    onmousemove="ResizeBar(idFrame)"
                    onmouseup="this.releaseCapture();iStartX=0"
                    onmousedown="this.setCapture();iStartX=event.x;iStartW=idFrame.offsetWidth">
                    <img HEIGHT="2" WIDTH="2" />
                </td>


                <td align="top" id="idPDF">
                    <div id="pdfViewer"></div>
                </td>
            </tr>
        </table>

    </xsl:template>

    <!-- Template now handles both NODE AND DOC elements -->
    <xsl:template match="*">
        <xsl:param name="depth"/>
        <xsl:param name="parent-level"/>
        <xsl:param name="imagePath"/>
        <xsl:param name="docPath"/>
        <xsl:param name="appID"/>
        <!-- parent level which we only set when -->
        <xsl:param name="previewPath"/>
        <xsl:param name="profilePath"/>
        <xsl:param name="bibleId" />
        <xsl:param name="docId" />



        <xsl:variable name="numStyleCount">
            <xsl:value-of select="count(/BIBLE/NUMSTYLE)"/>
        </xsl:variable>


        <xsl:variable name="numberStyle">
            <xsl:value-of select="/BIBLE/NUMSTYLE[(($depth -1) mod $numStyleCount) + 1 ]"/>
        </xsl:variable>


        <xsl:variable name="docName">
            <!--<xsl:value-of select="@DOCNAME"/>-->
            <xsl:value-of select="translate(@DOCNAME, &quot;'&quot;, '')"/>
        </xsl:variable>



        <xsl:variable name="number">
            <xsl:number count="NODE[not(@NUMEXCLUDE)] | DOC[not(@NUMEXCLUDE)]" format="{$numberStyle}"/>
        </xsl:variable>

        <xsl:variable name="numberLabel">
            <xsl:choose>

                <xsl:when test="string-length($numberStyle) = 1 and not (contains($numberStyle,'('))">
                    <xsl:value-of select="$number"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($parent-level, $number)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <table border="0" cellspacing="0" cellpadding="0">

            <tr>
                <xsl:if test="$depth>1">
                    <td nowrap="true" style="white-space: no-wrap;" width="15"></td>
                </xsl:if>

                <td style="white-space: no-wrap;" nowrap="true" class="node" valign="top">

                    <!-- Set up the expand/collapse icon -->
                    <!-- only display if the node has children -->
                    <xsl:choose>
                        <xsl:when test="child::*">
                            <a  title="" oncontextmenu="showNavMenu(this);return false;" onclick="toggle(this)">
                                <img id="I{substring-after(concat($parent-level, '.', $number),'.')}" alt="Expand level {$depth}" src="{$imagePath}images/plus.gif"/>
                            </a>
                        </xsl:when>
                        <xsl:otherwise>
                            <img src="{$imagePath}images/spacer.gif"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:choose>
                        <xsl:when test="@DOCNUMBER!=''">
                            <span class="nodeimage">
                            </span>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="nodefolderimage">
                            </span>
                        </xsl:otherwise>
                    </xsl:choose>


                    <!-- Calulate and write out the header value -->
                    <span class="heading">
                        <xsl:choose>
                            <xsl:when test="not(@NUMEXCLUDE='true')">

                                <xsl:choose>

                                    <!--when has parentheses in the number style select last value-->
                                    <xsl:when test="contains($numberStyle,'(')">

                                        <xsl:variable name="result">
                                            <xsl:call-template name="substring-after-last">
                                                <xsl:with-param name="string" select="$numberLabel" />
                                                <xsl:with-param name="delimiter" select="'('" />
                                            </xsl:call-template>
                                        </xsl:variable>

                                        <!--As substring will contain everything after last '(' need to open the bracket.-->
                                        <xsl:value-of select="concat('(', $result)"/>

                                    </xsl:when>
                                    <xsl:otherwise><xsl:value-of select="$numberLabel"/></xsl:otherwise>

                                </xsl:choose>

                            </xsl:when>
                            <xsl:otherwise>&#160;&#160;</xsl:otherwise>

                        </xsl:choose>
                    </span>

                    <xsl:text>    </xsl:text>
                    <xsl:variable name="nodeName" select="normalize-space(text())" />

                    <xsl:choose>
                        <xsl:when test="name()='NODE'">
                            <a title="{$nodeName}" >
                                <xsl:attribute name="id">
                                    <xsl:value-of select="$numberLabel"/>
                                </xsl:attribute>

                                <xsl:attribute name="docdetails">
                                </xsl:attribute>

                                <xsl:attribute name="title">
                                    <xsl:value-of disable-output-escaping="yes" select="$nodeName"/>
                                </xsl:attribute>

                                <xsl:value-of disable-output-escaping="yes" select="$nodeName"/>
                            </a>
                        </xsl:when>

                        <xsl:otherwise>
                            <!-- if the current node is type doc then build up the anchor events -->
                            <!-- add the application image and write the document name -->

                            <xsl:text>    </xsl:text>

                            <!-- use VBScript for the show function due to issues with -->
                            <!-- Javascript and the Version download method -->



                            <span class="node">
                                <xsl:attribute name="id">
                                    <xsl:value-of select="@DOCNUMBER"/>
                                </xsl:attribute>

                            </span>&#160;
                            <a class="doc" onMouseOver="window.status='{$docName}';return true;" OnClick="return false;" onmouseover="SetTooltip();">

                                <xsl:attribute name="href">#</xsl:attribute>


                                <xsl:attribute name="rel">
                                    <xsl:value-of select="$previewPath"/>
                                    <xsl:value-of select="@DOCNUMBER"/>
                                </xsl:attribute>
                                <xsl:attribute name="title">
                                    <xsl:value-of select="$nodeName"/>
                                </xsl:attribute>
                                <xsl:attribute name="name">
                                    <xsl:value-of select="@DOCNUMBER"/>
                                </xsl:attribute>
                                <xsl:attribute name="id">
                                    <xsl:value-of select="$numberLabel"/>
                                </xsl:attribute>

                                <xsl:attribute name="docdetails">
                                    GRS:<xsl:value-of select="@DOCNUMBER"/>;<xsl:value-of select="@ORIG_LIBRARY"/>:<xsl:value-of select="@ORIG_DOCNUMBER"/>:<xsl:value-of select="@ORIG_VERSION"/>
                                </xsl:attribute>

                                <xsl:text>    </xsl:text>
                                <xsl:value-of disable-output-escaping="yes" select="$nodeName"/>
                            </a>



                        </xsl:otherwise>
                    </xsl:choose>

                    <div id="D{substring-after(concat($parent-level, '.', $number),'.')}">
                        <xsl:attribute name="style">display:none;</xsl:attribute>
                        <xsl:apply-templates select="*">
                            <xsl:with-param name="depth" select="$depth+1"/>
                            <xsl:with-param name="parent-level" select="$numberLabel"/>
                            <xsl:with-param name="imagePath" select="$imagePath"/>
                            <xsl:with-param name="docPath" select="$docPath"/>
                            <xsl:with-param name="appID" select="$appID"/>
                            <xsl:with-param name="previewPath" select="$previewPath"/>
                            <xsl:with-param name="profilePath" select="$profilePath"/>
                            <xsl:with-param name="bibleId" select="$bibleId"/>
                        </xsl:apply-templates>
                    </div>

                </td>

            </tr>
            <tr>
                <td></td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template name="substring-after-last">
        <xsl:param name="string" />
        <xsl:param name="delimiter" />
        <xsl:choose>
            <xsl:when test="contains($string, $delimiter)">
                <xsl:call-template name="substring-after-last">
                    <xsl:with-param name="string"
                                    select="substring-after($string, $delimiter)" />
                    <xsl:with-param name="delimiter" select="$delimiter" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="NOTE">
        <xsl:param name="depth"/>
        <xsl:param name="parent-level"/>
    </xsl:template>
    <xsl:template match="NUMSTYLE">
        <xsl:param name="depth"/>
        <xsl:param name="parent-level"/>
    </xsl:template>
</xsl:stylesheet>