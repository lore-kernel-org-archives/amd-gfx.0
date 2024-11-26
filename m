Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3C2D3B7CA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2024 09:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ABE610E808;
	Tue, 26 Nov 2024 09:56:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="37dlZDT1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC18F10E808
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2024 09:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alkqHuWIh5XgWs6N4203+eBmfrep5mhMcwrq3nx9RpRmgcLhQdFUPBzarWBFza4iTlWcREnMRN88/v91K3gy9s0iZDZ4yevCMJjAl+CIcvmK27dBxNJDYTl9FKqy7byncfC5n1C50PW31I5Itw8MjAH8Hbqdjh6MQRIKJpsX8OkmMSeKEIaCF+460Xrv6LrXEjhV/wV2efLnMNt5+TzmL1AcqAF+tSOGSW0rUJr3ve9MiZ+BS/S81lUZQUBrcEz0rXCoH7mzk0F+uBMBTYvr2zxVRtfq03lzfZcVAfaliABlrK4Qe9YG0Y7kVMiYex4QKd5xCsKamMXqUe322475wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJszlXFYzlJ/rcs4p7dLzIZiuZXwQOgvPkgL8uUE/EY=;
 b=cPDLbu4x6LE2j4BRxaJD+yKkctaqoCgE4taWzN2+Azzbjc82itIr/k5EIySAWtxnNuhAEvBdKkztf+8jUeOlhtzq//zF7hjW9HMgwjeQF19gdrNf/AhTkjlFzrSTPBCITAyjdtjfAQrONPBIv1Umq6qQqgK9rfB4i0aw29hwR8QodNetE/y+9wxWGaQM1lIPnDmT2z83ZdSzCMZtyCunAi8tdr+yj3oudzOG9/JqarPwjuaHmb7dSqoHY9oJTkCPuzxnL0kgB/k4rfBTQ4U1NpwFVCq9MhZK6vzY9RDM5etJolwiWA1s1UqHmnk5xLkOzZSABMYtCf05KGkWd8/fDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJszlXFYzlJ/rcs4p7dLzIZiuZXwQOgvPkgL8uUE/EY=;
 b=37dlZDT1AWR3+R1Yb/I8PZT6yATKpYszhdom7biLpI1TvnkB2xYB16MyKVDhTS9nB1AAtC7rthfbWegVmAetH3ZNa8+lHk3DLt1u+dxBLSI2KgHIEje50V9OD703Qn+16Dgt0U8mXXxVXJKupadyRxrNb7GHbCPyXOQ2E+jshEc=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 09:56:01 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::bcdd:c459:3f9:5bb4]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::bcdd:c459:3f9:5bb4%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 09:56:01 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use sjt mec fw on gfx943 for sriov
