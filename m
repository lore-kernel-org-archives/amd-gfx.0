Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FCDC4451B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 23:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CD710E4EA;
	Fri, 17 Jul 2026 23:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fq8jwrzP";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C2710E4EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 23:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfCDqo0UCdnIyYVT5VUOeDplUFwXf7uxrRYwBQ8F9+Iy9DIaCsBBmtlFlwuFh6k+B/9N8YVzMBFYSVwJKpg385mFUDyYJe0Teoq6W43tKeTSzbPF9Q6c48WrScc21XL3EOEjc85XGhGj5K2+eiCa1fEQnZYnN60IPkCNUyuh4XEixxxvNxPsu6l5H0fmfeUdo3gRO5dDpZVPpMon8mzOW7RepwGEtHq7EuiJ2tcrxoj/+3iQAeJl/o9Xn3FjsdOBwRsGg7ZmQZJQ3GiSTAect1HkgcISTiQnK0EU+ZWPQiNi4Vbzdaa87oqZ6FwZ/rhYP8Zd0z1uy14NEtXP/CSZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UkyQZViAhqamp1cgw407Uusq2FHCUZChEdpMAsp/DE=;
 b=y+qUisB3T8SpGXGF4siZb+Re8EAJ4grF12jd69GkxSX2dNukgf4i1qjIoSvvOcA/AM3F4qiaQhlfb3mD2iGDdHsouU8/K1f9W44WqCvtzw83TmeXtfHLL8tdVuAAB+9eCVzna4frqiJVskH6n+vlBKSlQWvY+ugWnGON//vYrpy6jzX1GRgtl4NnVWeRSXpLdECuCkivBW+HdWxLNFNNtyvrNkTKDYozphDQyLaT+jUjf0n9oLwEH6EgUG+z8WWCtrrpJ0mGPS5j/4j3RS58Cj8yd9Oc67eLLmG0xeBGtYBNxhxYIfy9MekbdFxHdSGI4vW4EIKX4rhaxKw0bPamEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UkyQZViAhqamp1cgw407Uusq2FHCUZChEdpMAsp/DE=;
 b=Fq8jwrzPUAd6fADVRmohD0Fn9JhNX3FQif73McL+7YP9YYBhYL1zeWY+JLq9vfXo5lcj+yGrbcMe4IPLoFYwn5EsGHFtQClrI3G0Dk+3bSGBo1hYCcVBk38d4l02fH7UpwVoVocEx4N3PcnVv6H3CJ2msaaphCzBSGXSoVhtt54=
Received: from BL4PR12MB9480.namprd12.prod.outlook.com (2603:10b6:208:58d::7)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Fri, 17 Jul
 2026 23:06:07 +0000
