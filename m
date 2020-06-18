Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B793C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 15:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7CB204EA
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 15:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bb2ytHCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7CB204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D0B6EB3F;
	Thu, 18 Jun 2020 15:05:54 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam04on0603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4d::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9486EB38
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 15:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flhsU06lVxdjBmrT/uYr2RZdEwLxyW9hO8tc4EgYLn8369hGpOVzOHypZtV1vJ4hxNC7IgrSHE6QqBLZX9CIFtcTmh69SOdVFXAxepo69LH/5PkSO0uPXTutp5exb5CyRe/17M+TQXhUyArm7hXV17jINGNS+2eACuPHAVRoNk3g7BiifXH3LwiSM9Kt30tNIDdQ0GiDxFeEsTZBLAlRmvr+fZk40KSoS4QBxUqU12bvr5heWoQk9qgDkZGtqIzU7G26OXanlYpqGRfeU7YesPW5wiQZqjphzQRgusQk3eIdcWIAsOxQRsbhWTIMAVxwz2oFN6mjprXFcbiu5SJV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMhaFYY3SAtgAVCFfLwKH1JGKqXkUBGtIj1x+/BPYzo=;
 b=ZSwevWXHN1ZKlPBieooqZqHFYANIVWB+IgoKGQsom2KLpQ+aHN670DshfFhoUGZ8KgTEysk30Dz+VDqlugvvKpT8s3sTrufdX/5M5YosZuk9YUZFoxK/ZhVWEobjZvbB0vhRXdWRmBciHsG5yjmjlc5APozMK7Vsvksh1tdzIQrUGUStvWIm4ILxxERxpD7R17w1vJ5g/l5LdhvbLGI6UXbFIKB7+TeUXqQpoyJ+ZbtO4gqrw+pXVj2IJH0aiRqeLD6EkxPKKkoPK4SI6zXesVht7P0jEC8rGW6zkMMd6KinO26o7QisNQcyAu+r4ZTgUpd8/rO8FMv8oGIgs9TapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMhaFYY3SAtgAVCFfLwKH1JGKqXkUBGtIj1x+/BPYzo=;
 b=bb2ytHCIJWdV+JS9tWkd7Ny5Ff5KoN/BkNRedcVxPHCoM2DFHLv0XNe+gVkM8crj2TsDfg0hxIZv6XQr4hnE68FaJk22hnskZfXbBLwBlBP8o7QbWlsqoJFVP7eDs+q4yvzyg2Jxc6kGcUuu12jDyGxDfuay5kW+sRa7CN/G9FU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3741.namprd12.prod.outlook.com (2603:10b6:208:162::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 15:05:51 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 15:05:51 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: remove unused functions
Thread-Topic: [PATCH 1/1] drm/amdgpu: remove unused functions
Thread-Index: AQHWRX/4iXjAkxentUK+g04dvoexVKjeeLD8
Date: Thu, 18 Jun 2020 15:05:51 +0000
Message-ID: <MN2PR12MB4488B4A24615968E176D66A2F79B0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200618145235.52039-1-nirmoy.das@amd.com>
In-Reply-To: <20200618145235.52039-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-18T15:05:50.979Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.51.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9e590be-0f77-4255-7e50-08d813991758
x-ms-traffictypediagnostic: MN2PR12MB3741:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB374102DFBD031B79509B77ACF79B0@MN2PR12MB3741.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:169;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIypdwpVpDUxkDhr7yFAga/Fk5bpnpyXHDiL8lPmKCF0Oy01THb4G9O2jOLJrg08VvHXdygmRuwHRwmv42qpmsDFR0EWUNR2O5t9erYFOxob0UsY1JrzRtT8Gyq8zkI/CPMbp0mDuUKj5VEAgfnAwQF6/VKlQEVsl+N3WxG3A75SQ4kCrEUIGBLbEUCez3L9I0lCSDNx1Qi/HBqFk81I2/vGjiMSVEXT8M9JoUIcllhoBJ+YP0/b9Kk6ntWN+NufQXXCj0v2QH/Ye31N1MnnKjvvDjWltRsXJn/lWNdGkHaKLNzWyIoadnvewAGnJl8IpynwyDHTeslyjkaOVoqBPwG1kzkxQnBhSd+lwze5OuA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(8676002)(7696005)(33656002)(8936002)(9686003)(71200400001)(966005)(55016002)(52536014)(4326008)(6506007)(53546011)(83380400001)(5660300002)(66556008)(66946007)(316002)(478600001)(166002)(2906002)(86362001)(76116006)(45080400002)(19627405001)(186003)(26005)(110136005)(66476007)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: CJ6G13A19ka926PlQg69gtqoo8F7br7+AVNMP0+MMksOfwvx3y8ovWHswjhdkLWV8VelEgAih5m/tSt6Zyl6ltPxdckVhHb6dQ/lzsWxC9P1myh2GDSxREFXcGitBAE7GBogc5AiEq12Ykrj35tY90liIyPqBgf1XxwAR5e7nKpFHCWMUaaHkUezMDZAFaL7x41jDXSeyUV7kTbz+TnAlkQ6oJ71PZqxKhJ14hjMoCDu2TH6PYMqSVDyqJnbIDJvVTD88so2JrtkLv9xwVh8Arqlz0aOZeQxAAsE96ZJPvCH9gA3B7jKgtFZvCJzv7mHpCiO+sXn8bKtNPe9ESZmDQk5DJ+Z74JMmlnS7tXk0FQoSWcHV/Pi8ZKEvG+kJyYz6r3EdDZtFlMFa2HWBLLnGYFfYKRK8Nx6ce0P1JzxHayKTqodOragSLUzg3lrp+Qw+oraqBAfCtwimXClTclLahOHEu/QHCrDJ9hyp7/b/FKwNQFAbfbyP50rAo743FzV
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e590be-0f77-4255-7e50-08d813991758
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 15:05:51.4319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5iaK0+dpLWkxYgEaGWzURpDtjot1PClvOB/YkPpIIGGJLjAeXMPxC1+CnMyHaxHAM05T1zAnQ2pTa3xeoIetSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3741
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>
Content-Type: multipart/mixed; boundary="===============0069586807=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0069586807==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488B4A24615968E176D66A2F79B0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488B4A24615968E176D66A2F79B0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Nirmoy D=
as <nirmoy.aiemd@gmail.com>
Sent: Thursday, June 18, 2020 10:52 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: remove unused functions

Remove unused amdgpu_xgmi_hive_try_lock() and smu7_reset_asic_tasks().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c         | 5 -----
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 91837a991319..e3a3755cb999 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -144,11 +144,6 @@ static const struct amdgpu_pcs_ras_field wafl_pcs_ras_=
fields[] =3D {
          SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, RecoveryR=
elockAttemptErr)},
 };

