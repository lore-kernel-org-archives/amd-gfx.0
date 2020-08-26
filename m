Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D2EC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 12:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10662208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 12:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Udk2OYfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10662208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B646E115;
	Wed, 26 Aug 2020 12:53:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE196E115
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 12:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foUcuUj3AleYIqCgd2akkbJ3THTsPaixUTVcBNm1oHu1Qb5JFdAzi/c32kBGDcb2ZUGD2Y2FrZRQkshr5YktSEGNbTCKv24vHmOjhg/lb7YvaYSp1i/j9vKbCn6wTK+7zzuncCNueLsRkc8ktGz8igT0+W9dX6qwLSIaS4tUwlJ+/uXppfT/jm3N4w0ANuguir1JlGmGuopArVe6KRaOdYi5z8VTnJtef5HtShZO9VpABPlgW69qgysCHr+DuW6TpltOcfC73tc983cEaLRu9d8OSs6f0hW7/7F+9562QvCEtFMaT/ptApPsEyQRvFR2ZJehYWuv6mJk0mbe6EYVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0lBy6ZPMwew/lpomaLdWTe7MHDI2EURipRjwPv8BO4=;
 b=USL58sqnTGZ/IXYEGe+siQ/Z3e7OL1mQBHC8QRCDpkhM8zbI8bZHXFKZuslV6u/4T0DK6887DB6RyVfGbNVSkFIIhX22TNJxVq//ckXyF0GMKg2o6x7ZjiKHx2CsVJmf9qziw+MA9jQ2byV4xA7rd33vNmqHFwl9gaxUwy8PGmwAmqknP32Bz0AQ5ODY1tKxJbJFH+fpbR77Sq2+nXDSuLoQcVqn0qzSaO1fswxszdxMX7D5Q3Ar/eWNKzWpWHzBbioO9YAf2CqGMiEkO7LWp8uNbK0WqKjjpQRC8Cta4bTr4BPyGymTQ8jFq9p3giQ3DaL1Jb1TTKe9Ou18Fy8BeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0lBy6ZPMwew/lpomaLdWTe7MHDI2EURipRjwPv8BO4=;
 b=Udk2OYfD8QIbM4XnU9Bmr+mXrSWDwoMiJeiQduGnJMMp5i3rCURzxrADu8DI3NVzyuWArMwlMCN0NGoI5EuSZ9AZMqFeeybtZ1FemDjciS5xEB3HFY0tzr+YRQe+FYXZM1G8uP69m+lJCzbaxvr+yofHs3RCHca+XVBfYe9XTgg=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 12:53:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 12:53:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: avoid false alarm due to confusing
 softwareshutdowntemp setting
Thread-Topic: [PATCH] drm/amd/pm: avoid false alarm due to confusing
 softwareshutdowntemp setting
