Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89375C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 17:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B5A6117A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 17:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B5A6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD42C6EC29;
	Wed,  5 May 2021 17:17:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D74D6EC29
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 17:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLreMewyTPwTFQzZ7mM76VTtqbdhOP0KP3acAffqrlKixpISQZd1fUjmx5D+3nrelAc2k5X3Y1MmaW2q+mNAXis8QKP1ubSEJRrDke4eJ812c2+jztpFg2rY2rmZ1abn/X6wxqtERMm9OFj9Z+LFuKF5kY+e/oEA0oiuVUj18Ic1xRWExra3oo+Z14kwTstDYIN6laFxCITaYKSeOnVZsfMnilBxur6SLVvpTofc+NRsE2XSiouZ03F89ZXN3YIE7aH3XTDZGaiN4FxGvRu1R4Fj/OB+eQBvSxB6Yg3SYWNhSR0wEnNnTIe6xjo4brNunbGksN/vGviGkbPfFTvPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjF852G0HjeEAzd1uQ7at5Kv7RGCr/dCBjZOKYfrXQU=;
 b=kWcjYGrNeLxl/z/pNzteunrttPmForvuUbESrQ49huYxfNpI6wzZlRgssnYziCT8q6mydR0MXaJGDI1dn5/Ve1Rb6lglm5sKuVZ8hW0tJ0fMa/0q/Y42ls+zlIEFRY/4149szrlicsN3sN7YLElFLA6flO1E8DcwiLZqG/e6Ux3g1GwhZ9TkS4Fi/Ypqm67jcgnyY5r0eJCwQ31GW91N3cKQI8kVbJGSJUxzNf1e0knhuFNrI7uRhyGGGGSAUNNmUlntKiRRY9VqTeExDuXPN+6QVq6ABTe/tl9+O1Mnib8Jo2/44Wz09xg2TuJ3x7Plg4cKcx1SYtZreDshiAJJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjF852G0HjeEAzd1uQ7at5Kv7RGCr/dCBjZOKYfrXQU=;
 b=jb+ThokuNVxUqu9z/JpOYcKGhcFlrrMzq3b/4lpfxeE7q1INP/i/NC3fAiprf5tc/wiX2F8a5xc4+6aiaoQMAJCygt+EsUSwdYseXF6Wx2U83LYez/7srJkeF9oFPYTnutDYC+LGP94fb+fp4/e8OLAU+HckgJU4JXIBO45MnQE=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3870.namprd12.prod.outlook.com (2603:10b6:208:166::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 17:17:19 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 17:17:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: set vcn mgcg flag for picasso
Thread-Topic: [PATCH] drm/amdgpu: set vcn mgcg flag for picasso
Thread-Index: AQHXQa9sdu29SZ9wb02enlkwfc+sx6rVIYBe
Date: Wed, 5 May 2021 17:17:19 +0000
Message-ID: <MN2PR12MB4488D7017D8C871161057025F7599@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210504092726.15498-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20210504092726.15498-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-05T17:17:14.485Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c2d7dd3-5274-4029-c3bf-08d90fe9a397
x-ms-traffictypediagnostic: MN2PR12MB3870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38707DB797A01B6BE51AEADAF7599@MN2PR12MB3870.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bIMNLjZZGmgdENe7aa+g/CQo5tGua7/kb9pbT8O8zZ36CdtmJsO/cvjw+H7REboOZoTFFXMobrSUngb6jM6dSw3t/BR7U1yCRyGndcfaVqsdb129OhJ/d2aDvyW4U4YEh4AEukBYz+gRehvEPurIZHb6h8zQ2RLNUYeBv32vs6Qv/XqckJrnRH7iBfLTzzweNWtQUbKbQ77X8CO2+mlfs0+Zm8sljhJHFFdgziemSmUoD396dNZfWcWA18JBchXqAkKreWDpPZlEaEYoKNgGW3ucHM8EQefVqvX6KU3+RT4O04p6MUi4Q1UTEjlkYFky581RTRfnML1C9jayUjPx2hW/BqPUkRtj1XmTM2/Jed3DfxhyWC1hK+i8MGwiPuRAbPIChUth8kFNkpxDiEGz4s7ryiKTmmh2aedG3qqqsRpNdphoLPgqp2SvAyqKIq5Tk2mgcBYyUbmH5fH55ghXMNq3ec4HwFHZRsytremjvbKF/fVgeT+gVJY1tMFXjG9ntQqjlIYdf5f8ucQ2Q5Evn1SntAEMjQTafy5weUD03RyNgFDn4s3zSfWeUW0kPXlM8D2pwIKFlXocKKpYn6Urf4wjH5Z7wTKIT/M0qNZNvBs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39850400004)(7696005)(71200400001)(9686003)(83380400001)(5660300002)(55016002)(110136005)(316002)(2906002)(478600001)(4326008)(64756008)(33656002)(38100700002)(19627405001)(8936002)(26005)(186003)(8676002)(52536014)(122000001)(76116006)(53546011)(66556008)(6506007)(86362001)(66946007)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r1rOyXtSjIYuXB4xaHx2tAPERBpTPnuFZWXRuP24uR8IvYVujjMGRzM1ZFQh?=
 =?us-ascii?Q?gJtM7VbkQxmKyqxE/GSt5nMi2+hHHSb9A3mZwhsTFt7Jx6Ryr/WIjN48PWuS?=
 =?us-ascii?Q?GniQjTmuVwLayzirAYv/j8G2F92nsEGdv1KKL/aawuOnQ2DudLm3Ev5bUfqU?=
 =?us-ascii?Q?9h9mQYZfSCeeq5bTPnTUGMQ4opuXkdFhagBit3iUvT8aE8T8eAeDbH1x4Rvp?=
 =?us-ascii?Q?dxi79oWyDn4l74chinft7G2VS9Ne1SZL3wbYrNiDnMA85K3frJqADL46hsye?=
 =?us-ascii?Q?+p+s4Y7eie9DJjgg865fv8gIM2fTyFDhHsZeZTzZ5Xcasw6WzuKcaoH6Mf2J?=
 =?us-ascii?Q?brqFfXguaDAgGWJWMMcSilM+PzwHHoVv4eVo845JH8IZ4aFWBsbrL36z1/hD?=
 =?us-ascii?Q?KcNle1vr8Ue0TXYDSVmBd52ZwKNnwmvp7rEPZoQIB/xFqwRQmAQyqrK74n6o?=
 =?us-ascii?Q?GKAhE5O/dc481sKbwd8rfxWZ10/RsHMkwp+Rx8+n7sDsT8a1m/zJ8zEI+b01?=
 =?us-ascii?Q?unEIqWF7m2qKajIN/MSiS+9IIJH44VkkCMLxKeei9p+FqZjW0nhTHchZm2hE?=
 =?us-ascii?Q?UGZ3rCy95ry/tyn3a+9ZAJ0dbVIyAJx/vLfMiFPQq3xSsjqfQ1x9fsxqvo37?=
 =?us-ascii?Q?DJHr7pK4NzY+/LHoPgdYii2qFkohR21HcSVn/Kqd4+OGiOGnbFPE9Gj+ISQF?=
 =?us-ascii?Q?U1ARcdYpTa1kWZvo1oIe3Rs8aebxBYWPqAKLXKGd1XvitVnGJOqmWmB+oPCV?=
 =?us-ascii?Q?av+gaUS7VjI3giNM3Q3iTJesTCZhbNjosjrTgZ+rFWJlHXydXGlnmfmFJfSI?=
 =?us-ascii?Q?tKRCd1ZKFyMi5QGyaxmEQL04+bFFpVlahQb/ljxp3uL/sqxlTfLJj13Kwt4+?=
 =?us-ascii?Q?G6K1o95NwktS2clbLJrnQrMMlo2pmPu6mFZFR1sNVqbHQETCzCLN571Not9b?=
 =?us-ascii?Q?UQMSg3k8n8DyPNpz2BqeM9uHfvRdFkwltki/KIASxDS9jBTiDIgByFmqT6eE?=
 =?us-ascii?Q?vZS0cJ1Rp8iNglxR8AIDvIxv1ski/c6yC3lkiUMJdTj7LvgSH+KCmbO6IBem?=
 =?us-ascii?Q?cTPLK9C7lipYEbTKgVTQpU8UXya3TV2W9plDzZ67ul94rUNQsXWJCu5Z0tMc?=
 =?us-ascii?Q?EjTCe0JXZFFfjCg/ycBcP0cs4gXnZD8TQoBJpDzjCaAZNqHZolvqWRKY49ZK?=
 =?us-ascii?Q?sRBDWOKdXefGAc3jtlT1fGeqnj/bVxm4v+5UFW4uC6YPiB6J045Wwk9IM7/L?=
 =?us-ascii?Q?tBD3c8PWZcSSpuNYKdrQCgGKo+lpNiVnF2KE7VY6hqPxmPl6JVlXhaWTjnJG?=
 =?us-ascii?Q?FLFrAbdnQGgeC7nVWSLq/5Lk?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2d7dd3-5274-4029-c3bf-08d90fe9a397
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 17:17:19.4491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROszDdd7YA1+8I7b3qBe+b30XtR/VXmy8tyoofXUoGFVjVuM4Na7bODfwQbX+BL94vQjOPvxcFPGnfp/VlPK/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3870
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
Cc: "Liu, Leo" <Leo.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============0726921965=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0726921965==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D7017D8C871161057025F7599MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D7017D8C871161057025F7599MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Sent: Tuesday, May 4, 2021 5:27 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu: set vcn mgcg flag for picasso

