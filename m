Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E97CC2BA16
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 14:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441962073B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 14:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HCv2td2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441962073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245ED6EBFF;
	Fri,  3 Apr 2020 14:43:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04FC6EBFD
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 14:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVwsPstFPy6gx82ZAPoDJU9J+LKEEKEmRSIcVUL0HT7UuO4UMYtQ5Q0ZqhGfafw0KrESeQomB9DKivhmp37U/FecLzMCmBWHq5xleCcAqDFeEioB/im6leWV4KddVNhPwAAhXJQz+N0W18mXAfEMDiehMWEYr2BmVzwtIrcLNFv2zKMZkkRJVDCdgw76pr7+iGfLp6jw7c43dJjnp4isJWgnoYlPratontBhC7mgKLJ8ul8rpnQHGS8HylpuJPSG4mMvExSuJjIZlwWizFnAUAlrb6pTqr55ImVqXq90dc/fOhpVWGCw9YgySNJZsRSar63etr3r3cqgTSK0IDRrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGJnTk0DKx5rrx9F/IkIr0my1AvAHnZwKgPxxBOvAGc=;
 b=DB7iCJyaBeZsqOhlyVoSRGeQvOB2mIwLabO8vQsD+Sg9FH6LHpT0oxJMhiQsu4y8ammH3fc3tTlQDI0LHgyfbYa5FD42Uqnuvu9gZypZ60QFoX3W8Y4qHWc3iCvaQbW29gOfKeKAYuntMRUvwJiEyFF6Cpe2IxCJu5yFCaeykpSZgC6iA1WZaoX0r/LXH2ztNwRY2v6eATXznY7U/b0v/abLHbIKzZhBiaY5jUyHN6TQYXWa6KgR/INtU14WbvHFeCR8BLfWUURr0OejTgjF86nfdBpuHPJ8djB4Hg2sw1TLZpccr4fYoKbT7TkXa1xICam4Ku+Lut3rF3YSuT/iKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGJnTk0DKx5rrx9F/IkIr0my1AvAHnZwKgPxxBOvAGc=;
 b=HCv2td2QnIB9asdk2E2eAB7uI9pKqjXFB9G9KD1Eu1VR2TASEdP/FD0iIp1+u0c5prwioS5m9Lvi2gB2oqnLGLu2a8l4J8yadZmKOKAJZ7dIJMQo/Nkovlvpa62MashDXlye6CTflCyoNWL2nUdjk71KvhUtT2Ez+7hVVhm6eVo=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 3 Apr
 2020 14:43:53 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 14:43:52 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: error out on forcing clock setting not
 supported
Thread-Topic: [PATCH] drm/amd/powerplay: error out on forcing clock setting
 not supported
