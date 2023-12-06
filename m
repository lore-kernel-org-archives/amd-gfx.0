Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB73C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 20:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B812C10E0CD;
	Wed,  6 Dec 2023 20:11:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 847A510E0CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 20:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTYgZbhFWnHLcY7/t0prOOYptk7AqF72gUEEaUt9HNWEsWdBa1IybXy6toBlgiJC4+AVMZbRzodVzJ60qNcBMsDVJLAf/V6Szz+IT6mu/XzlCVNIhH/gMpmwypLAjOmvVGDaNF3Xl17aqcDWeybwm9kwTV2WAfDU7xqwv8sGJeudDUy2uROiUptLiJmHIUZYBW3A2uGSvJTij9ia9a6+yXyiAD2Gb4s077HspwjKZ/A97AOyjsKvAYeCE0oZHYyS2d6pPYAZj7RybO9wMUerGw+WJByY/Ve0TuNkaNNIZAcKlgMhxKw1gCr6gqC5xoZkvdGafB2H+B1I3RtjSMU8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCuA6CxLEMH3tk3BpDG5Tr1d+qCkvpk9CaMPYoCiDjk=;
 b=TDDFQl5Cu6MmUyg8hbBRCUOq2RIydDjJLDXXSDhbkU0zKZYgHq0Gui5qet3UT1+xpEl5ejMeUl6QIB23J+z7JQhuXSSWhg13Z0ZzkiUBSlKHBwbXc+o8QItgNnTYpYDUZSvDLkvDqAuJ/Kd0L1Uj1EXHwuzjXCHoylfwzOxCuFWPOhgozleSzs7wGRe2OvrNSMRcrFfxOP8hg5C41hdUqfg36E2ybB/5eDzUa3oc+cXJhCPqDYPbDlhaXB0NQ9EMPEfKz/BegrzDwoPWwcQJ91x5dijJq93vB38sJ0zMBpSMHbwqLzzM5z4w8o2BJG1/kZ6ztKEb00TKzvqDqNIB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCuA6CxLEMH3tk3BpDG5Tr1d+qCkvpk9CaMPYoCiDjk=;
 b=YbfaahIuHsBUEha5oyWscPANyNd/pE5SCbQ39EtazCVQjyBSR3GcN6ov7G+pPtGEjSVa7Sc5sejOKcWcgi7bfy11v0OPbpTpv+KrXFTavNUdx7OncaVU3AuEiG5C/fhDpzvdcyPnv5UbeJx/Jac41s8+dexBh1MtB2ubpLnT17o=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 20:11:01 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 20:11:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Galantsev, Dmitrii" <Dmitrii.Galantsev@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: fix pp_*clk_od typo
