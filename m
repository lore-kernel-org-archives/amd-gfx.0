Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334B4C25B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 06:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF3A10FF91;
	Tue, 28 May 2024 06:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3qtoTAXn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2B610FF91
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 06:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7Xo0Ruiwxr3B87i7xAdgsX+980wDYi0t4YSuQnJIHvVJ/y4LEi4B2yQWHrRn5v9UfFtkls2Z0Zm6ZO91AaoXaxyf++uY8KR+D65ydmIGR/e3bWWEpmLLC0EgFjZfqAA1D2bkfFlh6cmBGRktsOPDGOM+KPJLyix5uA6qNR6HCH7/lEMoUzK9ud+70xz5Gzn/9TtPHH/Fy78boO6rA6m0j0AahJob3QJ9cpOWbNfot+3+tZ39I7fq4PCtIbu95GOYqZVHLBOVhX3Qe2ivFg5zgn3ScYkrrOeFXSukJHJ8PFTpkBp6SCUYa0RJ5Q1IGf3pbrLf7CdreSMkst7vP9fTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGw3VI2yYpN1jFFXFecYw1gcAfO1+US7epBtFzGX6YY=;
 b=O2aLQJn1AFMTXpHZou8w76pE85nlPLCqtvBSkSftchs7NCG8PEacBHvOXiSl1VwEz2Uj1nru+4pReZ2sV2YtknF2WXwcPy8zru+FT4LwK6umHy6SL5WdFwiIsf34QQN9nXR+xh8CGSJZSBktq7FAuFXXNOwlQsxQZ2icIsGpcfHyrUULGNhulDaSgft2JlCfNZuCNHJwXYYmr48OHyQEfobiOijZb5PI3cBNzMWpyA5tyaDXnuOup8Yzv7PFEUoD7gaKTy2jq2rlJSoQlSh6DeWojO9fOgGGPiIpiGTtohM/xUe9o79ZiY9nuzYRgmooEqm2MWgEwc4FOkKA00EmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGw3VI2yYpN1jFFXFecYw1gcAfO1+US7epBtFzGX6YY=;
 b=3qtoTAXnOCk4Y2X8EbIFWc71kn4ZRckHAGoUEjF2zm72qBA6luxWW3UZcs+3Na0EC7faX9BhcZxM4xaonA/Y7avFzfqMvVpQqoAawJuujHzJOM4jS92McEsKK2tZ1uL6JVEfdkCwCarPhwuNaOrl+E8oCPrMswpv3xiYfNlOy14=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 06:02:21 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 06:02:21 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Estimate RAS reservation when report capacity
 v2
Thread-Topic: [PATCH] drm/amdgpu: Estimate RAS reservation when report
 capacity v2
