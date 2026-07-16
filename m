Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526D6C44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 01:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B259410E180;
	Thu, 16 Jul 2026 01:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4b9+z+29";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 391D610E180
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 01:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXyz4y1ZH627nQzwjTNJ8LxPOwm5YWAt8YwiHxmCg10/sWNNwUoGq2//faAzTr6qkJeBnfHA+SODdngWjorFu8iYgQS0gPoZGXxjPvKySO65HcJeAEwb6fYOWK4Pb/ykmW4lPUcVKSkMVSMmqFzyljsBG9aZZGAB12GyemLjSx7o9DNndWgjpw6GHUHb6yfxqK4YaEqA/J+0SXDCjw4aChlm5JWBnZotv+uBOSkdyahKvvHb4Vi+d+tCL8oTD1sPtn7NTwbhk/hGVNlKQa9rlDsBTbdRPNNmBju8K1eibCmVlPOkK2yDj+rQGf2xgJw6Gbc2EP79LIaK2Q0mmzr2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDIuzf7wV/8liG6rhK7ae2+9ZNfIov3lBSWutQqRfAc=;
 b=DOuAgrilKPOPpPTwvqLNCufQ8so15WL2yVPARjUdlPbm1c3+v6QctSd0FhfsyiQQJ5xmLruqOy1er6zi7kHqWFmkPbp+xzKp0iSeKGm0pgGuf7Q1j/XjPiD86I3SO4yexzHidWQGQ31FrFrTsf9iSrq/CBADPcxgTQUao+HA7UPqlJ30FpxD+mrH2GuP0PMLlGETR/8IaZvsGyFj8SPgtemCKHIGYbIrbsLb9TMQxO63RdG5QfMRs8W0ZieDJHSMhCaF7rUUG2TlzoBo0Beq3WCrNChMu7XbTI5emL7eSIbABghPiCZgUJQx9vv6rtqyL6DuMW1LY1XM2FXSa3WFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDIuzf7wV/8liG6rhK7ae2+9ZNfIov3lBSWutQqRfAc=;
 b=4b9+z+29MiN2jf+mSIxRC3yXeKWyGTZ2Wc6Db6YXACE2LeA6VurAU+j9yFJvXSRccTC0FM4xU474uvtyj/kq48b3J6c+DtbAiUqeHKI4QXtgnNAyT2T1aHlTQ0+P7SjtCUvI205t4yrGiEsB9YwrIERfzDryQBfKXiCKdPWtPic=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 16 Jul
 2026 01:50:26 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 01:50:26 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
Thread-Topic: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
Thread-Index: AQHdFC5EatDn7xZDSE6tLIxz6GOH8LZuPweAgAAIbACAARidgA==
Date: Thu, 16 Jul 2026 01:50:26 +0000
Message-ID: <BN9PR12MB5306E81D6FF9283352A26382FCC72@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
 <20260715074734.2668631-5-tao.zhou1@amd.com>
 <BN9PR12MB52575849F098B6FD36227AB1FCF82@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BL1PR12MB5127187AC95C256DB499E271B0F82@BL1PR12MB5127.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5127187AC95C256DB499E271B0F82@BL1PR12MB5127.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T08:25:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|PH8PR12MB7159:EE_
