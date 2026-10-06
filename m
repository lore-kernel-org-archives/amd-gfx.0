Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B5ACA5FED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 21:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A03310E467;
	Tue,  6 Oct 2026 21:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4yLukQnt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACEAD10E467
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 21:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXSfa4lM7DbbyTr53DmV8Gx5frzH3iTabrOb6OmIWnVKF2qWLjFl7Z/Lf7pe6U34wRhNykqBrqMUdf7y98eY9udTp2mUS7PBW3muT1M3nL3mZrKFLW065vDWIQKG0oRA68gzbcEoajhOjvJsJse3kNW8qbVdp7bsZPBjKJlQQGfSPQ7TB4Oh6GiNGHxphIrRO1GYwBIboJBDZpIcrevuRkzqdHVHFMwMNmj3lFkck/mC5iz/swfqFT6+PVAgRegWKss2xZA6IzBX8+tNA1MhY+W2TZuF/YQL4Jn1mTfNeKV2jxUOiOEx3DPZuLTi8MUL8M7Kl2PDbaGkWl/TmfAMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmMVYQI3BewpAfruxcZ0z6b4nPCK25FyCW61IG9qVPw=;
 b=EzP3ZzpiBr7yHZWfRmxZxT9baHKoqcVGFBiIGTB39YiC1ZR4THie+r5wN0xddmdj5Q3InXWdERvnXKxZAQmmzk77BjzrdbbOc9rg30mhDszjG+ZaCdxxMraoTTZFJVQEwEekddAi+VkRsDe1f3W3w0tHWQJmOI5FcqIySRl+3KpkMOnh6H8GcofblIH0FZfgXbCUJx7mmtSsleapcyel0hB4TBvO+mE6E5NZScheF0xzdkqYtZut1G1zAQYVTWVQovbnmVvp4FmUUUMgAKrkXDx5+b/Jex83Qdkb2KIEnMyA1DdT+iiGIYvuCpWX03+Wkb9wPOFFMisDRilIIYWoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmMVYQI3BewpAfruxcZ0z6b4nPCK25FyCW61IG9qVPw=;
 b=4yLukQntSRtfZiW1u+Mswzjmp5tU7sFgCQ4LaaooDtyUMmqmaj1o+Vs7/yl1VYnurTJoMETnDR1jzwxpkyRibKyveJ0PVlIXZ352PTVoev2fPqoNdUWZ0FA6DHpDZckAVtFhMtWpVAMVVWzCmLYYQpDIKQwSey5I56JoRO4sg5g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SJ1PR12MB6025.namprd12.prod.outlook.com
 (2603:10b6:a03:48c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 21:40:16 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 21:40:16 +0000
Message-ID: <225421e2-3ab1-4c6c-b229-6c59dcb4bcbc@amd.com>
Date: Tue, 6 Oct 2026 17:40:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/amdkfd: Add awareness of THP of device and
 system RAM in kfd svm driver
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260904195421.42919-1-xiaogang.chen@amd.com>
 <20260904195421.42919-2-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260904195421.42919-2-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::28) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c56689-ac9b-492e-7a4a-08df23f26957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|10067099003|11063799006|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: LP1hxlRKEd+Iuoa5tPmVSHRvN56gLkSEI9XVzFSPtL7pfcCe8hq6x/CBpyKQDtEiHr1qK+9Z19pRFVj6qqE0qomnlDRhpuRqh9Y+rwFQwBzALRFvkdPbr8wRCXvqoIH8u4+LImQtdAZrrxdl3J5/OSoeXuPx4TikeYfNq7Wmqa03OYgu20iOjNPREp6DssgN6OwpzatBhcL9CKako51wC9d+IWn1+mHfiJTkET4+WsLmQ9JVQbXXjV3xlEPDGe6ofOzELt6TUazuLkQm2X/tzQPChgNYJHwTUtoaFHMCfE5Ik6io2UsN8dqWkKwLPgXpQmfo+9u9xbn4V0RpEoLG7zigFvrwWGJB2u7JplMOIfa1K0BOMhHNENzjAtwKS9lcWUwD8Du0fXESzjGWpAXK4GM+NG6w/ES/6td9AR2lBb4q9W3z/X7haDBfOdpDhrORGYuWf0ZI0Kc38cjmpYljo6qKCUegVG3PlCFHtiDSgOhCq1uizRT7UCn1MIcCtmDcbMzlxzez6W49F3MO4e/nupncKm3RXkBSu4a2HuWzAGJZ7Lf3T6s3IRKme6gxZG7tHahipYE0093FTV6Mg1rhKGoRDs5yntvGuysXYJrfyn/fklYmtTb/JO5dvxJOj8bMwVAQAm74MSxLC3I63y5R5AuLwJxxlyTGOU6uCp6PWTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGFsdG1OeTA0dmorUXpJSGJwZkZVK013N0pyZ0ltclc0Z2VBWWp1cHdIVE1x?=
 =?utf-8?B?ZnM1aHhpRGJSTFBKOXhwWEMrblRsdGlxQStYZnJVK01uUkdiaTk4ZWRhU09l?=
 =?utf-8?B?OXVLR2VKcExBd1BPSHROejlNeHlkb0RjbkpYU1oyTS92alFKNVY3OFh2RTIv?=
 =?utf-8?B?RlpSN0Q0VzFSMmhhT3FhaUNISmNESEh3VDVFWEtIZVQxUjdhNjBqaGFrTlJR?=
 =?utf-8?B?RFVCbUducHhzRDVKUy83YUZPM0VPUGVEM2M2M3h1N2JYdDBvS1NKRzBmT01I?=
 =?utf-8?B?bUZXbDNnYVYzY25UUGpNL0RGclRqY3c3MCtXZVZBbW5yTGpqZERKa0I4T2pW?=
 =?utf-8?B?V2ZQVFNnQWFPSjJEOWV1bXQxU2lHQjBNTzJady8vYmhmQnViRnVxOWZUUjh6?=
 =?utf-8?B?aGJrRWlYbjlTL0lpNHdBc0Q5K3pBbFdUY05tUEIrYXZBNFVHbGpaYndINTkw?=
 =?utf-8?B?Tyt3NlN4N1pBR1ExaU5qMzFNR3BHMjJwa3BzbmZralVDdTFFUkZiY0J3TFNT?=
 =?utf-8?B?SVAxWVBYMlB6clU2YzQwc1NNd1pRa1ZZNjI0UzA5aGFwN0JkL1FYWWhuWnNI?=
 =?utf-8?B?NEJ4MlVYUC9GdWxGMHAxd1hXa1hIKzliYTRNQ29UYjZwSUZJV3FzM3RGeWNK?=
 =?utf-8?B?em1aeHgxaE9aSGFoT1BYUlBaUDk3eW92L0Qxek5ib1JKWGxsT1pKdU9YR2dk?=
 =?utf-8?B?a2EvQzVsL0NxVEFQbm5KbzlHMTVrVEZ6QzcvajEraklqNlZUbUE5ZFRManI3?=
 =?utf-8?B?c0xWOUdXYWpWbG4yOC92MWRJVEVYeUpwQjJWZWhBbk13cWNvczdoaUdDb01o?=
 =?utf-8?B?MlhEQnRUa2IzelZTK0xOY21Zby9zRENmN3dTaWhrMVVHVDJPVGlobSt4a3k4?=
 =?utf-8?B?eXhjTnd6aU9KZFFBVTFSSitjU0hVN0tQam5FTm15a0NWa3hZWEJtRkVBTDcy?=
 =?utf-8?B?bk85K1BjYUtycWF4MzNLRGNWcXZsU3Z5bDE2ZDFLL1U3TVJQN1lKUW9SZVpS?=
 =?utf-8?B?UGhOUUVhaVA1TndJYzJZV0grWWUxOUk4ZTkrejMzSk9UUWRiZTAzVi8vbTNR?=
 =?utf-8?B?dDM5dmpUUnRoOGNEU3hrTmhpR0VKSG9PYkpSK25zV0gxSnRwK2NBWGh1ejBS?=
 =?utf-8?B?eHRHWTlRVlpzMG02QVNYNjFQZ2pEaVppdmRRYkd4YkpDWFJBR1pmam1IdnJy?=
 =?utf-8?B?WE5tSmhoNUNuWXVmVjM4N2tYSWQ4NE5qTS9DTlRWZnFEUm9IMFZpVktKU0dY?=
 =?utf-8?B?Z2NZTTREbmlpdktRdmx3Q2NrM2dSV3FBYnRqNjQwZHhNd3I1bzByY3BJVkda?=
 =?utf-8?B?czA2ODFLRkoyL2Jad0tNUGlvbERJQXlScitWSSswRUl4cXNSUThaaFlYSHZB?=
 =?utf-8?B?eTFiNHJITjZmYzhyVTJzWWZUdU1mR0dNcVBCSUduNGFwR0JCOTYyNWl2N1Jv?=
 =?utf-8?B?VitMSmtxRHh0RFZHby9HQUVSaTBlVHBQN0ZWV01HRXpNekZybTd3amVqOEVi?=
 =?utf-8?B?K3ZMNVBDWU5GcDNLYXk3Z01ZamhmS3U3NVc1K0tlaXRteHJlK0RxZmx4b3Rr?=
 =?utf-8?B?aGg2eHZLRjRiZlV1dTJ2eE5pTzhyZ01ocytWMG1DbkJnZ3RJOEZTRVhGK3cr?=
 =?utf-8?B?b1hWVzY1SXVod0xMTlI2M252UWNkMEpHZlowUHhYNTF1R1E5ckY4WEkvQmd1?=
 =?utf-8?B?YVpDamhJZytwLzEzcGpMSXdvTE9ta0ZML1Vjck5nVnk2TnMwUjh5dXVTTzhi?=
 =?utf-8?B?NGxTMDdCaWlpWklRMVR4Q0ZKQUVYSGdRZlgzaVhzZHlvcEdJQTNBMVhENDNU?=
 =?utf-8?B?UnJaN2NpK3JtaFJTc3lGN3FBcjBwRVRBd2tPdTl6N25EQktLVGRieXd4Wi9H?=
 =?utf-8?B?NXVEZU4yNnh5SHFOa1lvZG5KU0EzR09US2FEenhpZDhnY0hGRUZobHNvOE9j?=
 =?utf-8?B?dHE5RkIxZHdHVGk3K0RnQTdoQmRhVlMzS2RzQ3RTTkxrYlRLU0RBSU1RVzFj?=
 =?utf-8?B?czFMRU51eG1ISEIzVEVDNmlkSy9VTzNnUFJoRSt0NFJ5UkJpdUxOUlZucHJP?=
 =?utf-8?B?VkpoRGhpN3B1T09zVWtHSHpuTmZqQXRCaVlvQ1l3UzRYcFluaVl3S3FYTnho?=
 =?utf-8?B?ZUQzYzk5UGJ4d0ZUc2xsc0RPZStPNThFOVVkR1F4WUZOUzdKTU1sSWdmYzFU?=
 =?utf-8?B?ZkNqZWFrS1l0MldHeFl5bzdTOTN0bkUzRTNJaDBBWHRIVDl5bGtTeVova3Fp?=
 =?utf-8?B?UnhVSStaNzB3TFlFZEltSkRZWEtINDAzS1VoTi91N2FmY2hmaDQyamVrbVhu?=
 =?utf-8?B?dHR0K0VPbHJ4S0t2eVhkWE1DVTVpV05DZ3plTG1ZR1UvWkkydWR4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c56689-ac9b-492e-7a4a-08df23f26957
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:40:16.7781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNZTwuJpCSUlr1gz6QMM3pNPY26jTndJFyl0oDfcIOtxwzr+Vq8nPdroDcOyaC9QUyJruZ7z+J9gpt1TA1LLQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
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

