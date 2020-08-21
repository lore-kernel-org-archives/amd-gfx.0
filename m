Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD56CC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 13:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF052063A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 13:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IGYFfXBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF052063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCC36E995;
	Fri, 21 Aug 2020 13:10:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4546E995
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 13:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ip0uHQ/9AL0mGOuL3gDsMFZPS0vSUxy5//Y9PuTO3tn2Y3DKlzXP8w/fb4oCLTF3lAebYRL53YSb3d0CNC8CQFLIWhj0vYKiOHcNb+I+YBt65WSg0EriqkI1rTQEEBTGH39Thtw/Gumz124GJiyEfXXcu2/D3CZEIUXuGlaNWsL8v6IA/WrdcHI3iJqx+Nl9Mo9Y+KSexmWwt7pzETrPM4VGYbJXcVVcrwcaQ2qH7cY40zY9nQY09zLbPTg5F6gtEtQz4A/asGkusJ4my6wMVACOjcmYnJLRyTXeFqO2MC1lf0xIpGviNQQajPFQ3q2LF/QVRvUw8s3SoBNImP1reA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw9IKr6hvvcpqVj1hx+6QTu606RJ5K4ycDcu0UAPPp8=;
 b=Hi7olxUnS+TDuefdlHjvSXerhpPhKrBFxW/Jveh6Lu0TNH0U/hN1ofr2rKva6kGw55VhzkgzWhf5FHDeWqJ0Ur3ICKH/gnR2JLaAiykMXWTfb0RbHoh5YUDnsOTBqflvRoUYwqsm6svcbyP8UU69tHtGuUUPB3hDyGLIAePnXRn5xU0DNa2tIrZhEnTL61Ci2FHNFJcdLajDU5zc1d78TM0rDgU2QK7HFxcHrCI0EG11M4sxyv0OzmSqEjgnCbJYZpetL17hyh1IpfJe2vOH6uct2al2tKsgYWphsz0BD6pRBvJ6UsLwV3OYI0z5Xn4siz/pV50J3PVFI4mpjn/Gbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw9IKr6hvvcpqVj1hx+6QTu606RJ5K4ycDcu0UAPPp8=;
 b=IGYFfXBbWEGkkEqh7+GBqDq+8k1hZh8MifGFFtgT8ivzZSOfbUFPpEVam13+nqvPTADeI2hK4C09f5jwJuUd9kecVJSujgY+ApZ7UeIJZ29lEh1Tlkwt7ckyjfwhem1QCmONPZKEDClhRGtY+e5yLVhI04NFk3tI5WneZ86EHdI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 13:10:43 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 13:10:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] drm/amd/pm: correct Vega10 swctf limit setting
Thread-Topic: [PATCH 1/3] drm/amd/pm: correct Vega10 swctf limit setting
Thread-Index: AQHWd3V+vnyH/5ryT0WqsKxTetltsalCieEw
Date: Fri, 21 Aug 2020 13:10:43 +0000
Message-ID: <MN2PR12MB44882E124814D6ED6C0B4303F75B0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200821044212.3039-1-evan.quan@amd.com>
In-Reply-To: <20200821044212.3039-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-21T13:10:43.057Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5923f9e-9a14-42df-63ef-08d845d39c5d
x-ms-traffictypediagnostic: MN2PR12MB4046:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4046787CE9520B970EAED6D3F75B0@MN2PR12MB4046.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:529;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sFklm1nunB/bCYIxRj6zE09qNYoCoghh/2bg90pZycOWB/Jfg2pL19g5OkuNBjonzlJ4Rohjs4EoGzcvAu41ie0MCoACgTVr62W551RgCRa6ZXc6cq29tw5X6Nt4RuxvGvLuGdwU8Z3mfmRFM6ZQM5FtUyEvMv17us2vPA6jvn00/IE9PUdaYgt14vbSU7zGn6GV0r9/yyLPqQlF+PFEqJprrHROTebQrBSL8eBG3p31O9Y8Jiwhm1lIZNyeUF2/63PkXMaz4AyEzLtd8QoY494bLrIr0J0ubzd1L70CWqtQx3OdEHuviKNguXjQTms6LvJnoCJTycb511DWnT40UyZ8ZSVVo4Q5eOGFXMvkIm8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(26005)(9686003)(110136005)(166002)(316002)(66946007)(76116006)(33656002)(64756008)(5660300002)(83380400001)(66476007)(2906002)(478600001)(66556008)(52536014)(66446008)(55016002)(8936002)(966005)(71200400001)(53546011)(19627405001)(186003)(86362001)(7696005)(8676002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UjEpXpxyiEsFJO0US1s+3+hL6AQ8HfSQcZgwh46oVaNbzlwp0M6YvGhI6OmP85zJ9UT4N04aZTdynG5oqH8zJD887t/fWTpDzlFVvv0PyxHbpu9SSUsyxq1SsPyLc2xUpM+8po9/kQmoDDeRY73907xjKfqahQc5TrBnEtDy+3bTiPeXGTOi8b4na4MU/inb1ZGO/ciXbcjOi7T6NT00x1MFF3p9/W+31dACzORDNAH74BFJwuizNQZM8gj+Bl4mlU3GwfFTduty9DFJr6ZpovcILT8cAh9oepHjxxRff1/DZR2m/kKC9YSzBcIWlv/7//ID5oZI/tLRfYSbKqKNu8prV9KUw1pu9+Y5v44XZVXGGBtf9L1V/xvKAoizefmNr6haps8VfUckI1YbQwwU8BQOPra7GmV9ciDUPiqW5tCqBFvNWpkAeDqINGVW+RysLXsm2MhEtsyji+eFz7h0Bd1HIUIc7huRlpCAcbZtnyiUgLl+CGllL5XSuUHBVNStEohP36J8A/DGGOJQSD4/d4tTmBN6UOtBph1cfCTPUITCh2wPnm5PrFHnbQGzJ1WlIfkKvKmWECL6dPlCYLpv4oYYdUEjkV/PJq/4QAvFwYbJWp5FKT/6Xs+wyfkX3dndeXxmLnxmPWOSZF3qmebAcw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5923f9e-9a14-42df-63ef-08d845d39c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 13:10:43.5572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFpq9LQBLkunh+c0/It2z1OR/OfWyXVd64+C6Uph1FTYUnq3koEYQV6jEhdkS8MJ9UuurCKKscMIrEGOpSrhQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Content-Type: multipart/mixed; boundary="===============0456789953=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0456789953==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44882E124814D6ED6C0B4303F75B0MN2PR12MB4488namp_"

--_000_MN2PR12MB44882E124814D6ED6C0B4303F75B0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Might want to add:
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1267
with that, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, August 21, 2020 12:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 1/3] drm/amd/pm: correct Vega10 swctf limit setting

