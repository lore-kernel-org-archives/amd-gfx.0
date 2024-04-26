Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC73C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4720810E07B;
	Fri, 26 Apr 2024 13:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yOm90sMB";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192EA88DE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8gyrSCb24Cn/x4j0sUHRQZBnsVw8q59krr3rzCjtGqk/HO5dhA6EyQJlNmWxtA8VV+TqpsyG9XCnQ8uzdkWg9rnSHm2L5snkTKPYvm6pn28uHCj30zqKRbfdBXD2AnP5mPZp3dvXDC8H5xCcY41TODMAOqvCUaEergN7f4Ycq5PuBzZHsM+ccLewV/iorPojCz5qg8vQarjTi+KBok7H+Ru0BlQn5KoZdgyExHC9wCf8fyDEJI6/aBCrc8uDpXPCKqIIs/XUr3uo7ufiaLgt5f1ow9UBqsJfi/ziPeEV2DcELvk52Xjq22s0Yh6Z3fQz1AVp+VpC3yVzmumKMjjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2s0uoXm0fNDtX6fQqAr66Xjmu7b+BGTHg+ifqhxinc=;
 b=IWSAEmkczvRiR3h/e+Bcq7eZrRag5O28UPC70Bgc2jkUnsY2XLGkJrabWwws4jZ6e25IaWAXHSfbY2+mmeP6w+vLvLMv4ARS4gwGDPmzl9/97Wp2f1nCAAI+eh2nVU9q3gQmZWY6EVodzva92I0fnSQGpUFpiXiED7gPQnE9yaGr/CdGMosH4xhQZPJxki3kEWiSJOjENNu2cJJkaJ4K+Jgbs2JstoQBKwC66KdK8uFc+oo37RcmFHyt9cApg2zJqUGXeWMPZs757mIKr7yDFViekiEOLTkkpV+q52q20E/cTbgUMZ5VR2gDKyVFs23FF+Gcfu9rWhAaoj2CZJQcTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2s0uoXm0fNDtX6fQqAr66Xjmu7b+BGTHg+ifqhxinc=;
 b=yOm90sMBeJd70o6SIBipSOTC73uHyzy7kXTdMIaA2nhDq5zGx28f4mWDO0P1/KOkIHhDeOk7jiiV9dV7ZqvCMzdqHNtUC6DliRq5Jr+skcKyUtX6L+vqmyXSv+Csmwpe4COzk5krBI1Zj5uMUOfwaHk+ccgOTZJE1dIyY77M3RA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:22:17 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 13:22:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add function descripion of new functions