x-ms-office365-filtering-correlation-id: 9327b4b9-a79d-4eee-eb18-08dee2dc9b88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: HMPCm+nIwa4vDIPvA/KwebLhLzy/Dgdy32icbCC+7dPLTnIuwY7H83I3mQXpfD2k4JWUMIeIErP47hsdT3+giJn3lquJuZaIaRRhGT7DqjAOludJpRm+HfGfdN+eoQdUl3cbmSmUwW3IWnS6G6uC+pcnkBVkZJmU6utUuA+XiK5D+qVnJtrF9iZgZTTxbM2UTk40uwK5ctgZbmyuKDjTtWSYORWvpwo8sEYb9G+eOlEDBk4qetP3q3yrGoGjM4m0TtseeVtwLmjBUt0XoBsHzZUXUDSvvMANkmA4JzFi+x4AJGjPE40NaRu2akIhBGr3I560zgzE5S7zOaoNhSZf5+bxKNS+jfc1WSdI9jt6WJ/KY85H+5eYI5Jva7hDgMFOqvDYyj4mnavV3ECf0lIrKWCdOk37eC6pGJ8kDQe2+4mllmCjLTEowQyt1Ij6+xtWWviFw+i0fd76ipMgoEfZvUTq4CrQSkNNBTufuhdHWnijvXSqOyMK3iiMG7tb5mPeyqv/zH2es2DxhG1twRin8IB4hFmRbv7i8MrqsNmU0zSYQIJypAFtjlbPjpy08rTvbA4BIs61rmTR5sDzMvxF1LY4EtLbcss8MVcVb59BduFhFUngZj+BJp+xI2d2lKlbHBXJF2/+zaiWrNhU4QlgOlyodYVlnW0Juqs5CLolLuqMBcnVB2dAZ0t0BSAGT+RknE49sv8HXq7uFAtVBn3Q6KmhJyLVVnDje07E8P4Q2Rc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?POF3fdKIVc/2/EcBwheriTQzLq5kjPh5Lp71BaNHd03TlP7cpEE4gqvOzpst?=
 =?us-ascii?Q?ZMy6LX1ZnaPFmj4UAcfbxrxjMSvnGK7Ed4DS6v+hO0hDpEc/zBLbMRBGuANj?=
 =?us-ascii?Q?eJ8tgLqBEpHHTKK3ovR1t9Y7L52mm0QzmRCkiWxi0SQk0FI1I5k/YwT5r8ZG?=
 =?us-ascii?Q?GglwyFydrnT+9xKScqsNb9NXlYk/ncNeRJ9KIpIt0DUTmWPHxYSb3KAkEaJ7?=
 =?us-ascii?Q?NZaaCeDiBDPYh4lobahebiHxxBKuspttuETV8tRhx6JziGatqdlZks92yhC4?=
 =?us-ascii?Q?pvSzeYeosFiHpS+RT5eX70yG+Uc5mAJqzd7AesYvzUs5wjehLbapnSmGU4Ya?=
 =?us-ascii?Q?srsyhLXTNxPdZGxiF6+jIBcvT+zJ/8KficqZvKJBS+BaR/WL9eppRU2Inl9j?=
 =?us-ascii?Q?a9Dv/NQ08dZnRlkAitfLPJyQhiMISWlNEBGf81n6LMThWaQiI6FWRxhNfpRU?=
 =?us-ascii?Q?P/JHmkIOj26FqaFfAMG7ES3Bu3BgzI4h5CoemIcYmdaJ3FMZvoBTs4PPTIjT?=
 =?us-ascii?Q?NxlfSVmAf8M0JWv1CyvW4dyVV91HroCoeRfFoNl2KbTlLx9CPHHQR8SBW/K5?=
 =?us-ascii?Q?U8+h2m61djy2IRpNf9mSGecppCkr9Eb9kwUADaMXyraPtkCkKXfIIFVOPvQU?=
 =?us-ascii?Q?z5j0y6xfjqNBT4ZzypryS0O8LqtMcDKPlvcIQCTOQ766ttfJqQLvoKeJRfbT?=
 =?us-ascii?Q?5ny2N04IeszZWfe522k/9qYGnHP850BC9RrGKtt0S+oZR5ZlYNZR6k7yY5FW?=
 =?us-ascii?Q?7Ww1dFvH7D5+oeYIeVPM3Pk+JGB9f5qf6CsT/xMCV1ludAZuxthICGyb/jFX?=
 =?us-ascii?Q?QpqUDjWKuueQBqcO7xaO7cdCJKvF3aYrkHNKlu750gOK6A3s/h4lyuYiUkzS?=
 =?us-ascii?Q?vSijSqXZvUGWTHy3fOH73o3ZQrIBbPZA81GUwpNc2U1oF0Oj/NStkpQF8vKa?=
 =?us-ascii?Q?6cNZlm2EH7aZCZ3NOx6JfFKuYtb5Jj4qIMA5YoiJM3z4G2BoniCPsExZBKsE?=
 =?us-ascii?Q?21q1yyxS98IvP9V5pMfJYu2T64WXtMv3RzowIfV8uz65EkYnhlOdBB62iTCp?=
 =?us-ascii?Q?kKkpX0X6Uf9Iz4mWblOiHxEuYicIKBBCDpAD6gauUeS426gp5NXECaCFAhiT?=
 =?us-ascii?Q?/fKyympvGzuL7W34eq4u01veQumZL31p0psybuMhmDaFt9E+SL54+SEMOzLm?=
 =?us-ascii?Q?touswAGT44hG7zLaJzNrlMe6HIVxOyBZVg1+VVpr8vVhYpuHdo+hFgK3oRzo?=
 =?us-ascii?Q?AOS9mOC+hFcY7Rk6fwf6X4fPgyJrvHrEXX/6bAN3BKRxsPZ2QXERfscfhu0m?=
 =?us-ascii?Q?I7pMnjR21x04Lfd+mVsXqYrSb53OKiSR4leY3ajdhSXwH1i+LCeMfeskxm0y?=
 =?us-ascii?Q?8cUz66m2Oavsy53OyJ8b4EclaIz2SqILYnenNP8jA4DR9GjPYo1orAk6/tZl?=
 =?us-ascii?Q?ToFssr8qmgqoBKeWeetBN4dCLiWyL0/6fT3gsK6YBPOCnmYaXEnOdWDg7zRY?=
 =?us-ascii?Q?m57l83qazNvqBS78I0LNduK3b7yFiAf90V8aL6Elv1g2psfT5cVNoLBJ7Wpy?=
 =?us-ascii?Q?aqb99U+uG01HNqw8Z0ULp/dUoe0TIgIWZoCWCUjxIBNushS1vUL/gz5VpsL5?=
 =?us-ascii?Q?an6cBIQM4CIcUhapLiLzTod9szQvkg5OZKkhEAEP+J7UQdiNWHnBTz7qzW0e?=
 =?us-ascii?Q?dFyWxc+v4BdOuP4CrEUU2OrDQKHNwavsgK88lgoQjJUoirmi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9327b4b9-a79d-4eee-eb18-08dee2dc9b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 01:50:26.2772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKazrM4FzXvZi1Kw1GVw0mP+UyavsFUbxKmyXah8rkKeqvEBOL72k0ORewCSpUN+YW84c+ns2FVHh+LIo1HMSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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

