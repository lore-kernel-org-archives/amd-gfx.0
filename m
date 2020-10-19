Return-Path: <SRS0=J5eG=D2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6FDC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 12:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9351222BA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 12:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fpLAU/tC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9351222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8166D6E92E;
	Mon, 19 Oct 2020 12:56:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBAD6E92E
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2020 12:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jutWnEln7PjWpK/v0E7LFRTE/bCalflDYTTlClnswMnaIQ2YyHD7a3VAXRKZ9/JPXclBLT8XkwqgcQkLCJUUacb6BE3w/04ixcoPO3zh5FLiTxsLCs0gVud/9KB4ocEGS95YH897fsONHmUhEm5L2uaulF1cOSdsqC3+bvfTU9ZSGwS4sIBaNGOBfmbN1I/WgTmuH/ZsTg+hY5F8tsPYxiMYkoi6knTZmmCso1SxghPE/fIQSYgIkY5uWVlEBbW3CVeM5aUQXsjXIW5LXrc8jeHSXdxBx5s9tG7uCX1sdZp42aieNP34evslQhXwOzOxcfLocPkJucuKXZ+MCm/zNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fh6fg/BB0uHKrwnoHV9iUkIwEmXjIY6tmQTZdYH+jY=;
 b=coP5QEjX2VDddCdrGDX7p4VkYwVNGlyL4/JPrj8M5Npg2F/z/6dvMfDflxlhaHnJHH9E1oSrwqoQqDt0gZ3wGeSysTOttG7VYNiQatjt0UQPxRWu1zPb8rDL7+XjynFpg8Bsep84PwxvlkoRuQjfTYVfyp/la+yBvZ+kvkWvNHCkWJSYyhz6nH2wc24UV9q8D61loOgzwuNsmbZTxHTQcZsARiYjZo3xKmsqf2ryuEPmMlcmA+d1q6Hc5MGNZaGRnfKEgdwt+Kd45LSbuJm9qpL47OQe3P+sRizszyVpoEBlRkyBdcOtCcEiBFaKfu+gtRDR9sMBlpMBPElmshx6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fh6fg/BB0uHKrwnoHV9iUkIwEmXjIY6tmQTZdYH+jY=;
 b=fpLAU/tC4NVVNbLCM2PxhGAmsgYUYomDqMLcxawRgPQPoJBubzFrTPEFWjcEkFN14iKBBOrQ2L3R9QxlJg7xHOqgycVgRY92RaaKWxJ7M3ggAz3dZq1PKBV71+OdNTq52qjM1WPM7T6Xp96M+0gB1TJfmQ62VTLu05AduE489AM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 19 Oct
 2020 12:56:49 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 12:56:49 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable VCN PG and CG for vangogh
Thread-Topic: [PATCH] drm/amdgpu: enable VCN PG and CG for vangogh
Thread-Index: AQHWpBOsa3eLhjLSvEunvMmv7QS5tame5jTl
Date: Mon, 19 Oct 2020 12:56:49 +0000
Message-ID: <MN2PR12MB448849FAC7BEA10970C081E8F71E0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <DM6PR12MB3132C2E22D2AB1A549FD1B5D87030@DM6PR12MB3132.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3132C2E22D2AB1A549FD1B5D87030@DM6PR12MB3132.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-19T12:56:49.090Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcc62449-82b5-4c45-0433-08d8742e71ad
x-ms-traffictypediagnostic: MN2PR12MB4373:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4373A7A514F58F93E2998610F71E0@MN2PR12MB4373.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUFj6paSCADGCoXvPN5pczhK6jBsD/fFH5XVJDkXr9DLxzJTj/ip8ZA3a7gTVfdm+ZbGhwD8Tbv6s8/CiiOIiItzy6sAuzCbt7PUM84NUm9314QPrrdWIfwoRDmRHZQUXugzwJprEMFJiVBHjrOllexYxA/VGHbVnQbu8NK+0TrxOHnYAlTFBuggnaWmgr2I+MqdBof0z7dAl7lnp3pMlefiBOKQz5L25I1eoTreXBwJNSrQURCpLa76hjtwa3LZocOyWjawS+wyw37mO2ZEOs6DFIO1eQM5BRx7F12TB+uRTqEH3JWZcbg2nadHVeDs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(186003)(316002)(33656002)(6506007)(53546011)(8936002)(5660300002)(26005)(110136005)(478600001)(52536014)(86362001)(8676002)(64756008)(55016002)(66476007)(83380400001)(9686003)(2906002)(7696005)(71200400001)(19627405001)(76116006)(66556008)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: R4r7b1+hs/bwtzrj/u5bkyQ4dCzE32CmsOCLaYaakRUW3lMiQsnMdTb4uiwzoN3A2CwIN87gwHJJ//1vjfx4oKZy71LwIKkMzJfhqYftQJ5LBj43+J5V0n53NSoCwpRewp7Ayp5bqLugx+LrRJjRaWPxYhqVvcXxp52zoZESyTVNHmhytPBjySMerWDGNFbfTzTnNVmLZ5qiyrIp/1ELtcFVexhIavgexjoItBFcB6XaDg0xK/u73B1jyKgeCeSeKTCVzfTzLkXUUj5lDTTOfZTGTvfrR0LhbW7DRDZ5zAn5cgxIym/QECHDhOetFEUlRBQdsyn4UkNY4K61FHJvLXzh+Wo/z9JntZbe7KUYvmrl3XruCqaHv01FTO9ZfMwsB3JbyN36EcEP9Z7NngzcsTem0ZU15MBX0P0MMjRc9/c6sOnWBZns7EzymzzS8mCSVzKq9QDix92rR+WZJ0adg+/DtCT9FN3JEHy9HI9KNOLd+t6qEDLfKrHP4GpujOmfKP94QBCypoKVixsP+klCjLKwBABH+PLvLRkYcMGHm1ioo+8CfU5qtAc24KpVgL1lKc/1wGZJlLVjo2ckYKnKxWWzO1KmYHSfhJ/nr87qZM/chnaJEi9MCSLO8RufxjDLowK0518P+OxqsXKic7Pudw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc62449-82b5-4c45-0433-08d8742e71ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 12:56:49.5535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TshL3rWbCbcnxzJ4hPnVJBnTSSS714zni37LKQGhdfu1G82DkPgCIQZ1soseK6Izmwt4rF5BK7aqV0SO75YXAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Content-Type: multipart/mixed; boundary="===============1724442292=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1724442292==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448849FAC7BEA10970C081E8F71E0MN2PR12MB4488namp_"

