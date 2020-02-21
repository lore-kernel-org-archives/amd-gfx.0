Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8900BC35666
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 20:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529FE2072C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 20:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="soDsMd++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529FE2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F8B6F509;
	Fri, 21 Feb 2020 20:31:45 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEF726F509
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 20:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bv6l1pnMSQm5tOfd6Rn6Ptn4+53O57Ks/+sbIR5fD0+JR1H7iCqzVb094b14pMYdYTw51hc01CeWObDD8Mr2JUTf+ih0Em0LZEzw3pHPp8RAkj9s57ZBWl+94ptly0g2+xGdwktziOphj/f2k60LfliNRQO3xbSAA+dZqJJqt1P7SSTFQgjs8DtUOlxnCqkOdb/b3uF65NNp67ReznZ394PLIXOEZHo0uc5TrcyfWYLW4ckXZh1t4rnNTb4qA1YUAc7SR0nKaMcdJmDZ8I6JQgBy6kuYhlMmJzJteR9HUKAm52AKIBpEk7ZEkhLVv85SDjYFw08cf+QroGEl61UEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdM0osPXNJWqe8JNj4z+kqF1tvrkc5SwkJVqt+KBs08=;
 b=mbqJO8wo9oH+Pe8pgbzQAD1RcuJDJpUusKgPfpVOcpjKc/Pboboy5FZyvtDaqc19DVTqpznEYQNphexQjWh0K5wigJhEAGlkEENBJxkNFYup46ek+7zq/5OfUbfb5M4qknCOmOouGG17aQPblZ7bSJ3rVwKVElISJKW4CZ/FO9Gr64LeYDNoOEyPWNTOh1aHy41l4yDt7Hnt/1phe02Uajoftgrl24hGsB8uLpoahFlPv8Qaw1cl6XAHMUqVwzSxG5BUY0W6lZxyWnG6kSq9i2J+AAfopRhnCmJf9t5JY8KQl+PVvKA2LVoX8cUUwpD9djObE2wiYAyT1xAmne8FXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdM0osPXNJWqe8JNj4z+kqF1tvrkc5SwkJVqt+KBs08=;
 b=soDsMd++cHWepwkxhXzdyQSzXw2PZvkiXxwbsMMMyMWKDukbI6Je0pavKNKmXfeIj87h17xf+2c1CqfQdBkYfFecpCm86JI1cfgSrVbBYNhuVjLK58ZWR8rhOIZHSwh9Nv3pWqGXCaPA3c6XCz+x20WfW4A0+2yK3lyAyeKvHsU=