Best Regards,
Thomas
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhou1, T=
ao
Sent: Wednesday, July 15, 2026 4:57 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras

AMD General

OK. Since Ce is working on it as well, he will refine his code per my patch=
 and your suggestion.

Regards,
Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, July 15, 2026 4:27 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
>
> AMD General
>
> +       init_config.debug_disable_ce_logs =3D
> + adev->debug_disable_ce_logs;
>
> Let's pass the full amdgpu_debug_mask to ras core
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Wednesday, July 15, 2026 3:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
>
> So we can disable ce log manually.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 1 +
>  drivers/gpu/drm/amd/ras/rascore/ras.h            | 2 ++
>  drivers/gpu/drm/amd/ras/rascore/ras_aca.c        | 7 ++++++-
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 1 +
>  4 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index c55288c2df9a..1e95419989b4 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -310,6 +310,7 @@ static struct ras_core_context
> *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
>                 amdgpu_ras_mgr_eeprom_is_supported(adev);
>         init_config.poison_supported =3D
>                 amdgpu_ras_is_poison_mode_supported(adev);
> +       init_config.debug_disable_ce_logs =3D
> + adev->debug_disable_ce_logs;
>
>         amdgpu_ras_mgr_init_aca_config(adev, &init_config);
>         amdgpu_ras_mgr_init_eeprom_config(adev, &init_config); diff
> --git a/drivers/gpu/drm/amd/ras/rascore/ras.h
> b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index 5719bc1b6167..9d538a07c50e 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -301,6 +301,7 @@ struct ras_core_config {
>
>         bool poison_supported;
>         bool ras_eeprom_supported;
> +       bool debug_disable_ce_logs;
>         const struct ras_sys_func *sys_fn;
>
>         struct ras_aca_config aca_cfg; @@ -348,6 +349,7 @@ struct
> ras_core_context {
>         bool ras_core_enabled;
>
>         u64 ras_fw_features;
> +       bool debug_disable_ce_logs;
>  };
>
>  struct ras_core_context *ras_core_create(struct ras_core_config
> *init_config); diff -- git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> index 67a35409ff0e..9760894c4c66 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> @@ -98,7 +98,7 @@ static void aca_report_ecc_info(struct
> ras_core_context *ras_core,
>                         blk_name(blk));
>         }
>
> -       if (ecc_count.new_ce_count) {
> +       if (ecc_count.new_ce_count &&
> + !ras_core->debug_disable_ce_logs) {

[Thomas] Can we replace ras_core->debug_disable_ce_logs with the function i=
nterface in sun,ce patch?  The other changes are the same.

>                 RAS_DEV_INFO(ras_core->dev,
>                 "{%llu} socket: %d, die: %d, %u new correctable
> hardware errors detected in %s block\n",
>                         seq_no, skt, aid, ecc_count.new_ce_count,
> blk_name(blk)); @@ -
> 114,6 +114,11 @@ static void aca_bank_log(struct ras_core_context *ras_co=
re,  {
>         int i;
>
> +       if (ras_core->debug_disable_ce_logs &&
> +           bank->ecc_type =3D=3D RAS_ERR_TYPE__CE &&
> +           !bank_ecc->real_de_count)
> +               return;
> +
>         RAS_DEV_INFO(ras_core->dev,
>                 "{%llu}" RAS_HW_ERR "Accelerator Check Architecture event=
s logged\n",
>                 bank->seq_no);
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 2346918c7736..cdef7727decb 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -377,6 +377,7 @@ int ras_core_hw_init(struct ras_core_context *ras_cor=
e)
>                         ras_core->config->ras_eeprom_supported;
>
>         ras_core->poison_supported =3D
> ras_core->config->poison_supported;
> +       ras_core->debug_disable_ce_logs =3D
> +ras_core->config->debug_disable_ce_logs;
>
>         ret =3D ras_psp_hw_init(ras_core);
>         if (ret)
> --
> 2.34.1
>

