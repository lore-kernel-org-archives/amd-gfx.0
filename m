Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B954EE57DF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 15:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D0110E1B2;
	Mon, 11 Sep 2023 15:17:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC0510E1B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Sep 2023 15:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJXENtfiqUW+nbLM6XMkBKqvkys1KRENYVhCBi61T0QvJSnCkO2e4NPOxlXjjeZ39SBQFAojjI32OSu+Te0DqVIQUOI255V0hT60sROEu2DDu/lsxPud2DPgbJtLh2I1Nd3UKclibJ225pF0rPzr/u5Z8GKDYq8+PQ0yS+0M592FmDStNSqxyfUqJPono8AnvOC50EWRcrhNAxqwFnmtsCOuplOEryg2Sux63OPmG1eZ/EbRJ1LTlVq1kJNJZ0NCHCgReQehgQBkHpIFpDx7ZXpgLL+ECl7OGQAyvfzi7HwwkKEST7X5q0zUPnOOw/Z379P0MamrIRydLssD3kqSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH+riNl6ztxfwtW0sr5UUVXZycQUBAehHG8BanJwBu4=;
 b=XjMLG62S3J4gKkp9XhcC/JmzozPamO4NlLbr86whhW5VsVNHapENikQ1eDLYzqubAgcyJSDuFjSWOS5QEsQpKVtDpgy4adSDMetLrijuC6m9Enr2ENBG2B1GRRbJl3Aee/EeF8Yg99hcsY5dacxXyoBLj1FuEeCHnm2qzPpBgEy2jT4hurh6myCd8ocn4vgVadHNV5Po21TOAXYUGLZJgXytv3WN6H1+UTJFgiv0xmIFdWVzMIbs99wVHlp/tXOYTUYXdXLg9fFCwNwanNg9wsdCCGGIatziCtJOTtGEj5fLYPN/MabQ7TKPKk9//Nfv4uf+ugtsbbSEWDNAmrEbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH+riNl6ztxfwtW0sr5UUVXZycQUBAehHG8BanJwBu4=;
 b=pY801E+155X+n4Tvx9Ln7fOhvCko6SSFlAKxledLQN0hcCoI/cNwU9kIf7j93IiJhDYXFA2uqIFA7BOIWkkKOZDSn/Qd5nGIriWswuFtTwdb91sYj8Dgiy3OPGBKqx+DyMO0ZQZtBO/ZxBMAPFwrKeQ9vO2ggsrcf6ZXwK0vMrQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 15:17:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::629e:e981:228d:3822]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::629e:e981:228d:3822%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 15:17:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: Handle null atom context in VBIOS info
 ioctl
Thread-Topic: [PATCH v2] drm/amdgpu: Handle null atom context in VBIOS info
 ioctl
