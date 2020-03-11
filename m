Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709FFC10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 13:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F0A20873
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 13:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K16/f04P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F0A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA9F36E1F7;
	Wed, 11 Mar 2020 13:42:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33FEE6E1F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 13:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDx/QgYKWtpvpuMksh3y5X0LflfuawttOb9AuQ2gJw9ZwQWUxo7I+wBiOgJSwQ7z2vyvwnkO7VEYs+tmmf3IzwTJwjPz61I0HM7OCcjwQF9dY0e4tswI5az6hMt2fK2FVvuRwPMods9YElymTnEyuM25/XO3TqiN2wbh1GduxszviF4YA5IhMDcmT3GjFPSnbd5tynnqFToWXcDzfgP1OU6WAKzxR/LnG8fhSEnMwHkOu+lpf65fv5z3wuxTbVaQv487kc/VhdTof1UusBcUf0II2gsRYWJoiwbe3BWmoV4djNJwkUEdGjWAIGbL5+z7y/XWDhR1c3uFffyI9uxDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBiMy9zuBFmz1yB+lgqeMquju1dlAJvybfYTRXLtNEA=;
 b=HQwEWghHrhgP4+LT3bk5klMiESrbaKERlOCPlHM+cNzUGR4TP92dnwEbT0b+LSu4d+bz9w/MMmrCbsdd+GFd0xlU3ri71ypsBaah3Ch96/UGQBNiFS6tnmYO0xm6x0408dr4qXX+02mQkOWoa8mcS6btq1pHfGF6HAdCcYm+03GQJGo52ZZH/h7pVfIM8Nm3GIdSXerYXw/d+ZrU3p9hjL6RaljP1GKeGtiFiR+2lE+7B8Spd7NFon/aK5oUDqqt1iavBKCYTRjUiNtSnQNhOQIZwmvQco6ZG693WoDTIE0fK2DPO4iMF5aPgZhaczu8oW3fWJGkTBL4rV6tvGZlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBiMy9zuBFmz1yB+lgqeMquju1dlAJvybfYTRXLtNEA=;
 b=K16/f04PEs274f83f2EfmXvrFUef552U+PIo0mXKxmWjoP1GTGycd0Dnw9PDspwUkBnOT4IGLv8/9+dByV3t0NiMxLRC7TCrhmCNomoVbc3sDiNYZ4SC57TUWyNuhKfiJTAuP+U4ujczXhhLddDaySN2AWLft7A3dCXX7MV5dek=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BN8SPR01MB0032.namprd12.prod.outlook.com (2603:10b6:408:aa::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Wed, 11 Mar
 2020 13:42:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 13:42:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: reenable runtime pm on navi12
Thread-Topic: [PATCH] drm/amdgpu: reenable runtime pm on navi12
Thread-Index: AQHV95PZZB3JvUCh7kOC3FirFfvdOahDZntU
Date: Wed, 11 Mar 2020 13:42:12 +0000
Message-ID: <MN2PR12MB4488C21D7862314BAF260E78F7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200311105652.28287-1-evan.quan@amd.com>
In-Reply-To: <20200311105652.28287-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-11T13:42:11.678Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 617d7d4d-017b-4056-bdcf-08d7c5c2010c
x-ms-traffictypediagnostic: BN8SPR01MB0032:|BN8SPR01MB0032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8SPR01MB0032494A4D4A2C389D911361F7FC0@BN8SPR01MB0032.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:245;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(199004)(478600001)(71200400001)(5660300002)(186003)(52536014)(7696005)(26005)(6506007)(76116006)(19627405001)(81156014)(66446008)(66946007)(8676002)(66556008)(81166006)(9686003)(53546011)(64756008)(33656002)(66476007)(8936002)(55016002)(86362001)(316002)(2906002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8SPR01MB0032;
 H:MN2PR12MB4488.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ai348+F/JCypIxHqxNCM08M4gZWDf29qorB3yk6i2FVpwB3ejn40j0SH+gFIvnRL1Ay5wZXGCUa7Eb3qWE8w/rpsAPVt88NwHoHV6D8wor5achJghUEuNPdXa9cc/3ZhgVMosrP4ChspsbLZQeliN3wnARPkbTFYvMtKqrRJVZo9ddRDmscEdrOS5IjYBNqgLQd3y/qPe1NbejivHHLpxvVCBF9pu15A2DRid6dVVH+2nYV3Tm/sqEmT89427c2tSwAEBZ9yIh+hIcJHFDEsGHhF2dh5EpFotytkC37BtWZgo9OWEiw9KkKC5n+OgddbTdBttq4ElMRLiC8tbF1cOpTEzUbIQvB8yNz1Ft50l8MadNorLJsVVOIpm8VkTRa+VSGJRwON2xgoAfFYlCT/eDk7o1RGWZN65/0PrVVFrOWtILar6e//rlCH3lmBwzum
x-ms-exchange-antispam-messagedata: yuJliGQNoCoyZYonPlCjQ6cSPpjkRueGmo2vpeRO0PDBM5tFpOc8+Leg2+Dib8cFQ72PIvYwv8UHZEP1hhh4L5MUmgQK80vW80agficj2ppKdHzHH1sKycpCH96Kxy4021lzS2N8R5yCMu1uM6lp/Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617d7d4d-017b-4056-bdcf-08d7c5c2010c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 13:42:12.6591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDXkR0sj3P5fTSVpwXJ03TCMZFJvbHG+q3sWSvEIrvY+XRFEJ+hJLjDyMUP5MeKnhFPLX3qnrPZ98CudoQJNog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8SPR01MB0032
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
Content-Type: multipart/mixed; boundary="===============0427364033=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0427364033==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488C21D7862314BAF260E78F7FC0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488C21D7862314BAF260E78F7FC0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Wednesday, March 11, 2020 6:56 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amdgpu: reenable runtime pm on navi12

The runtime pm is verified as working now
on navi12.

Change-Id: I20393633678297308c9651237bbfdc854a3cff94
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 80495652a7c1..e376dc072d42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -174,8 +174,7 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsi=
gned long flags)
                  (adev->asic_type >=3D CHIP_TOPAZ) &&
                  (adev->asic_type !=3D CHIP_VEGA10) &&
                  (adev->asic_type !=3D CHIP_VEGA20) &&
-                (adev->asic_type !=3D CHIP_ARCTURUS) &&
-                (adev->asic_type !=3D CHIP_NAVI12)) /* enable runpm on VI+=
 */