Thread-Topic: [PATCH] drm/amdgpu: add function descripion of new functions
Thread-Index: AQHal6oU2Ayazl8sHUGqCxUbvwb6UbF6ihb0
Date: Fri, 26 Apr 2024 13:22:16 +0000
Message-ID: <BL1PR12MB51449DA6CAD97C4B58D03338F7162@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240426071858.131118-1-sunil.khatri@amd.com>
In-Reply-To: <20240426071858.131118-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-26T13:22:16.689Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB5854:EE_
x-ms-office365-filtering-correlation-id: a77a9d0f-a8ee-40af-bec1-08dc65f3e4cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?ztgGEA6Iji24+MbjFMfqB3m592AM+x4sLFZZd5eioT/e6a+qZrJ3Jr6IMUgb?=
 =?us-ascii?Q?I8V+RB2RAxjXcMuRbxhrQUIExvKCanZE+NbKg7XfGDPX1rJD4rI2CWGaG7a2?=
 =?us-ascii?Q?V++nn7qA6tTiLfiaKp6vUTQfzd1Mq7CCj1q5kNugmqfmGpS6oMtw1YasLpK+?=
 =?us-ascii?Q?oGskethZSYoKcg38/ZCrjZqGhT0DOtgq6ctRJ6IsfRHK8sNJnWVdLcd8/3s/?=
 =?us-ascii?Q?PVDuhYUx7F9GzSPu5JJj1l4e9bH/EpLUSziwVDAdr1qE03cAEnPE0UhsdDdi?=
 =?us-ascii?Q?b5gJ02Tt6Dl0hfHOp8S1FpQ6Lm/KYysLk+SnV4Sc0a/h+eewLiTIjSHZQBAG?=
 =?us-ascii?Q?sRPCuHDeOEnLjzyPAxYJAl0tmQ3u628w17hxOgQHiR2vLjxz58LOV+gUIYrn?=
 =?us-ascii?Q?TROljMtMYLmxVtL0CAQNf3LMdcZVBie4JpeUDvglPzs8iQD1OnQ9UyuzbpN+?=
 =?us-ascii?Q?1EHbVZrsahuQrMTpGYeQeTSdZu12tpN74R4N7xXy0EkSq5vSVLfw8ifuIx5B?=
 =?us-ascii?Q?QbFUvb66oPpxCBXGViB741Pyu2dcXoClUgqHvP8Ra2sSr4o1uI4Xn0bI31Hx?=
 =?us-ascii?Q?5c9A4THGB9DBc7WSkRx8Q2VGMlqb+NFIgnhVRD+kQw3OowuFt3LjmUjKg72a?=
 =?us-ascii?Q?ePfqDO4B3wJZAPTrn2ey9z0lwyfz3AXTfwGZYDepBs8dn0pcWLLZtTfX58x1?=
 =?us-ascii?Q?ifaqdmo2+CP6/TW0MWL4mZ0P0jBf9EBp98VweorNUzLdWd8QJsU9kTpYyMr/?=
 =?us-ascii?Q?prdfdMjydJGmVm+ceGKz7e6gj+MX+L3rexvARR3/jYJ6bfYpguh+Jm0lqGJm?=
 =?us-ascii?Q?DksOzFprElpp8IFhqh04OTgPLyEeDdqsOXeqhUK7MKE3x8h8zZ5rBrXDC6UD?=
 =?us-ascii?Q?7QauN/rjwhZ13CyqK2JcSRUvUVoapZoSkZtXSPKnjur6rORHZXIl9M3e8L/a?=
 =?us-ascii?Q?vYVIPMYCNARGZdGYfIuNWvDbsxc1GHzvv21JbkC0xTfhoonU1CIDy3l0vgno?=
 =?us-ascii?Q?3hhvbYOzPKStAnmimvOl1vv4oSnKWLioZyv6o4PjjRHuH26QPTVuigW8nbKx?=
 =?us-ascii?Q?Nma2RxH60yGCjUmzxkI+TLkOCl8GoSQsuHV/X28zRD7F2qgO94i0GAdrKPep?=
 =?us-ascii?Q?b92s8qzHcqQjdW3FONjNGBSedz/1wrt3WCIRvgGIttEiiNAMhCsCJANyZ9+D?=
 =?us-ascii?Q?QujaDMWX5rykSuaRjyKMfH4f/rStmDvGlg5XpgEd8zOTzWN7h1Akw1ek+0Dk?=
 =?us-ascii?Q?36Kx7RhVN8VTfeNAWU6+xXTYPtYP5KzXjDU/jyHxQbKjjvTy86PJFT2P9cAl?=
 =?us-ascii?Q?I1HM0SjNfx2mYSQo0zqwbr1Xb4PrQ1kmNB66KsL2qDgR9Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3WCUZt9JOFFz4VZpdZnyHz3MSnA7U2jnTwMaF7OMFlzYhZfcm91KJ1LYr+XI?=
 =?us-ascii?Q?jg3tKv8zlC6JuqR35byLHOqcW5KehGLN82pR8WEdkvKThij1QZKY1lycdWcf?=
 =?us-ascii?Q?LA29kGES+TOoTlEIsCE8Yvt+tkDF/0UO+QWjUxffp4Vi5xrT1h92G0Viftoa?=
 =?us-ascii?Q?reTMCjXu5xu3YrDl213x+0G6sZYVAil8rtKuFJb6cURjGvVapOoODowjZ+iz?=
 =?us-ascii?Q?BNh+apiU5AsYHBLgeO6cdd9Mcu5NzWkiNApF0289Q5Z0M/dQ1gD/COOTdCNU?=
 =?us-ascii?Q?nTnlPDBYQTe7DC2U/69BWyZa65IRJxryKzu1T7jPvGUU2sfYoM5f2QunwRTQ?=
 =?us-ascii?Q?zCBlKq/SVdAyXClfQZklFY5qymuqNLrt7nxP9FliAvarOmH+ZGupnd0I+skN?=
 =?us-ascii?Q?9F0V7HQWRTmIR7E9XuBE8SU0B2lZozQxFCqxj1u4CxV2OhglR/MhqCIqBmgJ?=
 =?us-ascii?Q?/hZwvuzn2Obw82CN75GXKo/Us9oGn4KnCWOwXjNFiwlzWTO7YRd48CG0O02z?=
 =?us-ascii?Q?Gt1nQgPVxBAUTBWG+co+Z5O4y1vF7AJ6fZyYILsyyUjg3Ne6fm9I6EbXvK4+?=
 =?us-ascii?Q?DR99DGgxliC3fbbM9FWGPXiaa13NwBPzlwsmR94/xc+k+iIgCbvhu/8fa2GQ?=
 =?us-ascii?Q?3G3lSV38gBcb67gZbvoL9tZYWsiOdiz8tPrYtprvrxCuL0Uv9oFIPka5n62L?=
 =?us-ascii?Q?+CPdMs7OYnZ6bCwiV5Y4gh8f0BdvEYSttHXl0W9R4b6oyxHr7VAe462DFf10?=
 =?us-ascii?Q?Si1Y3kMvjH/1LBQYbI/z6Hm7wv352lIGDC2QWBz1m3DTvS9/j/jVA1StX4Gk?=
 =?us-ascii?Q?CBaAWmj/nbXelNasYf6B1sU3Az6NlXY6mzjA6T1suzzNUgASBfU5AADpJ34N?=
 =?us-ascii?Q?afvyetX98R+7AIrBuGt0F6+pficZW2vdE+8PIYeb9AJACrbRy8jYzCbFANPO?=
 =?us-ascii?Q?cvuyGunVu7Ehmjaoy82P1M9NHo6bt7s95tGybFL38+PzuQcfb+G9FQ2pwaYz?=
 =?us-ascii?Q?B9JkFC15t4tyOaDiumEKCykG13GXHyh4Cwn5g1yEmOGNRTyDZmzZKf/CHuuF?=
 =?us-ascii?Q?0nbH3bSuI2Idpzm2d32kAO+C2YRzzZCovRwKf8/5BVuRlRMG7W2N2wXNCmQB?=
 =?us-ascii?Q?cJa3o0+/r0BSkwT7Fmq06eMTbZwlYxM6mFwYRe+olHZfY+Eele2ij+ebajDy?=
 =?us-ascii?Q?8lsX6xhwPgf/zf5U6wUCvZN5AbnwT08D4qw8xpQOilOZl9K53+Y/a/LIkY6K?=
 =?us-ascii?Q?njPi5Aw6zaVJ1yS2tVFuFpdOvwbCAe/bsTM3kbFWNXXRnJMlYQ0jN+FL90jQ?=
 =?us-ascii?Q?Hl6X/r58cEzPlRJ1TPw+E8K36Vvgw+72zzdhDFuX3e9V6H3SrS5tmVNzWdVO?=
 =?us-ascii?Q?qmmXVdw+tEwA1zzis9mRzqdb6vgYIeFXqDOCw0Lr8FeubYrZT+mWOR2UV0DV?=
 =?us-ascii?Q?LDqJs0VXS4LgRf/uEH8ys5JwCZbVefpFq7J9dclgATnME1TnIerW1NwtG2IX?=
 =?us-ascii?Q?k1SjQ107iZtuW0Db6TVZ9PcVbP3ivGPtS6qN5NTI7RwlTkNqKXnXG/sKy/O+?=
 =?us-ascii?Q?pa4h1fa1uCnk40ywkC8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51449DA6CAD97C4B58D03338F7162BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77a9d0f-a8ee-40af-bec1-08dc65f3e4cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 13:22:16.9502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ztm0chEKEKz94d5SqOIXEJF6rQHw+ZhVY8BVbyDFZUR5EM+MzrxAa5fpI6//f3EUsPKYAc4hbwWuIA9wZpd4og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
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

