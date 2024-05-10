Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2D2C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 13:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D14FF10EC21;
	Fri, 10 May 2024 13:16:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kLNPKzKz";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1EF310EB2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 13:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANT0JGejPmpQ2/rjF3dOpVz1fbMR06DrmWUAzyyxpFGHQszyb8P78M/vNR0/TJajQdQbcNuIFIpYy0TJP4awWDhl2kFfBrG3TFi06xhUS3rJIfmIk1jaSkgOB3tF4kYWjmXg866Sq1tPSos9D00U5L223xagvedVK2771ahXGl7XKK5yvLbvNcwCRQX+joAJhCQ9lq3R4BOWZvYbrmOndgVltOGxRGxK0eJ/DrPy3Tde24jFZsjmDvGF8cGrZEwW4IvInDDIdyxvhFlrTyutUPLVRwfGFmNeUxy9lUt9eiN+z0427QKWk2HTyguNE9jiK2HcCmTkroZ4tNyMpEUvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXPPdSDD7/X2NQKBMi68BKoImlKslfCfr/FN74+zAcI=;
 b=UAaDhPYGU0cq+glaPGGYLNnrw9QgXnI7YI62bNx0Qw7ILS1oA9Mq0HXDzsF6LucIu0PsS3mzNFBfuqppEPqiziTpPSD0m5tMvgPn+y/wzKKVBsJWkadWHqgRxvMUYnI9ItTFQb9b8QHTLQvazFEWNTvkybKZFkm1RgZOC4ryoAqSx4ddF+qn+EXAn+HgtjzNd988LxWSgHmVkUn090DgNJq24by/D85uNh96S8wsJnjmAz65MHmeBA8g1QhLBVPyjKkLZUJJIloaSOY5L69tORksH9iJzU26F0yJe2GD5SgvWvpos4ZS6HojUAosRYUscukur4ZKD6aLcgHN46nZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXPPdSDD7/X2NQKBMi68BKoImlKslfCfr/FN74+zAcI=;
 b=kLNPKzKzcq+YCoetINlz+OhgbV6h4D3IRlXTX9anQ1ttWAlRHy/r9986rm0Kmd+xddOZTrYaNFRkrkqzSRmjEvyYMkoV0INsJvh9z2shErnT20O5pHVR8PNums1RzJd2LcXfbYzoLIfbZpiFIUT9KbEsAioSPiNR4ajOqmQNm4w=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 13:16:05 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 13:16:03 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Somasekharan, Sreekant"
 <Sreekant.Somasekharan@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: Remove bo NULL check in
 gmc_v12_0_get_vm_pte() function
Thread-Topic: [PATCH 1/2] drm/amdkfd: Remove bo NULL check in
 gmc_v12_0_get_vm_pte() function