Received: from CH2PR12MB4024.namprd12.prod.outlook.com (2603:10b6:610:2a::26)
 by CH2PR12MB3735.namprd12.prod.outlook.com (2603:10b6:610:25::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Fri, 21 Feb
 2020 20:31:37 +0000
Received: from CH2PR12MB4024.namprd12.prod.outlook.com
 ([fe80::18df:3bde:fc74:f7aa]) by CH2PR12MB4024.namprd12.prod.outlook.com
 ([fe80::18df:3bde:fc74:f7aa%4]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 20:31:37 +0000
From: "Gravenor, Joseph" <Joseph.Gravenor@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Add aconnector condition check for dpcd
 read
Thread-Topic: [PATCH] drm/amd/display: Add aconnector condition check for dpcd
 read
Thread-Index: AQHV4FZOEhp4aFtIy0W8B+GsGWEreqgmKyGD
Date: Fri, 21 Feb 2020 20:31:37 +0000
Message-ID: <CH2PR12MB40245FA27CCE227A020377BDEC120@CH2PR12MB4024.namprd12.prod.outlook.com>
References: <20200210210832.2779-1-zhan.liu@amd.com>
In-Reply-To: <20200210210832.2779-1-zhan.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-21T20:31:38.995Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Gravenor@amd.com; 
x-originating-ip: [70.29.101.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85f76345-3079-46f1-974c-08d7b70d0d22
x-ms-traffictypediagnostic: CH2PR12MB3735:|CH2PR12MB3735:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3735B20894EF3DA5C68DB9CCEC120@CH2PR12MB3735.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(9686003)(55016002)(52536014)(5660300002)(86362001)(110136005)(498600001)(33656002)(19627405001)(8676002)(81156014)(6506007)(53546011)(8936002)(7696005)(64756008)(66946007)(2906002)(76116006)(66556008)(66476007)(186003)(66446008)(26005)(81166006)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3735;
 H:CH2PR12MB4024.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSBVzSUyyIzKqPflzjOFHaxV2PKeN3PW6WMMP3OXkPyi9o5+XlYF85lu5V4yIz22eC6wYyL4WqMsvlYjJ8SmJfaZtw7qt3rONGZ+2/G/nEMM4kTW+xXRNjQSAyNwNqxGkPuq1lWGjoaM4NIWd+9gVRz6MHEm1owUuhBaKMxeyTlJ6t1/eywAz4plx99eYzfcXvVuBcPJwIpMEgGt4vn1PYt3RBjARdXXp5O+wZRysmOEIUWKvrLlwp+0RC/kwQv8ZWL+h3UcaACzAYbHpcFnSsiijW4yjc/o+Bvh52ZWqhVBFHENJ/Wd4zD+trWbXUQ0URi8G2tP6AXEIOsu7PhvY9pFx0PujJxxUGtcoDCG7F/sPxdh/3g4Z7ml3W+huQHZrV4m+jOK6Dw0TOmIyhHkKg7G8cc75+6l4NNrZIiOZmCPzlADPXwRT4jIRvnkmSXA
x-ms-exchange-antispam-messagedata: SlOtmhn1xa9eKI1ZxTJazKYQwPk3xG0+dCmbVws623MF0+8rvO0i6zdcsy3hyzqvEohjYG321Gfbb0c9j7N8NcUXUY7NlHt3hAQg+FLLm5iI+xwyvXjIq46mylZluzk3locpIEz5TiirFpQVyCu38g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f76345-3079-46f1-974c-08d7b70d0d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 20:31:37.8503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEZsLRk1gBihuTuXEoDGBbWkS9gIHlAqLLTgeQbCT75juqMDWnU2Ljnfqs7OAft5UzqjDXMsIH849ObR6QgyQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3735
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0329090368=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0329090368==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB40245FA27CCE227A020377BDEC120CH2PR12MB4024namp_"

--_000_CH2PR12MB40245FA27CCE227A020377BDEC120CH2PR12MB4024namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Joseph Gravenor <Joseph.Gravenor@amd.com>

________________________________
From: Liu, Zhan <Zhan.Liu@amd.com>
Sent: Monday, February 10, 2020 4:08 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Liu, Zha=
n <Zhan.Liu@amd.com>; Gravenor, Joseph <Joseph.Gravenor@amd.com>
Subject: [PATCH] drm/amd/display: Add aconnector condition check for dpcd r=
ead

[Why]
core_link_read_dpcd() will invoke dm_helpers_dp_read_dpcd(),
which needs to read dpcd info with the help of aconnector.
If aconnector (dc->links[i]->prev) is NULL, then dpcd status
 cannot be read.

As a result, dpcd read fails and a line of error will be
printed out in dmesg.log as:
"*ERROR* Failed to found connector for link!"

[How]
Make sure that aconnector (dc->links[i]->prev) is not NULL,
then read dpcd status.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 42fcfee2c31b..92e1574073fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1331,11 +1331,20 @@ void dcn10_init_hw(struct dc *dc)
                         if (dc->links[i]->connector_signal !=3D SIGNAL_TYP=
E_DISPLAY_PORT) {
                                 continue;
                         }
-                       /* if any of the displays are lit up turn them off =
*/
-                       status =3D core_link_read_dpcd(dc->links[i], DP_SET=
_POWER,
-                                                    &dpcd_power_state, siz=
eof(dpcd_power_state));
-                       if (status =3D=3D DC_OK && dpcd_power_state =3D=3D =
DP_POWER_STATE_D0) {
-                               dp_receiver_power_ctrl(dc->links[i], false)=
;
+
+                       /*
+                        * core_link_read_dpcd() will invoke dm_helpers_dp_=
read_dpcd(),
+                        * which needs to read dpcd info with the help of a=
connector.
+                        * If aconnector (dc->links[i]->prev) is NULL, then=
 dpcd status
+                        * cannot be read.
+                        */
+                       if (dc->links[i]->priv) {
+                               /* if any of the displays are lit up turn t=
hem off */
+                               status =3D core_link_read_dpcd(dc->links[i]=
, DP_SET_POWER,
+                                                               &dpcd_power=
_state, sizeof(dpcd_power_state));
+                               if (status =3D=3D DC_OK && dpcd_power_state=
 =3D=3D DP_POWER_STATE_D0) {
+                                       dp_receiver_power_ctrl(dc->links[i]=
, false);
+                               }
                         }
                 }
         }
--
2.17.1


--_000_CH2PR12MB40245FA27CCE227A020377BDEC120CH2PR12MB4024namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div style=3D"box-sizing: border-box; font-family: &quot;Segoe UI&quot;, &q=
uot;Helvetica Neue&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emo=
ji&quot;, Helvetica, Arial, sans-serif; font-size: 14px; orphans: 2; widows=
: 2">
Reviewed-by: Joseph Gravenor &lt;Joseph.Gravenor@amd.com&gt;</div>
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Zhan &lt;Zhan.Li=
u@amd.com&gt;<br>
<b>Sent:</b> Monday, February 10, 2020 4:08 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Liu, Zhan &lt;Zhan.Liu@amd.com&gt;; Gravenor, Joseph &lt;Joseph.Graven=
or@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Add aconnector condition check for=
 dpcd read</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
core_link_read_dpcd() will invoke dm_helpers_dp_read_dpcd(),<br>
which needs to read dpcd info with the help of aconnector.<br>
If aconnector (dc-&gt;links[i]-&gt;prev) is NULL, then dpcd status<br>
&nbsp;cannot be read.<br>
<br>
As a result, dpcd read fails and a line of error will be<br>
printed out in dmesg.log as:<br>
&quot;*ERROR* Failed to found connector for link!&quot;<br>
<br>
[How]<br>
Make sure that aconnector (dc-&gt;links[i]-&gt;prev) is not NULL,<br>
then read dpcd status.<br>
<br>
Signed-off-by: Zhan Liu &lt;zhan.liu@amd.com&gt;<br>
---<br>
&nbsp;.../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 19 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;1 file changed, 14 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c<br>
index 42fcfee2c31b..92e1574073fd 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c=
<br>
@@ -1331,11 &#43;1331,20 @@ void dcn10_init_hw(struct dc *dc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (d=
c-&gt;links[i]-&gt;connector_signal !=3D SIGNAL_TYPE_DISPLAY_PORT) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if any of the=
 displays are lit up turn them off */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D core_=
link_read_dpcd(dc-&gt;links[i], DP_SET_POWER,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &amp;dpcd_power_state, sizeof(dpcd_power_state));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status =3D=
=3D DC_OK &amp;&amp; dpcd_power_state =3D=3D DP_POWER_STATE_D0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp_receiver_power_ctrl(dc-&gt;links[i], fal=
se);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * core=
_link_read_dpcd() will invoke dm_helpers_dp_read_dpcd(),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * whic=
h needs to read dpcd info with the help of aconnector.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If a=
connector (dc-&gt;links[i]-&gt;prev) is NULL, then dpcd status<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * cann=
ot be read.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;l=
inks[i]-&gt;priv) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if any of the displays are lit up tu=
rn them off */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D core_link_read_dpcd(dc-&gt;l=
inks[i], DP_SET_POWER,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &amp;dpcd_power_state, sizeof(dpcd_power_state));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status =3D=3D DC_OK &amp;&amp; dpcd=
_power_state =3D=3D DP_POWER_STATE_D0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; dp_receiver_power_ctrl(dc-&gt;links[i], false);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB40245FA27CCE227A020377BDEC120CH2PR12MB4024namp_--

--===============0329090368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0329090368==--