Thread-Index: AQHWe3zbIbHALpCmXkqTOc/1X4/gLalKWKzm
Date: Wed, 26 Aug 2020 12:53:12 +0000
Message-ID: <MN2PR12MB44880CFB5899FF6E46E38B7FF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200826074500.14603-1-evan.quan@amd.com>
In-Reply-To: <20200826074500.14603-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-26T12:53:11.650Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce9ebbe3-4e0c-43b9-77f1-08d849befdc7
x-ms-traffictypediagnostic: MN2PR12MB4421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4421F97815F0E20237CE6C9CF7540@MN2PR12MB4421.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OsDWFWJCJPTtuOrdHp7TceMXQzHV3mrSbmJJ91L5l5L522DAVEvT46/5gObILvZ7S6gxfhlVGtrSLUK50rnlrPE68i9/XpH4bAlxGcTiPHwAXoqOSV0RvI73LPn9ihFzzdzEB6KWy/LJXIpx1IiTekXRMlN2tfpj4eguQBvvbt3Vdh5hAqIgScoS+k9WCRKlJN3gF2JYI4ddLeDv/q+RpG1sAqYnJvZuo7WfpLGdKQUlZxzC9+RKRl97topVYmPYU4PtFFZ1vudnMkTHSDnVMDOiAuWIlnz0/04a5yHvED9wxTF+6/U9PbZLZlC1qgvmCtL7GJ7gYqgiBScrubURAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(2906002)(86362001)(186003)(19627405001)(478600001)(9686003)(110136005)(83380400001)(8676002)(64756008)(66556008)(66476007)(66946007)(76116006)(53546011)(66446008)(8936002)(71200400001)(7696005)(316002)(55016002)(6506007)(26005)(52536014)(33656002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: zF/43s02IRV5HMbeioBkGjr3t5f8SAP/xY+RhYcNkaVaMPsIKLf7ICvntm5J9KVApzwHXH5ziKIPtCxtmOTqnprTQkeJ4CaI/WEDPL7Nw9Tyx1vctq4NWhPY/Xyh9753aZDrNBQW0reHzldfp0JR5XJaOSpk01/2zarqlaSMmipR06FCiQBcEnakRsgC3FxmW1Uf9r1yfZl+bH97HOonCsRavxshWH5GyeU5a2qDiAKPWNy6gIXrBYWdlcmXvzB0lgNFvldcDNCOxaHCr0hoc84bm5KKc/cC+nMoKzRLbgORm/eUO5ZnAJfcrZ0PpT14rEtKPJnPT9KWbL7pYuxRFPnvYY2wOaTd8CNn4omc+xTESaGUGATbFllUJRyS7kJ43ZPQTG7sJGQEibLJKU4GFbMoMgX4qYMkIF0VDnfFXUjDOjpZVngpZcsmPluzBwcvIZlSnatIeIshIAjSwbZTxC8QJn5ZKWVawSDn2calylOlMKfLFSRvhlhG2kO+hT8sMbWYulPpxEeFU/yYwS/PXKBy5herb/7tfbkj1mGa7W7NTmYol/lN0thd/0jQ1LjpUoc8s4+T3K/w4d9V/2aF3z8l7UbClJP5mZIBWuVU50CN+T3wIjphfmnVuVaRyjMUq1kUDRTcjUrUR8rTK/XJzQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9ebbe3-4e0c-43b9-77f1-08d849befdc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 12:53:12.0967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6yfgrRx1edhBv0LkV5yhynlSwqF9YvezrvtoxIRFrENIiZZ8UHLxcBRsPbMyRxGBRUwb1MS9csAEoAOE9F6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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
Content-Type: multipart/mixed; boundary="===============1591862724=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1591862724==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44880CFB5899FF6E46E38B7FF7540MN2PR12MB4488namp_"

--_000_MN2PR12MB44880CFB5899FF6E46E38B7FF7540MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Wednesday, August 26, 2020 3:45 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/pm: avoid false alarm due to confusing softwareshu=
tdowntemp setting

Normally softwareshutdowntemp should be greater than Thotspotlimit.
However, on some VEGA10 ASIC, the softwareshutdowntemp is 91C while
Thotspotlimit is 105C. This seems not right and may trigger some
false alarms.

Change-Id: I940cc6e450eebccd93ccdc3428187f6b7c09dcda
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c    | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index d572ba4ec9b1..952cd3d7240e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -374,8 +374,18 @@ static int vega10_thermal_set_temperature_range(struct=
 pp_hwmgr *hwmgr,
         /* compare them in unit celsius degree */
         if (low < range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES)
                 low =3D range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       if (high > tdp_table->usSoftwareShutdownTemp)
-               high =3D tdp_table->usSoftwareShutdownTemp;
+
+       /*
+        * As a common sense, usSoftwareShutdownTemp should be bigger
+        * than ThotspotLimit. For any invalid usSoftwareShutdownTemp,
+        * we will just use the max possible setting VEGA10_THERMAL_MAXIMUM=
_ALERT_TEMP
+        * to avoid false alarms.
+        */
+       if ((tdp_table->usSoftwareShutdownTemp >
+            range->hotspot_crit_max / PP_TEMPERATURE_UNITS_PER_CENTIGRADES=
)) {
+               if (high > tdp_table->usSoftwareShutdownTemp)
+                       high =3D tdp_table->usSoftwareShutdownTemp;
+       }

         if (low > high)
                 return -EINVAL;
--
2.28.0


--_000_MN2PR12MB44880CFB5899FF6E46E38B7FF7540MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 26, 2020 3:45 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: avoid false alarm due to confusing soft=
wareshutdowntemp setting</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Normally softwareshutdowntemp should be greater th=
an Thotspotlimit.<br>
However, on some VEGA10 ASIC, the softwareshutdowntemp is 91C while<br>
Thotspotlimit is 105C. This seems not right and may trigger some<br>
false alarms.<br>
<br>
Change-Id: I940cc6e450eebccd93ccdc3428187f6b7c09dcda<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c&nbsp;&nbsp;&nbsp; | 1=
4 ++++++++++++--<br>
&nbsp;1 file changed, 12 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
index d572ba4ec9b1..952cd3d7240e 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
@@ -374,8 +374,18 @@ static int vega10_thermal_set_temperature_range(struct=
 pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* compare them in unit ce=
lsius degree */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &lt; range-&gt;min=
 / PP_TEMPERATURE_UNITS_PER_CENTIGRADES)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; low =3D range-&gt;min / PP_TEMPERATURE_UNITS_PER_CENT=
IGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (high &gt; tdp_table-&gt;usSoftwar=
eShutdownTemp)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; high =3D tdp_table-&gt;usSoftwareShutdownTemp;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * As a common sense, usSoftware=
ShutdownTemp should be bigger<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * than ThotspotLimit. For any i=
nvalid usSoftwareShutdownTemp,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * we will just use the max poss=
ible setting VEGA10_THERMAL_MAXIMUM_ALERT_TEMP<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to avoid false alarms.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((tdp_table-&gt;usSoftwareShutdown=
Temp &gt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&=
gt;hotspot_crit_max / PP_TEMPERATURE_UNITS_PER_CENTIGRADES)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (high &gt; tdp_table-&gt;usSoftwareShutdownTemp)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D tdp_tab=
le-&gt;usSoftwareShutdownTemp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &gt; high)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44880CFB5899FF6E46E38B7FF7540MN2PR12MB4488namp_--

--===============1591862724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1591862724==--
