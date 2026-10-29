Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E2606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ksqC2W7i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B37CA11231B;
	Thu, 29 Oct 2026 13:56:02 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D9111231B
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 13:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zt9k2Q3spRvFJ2bWWa9qGogZdy/7R2OpaqYE/51CNGiTbe1jgogZUHdGS6kMQQ8v7KqRDwwskiHjIYS8/NPm4BuA0LAZWUGrbdtGBSuatPXXsHvLAQfJGECFpDylbiQRl3Afr7V2luw48QI68Tqpv3HlNUTa2h0DHLHbU//wDzpmtd1ChzZKmMbKbO//e9CLnwY9G9K/8bZwaanlQwgVSEeseA6PYwL55buYzF8Cjr7BOu/r4ap6aVuvuFgneleiPHQPBjOgqNYc6Ia03rutamsPkiFUni34OgnaGQLVhasVhC59Jygs0LWSKES+g6HDzrv/U41DBPRJmuXMEkRN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXw+RscYQuiLj2WhkXUwm8bROWgnmNXV/XdefJetIdQ=;
 b=yhRwNmf5bJ8nxilxD+1VVecDXw65lSrnz5q+0/90NHmU/bI0ixeyJTZtJyqGWohTn/GnKsjVeISi4m43foHQ+NSANtYLaf4F4pvtsBUKuMuazP+YWZO4HgxhdfHSm3QvIRxz8Ge566x6JH59+do8pNWISsRHnWjUxU5d/yJ2i8Xi1WMbKDa/aoT5lJPSYF0LfFj3X5X1ZE4Oq+GRy3fdaAvaKM2e9KALQSlI1rG9BPGxVd2IHR4MB3orST0g9VUQH9J+OKL0K8V1wY5qgscg8c7y8kV00DyYqL1mV2varyPfh63bA1PLuP9fxrZpflfWpHa5eQyy7repSikZN5sAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXw+RscYQuiLj2WhkXUwm8bROWgnmNXV/XdefJetIdQ=;
 b=ksqC2W7i67oRMorFflEtr/oNV0yRE3Zo2zH1gaHzZ5NiktzreVfFPAa7t9J0EC5QRZzEwnN59gX5vo3RRrhs7/dguy9BU+pqRoYlVImC3X6GaY4acAIv16Sa4zRZpgw/0tySutztG/SRTWDziZPOkfQKxgR1a2arwUtLzQwKJgU=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by LV8PR12MB9272.namprd12.prod.outlook.com (2603:10b6:408:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 13:55:50 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 13:55:49 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM aperture
 is missing
Thread-Topic: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM aperture
 is missing
Thread-Index: AQHdYjp4pZ1K7bpyAk2miL1IPo526LcT+8MAgACS0eI=
Date: Thu, 29 Oct 2026 13:55:49 +0000
Message-ID: <SJ1PR12MB612197EEC1C26B3661FE750B806E2@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261022153132.211631-2-Chenglei.Xie@amd.com>
 <70f8340a-267e-4bba-9611-07406c552cb7@amd.com>
In-Reply-To: <70f8340a-267e-4bba-9611-07406c552cb7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-29T13:55:49.242Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|LV8PR12MB9272:EE_
x-ms-office365-filtering-correlation-id: 676863db-6683-4b71-9d25-08df35c456f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|4143699003|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|10067099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|22082099003|18002099003|6133799003|8096899003;
x-microsoft-antispam-message-info: VlspEMxXiRuU1gj1NaQ5FjardcG5wtwtdnyv8S8mgxA2KuVd0xDQDimC2m7gxxyly3lbP/EEFZeRGT7RWRuN2xq+a9pJfvQAHq2u1Qx8DNtypcDBnrVfVwHCU5ZyboSdInWLIFXE97JTMDoeO7wXQox3Qwu6WN3bmU0pWrPuyo8DDMK5R6kObsEVRHotREX1IUaZK31ehcpA9okvZQuQp+3X6FmHZ8LnIxdPE36PHSngJFvZ2dLrRoYDBr4k3PYewff+HGtOzwnt1L3Umot04AP6ijbh5lpCL69JP5/3A5WgfFOH3kWZvHlpGpWH+XljSn+gCXLhim54uSa5nhgxOGAgBZzOsnhq3D17EcniNBzs1o9tKchOLcbYocPnUV9pYn3uyzBpVvXTJGQ+1iaE7fB/MIe6FTLAsLKUeiEAB1JULtMnIrn9kqRWPqi5ns3VmG7H08Acf/eY4NL1Jh/Xvt4X6hUJUYDZ+rGc2HpPG0nqLUIEd1hJdPCFV/SW8Vj596NKD9THpHdRa3hw3pTWIUFnoSs86SHqn15Mt0Ykh8DuEbDQA7BjywmMAuCbGE34h5b7q13gTxaZ9FO90Vj3ZC8nvKMmsOoyVv8wGxZIVlktMBnH2SX+RA9kooZg7P1X/8f0a5nc9UFq2FFc15d0jekXTZUvCMuYbvoMoBSGHWCAl7YUhAhlHMD2CG09K7SgZ3lQyvsnn5+O5JhGLewpBTDqjolvM98c+g1aOh84DsU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ykOJTA29cMewvg7NTVXI+/N5coRd7U5aR3eHM7vjGl6wmwQ2Zg7hbk9vddGI?=
 =?us-ascii?Q?zWO+vKXiXF76vixd7+bS5Dqa4UvXTjc1Wm/ECIb18inx5IosKccIm1EdZOeZ?=
 =?us-ascii?Q?ItDvhw/+LYo34qwbm+B39aLQZK7sx6jY3wQKIbAfwadirlIVkhQklV2sm+/q?=
 =?us-ascii?Q?mzrH6IPhOP7EEfuDLmlrLQiiVLR1XOIcZ18+dxK8RwziUBRgpd1O1R6WFg1f?=
 =?us-ascii?Q?bUWMOj73PezQUYsHCjeXw9fAFzcZ0pkNEvmMQV5HoRtYydIl9gOSNHvVpi64?=
 =?us-ascii?Q?BnQK3VCvpI2ti/kN62oQVwFBGMhG8sYfnG4pJOXZLBizj1CKixk07i9FXYhx?=
 =?us-ascii?Q?MJXBfgX0TYMGjGbms7ryd3eCzDW9jS6fjbZ64gfAnOMc7bpmi8ZCb8x+yMhc?=
 =?us-ascii?Q?FQho0dQfDt3dtP3YMk90+39r1+fcVPhnjBzEJm8J+d6mLnxCO3kFdLHbK4FM?=
 =?us-ascii?Q?Ktod3bh6D4MOcyxdEegI29AB2vLugM9IuaEIbIY4tNaS4atuMFIeWtWd+vhH?=
 =?us-ascii?Q?rcPam0bACPomL+DZ9T4BMbm65YOLu62bRG5YVPCb5BRXtrmsf/AacK4x4yUD?=
 =?us-ascii?Q?t61aS28bGnrf5deY4hNsamXbhqbWxZ/J9ZtRynkgburWa8QSJMM6lb+R4KCH?=
 =?us-ascii?Q?ogiFQZodayYhw7sUuv819wgToEgCmfQJtwx2dEAWGQ7xOKyeofGbfq3gLFRj?=
 =?us-ascii?Q?GcGbmWdaFqdvEASXwfCs92EuW5eMzmS760fYwxC6PLDcc+UcSHjXMA/aoXQQ?=
 =?us-ascii?Q?6wJwbChj1WTHuWYsw6FH/ZBjewSkP7XID1084C5lUD1byQXELrycTjYi7D7X?=
 =?us-ascii?Q?ayKBRo726fMjVTFOHl5udnRm+79tXpGd9xblDUgtWJ6+hbjqEj++6NZH5aU/?=
 =?us-ascii?Q?2o3PGku2snFlHjIVISw9TRFqGNKxJ+1Zz5tU34ZjlyUZwDHukc9INWUKWeiI?=
 =?us-ascii?Q?z2khqwZf3podD0rrJ181ApW8tfejYD1nrRZlEXgKvhMFWalfXfqkq9CHXAya?=
 =?us-ascii?Q?JGn6x299RBamdR97zyEtDfLZdCiE55osAjJBie0F13bAXXIY0v41lwfdOPc8?=
 =?us-ascii?Q?UetT/NhnmVMzEZfb8gRhBXlP7SR+tvrNZvvHlP42x8bIdmSHW4sroAe2mJHU?=
 =?us-ascii?Q?wl8T8XeoCGVe00hshlBQN/j1BYdfgXAwxQAE4t3mFvXkV5ZPKzrWzz31tvNo?=
 =?us-ascii?Q?nVWxAypwNd8HnHSuEmKvTEHqbJJ/3ahv89PxHojV4absXXBxh8o6Uyi+xRts?=
 =?us-ascii?Q?eyFVjPTKgK5HrmyurTUe33pJdswtS8WEyYbEJgbduCUFBVBJxY9LrQvq/GpH?=
 =?us-ascii?Q?+CJFcv/pTDU3ESpTjvh10UAxkMr4RsjMMp2SUvD0CeDYvd5JuQtxpPcxrOik?=
 =?us-ascii?Q?VLv674+wM7k84tQkSPasWGka0Xx2uyxr462x/cLacQILtNF/FHD2geTzqVBS?=
 =?us-ascii?Q?Kaw5RHHoUbYqHpFaMk06tI2EpC222O0T9b/TOds1tvjtXgeqA8bC15mv9Tsc?=
 =?us-ascii?Q?vFtoYM4wgsIvqKHLGfmmer4qr7CsU/PADUF239ShJrTC67az7Q0366FAufJp?=
 =?us-ascii?Q?3jxExfw/ezcngiBv64LwaXhi2A6ZsSU2ocLMawqJ1Z/pTjA47G1JYN1hq5Jk?=
 =?us-ascii?Q?NGglsC3xF3VgSNn0XtB0SWpQgMdrOcoRVf63OdZID+cOq69iRxI7QcAw7MFz?=
 =?us-ascii?Q?V4KMIkEJwMhJ2joP1aqDCfIxyn0EEq5sqgE/8NOGfKmIvkJw?=
Content-Type: multipart/alternative;
 boundary="_000_SJ1PR12MB612197EEC1C26B3661FE750B806E2SJ1PR12MB6121namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676863db-6683-4b71-9d25-08df35c456f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 13:55:49.7720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPMFphm+Cz6/MiyIAHm/g6WhaxTODC3bN5nuFdtI5qOoBNC1xiY+Z/sBNK3cFN4CcKs2KcSyRAtkJ8LMY5AWeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9272
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_SJ1PR12MB612197EEC1C26B3661FE750B806E2SJ1PR12MB6121namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Thanks Lijo, please review if my reply on the comments make sense.

Regards,
Chenglei

On 22-Oct-26 9:01 PM, Chenglei Xie wrote:
An SPM-backed SR-IOV VF has no usable FB BAR, so gmc_v12_0_early_init()
resolves the VF HBM aperture from the SRAT. When that lookup fails the
code returned -ENOENT, which the early init loop treats as the GMC block
being absent. The probe then keeps going without a memory controller and
only dies much later with -ENOMEM, far from the real cause.

Return -ENODEV instead so the early init loop aborts this GPU probe at the
point it actually failed. Other GPUs probe independently and are not
affected.

Aborting here also exposes a second problem. On a legacy host the VF takes
exclusive GPU access at the start of early init, and every error path
returned directly without giving it back. The host then waited for a
release that never came, timed out, and recovered the VF with an FLR.
Route the post-acquisition failures through a common err_release_full_gpu
label that releases full GPU access before returning.

early init also fails before the CP scheduler is programmed, so the host
treats the VF as not active once it sees the release. Clear
AMDGPU_SRIOV_CAPS_RUNTIME and drop adev->virt.ops at the same label so the
later fini path does not send a REQ_GPU_FINI that the host will never
answer.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++------
drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 11 ++++-
2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5069042b5279..10002b78c69d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)
r =3D amdgpu_virt_init_critical_region(adev);
if (r)
- return r;
+ goto err_release_full_gpu;
}
switch (adev->asic_type) {
@@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)
adev->family =3D AMDGPU_FAMILY_SI;
r =3D si_set_ip_blocks(adev);
if (r)
- return r;
+ goto err_release_full_gpu;
break;
#endif
#ifdef CONFIG_DRM_AMDGPU_CIK
@@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)
r =3D cik_set_ip_blocks(adev);
if (r)
- return r;
+ goto err_release_full_gpu;
break;
#endif
case CHIP_TOPAZ:
@@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device adev)
r =3D vi_set_ip_blocks(adev);
if (r)
- return r;
+ goto err_release_full_gpu;
break;
default:
r =3D amdgpu_discovery_set_ip_blocks(adev);
if (r) {
adev->num_ip_blocks =3D 0;
- return r;
+ goto err_release_full_gpu;
}
break;
}
@@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)
if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) &&
!amdgpu_device_get_rev_id(adev)) {
dev_err(adev->dev, "Unsupported A0 hardware
");
- return -ENODEV; /* device unsupported - no device error /
+ r =3D -ENODEV; /* device unsupported - no device error /
+ goto err_release_full_gpu;
}
if (amdgpu_has_atpx() &&
@@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)
if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TYPE_COMMON) {
r =3D amdgpu_device_parse_gpu_info_fw(adev);
if (r)
- return r;
+ goto err_release_full_gpu;
bios_flags =3D amdgpu_device_get_vbios_flags(adev);
skip_bios =3D !!(bios_flags & AMDGPU_VBIOS_SKIP);
@@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu=
_device adev)
if (!skip_bios) {
bool optional =3D
!!(bios_flags & AMDGPU_VBIOS_OPTIONAL);
- if (!amdgpu_get_bios(adev) && !optional)
- return -EINVAL;
+ if (!amdgpu_get_bios(adev) && !optional) {
+ r =3D -EINVAL;
+ goto err_release_full_gpu;
+ }
if (optional && !adev->bios)
dev_info(
@@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)
adev,
AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
0, 0);
- return r;
+ goto err_release_full_gpu;
}
}
}
@@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device adev)
}
}
- if (!total)
- return -ENODEV;
+ if (!total) {
+ r =3D -ENODEV;
+ goto err_release_full_gpu;
+ }
/* Request full GPU access only for the remaining SR-IOV init work. /
if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
r =3D amdgpu_virt_request_full_gpu(adev, true);
if (r)
- return r;
+ goto err_release_full_gpu;
}
if (adev->gmc.xgmi.supported)
@@ -2184,6 +2189,22 @@ static int amdgpu_device_ip_early_init(struct amdgpu=
_device adev)
amdgpu_smu_early_init(adev);
return 0;
+
+err_release_full_gpu:
+ /*
+ * Release the exclusive access acquired above so the host completes the
+ * handshake instead of timing out and FLR'ing the VF.
+ /
+ if (amdgpu_sriov_vf(adev) && early_full_gpu_access)
+ amdgpu_virt_release_full_gpu(adev, true);
+
+ /* Don't send request since VF is inactive. /
+ if (amdgpu_sriov_vf(adev)) {
+ adev->virt.caps &=3D ~AMDGPU_SRIOV_CAPS_RUNTIME;
+ adev->virt.ops =3D NULL;
+ }
I think this is not the right place for this. These flags are not set
inside this function.

Chenglei:
Agree. I'll move the release + deactivate into a helper in amdgpu_virt.c an=
d just call that helper instead.
As this is needed to avoid REQ_GPU_FINI timeout post release.
+
+ return r;
}
static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index cd276a138e10..5c6a20e42000 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -667,8 +667,15 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block=
 ip_block)
r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
&aper_size);
- if (r)
- return r;
+ if (r) {
+ /*
+ * An SPM VF has no FB BAR0; without the HBM aperture
+ * from the SRAT this GPU cannot init, so fail its probe.
+ /
+ dev_err(adev->dev,
+ "SPM VF: no HBM aperture in SRAT (%d)
", r);
+ return -ENODEV;
+ }
amdgpu_acpi_find_gpu_memory_in_srat has error logging. The error code
returned is -ENOENT when table is not found. So this change is not requred.
Thanks,
Lijo

Chenglei:
I will drop the redundant error log. But I would like to keep the -ENOENT t=
o -ENODEV change.
The early_init loop treats -ENOENT as the IP block being absent and sets st=
atus.valid to false,
so the -ENOENT makes the init continue without GMC and only fail later with=
 -ENOMEM.
-ENODEV sets total to false, so it aborts at the real failure point. Let me=
 know if you would still prefer
to drop this part.
adev->gmc.aper_base =3D aper_base;
adev->gmc.aper_size =3D aper_size;

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, October 29, 2026 12:43 AM
To: Xie, Chenglei <Chenglei.Xie@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM apertur=
e is missing



On 22-Oct-26 9:01 PM, Chenglei Xie wrote:
> An SPM-backed SR-IOV VF has no usable FB BAR, so gmc_v12_0_early_init()
> resolves the VF HBM aperture from the SRAT. When that lookup fails the
> code returned -ENOENT, which the early init loop treats as the GMC block
> being absent. The probe then keeps going without a memory controller and
> only dies much later with -ENOMEM, far from the real cause.
>
> Return -ENODEV instead so the early init loop aborts this GPU probe at th=
e
> point it actually failed. Other GPUs probe independently and are not
> affected.
>
> Aborting here also exposes a second problem. On a legacy host the VF take=
s
> exclusive GPU access at the start of early init, and every error path
> returned directly without giving it back. The host then waited for a
> release that never came, timed out, and recovered the VF with an FLR.
> Route the post-acquisition failures through a common err_release_full_gpu
> label that releases full GPU access before returning.
>
> early init also fails before the CP scheduler is programmed, so the host
> treats the VF as not active once it sees the release. Clear
> AMDGPU_SRIOV_CAPS_RUNTIME and drop adev->virt.ops at the same label so th=
e
> later fini path does not send a REQ_GPU_FINI that the host will never
> answer.
>
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 11 ++++-
>   2 files changed, 43 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5069042b5279..10002b78c69d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>
>                r =3D amdgpu_virt_init_critical_region(adev);
>                if (r)
> -                     return r;
> +                     goto err_release_full_gpu;
>        }
>
>        switch (adev->asic_type) {
> @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>                adev->family =3D AMDGPU_FAMILY_SI;
>                r =3D si_set_ip_blocks(adev);
>                if (r)
> -                     return r;
> +                     goto err_release_full_gpu;
>                break;
>   #endif
>   #ifdef CONFIG_DRM_AMDGPU_CIK
> @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>
>                r =3D cik_set_ip_blocks(adev);
>                if (r)
> -                     return r;
> +                     goto err_release_full_gpu;
>                break;
>   #endif
>        case CHIP_TOPAZ:
> @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>
>                r =3D vi_set_ip_blocks(adev);
>                if (r)
> -                     return r;
> +                     goto err_release_full_gpu;
>                break;
>        default:
>                r =3D amdgpu_discovery_set_ip_blocks(adev);
>                if (r) {
>                        adev->num_ip_blocks =3D 0;
> -                     return r;
> +                     goto err_release_full_gpu;
>                }
>                break;
>        }
> @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>        if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
 &&
>            !amdgpu_device_get_rev_id(adev)) {
>                dev_err(adev->dev, "Unsupported A0 hardware\n");
> -             return -ENODEV; /* device unsupported - no device error */
> +             r =3D -ENODEV;    /* device unsupported - no device error *=
/
> +             goto err_release_full_gpu;
>        }
>
>        if (amdgpu_has_atpx() &&
> @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>                if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_T=
YPE_COMMON) {
>                        r =3D amdgpu_device_parse_gpu_info_fw(adev);
>                        if (r)
> -                             return r;
> +                             goto err_release_full_gpu;
>
>                        bios_flags =3D amdgpu_device_get_vbios_flags(adev)=
;
>                        skip_bios =3D !!(bios_flags & AMDGPU_VBIOS_SKIP);
> @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>                        if (!skip_bios) {
>                                bool optional =3D
>                                        !!(bios_flags & AMDGPU_VBIOS_OPTIO=
NAL);
> -                             if (!amdgpu_get_bios(adev) && !optional)
> -                                     return -EINVAL;
> +                             if (!amdgpu_get_bios(adev) && !optional) {
> +                                     r =3D -EINVAL;
> +                                     goto err_release_full_gpu;
> +                             }
>
>                                if (optional && !adev->bios)
>                                        dev_info(
> @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>                                                        adev,
>                                                        AMDGIM_ERROR_VF_AT=
OMBIOS_INIT_FAIL,
>                                                        0, 0);
> -                                             return r;
> +                                             goto err_release_full_gpu;
>                                        }
>                                }
>                        }
> @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>
>                }
>        }
> -     if (!total)
> -             return -ENODEV;
> +     if (!total) {
> +             r =3D -ENODEV;
> +             goto err_release_full_gpu;
> +     }
>
>        /* Request full GPU access only for the remaining SR-IOV init work=
. */
>        if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>                r =3D amdgpu_virt_request_full_gpu(adev, true);
>                if (r)
> -                     return r;
> +                     goto err_release_full_gpu;
>        }
>
>        if (adev->gmc.xgmi.supported)
> @@ -2184,6 +2189,22 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>        amdgpu_smu_early_init(adev);
>
>        return 0;
> +
> +err_release_full_gpu:
> +     /*
> +      * Release the exclusive access acquired above so the host complete=
s the
> +      * handshake instead of timing out and FLR'ing the VF.
> +      */
> +     if (amdgpu_sriov_vf(adev) && early_full_gpu_access)
> +             amdgpu_virt_release_full_gpu(adev, true);
> +
> +     /* Don't send request since VF is inactive. */
> +     if (amdgpu_sriov_vf(adev)) {
> +             adev->virt.caps &=3D ~AMDGPU_SRIOV_CAPS_RUNTIME;
> +             adev->virt.ops =3D NULL;
> +     }

I think this is not the right place for this. These flags are not set
inside this function.

> +
> +     return r;
>   }
>
>   static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index cd276a138e10..5c6a20e42000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -667,8 +667,15 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_blo=
ck *ip_block)
>
>                r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base=
,
>                                                        &aper_size);
> -             if (r)
> -                     return r;
> +             if (r) {
> +                     /*
> +                      * An SPM VF has no FB BAR0; without the HBM apertu=
re
> +                      * from the SRAT this GPU cannot init, so fail its =
probe.
> +                      */
> +                     dev_err(adev->dev,
> +                             "SPM VF: no HBM aperture in SRAT (%d)\n", r=
);
> +                     return -ENODEV;
> +             }

