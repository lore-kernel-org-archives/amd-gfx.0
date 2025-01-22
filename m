Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A400C02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 11:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDE5D10E6BB;
	Wed, 22 Jan 2025 11:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VarXTKuE";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1E410E6BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 11:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjMQ2ZlIM3xp0J43d18fAc95HfmaF5qeO56R2410VvLAPtseBQN/NtqFeOPLvWwnSBC4+BBLlE2dyQvcFE0qH6RtRdb1fn8YgBxApQPwgRY/2KUQv5xqyuaZNufojBzTq5UcOuddfs0o0QlaItiA0aqllZJNLe5qfBuQB6QVz0qoJx7AJwatrzmJL0zFjbOJKGd9kCKUhccDRRE632RE12J33nkcpbkdnxA5Biu4gdtcwa2ryAAvdYIZImApzvup2U6pjuYtV7LwSkbpHi5LeMJIovyGRJD1/vgK4dciyaBH77ywwCj0rpMvX1MO7RBL/U5DzaAbV4BmU6aDUqTlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M9EfERMUOY116HQWjrulpb7zIOi2kvSratNSh0MveY=;
 b=U14fGuBJU4jh26yKOM/F+mkywHxMHXqa+29A4SlUClc8xm7gxk+wIK6JeJPLQ3zUmTBEaoTCDnZYwaDa0rxispIKXQXQdfpGd52WGIQre+XAIk7A1EUAUz/LETv/7Pc9lJHWkvYXGtVFrxhXE7zSYKsI1VZG9zYpVHIUoei/uQ2nE6dxIApujxLCw60A8F8hErdGveeYQ5nPZ1vzZWkvSlt0BxoZq5FOrlh99kU9rGrCETrXEpeJoc/2VRXyjV/IAEyyOTk8IrIMOJdf5/fZ3zdVCadLgqiHFExZxCr88N48zUMZoZroU9ewXj8zRn9ymKyluBOIecp0P1cq2NHCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M9EfERMUOY116HQWjrulpb7zIOi2kvSratNSh0MveY=;
 b=VarXTKuEN6bFpwxsPMnl+PV6uQ/qAlPSnoq3iVdz2T3syEpRKZyW0W08OFVB0u+mROXRgWTaHLtPyzs3yClRKLtXWoUTjRyOn+Bt429MWZpZlks4sXEH9Jr2VH18+83ut7BXaMVH2q9wimYphzP9UUtdaKx4Ypb3SsCRUkQNQtw=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 11:13:18 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 11:13:18 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update usage for bad page threshold
