Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE004C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FD62076C
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nvlb0eAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FD62076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 702DB6E505;
	Tue, 11 Aug 2020 13:18:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA336E505
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 13:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtIWChFEzEFCmp8U2N1r+gtZWOfhE4K9nG+L4sTLWT0bcGdOaBx+VKJdbRuFzFX3VSargFnC+UIydWS1bSqnprCiiyDRfiPGL32ZeV6ltgIvoVwz1sOTEDH+WVbvJbfp0ykV5LppzuzsAt1a0ZtQmyDKwQsO+mCVLtCyt2rDuFh4V7ipO95VfanuTMlpb5eZ6AwdJZPGzO2QlURCRj0ogp3LV4D5FTXHTv0urZFkPCRyh7AmNJT/zB+uTfMaSlUJ7n2JdKA7xU6Ztk6dlA4+6jypJ3hDGlfZ9xfrHD4nshhqtJdpspD6MEe5tSgcCOGbi5YQhkWkA1HrInfZ4NFSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dB5qqxDA3G8757YuRqIThB8f1xBtuD4GMg+/l/YSzEI=;
 b=McJji1r+UYw+LvK9iyP4R1nbfigRyh8suV5Jify3lNhdBfAFiTEZLe9b69tjXv32yLnVBecDejVIqlW2WACQQDzRW5lkPxOKxvOCLdCHl6h7yRtTuJgIEV7KtYOJ73Inf4dYSvAC9iJc50ZgWsFFBjFuQv9+TsNB3caB6roTf19md3GQkwdCv53qztoXRk8osH6gSAFFbabxLz7PpiJdi1gorV/3bNR8H0yNfnc1daSAlbBTZjwsSWwZY8+yqdFny+tIGCM2ywDxgY4/MZsrpHCn0qGbKKEUvwWWbw1JmYjRWc09hY52NZ3DbMy/u59xX6zvzT43vaUz1MN975jLdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dB5qqxDA3G8757YuRqIThB8f1xBtuD4GMg+/l/YSzEI=;
 b=nvlb0eAeXOJAKjExkDuH8/TIXbFlHWekSh898JQVw9zm0Tv4EhKvw3ne+5OuiS4r4uCmEnAogNkWKrGUbtqTijG/f6HnSLUqsJha/r0hd9afYllw4vCBISH6/cuDxuGRrPcE7Mr6hhnMBrxXftYvh0+40BoFbQzg1rN+1cV8lsg=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 13:18:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 13:18:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: update the metrics table cache
 interval as 1ms
Thread-Topic: [PATCH 1/2] drm/amd/powerplay: update the metrics table cache
 interval as 1ms
Thread-Index: AQHWb5CRtNVVS/FP6k+u3OIv/sy9GKky5IZ6
Date: Tue, 11 Aug 2020 13:18:24 +0000
Message-ID: <MN2PR12MB44880F911FA752C6E1193CB5F7450@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200811033556.1004-1-evan.quan@amd.com>
In-Reply-To: <20200811033556.1004-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-11T13:18:24.468Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2af16d2d-f8df-40b2-bdc7-08d83df9073b
x-ms-traffictypediagnostic: MN2PR12MB4287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB428728402AA5C81B3B75F15AF7450@MN2PR12MB4287.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O7bqY7Qa49DVqj1414DnKao3cGhtkSeVPS7+IX7H/mFdMsL5nGRLEQtJErfPB9edvrJdunTpo+d405Ufs08To+CC0tL0wnCu1sk5LSmm6yIHCDL8hY+jQLKwfIxnOaa19+tv2kPlyFG4eA2FH2gb2cqASokP3L0H5wdEEqQ4sPTiRxpEjqhaJvebfbIwIBB3xIsIdM3REg/zSVwEieReEfFHSwueG/fOnlTcbaaVTfDuT1zmc4VIRuKqAbHd8TCPK/wa3KHPqSA1Z8ecaw0SHkUUrVEsy58ZCca6CDAF9YgDgBNObYoj/UjQicMuuUG27+t04kb4ZwXnXWfeOlkR1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(15650500001)(186003)(26005)(53546011)(5660300002)(6506007)(478600001)(8676002)(33656002)(8936002)(7696005)(2906002)(52536014)(86362001)(66556008)(64756008)(66476007)(316002)(110136005)(9686003)(83380400001)(19627405001)(55016002)(76116006)(71200400001)(66946007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yfgXtGGpRfPDi/z1UpAl4h6YGXF1vT0OsOO105jNE4mZYAYrMVzNBtYLs7++kghncjxfGvuOvEMa8jpaqpsi7njYzT/kFBQmmFjlkxqS4qMj3IBd2Y9FWv9vAXKstoAaqFr8hjHXIaRXMvtI1XKHoFfRQxUE7T7UTWzYsVsc+R+XEyoD/2eIFRLCf8yNE8Glxn42QFrMzEpmCAj8W40Oymb6FuBr2YL//LpvvAauc7ZD1By5drXR9TMqND43u1ndKy+j2Sz5jmEYKKbtn1fSPJfDjPKHaX+gbbkUqHBeuW9q8hT2yGg9g09BZjXMdkZ0cv1WHpPL4WL5BwmlpiZbcR6Nql9OMOwvhjFqQk0NcEegkYtuA531Lq1nZDkLEC4kPuS1JvmMA7u5Y4yU7PexMDSTev/ROcibQSKsHUNDSjhr0zg6hEcBbrHuCnbse0ZILnoE0s9jrYbWqIQBDmMLu2dH6qOj9KOG+VCfOx+cDik7L922ikpc2kSoj6Ty5GsWBEMbQekRrzf1UTJkpDo9tqrlWRc2DjmOG5iG92rbi4qRtf7AqJhBImqnaa49cjLCFxOHKPhSRfI0Ac7HxY+f9UwWQ/b5iyFE07XE7BpOpPZKfrY1/HQpEiVU0A5+3oDZP7VnER6okTXQuejDIslJ2w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af16d2d-f8df-40b2-bdc7-08d83df9073b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 13:18:24.9107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPHDRD+zk3jsvjXXyiae18py6p5x07WJNpqu8JxzkrCG4jffQJnOAB8L9EQTyoqE4gfSdpfJy3OeotIllYxhUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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
Content-Type: multipart/mixed; boundary="===============0198983209=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0198983209==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44880F911FA752C6E1193CB5F7450MN2PR12MB4488namp_"

--_000_MN2PR12MB44880F911FA752C6E1193CB5F7450MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, August 10, 2020 11:35 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 1/2] drm/amd/powerplay: update the metrics table cache inte=
rval as 1ms