--_000_BL1PR12MB51449DA6CAD97C4B58D03338F7162BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Friday, April 26, 2024 3:18 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Khatri, =
Sunil <Sunil.Khatri@amd.com>
Subject: [PATCH] drm/amdgpu: add function descripion of new functions

Add function description of the new functions added
in amd_ip_funcs.

new functions added are:
a. dump_ip_state
b. print_ip_state

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index 7536c173a546..36ee9d3d6d9c 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -291,6 +291,8 @@ enum amd_dpm_forced_level;
  * @set_clockgating_state: enable/disable cg for the IP block
  * @set_powergating_state: enable/disable pg for the IP block
  * @get_clockgating_state: get current clockgating status
+ * @dump_ip_state: dump the IP state of the ASIC during a gpu hang
+ * @print_ip_state: print the IP state in devcoredump for each IP of the A=
SIC
  *
  * These hooks provide an interface for controlling the operational state
  * of IP blocks. After acquiring a list of IP blocks for the GPU in use,
--
2.34.1


--_000_BL1PR12MB51449DA6CAD97C4B58D03338F7162BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sunil Khatri &lt;suni=
l.khatri@amd.com&gt;<br>
<b>Sent:</b> Friday, April 26, 2024 3:18 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add function descripion of new function=
s</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add function description of the new functions adde=
d<br>
in amd_ip_funcs.<br>
<br>
new functions added are:<br>
a. dump_ip_state<br>
b. print_ip_state<br>
<br>
Signed-off-by: Sunil Khatri &lt;sunil.khatri@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/include/amd_shared.h | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h<br>
index 7536c173a546..36ee9d3d6d9c 100644<br>
--- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
+++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
@@ -291,6 +291,8 @@ enum amd_dpm_forced_level;<br>
&nbsp; * @set_clockgating_state: enable/disable cg for the IP block<br>
&nbsp; * @set_powergating_state: enable/disable pg for the IP block<br>
&nbsp; * @get_clockgating_state: get current clockgating status<br>
+ * @dump_ip_state: dump the IP state of the ASIC during a gpu hang<br>
+ * @print_ip_state: print the IP state in devcoredump for each IP of the A=
SIC<br>
&nbsp; *<br>
&nbsp; * These hooks provide an interface for controlling the operational s=
tate<br>
&nbsp; * of IP blocks. After acquiring a list of IP blocks for the GPU in u=
se,<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51449DA6CAD97C4B58D03338F7162BL1PR12MB5144namp_--
