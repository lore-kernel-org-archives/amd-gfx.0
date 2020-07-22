Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A8AC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 13:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C5620717
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 13:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rHWYsfwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C5620717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFAB36E05D;
	Wed, 22 Jul 2020 13:38:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C636E05D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 13:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpenqSLQGUNoNKusx+0rE4ac34M5y8RigdUlDiSfFJMg/t0onBU6Q+HW8Mc90qJu1aBEiVE9rUzNrSH/di7+ZS6VAioJ4OkhpekLQEEN4dmXwvMTVtwoJ3TrQyOQdpBEh+LIDIcIzQJAnoz/eg3mXYBdvrQlePjukGdIJbVY0e4xYgv+1E8bLJCa4MS75CHQrCPd5m7Ob/aSFPW4OBcb4Tr3u3U5o/weo4EaKAZ3ywgrmvp3BHC0reJw+G6QFYCiLOruB5Cfu4eE/L8yAiKCunQrtenSGooarrPYFnrBdHJ9rzmDk78iFE9omn1LGrV/s7VEd/uNhj8pBYolI7ZUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w+FBLIOZ8kAWyIUjRRHjsfqhVG5OPDi7Eb/FWtHqO4=;
 b=Yt9IwkaKr1ibtIv+m3EBPkugiYdNDaRRsHEpjfkoVNFCnSqZ8/DBaAe2CIMG9BXY7cVgCNjoB6f64z3mzvu2jtu6HYSqnO29mnBRfmmWVsbtEKszcWNrz2z90884aoBON6msIs2h2Tkz3AwuI+XrXE5reIZggfAH3H6P/e6lQMdoZ5oU9mb8C2lC087buiBg4cvHCEYxB7f+pB1X7d9VBNwOpN6Ef1InSEZ5Z7dKDIi50dJ7xCNMwyj/ymasEeE9BMNhyE/ku5ZbsUk27NsyF+kcvO5NFswwDfhe5wrQul8O3ZBSoyT9Ef2kvEdGV4t5rR8Pptb7XK/C2uU+w6eS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w+FBLIOZ8kAWyIUjRRHjsfqhVG5OPDi7Eb/FWtHqO4=;
 b=rHWYsfwuQoW8DBTVTIMElrr8QNTtb5OiCsFe/uDo2NF2303pOIKq0enA3rdEfIzlLLDBZdp/VvM5RLQwtlbvaGtfEAV7VTjoLfx3OSC5WmSgh1FNDBWj5gfAqHTyHSUHAzTMxQZIdhkCeVYVWSrevQacFmeA806cvjOwAsPmbyQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 13:38:53 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9%5]) with mapi id 15.20.3195.025; Wed, 22 Jul 2020
 13:38:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix compiler warning in df driver
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix compiler warning in df driver
Thread-Index: AQHWYBzv9pHSmiUe2E26WpYoSHCJ3qkTmnoh
Date: Wed, 22 Jul 2020 13:38:53 +0000
Message-ID: <MN2PR12MB44883FE4AD8038DBB215C565F7790@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200722114028.1204439-1-tom.stdenis@amd.com>
In-Reply-To: <20200722114028.1204439-1-tom.stdenis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-22T13:38:53.146Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33625b12-07fa-4a8e-c067-08d82e449370
x-ms-traffictypediagnostic: MN2PR12MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB382355D2ECEBA57B3A565D03F7790@MN2PR12MB3823.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:46;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hLoGU5F3BrE2l2onDQhe4SvtRX3tZ9ptihxGeAo+AT7Bn0ypt8oWiCKmJfrCKGnmIF4Ha0bh1Dj0vkG3Qhxm0DYxajMADVbjrSIUU373sCt8qHwBniDdNQGJ7nm4dOg/bjk3uuhtKtENgnZGdODUQoKHEXnSG0Kbt+x61qZLKdQs1+2A+FC1FsEzXd+t/Ugl5VZVapAqsZ1sVXDzgu38WiCAl3eAKR8wZIfcAbVel/9WyezgUGdibXbxGEJ3movC3XZ488uZALhyoRmwg9eslt/PSOmArlyJoUUE57QqQmjLxTf9kjntgOzg4QxTypL14jX5z/2O8UfdgKrL+0QIeXNRel2nT23Avu8aYsdQ6tw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(166002)(83380400001)(186003)(26005)(966005)(52536014)(7696005)(53546011)(478600001)(45080400002)(55016002)(2906002)(316002)(110136005)(6506007)(5660300002)(9686003)(86362001)(66556008)(76116006)(66946007)(64756008)(33656002)(66476007)(71200400001)(19627405001)(8936002)(8676002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: aPUgE6iZ//aapmtibgV0YMMDQuFiziMjFI2k0F9bzqEt1JYLZy4zGwB/P8mXuJNDjizvj/hZ18JVy7mNZoMtcO84rupPkzcaeyuV7/R/sMULE//1drHlZ+F1m/W5jH3lL1F3/LY09t3ysUbw5Bi3OKX4A2cJPObbQoQcnexaxz9wLK4bP3jNdNoLOo215Kk6glHhGKyoN1XgM16po3+crLLgsvkHxUEBrEjE6hRz53DluyPMOTusAXNWPx8MTIlWJau7YGOUKj6TEyfimQYMing2Aher+O6Pdz5K9qPv7StfQpe93sf0gdeAYREQBNB1HHiFz0/9LnPqeFXQ9Wfe3jMaHr5W66wK1Umc9B/i++k6vNZsYGFlSlw/d4jPzaY9hKkVN6jqLJuyebGdH+Xf7LHcN64496EVoIoF6Q5ak3AwqNax/hWzCoilpvT0uZAXg9rbUtIK3lHLzMW+uWNWxlC5ndRUvwH/DpnFrCQuci1dByy7ppwjUFgcuex+DuHG
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33625b12-07fa-4a8e-c067-08d82e449370
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 13:38:53.7586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0sAiFgAKvlZsyjdq5vng9Xm4Uw8rY9PknTpFsiuz5ydddoVJKOR3DNmR49AqD5euKKkOCLJuIN3lmc69j3FwyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3823
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
Content-Type: multipart/mixed; boundary="===============2080417811=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2080417811==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44883FE4AD8038DBB215C565F7790MN2PR12MB4488namp_"

--_000_MN2PR12MB44883FE4AD8038DBB215C565F7790MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tom St D=
enis <tom.stdenis@amd.com>
Sent: Wednesday, July 22, 2020 7:40 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix compiler warning in df driver

Fix this warning:

  CC [M]  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.o
In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h:29,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h:26,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu.h:43,
                 from drivers/gpu/drm/amd/amdgpu/df_v3_6.c:23:
drivers/gpu/drm/amd/amdgpu/df_v3_6.c: In function =91df_v3_6_pmc_get_count=
=92:
./include/drm/drm_print.h:487:2: warning: =91hi_base_addr=92 may be used un=
initialized in this function [-Wmaybe-uninitialized]
  487 |  __drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~
drivers/gpu/drm/amd/amdgpu/df_v3_6.c:649:25: note: =91hi_base_addr=92 was d=
eclared here
  649 |  uint32_t lo_base_addr, hi_base_addr, lo_val =3D 0, hi_val =3D 0;
      |                         ^~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h:29,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h:26,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu.h:43,
                 from drivers/gpu/drm/amd/amdgpu/df_v3_6.c:23:
./include/drm/drm_print.h:487:2: warning: =91lo_base_addr=92 may be used un=
initialized in this function [-Wmaybe-uninitialized]
  487 |  __drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~
drivers/gpu/drm/amd/amdgpu/df_v3_6.c:649:11: note: =91lo_base_addr=92 was d=
eclared here
  649 |  uint32_t lo_base_addr, hi_base_addr, lo_val =3D 0, hi_val =3D 0;

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amd=
gpu/df_v3_6.c
index 1ab261836983..0aa1ac1accd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -646,7 +646,7 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device =
*adev,
                                   uint64_t config,
                                   uint64_t *count)
 {
-       uint32_t lo_base_addr, hi_base_addr, lo_val =3D 0, hi_val =3D 0;
+       uint32_t lo_base_addr =3D 0, hi_base_addr =3D 0, lo_val =3D 0, hi_v=
al =3D 0;
         *count =3D 0;

         switch (adev->asic_type) {
--
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C95d3961b50a743867b6c08d82e340fe9%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637310148439516686&amp;sdata=3DmkDp4Wqa3ZSS9T1Tr%2=
B0HvNhb0Il2RhD4RZ6WT%2BDXL9M%3D&amp;reserved=3D0

--_000_MN2PR12MB44883FE4AD8038DBB215C565F7790MN2PR12MB4488namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tom St Denis &lt;tom.stdenis@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 22, 2020 7:40 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Fix compiler warning in df driver</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix this warning:<br>
<br>
&nbsp; CC [M]&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.o<br>
In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h:29,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h:26,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from drivers/gpu/drm/amd/amdgpu/amdgpu.h:43,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from drivers/gpu/drm/amd/amdgpu/df_v3_6.c:23:<br>
drivers/gpu/drm/amd/amdgpu/df_v3_6.c: In function =91df_v3_6_pmc_get_count=
=92:<br>
./include/drm/drm_print.h:487:2: warning: =91hi_base_addr=92 may be used un=
initialized in this function [-Wmaybe-uninitialized]<br>
&nbsp; 487 |&nbsp; __drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; ^~~~~~~~~<br>
drivers/gpu/drm/amd/amdgpu/df_v3_6.c:649:25: note: =91hi_base_addr=92 was d=
eclared here<br>
&nbsp; 649 |&nbsp; uint32_t lo_base_addr, hi_base_addr, lo_val =3D 0, hi_va=
l =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~<br>
In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h:29,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h:26,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from drivers/gpu/drm/amd/amdgpu/amdgpu.h:43,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from drivers/gpu/drm/amd/amdgpu/df_v3_6.c:23:<br>
./include/drm/drm_print.h:487:2: warning: =91lo_base_addr=92 may be used un=
initialized in this function [-Wmaybe-uninitialized]<br>
&nbsp; 487 |&nbsp; __drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; ^~~~~~~~~<br>
drivers/gpu/drm/amd/amdgpu/df_v3_6.c:649:11: note: =91lo_base_addr=92 was d=
eclared here<br>
&nbsp; 649 |&nbsp; uint32_t lo_base_addr, hi_base_addr, lo_val =3D 0, hi_va=
l =3D 0;<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amd=
gpu/df_v3_6.c<br>
index 1ab261836983..0aa1ac1accd6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c<br>
@@ -646,7 +646,7 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t config,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *count)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t lo_base_addr, hi_base_addr, =
lo_val =3D 0, hi_val =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t lo_base_addr =3D 0, hi_base_=
addr =3D 0, lo_val =3D 0, hi_val =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *count =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
-- <br>
2.26.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C95d3961b50a743867b6c08d82e340fe9%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637310148439516686&amp;amp;sdata=3D=
mkDp4Wqa3ZSS9T1Tr%2B0HvNhb0Il2RhD4RZ6WT%2BDXL9M%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C95d3961b50a743867b6c08d82e340fe9%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637310148439516686&amp;amp;sdata=3DmkDp4Wqa3ZSS9=
T1Tr%2B0HvNhb0Il2RhD4RZ6WT%2BDXL9M%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44883FE4AD8038DBB215C565F7790MN2PR12MB4488namp_--

--===============2080417811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2080417811==--