Thread-Topic: [PATCH] drm/amdgpu: Update usage for bad page threshold
Thread-Index: AQHbbLi5Q7ZJOCO1nkKrPO2BIU+GnbMio1zQ
Date: Wed, 22 Jan 2025 11:13:18 +0000
Message-ID: <PH7PR12MB8796AD78D59DCD031181396FB0E12@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250122103018.17264-1-Hawking.Zhang@amd.com>
In-Reply-To: <20250122103018.17264-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b3e207bc-15f0-47a2-a922-598094defbdb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-22T11:11:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH8PR12MB6748:EE_
x-ms-office365-filtering-correlation-id: 46b536e0-2083-4458-b8e2-08dd3ad5c65c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qvy63HDg7wpOSv2zl4hhT9Nvln0+cZtAVXpdWcc57NWSpq17845lofeg6bnG?=
 =?us-ascii?Q?oSQzBtsEi47dMY3GZo7e/viopa5G6FF2gg5bfE34y6yISmR1nnL4ccH910cC?=
 =?us-ascii?Q?NiG1VndXsL+gPEZXXqHrcek9wpsweJmB4ZqfV10L/fNjWtnMaYlxMUqUnzkX?=
 =?us-ascii?Q?4U6bXo7RWWmbI0Bx44b0HBxI6TaN+l76WuFUUOOn8UPNACU9vwYkgVa3ertS?=
 =?us-ascii?Q?X07Pj4KEJ6GOYXTWhThO2mK0UwVAjCjG4RIRPVWbhPBqXJo6qlazalNvxvow?=
 =?us-ascii?Q?R9MPLk90eQVjZdQgt1rgSM6fnY0Mg/GmffmIfB3WClcScKsyeeVb9clIi30Y?=
 =?us-ascii?Q?//c5gG76yysZqNSBh2Vli+7zarFcFClfam19s8YSGpmFE6TacrwXTEYYbSof?=
 =?us-ascii?Q?QRkGgVleC4S0mtRIpoFhB+T2UOC6R1ln0sz8zBASuULlitGmewrj0Yf1jPb4?=
 =?us-ascii?Q?p+mil2pyg9LkVQUd4nqMNpaek7yhLwTXYRiLc52jOUpwVxqNwxIwXC/hd43W?=
 =?us-ascii?Q?a85T4EaWYHryhkXu4uRbnZnvmBs/T8htxacdnKnEp92LZMPn/l5GtNjD0Jzj?=
 =?us-ascii?Q?sS2VJJvDeZXLtOIBdeh66ng9PpgVbtBMQqPYfkV6auoB5RKpMThk1nBI+QLC?=
 =?us-ascii?Q?/Ve4tVpVPTfoICVFXHwllyXMC4llmOVwvOnMVVUolT2xdcshRt5GNerv9qNj?=
 =?us-ascii?Q?I7Lm8XKPds6jaT9IMr++m3xhPTwCzSw8vJBMyZxqA/8bf60ItupbeuY/LTBS?=
 =?us-ascii?Q?0K4cRTIdku8SauGX2/dtTvtPVmLSHNwFXua23lyiCyzvf2p3PfNIuGjsww2D?=
 =?us-ascii?Q?2fXcG4FZdXMDs8kp7pPcGvQ6wY3m9oqvruREB0Pzl02BE1WaiOMxmIV8jnqo?=
 =?us-ascii?Q?kYk7Nu/GGruxu+AGnEmgxQdWkog/947o765yO10A8nXhytoSSlCxfrpPTBAW?=
 =?us-ascii?Q?4pIXcNiw1LoJXOpVrysN0uiMCRI7t9tAQiudwXYBCl7cTec+7N8gbWBu8iEB?=
 =?us-ascii?Q?tUt6saOz5M3dTTe79zBmi9O7569X9p57HoWZBvTCty1a5w8hZ3gqssquSFfG?=
 =?us-ascii?Q?F6eYi/iFZ6bWreoFrBZeavfkgCfAkMpBo82ovKQxXdQKQ466Ae9BrBlnWTVG?=
 =?us-ascii?Q?SL4RiMw5HL6oNWW961BhkAG6/2pBHEjGRACw7e/XkFMoA0ofD3o6oPI2cq2C?=
 =?us-ascii?Q?8dqfsRtNJRyewowhg4FdXodayxblFMfQr059pUvK9h+5IzmOAFqZ9NKUIsak?=
 =?us-ascii?Q?p90SbV1+20Kak78to8o7+U/vbhu2lX2xG7oJCMIvHi3ZwMtluuJhhOlBpktz?=
 =?us-ascii?Q?5nqqTF3Op1QCoowaqKzM1K7kiIMTssBu2keWni48F3AhnS/SFAfgmE565zZA?=
 =?us-ascii?Q?0puBbfsLjs7NMvIwXFpht2fXPelfYsChFA6rxp/4oOyOntiyZCvflX2E4vge?=
 =?us-ascii?Q?/T5oOmw+43wxFlr8Mp8lR28LadhjRXVx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EfCKHSgqcxPWN6Li/G2oDv/Fl+RflDq+NrbqMUtRiQas/FMDYaKooA4G7I8y?=
 =?us-ascii?Q?t0M7kxNDFszmM+QMClNR0ypIYY6cw8K2umu2PFrITdwJa8TvRMMAZ+NSG+og?=
 =?us-ascii?Q?QXm1cKTIe5G9L3ZkySDl+X+RR8fxC+dZ1fiy5/orvhzeWvRUG5cQAbbPiA4S?=
 =?us-ascii?Q?2jBz7GkAB6psHXPQUL5X8zbTmYH5Qw3gRV5ngUgQZ3VW65EfEQOZACkGqR2G?=
 =?us-ascii?Q?2o+P/oe6AvwlHLNUBd4Gi/FXe58x4lUBSewzJ3dO6oA1ni8pDiKMOE5HN6Wy?=
 =?us-ascii?Q?MNV4wEu9BpBTg+nu0jo4MJRiE/TvfScK5Q1++HOkOSVr25N8Hn5SLKuDwZoU?=
 =?us-ascii?Q?KVtFLepH+q7LKOaNDG/smH+EXnRJeBI67UAGgaVcZY2O19Pr4qKXDEofWxSh?=
 =?us-ascii?Q?LRf/mdXgDmauJZNEIbZa4YsiNrtnvbNijs0ji2PNhM77lSXAZO7hWQbfxbBo?=
 =?us-ascii?Q?FNfjXmgcbqdVEe9hB6WxRvSwaILJzB6VDTAfj9J/CE8/zPWrO/tSsXV/lrrK?=
 =?us-ascii?Q?6zjYNushkyLneA8HEEhIlPZLiVJD8SsD97rcjB3u9c5qGL92aLgqgYPT7R9k?=
 =?us-ascii?Q?l8emAp/VyHs14FFXti/d2akBSTYA/7hUCWt6fHHskL6Ki9dPvmSSxPa7Ayis?=
 =?us-ascii?Q?hRyXihJUEP5n8Qx1cGRiy1goYQs239a9I58oz2gba0YKKd/hCP9M926G/pZq?=
 =?us-ascii?Q?PpnHdIYJRG3Wc7nOcqzcggl2DU41+0bSUbBRGe7i5li+a/VNIBH/t4QjgcXC?=
 =?us-ascii?Q?IPCBegA1N26gWJcNH+GgoNntR8TAYnDmd9lMQaf8pvQ4dcKIFa9fRHYeu+zB?=
 =?us-ascii?Q?5YwQcm62Xud7snatAEPALcNi1lcuGzIXFNRwD2pZ193cERB+aOrgJ6So8E2V?=
 =?us-ascii?Q?2UmkXHZ9f7BidLo9Y7JhGzEW8G5dKzaK60xFHGdN5LGknZYhoZ3wO6THoD5L?=
 =?us-ascii?Q?CGI51Bpc4A8SRG6OrLAZsx5U4bcAzXYNfZFzFjt1SAr9WgS5Leb2u+VWYSjD?=
 =?us-ascii?Q?OfIohegPvxhSetojjULaR8oQ+fPRUnrnHkQ+A3c/aW3S4sygKr/umaaKoAoK?=
 =?us-ascii?Q?pd3snrrhmeFctRMp4ngBsp/2YA5rr9icc6VRMJm02uuiFZorTu0v8g1nwN9F?=
 =?us-ascii?Q?mUbk+bQiUt4wD1Z7gqdHxNtdfrA/Iq8ZvkR9zZPMeZexDVyKmROCWxJvo//T?=
 =?us-ascii?Q?rmHqu7DG3zS597X/VVsfT2jF+/HDdfuss5S/pEMU6jPeF7ud44EySVfUwfUi?=
 =?us-ascii?Q?LZ6G+vxSlPohXfdlf3w4LfNjF/kjgh7xfsKRmRc/anVq1DnVHXaA62r5VHo2?=
 =?us-ascii?Q?u/S/T/P7EZ5Jb4ec638V1Cni8G0FK5QaKJ7MfMW4/ieNEcGcpeYyV4H1NUSY?=
 =?us-ascii?Q?1Cm1eWZ4K85pI/9xRPmeOekhQZP/L0oIqtd/Mt5H63h+7UlFrQpRYS7abHsM?=
 =?us-ascii?Q?3SW8JXT8XKxM0wlPeVaa/E9C/X4rFJckMDfVIGmO5cVIx9nxSG9GEgB0XA+c?=
 =?us-ascii?Q?jAh790E9TiQnFk68KYPqzD8uiRKqMqaRPssUiZh/uDjt1qKKBM0B+cF5icya?=
 =?us-ascii?Q?BsioCRJASEgOw/9D11g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b536e0-2083-4458-b8e2-08dd3ad5c65c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 11:13:18.6583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4tWU9ZwOtC7SRopjEwHChSRvxN846s/8o2Pg7sX3A7P6PAlEl5zIBUd+iiMmI+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748
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

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, January 22, 2025 6:30 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Update usage for bad page threshold
>
> The driver's behavior varies based on
> the configuration of amdgpu_bad_page_threshold setting
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 54 ++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++----
>  4 files changed, 44 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 99d884e6763a..87ea2e2a062f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -983,7 +983,7 @@ module_param_named(reset_method,
> amdgpu_reset_method, int, 0644);
>   * result in the GPU entering bad status when the number of total
>   * faulty pages by ECC exceeds the threshold value.
>   */
> -MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 =3D ignore
> threshold (default value), 0 =3D disable bad page retirement, -2 =3D driv=
er sets
> threshold)");
> +MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 =3D ignore
> +threshold (default value), 0 =3D disable bad page retirement, -2 =3D
> +threshold determined by a formula, 0 < threshold < max records,
> +user-defined threshold)");
>  module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int,
> 0444);
>
>  MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to
> setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)"); =
diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 960476e6124b..5676ffe5c43a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3071,35 +3071,35 @@ static void amdgpu_ras_validate_threshold(struct
> amdgpu_device *adev,
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>
>       /*
> -      * Justification of value bad_page_cnt_threshold in ras structure
> +      * amdgpu_bad_page_threshold is used to config
> +      * the threshold for the number of bad pages.
> +      * -1:  Threshold is set to default value
> +      *      Driver will issue a warning message when threshold is reach=
ed
> +      *      and continue runtime services.
> +      * 0:   Disable bad page retirement
> +      *      Driver will not retire bad pages
> +      *      which is intended for debugging purpose.
> +      * -2:  Threshold is determined by a formula
> +      *      that assumes 1 bad page per 100M of local memory.
> +      *      Driver will continue runtime services when threhold is reac=
hed.
> +      * 0 < threshold < max number of bad page records in EEPROM,
> +      *      A user-defined threshold is set
> +      *      Driver will halt runtime services when this custom threshol=
d is
> reached.
>        *
> -      * Generally, 0 <=3D amdgpu_bad_page_threshold <=3D max record leng=
th
> -      * in eeprom or amdgpu_bad_page_threshold =3D=3D -2, introduce two
> -      * scenarios accordingly.
> -      *
> -      * Bad page retirement enablement:
> -      *    - If amdgpu_bad_page_threshold =3D -2,
> -      *      bad_page_cnt_threshold =3D typical value by formula.
> -      *
> -      *    - When the value from user is 0 < amdgpu_bad_page_threshold <
> -      *      max record length in eeprom, use it directly.
> -      *
> -      * Bad page retirement disablement:
> -      *    - If amdgpu_bad_page_threshold =3D 0, bad page retirement
> -      *      functionality is disabled, and bad_page_cnt_threshold will
> -      *      take no effect.
>        */
> +        if (amdgpu_bad_page_threshold =3D=3D -2) {
> +                u64 val =3D adev->gmc.mc_vram_size;
>
> -     if (amdgpu_bad_page_threshold < 0) {
> -             u64 val =3D adev->gmc.mc_vram_size;
> +                do_div(val, RAS_BAD_PAGE_COVER);
> +                con->bad_page_cnt_threshold =3D min(lower_32_bits(val),
> +                                                  max_count);
> +        } else if (amdgpu_bad_page_threshold =3D=3D -1) {
> +                con->bad_page_cnt_threshold =3D ((con->reserved_pages_in=
_bytes) >>
> 21) << 4;
> +        } else {
> +                con->bad_page_cnt_threshold =3D min_t(int, max_count,
> +                                                    amdgpu_bad_page_thre=
shold);
> +        }
>
> -             do_div(val, RAS_BAD_PAGE_COVER);
> -             con->bad_page_cnt_threshold =3D min(lower_32_bits(val),
> -                                               max_count);
> -     } else {
> -             con->bad_page_cnt_threshold =3D min_t(int, max_count,
> -                                                 amdgpu_bad_page_thresho=
ld);
> -     }
>  }
>
>  #ifdef HAVE_KFIFO_PUT_NON_POINTER
> @@ -3852,8 +3852,10 @@ static void amdgpu_ras_init_reserved_vram_size(str=
uct
> amdgpu_device *adev)
>       case IP_VERSION(13, 0, 2):
>       case IP_VERSION(13, 0, 6):
>       case IP_VERSION(13, 0, 12):
> +             con->reserved_pages_in_bytes =3D
> AMDGPU_RAS_RESERVED_VRAM_SIZE_DEFAULT;
> +             break;
>       case IP_VERSION(13, 0, 14):
> -             con->reserved_pages_in_bytes =3D
> AMDGPU_RAS_RESERVED_VRAM_SIZE;
> +             con->reserved_pages_in_bytes =3D
> (AMDGPU_RAS_RESERVED_VRAM_SIZE_DEFAULT
> +<< 1);
>               break;
>       default:
>               break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 82db986c36a0..cc4586581dba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -65,7 +65,7 @@ struct amdgpu_iv_entry;
>
>  /* Reserve 8 physical dram row for possible retirement.
>   * In worst cases, it will lose 8 * 2MB memory in vram domain */
> -#define AMDGPU_RAS_RESERVED_VRAM_SIZE        (16ULL << 20)
> +#define AMDGPU_RAS_RESERVED_VRAM_SIZE_DEFAULT        (16ULL << 20)
>  /* The high three bits indicates socketid */  #define
> AMDGPU_RAS_GET_FEATURES(val)  ((val) &
> ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 0d824f016916..bd9ed86d8fde 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1428,8 +1428,9 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>
>               res =3D __verify_ras_table_checksum(control);
>               if (res)
> -                     DRM_ERROR("RAS table incorrect checksum or error:%d=
\n",
> -                               res);
> +                     dev_err(adev->dev,
> +                             "RAS table incorrect checksum or error:%d\n=
",
> +                             res);
>
>               /* Warn if we are at 90% of the threshold or above
>                */
> @@ -1447,8 +1448,9 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>
>               res =3D __verify_ras_table_checksum(control);
>               if (res) {
> -                     dev_err(adev->dev, "RAS Table incorrect checksum or
> error:%d\n",
> -                               res);
> +                     dev_err(adev->dev,
> +                             "RAS Table incorrect checksum or error:%d\n=
",
> +                             res);
>                       return -EINVAL;
>               }
>               if (ras->bad_page_cnt_threshold > control->ras_num_bad_page=
s)
> { @@ -1466,17 +1468,18 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>                       res =3D amdgpu_ras_eeprom_correct_header_tag(contro=
l,
>
> RAS_TABLE_HDR_VAL);
>               } else {
> -                     dev_err(adev->dev, "RAS records:%d exceed threshold=
:%d",
> +                     dev_warn(adev->dev,
> +                             "RAS records:%d exceed threshold:%d\n",
>                               control->ras_num_bad_pages, ras-
> >bad_page_cnt_threshold);
> -                     if (amdgpu_bad_page_threshold =3D=3D -1) {
> -                             dev_warn(adev->dev, "GPU will be initialize=
d due to
> bad_page_threshold =3D -1.");
> +                     if ((amdgpu_bad_page_threshold =3D=3D -1) ||
> +                         (amdgpu_bad_page_threshold =3D=3D -2)) {

[Tao] as discussed, besides modprobe, ras->is_rma shouldn't be set in runti=
me if threshold is -1.

>                               res =3D 0;
> +                             dev_warn(adev->dev,
> +                                      "Please consult AMD Service Action=
 Guide
> (SAG) for appropriate
> +service procedures\n");
>                       } else {
>                               ras->is_rma =3D true;
> -                             dev_err(adev->dev,
> -                                     "RAS records:%d exceed threshold:%d=
, "
> -                                     "GPU will not be initialized. Repla=
ce this GPU
> or increase the threshold",
> -                                     control->ras_num_bad_pages, ras-
> >bad_page_cnt_threshold);
> +                             dev_warn(adev->dev,
> +                                      "User defined threshold is set, ru=
ntime service
> will be halt when
> +threshold is reached\n");
>                       }
>               }
>       } else {
> --
> 2.17.1