Thread-Index: AQHasMP05TBLjvh460K53Z5CwyaaS7GsJvZQ
Date: Tue, 28 May 2024 06:02:21 +0000
Message-ID: <PH7PR12MB879690F3B337DF8B9934A297B0F12@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240528055721.27848-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240528055721.27848-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=73685698-2f20-48d3-be98-f5d5ff03c302;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-28T05:59:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH2PR12MB4230:EE_
x-ms-office365-filtering-correlation-id: 7d4d7757-e37c-44cd-3dde-08dc7edbbcf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?CmwrwgyPq3YwcPpN8KEtkDbt7tUrWh+ekWF2BwawRxJrAeKJAF0TekT0ZQBj?=
 =?us-ascii?Q?T/3qZZGD1xCSMuy6nMYbyfOe9U4iP6aUcTtVtVmHVQaXCV03kCsArLpu8GKh?=
 =?us-ascii?Q?JgaZ3LNs2V6z1Q7dTxFCL2JvE1RY0R3e6+wrPGCH13UTLi38ugJ6guixMvb9?=
 =?us-ascii?Q?kAk/W9qe0W9EIUk5zv8zPz8qhZLekysvnvbXAPgd4gBdSts1GveVseXMmKYB?=
 =?us-ascii?Q?CfCMbZ/Jw+BYXq6Xp1lYoTXtFoSc6nZaUXPLMMOYF89t6/SW8qO6CRlHeWb1?=
 =?us-ascii?Q?oSLKgxW+opOmjo3Pw6UNLnGi2wTqy4SZ89x4c10ZFVpXQXAy74e0ofLvh6TL?=
 =?us-ascii?Q?LWCFqMMtHCyIvYV34cAvlZsebS1fRKqZeLnkgg2WU0ejGYmuBt5EnveSPfHw?=
 =?us-ascii?Q?QLQNGI+C5pCFSR9OAOkvFUNf9pn3hkoKSOdnlJ/JKflOc5pFqkEuyF6X9vTO?=
 =?us-ascii?Q?wxhu+wsRdPwioMWtWiZeY6Hp8LX0j7W14IlveC0DZg9W8i2ZOCt7f4jXmRfT?=
 =?us-ascii?Q?LvtuVEqKduwqUN0BhOqwVqgcvSI9XU+7pYo9dRYzAaQ8vFwgg3zcjydgtuqR?=
 =?us-ascii?Q?xVvGTJBQGtpAksR6OZGNaXOsp5NTP2NUEorUUxZH/cSjiXJDc8gkAql2jgiT?=
 =?us-ascii?Q?uIwcGLwWpKAf2DwHtwZ5lretE3/qqChBdiE08KFKCMyruk4czxjnneXDGy5l?=
 =?us-ascii?Q?zNF8tzblXM/PPDKl2FXQSi90R3kNuHvy00tM83guM1eyAkgHxnkdf88uuK1T?=
 =?us-ascii?Q?gtebpO+DvUvF/rtOKyk1BZfbpKFeOztdBtD2b7ihMQKPto4fswZiKYPcPbyz?=
 =?us-ascii?Q?O51pSRsK5V5hHFHGEXtMOmVRCF+6hMdi/ZFFLy28OKb2JlU4J8qFv1IcdBVQ?=
 =?us-ascii?Q?3FWaKzv5xYFVQajoeCiswpFUrr5BQ1F9k09YbGQ4k/uOVBaicKAtcC6jjVwQ?=
 =?us-ascii?Q?khgXGIeW4E7nd+XJ7PisVdoORLM7b9jZsZUzsJsKgmcaQBYNKC5jOVxbyuKb?=
 =?us-ascii?Q?+XTzVIUY45DuhMAQTXx67K5OieUYWiBU+SDni6VC+0SL/7YH9DB4rxNkLyDf?=
 =?us-ascii?Q?jhBRY2ZHlG+28xozDzFnrzq5ixusGNYOhLMJ2JZPZXAbe2tkVIH+LOSZdOv4?=
 =?us-ascii?Q?bdTGONia5nhIoEk7jXgXJUjFzt5CdGr+6S0V08pPsKAT4HfXyEzKhso7tiUA?=
 =?us-ascii?Q?vM/LjRio/lSmppNtP2/JH9k4pEWTvk0MNWuU41VVmsqsXjmR52GjpMKmKITy?=
 =?us-ascii?Q?eUGEAOtmiau+Y1EUiHoOtH4WmOFQv/um6XlrCTl71YkGLSfLjC00riAI+V0Y?=
 =?us-ascii?Q?JiR6wbyfQxTHob8A+SSdfvlmw9GJrfTxt19YdoXHS3y0rg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4P69SpVOdnxTFoku7tBly4Qt6HdgYBuFd1hjKmeBkx58tqA8rN5zBDGsCBGb?=
 =?us-ascii?Q?qIdBtQjy2BxiBYJW2eKcDndWCOHKM6JTIjfnrP8sWQb6Uu0mTiVnoZbiOELd?=
 =?us-ascii?Q?GHq/QxermRHaaLWtOPxctSTftUHFIfZJ9NRg4WZuT9GYyYuc574A/Ujwh5LQ?=
 =?us-ascii?Q?BzqKC+h3NS1k5UNHIbnZOGhaPSj+qwJELFmPXnWCUBcCbVBIhWg55fqkqvZV?=
 =?us-ascii?Q?/PTdSh43JcGykDkNKReDzJ/wlafdaiN52LHo3pSdGEaGRvRnr1wtuMLy0IMy?=
 =?us-ascii?Q?w/AAL8d5OpwHFHXomlWDIi5NEL0f5bBLf6aDC0I7absDTq7QBjhaZ+ongaDn?=
 =?us-ascii?Q?/J2v/+coXZCxtmTqs2W8T6RRonAwOShIfnjPibaGHlJGVQgZOxKhkoOjXXv2?=
 =?us-ascii?Q?Q/cUhROrWwxrbeK9RNtLIs/c4FLD/h8guVaVDuS3d6zQ1AX428MIT0wP1I/r?=
 =?us-ascii?Q?vNrM4pc8g7PK/ewFGExsVPi4uyTy9oYRa2VccMoL8dTG2x1pHh34wsAMDLvO?=
 =?us-ascii?Q?DXnYkENWIt1EbCJgyQpCGB1nOF/zygQ/MWOgsiGQLF2A/b2Splh/4RqfCZHt?=
 =?us-ascii?Q?JTXzSim5tz2f9PV6Unz3E9oMhXYSIDGdyD3gWkP5AGUxFfa8NFxqDuTt6iHH?=
 =?us-ascii?Q?oz3/PGw/dy2P1ihaya2u91ExVQAGNg02k1QhslHko+roQ35BJtP8GJcebMCp?=
 =?us-ascii?Q?NYIqHghvKHygYguIK6FkQzA2THVgZQVY2busTw9QGvF+LFAkHK1i7jDWFMWZ?=
 =?us-ascii?Q?4z+6fs9BIvR4mX3twSDg/KQEvgbG5rjYbpVgwuSNyvGjsAr19MoTCP93OYza?=
 =?us-ascii?Q?ZLOd6ky1K7ygYAs6RAyCAtaRmXxaxRsZCEdTjJt9j0Fm4nF0Lyhk+a8Z+8cH?=
 =?us-ascii?Q?3x/O4rC5lj6Gs8+lpe+EJ8WTg6Lx3GNOAqKwxqfJ0TA8qELvSqySvH/pSudO?=
 =?us-ascii?Q?9gSyCUtOpz5rKYqL6KFT98PLF/eQaDq/EciE6r/uHwMWPsNeTVUgKRlu1DAV?=
 =?us-ascii?Q?uCUiAanBNlFzFFwstHolfsRUXMcc7x2fYTYE52zA1rbQzyhXse72CVs1aq5G?=
 =?us-ascii?Q?yp3jhiq+hQEKOAMOoAbIwBKyjBtsfUrm2QUaoDtOy87qPqQqnQu+EssCtzLd?=
 =?us-ascii?Q?OSre7re90rhrA2wL34gfy22up1DIg6Qj4vIATQq7m06wYdUEqyEVruByJQdQ?=
 =?us-ascii?Q?M3v6owa6tAicTRsyuBnnDIur7Pcc+UIVJaHPHO95Xr3C03qK3n25o0WSGTpy?=
 =?us-ascii?Q?6Rw7YGw6GKbd9N94I7++L6eteOZq9ChczGG+6tEJKv3DGyuJ3tBcOzhYvJY2?=
 =?us-ascii?Q?wPm515B7j109xC/yWAR2TcYVwPoVqHuNYM0ZsVMAJZ5HuCtMgEVst1yWZEES?=
 =?us-ascii?Q?SaNW+XXdqA/ONNQ1voXZD4q4hnKSFpmXyj8LR6fT6spnrWN8hQnGt1gWHDAk?=
 =?us-ascii?Q?8sWHM3IWCf0QpPU0M4/Or5TJ7yar0jscVUxDW5LEgXoceJR/+9BwmKxADLI9?=
 =?us-ascii?Q?MSRvd3z5Za87QxtK8nMGDL0Q91oCfRqyJ/oWAOOiANTNM6zW/AB0KsZJPOzp?=
 =?us-ascii?Q?T6o9JiE7XJESX7Qxp2Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4d7757-e37c-44cd-3dde-08dc7edbbcf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 06:02:21.2399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuAPfNDFblE0OWr2xsWaLtuY5K+sAJF6ME6rJaIt94HV50WBXV9AXgpTO2KFGr8l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
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

