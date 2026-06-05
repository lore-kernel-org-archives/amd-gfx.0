Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4DACD6E7B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 19:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C598810E49C;
	Fri,  5 Jun 2026 19:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EbB+4FAA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F019F10E49C
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 19:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdRcRSco6sL3cgn9BdnbAOz0LpNCHS14qErBr+VaqBX4aTFgsjXRoOuFa0BdUXGGVcs9tUSPcNBxuDRpKQ7D6ttXtscNnjrwTv3WfrJU9d2nMD1HZmLbnZ8Jnhu0+1T1dgCwwBvXK2v2/zu1NiFhz3Bu1zCxkoV33zGgfKw1KGgOShZ8KPp2AAc/4rGSfV116uXDqfMMbAD5WOqIahny7lX+MxGBUgvmROMeJta77GwY1c3pJ/LblbPelWPyXCEfeMHOIrHiYtimeWHCDHa/vDS4rRW/MU1F7TKKMxobRWtMSIXj1N4q4bnrZWEvOfoEOBJDxoGeJENhu7tDmt+vrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNoJVzCg7qu2qzpSSr9zGgmUyOnva7ez9Y53hH6aRy8=;
 b=Frw5Lxzgk35g1NCVulR0gQRX7ZaBJJMKjwuOlL9Y2iwCF+w+VvFCwcyKvAG2iMtH0NuCZeSthePUEZ/BTHM72L6Rbza95y4JsPMGQeMi+cR6YRjW/vv7ib9PkcX157vM/5TznTDhanSxkLmzoHhQs11OAzPbeA0IxGyltL6fe8eHI1qDnn1T/1b65dumG4PkgsGTpR/Sl9f7KoZB6/MRRLDmxASK2Zgw5iEroIPk0WlH3je5WQx87WpiAtiMBXbZ8Si/jnYiXhV6ahjx1OUWIofNNOPxXxKS3IHjSpUiLlVVrztz1LsBOEX900Xjb5R7Kcd/FB26fm4D3H24CdDjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNoJVzCg7qu2qzpSSr9zGgmUyOnva7ez9Y53hH6aRy8=;
 b=EbB+4FAA2CWXiP+UOXrMOLrG74TepNcc88dpId1/nR7cB9IfSsKXEjrbDOvoLKWEZjTj2zcfb78FXvi8l5yrxkN5ln6rVdNGa4jRA9KSF0GzX7GZu8rZaluNhpbVWjZMXeoNnD1Pj9qxY6K9NYd2nNd15xsa2HCgSH4i6IEy+cI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9ab) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 19:30:10 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 19:30:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Liu, Monk" <Monk.Liu@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: skip already suspended IP blocks in
 ip_suspend_phase2
Thread-Topic: [PATCH] drm/amdgpu: skip already suspended IP blocks in
 ip_suspend_phase2