To make the setting same as Arcturus/Navi1x/Sienna_Cichlid.

Change-Id: I7ea721bf5872023f1ab39c3827fb9c6fd05877cc
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index c70c30175801..f0680dd58508 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -1272,7 +1272,7 @@ static int vega12_get_metrics_table(struct pp_hwmgr *=
hwmgr,

         if (bypass_cache ||
             !data->metrics_time ||
-           time_after(jiffies, data->metrics_time + HZ / 2)) {
+           time_after(jiffies, data->metrics_time + msecs_to_jiffies(1))) =
{
                 ret =3D smum_smc_table_manager(hwmgr,
                                              (uint8_t *)(&data->metrics_ta=
ble),
                                              TABLE_SMU_METRICS,
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index c9f402edc0d6..da84012b7fd5 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -2082,7 +2082,7 @@ static int vega20_get_metrics_table(struct pp_hwmgr *=
hwmgr,

         if (bypass_cache ||
             !data->metrics_time ||
-           time_after(jiffies, data->metrics_time + HZ / 2)) {
+           time_after(jiffies, data->metrics_time + msecs_to_jiffies(1))) =
{
                 ret =3D smum_smc_table_manager(hwmgr,
                                              (uint8_t *)(&data->metrics_ta=
ble),
                                              TABLE_SMU_METRICS,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index 8a8e6033f71f..c50c4547fea9 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -139,7 +139,7 @@ static int renoir_get_metrics_table(struct smu_context =
*smu,

         if (bypass_cache ||
             !smu_table->metrics_time ||
-           time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(=
100))) {
+           time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(=
1))) {
                 ret =3D smu_cmn_update_table(smu, SMU_TABLE_SMU_METRICS, 0=
,
                                 (void *)smu_table->metrics_table, false);
                 if (ret) {
--
2.28.0


--_000_MN2PR12MB44880F911FA752C6E1193CB5F7450MN2PR12MB4488namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Monday, August 10, 2020 11:35 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/powerplay: update the metrics table cac=
he interval as 1ms</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">To make the setting same as Arcturus/Navi1x/Sienna=
_Cichlid.<br>
<br>
Change-Id: I7ea721bf5872023f1ab39c3827fb9c6fd05877cc<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 2 +-<br>
&nbsp;3 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
index c70c30175801..f0680dd58508 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
@@ -1272,7 +1272,7 @@ static int vega12_get_metrics_table(struct pp_hwmgr *=
hwmgr,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bypass_cache ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !d=
ata-&gt;metrics_time ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; time_after(ji=
ffies, data-&gt;metrics_time + HZ / 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; time_after(ji=
ffies, data-&gt;metrics_time + msecs_to_jiffies(1))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smum_smc_table_manager(hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)(&amp;data-&gt;met=
rics_table),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TABLE_SMU_METRICS,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index c9f402edc0d6..da84012b7fd5 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -2082,7 +2082,7 @@ static int vega20_get_metrics_table(struct pp_hwmgr *=
hwmgr,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bypass_cache ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !d=
ata-&gt;metrics_time ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; time_after(ji=
ffies, data-&gt;metrics_time + HZ / 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; time_after(ji=
ffies, data-&gt;metrics_time + msecs_to_jiffies(1))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smum_smc_table_manager(hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)(&amp;data-&gt;met=
rics_table),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TABLE_SMU_METRICS,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index 8a8e6033f71f..c50c4547fea9 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -139,7 +139,7 @@ static int renoir_get_metrics_table(struct smu_context =
*smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bypass_cache ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !s=
mu_table-&gt;metrics_time ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; time_after(ji=
ffies, smu_table-&gt;metrics_time + msecs_to_jiffies(100))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; time_after(ji=
ffies, smu_table-&gt;metrics_time + msecs_to_jiffies(1))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_SMU_METRI=
CS, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)smu_table-&gt;metrics_ta=
ble, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44880F911FA752C6E1193CB5F7450MN2PR12MB4488namp_--

--===============0198983209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0198983209==--