From: Sathishkumar S <sathishkumar.sundararaju@amd.com>

enable vcn mgcg flag for picasso.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 28e9f6b726a6..e3f42ad1e6bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1401,7 +1401,8 @@ static int soc15_common_early_init(void *handle)
                                 AMD_CG_SUPPORT_MC_MGCG |
                                 AMD_CG_SUPPORT_MC_LS |
                                 AMD_CG_SUPPORT_SDMA_MGCG |
-                               AMD_CG_SUPPORT_SDMA_LS;
+                               AMD_CG_SUPPORT_SDMA_LS |
+                               AMD_CG_SUPPORT_VCN_MGCG;

                         adev->pg_flags =3D AMD_PG_SUPPORT_SDMA |
                                 AMD_PG_SUPPORT_MMHUB |
--
2.17.1


--_000_MN2PR12MB4488D7017D8C871161057025F7599MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sundararaju, Sathishk=
umar &lt;Sathishkumar.Sundararaju@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 4, 2021 5:27 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, Leo &=
lt;Leo.Liu@amd.com&gt;; Sundararaju, Sathishkumar &lt;Sathishkumar.Sundarar=
aju@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: set vcn mgcg flag for picasso</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Sathishkumar S &lt;sathishkumar.sundararaju@=
amd.com&gt;<br>
<br>
enable vcn mgcg flag for picasso.<br>
<br>
Signed-off-by: Sathishkumar S &lt;sathishkumar.sundararaju@amd.com&gt;<br>
Reviewed-by: Leo Liu &lt;leo.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 28e9f6b726a6..e3f42ad1e6bc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -1401,7 +1401,8 @@ static int soc15_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_MC_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_MC_LS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_SDMA_MGCG |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_SDMA_LS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_SDMA_LS |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_VCN_MGCG;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pg_flags =3D AMD_PG_SUPPORT_SDMA |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_MMHUB |<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488D7017D8C871161057025F7599MN2PR12MB4488namp_--

--===============0726921965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0726921965==--