Thread-Index: AQHWCYYGpuIECj4jlESTIMWio3dob6hneXMU
Date: Fri, 3 Apr 2020 14:43:52 +0000
Message-ID: <MN2PR12MB44884FDE17077CEFD756B031F7C70@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200403070319.10190-1-evan.quan@amd.com>
In-Reply-To: <20200403070319.10190-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-03T14:43:51.490Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae1a73d1-cf9c-429f-c411-08d7d7dd6d91
x-ms-traffictypediagnostic: MN2PR12MB4238:|MN2PR12MB4238:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4238F15CF23BEEF0BAF884F9F7C70@MN2PR12MB4238.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(81166006)(81156014)(8676002)(33656002)(186003)(478600001)(4326008)(86362001)(55016002)(19627405001)(9686003)(2906002)(316002)(110136005)(7696005)(53546011)(71200400001)(76116006)(66946007)(64756008)(66476007)(26005)(6506007)(66446008)(66556008)(52536014)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKXyJQB1vGjCUSnEceyhsGWN3QRl/AjR5ATu5xrivIJM4BXLfB57CxG3NtTlSyyN9WOd58Vv9epGy0QEXhEOGmuoqB7D7a2zs1r6mT0qFjjx/i/d7wCzOypbGEibhlVC7qq6gUKZH47byYy6rMR8jHYOYY0fSWShauMGy9nxLkBKVEckbWiqJuSiOlZooHAENDNQ27phOndpJ1rIu1+jPV8wekx+N/pbTVTQP4t3HLQvczvgXs+6pgRznSJ0T96Pj8rQzFv5cEApdAIB7yH50lZLLmY5qoMeODLo7SNV/f8ZwhhnuQkbTk3QGhOHSvUNmuNqmygWn/eDnSQBoWMeeOO6Yso9RebVVDWr1LVV/nJcQtAAiCxM08Qr8mrk7CH/wECBfjHTlARiHbUibb7DTbjHBcwk84zX/Q8HeeqFBZMQ+AQ4AElw4DjbsSDxHlQO
x-ms-exchange-antispam-messagedata: J7RaLNw975oOqozOhyLIbn8A2iDKDSCBZviSVMrMWNhYsY8qlo88GYjA02+EJcG/cQEjgvB5BVPTltuJmPmKoabAfdpC+C8rmnQ4vQwR13zWAHAwVelinpaK5K3qG8R8T03U5fCJFNS3qskCe2TRcA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1a73d1-cf9c-429f-c411-08d7d7dd6d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 14:43:52.1362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GX3Di3JUsLeJxjvLSTdt9Gyg2t6upFoOp90COfi0UgDQksDzURHkMvIrlbt6W6JT8MYaYNWm7x1H398b+gTXnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>
Content-Type: multipart/mixed; boundary="===============0788297421=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0788297421==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44884FDE17077CEFD756B031F7C70MN2PR12MB4488namp_"

--_000_MN2PR12MB44884FDE17077CEFD756B031F7C70MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, April 3, 2020 3:03 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: error out on forcing clock setting not =
supported

For Arcturus, forcing clock to some specific level is not supported
with 54.18 and onwards SMU firmware. As according to firmware team,
they adopt new gfx dpm tuned parameters which can cover all the use
case in a much smooth way. Thus setting through driver interface
is not needed and maybe do a disservice.

