Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49FFC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 09:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076C610F20B;
	Fri, 12 Apr 2024 09:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OPu1NY5t";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4163410F2BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 09:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbB9fVQf8Yn2bMRel4DL3CJssLWdv8iy+wm/3PVKTaLQmIth8Yq38/yFQ4iHUIbNgq6BobWd7wxyeaFlsaInNaMxHHbT6RXIA2I5s3OCnbqMTKYANadl3GENB0jbw0aHWhXsYSc56J5JGJ6FyYptei6bdhQUprwU1C/uy5PT3xohtE3LnxYbzWusVV3M3UIO5X4UI5+6qUOwFE7t2iRJtuvf8Grgu5tLbsKC1AWnNK+OD0E6XaF6shaPa+0hT4IjxwEz2qMUfqBzcrkawxEKRevN6yrRbKevFQKi14oDlq01aS2jW2mTfG5SS9tJyLwMpwIuyPBT0kC4pXniLLfYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJYxWADy8nbwlSshmq0RgXtYbuHs0BF5CWAvEMTvcVg=;
 b=K4uTaHAp2ExY12QY9e/jdOvEYx0OKSsYwW+5pnGqDJrwp2/0KNDrKmSSK7Mdh99V98ZSYq8HaptjXtByEjdotoOXMuuCTev4GjaoeIdICoxBbKT80ubdlnRLMVR57D27JGuEL3hjZVT05RvkCFKx9qPjR3r761koLOaC1niobxEfMLbSKcLOEDKVVxbLjzI61kvzCwrZCPkFvOTOq5U+kKqxau/0a47IQWwj97nGKw0EzyPhM/US1v8mmtYEWfGFDn+eJ+NQLTM6jVaX9TB75HlS2iBRSVd17YDAV3QtrSoSU0CrkEOxT7a8huFL6hm7/VAgwKUkFdhQ/IOT6mqyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJYxWADy8nbwlSshmq0RgXtYbuHs0BF5CWAvEMTvcVg=;
 b=OPu1NY5tDJO1t16d+z9iibz2Q3Sd2tHzbERvA+VagUkXDYEkUEG9oH4+UWDAu9F2211a1mQSf1bMnTK3svqhrEAzS9Kmh5aiW4Jijx/fyV7ryU6ikM9s3oGA/xL1edxxFiMIaz6ktci14XWqBpFnEUwPBV1E35O3GtKCK/578B4=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 12 Apr
 2024 09:02:20 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 09:02:20 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: Fix incorrect return value