Thread-Index: AQHZ5LYYxUYjEayZj0a+DGex12zolbAVvIzk
Date: Mon, 11 Sep 2023 15:17:15 +0000
Message-ID: <BL1PR12MB5144F96224B33CDA693172CFF7F2A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230911134403.511233-1-David.Francis@amd.com>
In-Reply-To: <20230911134403.511233-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-11T15:17:14.548Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL1PR12MB5159:EE_
x-ms-office365-filtering-correlation-id: 009ec2b4-5f9e-4bcf-4a1e-08dbb2da2e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQrj/9woISBrj5b1TVzBFU9NN7tyZq9DP7NwOY684FsEU3VGTQhRPyp0kubG81dSp/buifQa41oAW1ZQ/+haBX8x4HC/zprJ/rcOWrE4SPEVXo2Pq3veNKbe84ddyLSymeanulAZ641rb4zbRvxGBxdWhOmid93KUm6E6mE45TPjQyL8+kBXTq6A0Fof+K93aAg8mokqcr3MrX/v6aygIAt5Uoyg2J9NTPscdd4kdX7MZqRY62blxzqA9/dfPtxxZOTaT2KSl5u/j326++XnUYVyD4xOT/D+dEW8xzB26GbhAAB7NrelpHsYK/HaliesrjqY7xzocd5RF6sZYWbSyr3p3iIyLcuLT798uoXoNhO+SRO7aRHfykd7QUuUIhZWLfi+35acfqyYtv5W3/tEAtCsvVnvXC6eBT50dYTbZiVj+KH+iHM4nQSaTUXAA9Gzwi7gGoOI94EyaXPBhEEuQ/9lvmlhmpeSTiJYP+O1vknnZe3H0zDbzfmefj8k+5WnK1/cfacMaqnFq7svYvjNj+17/Tyt+cc6Tl8XQVN9dwApkLX73CzjBX2JPx1pglXT3HzFtDg//awnnh0mGvTweeIXHMaHmR9zJ6iy3V5caHrg8F/4mxOUmk1GiBN8YEls
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(1800799009)(186009)(451199024)(76116006)(110136005)(86362001)(26005)(2906002)(83380400001)(53546011)(7696005)(71200400001)(6506007)(33656002)(9686003)(38100700002)(122000001)(55016003)(478600001)(38070700005)(52536014)(5660300002)(19627405001)(8676002)(8936002)(66476007)(66556008)(316002)(64756008)(66446008)(66946007)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XWTIep6n20iwBXxm0yZQbUHm54TYSknbQ6DcVSNBGPH9Txf3pwVnL54pk/MH?=
 =?us-ascii?Q?HY9ik6AG18n6YhcY6NUR6mKJsXOp35TaBwQAX+8TKDHiMK7P44G00/FCutJk?=
 =?us-ascii?Q?Bao/lc/ap3nB9qd6/yISWZY+6Dyi7yrCyqX6PO1A0BQRSUIqrFsdP+7Z0ua4?=
 =?us-ascii?Q?ShHEbH0AyqX2FfQvOojH1e75S/DYSaDSjLsCrIB0oBe57J8zjYuu7+EXAQ6b?=
 =?us-ascii?Q?lCJaglwhgDB3yQZll1K2wz10LXZ07V/lOu/HbVFEn03+m0RqNbe9OMc1HT49?=
 =?us-ascii?Q?3/Mu0HSeGDQDP8nF16LWsCAcZ7ukf9Hzt0B3kmySnZ0COaBbgaqdLCWjyOwK?=
 =?us-ascii?Q?Vd7zNaOPIO7td7Gi7chpVAZvD3ReLvn35MHksToXAnn8dNHHphIivhxVNcJR?=
 =?us-ascii?Q?yLsfLwH8XWX86kapWMT84LorXDEq+BpL1vNrogwq+YR1DfV97TxVVX+qYNyU?=
 =?us-ascii?Q?sRVSGcpczyZaTbvRERPqVH/HVY00tFyXASkKl0ph9nWu/XxGf7TYzklriSat?=
 =?us-ascii?Q?kr6ZvSi80X7BIDG/ODP7hQuM6Kl+xicBldFk85013sjDEBQWSwq1K/Z62mVy?=
 =?us-ascii?Q?iHwfC/9Pe7tUMIIEW4lYCQc8r3vGLVxtdErH5YFeaEo1SdI5dwubfqyr5WhS?=
 =?us-ascii?Q?hH8lwl5nchu53HbONOxZ0R1Hb+lXAQUyMcrzXM5tGxrHTPoqbQMLCbov5O3C?=
 =?us-ascii?Q?uqPFB88+3BihKcjvFLwNOlDej5tId/aFBaRpWouUgl2A+uwUGUg/9U9eWACL?=
 =?us-ascii?Q?LRTU6cky4JBTk43g0kj1YygCfvyH18UaIlr6/ppFbJ6BJDTS0lWHkLaJdbmh?=
 =?us-ascii?Q?84RT/MjaJJymuE/cBcwsC/qWPVyzbN1gOg+Y7aUIDKGplcnVfZsuJJbZvtqM?=
 =?us-ascii?Q?e13/JSlAZNwrmaBF0/bSbY3EpTqW/Se1Blak1Yl1HNpkEgW3YbUEnREkEb+F?=
 =?us-ascii?Q?mbd9T9I1keUZ2dpMKJzOb4eYKzGOw6shRrrewoIXy/YRU8hbNKxM34mk+pR7?=
 =?us-ascii?Q?UxM2sE4EAtPZRNc6O4tPgfXs8b74KflDSwLkdgMzQ/sWGnY/g1kHbOSXnK0D?=
 =?us-ascii?Q?guRUfrEMZGqJT7kGu22RWx23CAxUz9aYKaLS/gRTNmAwojBxm3TT0L8c+ODs?=
 =?us-ascii?Q?f1w65VfAhSvqhf6Lor9UaYgxGWH17yZcRsdMUd+cecElYX8ajo4DqHaIocZe?=
 =?us-ascii?Q?jvQ0UeGptQlfphN5USm8JYrfSuOW7jbmJfGWUBn49kr+a5bs2s8nZ11S5ROI?=
 =?us-ascii?Q?6Nhc8LuFL3ElB9y77y8iMjUMiwAp5NWDp0X591vYv4F9J/4yeLIItzhZTEh7?=
 =?us-ascii?Q?51LaxUuGHOlTA1ffRG7yQ3BrQghzb+UTxBA1MjMQ1mcG028QRsShXaV/Nub1?=
 =?us-ascii?Q?SoZBa7ow2SKBm19g1W496YGOpvdC8EYzcRgjHChtk32+gBNi5aVVWXOr8zX2?=
 =?us-ascii?Q?+/MZovWdkDxu/CRzJh4Um/Scz8+I/1xBizSpdlvy3GEYRIq4SKbRH4/z6wuq?=
 =?us-ascii?Q?ofLl/cFbjR5yE3dF/wttFdFIVajxzqIhU8T+ni0UxqEv/AjFNM81mP4DIAOk?=
 =?us-ascii?Q?4XNQCiZ7BbuIqyoS2rg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F96224B33CDA693172CFF7F2ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009ec2b4-5f9e-4bcf-4a1e-08dbb2da2e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 15:17:15.3209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9woYHjfa72ghEGQhfMP0x6gQxl3XnH0h36xbOV9rLn+19W4evMZe0m8pbWEYbUb+VN5i4FyanqcBclwlAo3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
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

