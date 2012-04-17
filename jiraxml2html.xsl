<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                version="1.0">
    <xsl:param name="url" select="'undefined.jira.url'"/>

    <xsl:param name="title_type" select="'T'"/>
    <xsl:param name="title_key" select="'Key'"/>
    <xsl:param name="title_priority" select="'Priority'"/>
    <xsl:param name="title_assignee" select="'Assignee'"/>
    <xsl:param name="title_reporter" select="'Reporter'"/>
    <xsl:param name="title_summary" select="'Summary'"/>
    <xsl:param name="title_status" select="'Status'"/>
    <xsl:param name="title_resolution" select="'Resolution'"/>

    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ '" />

    <xsl:template match="/rss/channel">
        <html>
            <head>
                <link rel="stylesheet" href="http://confluence.atlassian.com/styles/main-action.css" type="text/css"/>
                <title>RSS -
                    <xsl:value-of select="title"/>
                </title>
            </head>
            <body>
                <table border="1" cellspacing="0" width="100%">
                    <caption style="text-align: left; font-weight: bold">
                        <a href="{./link}">
                            <xsl:value-of select="title"/>
                        </a>
                        <span class="smalltext"> (
                            <xsl:value-of select="count(item)"/> issues)
                        </span>
                    </caption>
                    <thead>
                        <tr>
                            <th style="text-align: left;">
                                <xsl:value-of select="$title_type"/>
                            </th>
                            <th style="text-align: left;">
                                <xsl:value-of select="$title_key"/>
                            </th>
                            <th style="text-align: left;">
                                <xsl:value-of select="$title_priority"/>
                            </th>
                            <th style="text-align: left;">
                                <xsl:value-of select="$title_assignee"/>
                            </th>
                            <th style="text-align: left;">
                                <xsl:value-of select="$title_reporter"/>
                            </th>
                            <th style="text-align: left;">
                                <xsl:value-of select="$title_summary"/>
                            </th>
                            <th style="text-align: left;">
                                <xsl:value-of select="$title_status"/>
                            </th>
                            <th style="text-align: left;">
                                <xsl:value-of select="$title_resolution"/>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="item">
                            <tr>
                                <xsl:attribute name="class">
                                    <xsl:choose>
                                        <xsl:when test="position() mod 2 = 0">rowNormal</xsl:when>
                                        <xsl:otherwise>rowAlternate</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:apply-templates select="type"/>
                                <xsl:apply-templates select="key"/>
                                <xsl:apply-templates select="priority"/>
                                <xsl:apply-templates select="assignee"/>
                                <xsl:apply-templates select="reporter"/>
                                <xsl:apply-templates select="summary"/>
                                <xsl:apply-templates select="status"/>
                                <xsl:apply-templates select="resolution"/>
                            </tr>
                        </xsl:for-each>

                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="type">
        <td nowrap="true">
            <a href="{../link}">
                <img src="{../link}/../../images/icons/{translate(., $uppercase, $lowercase)}.gif" alt="{.}" title="{.}" border="0"/>
            </a>
        </td>
    </xsl:template>

    <xsl:template match="key">
        <td nowrap="true">
            <a href="{../link}">
                <xsl:value-of select="."/>
            </a>
        </td>
    </xsl:template>

    <xsl:template match="priority">
        <td nowrap="true">
            <xsl:value-of select="translate(., $lowercase, $uppercase)"/>
        </td>
    </xsl:template>

    <xsl:template match="assignee">
        <td nowrap="true">
            <xsl:choose>
                <xsl:when test="@username = -1">
                    <i>unassigned</i>
                </xsl:when>
                <xsl:otherwise>
                    <a href="https://jira.codehaus.org/secure/ViewProfile.jspa?name={@username}">
                        <xsl:value-of select="@username"/>
                    </a>
                </xsl:otherwise>
            </xsl:choose>
        </td>
    </xsl:template>

    <xsl:template match="reporter">
        <td nowrap="true">
            <a href="https://jira.codehaus.org/secure/ViewProfile.jspa?name={@username}">
                <xsl:value-of select="@username"/>
            </a>
        </td>
    </xsl:template>

    <xsl:template match="summary">
        <td nowrap="true">
            <a href="{../link}">
                <xsl:value-of select="."/>
            </a>
        </td>
    </xsl:template>

    <xsl:template match="status">
        <td nowrap="true">
            <img src="{../link}/../../images/icons/status_{translate(., $uppercase, $lowercase)}.gif" border="0"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="."/>
        </td>
    </xsl:template>

    <xsl:template match="resolution">
        <td nowrap="true">
            <font color="#ff0000">
                <xsl:value-of select="translate(., $lowercase, $uppercase)"/>
            </font>
        </td>
    </xsl:template>

    <!--
   	<xsl:template match="channel/link"/>
   	<xsl:template match="channel/title"/>
   	<xsl:template match="channel/description"/>
   	<xsl:template match="channel/language"/>
   	-->


</xsl:stylesheet>
<!-- vim: set tw=10000:-->