Thread-Index: AQHaopZuPc1QhqbgJk2IBWRg4HINh7GQcyVA
Date: Fri, 10 May 2024 13:16:03 +0000
Message-ID: <BL1PR12MB5898A0A3EAF7FDF26A20F12F85E72@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240510045541.533908-1-sreekant.somasekharan@amd.com>
In-Reply-To: <20240510045541.533908-1-sreekant.somasekharan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6534a26e-8720-42af-9415-4354a3f82008;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T13:15:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|MN0PR12MB5905:EE_
x-ms-office365-filtering-correlation-id: 1d5fd1aa-a9c0-4b33-38b1-08dc70f357f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ofZS5GKM9xj9dyfW5ZvSznMFLZZP1mNZN9plHxBmleeMis8iDgVlA9ojZhNm?=
 =?us-ascii?Q?WSBeivsx6XM9dGANbVTMYL4aL0nnJCd8sxhytyZ4541RCsjeq/O0fOtahBNr?=
 =?us-ascii?Q?1KNQhKrpBG8dpXZgDCf6bnMuCgJTeTtbvXLU3JDbIO5Tu15p7IO6oMx80zq1?=
 =?us-ascii?Q?BMpIbUtUuy2Y24RdVDS0ZKtRjIv/PgqFWShwOwBtjEeXC6dqsJjT/924vHfq?=
 =?us-ascii?Q?P+WqyWL3AFUfOVFnw0ZYyZZJcCZen6aQozKvhqUhFaiWnTAMsaNoYfAV7rKt?=
 =?us-ascii?Q?bPKD0ZG7RDBzcvKWcPLjEfwYaSprWS11qys9GKN36Gc+iK1CjZumpayDwgu+?=
 =?us-ascii?Q?CbZoEhvmeCczqSl7Y5gfRowCJYXPed2bEAyTDdypkr0vdFSUE93VgW2qhAMy?=
 =?us-ascii?Q?V+SQ2buZUc33Q2004aAP1mc+REh+StK8AAwqE3Z556C+RSKHpTP99Rhd+I8B?=
 =?us-ascii?Q?hIo9f7BFCAQbDcagyO9Oz2fsRpABa9G2LjqfzvPkt3fYiq20P4G00VFH9udU?=
 =?us-ascii?Q?CNOX2N9DzaW6d6PzGvvVRVBzWmh/hc/GdM7RUaI+2ushaJ5sunJh4ID3iHbL?=
 =?us-ascii?Q?ErAzHKbP599/Tp6cdGWkjTCCKGemmSRg5Wz5Ck4GtBUqSQ/ne5dVwd0SJw46?=
 =?us-ascii?Q?tHz+f7HJC4x0377k8yzkIWGOrjbOCkJVmrQz0+YKyKlNQ/qzNSdB12axRVrV?=
 =?us-ascii?Q?y475gWDw3RqAwYtw67JfRwfH+iEvPJcppYeI1LoJJXkqsT1Lnq31BEP3Avlq?=
 =?us-ascii?Q?mxnoRPCeF4QrA9SByfk2YuJJV4HY8UzL7JFGH+hmz/gb3PVxW6blo4XWNIJz?=
 =?us-ascii?Q?EggG5CAMJOMM6qemclcxkOvy++0q2jeP+mnYrAQZLfX8GXgR4G5Vv7Tga9pX?=
 =?us-ascii?Q?qICWhBMhzLWBnAQJuSjtoiKhNEx2Vh+Hh3ttlNICbFLdsUZAzMP+leMoo7F5?=
 =?us-ascii?Q?/E5/7VEu9QixfKNSb1Xxzr4Zrsk8Z2u2B+zNwQ7wesV0MU/5HiJLYG8IpWKi?=
 =?us-ascii?Q?+jUn2wRxgZ7zv+dsFEIJXZNY2HUS0SYgVwnexMimRvPgcM+tB2kZRiAgdUh4?=
 =?us-ascii?Q?Tx7j7ZuThSuJE3pve1QTlxopEXGx+YE/kaNDWqLviZ/fHtN5pKE6hSZ+KOaw?=
 =?us-ascii?Q?MN+H1qv2OCCH46mR3EKdjHiijEtzuQWK0VrGIntT5pd/LiF//EUrhq3BRmLX?=
 =?us-ascii?Q?hPMOD9r1LWcUo+ChJuk65Mo62tbQ5r86+MFPTrJpX7Dzb//oo259hsfWOWS6?=
 =?us-ascii?Q?zslZEnPF52KJY6slCr6FHFV+CYMUllH2cJf0JRixI4rmnBQPS/HBOAOgta9t?=
 =?us-ascii?Q?5ZktaQfQ5Igvq/0jWzYkHLwZv6A3fGyQ+HJUj5ohm4YjxA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j2ASYS0r++4sD5vm3/lR65FvP71kroNBuDBAlsdkhbid7p+VVuwIHrozyj5p?=
 =?us-ascii?Q?uZIYC7ja0cQibzV5+ajbpJs8Ue1UcppX6NHIjfhcxkFnnh0I3F2plh4HRnW8?=
 =?us-ascii?Q?uQYs+WHaN+sDSecr8zgvO7BP+aLJKMN2uGuUCyUobNtpP1zMVbE3Ieis4hUR?=
 =?us-ascii?Q?q3YmQFkGhKispLhhgawHAFfqKELPrOh2WysbIp3s0/6l58z4Gg9GRTodIJCB?=
 =?us-ascii?Q?3F9EWKwdJCQeQrCIfOrCcDicdrCwwasTiVU/jNZscsshN91oq1mJtZAX2Q9O?=
 =?us-ascii?Q?GEzPnDYxtM/nWgAcXwF6h1hnTDcMKm6Qn+WaJmTL3Up9pEDbU8ZIxcZQDHdD?=
 =?us-ascii?Q?SoIR81K3Wjb7Gzut24CeCmPE7YP9rZesX9y5h6fI43s1AMuv9RBOczdm1a61?=
 =?us-ascii?Q?gneRWjxvUsK6Xz8xqrZmVZmwMXdn9vTf3Kb5C+lMAiOhfOtZP2AKhvz5eIay?=
 =?us-ascii?Q?TiA+iZVGzWaGYYsrFa3ghKe4J6jhp7KTyMuiT1Ayiyf6ewQL/E+710V3ip1R?=
 =?us-ascii?Q?7bpTGNok95E/RtHLaF6YKfMLOADsqhVgBm+zNHWDjcPS8nz6h52HHtdpIMLc?=
 =?us-ascii?Q?6CPy/uHBiiRc6ENr84kHmBPITXY/K/QtcZNAIKNATYZmjnLhf5iC9to84AGC?=
 =?us-ascii?Q?zgtvW8OVmTnTP8PAsfKIfAJDhWBChMVsepTfwWt8d98MQf8Zp87h7P4qGws7?=
 =?us-ascii?Q?SHTqr3+Opv44FYyGXTIRqynWI/1AsHmulGj04mxTW4SKj94faK57TFg7GKS4?=
 =?us-ascii?Q?BWZaXC3rz45XFxLBzDaK2EBk3bNF9vJxWPpBpa7rDveFk3zhL4a9JRQeka/M?=
 =?us-ascii?Q?aF9XZH6VjtU/XaBmwcmaQVjq13FDnzNgzg+kz08miUq5DPPdAuHqnB3wxi3k?=
 =?us-ascii?Q?js10R5TVLsqsbYaJ6w47rCmPsyfJ5QLPAz0N4JKqvpHlNXr7QAR/aUwHQzOU?=
 =?us-ascii?Q?rgLm46n9TO+4/NDHsJ0nEOg2s0hq24wElQIJxAcE2xNXIhEl4/MrMT5JW6kI?=
 =?us-ascii?Q?e/bnQrG9xiCr2FbXMNEuNaaZY7/53NKHbaea6oVFpD4fqLsGW8d1od7laPx3?=
 =?us-ascii?Q?qIv+7sQGApH23jHf3b+yYONGvdVGX3PqVuCAabiDZFz+H0RIUYwTjXG0lL99?=
 =?us-ascii?Q?vVcvfNcHVNtpAVax/O9544YNsMZKnkgC647toxYYBhOSIz/0JWUr1Ss4tefo?=
 =?us-ascii?Q?TpF1MNJqrQiB6Y/4NSCOaJQA8VL9qi8aTSc32pFwtnR/llz2efjSDk+/3XLM?=
 =?us-ascii?Q?8JppqJofRdi5BDgDXx+iN6yfhCk87odZM7vd9P0wYgo59K+hufThuuRxp00F?=
 =?us-ascii?Q?3/CoBp3IGs1RyYj3Rt4XFM/SDCWvvh4sUNZimQ/Hk+5VXCvc0frdBserdF3q?=
 =?us-ascii?Q?9SRNKFqEDC45H4x1EQjHJkX8a9pXibmBGcQRFnuonyZi7jkodSxMe59G+MD6?=
 =?us-ascii?Q?ErBPtiv9bvC08CipQdFzuKy/8OY4GLt6j9G6s38WmgIuVa1unmjEdnYmXsu4?=
 =?us-ascii?Q?1rlGYBRbTnKg1tZh1FLxRiqeH14nixyg6PMu0SPmRTM4UzykYvYBUCPtZiNR?=
 =?us-ascii?Q?vBhoFAqCMXGgLfRs88c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5fd1aa-a9c0-4b33-38b1-08dc70f357f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 13:16:03.4121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ub+0dNvOQK/1eMtFB/opes3l5aKbuhylYH9xXN4KXW25MPCdsTYeAK46SlbXTIy7weYkomJoPMPKZnq7vs/nEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
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