Thread-Index: AQHc9PyWNlwvl2VkJUOlWdm8eNIIgrYwWV2N
Date: Fri, 5 Jun 2026 19:30:10 +0000
Message-ID: <BL1PR12MB51444D711DD3B2ED71915A8DF7112@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260605150202.2453971-1-Yunxiang.Li@amd.com>
In-Reply-To: <20260605150202.2453971-1-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T19:30:09.910Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ5PPFFA661D690:EE_
x-ms-office365-filtering-correlation-id: 933b1808-e3c2-465c-e5d0-08dec338dbbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|8096899003|18002099003|22082099003|38070700021|6133799003|56012099006;
x-microsoft-antispam-message-info: RaE/WI79Yu/nMRjf3p1uEzetzvfJpge+CTtXDrUn8olvDsggv2AZJdMy3jIhrRuMLGoB5A0vxxRCS0lCqZyDcsGEXejIm4OLSmCvb+My77ozbw/kUAKF/5HnrdaRo0ALjA3FQF+pyI0mKiyONEodetwMxkSJAaF73HypWF3Xzfkvi89SBSXRA7ZFib7j7owycwGqbWJiDKK45EggamK1rIfOOL/gz3EhffSOwqLFdrqRrVgxy6DFiNXiIryuK5oRUcmUPAnR49Eg6ac+xWg7qNRvqMUXw7Rawmzo3ZpCgH0eyDn4vnn6GxIH541gLnbV7jJ7mLoPJaGm1Pzt83MbeZG7S89Jc2bI6gZlYSmYDFi4iGFJB1AIzyV9kY8VrhNwkKn3rnV1ep7ScygqTCRM8yk1fHOiDTJQacqNqXDYqcbKsgytTWbBu0wVbj5g+zS7i6PykQ1x8P7bWI5adChDQ64yfxpnP3f9vPdW1IlqIx8/amSskiD6J5mdbrQNj10LZ0fbcRZFvoIeT92CtKq8Yo9TmSMwDsTixHQ4iTb698UDaDmypDrDBH04rl9yB+o4VGNfIoFFEteIyFAa7tMX2b2ppRPrfJO+Z/FhkhUBxIo3m7KJcrlkY5KKsQ+qwAbtIP+/YrF24Osn5+LkfHvUtN10WBp35lPco24PAKzATSZqG8qD+I3IrxSt9Hg4sCYc4QIIx/u0+h9AbU7wqpjEO5LA2Vm807K8rdXRYUF02TE/yLpEBDnBF1Qug22g1XXS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(8096899003)(18002099003)(22082099003)(38070700021)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z0dmtEWtH5c+EhkBN9bosxut+/XXNlc6JuV4Lw0Xp4HYA6dfpn4iCDvA4s5x?=
 =?us-ascii?Q?zGQgiIJwIxb2Vrt/ZV5S/gzuBVlJCR4HoJYiwTSjLcS8cFG+ZCBNtaBLT+mV?=
 =?us-ascii?Q?aYNYD3EeZOf6LHoVYvpgwu4TpZ4w7JbMjCCL1zCrCJC1D2sRktIBsf5/gRSw?=
 =?us-ascii?Q?/R0UfRdM+QRk9gh42xbFk5GbBz7KbyH34DPmt5E1WHS/s+zzuqSJnfYG+id8?=
 =?us-ascii?Q?+p5JtygNS0IrZ8PvWp+6iYEd1W0kly7KoQaKiXV4T0MSDYQVJC+IqOF9NtT9?=
 =?us-ascii?Q?5zHSa3xdjVwQtVLwCgjS+cojsx8+f7F9ky7hZgYNjI7Xcjomq1w8vPnfuqgj?=
 =?us-ascii?Q?HyT+tIjO8dQcilIf3FJy3HETOzpjygTD5ZrlCkpI26nvzLY1SQTyVC89We3L?=
 =?us-ascii?Q?rnVy4e6c7CUu7Xozpaf+Ucl41x3C4sq00kncJDP7rAWpCxlUnlOgT/hxgxmC?=
 =?us-ascii?Q?mk0PdGMJ8b3CRJnoQw7dJakrEobtKPXIPk3TdbO9fmVe7LcpABmrvnbtkAlF?=
 =?us-ascii?Q?k8TZmxdsi5GK/8y0uXlNXjgKvdGAk2/WS6eFy1wMYxaToUw1bQ1xeOaa00di?=
 =?us-ascii?Q?q5vBguQQzhrd8IW/z+TVBeGnaiZGde0PGtIbxBwlsc6kuHq5+vfUgvj9O46u?=
 =?us-ascii?Q?SZ4LnTq+z1ynoNEeTb7t1JmmwvjpZKXi/yIqTuyKTa9gJHpjcIsDKmIo57RS?=
 =?us-ascii?Q?jk3an6O1b8yqw3kK7+QDlhEySXbhxr+RmA+Wss3CtN0hN5Q2UNsyoK9viWyr?=
 =?us-ascii?Q?4Svl10aLIwKW6pbV1ZG3/R+lHkkigCNNpqePyJTevarpeKsMiVBq24N6m2kI?=
 =?us-ascii?Q?dueKICmYVhyRjVsnlC3x6dinjUwsUWHmpDoWMOWauI+MR6GcW8OQBXpyqXq/?=
 =?us-ascii?Q?o0TYVSv1+5BDCSoIAu2F2AaPLXVnHjwZizeoPQfUx83tclNxeQd+2q76HvsE?=
 =?us-ascii?Q?7WhVfrFc9DHRMF4lyMa6FSmVWNgWvNlfXtC9iB0Smsl/ucSxdVhkhIbKWipQ?=
 =?us-ascii?Q?+Lju9v/vUHi1sVchRnPKmxcYgFnO0H+YmV4M/+PeJqzeH7ec7waxXubZRJj5?=
 =?us-ascii?Q?GpGzfQHdtZ36JmV1bwUQkeWl38vjRK97Z7cSPMM0FNm6hvDuz30gGDoenrv5?=
 =?us-ascii?Q?CGxPSk529CTeCls0ZEcJIwFbpDbm6bMMrK2HezOdZtn4zv28ne/gT9jRj7r6?=
 =?us-ascii?Q?NlMkm2/A+kkxIIfx7b90SDMjjRAQY4+w5yrjCn45F70Fb6zDA5RRqONz5bsJ?=
 =?us-ascii?Q?NywkgtANFW+QiSC+g2kPSpDBrWVeL40rGtN61P3UFIjU2fSyA5kRTBIekda0?=
 =?us-ascii?Q?EfBssHh7QTwbXll3j+c4o2W1xzWBoXe2CFDN9WzORZlmqyJshuf282Xie6Sk?=
 =?us-ascii?Q?WiOBJvBr6kBtw7sIjUS8L7xsA4EmDj3BYHPKY5Pmfvsofye9mDJ9nYNTnnqD?=
 =?us-ascii?Q?ds0CP4wq6VPI/T7qG9ngmoNC+0X+/wWrJbSo51mGarUv011CcMSn87YzdFTp?=
 =?us-ascii?Q?8SH4K9Dz6STm4bvek3t1UNquKS7mZN9LNkm3wmUpAm/t+csNU8YuSlv0FoEe?=
 =?us-ascii?Q?Xfr0CtU4q13OSk5tv3gxP05NiZlA+vrgDkMTGgQG54Kcwbd96MYh/lkncSFx?=
 =?us-ascii?Q?RYqtGfsRAs7DWfj1bC8YCy9rXlxcZxIfpHiNdQ4gLWzxwz6MJpLAdBovUtdk?=
 =?us-ascii?Q?cv58Q+pddM8kUu7PDuFfQ7o+xqfuUwfAfovyWiSUmagpTnKm?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51444D711DD3B2ED71915A8DF7112BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933b1808-e3c2-465c-e5d0-08dec338dbbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 19:30:10.4502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qw2/HaJpIlpisJyFQV6n6hpwK1MkG2EKeRTgznWksf3x9V5hZEktSTJg6BwVGPQV310Xd+xVfv+bcycOMY3FZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690
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

