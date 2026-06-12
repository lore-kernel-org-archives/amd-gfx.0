Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C349CD98CC
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 03:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF3E10E90E;
	Fri, 12 Jun 2026 03:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gYYrjA/X";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012018.outbound.protection.outlook.com
 [40.107.200.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D042F10E91A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 03:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFhNAiHv5I/MgUrDR/sawpMVO8HjfZqsifUkVU/NWiXZSVcdyYyBfseBec4bWuUTrmZrNnAy21dceifd8MwcIk2tadwAofLhs+G2J8ocq+bd0tC1vbwQEVunKgv0o7OaaZKeocdWnZJDtHY23Clagn3HW+Mj74LSAaRgG02MkGCnbUCKGTCE9sPOFeQPD8QXN2LVkZ7ZyxRGvfLQNh/0NpqGqs7gl48BYwcw5UhF97+RnW0UhA0udcBQn0y86VDg0NNHEHgHTcIw091Xh3B4UbT/Stxrr/RH+ten25912UXTQM/ug0akB+0WmEP+sv7hEgB2H1Fbo28UZxKWSzt/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnn+DBztvwNL+FCBmWGJEPheo8q0S7TF/FoyxzTsDO0=;
 b=u0cp8DMaLOXHZeV+OUCAyUWAAAl84f3cfcKDtSiLlZNNhCvvheDkGIrEylvZoYXbW6oTBgUgeumzco5YWILRL7VQwh5kJsJOvdxefiXJ/krf8Y6k3Ya1i2Mqk/gO8Vsc2k/jcZN+/kPsGs42y9DS4vkrjwWvuUl3JQPtR62nGDytUWlwU9kV0TKCrXUSHIHerIMLJ+ILGssPS3tm5V9GwnEcbAS8LKmhLyA+fh4FNCaYCWGXa/5FhF+Cwl7RT5A+Taoc/kbqGmbg9i6qKMHlvtXhPB8WJl+xvvN1nazqpLSC0FTNDoq060HPs0Xrd+HS/vEwQpipbuJlD0MfHM5Omw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnn+DBztvwNL+FCBmWGJEPheo8q0S7TF/FoyxzTsDO0=;
 b=gYYrjA/XzcG2zpxGDrpRJBa/JeEN/Eem61nmahZSCg4fvUlIvoOplchKqk+WCwSryEqj8jU8D0OZBzrbskef+CKK3Utvb8Y0IIRyvErS/u9RxLIr2oonz9gHRsP6cq6lmvM0cX3PFT9ERvJjdxtO4zq6zklRfDVIWjT9i0nv0ug=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 03:16:18 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 03:16:18 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
Subject: RE: [PATCH] drm/amdgpu/ras: Estimate RAS reservation when report
 capacity
Thread-Topic: [PATCH] drm/amdgpu/ras: Estimate RAS reservation when report
 capacity
Thread-Index: AQHc+aNqpZG9V1Mry0S2lgOC6G5C1rY6QFSA
Date: Fri, 12 Jun 2026 03:16:18 +0000
Message-ID: <PH7PR12MB87960FEA018C44CD973A7961B0182@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260611130730.622904-1-cesun102@amd.com>
In-Reply-To: <20260611130730.622904-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-12T03:16:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH0PR12MB7983:EE_
x-ms-office365-filtering-correlation-id: bb9da7c3-1151-4a14-cc55-08dec830f872
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: Y1dSLyVC4n9AvIBhFgjNadAnKsWReMGCokji7JLctu22wsZi093EGpKe5Sk0gz03pUuIm9u2366jx/bKm3O4NQ1WAIqAB0VLLESPd6tDQTuSVk2np9QBp1B8b+Zin/gLqVvzHc+jizdKAyTmRdgo0tjfywaolMTpSnw7cPkM4gvzpYb6TEagyDsDZ64URfBGLvgVFy7OD7BjuFBVDWwtVrbuW8J4mTtyz0g7OSJjZq2jrCJ2mRTsuMFGu2OMTKI7jQlrRMZ8RutZ8cpihfOwSMP50Jx0agIAfpILBgXreHX0OfUmSUusndfMHcIHm8dHjKtvap+gtq3OVyOg+rnwWXAei0Uu3fYrkrY8Ug3yra0yi3fQYoBeDLfvu0+l5E+sGzCRDNrMagLThO3Z9bHzP/+t8Bk5NDCXfTBtKqF9SK5FeIz8w/ANttV5hYa/Dk5m1oxpnCl2B/ymMOUlv1TBkdhrhtMbsGD3rTlT/gdZrL3LKrjZ2u4qjqvieHAm8Zr1OAwQrU7KoA5ROE5r5RtukIKSDrv5aol8bcS98KC0pdfaQ+/Xx6lD0DfwjYY32D8J8kuzau1TdtDYbZ0yrNI2dxFwgHXFss1sYDXOJzyUzaslPRNzkFBAsXHKUBrFJkBe3UI6VgaUs4hG4P+5xSj0JUw7+UxxXfBL+bTrg5K2jEjYaevE3iydebUSJ1xrPqhHn7B+P+bNTFk8prUzWCb/9UJG6e+RFD0vL/6gbkh6jXRIyAAfhq1iIC+pHJBHRWW8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kg1iCfLYJ9pnoGEaOpPpwSWVzpZJI1WPIHZK4C0aGrU2gZ9SzwSu8h6RsR2U?=
 =?us-ascii?Q?+tA+EwCYMp6kjkQ99FsqLFFg1UY3Gdtpp92sOJqtfbwJojVFH+DFiU97J/3r?=
 =?us-ascii?Q?ej6EasoLGQhOm+gXyZkAwHdY7zesEwpcwEUyMPOK5VBxIZ87b6bYQaGN9TCQ?=
 =?us-ascii?Q?hBPZqju9F9WFsHFXNoBNYGaVtTZMoCyLWcsumxm0BQauO/60Ox1yePaRjgr+?=
 =?us-ascii?Q?btSPidG4hjThWWaQ7Vz8LeNkhJgwoZjsFXN6CnpBfeHSgmM6flGxYQB8hrjS?=
 =?us-ascii?Q?zRSd/PaLqSRnrByA+3xdDdayl7PIUKr3l2FnW3qqKdAtW3dLJb2hAxtLt954?=
 =?us-ascii?Q?9nLFGXBkmfyjKVBahP+YXzC1sBCuDEEESUCfdOg3P4NYIu8QrtV+TCHjAti9?=
 =?us-ascii?Q?yszHmOeKAk1KU6Wzg9MNMYwMs4+T/pNaIWKWIRttWwTWmT9/CMg84rWzehZq?=
 =?us-ascii?Q?gsmR+AY98dD9EAMXkMwqgj1QAVBVZnEJjhIbIVMqREZm0feCkikoWqdgoiTi?=
 =?us-ascii?Q?bdO4mUIeg4Etudopnqn5VlgRpkAEByHFpjK2PsR66OakA8m2hIBdU/ycArIm?=
 =?us-ascii?Q?sWihWaVJK7JB81kDuPX+QNu6XyxFy0Pf7r+eHWFz0h2ST8e82pIv0CfNh2D6?=
 =?us-ascii?Q?a1s62ljZ0A8GDIwTIzfa2iqt+fgjT2LU1pBnIC0FFA2toIzrNiab8NnVWgUy?=
 =?us-ascii?Q?B1sZ50iy5El2++Kinwc0zkYflIPqyL/t/8M5yK0Na85YiCrgn/eqf4QOtbSj?=
 =?us-ascii?Q?QmuwqXpnMAOVXPWKoFNn5qvDlywynQHKkRX96qFXYclMUW7ou4NlaspLIXj+?=
 =?us-ascii?Q?3+mzW5AAnFtGLz9k0syCOA57W74huoTQuZmUHCjPg66qYgqYGs0e4Al7kC5I?=
 =?us-ascii?Q?EeFNmCy2tByoiXmjku/3yh76R1LBhxZzC571ujh/5k3c4NpSwXIwMEzfoq8C?=
 =?us-ascii?Q?msevZeszHQT8g+MozX4sQdRY8yHAIA44VOjwWv9cqMwvoGqB+gLhUtB7Fd/X?=
 =?us-ascii?Q?1WUkguct9dtm6zHYJ+jKrX+EBtyl0wqDqRLIjbBOPqUt428z5q/ZyEL6hXyb?=
 =?us-ascii?Q?SIO1dtBm70/pLhi8MArJcKKTdyLpfgxNIJQfdPU28wVyKo/KXPiY9m4xZycK?=
 =?us-ascii?Q?LKzz2q/HDWramO66S9VgNA3BEnunupPkXnPotN0CMh8mit9QhbolYSZzfmff?=
 =?us-ascii?Q?t4r1b7U3WnKnCm+A+2YlhBIXMGPXMqJ8okaz6WYLqg+ELNTCa1S/PjEOtiI+?=
 =?us-ascii?Q?/CMI67jjDPi5Kn97zKyXiiLsS/kBMtTBQo+dSFEBH3F9YVdACTt70HqikiGE?=
 =?us-ascii?Q?otRhQzyi9DytiG7/IN+Q0gTxy+9KJkcBbCpwOwTYo94oxG8YAa84YneAyxVN?=
 =?us-ascii?Q?X59qzCsbaGiMK+zPwDnIBhDRErQKhknQ0SMa2Qefb9Uux27XgKzZRXaBB+ll?=
 =?us-ascii?Q?JXCDnQMvl1yBRjJNLM99ysyKQ7tcANfPayRBwYWoiKTWAngxL/oYvBLga7Vp?=
 =?us-ascii?Q?Ff2Qa8JXhb8dnL/6b4fw8H0Waaybwun+z15JWkqqZmuMfx3EU9L1X47m5jWd?=
 =?us-ascii?Q?g3pEuQXl/fBD9Gpk9qFuVmKVQFexMxXMCgoUKFNoXe9MEsFGwoGGt0yMg8ay?=
 =?us-ascii?Q?EG73BKkIu+JNebGtJy6IquSBjqS8fVA7xbUxa1t7yYrplPjq2DTE17nqLaeF?=
 =?us-ascii?Q?+IQRWXh+rssEn0fHMsmKNyB3NDgul3Ma3niavjTJem8/9HG+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9da7c3-1151-4a14-cc55-08dec830f872
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 03:16:18.4955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMzFrrVkUhZOB9cO5VlkmydVl6WNJFMxbdL4kDGSwqm381+dW/z3G5Gt88VOGqvY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983
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

AMD General

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce Sun
> Sent: Thursday, June 11, 2026 9:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Sun, Ce(Overlord)
> <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu/ras: Estimate RAS reservation when report cap=
acity
>
> Add estimate of how much vram we need to reserve for RAS when caculating =
the
> total available vram
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index 26f554a80e1a..f627a97797ed 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -95,11 +95,35 @@ static int amdgpu_ras_mgr_init_aca_config(struct
> amdgpu_device *adev,
>       return 0;
>  }
>
> +static uint64_t amdgpu_ras_mgr_reserved_vram_size(struct amdgpu_device
> +*adev) {
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     uint64_t reserved_pages_in_bytes =3D 0;
> +
> +     if (!con || (adev->flags & AMD_IS_APU))
> +             return 0;
> +
> +     switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
> +     case IP_VERSION(13, 0, 6):
> +     case IP_VERSION(13, 0, 12):
> +             reserved_pages_in_bytes =3D
> RAS_RESERVED_VRAM_SIZE_DEFAULT;
> +             break;
> +     case IP_VERSION(13, 0, 14):
> +             reserved_pages_in_bytes =3D
> (RAS_RESERVED_VRAM_SIZE_DEFAULT << 1);
> +             break;
> +     default:
> +             break;
> +     }
> +     return reserved_pages_in_bytes;
> +}
> +
>  static int amdgpu_ras_mgr_init_eeprom_config(struct amdgpu_device *adev,
>               struct ras_core_config *config)
>  {
>       struct ras_eeprom_config *eeprom_cfg =3D &config->eeprom_cfg;
> +     uint64_t ras_reserved_vram_size;
>
> +     ras_reserved_vram_size =3D amdgpu_ras_mgr_reserved_vram_size(adev);
>       eeprom_cfg->eeprom_sys_fn =3D &amdgpu_ras_eeprom_i2c_sys_func;
>       eeprom_cfg->eeprom_i2c_adapter =3D adev->pm.ras_eeprom_i2c_bus;
>       if (eeprom_cfg->eeprom_i2c_adapter) {
> @@ -133,7 +157,7 @@ static int amdgpu_ras_mgr_init_eeprom_config(struct
> amdgpu_device *adev,
>                       div64_u64(adev->gmc.mc_vram_size,
> TYPICAL_ECC_BAD_PAGE_RATE);
>       else if (amdgpu_bad_page_threshold =3D=3D
> WARN_NONSTOP_OVER_THRESHOLD)
>               eeprom_cfg->eeprom_record_threshold_count =3D
> -
>       COUNT_BAD_PAGE_THRESHOLD(RAS_RESERVED_VRAM_SIZE_DEFA
> ULT);
> +
>       COUNT_BAD_PAGE_THRESHOLD(ras_reserved_vram_size);
>       else
>               eeprom_cfg->eeprom_record_threshold_count =3D
> amdgpu_bad_page_threshold;
>
> --
> 2.34.1