Thread-Topic: [PATCH] drm/amd/pm: fix pp_*clk_od typo
Thread-Index: AQHaKHvwmwKI9cgIeUm092tSet/FVbCcr5ho
Date: Wed, 6 Dec 2023 20:11:00 +0000
Message-ID: <BL1PR12MB5144F8AF3305579FF4784039F784A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231206193903.14623-1-dmitrii.galantsev@amd.com>
In-Reply-To: <20231206193903.14623-1-dmitrii.galantsev@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-06T20:10:59.718Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA1PR12MB6679:EE_
x-ms-office365-filtering-correlation-id: 64e71a66-f33c-4530-49e5-08dbf697772f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nrx4jtaCxH55hLunyWoPoNM0pmh3CRRV60rfwIVAeKC8ME04kUXVGTbHsrHx/kLd2D8l7c70A+ebB4Z40w9SJvnbtNKT4OgDaf0L8z84KGqqMDF6KWqu23H2b4Ny0hARPQQS80qcF39Jn5F5bq4QVSbTQaBwyLoHDAKdlXTjzRfqXrDKQ/GWCV6dDR3oT2d4LOXz1QMO9N1Xd1F5wXeMFi5jmce/JO/jTDd2JsI6U16Xlxv835M541mqWnaGgxwAaqpEy1XpasvWqtWv3cjBhlm30DJEsFhJ3Uzeg7lJL2TmOKwnnju7hDOoFacx+aKPk+XQHGVjfw6aulvrVkI0yqOZeQoLi1190qF4SKdQNxs4OS9Z/9FrmEPrwsfxL6AhtMRxAytbSopZt+IcCKZwpHJK8qKSi/70JpHM6gD3ha7q4uvKWhFliF+0RK4SmtPJ3gCX7FtzAW1mAdDp/4PWlo4hrK+zD8igD77muP2Lvty/U/Zt6jZu4bIL/zfoFOxLUTKyNrZ3LjDK5pkq0OyyveESJpURekA74y1mk7XGUpNaWpXAQpYuN3ynnCJO9CyF3vGab0injlfGUCi0xTzE86IjS9Zi36+Novq5kRAiLox1Ncv9XwxSfWsj1vcfVEKS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(52536014)(2906002)(5660300002)(38070700009)(33656002)(41300700001)(86362001)(478600001)(7696005)(6506007)(9686003)(71200400001)(53546011)(55016003)(122000001)(38100700002)(19627405001)(83380400001)(26005)(8676002)(8936002)(66476007)(66446008)(76116006)(66556008)(66946007)(110136005)(64756008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s2uw/trhpcecOw1Kv/MHOA4OkS53ktQSrbv8WsCvzCThTfTH+hiTQY0+bdPC?=
 =?us-ascii?Q?v4Twp/NGl67M9VVwrHOiOqmH10njkNWGD7TMQ1bBp2EplSZdlorDXl0YB3Yu?=
 =?us-ascii?Q?X/xLcas+RFx6FF1oGjlW+rQr8hBAYOLlegXswHW6fAiUW8cPo7rL4BFVWc/0?=
 =?us-ascii?Q?1PjQL7ePYacR6XtWJT6ZI/hY7rgw0D+iCXXl5J0U0kX/uqDiPj1t5uhQMeE8?=
 =?us-ascii?Q?tX8c89Ediw6BAGjleOvzOyBtsyUO9+tivNF3c9Kz/vfA4rkIwJ/lml+e9IUg?=
 =?us-ascii?Q?ywxx4UROJYcN6gYg1i080ooHhdOsAoYd6KVI16NTTznkZ66Mc5Vfubv7mdGy?=
 =?us-ascii?Q?yDrhTfzBV+di3Wt6luYJ4/KeZ0jXve0Y4OZqviQ0WHpOJ+SFF35nuGusIMmU?=
 =?us-ascii?Q?/KObjL3hdaJ8C3E7cgYCwM8DPPnXwXqaKFQ1uWQqj7LzH8zsoE6NZeJkvpOq?=
 =?us-ascii?Q?ZUqoIrX7U5ihph3ccKz58s0C4jhBK7ziPv0ggN/+qCzT5VpxrKlpLOM9lH+b?=
 =?us-ascii?Q?XYTplOBMi3bcjeykwi5Xm+zsx2kO2OCVe60ssnfQtYFWhwHQUatg77FOhgY3?=
 =?us-ascii?Q?5Bj0UzlDLFvHxVVyBCsgFN1iEO2XKI3muJmEMbBBWsrej4L7r8mhi75AXkXO?=
 =?us-ascii?Q?e89MxCGQv0JiePQj1WXGxEy6wAqcJUwzCUI7n5IYeJwxQyYyi2GI6ls4G5z9?=
 =?us-ascii?Q?quMKVw1NYrAxHcNGXEOsF8IIYciTJkaRjE495sx64aav3QGcOF8ROYivTj6w?=
 =?us-ascii?Q?h4tkni2tXDxq6xcJ0XW/h0BsvzSQe0h/6hHmlmH+F028kIh93uoxgSKiUQr+?=
 =?us-ascii?Q?BJlL9E9OeqPrY6XZ8bs/yrJTC804If/6S0Dzdzpw0Cuc4PqPP/2LlgyBrlLv?=
 =?us-ascii?Q?xPdUyQQ+3ncvXhlRhR86vVVNTzFtnIcLpmeD+vWzYXoTwTZHPYBSa0DDc5dk?=
 =?us-ascii?Q?JUiDd1Hx/sVwelDNxqiC2a5BKYIIGr1mOlqcB3CcN6kctqeM1fNL1jUt8wqB?=
 =?us-ascii?Q?4R9gbZoOvigGIJlmsjmhvc9GlaxmjlOnwk2FW2VEGkVBvt6jqCbI/4zi4a9B?=
 =?us-ascii?Q?nZGSmuwiFPF6b0re6F5cMJwdHd8P2by88geeJ+Y2jceOnnJzVWbzfkWD6eYp?=
 =?us-ascii?Q?5TjQL9k842acfSv52+3MMXkMkonOqpuRmLCE8EsiV+nr++oXA/VLkF21TKx+?=
 =?us-ascii?Q?8onYiTWW6ZgygCrvxrQTTPr4NLILNA5D94NyCigxi+x3kTJFqhM+FTU+8yo5?=
 =?us-ascii?Q?2TSPmYygTnZoWKJmid8maubLLFS+ipYiuicJhyXF4u7UKn9QUuFbTuIYUbwK?=
 =?us-ascii?Q?tmCbtWjOAG83DPSDWdNVQdGKC6m+OjAHvpVsMgV3etNVy/fqUnz0vRVCA7YX?=
 =?us-ascii?Q?gKXU/xYUioFX+KFnKcmD2bV6aBc+nN35yC1L29HlTNzV7aAbp+FNCImh3yWH?=
 =?us-ascii?Q?aUX4nA8R8HMdXD73+YMNgNqp3cYxKhKCtFFfgTMuxL1oPvOuxmMS04jNs04f?=
 =?us-ascii?Q?WtcYv+aoiyjYyGwrLQHi/SO6srgA7KNEO/8GRKW9Jbb7TH0OK8cmKpsNaChu?=
 =?us-ascii?Q?N4nv3Cn9liezxhw7/jI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F8AF3305579FF4784039F784ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e71a66-f33c-4530-49e5-08dbf697772f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 20:11:00.2908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCAE5QZckiLRvTFOOpxpU5SpbVoSG4kvQfh3h3SzENFTV1/2TI0wjHAPnIO1RSctub0Pl2/k/7kuggAv1+pawg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144F8AF3305579FF4784039F784ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Dmitrii =
Galantsev <dmitrii.galantsev@amd.com>
Sent: Wednesday, December 6, 2023 2:39 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Galantsev, Dmitrii <Dmitrii.Galantsev@amd.com>
Subject: [PATCH] drm/amd/pm: fix pp_*clk_od typo

Fix pp_dpm_sclk_od and pp_dpm_mclk_od typos.
Those were defined as pp_*clk_od but used as pp_dpm_*clk_od instead.
This change removes the _dpm part.

Signed-off-by: Dmitrii Galantsev <dmitrii.galantsev@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index e1497296afee..2cd995b0ceba 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2238,10 +2238,10 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_
         } else if (DEVICE_ATTR_IS(xgmi_plpd_policy)) {
                 if (amdgpu_dpm_get_xgmi_plpd_mode(adev, NULL) =3D=3D XGMI_=
PLPD_NONE)
                         *states =3D ATTR_STATE_UNSUPPORTED;
-       } else if (DEVICE_ATTR_IS(pp_dpm_mclk_od)) {
+       } else if (DEVICE_ATTR_IS(pp_mclk_od)) {
                 if (amdgpu_dpm_get_mclk_od(adev) =3D=3D -EOPNOTSUPP)
                         *states =3D ATTR_STATE_UNSUPPORTED;
-       } else if (DEVICE_ATTR_IS(pp_dpm_sclk_od)) {
+       } else if (DEVICE_ATTR_IS(pp_sclk_od)) {
                 if (amdgpu_dpm_get_sclk_od(adev) =3D=3D -EOPNOTSUPP)
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(apu_thermal_cap)) {
--
2.43.0


--_000_BL1PR12MB5144F8AF3305579FF4784039F784ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Reviewed-by: Alex De=
ucher &lt;alexander.deucher@amd.com&gt;</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Dmitrii Galantsev &lt;dmitrii=
.galantsev@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 6, 2023 2:39 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Galantsev, Dmitrii &lt;Dmitrii.Galantsev@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: fix pp_*clk_od typo</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix pp_dpm_sclk_od and pp_dpm_mclk_od typos.<br>
Those were defined as pp_*clk_od but used as pp_dpm_*clk_od instead.<br>
This change removes the _dpm part.<br>
<br>
Signed-off-by: Dmitrii Galantsev &lt;dmitrii.galantsev@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index e1497296afee..2cd995b0ceba 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2238,10 +2238,10 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
xgmi_plpd_policy)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_dpm_get_xgmi_plpd_mode(adev, NULL) =3D=3D =
XGMI_PLPD_NONE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_dpm_mclk=
_od)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_mclk_od)=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_dpm_get_mclk_od(adev) =3D=3D -EOPNOTSUPP)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_dpm_sclk=
_od)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_sclk_od)=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_dpm_get_sclk_od(adev) =3D=3D -EOPNOTSUPP)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
apu_thermal_cap)) {<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F8AF3305579FF4784039F784ABL1PR12MB5144namp_--
