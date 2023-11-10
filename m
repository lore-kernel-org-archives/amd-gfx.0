Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1F9C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 14:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6813E10E05E;
	Fri, 10 Nov 2023 14:14:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF3410E05E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 14:14:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+Pzp5pJQX0xqZitES8vPdu19xrpN7L/4H9yjcP/GW/LS/fpaZ84tVK5dy+5gkMBgj0Mhqg/Qpvg2Tv+Q0lMVvde4iaF0aZbBMRpNPExajI1eSnI3Ie2ZdbeGiqfIiPgC1AmHyEQCBwHSUeOpXv5q163d3KTBd2rWP8BgxQbHbbQ6wU4t53gpQgRHrNrbRMViItKkIfwMfwXiBxiuHlOB42Vv8am3FB9GuUbHZF1G7+Yu4n4FC/80+HO0Dpi/aJIgnI0OTqpI97ibhOXr0NYuVY6Uxk8FZjUOKg4Z42E6TUKMwGTDqYXxbnENY1e4FZyzFYsrPwu9d571uSD/ekw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8u8eJVGYNlOXHnj7aEjnft7W7oR2DgGAxv+5jJ5Lbc=;
 b=A9NiqSqC79W66bAly3OoUVfSaYtqiyQeipskpNraXuQJ/Enpa/wfDaDdC5Btha/iyJW8rilyYcOYH3bdYyIo6/zvhxp9Q/n3FCSbJu8NeQl6hS/jlR08N1lqEBFBP+vHkyHQBzfxRwXzIB8NJEb9PvXNrcaLrE/22bI3NG/Oj7Q/4ZtYkjAEclOh1XDuydFG3nkIL5ze+zPrEdfS9XBrr7tvqtYeWRpnEhx2nMUHSvcRndZ/BJE+yF39VEPrOIkkr8dHtoni7QzWo3WLKbny5fIrFm8eJV7etj2Z41FxNUY2PLM/lXIzK9iM90SHL3AOV1K32gXOvZivArKsxlhs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8u8eJVGYNlOXHnj7aEjnft7W7oR2DgGAxv+5jJ5Lbc=;
 b=I7e2S6a9gr0d/Wit3kj4YAc8UHSK3xZ80aXJRHIAPxWUu1Ql/UXRA1fLm0d4GuRAvKnv9m0ZMm+Pk2DZ3hc7g6MJMMK88fauH2Y3fmMcSZB+bfgOb+tyPagbDv0tYyDaPQzyaWcbaANlIj1ZwHWSzSer+6/CvjO82KhbSA/743M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 14:14:15 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%6]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 14:14:15 +0000