Thread-Topic: [PATCH V2] drm/amdgpu: Fix incorrect return value
Thread-Index: AQHajLdjAb2HzdqnjkG6t6Dkj72XpLFkVsug
Date: Fri, 12 Apr 2024 09:02:19 +0000
Message-ID: <PH7PR12MB8796DEDE4E8AED3E421E8040B0042@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240412085546.1459735-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240412085546.1459735-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7140f4cf-a4e7-4bdd-974f-6f13492f93a6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-12T09:02:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ1PR12MB6290:EE_
x-ms-office365-filtering-correlation-id: 330fd9f2-e206-4eed-81de-08dc5acf427b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VVRRMYMncmnXfaY/0UCZuYxWXY1Ecag3vQJQk9bAUMR4FAWMAg/EH6Etmn5T2874+K8+wzm7kZ8pVpZYf0cjcIpW3Ld3jBD5qT2YDNSFnZEzLTTcu/LCM4ETekrc7y0NKpPGqV7qBNQ+1AbukEDzigmSeS31fVo3lqOJ1HE6r5NspYqEzAwBrIlH0EBPTkHdRgfGbdlDyjuQOyBystWG6peFGu8gI9n2oru3jS9VCh6tWKm84SNJCKCIhPVUVZZPOF88GN3NYFO0fuHvY8P7FRED11Jbnrt4YWWefNhDW/t9az/fuPimgOgQoJ2gOXD2jcENQksxjXJuk3NdJo/GaEcjNDtBDC1kcQxpNLmiYcYSCWDlcRDGvzQEbo3athq8qOX9a03te9CJLzNbfcBzXiUKPF7dko7beqiqO3cgwyCjNkFxrLmsNp9hMTWBHw++duSB67HfsiPjV5ittk+DTCY0uVmq9n+9kqQias5YhqhYhjI/zuUS5r1YJNoEcjK7ewH+g6JQ+jhQdJpdbODA8nR3/p55cxwCkmuuBAnCkufs7VDusR8YeSh9gMb070HFVISYU+qoXD8xqz4HTD0yFCmkTFbtDFbCr4ddAGT9VpmJbztk6g91w28tsidP5oZyFN+0VBa7QdO49VM4fpZw2A4DYnr7s/NKFdryAZ04dIuoOIlZLy0o5NefXZh6SoM+AT4zr51Aze3CTXLuWREXokNLc68CHaTCsKM1UH1csfQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MjAAEKmqCcEMv5q26wxvV8ejGns5Ksr+CtMvm2MF6JvM2vvt+MWGqwmocK7z?=
 =?us-ascii?Q?YnzYG5zqzHOOxJ+HESNt+qbruodCs/od2+choWkIGgCC9SMrD8GFr6ibix1A?=
 =?us-ascii?Q?VhLMkcURa9wCa1m55nd3Sap8TaihtrZKY34mXJZ4lzYF9Gk6GWumKGZoJYtp?=
 =?us-ascii?Q?vfakBu5w1KFv1QSXM4rXNIedUkVSvApXLgOEQ9+lrOtXwpWIXwAzwmNKwaqD?=
 =?us-ascii?Q?0aOrvvc2KIqcHqJjUh2+T7opFcnxAh18XUli0Z9zGcB23KfaEC8XZIeeMnAh?=
 =?us-ascii?Q?V8OvTwNVCEl2A5ko8GNTAtQRK9jJFZjlwOgSTk3rUa5of4vQ96wkCflHjBBP?=
 =?us-ascii?Q?IRb1u5Mv+sXMy5Zz9vfgzdlL0lunj2Ie/+0KuHmudPrGCx9BXK8Z7ZNTsCT9?=
 =?us-ascii?Q?2BF9+WUex+2+R3p07EKujGOAwEynFb7+hbKAW/CEdbgY73T7o1VnN51veJiM?=
 =?us-ascii?Q?6HPnexKPaFrBvqWXgc4JqZk2PE9ZSlamTTnHrZFopdCM8nXdGit2XWkrr5Iz?=
 =?us-ascii?Q?bmITjq1jMCzlY+tFoWWdke7BFMRSCTiznMSDwu27rfsktiCPILIKmo0EJmCx?=
 =?us-ascii?Q?OqjhPYPYsHVBKTlhDOdzKw1x8cpvEH5FViMWDaIIJwZ5KdF86xVUwBPNmbMS?=
 =?us-ascii?Q?AxHl2og+Bv//rLZhEL9oec0D2Xdg4b759mlCx4w+5epTp07/uq3qvpjycWr3?=
 =?us-ascii?Q?dtf9u/6h9WkFyX3y6xlXOE7VBgAfkoTdZLVCDJBdP/sjI3fP00KwvAR2Vfev?=
 =?us-ascii?Q?WFrnC2dDEur/+Sh31PbABmo5ZdBRXhDdcbd42SaoWvhLyaUMRaQB355yY3ay?=
 =?us-ascii?Q?D+VTWpdA0CMpbo8bURpMa2HGdxQeKqBnT/yVB5I1hYeCSZU+oqWt0BTEdfye?=
 =?us-ascii?Q?9PeCJROfcMnc38Bo5cBMDWsK/3x/dL8mo5yJzfhks610AK4AePalSy2m0OOG?=
 =?us-ascii?Q?1d2vu/AxCjukTPUSaSBxCUltsiJ4C9g3Nueb+yfk9IQMKEbsYr5BIxlPSo+i?=
 =?us-ascii?Q?CG+mKVdRVjmPTr2ul+930mwhntKMDg1O8S8VekPeDTYnlxNFHpSF1x9IBbQt?=
 =?us-ascii?Q?GgJ+aAY2Po8xCu5YV34chyXHPIdBUe1mu5wCUaZcFTC7rjxCjRId05E8dXvj?=
 =?us-ascii?Q?+x/fRahDcnTpG+rrwl0H3cerPtaamcW2EvTpSJsZCNk7DREqUGrXEJ6atqXb?=
 =?us-ascii?Q?aFr1XdxCsF1TjcqcyEir3m5tvcUbqSz3ZBNp+p4VfEtBSmcT6Cyfzm5WH5+F?=
 =?us-ascii?Q?f6/YKBEeknJ+rFpjQVIZWxhqc72iz6fscj4GGyo0cY1VmSEufOTr/kF51cFT?=
 =?us-ascii?Q?wMaCc0hN4rbMzXx4f3dZZga+d9pV9BqfCdG/n8htIRUo1Ezmowletf4S87za?=
 =?us-ascii?Q?reCiSPbMs7lpfEXk7VYtG8AGFLjK+OozAFp4oG8dzR8IT/KwZTwS+5dYDTa/?=
 =?us-ascii?Q?oGNcb/3qRh4Rd2/OIwnJZLBD3ii8uNLY2Ds5qfXbHBA+xBmFM4qeP4WXyktW?=
 =?us-ascii?Q?lmOnfa0sYwhJqzQLVit9t113+dyc7AGkWrFHrybAoEL81xBW+NYPOBWUlAFY?=
 =?us-ascii?Q?K3cQ8/HPyraajQIkT1A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330fd9f2-e206-4eed-81de-08dc5acf427b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 09:02:19.9254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H08P8pkWp1XI8TsXptBLA6YXhVk8b4MHWTA5b+vPeVJShfh5Fp1k9oqqX+CTRp46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Friday, April 12, 2024 4:56 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2] drm/amdgpu: Fix incorrect return value