--_000_BL1PR12MB51444D711DD3B2ED71915A8DF7112BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yunxiang=
 Li <Yunxiang.Li@amd.com>
Sent: Friday, June 5, 2026 11:02 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: Liu, Monk <Monk.Liu@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Zhang, =
Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lis=
ts.freedesktop.org>; Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>
Subject: [PATCH] drm/amdgpu: skip already suspended IP blocks in ip_suspend=
_phase2

The GPU reload test (S3 / mode1 reset / module reload) triggers a
WARN_ON in amdgpu_irq_put() on gfx10 when unloading amdgpu:

  WARNING: CPU: 0 PID: 2314 at amd/amdgpu/amdgpu_irq.c:676 amdgpu_irq_put+0=
xc3/0xe0 [amdgpu]
  Call Trace:
   gfx_v10_0_hw_fini+0x41/0x150 [amdgpu]
   amdgpu_ip_block_hw_fini+0x29/0xc0 [amdgpu]
   amdgpu_device_fini_hw+0x315/0x610 [amdgpu]
   amdgpu_driver_unload_kms+0x7c/0x90 [amdgpu]
   amdgpu_pci_remove+0x51/0x90 [amdgpu]

amdgpu_device_ip_resume_phase2() skips IP blocks whose status.hw is
already set, but amdgpu_device_ip_suspend_phase2() never had the
matching guard, so a block can be suspended twice (e.g. a reset or
recovery issued while the device is already suspended).  The second
suspend runs hw_fini again, which now releases the gfx fault IRQs
unconditionally, dropping a refcount that is already zero and tripping
the WARN_ON in amdgpu_irq_put().