Received: from BL4PR12MB9480.namprd12.prod.outlook.com
 ([fe80::ac26:ddc4:4659:b2f1]) by BL4PR12MB9480.namprd12.prod.outlook.com
 ([fe80::ac26:ddc4:4659:b2f1%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 23:06:06 +0000
From: "Soliman, Fares" <Fares.Soliman@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liang, Richard qi" <Richardqi.Liang@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Topic: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Index: AQHdEss7rMXd478p50KeJIbebVUkB7ZyPpaAgAAcPbI=
Date: Fri, 17 Jul 2026 23:06:06 +0000
Message-ID: <BL4PR12MB948066C4AA3E7F79D3569773EBC62@BL4PR12MB9480.namprd12.prod.outlook.com>
References: <20260713132624.1173426-1-Fares.Soliman@amd.com>
 <BN9PR12MB51464FFC1E39FC0777D45524F7C62@BN9PR12MB5146.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB51464FFC1E39FC0777D45524F7C62@BN9PR12MB5146.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-17T21:20:06.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9480:EE_|CH2PR12MB4134:EE_
x-ms-office365-filtering-correlation-id: 91bdea3a-920f-47af-6bc1-08dee457fb77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003|8096899003;
x-microsoft-antispam-message-info: PpqlmNr5O9VvPYXd/DysefNYZJ/BbqSJL+9dneDcDWbgd6soT/MdG5JwCbS9SP5evl1UQsdS10EFH6eIf9NCRKfJXFH5Gdc3E3Y0xjpXQw1VDYvM6fFEXEgYAm40efK3PEy9xaf1uj+4K8u8MjXKBvmQvTSJI8Rbu06SOlbqsaHh8OQ2YFHkPXEjSnanpC3ZEUZ6s8FrPyg0nIGVSWylPh4mnZpuqh3VUYiasWcRQtbMZzBjLJso28ebIS2vWRUCIoU2SIMTBOANSTAx8YT0B1CLy15DyqYX64KMw3E2q8a6+7vTxFNAprMyp1POtg2dy+So2hli5532mwU9FfFGGw64mMNRXfcLZJnu0HU0PCjvf9yLsoZ6L3d3w7i+appSFxxLBuolWrBc52NYE+ZB7ItUJNz0AcSzh147fHcpXR6opH/KQSz9PNyDb5U3YhSJ6L3YJQFx/bq7Cs7MZlaqVYi1jvixsOtDPeQ1wu4938vt6WIvN/PzYOAhG9dbGcY2XKGoxxO8WclJfyc2ataSwCQm6AQAguyCgMr5vOekwJkIIF2ZYKR+SEZnGuO1Ho8G7cbSfA+WHSYuMxF5xvgBvjLuGrke+xoeBCii2EJPnyQVcPA9/oy+5StNo7XMTjh0aHKbvhuplNX8L4AamB8m7KZ90yDs+YOZeXkOQrzcWwAYw7aC6nCz3HE6STVLenNIKWoOKarVKXGSpRVfP49t/Ykg7tYt+E0IeENSxs5TC5w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL4PR12MB9480.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MvFifWp71OmNV0yCZdC9MYz4aYGyTW8qReD1OVN7/GYfSeahyELw+hvYGnU9?=
 =?us-ascii?Q?NGfb8jwHmtZYmDbQXXp4+OiSC+rzNd+kDWm3ah3eubAeCF8GfmOzl+wMsTIL?=
 =?us-ascii?Q?tNNOHT752hVD4TOEhVNibrbnblWEvBtfMybZNFyfYXUzssBmSnkQu46w6H+R?=
 =?us-ascii?Q?K6nCWvdtRuu+/knMzDFOMBa+p2vjNFAOzt9E0VHoueu2e1JpflCRN3ho1zPR?=
 =?us-ascii?Q?Vs63YCmO4o9lOMjESiv/QwUvkL/2vjsC3+4x1inp8g8oPenk59GF6bnv6mqu?=
 =?us-ascii?Q?Vql2bXAOlxd4KfIC41F3NxBa20e+3sK3GCaBFDuMm4rMxzYfAU7CasfFurVo?=
 =?us-ascii?Q?rKatI/JrC7EJIl9ZC+u4pXNgp817JWftKV6YpK+JRNgDz7+Qu+UGNoamBsXW?=
 =?us-ascii?Q?9qZaojfSLFBShDjjc1hBHcbhll8l6XSJhc/M3IqWO27coIn4Bi03W60BCVDf?=
 =?us-ascii?Q?MgbocVPn+qarlNNw4suVh0iy5rPT8pxOaXM+WB0XcV60vjLSlg6vCsuarAX2?=
 =?us-ascii?Q?LEEUCd8PeQGU1jrw1Pfhlr7FcvroOOM1qyBNZGKc8M9p7vhgZu/8Mw0AH7fG?=
 =?us-ascii?Q?FQKi6fqG0FNCHgJ0mPn4Bu4E0aqa1l7EWD18jOnObHXRlpIfGduzoCVFQt0v?=
 =?us-ascii?Q?18WVltsKyd80In9JZOMTJV4eV+dL44l9ykzBhWVezi9tjF+JtQ8yvmgk/dPX?=
 =?us-ascii?Q?mft5UUhJGZG+f+MeKlSugIKAlhUtXDtqE5T/Hf/5tW0q2MsgEtRu9rZ3BzFr?=
 =?us-ascii?Q?I4E2X53DF+Z/1SaVVBy91RcK7DCD5JU0iMoJnRNKEPL40U+7qQG9QuVgnR9P?=
 =?us-ascii?Q?SZjHmxfLaJoa9Prh6PaTqyp+LwT7XzSjiutiTgVce7U5XTT/lbz0dTRsH7DR?=
 =?us-ascii?Q?ukLUr35LPsgqpqBqKZJGVA+X0CG2w2fUkZ9ecAi378Rhll8D+UVdXpYdIpbO?=
 =?us-ascii?Q?+CKoAFSxbH4MIQnp3j7k0A5VWXO33QhQpoTRf0+UrCPxrVNDIFs4plNtKl8C?=
 =?us-ascii?Q?B1TmGDo8gB8FHbmHYzV6vsg3jA+S8hgmAxaGgegpqdY2rxHmeNlAbz0FOcGr?=
 =?us-ascii?Q?gu3gjeVDCuobOPvDAwnOjZVCnE2NsiX1e1kd+2tCRf2z673d/2JvRG8bncU8?=
 =?us-ascii?Q?6GxLDlzZKLA69WDlUw5kDx7PRMw/9vc8JJtT0xuOlw+eglJ7+nt7myK8tGXJ?=
 =?us-ascii?Q?gBLaDH9ncxCetp59AsJW/USZBF6OdBKp1yr9fClfbgBOtwCxmJS2KFeeMDFh?=
 =?us-ascii?Q?yseb1lMtVLbAPP9DgdGT3W/4QrWGVRyWpxtZ5V0xXTjRvizhc0tVdElIRyrR?=
 =?us-ascii?Q?jAWXNuDN9KFjizM5sw+W6goXDaSrhkkAj1J1joYbcBC2AnbNSL4Kb5ZikVLQ?=
 =?us-ascii?Q?50jWCoPAmF6hLsa6n8OPy51IEtUvczYZF1ZMGSNmuWfBvnpr+m1XH26xBzLH?=
 =?us-ascii?Q?ZRm0P1FgCISJf3AsdF4we10aY4rYEQDrQJCHLZ5n+6GEAIag2q0L92C7+VvK?=
 =?us-ascii?Q?pxL/yWuSVKbdXW4ExmzQXoopBx3NmtGcxDoKg47KdLCNXHaZ5RBIUdAjVqLF?=
 =?us-ascii?Q?VCKw8XgXVvHfPS+cfnqJnJKOjCJqU8fSYJGFKZA1vFR+PuHJHcBMCjDEbsyp?=
 =?us-ascii?Q?/17Ob8iSgHDU5kubCpwDVgg6PSy+e0OI2oelNc7aa9cayj0Nm5cLCANvcND2?=
 =?us-ascii?Q?5R9hxxl6vsl788sLJM4IIMHnvwMw0d4QA8BnSxuqFn+H/hz6gJER2sRDNtbe?=
 =?us-ascii?Q?a3nRcr1Iew=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL4PR12MB948066C4AA3E7F79D3569773EBC62BL4PR12MB9480namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bdea3a-920f-47af-6bc1-08dee457fb77
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 23:06:06.4867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8QLxDQYBiAH+iSmU9WGRkI3HkZbhu+PiuiZd44EPtCL7darNS8kU42opMDA5I36EfoLRIt2CqmwhfbwxHZyQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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

--_000_BL4PR12MB948066C4AA3E7F79D3569773EBC62BL4PR12MB9480namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Public

Thanks Alex,

Forgive me if this is obvious, but is an Acked-by tag sufficient to have th=
is pushed or will I have to get it reviewed by an additional developer?

Thanks,
Fares

________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, 17 July 2026 17:20:27
To: Soliman, Fares <Fares.Soliman@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Cc: Liang, Richard qi <Richardqi.Liang@amd.com>; Soliman, Fares <Fares.Soli=
man@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly=
 gather GFXOFF residency logs

Public

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Fares
> Soliman
> Sent: Monday, July 13, 2026 9:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liang, Richard qi <Richardqi.Liang@amd.com>; Soliman, Fares
> <Fares.Soliman@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
> gather GFXOFF residency logs
>
> Updates PPSMC_MSGs and set/get functions for gathering GFXOFF logs on
> Van Gogh. Logs are now gathered live rather than starting then stopping
> logging and reading an average value afterwards. This is in accordance to
> changes made in PMFW.
>
> In regards to messageID 0x52, the old interface uses a start/stop paramet=
er,
> and the new one doesn't. The firmware is checked to determine which metho=
d
> to use.
>
> v2: added firmware guard to new interface, old interface kept as fallback
>
> Signed-off-by: Fares Soliman <Fares.Soliman@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
>  .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  6 ++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
> .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 50
> +++++++++++++++----
>  5 files changed, 50 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 5c4d4ff001ea..46514a1faf1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file
> *f, char __user *buf,
>   * @size: Number of bytes to read
>   * @pos:  Offset to seek to
>   *
> - * Read the last residency value logged. It doesn't auto update, one nee=
ds to
> - * stop logging before getting the current value.
> + * Read a live GFXOFF residency sample from firmware. One needs to
> + start logging
> + * before getting the current value.
>   */
>  static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file *f, char
> __user *buf,
>                                                   size_t size, loff_t *po=
s)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index f8fd93999617..d94e3dcf7f9a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1333,7 +1333,7 @@ struct pptable_funcs {
>       u32 (*set_gfx_off_residency)(struct smu_context *smu, bool start);
>
>       /**
> -      * @get_gfx_off_residency: Average GFXOFF residency % during the
> logging interval
> +      * @get_gfx_off_residency: Live GFXOFF residency percentage
>        */
>       u32 (*get_gfx_off_residency)(struct smu_context *smu, uint32_t
> *residency);
>
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> index 7471e2df2828..4206514765cd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> @@ -110,8 +110,10 @@
>  #define PPSMC_MSG_GetSlowPPTLimit                      0x4C
>  #define PPSMC_MSG_GetGfxOffStatus                   0x50
>  #define PPSMC_MSG_GetGfxOffEntryCount                       0x51
> -#define PPSMC_MSG_LogGfxOffResidency                0x52
> -#define PPSMC_Message_Count                            0x53
> +#define PPSMC_MSG_GfxOffResidencyLogReadSample              0x52
> +#define PPSMC_MSG_StopGfxOffResidencyLogging          0x53
> +#define PPSMC_MSG_StartGfxOffResidencyLogging                 0x56
> +#define PPSMC_Message_Count                            0x57
>
>  //Argument for PPSMC_MSG_GfxDeviceDriverReset  enum { diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 636ff90923d9..acf03838d49d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -252,7 +252,9 @@
>       __SMU_DUMMY_MAP(DriverMode2Reset), \
>       __SMU_DUMMY_MAP(GetGfxOffStatus),                \
>       __SMU_DUMMY_MAP(GetGfxOffEntryCount),            \
> -     __SMU_DUMMY_MAP(LogGfxOffResidency),                    \
> +     __SMU_DUMMY_MAP(StartGfxOffResidencyLogging),           \
> +     __SMU_DUMMY_MAP(GfxOffResidencyLogReadSample),
>       \
> +     __SMU_DUMMY_MAP(StopGfxOffResidencyLogging),            \
>       __SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),
>       \
>
>       __SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel)
> , \
>       __SMU_DUMMY_MAP(AllowGpo),      \
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 717ba46c8933..1104f8b05b29 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -72,6 +72,12 @@ static const struct smu_feature_bits
> vangogh_dpm_features =3D {
>       }
>  };
>
> +/*
> + * SMU support new GFXOFF residency log interface since version
> +4.63.62.00,
> + * use this to get live readings of GFXOFF residency  */ #define
> +SUPPORT_LIVE_RESIDENCY_MSG_VERSION 0x043f3e00
> +
>  static struct cmn2asic_msg_mapping
> vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {
>       MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,
>               0),
>       MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,
>               0),
> @@ -142,7 +148,9 @@ static struct cmn2asic_msg_mapping
> vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {
>       MSG_MAP(GetSlowPPTLimit,
> PPSMC_MSG_GetSlowPPTLimit,
>       0),
>       MSG_MAP(GetGfxOffStatus,
> PPSMC_MSG_GetGfxOffStatus,                                            0),
>       MSG_MAP(GetGfxOffEntryCount,
> PPSMC_MSG_GetGfxOffEntryCount,                                        0),
> -     MSG_MAP(LogGfxOffResidency,
> PPSMC_MSG_LogGfxOffResidency,                                 0),
> +     MSG_MAP(StartGfxOffResidencyLogging,
> PPSMC_MSG_StartGfxOffResidencyLogging,        0),
> +     MSG_MAP(GfxOffResidencyLogReadSample,
> PPSMC_MSG_GfxOffResidencyLogReadSample,       0),
> +     MSG_MAP(StopGfxOffResidencyLogging,
> PPSMC_MSG_StopGfxOffResidencyLogging,         0),
>  };
>
>  static struct cmn2asic_mapping
> vangogh_feature_mask_map[SMU_FEATURE_COUNT] =3D { @@ -2450,19
> +2458,32 @@ static int vangogh_set_power_limit(struct smu_context *smu,
> static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool
> start)  {
>       int ret =3D 0;
> -     u32 residency;
>       struct amdgpu_device *adev =3D smu->adev;
>
>       if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>               return 0;
>
> -     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_LogGfxOffResidency,
> -                                           start, &residency);
> -     if (ret)
> -             return ret;
> +     if (smu->smc_fw_version <
> SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {
> +             u32 residency;
> +
> +             ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_GfxOffResidencyLogReadSample,
> +                                                     start, &residency);
> +             if (ret)
> +                     return ret;
>
> -     if (!start)
> -             adev->gfx.gfx_off_residency =3D residency;
> +             if (!start)
> +                     adev->gfx.gfx_off_residency =3D residency;
> +     } else {
> +             if (start) {
> +                     ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_StartGfxOffResidencyLogging, NULL);
> +                     if (ret)
> +                             return ret;
> +             } else {
> +                     ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_StopGfxOffResidencyLogging, NULL);
> +                     if (ret)
> +                             return ret;
> +             }
> +     }
>
>       return ret;
>  }
> @@ -2479,11 +2500,20 @@ static u32 vangogh_set_gfxoff_residency(struct
> smu_context *smu, bool start)
>   */
>  static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint32_=
t
> *residency)  {
> +     int ret =3D 0;
>       struct amdgpu_device *adev =3D smu->adev;
>
> -     *residency =3D adev->gfx.gfx_off_residency;
> +     if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> +             return 0;
> +
> +     if (smu->smc_fw_version <
> SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {
> +             *residency =3D adev->gfx.gfx_off_residency;
> +     } else {
> +             ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_GfxOffResidencyLogReadSample,
> +                                                             residency);
> +     }
>
> -     return 0;
> +     return ret;
>  }
>
>  /**
> --
> 2.43.0


--_000_BL4PR12MB948066C4AA3E7F79D3569773EBC62BL4PR12MB9480namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
Public<br>
</p>
<br>
<div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Thanks Alex,</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Forgive me if this is obvious, but is an Acked-by tag sufficient to have th=
is pushed or will I have to get it reviewed by an additional developer?</di=
v>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Thanks,</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Fares</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, =
-apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" id=
=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Friday, 17 July 2026 17:20:27<br>
<b>To:</b> Soliman, Fares &lt;Fares.Soliman@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Liang, Richard qi &lt;Richardqi.Liang@amd.com&gt;; Soliman, Fare=
s &lt;Fares.Soliman@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to co=
rrectly gather GFXOFF residency logs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">Public<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Fares<br>
&gt; Soliman<br>
&gt; Sent: Monday, July 13, 2026 9:26 AM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Liang, Richard qi &lt;Richardqi.Liang@amd.com&gt;; Soliman, Fares<=
br>
&gt; &lt;Fares.Soliman@amd.com&gt;<br>
&gt; Subject: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctl=
y<br>
&gt; gather GFXOFF residency logs<br>
&gt;<br>
&gt; Updates PPSMC_MSGs and set/get functions for gathering GFXOFF logs on<=
br>
&gt; Van Gogh. Logs are now gathered live rather than starting then stoppin=
g<br>
&gt; logging and reading an average value afterwards. This is in accordance=
 to<br>
&gt; changes made in PMFW.<br>
&gt;<br>
&gt; In regards to messageID 0x52, the old interface uses a start/stop para=
meter,<br>
&gt; and the new one doesn't. The firmware is checked to determine which me=
thod<br>
&gt; to use.<br>
&gt;<br>
&gt; v2: added firmware guard to new interface, old interface kept as fallb=
ack<br>
&gt;<br>
&gt; Signed-off-by: Fares Soliman &lt;Fares.Soliman@amd.com&gt;<br>
<br>
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp; |&nbsp; =
4 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |&nbsp; 2 +-<br>
&gt;&nbsp; .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 6 ++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h&nbsp; |&nbsp; 4 +-<=
br>
&gt; .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp; | 50<br>
&gt; +++++++++++++++----<br>
&gt;&nbsp; 5 files changed, 50 insertions(+), 16 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; index 5c4d4ff001ea..46514a1faf1f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; @@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct fi=
le<br>
&gt; *f, char __user *buf,<br>
&gt;&nbsp;&nbsp; * @size: Number of bytes to read<br>
&gt;&nbsp;&nbsp; * @pos:&nbsp; Offset to seek to<br>
&gt;&nbsp;&nbsp; *<br>
&gt; - * Read the last residency value logged. It doesn't auto update, one =
needs to<br>
&gt; - * stop logging before getting the current value.<br>
&gt; + * Read a live GFXOFF residency sample from firmware. One needs to<br=
>
&gt; + start logging<br>
&gt; + * before getting the current value.<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file =
*f, char<br>
&gt; __user *buf,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; size_t size, loff_t *pos)<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; index f8fd93999617..d94e3dcf7f9a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; @@ -1333,7 +1333,7 @@ struct pptable_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*set_gfx_off_residency)(struc=
t smu_context *smu, bool start);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @get_gfx_off_residency: Average GFXO=
FF residency % during the<br>
&gt; logging interval<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @get_gfx_off_residency: Live GFXOFF =
residency percentage<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_gfx_off_residency)(struc=
t smu_context *smu, uint32_t<br>
&gt; *residency);<br>
&gt;<br>
&gt; diff --git<br>
&gt; a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
&gt; index 7471e2df2828..4206514765cd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
&gt; @@ -110,8 +110,10 @@<br>
&gt;&nbsp; #define PPSMC_MSG_GetSlowPPTLimit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x4C<br>
&gt;&nbsp; #define PPSMC_MSG_GetGfxOffStatus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x50<br>
&gt;&nbsp; #define PPSMC_MSG_GetGfxOffEntryCount&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x51<br>
&gt; -#define PPSMC_MSG_LogGfxOffResidency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x52<br>
&gt; -#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x53<br>
&gt; +#define PPSMC_MSG_GfxOffResidencyLogReadSample&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x52<br>
&gt; +#define PPSMC_MSG_StopGfxOffResidencyLogging&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x53<br>
&gt; +#define PPSMC_MSG_StartGfxOffResidencyLogging&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
56<br>
&gt; +#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x57<br>
&gt;<br>
&gt;&nbsp; //Argument for PPSMC_MSG_GfxDeviceDriverReset&nbsp; enum { diff =
--git<br>
&gt; a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; index 636ff90923d9..acf03838d49d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; @@ -252,7 +252,9 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DriverMode2Reset),=
 \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetGfxOffStatus),&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetGfxOffEntryCoun=
t),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(LogGfxOffResidency),&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(StartGfxOffResidencyLogging)=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GfxOffResidencyLogReadSample=
),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(StopGfxOffResidencyLogging),=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetNumBadMemoryPag=
esRetired),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetBadMemoryPagesR=
etiredFlagsPerChannel)<br>
&gt; , \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(AllowGpo),&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
&gt; index 717ba46c8933..1104f8b05b29 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
&gt; @@ -72,6 +72,12 @@ static const struct smu_feature_bits<br>
&gt; vangogh_dpm_features =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; +/*<br>
&gt; + * SMU support new GFXOFF residency log interface since version<br>
&gt; +4.63.62.00,<br>
&gt; + * use this to get live readings of GFXOFF residency&nbsp; */ #define=
<br>
&gt; +SUPPORT_LIVE_RESIDENCY_MSG_VERSION 0x043f3e00<br>
&gt; +<br>
&gt;&nbsp; static struct cmn2asic_msg_mapping<br>
&gt; vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TestMessage,&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_TestMessage,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSmuVersion,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PPSMC_MSG_GetSmuVersion,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0),<br>
&gt; @@ -142,7 +148,9 @@ static struct cmn2asic_msg_mapping<br>
&gt; vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSlowPPTLimit,<br>
&gt; PPSMC_MSG_GetSlowPPTLimit,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetGfxOffStatus,<br>
&gt; PPSMC_MSG_GetGfxOffStatus,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetGfxOffEntryCount,<br>
&gt; PPSMC_MSG_GetGfxOffEntryCount,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(LogGfxOffResidency,<br>
&gt; PPSMC_MSG_LogGfxOffResidency,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(StartGfxOffResidencyLogging,<br>
&gt; PPSMC_MSG_StartGfxOffResidencyLogging,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxOffResidencyLogReadSample,<br>
&gt; PPSMC_MSG_GfxOffResidencyLogReadSample,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(StopGfxOffResidencyLogging,<br>
&gt; PPSMC_MSG_StopGfxOffResidencyLogging,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static struct cmn2asic_mapping<br>
&gt; vangogh_feature_mask_map[SMU_FEATURE_COUNT] =3D { @@ -2450,19<br>
&gt; +2458,32 @@ static int vangogh_set_power_limit(struct smu_context *smu=
,<br>
&gt; static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool<=
br>
&gt; start)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 residency;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu=
-&gt;adev;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pp_feature &amp;=
 PP_GFXOFF_MASK))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu,=
<br>
&gt; SMU_MSG_LogGfxOffResidency,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, &amp;residency);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smc_fw_version &lt;<br>
&gt; SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; u32 residency;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_cmn_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_GfxOffResidencyLogReadSample,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; start, &amp;residency);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!start)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gfx.gfx_off_residency =3D residency;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!start)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.gfx_off_re=
sidency =3D residency;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (start) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_sm=
c_msg(smu,<br>
&gt; SMU_MSG_StartGfxOffResidencyLogging, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_sm=
c_msg(smu,<br>
&gt; SMU_MSG_StopGfxOffResidencyLogging, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; @@ -2479,11 +2500,20 @@ static u32 vangogh_set_gfxoff_residency(struct=
<br>
&gt; smu_context *smu, bool start)<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; static u32 vangogh_get_gfxoff_residency(struct smu_context *smu,=
 uint32_t<br>
&gt; *residency)&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu=
-&gt;adev;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; *residency =3D adev-&gt;gfx.gfx_off_residenc=
y;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pp_feature &amp; PP_GFXOFF=
_MASK))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smc_fw_version &lt;<br>
&gt; SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *residency =3D adev-&gt;gfx.gfx_off_residency;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_cmn_send_smc_msg(smu,<br>
&gt; SMU_MSG_GfxOffResidencyLogReadSample,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; residenc=
y);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; /**<br>
&gt; --<br>
&gt; 2.43.0<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_BL4PR12MB948066C4AA3E7F79D3569773EBC62BL4PR12MB9480namp_--