amdgpu_acpi_find_gpu_memory_in_srat has error logging. The error code
returned is -ENOENT when table is not found. So this change is not requred.

Thanks,
Lijo

>
>                adev->gmc.aper_base =3D aper_base;
>                adev->gmc.aper_size =3D aper_size;


--_000_SJ1PR12MB612197EEC1C26B3661FE750B806E2SJ1PR12MB6121namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks Lijo, please review if my reply on the comments make sense.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Chenglei</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
On 22-Oct-26 9:01 PM, Chenglei Xie wrote:</div>
<blockquote style=3D"padding-left: 10px; border-left: 3px solid rgb(200, 20=
0, 200);">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
An SPM-backed SR-IOV VF has no usable FB BAR, so gmc_v12_0_early_init()</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
resolves the VF HBM aperture from the SRAT. When that lookup fails the</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
code returned -ENOENT, which the early init loop treats as the GMC block</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
being absent. The probe then keeps going without a memory controller and</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
only dies much later with -ENOMEM, far from the real cause.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Return -ENODEV instead so the early init loop aborts this GPU probe at the<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
point it actually failed. Other GPUs probe independently and are not</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
affected.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Aborting here also exposes a second problem. On a legacy host the VF takes<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
exclusive GPU access at the start of early init, and every error path</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
returned directly without giving it back. The host then waited for a</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
release that never came, timed out, and recovered the VF with an FLR.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Route the post-acquisition failures through a common err_release_full_gpu</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
label that releases full GPU access before returning.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
early init also fails before the CP scheduler is programmed, so the host</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
treats the VF as not active once it sees the release. Clear</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
AMDGPU_SRIOV_CAPS_RUNTIME and drop adev-&gt;virt.ops at the same label so t=
he</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
later fini path does not send a REQ_GPU_FINI that the host will never</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
answer.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Signed-off-by: Chenglei Xie &lt;Chenglei.Xie@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
---</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++------</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 11 ++++-</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
2 files changed, 43 insertions(+), 15 deletions(-)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
index 5069042b5279..10002b78c69d 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
r =3D amdgpu_virt_init_critical_region(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (r)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
switch (adev-&gt;asic_type) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
adev-&gt;family =3D AMDGPU_FAMILY_SI;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
r =3D si_set_ip_blocks(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (r)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
break;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
#endif</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
#ifdef CONFIG_DRM_AMDGPU_CIK</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
r =3D cik_set_ip_blocks(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (r)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
break;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
#endif</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
case CHIP_TOPAZ:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device adev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
r =3D vi_set_ip_blocks(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (r)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
break;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
default:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
r =3D amdgpu_discovery_set_ip_blocks(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (r) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
adev-&gt;num_ip_blocks =3D 0;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
break;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) &amp;&am=
p;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
!amdgpu_device_get_rev_id(adev)) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
dev_err(adev-&gt;dev, &quot;Unsupported A0 hardware</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&quot;);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return -ENODEV; /* device unsupported - no device error /</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ r =3D -ENODEV; /* device unsupported - no device error /</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (amdgpu_has_atpx() &amp;&amp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD_IP_BLOCK_TYPE_COMMON)=
 {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
r =3D amdgpu_device_parse_gpu_info_fw(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (r)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
bios_flags =3D amdgpu_device_get_vbios_flags(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
skip_bios =3D !!(bios_flags &amp; AMDGPU_VBIOS_SKIP);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu=
_device adev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (!skip_bios) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
bool optional =3D</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
!!(bios_flags &amp; AMDGPU_VBIOS_OPTIONAL);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- if (!amdgpu_get_bios(adev) &amp;&amp; !optional)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return -EINVAL;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ if (!amdgpu_get_bios(adev) &amp;&amp; !optional) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ r =3D -EINVAL;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ }</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (optional &amp;&amp; !adev-&gt;bios)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
dev_info(</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device adev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
adev,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
0, 0);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device adev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- if (!total)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return -ENODEV;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ if (!total) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ r =3D -ENODEV;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ }</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
/* Request full GPU access only for the remaining SR-IOV init work. /</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (amdgpu_sriov_vf(adev) &amp;&amp; !early_full_gpu_access) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
r =3D amdgpu_virt_request_full_gpu(adev, true);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (r)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (adev-&gt;gmc.xgmi.supported)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -2184,6 +2189,22 @@ static int amdgpu_device_ip_early_init(struct amdgpu=
_device adev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
amdgpu_smu_early_init(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
return 0;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+err_release_full_gpu:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /*</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * Release the exclusive access acquired above so the host completes the</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * handshake instead of timing out and FLR'ing the VF.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ if (amdgpu_sriov_vf(adev) &amp;&amp; early_full_gpu_access)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ amdgpu_virt_release_full_gpu(adev, true);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /* Don't send request since VF is inactive. /</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ if (amdgpu_sriov_vf(adev)) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ adev-&gt;virt.caps &amp;=3D ~AMDGPU_SRIOV_CAPS_RUNTIME;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ adev-&gt;virt.ops =3D NULL;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ }</div>
</blockquote>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I think this is not the right place for this. These flags are not set</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
inside this function.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Chenglei:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Agree. I'll move the release + deactivate into a helper in amdgpu_virt.c an=
d just call that helper instead.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
As this is needed to avoid REQ_GPU_FINI timeout post release.</div>
<blockquote style=3D"padding-left: 10px; border-left: 3px solid rgb(200, 20=
0, 200);">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device adev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
index cd276a138e10..5c6a20e42000 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -667,8 +667,15 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block=
 ip_block)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev, &amp;aper_base,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&amp;aper_size);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- if (r)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ if (r) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /*</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * An SPM VF has no FB BAR0; without the HBM aperture</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * from the SRAT this GPU cannot init, so fail its probe.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ dev_err(adev-&gt;dev,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &quot;SPM VF: no HBM aperture in SRAT (%d)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&quot;, r);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ return -ENODEV;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ }</div>
</blockquote>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
amdgpu_acpi_find_gpu_memory_in_srat has error logging. The error code</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
returned is -ENOENT when table is not found. So this change is not requred.=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Lijo</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Chenglei:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I will drop the redundant error log. But I would like to keep the -ENOENT t=
o -ENODEV change.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The early_init loop treats -ENOENT as the IP block being absent and sets st=
atus.valid to false,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
so the -ENOENT makes the init continue without GMC and only fail later with=
 -ENOMEM.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
-ENODEV sets total to false, so it aborts at the real failure point. Let me=
 know if you would still prefer</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
to drop this part.</div>
<blockquote style=3D"padding-left: 10px; border-left: 3px solid rgb(200, 20=
0, 200);">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
adev-&gt;gmc.aper_base =3D aper_base;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
adev-&gt;gmc.aper_size =3D aper_size;</div>
</blockquote>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 29, 2026 12:43 AM<br>
<b>To:</b> Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Luo, Zhigang &lt;Zhigang.Luo@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM =
aperture is missing</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 22-Oct-26 9:01 PM, Chenglei Xie wrote:<br>
&gt; An SPM-backed SR-IOV VF has no usable FB BAR, so gmc_v12_0_early_init(=
)<br>
&gt; resolves the VF HBM aperture from the SRAT. When that lookup fails the=
<br>
&gt; code returned -ENOENT, which the early init loop treats as the GMC blo=
ck<br>
&gt; being absent. The probe then keeps going without a memory controller a=
nd<br>
&gt; only dies much later with -ENOMEM, far from the real cause.<br>
&gt; <br>
&gt; Return -ENODEV instead so the early init loop aborts this GPU probe at=
 the<br>
&gt; point it actually failed. Other GPUs probe independently and are not<b=
r>
&gt; affected.<br>
&gt; <br>
&gt; Aborting here also exposes a second problem. On a legacy host the VF t=
akes<br>
&gt; exclusive GPU access at the start of early init, and every error path<=
br>
&gt; returned directly without giving it back. The host then waited for a<b=
r>
&gt; release that never came, timed out, and recovered the VF with an FLR.<=
br>
&gt; Route the post-acquisition failures through a common err_release_full_=
gpu<br>
&gt; label that releases full GPU access before returning.<br>
&gt; <br>
&gt; early init also fails before the CP scheduler is programmed, so the ho=
st<br>
&gt; treats the VF as not active once it sees the release. Clear<br>
&gt; AMDGPU_SRIOV_CAPS_RUNTIME and drop adev-&gt;virt.ops at the same label=
 so the<br>
&gt; later fini path does not send a REQ_GPU_FINI that the host will never<=
br>
&gt; answer.<br>
&gt; <br>
&gt; Signed-off-by: Chenglei Xie &lt;Chenglei.Xie@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++=
++++++------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c&nbsp;&nbsp;&nbsp;&n=
bsp; | 11 ++++-<br>
&gt;&nbsp;&nbsp; 2 files changed, 43 insertions(+), 15 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 5069042b5279..10002b78c69d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_init_critical_region(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) =
{<br>
&gt; @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;family =3D AMDGPU_FAMILY_SI;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D si_set_ip_blocks(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_DRM_AMDGPU_CIK<br>
&gt; @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D cik_set_ip_blocks(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TOPAZ:<br>
&gt; @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct =
amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D vi_set_ip_blocks(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discovery_set_ip_blocks(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;num_ip_blocks =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, =
GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amd=
gpu_device_get_rev_id(adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Unsupported A0 hardware\n&q=
uot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -ENODEV; /* device unsupported - no device error */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D -ENODEV;&nbsp;&nbsp;&nbsp; /* device unsupported - no device erro=
r */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto err_release_full_gpu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_has_atpx() &amp;&=
amp;<br>
&gt; @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD_I=
P_BLOCK_TYPE_COMMON) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D a=
mdgpu_device_parse_gpu_info_fw(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bios_fl=
ags =3D amdgpu_device_get_vbios_flags(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; skip_bi=
os =3D !!(bios_flags &amp; AMDGPU_VBIOS_SKIP);<br>
&gt; @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct a=
mdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!sk=
ip_bios) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool optional =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; !!(bios_flags &amp; AMDGPU_VBIOS_OPTIONAL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_get_bios(adev) &amp;&amp; !optional)<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_get_bios(adev) &amp;&amp; !optional) {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; go=
to err_release_full_gpu;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optional &amp;&amp; !adev-&gt;=
bios)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dev_info(<br>
&gt; @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct =
amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!total)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -ENODEV;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!total) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D -ENODEV;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto err_release_full_gpu;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Request full GPU access o=
nly for the remaining SR-IOV init work. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &a=
mp;&amp; !early_full_gpu_access) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(adev, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.suppor=
ted)<br>
&gt; @@ -2184,6 +2189,22 @@ static int amdgpu_device_ip_early_init(struct a=
mdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_smu_early_init(adev);=
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +<br>
&gt; +err_release_full_gpu:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Release the exclusive access acquire=
d above so the host completes the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * handshake instead of timing out and =
FLR'ing the VF.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; early_f=
ull_gpu_access)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_virt_release_full_gpu(adev, true);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Don't send request since VF is inactive. =
*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;virt.caps &amp;=3D ~AMDGPU_SRIOV_CAPS_RUNTIME;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;virt.ops =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
I think this is not the right place for this. These flags are not set <br>
inside this function.<br>
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_d=
evice *adev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v12_0.c<br>
&gt; index cd276a138e10..5c6a20e42000 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; @@ -667,8 +667,15 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_=
block *ip_block)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev, &amp;ap=
er_base,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aper_size);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (r) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * An SPM VF has n=
o FB BAR0; without the HBM aperture<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * from the SRAT t=
his GPU cannot init, so fail its probe.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &quot;SPM VF: no HBM aperture in SRAT (%d)\n&quot;=
, r);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
<br>
amdgpu_acpi_find_gpu_memory_in_srat has error logging. The error code <br>
returned is -ENOENT when table is not found. So this change is not requred.=
<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D aper_base;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D aper_size;<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ1PR12MB612197EEC1C26B3661FE750B806E2SJ1PR12MB6121namp_--
