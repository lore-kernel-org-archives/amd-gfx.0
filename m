Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B495BC83F11
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 19:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB3210E09F;
	Mon, 28 Aug 2023 19:06:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 941EF10E09F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 19:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPeULiq3QQjHWLoMf7AmhsbTKmVP00IPtwhl0/9YiX6RTIQjWwp6dHdeUiFgTXmH5cQnI86owC0ifpBUD71XGTLqgTetYFa7Stqq8dPd+4hq4yYjwBVtcQO5ogKsBPW+dTbsi9STvsrFpC2t99vRpvqezbVNTLGqepE8lqm/h/hKKMKUZyYytItikelNQE6SPj+XIPu4yVNnJU+dwIs+frTKRdMLnco7R1Va/bvLj+3nTzZqc99z+TByqZbrMKoCVUnlq4iRZwQGvc7syx9V7QKQWUyPH6RXMDLM+p5VS6brkOolceiBKQ41/UpmOzY4repNre3otPtdl+CO2bUe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFbDjwPyt5jzgkyX/eYvQG0zNGtMD8UYOnegCl/v0w4=;
 b=B2/ftFlWsAZGBCrVQFm8I9Wp162RMMsy1yhdQdeob/k7f+ed+Tg0BRcq+lU3o74e3zY3dNND8GZkFyaAjrSwxLg5woylOtLzC/1QfheBTMzjaVzLrKWi8MBIPR8F2CNqM9iZncsY1iDXo3rsjEuESOhKfswwmlZ9ndr+/Nauq38+RZIB5ZEIs+9kD07Mq951Wn2g6TUZu7aHzB/Z2Ur3DT9cML/nrZEqmjQAZPT58PYANcTvZDkhVjUW/OuZU1E0LpAlFMdlvTt2McOFJnmEnD3Gedby9o7ezb3/ObonsXa3wZTPDIDs8RvTyEkkBKGVepXvTQDyOxpPuf4UzEhdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFbDjwPyt5jzgkyX/eYvQG0zNGtMD8UYOnegCl/v0w4=;
 b=CrxedH8cdXu2Fp4k6ZRUlwlFAA0WsNO/qg4jhqtKpDndC2NHuXDjgTutNcr0sWG7IDCQzEnwVuJ8iTfnamgJEbwoAnWzbKOby8J+v21C2qV+WgZfeV4GoAmvJAGlaEEfxcqjBASm9qL7rQGW4cWMCuCrRXln+p4WVuMy63ckVOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 19:06:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 19:06:23 +0000