On 2026-09-04 15:54, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Extend kfd/svm function to allocate HPAGE_PMD_SIZE based device memory by buddy
> allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned and to allocate THP
> system ram by vma_alloc_folio.
>
> Introduce SVM_RANGE_DMA_THP flag that indicates dma map of THP. THP dma
> addresss will use this flag.
>
> Add dev_pagemap_ops->folio_split callback that is called by folio_split when
> core MM splits device memory folio.
>
> These are preparations for following support for (THP) migration of zone
> device-private memory, no function change.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 50 +++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 15 +++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
>   3 files changed, 54 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 253365a8257e..813f3c1d29dc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -217,14 +217,19 @@ svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
>   }
>   
>   static void
> -svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
> +svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
> +			   int order)
>   {
>   	struct page *page;
> +	struct folio *folio;
>   
>   	page = pfn_to_page(pfn);
> +	folio = page_folio(page);
> +
> +	zone_device_folio_init(folio, folio->pgmap, order);
> +
> +	folio_set_zone_device_data(folio, prange->svm_bo);

I see that folio_set_zone_device_data checks that folio is 
device_private. This will fail for device_coherent pages. We can't use 
this function without breaking MI200 A+A.


>   	svm_range_bo_ref(prange->svm_bo);
> -	page->zone_device_data = prange->svm_bo;
> -	zone_device_page_init(page, page_pgmap(page), 0);
>   }
>   
>   static void
> @@ -247,11 +252,17 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
>   }
>   
>   static struct page *
> -svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
> +svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr,
> +			  unsigned long order)
>   {
>   	struct page *page;
>   
> -	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
> +	if (order)
> +		page = folio_page(vma_alloc_folio(GFP_HIGHUSER,
> +						  order, vma, addr), 0);
> +	else
> +		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
> +
>   	if (page)
>   		lock_page(page);
>   
> @@ -265,8 +276,12 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
>   
>   	for (i = 0; i < migrate->npages; i++) {
>   		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
> -		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
> -			mpages++;
> +			migrate->src[i] & MIGRATE_PFN_MIGRATE) {
> +				if (migrate->dst[i] & MIGRATE_PFN_COMPOUND)
> +					mpages += HPAGE_PMD_NR;
> +				else
> +					mpages++;
> +			}

Please fix the indentation.  This is one tab too deep. The alignment of 
the condition should remain unchanged.


>   	}
>   	return mpages;
>   }
> @@ -300,7 +315,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>   			dst[i] = cursor.start + (j << PAGE_SHIFT);
>   			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> -			svm_migrate_get_vram_page(prange, migrate->dst[i]);
> +			svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
>   			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>   			mpages++;
>   		}
> @@ -568,6 +583,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	return r < 0 ? r : 0;
>   }
>   
> +/* folio can be compound folio or single page */
>   static void svm_migrate_folio_free(struct folio *folio)
>   {
>   	struct page *page = &folio->page;
> @@ -630,7 +646,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			j = 0;
>   		}
>   
> -		dpage = svm_migrate_get_sys_page(migrate->vma, addr);
> +		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
>   		if (!dpage) {
>   			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>   				 prange->svms, prange->start, prange->last);
> @@ -1033,9 +1049,25 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   	return r ? VM_FAULT_SIGBUS : 0;
>   }
>   
> +static void svm_migrate_folio_split(struct folio *head, struct folio *tail)
> +{
> +	struct svm_range_bo *svm_bo;
> +
> +	if (tail == NULL)
> +		return;
> +
> +	tail->pgmap = head->pgmap;
> +	tail->mapping = head->mapping;
> +
> +	svm_bo = folio_zone_device_data(head);
> +	folio_set_zone_device_data(tail, svm_bo);
> +	svm_range_bo_ref(svm_bo);
> +}
> +
>   static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
>   	.folio_free		= svm_migrate_folio_free,
>   	.migrate_to_ram		= svm_migrate_to_ram,
> +	.folio_split		= svm_migrate_folio_split,
>   };
>   
>   /* Each VRAM page uses sizeof(struct page) on system memory */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fa4054d51f60..6b783d12bce4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -245,7 +245,16 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>   			continue;
>   		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
> -		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
> +
> +		/* dma unmap of THP */
> +		if (dma_addr[i] & SVM_RANGE_DMA_THP) {
> +

Unnecessary empty line.


> +			dma_addr[i] &= ~SVM_RANGE_DMA_THP;
> +			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*HPAGE_PMD_NR,
> +                                   DMA_BIDIRECTIONAL);
> +		} else
> +			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);

The else-branch should also use {} braces if the if-branch does.


> +
>   		dma_addr[i] = 0;
>   	}
>   }
> @@ -578,10 +587,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   	}
>   
>   	memset(&bp, 0, sizeof(bp));
> -	bp.size = prange->npages * PAGE_SIZE;
> +	bp.size = ALIGN(prange->npages * PAGE_SIZE, HPAGE_PMD_SIZE);

This wastes memory for small ranges. Maybe guard this so it only applies 
to ranges that are larger than HPAGE_PMD_NR pages.


>   	bp.bo_ptr_size = sizeof(struct svm_range_bo);
>   	bp.destroy = svm_range_bo_destroy;
> -	bp.byte_align = PAGE_SIZE;
> +	bp.byte_align = HPAGE_PMD_SIZE;

Same as above. There is no need to align smaller allocations.

Regards,
   Felix


>   	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>   	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>   	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index c7d7adae4476..f2b3a05cd8cf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -35,6 +35,7 @@
>   #include "kfd_priv.h"
>   
>   #define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
> +#define SVM_RANGE_DMA_THP (1UL << 1)
>   #define SVM_ADEV_PGMAP_OWNER(adev)\
>   			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
>   