>
> [Why]
>   After calling amdgpu_vram_mgr_reserve_range multiple times with the sam=
e
> address, calling amdgpu_vram_mgr_query_page_status will always return -
> EBUSY.
>   From the second call to amdgpu_vram_mgr_reserve_range, the same address
> will be added to the reservations_pending list again and is never moved t=
o the
> reserved_pages list because the address had been reserved.
>
> [How]
>   First add the address status check before calling
> amdgpu_vram_mgr_do_reserve, if the address is already reserved, do nothin=
g; If
> the address is already in the reservations_pending list, directly reserve=
 memory;
> only add new nodes for the addresses that are not in the reserved_pages l=
ist and
> reservations_pending list.
>
> V2:
>  Avoid repeated locking/unlocking.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 25 +++++++++++++-------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 1e36c428d254..a636d3f650b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -317,7 +317,6 @@ static void amdgpu_vram_mgr_do_reserve(struct
> ttm_resource_manager *man)
>
>               dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n"=
,
>                       rsv->start, rsv->size);
> -
>               vis_usage =3D amdgpu_vram_mgr_vis_size(adev, block);
>               atomic64_add(vis_usage, &mgr->vis_usage);
>               spin_lock(&man->bdev->lru_lock);
> @@ -340,19 +339,27 @@ int amdgpu_vram_mgr_reserve_range(struct
> amdgpu_vram_mgr *mgr,
>                                 uint64_t start, uint64_t size)
>  {
>       struct amdgpu_vram_reservation *rsv;
> +     int ret =3D 0;
>
> -     rsv =3D kzalloc(sizeof(*rsv), GFP_KERNEL);
> -     if (!rsv)
> -             return -ENOMEM;
> +     ret =3D amdgpu_vram_mgr_query_page_status(mgr, start);
> +     if (!ret)
> +             return 0;
>
> -     INIT_LIST_HEAD(&rsv->allocated);
> -     INIT_LIST_HEAD(&rsv->blocks);
> +     if (ret =3D=3D -ENOENT) {
> +             rsv =3D kzalloc(sizeof(*rsv), GFP_KERNEL);
> +             if (!rsv)
> +                     return -ENOMEM;
>
> -     rsv->start =3D start;
> -     rsv->size =3D size;
> +             INIT_LIST_HEAD(&rsv->allocated);
> +             INIT_LIST_HEAD(&rsv->blocks);
> +
> +             rsv->start =3D start;
> +             rsv->size =3D size;
> +     }
>
>       mutex_lock(&mgr->lock);
> -     list_add_tail(&rsv->blocks, &mgr->reservations_pending);
> +     if (ret =3D=3D -ENOENT)
> +             list_add_tail(&rsv->blocks, &mgr->reservations_pending);
>       amdgpu_vram_mgr_do_reserve(&mgr->manager);
>       mutex_unlock(&mgr->lock);
>
> --
> 2.34.1