-void *amdgpu_xgmi_hive_try_lock(struct amdgpu_hive_info *hive)
-{
-       return &hive->device_list;
-}
-
 /**
  * DOC: AMDGPU XGMI Support
  *
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 2c9cac8c170c..ffe05b7cc1f0 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -1548,12 +1548,6 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *h=
wmgr)
         return result;
 }

-int smu7_reset_asic_tasks(struct pp_hwmgr *hwmgr)
-{
-
-       return 0;
-}
-
 static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C5c82260a8a3b4b617f3708d8139716cd%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637280886979928986&amp;sdata=3DsDo8p7TN70t0HZt2rJI=
wOhycUqAyH0SPHEJyPO2MmaY%3D&amp;reserved=3D0

--_000_MN2PR12MB4488B4A24615968E176D66A2F79B0MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Nirmoy Das &lt;nirmoy.aiemd@g=
mail.com&gt;<br>
<b>Sent:</b> Thursday, June 18, 2020 10:52 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdgpu: remove unused functions</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Remove unused amdgpu_xgmi_hive_try_lock() and smu7=
_reset_asic_tasks().<br>
<br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; | 5 -----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 6 ------<br>
&nbsp;2 files changed, 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index 91837a991319..e3a3755cb999 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -144,11 &#43;144,6 @@ static const struct amdgpu_pcs_ras_field wafl_pcs_=
ras_fields[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_FIELD(PCS_=
GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, RecoveryRelockAttemptErr)},<br>
&nbsp;};<br>
&nbsp;<br>
-void *amdgpu_xgmi_hive_try_lock(struct amdgpu_hive_info *hive)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;hive-&gt;device_list;<br>
-}<br>
-<br>
&nbsp;/**<br>
&nbsp; * DOC: AMDGPU XGMI Support<br>
&nbsp; *<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index 2c9cac8c170c..ffe05b7cc1f0 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -1548,12 &#43;1548,6 @@ static int smu7_disable_dpm_tasks(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu7_reset_asic_tasks(struct pp_hwmgr *hwmgr)<br>
-{<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =
=3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
-- <br>
2.27.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C5c82260a8a3b4b617f3708d8139716cd%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637280886979928986&amp;amp;sdata=3D=
sDo8p7TN70t0HZt2rJIwOhycUqAyH0SPHEJyPO2MmaY%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C5c82260a8a3b4b617f3708d8139716cd%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637280886979928986&amp;amp;sdata=3DsDo8p7TN70t0HZt2r=
JIwOhycUqAyH0SPHEJyPO2MmaY%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488B4A24615968E176D66A2F79B0MN2PR12MB4488namp_--

--===============0069586807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0069586807==--