Message-ID: <82453041-8033-4d14-be82-ecfe7fce9f27@amd.com>
Date: Fri, 10 Nov 2023 15:14:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: exclude domain start when calucales offset
 for AGP aperture BOs
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231110125225.2512174-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231110125225.2512174-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: c35925ef-a82c-452d-095a-08dbe1f751fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/Wkm2eINORIdBeKQaiDaxnqVWZKYxdin4pYeZNMLGyATr6gGvKa6e0Go1/kDlihd6V+b2icMx5urA0eQBEwYm0+2NMD8JT6YEGpOhTzneRExvCAR7zEeptxnwCgDEGvMnnIbcWOrjb4BY958xjHPwebT3EbUnM3I8EWsJ1KgnP7+AHDqD64J3e8maVtmpi9yCRRHX0HCuJaXu3XRtNofaPMh9EJk6+Zn1Ervts2jQIXLKHhmzJCb/j0h6647cYvrL39WgF7Yohp3HyBGFTJP3pFqbGIRLyBJP17sKFOmRSl5B725zA6hYv2iPWWZHzR3ypBoT0/CnNaYuXOctsYf6FFppOirNau4tzfaAGAfTV8kR78xdo98lkfnimPk24LIVSGT7bxTJAY2ovPnloRbdKpOqg2Hc7ARNTD5/ezWvVhkby0cKiyNF3DFeRLqR6jf8XyiUwq+kvlEeS5y7H4YbI4kQxqwHjtBYpCgQ+NzV5GQMQ2yX4nw+9YubhxXnpfRM0g5Ydc9Jqcy5B1X0mHSbPAKzkkgwwPZnEx4R5qvgfOPNzAcn5V2RprtRO7bxrzqX2FC8mZQV11kpiXEXC6QOUzNjRJi8HjooJ+8MentVw4DbcYOAgYD83xTdsx1VF6+9S/VaLMtpBjyw/K1JNR6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(41300700001)(4326008)(5660300002)(36756003)(8936002)(8676002)(86362001)(31696002)(6486002)(2616005)(478600001)(6666004)(26005)(6512007)(6506007)(83380400001)(38100700002)(66946007)(66556008)(31686004)(66476007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFMvaGtISXhhcVk5d2xmZ3ZBOWZWcXFrOVZBOTNTUHZ2Ry9oR05wN1draERL?=
 =?utf-8?B?dnRlb0lJNzhPNUVQeEkrY3UrdGx0NDlxcHZXY01ERDhsMGRMdU5HdE9ySEdY?=
 =?utf-8?B?R003ODc0NE9xMXlQWjdRVE1xdVJqRXhwRkNnSjIrT0FUaEhSSStrZ1FWZk94?=
 =?utf-8?B?ckxlOVVkUTZJdWdud3VYT1ozdnh0OW40dE4xbStTWW9JWHhlQy8xdThyMU1u?=
 =?utf-8?B?MmUvangzS2FzQW5xK2dZZzZiRGNYME40enl5SzE2RUhScFhxSG53MWJNazl1?=
 =?utf-8?B?MHhVSWR0NWdkekx6UWZINWlMS2pFZUNoRDR1c3BaV0dCbGJQWmdBUVNQblVv?=
 =?utf-8?B?SEVnSzlMZkFicm5KN21jaG4xM1drUlVVWUJBRmhJSVdvWnl0SlBhOGdQdzdL?=
 =?utf-8?B?S09hM0hzODFRNjQ3QzNxL3Y1Rk1nUDFwNXlOVlh5azBrb2xEZFJ3anlQTG1I?=
 =?utf-8?B?RlI3YmZNMkFybHlock03eWZnSmtyN0VVV0ZDbmNHaXBnNGN5N08wUTVUU0Nk?=
 =?utf-8?B?Rk5uTG9wYTNLUUZ5Y3NneW16YlhqVzFvajZYOWxDdEQydUhNMHl2VmRob2x4?=
 =?utf-8?B?NjdOOGlENERyUnBWYVVjRWNPaklJb0VONG9Kbm1NUThRcnYvZm5QMXk4K1NU?=
 =?utf-8?B?eGVUYisxWWZPc0RxYUtWM0p4VklHS3lHMFZxS1gwWTJpaGV2WlBrTVB6cEJy?=
 =?utf-8?B?S2xQdndRYkhoYzVlQjRjVHQ5TVdnbFgvRnhXWE5pMUJmSDFTRk9ER0dUQnY5?=
 =?utf-8?B?anlqRUtaUFBPNGRxZUFwQkZsR1BOajJNaUhaQ09VNHR4aWFrWnQ0OXNaNzds?=
 =?utf-8?B?UER0c1JsQjc3OFNlMjZ0cDVBYXAwKzlBMGtYL2dpalRaSkg2OFg1bE9hUzR2?=
 =?utf-8?B?bXp1amUzcFRiaUtxN0FWVzFBR05wS0tUcHl6SUdyNUthRzZJbmVCV2tJYlZm?=
 =?utf-8?B?TXVhQ2JCQXg2b1hrWElqVWNzZXdrZ0htOHBGeEh3TVprY3J0Qm10azBpRUhu?=
 =?utf-8?B?VlBIeEoxcU5uTG5PaWQxNHdHK0hNT3VnSndGK0QvSjlTTDI2bnE2cExyeFY3?=
 =?utf-8?B?a1ZWRjlYKzFVNnZCemxmYnZoZ2VVZTZHZkxVTi9UUytwdFV4Zy8zMnBCQklp?=
 =?utf-8?B?QzV2NUVMamVPK1BCKzFMTFBzL2pqSjhBNFhHMWFUOFJuNjVlV1lLK3daSE4w?=
 =?utf-8?B?NGlIU3pZUjRxNzhjQ1pmUndEYWV5c1Y2NHo4UDlNWDFNbEMyUVlEU1hNNmN2?=
 =?utf-8?B?N1hBVWh4SERCRTFTWXU4OS9idXBRRVkrQnNvK0VrdzRHZWh5eExEMHZyYklN?=
 =?utf-8?B?T2ZxNmRmME9kNzBwRm1Ub2tvYWtTWE5SYm1yRUhaQVJseUcrRjN5STc0ZXhU?=
 =?utf-8?B?ZHBka3BwMXhoaFNpKzROcmlHY01ZSERQMDV1TFlXeEZoc3VmU1ZjMVFWQ3Rq?=
 =?utf-8?B?bTlVQ0Y1R2Z1OFJEOVczaTRIV3N1bGwybmJTSjZ5U1cvcldFcm54NUZBL2NL?=
 =?utf-8?B?ZFZHUUIxYzY4QUNoNVNEOXI1a2dVK1VIOGUyYnloY013ZFN0RmF0NHJYdTYr?=
 =?utf-8?B?SUZpU3E1anVwc3g4ek5odGhkM1VydlFwOE5zYmFteWFmQlRDS3JHak9jdWx6?=
 =?utf-8?B?eHVxaUFZUkgzclp5b2hIZFh1SFJVcUJTTWZxV0djNVNCakxnL3luUUYvNTdU?=
 =?utf-8?B?Yy9SYSt3V1JGNmZlaUJSL2IzQndsbWNBaUpuRWIxMG4rV0hIQ0NEZ1M5WDl4?=
 =?utf-8?B?bVZxY0xwNjkxUndTVGpkdEtXSmsyZWFyUXBwaDlmTVdoaHY2aVFuUytERHZU?=
 =?utf-8?B?d0ZjaklBUXphMlRnSHdwNEdhc3B0eEhQMTZydnk0WUY2VnRWdWdTY2pUY1ZD?=
 =?utf-8?B?d25INmREbERuRGxKVVNpRzlkMzV5YURJMVhjRWpIYTBZT2dkc0NleUljbUNE?=
 =?utf-8?B?QitLZHFoRG0vaW5IY0hoTkVqbUhkK0xITzNocENrN01FUDFEb3pVK3YvMEll?=
 =?utf-8?B?MVF3SVloYVp5TXZpWnBpc09ZTzQ1dnNZRkZ0TVVja0VrdlBRQ3VERld0OE90?=
 =?utf-8?B?UXFJb0RLOFk4Tk1WVTIwaDhtbkhrdlBTSk9tQ1JKVUdEUVBFSE9id0VEQ2hr?=
 =?utf-8?Q?+s1s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35925ef-a82c-452d-095a-08dbe1f751fb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:14:15.3458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUes4p6OMsfhJ8qU8VX4ikSJIX5aHoLMLodnSTxT3n+SkdWxW+U8J9oL2XhBdRWu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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
Cc: Alexander.Deucher@amd.com, Jesse.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.11.23 um 13:52 schrieb Yifan Zhang:
> For BOs in AGP aperture, tbo.resource->start includes AGP aperture start.


Well big NAK to that. tbo.resource->start should never ever include the 
AGP aperture start in the first place.

How did that happen?

Regards,
Christian.

> Don't add it again in amdgpu_bo_gpu_offset. This issue was mitigated due to
> GART aperture start was 0 until this patch ("a013c94d5aca drm/amdgpu/gmc11:
> set gart placement GC11") changes GART start to a non-zero value.
>
> Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ++++++++--
>   3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 5f71414190e9..00e940eb69ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -169,6 +169,13 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>   	return 0;
>   }
>   
> +bool bo_in_agp_aperture(struct amdgpu_bo *bo)
> +{
> +	struct ttm_buffer_object *tbo = &(bo->tbo);
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
> +
> +	return (tbo->resource->start << PAGE_SHIFT) > adev->gmc.agp_start;
> +}
>   /**
>    * amdgpu_gmc_agp_addr - return the address in the AGP address space
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index e699d1ca8deb..448dc08e83de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -393,6 +393,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>   				uint64_t flags);
>   uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo);
>   uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo);
> +bool bo_in_agp_aperture(struct amdgpu_bo *bo);
>   void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc);
>   void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>   			      u64 base);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index cef920a93924..91a011d63ab4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -39,6 +39,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_gmc.h"
>   
>   /**
>    * DOC: amdgpu_object
> @@ -1529,8 +1530,13 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	uint64_t offset;
>   
> -	offset = (bo->tbo.resource->start << PAGE_SHIFT) +
> -		 amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
> +	/* tbo.resource->start includes agp_start for AGP BOs */
> +	if (bo_in_agp_aperture(bo)) {
> +		offset = (bo->tbo.resource->start << PAGE_SHIFT);
> +	} else {
> +		offset = (bo->tbo.resource->start << PAGE_SHIFT) +
> +			 amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
> +	}
>   
>   	return amdgpu_gmc_sign_extend(offset);
>   }