+                (adev->asic_type !=3D CHIP_ARCTURUS)) /* enable runpm on V=
I+ */
                 adev->runpm =3D true;
         else if (amdgpu_device_supports_baco(dev) &&
                  (amdgpu_runtime_pm > 0))  /* enable runpm if runpm=3D1 on=
 CI */
--
2.25.1


--_000_MN2PR12MB4488C21D7862314BAF260E78F7FC0MN2PR12MB4488namp_
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
<b>Sent:</b> Wednesday, March 11, 2020 6:56 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: reenable runtime pm on navi12</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The runtime pm is verified as working now<br>
on navi12.<br>
<br>
Change-Id: I20393633678297308c9651237bbfdc854a3cff94<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 &#43;--<br>
&nbsp;1 file changed, 1 insertion(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 80495652a7c1..e376dc072d42 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -174,8 &#43;174,7 @@ int amdgpu_driver_load_kms(struct drm_device *dev, =
unsigned long flags)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type &gt;=3D CHIP_TOPAZ) &amp;&a=
mp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type !=3D CHIP_VEGA10) &amp;&amp=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type !=3D CHIP_VEGA20) &amp;&amp=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (adev-&gt;asic_type !=3D CHIP_ARCTURUS) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (adev-&gt;asic_type !=3D CHIP_NAVI12)) /* enable runpm on =
VI&#43; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type !=3D CHIP_ARCTURUS)) /* enable run=
pm on VI&#43; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;runpm =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (amdgpu_device_sup=
ports_baco(dev) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_runtime_pm &gt; 0))&nbsp; /* enable run=
pm if runpm=3D1 on CI */<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488C21D7862314BAF260E78F7FC0MN2PR12MB4488namp_--

--===============0427364033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0427364033==--