The fault/EOP IRQ get/put were balanced through late_init/hw_fini
before, which masked the double-suspend; moving the get into hw_init
made the suspend/resume asymmetry visible as an IRQ refcount underflow.

Honor status.hw in ip_suspend_phase2() so suspend mirrors resume and a
block is only torn down once.

Fixes: 3402365f4ca8 ("drm/amdgpu/gfx: move fault and EOP IRQ get/put to hw_=
init/hw_fini")
Fixes: 482f0e538580 ("drm/amdgpu: fix double ucode load by PSP(v3)")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 6608780ffef2f..dc8c650fc3416 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3044,7 +3044,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amd=
gpu_device *adev)
                 amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D3Entry)=
;

         for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
-               if (!adev->ip_blocks[i].status.valid)
+               if (!adev->ip_blocks[i].status.valid || !adev->ip_blocks[i]=
.status.hw)
                         continue;
                 /* displays are handled in phase1 */
                 if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_T=
YPE_DCE)
--
2.51.2


--_000_BL1PR12MB51444D711DD3B2ED71915A8DF7112BL1PR12MB5144namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yunxiang Li &lt;Yunxiang.Li@a=
md.com&gt;<br>
<b>Sent:</b> Friday, June 5, 2026 11:02 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Liu, Monk &lt;Monk.Liu@amd.com&gt;; Deng, Emily &lt;Emily.Deng@a=
md.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Li, Yunxiang (Teddy) &l=
t;Yunxiang.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: skip already suspended IP blocks in ip_=
suspend_phase2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The GPU reload test (S3 / mode1 reset / module rel=
oad) triggers a<br>
WARN_ON in amdgpu_irq_put() on gfx10 when unloading amdgpu:<br>
<br>
&nbsp; WARNING: CPU: 0 PID: 2314 at amd/amdgpu/amdgpu_irq.c:676 amdgpu_irq_=
put+0xc3/0xe0 [amdgpu]<br>
&nbsp; Call Trace:<br>
&nbsp;&nbsp; gfx_v10_0_hw_fini+0x41/0x150 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_ip_block_hw_fini+0x29/0xc0 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_device_fini_hw+0x315/0x610 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_driver_unload_kms+0x7c/0x90 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_pci_remove+0x51/0x90 [amdgpu]<br>
<br>
amdgpu_device_ip_resume_phase2() skips IP blocks whose status.hw is<br>
already set, but amdgpu_device_ip_suspend_phase2() never had the<br>
matching guard, so a block can be suspended twice (e.g. a reset or<br>
recovery issued while the device is already suspended).&nbsp; The second<br=
>
suspend runs hw_fini again, which now releases the gfx fault IRQs<br>
unconditionally, dropping a refcount that is already zero and tripping<br>
the WARN_ON in amdgpu_irq_put().<br>
<br>
The fault/EOP IRQ get/put were balanced through late_init/hw_fini<br>
before, which masked the double-suspend; moving the get into hw_init<br>
made the suspend/resume asymmetry visible as an IRQ refcount underflow.<br>
<br>
Honor status.hw in ip_suspend_phase2() so suspend mirrors resume and a<br>
block is only torn down once.<br>
<br>
Fixes: 3402365f4ca8 (&quot;drm/amdgpu/gfx: move fault and EOP IRQ get/put t=
o hw_init/hw_fini&quot;)<br>
Fixes: 482f0e538580 (&quot;drm/amdgpu: fix double ucode load by PSP(v3)&quo=
t;)<br>
Signed-off-by: Yunxiang Li &lt;Yunxiang.Li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 6608780ffef2f..dc8c650fc3416 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3044,7 +3044,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D3E=
ntry);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D adev-&gt;num_ip=
_blocks - 1; i &gt;=3D 0; i--) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.valid)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.valid || !adev-&gt;ip_blocks[i=
].status.hw)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* displays are handled in phase1 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD=
_IP_BLOCK_TYPE_DCE)<br>
-- <br>
2.51.2<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL1PR12MB51444D711DD3B2ED71915A8DF7112BL1PR12MB5144namp_--
