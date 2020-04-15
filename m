Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF61C2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 16:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB4320656
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 16:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zFMWDrqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB4320656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EDA46EA2B;
	Wed, 15 Apr 2020 16:19:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044526EA2B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 16:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7Kks0avP8xmuJb3W8h80qGgs3DOBAOIObGKxOISvD2ZWL5/F9T4mvtm32qjisyokfDemWT6oWw/38iBXtOLWBNkimlCF/8lbTho5SV42UEA2A/6aVo4cwIn/AqzzxbneyJx6xw6f2+ccdBZ+5uBMgsZYf1DUxSZUACJ3ALUTNvLcdtdCyA2qHxjdhKPrJQgXoLQWoBlhNl1S1UjAQ8YeIBjcChw2U0EwvUqVoBO12TZHufN501Wk+DZrDR/4+3NPJODaZluSKSpVw7NgY2TLVpZDQXl2T4KJ70DEDxrU9Ha0NdvFtRSw4ggDc2pj5QHH4ozEAELNfS+5b3nsCSb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHfWX4glPBqvkEv3fWdHUa+r0HX2swaZmkrpMHDFWs0=;
 b=WtaxIcBhxtr8t+utBncwpqRRgkRq1SqHV1mW/Yo2syafE4KJtBfOZU7k+MxU5/q4Tt8XcSM1oqZZmIVvuVxidpVjGV6vAegZhMPg7Or4rf6+gfZkQuWxWECK4QbJW2Lm17DYkYL6GjT7LygK6icSyNJuriA/zZkddue4E0OnMdghmBECltVKbkMu9f45THIqL7anabHQEXhq3GiT3hWQ8flEYoq0KheDOKVO0vTA1ixmdZd9XhiDLM/aQ3OiwgKwu3w9d/iPqx3fLTuHj7qLUwVqEoXYn1cTeFt8l5oLlaIdYJCujfyUGUqIk0oRx64Yh/eQSOUMGINaguOF/wcHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHfWX4glPBqvkEv3fWdHUa+r0HX2swaZmkrpMHDFWs0=;
 b=zFMWDrqwvt85xdiyGDsHElMwp+tSI/cx71YEjXyteheEXyiSS744T5PXZMVrQrvl7BJ6TveV8lQ1nP80onimVpzyiIsbCtnveuiUJP8Oy9S9hhznhf6CE3b8tAgHZlJ+zx8+rDF0K+U4IuZTUqvpBibHVcguZbQEQgB7av4Yebo=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3710.namprd12.prod.outlook.com (2603:10b6:208:16d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Wed, 15 Apr
 2020 16:19:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 16:19:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: fix resume failed as smu table
 initialize early exit
Thread-Topic: [PATCH] drm/amd/powerplay: fix resume failed as smu table
 initialize early exit
Thread-Index: AQHWEzyhZu1nibji0UCywjpBpHe0z6h6XLMr
Date: Wed, 15 Apr 2020 16:19:35 +0000
Message-ID: <MN2PR12MB448866E89B862F484FA2E7F9F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1586965404-31922-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1586965404-31922-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-15T16:19:35.254Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [172.58.187.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b12b1ca0-2d66-49a9-80b9-08d7e158ca25
x-ms-traffictypediagnostic: MN2PR12MB3710:|MN2PR12MB3710:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3710174BEE12B379002C7C0DF7DB0@MN2PR12MB3710.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(53546011)(66946007)(66446008)(5660300002)(7696005)(55016002)(9686003)(33656002)(64756008)(186003)(110136005)(26005)(66556008)(4326008)(6506007)(8676002)(71200400001)(8936002)(19627405001)(66476007)(2906002)(86362001)(52536014)(81156014)(498600001)(76116006);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7CkTWct0LA7uOmWAIpVSj7Ek2RDdO3tMkyiDWLaKlmuFJ3IwD4zA3kBhiYpaAAnReTjS41/yIFrP4vkX1zCB7dZkXIG9tiXxeFF2wgtId6TrPKIytQ/nFM/O3QV7CY2IxqcKoHeuSk63UaQkln8oB139mosrO1DOOZYg6OjoHuJzM16dktbRheWDB0LOGbTyvDIYbmjtWbGym04YLfDA2kChyjXuQT/w0HAUgchkX7TeTA5UWxSihuSDLjo+MKhPKqSptj4O9igt5Kb5q9MSLHUkx5KOf+3aePhDGl5aW0kIOFbQGGDIpUbhWagePj0llKYKRqEml30u6AsIvAxkCXwnpmw2ctHLZ3/pCjMnJCcAjOq1Tuw+vJEXmkAJ+XUs4kFj00m/rtaH7wOp9UYetRwW06DEKN4sSWbkityhPwQ7ccMSmRO/Jqk5vA1Wf1XN
x-ms-exchange-antispam-messagedata: K93xVf5GbYhuPhSaMsNvipsfv0wgHNYof/RGTy69vY0S4cetf+5ZsZsDi65LgXaDv/DYVxbNjbprHz7pe4PYSsvWhRkb8APnVDPdVP/gI0c6NwG3JeZaTHDZjS70DmXirJO8ps9JGY8BEbT8DbWmBg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12b1ca0-2d66-49a9-80b9-08d7e158ca25
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 16:19:36.0185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSvP6zrBQzlf0mPZQ/I52nm3IE05j7M+ChE+qjo722WhKOgOE/aMCrqAYTwy5CdjKbHtiuvPfpXWOJoW/tF6Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3710
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: multipart/mixed; boundary="===============1319904416=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1319904416==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448866E89B862F484FA2E7F9F7DB0MN2PR12MB4488namp_"

--_000_MN2PR12MB448866E89B862F484FA2E7F9F7DB0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Wednesday, April 15, 2020 11:43 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amd/powerplay: fix resume failed as smu table initiali=
ze early exit

When the amdgpu in the suspend/resume loop need notify the dpm disabled,
otherwise the smu table will be uninitialize and result in resume failed.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index 95eb445..7ddaea8 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -895,12 +895,17 @@ static int renoir_read_sensor(struct smu_context *smu=
,

 static bool renoir_is_dpm_running(struct smu_context *smu)
 {
+       struct amdgpu_device *adev =3D smu->adev;
+
         /*
          * Until now, the pmfw hasn't exported the interface of SMU
          * feature mask to APU SKU so just force on all the feature
          * at early initial stage.
          */
-       return true;
+       if (adev->in_suspend)
+               return false;
+       else
+               return true;

 }

--
2.7.4


--_000_MN2PR12MB448866E89B862F484FA2E7F9F7DB0MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 15, 2020 11:43 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: fix resume failed as smu table i=
nitialize early exit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">When the amdgpu in the suspend/resume loop need no=
tify the dpm disabled,<br>
otherwise the smu table will be uninitialize and result in resume failed.<b=
r>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
Tested-by: Mengbing Wang &lt;Mengbing.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 7 &#43;&#43;&#43;&#43;&#=
43;&#43;-<br>
&nbsp;1 file changed, 6 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index 95eb445..7ddaea8 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -895,12 &#43;895,17 @@ static int renoir_read_sensor(struct smu_context =
*smu,<br>
&nbsp;<br>
&nbsp;static bool renoir_is_dpm_running(struct smu_context *smu)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Until now, the pmf=
w hasn't exported the interface of SMU<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * feature mask to AP=
U SKU so just force on all the feature<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * at early initial s=
tage.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&nbsp;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448866E89B862F484FA2E7F9F7DB0MN2PR12MB4488namp_--

--===============1319904416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1319904416==--
