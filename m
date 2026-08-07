Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEB2C5AC7C
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 10:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38CEA10F45A;
	Fri,  7 Aug 2026 10:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q85fttSC";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A442D10F45A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 10:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZ1kTA81KJrrx7oCTM8NvDBLWJIs/oBIWPU+z0MW87aQXXrtVYiPrJXUmUgNDj6TMrGc0eYOsH5f8Gd+IEmsFdGcR6CNoUS8phySa9o+LxNmg0sQMgW6gW1cPBsgD5VdhoCBONgrF7ZXsQ9jsx7dX9t76KXAyyLgKTaEozrneuJwYWgiQ2xOnUkj9ZzH/kZMgA0ZIB6wr4EfJDXXeooxM5zFyVz2TdwyBF2BzyjnienjiGSyofnoNWOeQVQFDV9UqeS6DIgHls/9v0k/QuJoVe4bjmcScGhme3aoXejvGmc/xxvzPlXinrpJ5RNPMSr3WNDHXwYEI9/0Xwbk8LKM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dK7+mX09J+ud1oim9Hs98Yms4lI+DX2WGBTGT8QBSwk=;
 b=YMfn+A2gccQFw+ptHteuCQenUzBUSVtcDzf2Iew/+mt19ce6Velh3+mGHMwzTPMPgNJ/D5HAWknpIzeX58oQdf5sLmGPMwhtV1Oa/aS5Bo9u+F9XvANIaKTB0CIqo7J9kISr91y4bYeB792/liUDd65kSUhtYJCp4H+WTliI9sGWEOArajsK0U560bYdJAhov9Nhz4qLNEguLnZAEZxzi21yf7/SlT0xEFWaDGwm9E2M1loHzP/CEMvR/x2OH8v4shBwllLt599GHtEXGNqyuFYQpjBA8zTs/VEYoz4kWhsHMz3BeilFYN4ntZB7ZSC6dq/pxNJvJjcpLSfrXsUdxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dK7+mX09J+ud1oim9Hs98Yms4lI+DX2WGBTGT8QBSwk=;
 b=Q85fttSCkhT4LnaI940e7F1UmrF7aVSA36tsXaRpkfkDch5nsKP9eoKxctUIkBvSaquF6pGlpKMBO8QiRwIxbD1GcZRmDqxJ++MmuHgn4VHBNVFTKyXa0Q7QSlU2rBR5aTLe07al3CIYAVGKRZSoqy3j8VqzaS/84IXbfxSlUPc=
Received: from BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Fri, 7 Aug
 2026 10:39:32 +0000
Received: from BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077]) by BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 10:39:32 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/ras: set pa base and lfb size for uniras
Thread-Topic: [PATCH 2/2] drm/amd/ras: set pa base and lfb size for uniras
Thread-Index: AQHdJjgdHaJMgsC5A0Sr4u6ZW4A5obaSR0eAgAABfwA=
Date: Fri, 7 Aug 2026 10:39:32 +0000
Message-ID: <BL1PR12MB51274085C9FC2AE87BF8A4F4B0D12@BL1PR12MB5127.namprd12.prod.outlook.com>
References: <20260807064330.3070081-1-tao.zhou1@amd.com>
 <20260807064330.3070081-2-tao.zhou1@amd.com>
 <EAYPR12MB99915843401615506944BE8535FCD12@EAYPR12MB999158.namprd12.prod.outlook.com>