Message-ID: <d31985b2-74d9-2536-2995-7b693928d443@amd.com>
Date: Mon, 28 Aug 2023 15:06:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230824220834.362948-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230824220834.362948-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc54efa-bcc2-49e6-48ae-08dba7f9dea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnpkQIP4tpPOCINnlnfRlllSLjF/hHpHFVsy5GLLkmk1oPfxRhE3DuMFMVCXwCsnLKqH7quJ/yZCOf9IvgIhKaNOg5vgzA02SnhCZ+LPOqX8pcj+Afz8WnKf2u0Z2vP1SGB063TpBSzqrrYJaV2tUJZIBY9wJi5Mr2BxWbyhfjvTv+tyJmyeEiZBRheyHiQzo2rP82nGJcWgZVZcWr1ylGwvj3jTcaMAQkUDv3MfdVJ7EP+8aI34ioUY8pX/Gef/xDfsoO9yGiTcLI8YruoQEk8y+qPEsyQ3EygnIlDa7J+sKMg6o1vnWM4YpYD7NrqWSNKKfG3AFIh8oaGrfo+Rdw1LkpGd6DqVdonqltzkhCnHhLe2DInzFgU13B1+16zTP8KJy6vJt/w2onXRwvTrCiZH2o2hCYjVc11Of60Kh4EeVIkW//ywoXIvCsio1ziLh1ksVmbAGO8PkRPbTJhDjuY1UHXtjrj6JtdK7c2I90MQswlkrzKezKwiD8tEUW6gbfdwUdsI3K5QvtH2uXccJw9vuUmDcNN08q6Vbns6lNlPr3liR1L3b3qL2pBU3hhsHCvdLkcE7uxsMT+czMAv4s9pyZR21jHMJSlAsLVYgNlTyVV30ZRKRXpLHJhnZI+Si4UWtzS8Th2ESCUNfIRijw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(396003)(39860400002)(376002)(186009)(1800799009)(451199024)(41300700001)(26005)(38100700002)(31696002)(86362001)(478600001)(83380400001)(2616005)(6512007)(6506007)(6486002)(36916002)(30864003)(53546011)(36756003)(2906002)(66476007)(316002)(66556008)(66946007)(5660300002)(4326008)(8676002)(8936002)(44832011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjNVYmZYalZDVjVlRktIV2JxL3dnWVFpTUxWL3NQcmMrRkhuY2h3aXB4Q1pZ?=
 =?utf-8?B?eXdJRllkbkZQSWgyZzRIMyswVWVva1BpYXBlNVJKSFRCUVVCZVNCMmU1bCsr?=
 =?utf-8?B?TCtWNjdaZmRwS1lXcVZMYUM2RmRaSDhqUHRvRkt0a1VCL3dFWFI1RG5oZTFJ?=
 =?utf-8?B?cW82TUtPdWZtUEw5RXlxNUxkbEJ6Q3FPOStSZ09xdnRxckpQQllyZDYwSEk3?=
 =?utf-8?B?QjBjUVc4WGpkd0dSQlpzeVVCSWFBaTBOOTJnRDZJNGVPcGNoMUkzNHVJL0U5?=
 =?utf-8?B?VDAweXJma1BsLzU1eHAwNmQwQVN1UjVHbXFMYnhKZkJyRERDTmZEZ1l0dkdY?=
 =?utf-8?B?WWRtVjZqLzVKSjlMdVNSMlN5UTFqdEx5K21CM1c1aDZBUTRCUU1FQUI0RVl6?=
 =?utf-8?B?dnVLZUF1Z1lTb0E3WjA1aUFHRGR5RDVuVWdBMEl4cGE2SUZOTm9zZWZ4Q2ov?=
 =?utf-8?B?S2lyc21RTWxvNXpUQjg5UkVyOUFiU3FocC8ySUVEaWZZT0NUaVZ3RDI2K0c5?=
 =?utf-8?B?VGlYMWdRL2xQcW9RaUMyS0VOUlM2Qjlrc09SU2tBenEvL3ZjYlVUOFRVemlz?=
 =?utf-8?B?Y2MvbEF1SW8zZGlTa2swR2pzSElNYTJpN0Y1S2QrREZkanlrZUxOa0Vaekll?=
 =?utf-8?B?eWhkWTZiN2gvWlBia0JEcXNDa1pPTjZKMW9zbkZBWVZ4cGphTkpHTXhMc0RF?=
 =?utf-8?B?clI2QXBSeVNrVTBBQkI0LzFhVGVDWHoyU3BqUXdMNVJ3U3pJMFZqVmdCZWor?=
 =?utf-8?B?bmNFQ1JGa1E3MnVzWW44OVBxRE05aHpBOUxZU3B3OFRsQWJhUzdPQWYwS01L?=
 =?utf-8?B?STZaTmxrRGhuU1ZPUENnMEpEbE5yWkFIbWN5SkFWMUtkMnI4elJZUHBBQmxq?=
 =?utf-8?B?WHJhYVNRZjNHbFBwOWQrYXN1ZCtrV3hpTWVYVHFidEhoNlJtM3dkRlJXaGNB?=
 =?utf-8?B?QklwWGtJazBNL0krVm5scmpjVUg4OWlBZTdvMkYyenc2bkFXWmpkbmZydUs4?=
 =?utf-8?B?UXdaRVhFT1JnNmFOazJ3cWg5blJMSkMrTU1SQUFFU0wzNERsMHB4SkZTdmtr?=
 =?utf-8?B?aTUrYktDdHJKT0Q5SVdjSjlVK0lMV2dxWitPUUNCcDJBMjQwTEF1MW1hRmpX?=
 =?utf-8?B?SjA2WVhSUTloNDh6V0NHRFpRd2JWRUxiZkdaT2Jad2doc2Ewc05OT2ljSFZq?=
 =?utf-8?B?ci9GUkxJRVFpdUNXaU10clJkVng5OXhRNjVUcEdHdVBkY2hTaU10azNXQXJR?=
 =?utf-8?B?cmpXakhiKzh1b1pxZk9zSkhGUWtsN0R2SzRKR3VkWm1pRTdpUHdpbzVjMnFa?=
 =?utf-8?B?U3RQSjhSTUcwT3NhelFZWU5mcmFyUmVEWVhiSDUzbm9TQmVsY0RrYUErU1dC?=
 =?utf-8?B?ZVhGeHdYc0dHU0k5NHNpVnhEVTVkVXg0V1dyS21OcmZ1SDFBY2l0VHhWU1hY?=
 =?utf-8?B?VmVVTjZsNnRrT0d3MU5DbmpZRmwxVzVqWVNNZitDMDlwNkJZU28zSkVlTVZo?=
 =?utf-8?B?cmJJRUFHYTg0bkpxYStuTFIzNjh3K3RlaWhGc1lwZWtKY0ZTS0NkNmxpYXJH?=
 =?utf-8?B?SDVsQXJ2TFFjaFZMN2NXMVRVU2JPOEJkWnFIU0x0cGFOSEJpckhmZUgxNjJv?=
 =?utf-8?B?Zlp5M1cvQmRsQkt5UWljQ05oQmhFb1AxZWwzd28zTzUyVE9YV2ltT0FxTFRW?=
 =?utf-8?B?aGo3MWZBRGRTNWF2VEFYU3JkSTRrdzBmd1NUY21kYTFFUk5VMTBEdXdEM2E1?=
 =?utf-8?B?YW1SbThWRWdWVEM1eVIxNHkzSDN2anc3SGhUVmxlWU9rNk9jcDkvUEZwYWxB?=
 =?utf-8?B?RnZNNEc0c2M0Uk1VWS9hNnZIWHNNZUZVM0NnYUE4c21XWVJ5WWVCTkxwbG05?=
 =?utf-8?B?OTBDbkMzTFB2TGdwYWlkWUkxZXZxLzBGdDE0d09JVXZ3d0VLc0l1dm1USjV3?=
 =?utf-8?B?MEhyVnNaYklzNUJmU1FBT1JyWW8rUVhKMjRSNmtuRDB4ak5Cdm91YW5zMDdo?=
 =?utf-8?B?eG1YZkZFMFAySlFaRHlBcDdDTG9wQnNPUnJmWkMyR2FQbFBPRHUvQUtBRWUy?=
 =?utf-8?B?RnpwTEljc0srUENXSGxWQzIyYnRnYUo2RFc3emM0bmlWZi9PYWJvNURyeHpO?=
 =?utf-8?Q?W7iOBW/FcbHNPCGKkm/IEXk5W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc54efa-bcc2-49e6-48ae-08dba7f9dea5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 19:06:22.9342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmc90/WqPqQyjGM1wwKc/5Fn4/XLDEca4RQnd4JyvD8CtUAkPD7MmmjCpxWGkJoymAw5S3dYj9RnCjNx+VIIZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-08-24 18:08, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> This patch implements partial migration in gpu page fault according to migration