Change-Id: Ibffdb157639809707aa71049a935e53d1b4d06eb
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 47 +++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index 5db8c56066ee..1ef0923f7190 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -794,8 +794,21 @@ static int arcturus_force_clk_levels(struct smu_contex=
t *smu,
         struct arcturus_dpm_table *dpm_table;
         struct arcturus_single_dpm_table *single_dpm_table;
         uint32_t soft_min_level, soft_max_level;
+       uint32_t smu_version;
         int ret =3D 0;

+       ret =3D smu_get_smc_version(smu, NULL, &smu_version);
+       if (ret) {
+               pr_err("Failed to get smu version!\n");
+               return ret;
+       }
+
+       if (smu_version >=3D 0x361200) {
+               pr_err("Forcing clock level is not supported with "
+                      "54.18 and onwards SMU firmwares\n");
+               return -EOPNOTSUPP;
+       }
+
         soft_min_level =3D mask ? (ffs(mask) - 1) : 0;
         soft_max_level =3D mask ? (fls(mask) - 1) : 0;

@@ -1512,6 +1525,38 @@ static int arcturus_set_power_profile_mode(struct sm=
u_context *smu,
         return 0;
 }

+static int arcturus_set_performance_level(struct smu_context *smu,
+                                         enum amd_dpm_forced_level level)
+{
+       uint32_t smu_version;
+       int ret;
+
+       ret =3D smu_get_smc_version(smu, NULL, &smu_version);
+       if (ret) {
+               pr_err("Failed to get smu version!\n");
+               return ret;
+       }
+
+       switch (level) {
+       case AMD_DPM_FORCED_LEVEL_HIGH:
+       case AMD_DPM_FORCED_LEVEL_LOW:
+       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+       case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+               if (smu_version >=3D 0x361200) {
+                       pr_err("Forcing clock level is not supported with "
+                              "54.18 and onwards SMU firmwares\n");
+                       return -EOPNOTSUPP;
+               }
+               break;
+       default:
+               break;
+       }
+
+       return smu_v11_0_set_performance_level(smu, level);
+}
+
 static void arcturus_dump_pptable(struct smu_context *smu)
 {
         struct smu_table_context *table_context =3D &smu->smu_table;
@@ -2285,7 +2330,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
         .get_profiling_clk_mask =3D arcturus_get_profiling_clk_mask,
         .get_power_profile_mode =3D arcturus_get_power_profile_mode,
         .set_power_profile_mode =3D arcturus_set_power_profile_mode,
-       .set_performance_level =3D smu_v11_0_set_performance_level,
+       .set_performance_level =3D arcturus_set_performance_level,
         /* debug (internal used) */
         .dump_pptable =3D arcturus_dump_pptable,
         .get_power_limit =3D arcturus_get_power_limit,
--
2.26.0


--_000_MN2PR12MB44884FDE17077CEFD756B031F7C70MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Friday, April 3, 2020 3:03 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: error out on forcing clock setti=
ng not supported</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For Arcturus, forcing clock to some specific level=
 is not supported<br>
with 54.18 and onwards SMU firmware. As according to firmware team,<br>
they adopt new gfx dpm tuned parameters which can cover all the use<br>
case in a much smooth way. Thus setting through driver interface<br>
is not needed and maybe do a disservice.<br>
<br>
Change-Id: Ibffdb157639809707aa71049a935e53d1b4d06eb<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 47 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;-<br>
&nbsp;1 file changed, 46 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index 5db8c56066ee..1ef0923f7190 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -794,8 &#43;794,21 @@ static int arcturus_force_clk_levels(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct arcturus_dpm_table =
*dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct arcturus_single_dpm=
_table *single_dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t soft_min_level, s=
oft_max_level;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t smu_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_smc_version(smu, =
NULL, &amp;smu_version);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_err(&quot;Failed to get smu version!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_version &gt;=3D 0x361200)=
 {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_err(&quot;Forcing clock level is not supported with &quot=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;54.18 and on=
wards SMU firmwares\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soft_min_level =3D mask ? =
(ffs(mask) - 1) : 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soft_max_level =3D mask ? =
(fls(mask) - 1) : 0;<br>
&nbsp;<br>
@@ -1512,6 &#43;1525,38 @@ static int arcturus_set_power_profile_mode(struc=
t smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int arcturus_set_performance_level(struct smu_context *smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level level)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t smu_version;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_smc_version(smu, =
NULL, &amp;smu_version);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_err(&quot;Failed to get smu version!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_HIGH:<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_LOW:<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_PROFILE=
_STANDARD:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_PROFILE=
_MIN_SCLK:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_PROFILE=
_MIN_MCLK:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_PROFILE=
_PEAK:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (smu_version &gt;=3D 0x361200) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot=
;Forcing clock level is not supported with &quot;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;54.18 and onwards SMU firmwares\n&quot;=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPN=
OTSUPP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_v11_0_set_performance_=
level(smu, level);<br>
&#43;}<br>
&#43;<br>
&nbsp;static void arcturus_dump_pptable(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
table_context =3D &amp;smu-&gt;smu_table;<br>
@@ -2285,7 &#43;2330,7 @@ static const struct pptable_funcs arcturus_ppt_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_profiling_clk_mask =
=3D arcturus_get_profiling_clk_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profile_mode =
=3D arcturus_get_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profile_mode =
=3D arcturus_set_power_profile_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_performance_level =3D smu_v11_0_=
set_performance_level,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_performance_level =3D arctur=
us_set_performance_level,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* debug (internal used) *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dump_pptable =3D arcturus=
_dump_pptable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_limit =3D arctu=
rus_get_power_limit,<br>
-- <br>
2.26.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44884FDE17077CEFD756B031F7C70MN2PR12MB4488namp_--

--===============0788297421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0788297421==--