--_000_MN2PR12MB448849FAC7BEA10970C081E8F71E0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang, B=
oyuan <Boyuan.Zhang@amd.com>
Sent: Friday, October 16, 2020 7:28 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable VCN PG and CG for vangogh


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

Enable VCN 3.0 PG and CG for Vangogh by setting up flags.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 4b1a4acb60d9..ce787489aaeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -938,8 +938,13 @@ static int nv_common_early_init(void *handle)
  adev->cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG |
  AMD_CG_SUPPORT_GFX_CGLS |
  AMD_CG_SUPPORT_GFX_3D_CGCG |
- AMD_CG_SUPPORT_GFX_3D_CGLS;
- adev->pg_flags =3D AMD_PG_SUPPORT_GFX_PG;
+ AMD_CG_SUPPORT_GFX_3D_CGLS |
+ AMD_CG_SUPPORT_VCN_MGCG |
+ AMD_CG_SUPPORT_JPEG_MGCG;
+ adev->pg_flags =3D AMD_PG_SUPPORT_GFX_PG |
+ AMD_PG_SUPPORT_VCN |
+ AMD_PG_SUPPORT_VCN_DPG |
+ AMD_PG_SUPPORT_JPEG;
  adev->external_rev_id =3D adev->rev_id + 0x01;
  break;
--
2.25.1

--_000_MN2PR12MB448849FAC7BEA10970C081E8F71E0MN2PR12MB4488namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Zhang, Boyuan &lt;Boyuan.Zhan=
g@amd.com&gt;<br>
<b>Sent:</b> Friday, October 16, 2020 7:28 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable VCN PG and CG for vangogh</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>Enable VCN 3.0 PG and CG for Vangogh by setting up flags.
<div><br>
</div>
<div>Signed-off-by: Boyuan Zhang &lt;boyuan.zhang@amd.com&gt;</div>
<div>---</div>
<div>&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 9 +++++++--</div>
<div>&nbsp;1 file changed, 7 insertions(+), 2 deletions(-)</div>
<div><br>
</div>
<div>diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amd=
gpu/nv.c</div>
<div>index 4b1a4acb60d9..ce787489aaeb 100644</div>
<div>--- a/drivers/gpu/drm/amd/amdgpu/nv.c</div>
<div>+++ b/drivers/gpu/drm/amd/amdgpu/nv.c</div>
<div>@@ -938,8 +938,13 @@ static int nv_common_early_init(void *handle)</di=
v>
<div>&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG |</div>
<div>&nbsp; AMD_CG_SUPPORT_GFX_CGLS |</div>
<div>&nbsp; AMD_CG_SUPPORT_GFX_3D_CGCG |</div>
<div>- AMD_CG_SUPPORT_GFX_3D_CGLS;</div>
<div>- adev-&gt;pg_flags =3D AMD_PG_SUPPORT_GFX_PG;</div>
<div>+ AMD_CG_SUPPORT_GFX_3D_CGLS |</div>
<div>+ AMD_CG_SUPPORT_VCN_MGCG |</div>
<div>+ AMD_CG_SUPPORT_JPEG_MGCG;</div>
<div>+ adev-&gt;pg_flags =3D AMD_PG_SUPPORT_GFX_PG |</div>
<div>+ AMD_PG_SUPPORT_VCN |</div>
<div>+ AMD_PG_SUPPORT_VCN_DPG |</div>
<div>+ AMD_PG_SUPPORT_JPEG;</div>
<div>&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0x01;</div>
<div>&nbsp; break;</div>
<div>-- </div>
2.25.1<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB448849FAC7BEA10970C081E8F71E0MN2PR12MB4488namp_--

--===============1724442292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1724442292==--