--_000_BL1PR12MB5144F96224B33CDA693172CFF7F2ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of David Fr=
ancis <David.Francis@amd.com>
Sent: Monday, September 11, 2023 9:44 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Francis, David <David.Francis@amd.com>
Subject: [PATCH v2] drm/amdgpu: Handle null atom context in VBIOS info ioct=
l

On some APU systems, there is no atom context and so the
atom_context struct is null.

Add a check to the VBIOS_INFO branch of amdgpu_info_ioctl
to handle this case, returning all zeroes.

v2: Maintain current use of {} initialization.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index d462b36adf4b..a74ea53899f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -951,12 +951,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
                         struct atom_context *atom_context;

                         atom_context =3D adev->mode_info.atom_context;
-                       memcpy(vbios_info.name, atom_context->name, sizeof(=
atom_context->name));
-                       memcpy(vbios_info.vbios_pn, atom_context->vbios_pn,=
 sizeof(atom_context->vbios_pn));
-                       vbios_info.version =3D atom_context->version;
-                       memcpy(vbios_info.vbios_ver_str, atom_context->vbio=
s_ver_str,
-                                               sizeof(atom_context->vbios_=
ver_str));
-                       memcpy(vbios_info.date, atom_context->date, sizeof(=
atom_context->date));
+                       if (atom_context) {
+                               memcpy(vbios_info.name, atom_context->name,
+                                      sizeof(atom_context->name));
+                               memcpy(vbios_info.vbios_pn, atom_context->v=
bios_pn,
+                                      sizeof(atom_context->vbios_pn));
+                               vbios_info.version =3D atom_context->versio=
n;
+                               memcpy(vbios_info.vbios_ver_str, atom_conte=
xt->vbios_ver_str,
+                                      sizeof(atom_context->vbios_ver_str))=
;
+                               memcpy(vbios_info.date, atom_context->date,
+                                      sizeof(atom_context->date));
+                       }

                         return copy_to_user(out, &vbios_info,
                                                 min((size_t)size, sizeof(v=
bios_info))) ? -EFAULT : 0;
--
2.34.1


--_000_BL1PR12MB5144F96224B33CDA693172CFF7F2ABL1PR12MB5144namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of David Francis &lt;David.Franc=
is@amd.com&gt;<br>
<b>Sent:</b> Monday, September 11, 2023 9:44 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Francis, David &lt;David.Francis@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: Handle null atom context in VBIOS in=
fo ioctl</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On some APU systems, there is no atom context and =
so the<br>
atom_context struct is null.<br>
<br>
Add a check to the VBIOS_INFO branch of amdgpu_info_ioctl<br>
to handle this case, returning all zeroes.<br>
<br>
v2: Maintain current use of {} initialization.<br>
<br>
Signed-off-by: David Francis &lt;David.Francis@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 17 +++++++++++------<br>
&nbsp;1 file changed, 11 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index d462b36adf4b..a74ea53899f6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -951,12 +951,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t atom_context *atom_context;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atom_=
context =3D adev-&gt;mode_info.atom_context;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_inf=
o.name, atom_context-&gt;name, sizeof(atom_context-&gt;name));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_inf=
o.vbios_pn, atom_context-&gt;vbios_pn, sizeof(atom_context-&gt;vbios_pn));<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.versi=
on =3D atom_context-&gt;version;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_inf=
o.vbios_ver_str, atom_context-&gt;vbios_ver_str,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(atom_context-&g=
t;vbios_ver_str));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_inf=
o.date, atom_context-&gt;date, sizeof(atom_context-&gt;date));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atom_context=
) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.name, atom_context-&gt;na=
me,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
izeof(atom_context-&gt;name));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.vbios_pn, atom_context-&g=
t;vbios_pn,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
izeof(atom_context-&gt;vbios_pn));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.version =3D atom_context-&gt;ver=
sion;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.vbios_ver_str, atom_conte=
xt-&gt;vbios_ver_str,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
izeof(atom_context-&gt;vbios_ver_str));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.date, atom_context-&gt;da=
te,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
izeof(atom_context-&gt;date));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n copy_to_user(out, &amp;vbios_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min((size_t=
)size, sizeof(vbios_info))) ? -EFAULT : 0;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F96224B33CDA693172CFF7F2ABL1PR12MB5144namp_--