Correct the Vega10 thermal swctf limit.

Change-Id: I220c18bcb0772bfb8cb674337bac6dccafbd7698
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 468bdd6f6697..ce9514c881ec 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -363,6 +363,9 @@ int vega10_thermal_get_temperature(struct pp_hwmgr *hwm=
gr)
 static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
                 struct PP_TemperatureRange *range)
 {
+       struct phm_ppt_v2_information *pp_table_info =3D
+               (struct phm_ppt_v2_information *)(hwmgr->pptable);
+       struct phm_tdp_table *tdp_table =3D pp_table_info->tdp_table;
         struct amdgpu_device *adev =3D hwmgr->adev;
         int low =3D VEGA10_THERMAL_MINIMUM_ALERT_TEMP *
                         PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
@@ -372,8 +375,8 @@ static int vega10_thermal_set_temperature_range(struct =
pp_hwmgr *hwmgr,

         if (low < range->min)
                 low =3D range->min;
-       if (high > range->max)
-               high =3D range->max;
+       if (high > tdp_table->usSoftwareShutdownTemp)
+               high =3D tdp_table->usSoftwareShutdownTemp;

         if (low > high)
                 return -EINVAL;
--
2.28.0


--_000_MN2PR12MB44882E124814D6ED6C0B4303F75B0MN2PR12MB4488namp_
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
Might want to add:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Bug: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1267" id=3D=
"LPlnk693456">
https://gitlab.freedesktop.org/drm/amd/-/issues/1267</a><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
with that, the series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Friday, August 21, 2020 12:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/3] drm/amd/pm: correct Vega10 swctf limit setting<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Correct the Vega10 thermal swctf limit.<br>
<br>
Change-Id: I220c18bcb0772bfb8cb674337bac6dccafbd7698<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c | 7 +++++--<b=
r>
&nbsp;1 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
index 468bdd6f6697..ce9514c881ec 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
@@ -363,6 +363,9 @@ int vega10_thermal_get_temperature(struct pp_hwmgr *hwm=
gr)<br>
&nbsp;static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmg=
r,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct PP_TemperatureRange *range)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v2_information *pp_tab=
le_info =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct phm_ppt_v2_information *)(hwmgr-&gt;pptable);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_tdp_table *tdp_table =3D p=
p_table_info-&gt;tdp_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int low =3D VEGA10_THERMAL=
_MINIMUM_ALERT_TEMP *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_TE=
MPERATURE_UNITS_PER_CENTIGRADES;<br>
@@ -372,8 +375,8 @@ static int vega10_thermal_set_temperature_range(struct =
pp_hwmgr *hwmgr,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &lt; range-&gt;min=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; low =3D range-&gt;min;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (high &gt; range-&gt;max)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; high =3D range-&gt;max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (high &gt; tdp_table-&gt;usSoftwar=
eShutdownTemp)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; high =3D tdp_table-&gt;usSoftwareShutdownTemp;<br>
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

--_000_MN2PR12MB44882E124814D6ED6C0B4303F75B0MN2PR12MB4488namp_--

--===============0456789953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0456789953==--