> granularity(default 2MB) and not split svm range in cpu page fault handling.
> Now a svm range may have pages from both system ram and vram of one gpu.
> These chagnes are expected to improve migration performance and reduce
> mmu callback and TLB flush workloads.
>
> Signed-off-by: xiaogang chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 153 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  87 ++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   7 +-
>   4 files changed, 162 insertions(+), 91 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 7d82c7da223a..5a3aa80a1834 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -479,6 +479,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>    * svm_migrate_ram_to_vram - migrate svm range from system to device
>    * @prange: range structure
>    * @best_loc: the device to migrate to
> + * @start_mgr: start page to migrate
> + * @last_mgr: last page to migrate
>    * @mm: the process mm structure
>    * @trigger: reason of migration
>    *
> @@ -489,6 +491,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>    */
>   static int
>   svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
> +			unsigned long start_mgr, unsigned long last_mgr,
>   			struct mm_struct *mm, uint32_t trigger)
>   {
>   	unsigned long addr, start, end;
> @@ -498,9 +501,9 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	unsigned long cpages = 0;
>   	long r = 0;
>   
> -	if (prange->actual_loc == best_loc) {
> -		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
> -			 prange->svms, prange->start, prange->last, best_loc);
> +	if (!best_loc) {
> +		pr_debug("request svms 0x%p [0x%lx 0x%lx] migrate to sys ram\n",
> +			 prange->svms, start_mgr, last_mgr);
>   		return 0;
>   	}
>   
> @@ -513,8 +516,8 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	pr_debug("svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n", prange->svms,
>   		 prange->start, prange->last, best_loc);
>   
> -	start = prange->start << PAGE_SHIFT;
> -	end = (prange->last + 1) << PAGE_SHIFT;
> +	start = start_mgr << PAGE_SHIFT;
> +	end = (last_mgr + 1) << PAGE_SHIFT;
>   
>   	r = svm_range_vram_node_new(node, prange, true);
>   	if (r) {
> @@ -544,10 +547,12 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   
>   	if (cpages) {
>   		prange->actual_loc = best_loc;
> -		svm_range_free_dma_mappings(prange, true);
> -	} else {
> +		/* only free dma mapping in the migrated range */
> +		svm_range_free_dma_mappings(prange, true,  start_mgr - prange->start,
> +						 last_mgr - start_mgr + 1);

This is wrong. If we only migrated some of the pages, we should not free 
the DMA mapping array at all. The array is needed as long as there are 
any valid DMA mappings in it.

I think the condition above with cpages should be updated. Instead of 
cpages, we need to keep track of a count of pages in VRAM in struct 
svm_range. See more below.


> +	} else if (!prange->actual_loc)
> +		/* if all pages from prange are at sys ram */
>   		svm_range_vram_node_free(prange);
> -	}
>   
>   	return r < 0 ? r : 0;
>   }
> @@ -762,6 +767,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>    * svm_migrate_vram_to_ram - migrate svm range from device to system
>    * @prange: range structure
>    * @mm: process mm, use current->mm if NULL
> + * @start_mgr: start page need be migrated to sys ram
> + * @last_mgr: last page need be migrated to sys ram
>    * @trigger: reason of migration
>    * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
>    *
> @@ -771,7 +778,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>    * 0 - OK, otherwise error code
>    */
>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
> -			    uint32_t trigger, struct page *fault_page)
> +					unsigned long start_mgr, unsigned long last_mgr,
> +					uint32_t trigger, struct page *fault_page)
>   {
>   	struct kfd_node *node;
>   	struct vm_area_struct *vma;
> @@ -781,23 +789,30 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   	unsigned long upages = 0;
>   	long r = 0;
>   
> +	/* this pragne has no any vram page to migrate to sys ram */
>   	if (!prange->actual_loc) {
>   		pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
>   			 prange->start, prange->last);
>   		return 0;
>   	}
>   
> +	if (start_mgr < prange->start || last_mgr > prange->last) {
> +		pr_debug("migration range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
> +			 start_mgr, last_mgr, prange->start, prange->last);
> +		return -EFAULT;
> +	}
> +
>   	node = svm_range_get_node_by_id(prange, prange->actual_loc);
>   	if (!node) {
>   		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
>   		return -ENODEV;
>   	}
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
> -		 prange->svms, prange, prange->start, prange->last,
> +		 prange->svms, prange, start_mgr, last_mgr,
>   		 prange->actual_loc);
>   
> -	start = prange->start << PAGE_SHIFT;
> -	end = (prange->last + 1) << PAGE_SHIFT;
> +	start = start_mgr << PAGE_SHIFT;
> +	end = (last_mgr + 1) << PAGE_SHIFT;
>   
>   	for (addr = start; addr < end;) {
>   		unsigned long next;
> @@ -822,8 +837,47 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   	}
>   
>   	if (r >= 0 && !upages) {
> -		svm_range_vram_node_free(prange);
> -		prange->actual_loc = 0;
> +		/* all vram pages from prange got migrated to sys ram */
> +		if (start_mgr == prange->start && last_mgr == prange->last) {
> +
> +			prange->actual_loc = 0;
> +			spin_lock(&prange->svm_bo->list_lock);
> +			list_del_init(&prange->svm_bo_list);
> +			spin_unlock(&prange->svm_bo->list_lock);
> +
> +			svm_range_vram_node_free(prange);
> +		} else {
> +
> +			/* cannot call svm_range_vram_node_free since only part of its vram
> +			 * pages got migrated. check if all vram pages from all pranges
> +			 * that shared this svm_bo have been released, then unref
> +			 * all svm_bo ref count.

This feels wrong and I don't understand why it's necessary. The point of 
ref counting is, that you don't need to know what the other ranges are 
doing. Each range manages its own reference to the BO. When it no longer 
needs the BO, it drops its reference. When the ref count drops to 0, the 
BO gets freed.


> +			 */
> +			struct svm_range *tmp;
> +			unsigned int count = 0;
> +
> +			/* how many prangs refer to this svm_bo */
> +			spin_lock(&prange->svm_bo->list_lock);
> +			list_for_each_entry(tmp, &prange->svm_bo->range_list, svm_bo_list)
> +				count++;
> +			spin_unlock(&prange->svm_bo->list_lock);
> +
> +			/* if svm_bo ref number is same as count above all vram pages from
> +			 * all pranges have been released, unref svm_bo count times
> +			 * from all pranges to force svm_bo released

There is probably a possible race condition here if a range gets split 
concurrently. Or a page gets migrated between the ref count check and 
taking the list_lock.

A better way to handle this would not need to look at the other ranges 
at all. What we really need to know is, how many pages of this range are 
currently in VRAM. We should be able to track this with a new counter in 
struct svm_range that gets incremented or decremented by cpages at the 
end of every migration.


> +			 */
> +			if (refcount_read(&prange->svm_bo->kref.refcount) == count) {
> +
> +				spin_lock(&prange->svm_bo->list_lock);
> +				list_for_each_entry(tmp, &prange->svm_bo->range_list, svm_bo_list) {
> +					spin_unlock(&prange->svm_bo->list_lock);
> +
> +					svm_range_vram_node_free(tmp);
> +					spin_lock(&prange->svm_bo->list_lock);
> +				}
> +				spin_unlock(&prange->svm_bo->list_lock);
> +			}
> +		}
>   	}
>   
>   	return r < 0 ? r : 0;
> @@ -833,17 +887,23 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>    * svm_migrate_vram_to_vram - migrate svm range from device to device
>    * @prange: range structure
>    * @best_loc: the device to migrate to
> + * @start: start page need be migrated to sys ram
> + * @last: last page need be migrated to sys ram
>    * @mm: process mm, use current->mm if NULL
>    * @trigger: reason of migration
>    *
>    * Context: Process context, caller hold mmap read lock, svms lock, prange lock
>    *
> + * migrate all vram pages in prange to sys ram, then migrate [start, last] pages
> + * from sys ram to gpu node best_loc.
> + *
>    * Return:
>    * 0 - OK, otherwise error code
>    */
>   static int
>   svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
> -			 struct mm_struct *mm, uint32_t trigger)
> +			unsigned long start, unsigned long last,
> +			struct mm_struct *mm, uint32_t trigger)
>   {
>   	int r, retries = 3;
>   
> @@ -855,7 +915,8 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
>   
>   	do {
> -		r = svm_migrate_vram_to_ram(prange, mm, trigger, NULL);
> +		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
> +					trigger, NULL);
>   		if (r)
>   			return r;
>   	} while (prange->actual_loc && --retries);
> @@ -863,18 +924,20 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	if (prange->actual_loc)
>   		return -EDEADLK;
>   
> -	return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
> +	return svm_migrate_ram_to_vram(prange, best_loc, start, last, mm, trigger);
>   }
>   
>   int
>   svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
> -		    struct mm_struct *mm, uint32_t trigger)
> +		unsigned long start, unsigned long last,
> +		struct mm_struct *mm, uint32_t trigger)
>   {
> -	if  (!prange->actual_loc)
> -		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
> +	if  (!prange->actual_loc || prange->actual_loc == best_loc)
> +		return svm_migrate_ram_to_vram(prange, best_loc, start, last,
> +					mm, trigger);
>   	else
> -		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
> -
> +		return svm_migrate_vram_to_vram(prange, best_loc, start, last,
> +					mm, trigger);
>   }
>   
>   /**
> @@ -889,10 +952,9 @@ svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
>    */
>   static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   {
> +	unsigned long start, last, size;
>   	unsigned long addr = vmf->address;
>   	struct svm_range_bo *svm_bo;
> -	enum svm_work_list_ops op;
> -	struct svm_range *parent;
>   	struct svm_range *prange;
>   	struct kfd_process *p;
>   	struct mm_struct *mm;
> @@ -929,51 +991,34 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   
>   	mutex_lock(&p->svms.lock);
>   
> -	prange = svm_range_from_addr(&p->svms, addr, &parent);
> +	prange = svm_range_from_addr(&p->svms, addr, NULL);
>   	if (!prange) {
>   		pr_debug("failed get range svms 0x%p addr 0x%lx\n", &p->svms, addr);
>   		r = -EFAULT;
>   		goto out_unlock_svms;
>   	}
>   
> -	mutex_lock(&parent->migrate_mutex);
> -	if (prange != parent)
> -		mutex_lock_nested(&prange->migrate_mutex, 1);
> +	mutex_lock(&prange->migrate_mutex);
>   
>   	if (!prange->actual_loc)
>   		goto out_unlock_prange;
>   
> -	svm_range_lock(parent);
> -	if (prange != parent)
> -		mutex_lock_nested(&prange->lock, 1);
> -	r = svm_range_split_by_granularity(p, mm, addr, parent, prange);
> -	if (prange != parent)
> -		mutex_unlock(&prange->lock);
> -	svm_range_unlock(parent);
> -	if (r) {
> -		pr_debug("failed %d to split range by granularity\n", r);
> -		goto out_unlock_prange;
> -	}
> +	/* Align migration range start and size to granularity size */
> +	size = 1UL << prange->granularity;
> +	start = ALIGN_DOWN(addr, size);
> +	last = ALIGN(addr + 1, size) - 1;
> +
> +	start = (start >= prange->start) ? start : prange->start;
> +	last = (last <= prange->last) ? last : prange->last;
>   
> -	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
> -				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
> -				    vmf->page);
> +	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, last,
> +				KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
>   	if (r)
>   		pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 0x%lx]\n",
> -			 r, prange->svms, prange, prange->start, prange->last);
> -
> -	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
> -	if (p->xnack_enabled && parent == prange)
> -		op = SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP;
> -	else
> -		op = SVM_OP_UPDATE_RANGE_NOTIFIER;
> -	svm_range_add_list_work(&p->svms, parent, mm, op);
> -	schedule_deferred_list_work(&p->svms);
> +			 r, prange->svms, prange, start, last);
>   
>   out_unlock_prange:
> -	if (prange != parent)
> -		mutex_unlock(&prange->migrate_mutex);
> -	mutex_unlock(&parent->migrate_mutex);
> +	mutex_unlock(&prange->migrate_mutex);
>   out_unlock_svms:
>   	mutex_unlock(&p->svms.lock);
>   out_unref_process:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> index 487f26368164..9e48d10e848e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> @@ -41,9 +41,13 @@ enum MIGRATION_COPY_DIR {
>   };
>   
>   int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
> +			unsigned long start, unsigned long last,
>   			struct mm_struct *mm, uint32_t trigger);
> +
>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
> -			    uint32_t trigger, struct page *fault_page);
> +			unsigned long start, unsigned long last,
> +			uint32_t trigger, struct page *fault_page);
> +
>   unsigned long
>   svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 841ba6102bbb..012dceb7c0ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -247,7 +247,8 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>   	}
>   }
>   
> -void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma)
> +void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma,
> +				unsigned long offset, unsigned long npages)
>   {
>   	struct kfd_process_device *pdd;
>   	dma_addr_t *dma_addr;
> @@ -269,7 +270,7 @@ void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma)
>   		}
>   		dev = &pdd->dev->adev->pdev->dev;
>   		if (unmap_dma)
> -			svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
> +			svm_range_dma_unmap(dev, dma_addr, offset, npages);
>   		kvfree(dma_addr);