Do we need to check whether bo is NULL in line 500 first? Or can it never b=
e NULL?

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sreeka=
nt
> Somasekharan
> Sent: Friday, May 10, 2024 12:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Somasekharan, Sreekant
> <Sreekant.Somasekharan@amd.com>; Dan Carpenter
> <dan.carpenter@linaro.org>
> Subject: [PATCH 1/2] drm/amdkfd: Remove bo NULL check in
> gmc_v12_0_get_vm_pte() function
>
> Remove bo NULL check in amdgpu/gmc_v12_0.c:gmc_v12_0_get_vm_pte()
> function
> to fix smatch warning:
>
> 'drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c:518 gmc_v12_0_get_vm_pte()
> warn: variable dereferenced before check 'bo' (see line 500)'
>
> Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 5dcd55d390d8..df0363ad1a51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -511,16 +511,16 @@ static void gmc_v12_0_get_vm_pte(struct
> amdgpu_device *adev,
>               *flags &=3D ~AMDGPU_PTE_VALID;
>       }
>
> -     if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +     if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
>                              AMDGPU_GEM_CREATE_UNCACHED))
>               *flags =3D (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
>                        AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
>
> -     if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> +     if (bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
>               *flags |=3D AMDGPU_PTE_DCC;
>
>       /* WA for HW bug */
> -     if ((bo && is_system) || ((bo_adev !=3D adev) && coherent))
> +     if (is_system || ((bo_adev !=3D adev) && coherent))
>               *flags |=3D AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
>
>  }
> --
> 2.34.1