In-Reply-To: <EAYPR12MB99915843401615506944BE8535FCD12@EAYPR12MB999158.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-07T08:50:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5127:EE_|BY5PR12MB4050:EE_
x-ms-office365-filtering-correlation-id: 5e4de435-a26f-4cca-dbc4-08def4702aff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|11063799006|56012099006|10067099003|3023799007|18002099003|4143699003|22082099003|38070700021;
x-microsoft-antispam-message-info: 7PND0JO7p9kRdyJRH6rI8mIypZdXpeHiIuYi9kUD5DS67662voRbfuyjgiCTBzl/xR8waabL74UdLGAh0YJYp7CAzXoluh2PzMXF5ByycKvZSwuHB2jiOKsPygsKEkIf6iGgAVqI//dW0gUM/WE3ubSSXpWNu2uxmWExzxEr0bMttv02Z5LpqJJD6Pi4v3cvTba9+uYv+c9u7IQHDXPEJRdI5mN1/qJSFoDpKTwlllWY/bOLUjqlpl0CWox1gGjVoOVwcfqbJ7yvL7jKpzAvB8CXnZRqRSPl31L4k9HxuXNI6VvWN0YNTINPf7GMEP2ImKI0MukgS68MMAVUn5R6kkc3rkjmuODzu/le3tuZD63KUEGjClcuvxX8IMG7ni5m59UKPKAAdmjJJNHimSOhf5zzUKSLMZaMolVlsJ6f3ybTFT9XEFPq7YYF2RcDOZo0flT5eKzANDUb1jMVmxBuV0UZivEnhF3B1OfPNcTd6AHcrAPckTEixjWa7vCD3CyfpahfzWhW5YAAHKV+zESHcuFmcVmaA11B4hJDdSM+5b2MtjQuaAu7abFLqmd4EcJsUDM+7heygqmhKosmmiuwcoyRRqGzswhUGZItkrK0T97nvEuTPX3HSqT1qPXDbbldAuqwH1vjFqWJq04iT/F7T6BkGlaglLL4tU08KnElNtcb/QxnjKfJCWKzqH/5OYkaGtIZCc3Xpf6Z0CBfykPduiXSH7fXQpVJnJJBYN+kEFQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(4143699003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Y9/ySygYS/HbIVZY8RC2+DvawIqsWgVnLBStUl2LRqhfJ7LYpiCNB0J+aYs?=
 =?us-ascii?Q?mSqOtd8BrA36t72ExJQqasVICxyOxBFBA7idPEf747WR8hwELRxjZYiCamGh?=
 =?us-ascii?Q?KM2MpuA5c3RwgnriHWT4SEc3trQZMBWBbAYzUlcMEOztpYmLGvzEZfliG9Lb?=
 =?us-ascii?Q?gBiiT2ondiFRb6j98TdJeCkKktBIR/Qu7X3kSIt9kQ34NLmo/XKMypbMz9/S?=
 =?us-ascii?Q?OgqrQYqSWOezE734cgPXx/dmxhHtwXp1NzDXgwyc/SWYYiwInIthxyaBPyKR?=
 =?us-ascii?Q?NMd3hfbCzF3ONrVR4u3PYvwgdBYWynx1FxtpkfmVM95/fnkXPZ1LbAvq7kOe?=
 =?us-ascii?Q?r+g7UfgI2640ys2jC/NcolOTEYXO5SOGucn0CwEcF5TKxDxOhKVDaE2hrpNQ?=
 =?us-ascii?Q?jrkyjFMhY5zLqn8Cs6g8EjDHaACjUoxW7INcRawPQizjyFIV38KAx2LKCvqO?=
 =?us-ascii?Q?UK9axcamRNt+6TJTTjHvAiXkipoWyIA+f0Sx5wAfAdjDs2cCCpDNmcxX+gJN?=
 =?us-ascii?Q?1tznir7DkbABVbmb9X7FfLDPgN51q/PTJjqG+C/F8PAIQyBYmAXmzUTXrBnD?=
 =?us-ascii?Q?zfT5D2VNHjgYRYQMIl4H56IMRR8vuMaEm0u12jeUZ4aWvn2n/DhahKlagoVs?=
 =?us-ascii?Q?Emr7+seWayrFlMZCj6h6FS09VD5qmBAWikPj3MkZwmPjyoi7Vvu+i6c5K88t?=
 =?us-ascii?Q?MYVZF20MO4PttoHIlQIT3psMRJg3zWfMdVcPb3r/Ht8zQKcgDfnS3oQ222BC?=
 =?us-ascii?Q?xh/BVqvRCybK4xZHNpD8xdq4qHBomnEAZhhxTM4rr+UpStejpwp+YiqNX/8Y?=
 =?us-ascii?Q?Fnou4yFLhJTnwR259M9d09+0mKFrFUoJ6JnVD5d8aHZacH9i0fAdr6idGO9B?=
 =?us-ascii?Q?tsMICeumlmrejenPGrm0AezaLjm3oG3OVHfSozS8OgfwnMCkI74S7J5ecrU9?=
 =?us-ascii?Q?j8UAIrB3txWy35mv9cVl/fK/91JHlWv5kYHxTz8TOTCIw39X9D+uV8xXvy8z?=
 =?us-ascii?Q?ecXoh6Zndp2UE+MhfS89fZGjrjd5i8qEkz1UMKTKQW9CoGkAHKmAPzXcK932?=
 =?us-ascii?Q?drt7R8wivj1QxC2J33KbdGfCPoRsVPNjxBKoiqEvCZyKvlS3btgoYSAwxAM0?=
 =?us-ascii?Q?J6Hr0yQmsiXoJuJXROIaJqyO5lWFGfWu0SLjZs6/nm4eJTGnw19C5wschgq1?=
 =?us-ascii?Q?2Ay+1kEjmtrbPvwT1YFFrYCyznHHHA3p+4QACzo/laMjl/xEdQcDnmo0qZWo?=
 =?us-ascii?Q?2FE4C6hISXqpOJNR93oG18VSEEh51bwC7V5p6aKZ5xc6Hk9dV7rVZ1rl90Zb?=
 =?us-ascii?Q?OXx26eWEEjQsQ0fN9iZm0g5ri1hblw5jWlgaybfA87OBmL1AfkAmKuSe2Gko?=
 =?us-ascii?Q?eMYf/vIdUcXrMqJ29Dx2uVsIVoSUuBIAudZybYot5ix15/SF0k3XQjaWhn3a?=
 =?us-ascii?Q?Hi6jhURSC47Nip11T2TpZ1q5WWEiL88giadGBciCzj7gGFNfLRKBjan/J3m4?=
 =?us-ascii?Q?EbN97dgvs5HRhR3EiZx/mFbdo9370++lWIKPjG0gR4c0Eu5T2/aA7fcQV5di?=
 =?us-ascii?Q?QU7XMz6EYHjj5pgFLMXdPVQBDTEF4VB50DoVGpt2Cv6UUoNPJW8F9kAbTtAa?=
 =?us-ascii?Q?aFGDHEAfsFKUF9BxuI6wz5rSU7WwlffeRluig/JbvF1DI3uMqJYjqJgGhaBj?=
 =?us-ascii?Q?QzyeqHqD0vFFPRHWKf+DDLofa0BO8+hzOpBWcXYoDokauEKK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4de435-a26f-4cca-dbc4-08def4702aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 10:39:32.7831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikVYiIdPJTIysSgjqAQf9/wImmASw9l+NYJk68Y1Rs8fua72KdQ5YjHQAmAjvr9e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
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