This doesn't make sense. If we only unmapped some of the DMA mappings, 
we should not free the DMA mapping array at all, because that would mean 
leaking all the DMA mappings we did not unmap.


>   		prange->dma_addr[gpuidx] = NULL;
>   	}
> @@ -284,7 +285,7 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   		 prange->start, prange->last);
>   
>   	svm_range_vram_node_free(prange);
> -	svm_range_free_dma_mappings(prange, do_unmap);
> +	svm_range_free_dma_mappings(prange, do_unmap, 0, prange->npages);
>   
>   	if (do_unmap && !p->xnack_enabled) {
>   		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
> @@ -384,6 +385,8 @@ static void svm_range_bo_release(struct kref *kref)
>   			 prange->start, prange->last);
>   		mutex_lock(&prange->lock);
>   		prange->svm_bo = NULL;
> +		/* prange dose not hold vram page now */
> +		prange->actual_loc = 0;

This is probably the wrong place to do this. The caller of 
svm_range_bo_release should probably update prange->actual_loc before 
calling this function.


>   		mutex_unlock(&prange->lock);
>   
>   		spin_lock(&svm_bo->list_lock);
> @@ -439,7 +442,8 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
>   		mutex_unlock(&prange->lock);
>   		return false;
>   	}
> -	if (prange->ttm_res) {
> +	/* requeset from same kfd_node and we still have reference to it */
> +	if (prange->ttm_res && prange->svm_bo->node == node) {
>   		/* We still have a reference, all is well */
>   		mutex_unlock(&prange->lock);
>   		return true;
> @@ -458,6 +462,8 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
>   			spin_unlock(&prange->svm_bo->list_lock);
>   
>   			svm_range_bo_unref(prange->svm_bo);
> +			prange->ttm_res = NULL;
> +			prange->svm_bo = NULL;

If this is really necessary, it should probably be done inside the 
prange->lock.


>   			return false;
>   		}
>   		if (READ_ONCE(prange->svm_bo->evicting)) {
> @@ -2888,6 +2894,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			uint32_t vmid, uint32_t node_id,
>   			uint64_t addr, bool write_fault)
>   {
> +	unsigned long start, last, size;
>   	struct mm_struct *mm = NULL;
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
> @@ -3023,34 +3030,38 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>   				       write_fault, timestamp);
>   
> -	if (prange->actual_loc != best_loc) {
> -		migration = true;
> -		if (best_loc) {
> -			r = svm_migrate_to_vram(prange, best_loc, mm,
> -					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
> -			if (r) {
> -				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
> -					 r, addr);
> -				/* Fallback to system memory if migration to
> -				 * VRAM failed
> -				 */
> -				if (prange->actual_loc)
> -					r = svm_migrate_vram_to_ram(prange, mm,
> -					   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
> -					   NULL);
> -				else
> -					r = 0;
> -			}
> -		} else {
> -			r = svm_migrate_vram_to_ram(prange, mm,
> -					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
> -					NULL);
> -		}
> +	/* Align migration range start and size to granularity size */
> +	size = 1UL << prange->granularity;
> +	start = ALIGN_DOWN(addr, size);
> +	last = ALIGN(addr + 1, size) - 1;
> +
> +	start = (start >= prange->start) ? start : prange->start;
> +	last = (last <= prange->last) ? last : prange->last;

This could be written more compact:

	start = max(prange->start, ALIGN_DOWN(addr, size));
	last = min(prange->last, ALIGN(addr + 1, size) - 1);


> +
> +	migration = true;

If you make this always true, we don't need this variable any more. But 
see below ...


> +	if (best_loc) {
> +		r = svm_migrate_to_vram(prange, best_loc, start, last,
> +						mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);

Maybe we can add an output parameter to svm_migrate_... to return 
whether an actual migration was performed (based on cpages). That could 
be used to update the migration variable more accurately.


>   		if (r) {
> -			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
> -				 r, svms, prange->start, prange->last);
> -			goto out_unlock_range;
> +			pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
> +					 r, addr);
> +			/* Fallback to system memory if migration to
> +			 * VRAM failed
> +			 */
> +			if (prange->actual_loc)
> +				r = svm_migrate_vram_to_ram(prange, mm, start, last,
> +							KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
> +			else
> +				r = 0;
>   		}
> +	} else {
> +		r = svm_migrate_vram_to_ram(prange, mm, start, last,
> +					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);

This is only necessary if prange->actual_loc is non-0. And again, this 
could update migration with an output parameter based on cpages.


> +	}
> +	if (r) {
> +		pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
> +				 r, svms, start, last);
> +		goto out_unlock_range;
>   	}
>   
>   	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
> @@ -3402,18 +3413,22 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
>   	*migrated = false;
>   	best_loc = svm_range_best_prefetch_location(prange);
>   
> -	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
> -	    best_loc == prange->actual_loc)
> +	/* when best_loc is a gpu node and same as prange->actual_loc
> +	 * we still need migrate as prange->actual_loc does not mean all
> +	 * pages in prange are vram. hmm migrate will pick up right pages.
> +	 */
> +	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
>   		return 0;
>   
>   	if (!best_loc) {
> -		r = svm_migrate_vram_to_ram(prange, mm,
> +		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
>   					KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>   		*migrated = !r;

This could also use an output parameter from svm_migrate_vram_to_ram to 
update migrated more accurately.

Regards,
   Felix


>   		return r;
>   	}
>   
> -	r = svm_migrate_to_vram(prange, best_loc, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
> +	r = svm_migrate_to_vram(prange, best_loc, prange->start, prange->last,
> +					mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>   	*migrated = !r;
>   
>   	return r;
> @@ -3468,7 +3483,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   
>   		mutex_lock(&prange->migrate_mutex);
>   		do {
> +			/* migrate all vram pages in this prange to sys ram
> +			 * after that prange->actual_loc should be zero
> +			 */
>   			r = svm_migrate_vram_to_ram(prange, mm,
> +					prange->start, prange->last,
>   					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>   		} while (!r && prange->actual_loc && --retries);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 9e668eeefb32..c565e018cfb3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -88,7 +88,9 @@ struct svm_work_list_item {
>    * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
>    * @perferred_loc: perferred location, 0 for CPU, or GPU id
>    * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
> - * @actual_loc: the actual location, 0 for CPU, or GPU id
> + * @actual_loc: this svm_range location. 0: all pages are from sys ram;
> + *              GPU id: this svm_range may include vram pages from GPU with
> + *              id actual_loc.
>    * @granularity:migration granularity, log2 num pages
>    * @invalid:    not 0 means cpu page table is invalidated
>    * @validate_timestamp: system timestamp when range is validated
> @@ -183,7 +185,8 @@ void svm_range_add_list_work(struct svm_range_list *svms,
>   void schedule_deferred_list_work(struct svm_range_list *svms);
>   void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>   			 unsigned long offset, unsigned long npages);
> -void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma);
> +void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma,
> +			 unsigned long offset, unsigned long npages);
>   int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
>   		       uint64_t *svm_priv_data_size);
>   int kfd_criu_checkpoint_svm(struct kfd_process *p,