Thread-Topic: [PATCH] drm/amdgpu: use sjt mec fw on gfx943 for sriov
Thread-Index: AQHbPa/siiSb1avGKEGcEzV5whRs1LLJTldw
Date: Tue, 26 Nov 2024 09:56:01 +0000
Message-ID: <DM6PR12MB43405B502B64827FA574F82EFA2F2@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20241123135920.2593163-1-Victor.Zhao@amd.com>
In-Reply-To: <20241123135920.2593163-1-Victor.Zhao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7d3a122c-476b-4ead-80ad-ecd2d6485b22;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-26T09:23:31Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|SJ0PR12MB6966:EE_
x-ms-office365-filtering-correlation-id: f9723137-039c-48b8-e6e4-08dd0e0088ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fCI/4oxnanyhJMotCQqggNHeDoMNfuPJOrhgaYhDyFeTnFWck4FPsNb8pHvB?=
 =?us-ascii?Q?chRJqz++vNYjKd+8W+nO/Pc21usqs66mMTRZWdKtypiWSreRbkCGINc7u+7m?=
 =?us-ascii?Q?5tJyLE6C371b5v4TDXLkb0W99g+1hFoSBlhtfwII7KJYK52BfGbztF37kLUa?=
 =?us-ascii?Q?ILbBB2PHJ6pAG/dclt3LwsRgzta3A2qENh9A6Jd0Cw/70h4qyrL3EZqEhqRE?=
 =?us-ascii?Q?LfQnrKRvNxxkXrl9+QF96/REliaJRds8YLWY4Ezx7lWM4RU1hC3GEBB8rgbm?=
 =?us-ascii?Q?1Bs7gnHPHV5316AGpBnnxphxE2D36muPO8Gj+/T7CoVKaqCcfwdDyUZWx870?=
 =?us-ascii?Q?zQhHTrLPET/DHlsRe8x3Y6kZRXUCPkaw9Fznr0KEgOriEPnZIz8MU8udb7Xf?=
 =?us-ascii?Q?O3fCWA7IK2e1ZKtZ+/KQzQXe21Q4k2cH596RDt2EU/8LE2NRogsKX5La/ZW1?=
 =?us-ascii?Q?MpN1snKwtd5iQmU2lcVTG0MnZ57tDKa5zyr67MKZA/8ByWVVRBYaa3Oj5E/c?=
 =?us-ascii?Q?gKvkYFYXjCrrSVgP2AIOB5IOQop0dC16ZlKsTaFLzQ+C+kTFG/i/nj8rP1HR?=
 =?us-ascii?Q?uVmVCPBV75qog5OxLk3v2abiPrJ5j2jzbGBcX8z2WbxsyeIiuCbDGjsBQ22K?=
 =?us-ascii?Q?JwKr/YVXbgWDvr6nuy67JAXV4odypdnl1y6+gKucjbF8FnOr3FXC8oMy6sqz?=
 =?us-ascii?Q?Gz4VB8+gv5wvAn7d7YrepjaRnt8cuULWS5a25hsLLSxXFRvFc76/A61COCmd?=
 =?us-ascii?Q?0uN2+LeqKo/w6v74qAB9TqrXpYqZxZvoSk3C9q06Law4otqNztmJ1gaS6o9H?=
 =?us-ascii?Q?mdFTCmp4+GPuR2CsdgDdcqJUSAZkNfdv8Q0P9m2cTQxTt/A6U3o4uh96my7+?=
 =?us-ascii?Q?/1BcG7OlUeY6F5yHfVXxyQlNiV/5OuSEqMqk512CMKbKtLWW/5q3Ri5gn8g0?=
 =?us-ascii?Q?5KEWOpaMjNzPVwGfMtN0JNVmf5UlqgLYiAKqtzcI31x1rHWd2iW14qt8VTjw?=
 =?us-ascii?Q?/WMWUsEjjUgnJRkB8le7PXmMbnihXvrq0B2iy4gxvB0+M1UiYzTy2wOZpTPj?=
 =?us-ascii?Q?zgFYFcxM5QftYv5j4AKivXs0PyQFzcQdG53jUwVI2XQBUuwbwinsxskx1X2a?=
 =?us-ascii?Q?9CRVWq8DAaY/EK5GLBuUM8xte4Iy9mKXwp3p6XSk0eEwCDolPx+dLX/YwBAR?=
 =?us-ascii?Q?z18V80w/wGmCiptmd/MWzC5D1IQavbblymYiHOjTlwwd2W6NipzmavrfWECB?=
 =?us-ascii?Q?AUjHs3NeP2o7B6tmLhthO3GBtWC/qEjrP4G2xKdZbTO1aSC5jU/rqX/wsuFu?=
 =?us-ascii?Q?M9hjFwwT+t+mLlUR+4uJz6CVfXyMLuSqVh+SxI7mniS3Uo3e212Hc8WAmMY7?=
 =?us-ascii?Q?U8BW8Ze9yAzMS+3l0oZEy6uUDUZp9C5ro7BcY70+ZHbj1wLkgA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F5JrljT/XtgVJfXJ34qyfd/JiIQT1WYv4XrwgHVSTnCAD5KL6qzapjFqEC96?=
 =?us-ascii?Q?Bi9iMJbapkeDEvnTyc3H91oIu9md33+MS0/U3oL1e5u+qqVnCzLhYPoT4aMZ?=
 =?us-ascii?Q?GbEY4C1k0i2gTHWos56RzWcRrEVorTPnm//UejeuwZjhSRxr/1w1awLkfU5o?=
 =?us-ascii?Q?hfc+WGsFN3+csW27OOP2e6ol4ymILfveN8/Tp8N7zJIETi+A3XLOwW/hztU0?=
 =?us-ascii?Q?Nk6H4326QvsyTwtyEcOCRic3ru5pAkpdHMIcCxrTzW4VwDA7w+EJXco6TbGU?=
 =?us-ascii?Q?Ml9jV0+ByIKmhOdmEdARvl4/u27EOV33EGn9+5WKlt52x0RCy/ft14z1Mxd4?=
 =?us-ascii?Q?5z4hIgdCtPF4Mm6WRJky+QRRqhmOCsxNlpzRGzsq5zyIerx/uBYFpII8OqOY?=
 =?us-ascii?Q?AhZ62YT9T9NC8Fgn+hcAM2DhNEC2bgBmyQA39Y+y5Kxe8hE9ttnevarW40YA?=
 =?us-ascii?Q?NPbnenCIgjEBTSArJDMJeQuu54Z/i+qSAG5z97o6Hrdc8rBIgD4y3TTkvLn2?=
 =?us-ascii?Q?ZUCqysGxjoadw77HzlrFFkquwyLi/BXDHEGifQQhb5YrQ60dTiMXdY6DAPNk?=
 =?us-ascii?Q?vIh+KVODdBD3Xjmk4GP6n9VEOTV3QYtsK0eXhNerNxH87ifkWkXGe2I5vfYN?=
 =?us-ascii?Q?akuaGloAbuOS873Ag+ERHDmh8l3EW77DiZHnbkQvm2hJyCNHq0jOQaoJeQis?=
 =?us-ascii?Q?6qNXtq0AfWoFU9vKUtAbtswwTqCfN7Nlm4+8nH867n9M9DwOBTn6s2TBWCFN?=
 =?us-ascii?Q?mSa2sn6yX+uybuSxIdQh6ZQJTS30hfIYQLbIPAHfk8IAGRyaCVz8mTwrpsCS?=
 =?us-ascii?Q?OKUv2kQkbPT7kXXbw987Ic2uZOGxM0uk4aY8TQVm9yuIu9m9hzmyHOzW9gdH?=
 =?us-ascii?Q?SRYQeXowSGkARrv/yFcF4vlBltEVzGB/pxDLQVab9um4oVqY6hJ3x4FmaYBR?=
 =?us-ascii?Q?pPkNTrZU3Cn1PDkTXWy8LDY8/0vN6sDGUETsjjG4wpr1iPONQDnwu9bGd9Bp?=
 =?us-ascii?Q?+tLng2Qlw7Ik4X+unkNr8luQ9Gc3FfYCHCW91yG1zNeF3ABqbLgpspX2TroQ?=
 =?us-ascii?Q?zMTnK/Pi/CABYKcLe9so7YPsdA9EGzH833eFCuev1PjBq8bwBwx9vH6rfRBw?=
 =?us-ascii?Q?7K4xfjYCG479WD6BjQE1nrH1GBV3aHNNU8A+rkJTl4bTUnjWvUb8oarTToa6?=
 =?us-ascii?Q?q/RG1HtECSooWwEkidv1ctIb1RgHwhrX1RpdBp7TEsHQD5thNr1SlhNLjau9?=
 =?us-ascii?Q?C9dF9imwm/4VW+ycyKcxeZ6KZKCcUVrk1OCBLBEG2V2DZ0xxaIgKXliUPcPZ?=
 =?us-ascii?Q?hg33thdWihN+7SJwhT55HDP6Z1k7UNc4sGpd2GbYkvqL+r2oUpt0MWKBNFKN?=
 =?us-ascii?Q?Mcy566xDM5PBwiCts5CfLSzcP0MIywPdezgr8dKrnWGPv+n7tdzd//dpfyjK?=
 =?us-ascii?Q?euHvu15C6dxeWudOVYCBaOUEgYU77QicS60B50eKQwhwNRpmt9OMsiMlSz17?=
 =?us-ascii?Q?4qUfaRloLSFhuQaX5KZq+lKOK4od0gEC34cr3rFCM6WaQKm6q683nysO8rlX?=
 =?us-ascii?Q?LLqueMo2jjxaj0jCReM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9723137-039c-48b8-e6e4-08dd0e0088ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 09:56:01.2162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cURn3GKQwcl20W0LZUPyfMGfLXFoGw/rbGOy3yWeokoh9rYw7lIQ96iZgRXsg3g0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping. Please help review.

-----Original Message-----
From: Victor Zhao <Victor.Zhao@amd.com>
Sent: Saturday, November 23, 2024 9:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: use sjt mec fw on gfx943 for sriov

Use second jump table in sriov for live migration or mulitple VF support so=
 different VF can load different version of MEC as long as they support sjt

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index f23df55d72fd..58541b93580a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -45,6 +45,8 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_4_3_sjt_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_4_4_sjt_mec.bin");

 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L @@ -574,8 +576,12 @@ =
static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,=
  {
        int err;

-       err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
-                                  "amdgpu/%s_mec.bin", chip_name);
+       if (amdgpu_sriov_vf(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+                               "amdgpu/%s_sjt_mec.bin", chip_name);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+                               "amdgpu/%s_mec.bin", chip_name);
        if (err)
                goto out;
        amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
--
2.34.1