Hi Hawking,

vram_base_offset =3D mc_fb_offset + amdgpu_xgmi_get_relative_phy_addr.

Regards,
Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Friday, August 7, 2026 4:51 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 2/2] drm/amd/ras: set pa base and lfb size for uniras
>
> AMD General
>
> +       umc_cfg->pa_base =3D amdgpu_xgmi_get_relative_phy_addr(adev,
> + 0x0ULL);
>
> Can we use vram_base_offset
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zh=
ou
> Sent: Friday, August 7, 2026 2:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 2/2] drm/amd/ras: set pa base and lfb size for uniras
>
> Avoid hardcode, get the parameters from amdgpu.
> For the algorithms of ras address conversion and die id calculation, not =
only pa, (pa
> + pa_base) is also needed.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/core/ras.h            |  4 ++++
>  drivers/gpu/drm/amd/ras/core/ras_umc.c        |  7 +++++--
>  drivers/gpu/drm/amd/ras/core/ras_umc.h        |  7 ++++++-
>  drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c  | 20 ++++++++++++-------
> drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h  |  3 ---
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  2 ++
>  6 files changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras=
/core/ras.h
> index d61c977b07cf..e0ed6a3ce168 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras.h
> +++ b/drivers/gpu/drm/amd/ras/core/ras.h
> @@ -278,6 +278,10 @@ struct ras_psp_config {  struct ras_umc_config {
>         uint32_t umc_vram_type;
>         uint32_t num_umc;
> +       /* socket xgmi offset, base address of umc physical address */
> +       uint64_t pa_base;
> +       /* local frame buffer size */
> +       uint64_t lfb_size;
>  };
>
>  struct ras_eeprom_config {
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c
> b/drivers/gpu/drm/amd/ras/core/ras_umc.c
> index 95a98b411fc7..2dc1c0b6ac49 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
> @@ -411,8 +411,9 @@ static int ras_umc_eeprom_rec2nps_addr_legacy(struct
> ras_core_context *ras_core,
>          * only ever existed on NPS1 systems)
>          */
>         if (ras_core->ras_umc.ip_func && ras_core->ras_umc.ip_func->get_d=
ie_id) {
> -               die_id =3D ras_core->ras_umc.ip_func->get_die_id(record->=
address,
> -
> RAS_PFN_TO_ADDR(EEPROM_RECORD_UMC_ADDR_PFN(record)));
> +               die_id =3D ras_core->ras_umc.ip_func->get_die_id(ras_core=
,
> +                               record->address,
> +
> + RAS_PFN_TO_ADDR(EEPROM_RECORD_UMC_ADDR_PFN(record)));
>         } else {
>                 RAS_DEV_ERR(ras_core->dev, "get_die_id is not supported!\=
n");
>                 return -EOPNOTSUPP;
> @@ -855,6 +856,8 @@ int ras_umc_hw_init(struct ras_core_context *ras_core=
)
>                         ras_umc->umc_vram_type);
>                 return -ENODATA;
>         }
> +       ras_umc->pa_base =3D ras_core->config->umc_cfg.pa_base;
> +       ras_umc->lfb_size =3D ras_core->config->umc_cfg.lfb_size;
>
>         ras_umc->umc_ip_version =3D ras_core->config->umc_ip_version;
>         ras_umc->ip_func =3D ras_umc_get_ip_func(ras_core, ras_umc-
> >umc_ip_version); diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h
> b/drivers/gpu/drm/amd/ras/core/ras_umc.h
> index af76de70ddd1..13d715c8553f 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
> +++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
> @@ -139,7 +139,8 @@ struct ras_umc_ip_func {
>                 uint32_t nps);
>         uint64_t (*nps_pa_to_row_pa)(struct ras_core_context *ras_core,
>                 uint64_t pa, enum umc_memory_partition_mode nps, bool zer=
o_pfn_ok);
> -       uint32_t (*get_die_id)(uint64_t mca_addr, uint64_t pa);
> +       uint32_t (*get_die_id)(struct ras_core_context *ras_core,
> +               uint64_t mca_addr, uint64_t pa);
>  };
>
>  struct eeprom_store_record {
> @@ -168,6 +169,10 @@ struct ras_umc {
>         u32 umc_ip_version;
>         u32 umc_vram_type;
>         u32 num_umc;
> +       /* socket xgmi offset, base address of umc physical address */
> +       u64 pa_base;
> +       /* local frame buffer size */
> +       u64 lfb_size;
>         const struct ras_umc_ip_func *ip_func;
>         struct radix_tree_root root;
>         struct mutex  tree_lock;
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
> b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
> index ccdbc5c4bab1..4bf993325a3f 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
> @@ -243,6 +243,8 @@ static int umc_v12_0_ma2pa(struct ras_core_context
> *ras_core,
>         uint32_t socket_id =3D addr_in->socket_id;
>         uint32_t channel_index;
>         uint64_t err_addr =3D addr_in->err_addr;
> +       uint64_t pa_base =3D ras_core->ras_umc.pa_base;
> +       uint64_t lfb_size =3D ras_core->ras_umc.lfb_size;
>
>         if (node_inst !=3D UMC_INV_AID_NODE) {
>                 if (ch_inst >=3D UMC_V12_0_CHANNEL_INSTANCE_NUM || @@ -31=
8,11
> +320,11 @@ static int umc_v12_0_ma2pa(struct ras_core_context *ras_core,
>                 OFFSET_IN_256B_BLOCK(na);
>
>         /* calc channel hash based on absolute address */
> -       soc_pa +=3D socket_id * SOCKET_LFB_SIZE;
> +       soc_pa +=3D pa_base;
>         /* the umc channel bits are not original values, they are hashed =
*/
>         UMC_V12_0_SET_CHANNEL_HASH(channel_index, soc_pa);
>         /* restore pa */
> -       soc_pa -=3D socket_id * SOCKET_LFB_SIZE;
> +       soc_pa -=3D pa_base;
>
>         /* get some channel bits from na_nps directly and
>          * add nps section offset
> @@ -330,16 +332,16 @@ static int umc_v12_0_ma2pa(struct ras_core_context
> *ras_core,
>         if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS2) {
>                 soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_CH5_BIT);
>                 soc_pa |=3D ((na_nps & 0x100) << 5);
> -               soc_pa +=3D (node_inst >> 1) * (SOCKET_LFB_SIZE >> 1);
> +               soc_pa +=3D (node_inst >> 1) * (lfb_size >> 1);
>         } else if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS4) {
>                 soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_CH4_BIT);
>                 soc_pa |=3D ((na_nps & 0x300) << 4);
> -               soc_pa +=3D node_inst * (SOCKET_LFB_SIZE >> 2);
> +               soc_pa +=3D node_inst * (lfb_size >> 2);
>         } else if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS8) {
>                 soc_pa &=3D ~(0x7ULL << UMC_V12_0_PA_CH4_BIT);
>                 soc_pa |=3D ((na_nps & 0x700) << 4);
> -               soc_pa +=3D node_inst * (SOCKET_LFB_SIZE >> 2) +
> -                       (channel_index >> 4) * (SOCKET_LFB_SIZE >> 3);
> +               soc_pa +=3D node_inst * (lfb_size >> 2) +
> +                       (channel_index >> 4) * (lfb_size >> 3);
>         }
>
>         addr_out->pa =3D soc_pa;
> @@ -496,10 +498,14 @@ static void umc_v12_0_mca_ipid_parse(struct
> ras_core_context *ras_core, uint64_t
>   * umc number: 16
>   * hbm type: UMC_VRAM_TYPE_HBM
>   */
> -static uint32_t umc_v12_0_get_die_id(uint64_t mca_addr, uint64_t pa)
> +static uint32_t umc_v12_0_get_die_id(struct ras_core_context *ras_core,
> +               uint64_t mca_addr, uint64_t pa)
>  {
>         uint32_t die =3D 0;
>
> +       /* use absolute PA */
> +       pa +=3D ras_core->ras_umc.pa_base;
> +
>         /* we only calculate die id for nps1 mode(save_nps =3D=3D ch_idx_=
v2 =3D=3D 0) */
>         die +=3D (((pa >> 12) & 0x1ULL) ^
>                         ((pa >> 20) & 0x1ULL) ^ diff --git
> a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
> b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
> index 268db10dc6b0..f6f7f827e06f 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
> +++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
> @@ -300,9 +300,6 @@
>  #define UMC_V12_0_TOTAL_CHANNEL_NUM \
>         (UMC_V12_0_AID_NUM_MAX * UMC_V12_0_UMC_INSTANCE_NUM *
> UMC_V12_0_CHANNEL_INSTANCE_NUM)
>
> -/* one device has 192GB HBM */
> -#define SOCKET_LFB_SIZE   0x3000000000ULL
> -
>  extern const struct ras_umc_ip_func ras_umc_func_v12_0;
>
>  int ras_umc_get_badpage_count(struct ras_core_context *ras_core); diff -=
-git
> a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index c55288c2df9a..c58fa0ef8a80 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -285,6 +285,8 @@ static int amdgpu_ras_mgr_init_umc_config(struct
> amdgpu_device *adev,
>
>         umc_cfg->umc_vram_type =3D adev->gmc.vram_type;
>         umc_cfg->num_umc =3D adev->gmc.num_umc;
> +       umc_cfg->lfb_size =3D adev->gmc.xgmi.node_segment_size;
> +       umc_cfg->pa_base =3D amdgpu_xgmi_get_relative_phy_addr(adev,
> + 0x0ULL);
>
>         return 0;
>  }
> --
> 2.34.1
>