I prefer to add comment for AMDGPU_RAS_RESERVED_VRAM_SIZE to explain the va=
lue of 16MB, anyway the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, May 28, 2024 1:57 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH] drm/amdgpu: Estimate RAS reservation when report capacit=
y v2
>
> Add estimate of how much vram we need to reserve for RAS when caculating =
the
> total available vram.
>
> v2: apply the change to MP0 v13_0_2 and v13_0_14
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 20 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  4 ++++
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index e98927529f61..ad813772f8a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -173,6 +173,8 @@ int amdgpu_amdkfd_reserve_mem_limit(struct
> amdgpu_device *adev,  {
>       uint64_t reserved_for_pt =3D
>               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     uint64_t reserved_for_ras =3D (con ? con->reserved_pages_in_bytes :=
 0);
>       size_t system_mem_needed, ttm_mem_needed, vram_needed;
>       int ret =3D 0;
>       uint64_t vram_size =3D 0;
> @@ -221,7 +223,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct
> amdgpu_device *adev,
>           (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>            kfd_mem_limit.max_ttm_mem_limit) ||
>           (adev && xcp_id >=3D 0 && adev->kfd.vram_used[xcp_id] +
> vram_needed >
> -          vram_size - reserved_for_pt - atomic64_read(&adev->vram_pin_si=
ze)
> +
> +          vram_size - reserved_for_pt - reserved_for_ras -
> +atomic64_read(&adev->vram_pin_size) +
>            atomic64_read(&adev->kfd.vram_pinned))) {
>               ret =3D -ENOMEM;
>               goto release;
> @@ -1694,6 +1696,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct
> amdgpu_device *adev,  {
>       uint64_t reserved_for_pt =3D
>               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     uint64_t reserved_for_ras =3D (con ? con->reserved_pages_in_bytes :=
 0);
>       ssize_t available;
>       uint64_t vram_available, system_mem_available, ttm_mem_available;
>
> @@ -1702,7 +1706,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct
> amdgpu_device *adev,
>               - adev->kfd.vram_used_aligned[xcp_id]
>               - atomic64_read(&adev->vram_pin_size)
>               + atomic64_read(&adev->kfd.vram_pinned)
> -             - reserved_for_pt;
> +             - reserved_for_pt
> +             - reserved_for_ras;
>
>       if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>               system_mem_available =3D no_system_mem_limit ?
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ecce022c657b..f28bf5765380 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3317,6 +3317,24 @@ static void amdgpu_ras_event_mgr_init(struct
> amdgpu_device *adev)
>               amdgpu_put_xgmi_hive(hive);
>  }
>
> +static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device
> +*adev) {
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +
> +     if (!con || (adev->flags & AMD_IS_APU))
> +             return;
> +
> +     switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
> +     case IP_VERSION(13, 0, 2):
> +     case IP_VERSION(13, 0, 6):
> +     case IP_VERSION(13, 0, 14):
> +             con->reserved_pages_in_bytes =3D
> AMDGPU_RAS_RESERVED_VRAM_SIZE;
> +             break;
> +     default:
> +             break;
> +     }
> +}
> +
>  int amdgpu_ras_init(struct amdgpu_device *adev)  {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev); @@ -3422,6
> +3440,8 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>       /* Get RAS schema for particular SOC */
>       con->schema =3D amdgpu_get_ras_schema(adev);
>
> +     amdgpu_ras_init_reserved_vram_size(adev);
> +
>       if (amdgpu_ras_fs_init(adev)) {
>               r =3D -EINVAL;
>               goto release_con;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 6a8c7b1609df..bd61f77a7134 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -64,6 +64,9 @@ struct amdgpu_iv_entry;  #define
> AMDGPU_RAS_FEATURES_SOCKETID_SHIFT 29  #define
> AMDGPU_RAS_FEATURES_SOCKETID_MASK 0xe0000000
>
> +/* Reserve 8 physical dram row for possible retirement.
> + * In worst cases, it will lose 8 * 2MB memory in vram domain */
> +#define AMDGPU_RAS_RESERVED_VRAM_SIZE        (16ULL << 20)
>  /* The high three bits indicates socketid */  #define
> AMDGPU_RAS_GET_FEATURES(val)  ((val) &
> ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
>
> @@ -541,6 +544,7 @@ struct amdgpu_ras {
>       struct ras_event_manager __event_mgr;
>       struct ras_event_manager *event_mgr;
>
> +     uint64_t reserved_pages_in_bytes;
>  };
>
>  struct ras_fs_data {
> --
> 2.17.1

