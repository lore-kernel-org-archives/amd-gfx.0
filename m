Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D953C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 16:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A21D10E724;
	Fri, 28 Jul 2023 16:02:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A8410E724
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 16:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPKIAGt/6hfvA8snWY/WDm/KBaz2s2m2TQzhFD3E3jYiOOMBj2UXGGGswReSW+1lTYSivrxV9lEcGMHBEJ1DXi5GXIgnpFtlkrrzGSOLEx44S6nIQF3LrkqLQQodcCx057FrBEJu5c/ey+CuPEylOHVgehfJmjN7J5j8zZOCy8My3YvhRCrPSMtGo2JGZOCVLxipe+Ti4ScdMTgrJOO7H5Xe8dKGynHTSCF/wpDxU1IA9Jl43yBj9Ae7vlzHpk0eeZPMrQLp6fm3U3XZgRH7bqtjtXpIJNN9DxDiTbPhvo7ACMkCwMN7blrON072EOr6CBgGPwZbgw28LMRIbnFEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGfS8a2uoZFKOINa79wmv8mj3YRUundPtaakk6VTVe8=;
 b=flJyBIK562e0fl514NLlLDa3m82IQHWTIWJPKClntxSnC1hursfKxFoWTWMlDyu/iRYScVdFo35Kw9P9fsF0NqMxabCyErtRqWvZ6eEMa+ZlVhd9x26WWYd1huk46Qn0kB7CbnQMq3cNZNA/+kCeJX476DjM/jorR63NQ/ZIW9mv+eLjXKQmnVLMnG552ArMsCsw3/hxr+IkmDahQvkl0ScUL0mE3TBsp6zII/6I5R7imHwm/xlj0rzlf5KK5nFN4VALfWvp/qvy2eGj1UYsRirNgKPfL3ElCld3R5nkywSR7iYv0rSDgKxL4NOf7jQ+3wCJ6wWPo5qlbAXDV5CAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGfS8a2uoZFKOINa79wmv8mj3YRUundPtaakk6VTVe8=;
 b=JSEHvPVLlqja2wUQqoAB7AbA+WsESUJ3yLjborjCI2HqKTgRzpk2cC/3iAmMlYfMVlBSayexdjKTxP1x3Y/iFnlhUf06soKhjSaalC3aJnGxLGIEeFqG1Sv09PJnGUUC5p9xDyb0Prgn6i34QDjwwUTE3lOWInnERsuZ8FhFqR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:02:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 16:02:18 +0000
Message-ID: <7d5729b5-b4ca-9687-6a9b-8b3fffff204a@amd.com>
Date: Fri, 28 Jul 2023 12:02:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: avoid unmap dma address when svm_ranges are
 split
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230727234306.15862-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230727234306.15862-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 369f026a-0c1b-4cf6-5908-08db8f8404b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mufvPAV6UvElplqpy6YOb5WpqHYdLqIkgvFc/ygnP7sZGcPMawh1AU2ikPMwU+6+I9KD7Iu02u0Oktf88zksAG0IgbLlHPhZhBlQ/K8IesXUYI7h4TsGi03dvATban5mKeNev+sf5i53S7HjpYwbAYj67U9LBOW/fxwnvkfj9LMno5Hwgl2nIrnR+1cinECo8GqQpd0CmagH3s2QxiDRFUVICmDy1quIureBR36KGBlDlWixk9rUrxNpWdzn0MNKjCb/3g6WsKWrKR7dOoDliw81SSbOm6+AlM4jrGvBj6XUZ8Ms8i3cbrXFe/JJwNQhhWg0Wus6hoTMw+/K6NLj23hiu6Q8szGD9oJiQHeoeawzWg7uU48O3FKBt38OCS7u3qGQRuBorzGxcOPZ+63BwRkSINODQJQR3U28y8ffJoHBQpIM9kZkIIF4vgUSRxKQI5bZYHQkN3j3HDwLYySXkqObjZcrV9PqA1NLou/v6MuhesRC4CkgBuHiGYpmesIji8H89TP2yV+TnGIINOUwm7Bk56cWyYny3FZxywdcBrr2CWT+g/p+zbpydHRIV5jjpHTmWZlOy0Zv1c6Pjdp6XsSzzthnGKh50dNmghJ6H3P98FN7jKWPjWH7ku1us9vLJhuhNY468+XFi8WyH3MG7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(186003)(31686004)(36916002)(6512007)(6666004)(6486002)(478600001)(83380400001)(36756003)(86362001)(31696002)(4326008)(66556008)(2906002)(53546011)(66476007)(2616005)(6506007)(26005)(38100700002)(66946007)(316002)(8936002)(44832011)(41300700001)(8676002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0F3ZlpWVUJybVRab1RXSHBUOHFQd2ttMmViNnBFbXZyN0JCQ01PZlVjUHZX?=
 =?utf-8?B?ZFFsZXVrQTZmZGc4UHBaVGg1OFJpOUI0U3Jmd2hseUlwalJ1WlNaT3IrVVFq?=
 =?utf-8?B?T2orTmQ2a1plTjEzWnVMVHdQcDZkWWdxR0d3RjEzT1NYLzA1Vmt3VFhtUTQz?=
 =?utf-8?B?Ynk5VHpYdm95b3dkbHczY2UzYU1mcGVRNzBaOUcrT2EvNFBXNktjVGZzZ3Ew?=
 =?utf-8?B?MFgrTi9BZXNPVCtuR08wQTBQcjJETllCNEhZSk12NFhmRSt2U3h2WnU3ejlR?=
 =?utf-8?B?MmEwNXdUSzZaS1Njb3FaTFFnQnBpRXVudFhvTzV6MDk4TzF4L3ovRzdnbk85?=
 =?utf-8?B?ajloeGlOQUo5a24yaTdwb0tYejlPWlc2T3JmaTV1SnUzOVpFMnQyMWVjS0RS?=
 =?utf-8?B?cUVRMSsybklXRWE3OUJLWVpaRjZUQiswR1B3UWlKU0hCN0FodXZMcVU4cXkv?=
 =?utf-8?B?cTVVVU45aVBSOFhxQXE3NjRWQytYdzNCcDJubHpqRjlkdE9VZ1JGOGxuQVRq?=
 =?utf-8?B?SitwVnN2UEJnR2c4QVdXbkRhSVJxK0tUOThkMjlmeEFJTEVlWkM4QWV4ZThX?=
 =?utf-8?B?bWp1ZXhoTkFzMUJ2OGlsMHJEV1I3UTBYaFRwYUp1bmcyRjFzYXIrWmRiYkdp?=
 =?utf-8?B?TEJuOGg4VGR0VVdHY0IyRkRJaDdpMCtYTisxQVkrSzlPMm5KUEZQSjhsVW1N?=
 =?utf-8?B?VzZJOEI3ek1YSlRSSFZGdEttSnYrcHJxREVvdHNhTGxBZEFlUHU5blQvQzhk?=
 =?utf-8?B?dGlMUEFVZEVraEFJWG1wOEEzdnpxS000OFFadmgwWEg2NEE3ZldHclVJZ1FJ?=
 =?utf-8?B?eGdzcG1nZk9SV0hhQ3p1UGQrZXA5alViaDB2bjlWR2JwN1lvY1ZNQVRQK25S?=
 =?utf-8?B?VW03dFRlaW8zK2dkYmI5RnFiUzh4WjA2SlZNajRISzhJN0dNTGpneUQ2cXVx?=
 =?utf-8?B?WEcvQ0wraWduRTNXZjZrcEFFT1RwZi9CMXh6RTBtQmtpYVVNUUZxTU55eFdy?=
 =?utf-8?B?WGZZYVBUb3JCUE1ZOU9DOUtaZUYya21UZHJDcjRNNDRiSjRGOXlkN1h5eko5?=
 =?utf-8?B?TGFac01XM1J0UWJhQVFCN1Z5ekxZQ1FxMFBvRHhNMUVMK2FNbTBDcHM3SDBI?=
 =?utf-8?B?NWU4aklGaG5QSWp0S0hJUzA2UnhXa1prYkhUZTJ2ZGNiVVlHQ2pNR2tYeDF1?=
 =?utf-8?B?SUdnMENzenY5QVBaTUlLS3h0TGFjNDI2akdNZllsNmZDYVF6RjA2WXBGaDlF?=
 =?utf-8?B?MklaYWxRZXNkV3QwZ29HS1M4U1pOd0cwR042bkRuc1RJeThkaXZuazg4VGFB?=
 =?utf-8?B?RDZwTzRIZkRTb3hCY1VkYTZhK3BjYjBBZFlKYnVSQnJkYUs5UjNqdmhJZUZT?=
 =?utf-8?B?ZXJGVmh3S2xSQWRSZnl4Z1N4bVB0c25mZEt2RHI3L2lZUFdCZDFvVGxWMFZj?=
 =?utf-8?B?VGNBKzJ6SFhsdzBORzhUZmlvYjhINGRiMG1hTE1VbFFka1ErS0FndG83OENB?=
 =?utf-8?B?VGNhcFJIYnNtUXN4c1krU09oZkNRd1h1L3NVVjEybUU4TzFtU3NkdEJGVG8x?=
 =?utf-8?B?TkhiZ1JBM1J3ZkZ1NElISEdwSExab1FkTkFyK1MxSXV5ZFVyRHI4ekJqZk40?=
 =?utf-8?B?c3BpMytWeTBtNTBLM3RWeHArYVY1Wmk2aXlpNG4wOXMrZDhHaFhLNWVhVXh4?=
 =?utf-8?B?WmJ3NkpRbDczN1BYOWVNU1BsdlBTbHBFRWdBMEw1ZzdZWUV2TC9pMTFaZlQ0?=
 =?utf-8?B?K3g1YTljcVRtbDlZQy9GTzNlenpxUDk4Y1NZNmhBa05vYzlUZmRpcXlYamdo?=
 =?utf-8?B?anl1ZUZLVXViQThkUHVmdWxpOXIvMlFLKzhDZ3V5MDZkQURvcERaditMQ2Rr?=
 =?utf-8?B?SlloMVZzekowS2hjazVjZG04cEZrOXhuTEFsWml0MG9WZTY3ZGhETnpqRmJO?=
 =?utf-8?B?eXQxYjlIblVmSGd1b1Rpd1Q5RFZEWW1tM05CeHpjSm83L0k0UVBlZjlnb2tI?=
 =?utf-8?B?dFRWSjBDWVFoMnhOMC9uN0x5a0s0RHhyVkJQa2d1aVdPL2VZd3Mra3Y2M3pB?=
 =?utf-8?B?bDFpd2UvdFVJcWpuMTJhbDJaSGgxUkE2Vkw2MStRdkFjUG9UOWNTdnNxTERE?=
 =?utf-8?Q?QIK3UQOQlm0+WH8kamUu0JG4p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369f026a-0c1b-4cf6-5908-08db8f8404b0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:02:18.5197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wN5bHIdh5Xxc0OpE4RXhnubTtmF8tknYQdoLGfzEI/xiiDK3ZquWMpxGxqVoGRCLLMq7xIOxqCMMvFE0zdnspQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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
Cc: xiaogang.chen@amd.com, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-07-27 19:43, Alex Sierra wrote:
> DMA address reference within svm_ranges should be unmapped only after
> the memory has been released from the system. In case of range
> splitting, the DMA address information should be copied to the
> corresponding range after this has split. But leaving dma mapping
> intact.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 67 ++++++++++++++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 +-
>   3 files changed, 52 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 709ac885ca6d..2586ac070190 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -461,7 +461,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   				    0, node->id, trigger);
>   
>   	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
> -	svm_range_free_dma_mappings(prange);
> +	svm_range_free_dma_mappings(prange, true);

Do we even need to call svm_range_dma_unmap just before? Looks like 
that's done inside svm_range_free_dma_mappings anyway.

Maybe this should also be moved to svm_migrate_ram_to_vram because it 
affects the entire prange and not just one VMA. So you only need to do 
it once per prange. Let's clean that up in a follow up change.


>   
>   out_free:
>   	kvfree(buf);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 1b50eae051a4..d1ff1c7e96d0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -241,7 +241,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>   	}
>   }
>   
> -void svm_range_free_dma_mappings(struct svm_range *prange)
> +void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma)
>   {
>   	struct kfd_process_device *pdd;
>   	dma_addr_t *dma_addr;
> @@ -262,7 +262,8 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
>   			continue;
>   		}
>   		dev = &pdd->dev->adev->pdev->dev;
> -		svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
> +		if (unmap_dma)
> +			svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
>   		kvfree(dma_addr);
>   		prange->dma_addr[gpuidx] = NULL;
>   	}
> @@ -277,7 +278,7 @@ static void svm_range_free(struct svm_range *prange, bool update_mem_usage)

I'd rename the update_mem_usage parameter to better represent what it 
means. Maybe something like "do_unmap".


>   		 prange->start, prange->last);
>   
>   	svm_range_vram_node_free(prange);
> -	svm_range_free_dma_mappings(prange);
> +	svm_range_free_dma_mappings(prange, update_mem_usage);
>   
>   	if (update_mem_usage && !p->xnack_enabled) {
>   		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
> @@ -851,12 +852,46 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
>   	}
>   }
>   
> +static int
> +svm_range_copy_array(void *ppdst, void *ppsrc, size_t size,

ppdst and pprsc should be defined as void ** to avoid some ugly pointer 
type casts below. I'm not sure why ppsrc is a pointer to a pointer in 
the first place. I think it should just be a pointer because you don't 
need to update the caller's pointer.

It may also be cleaner if you return the destination pointer as return 
value instead and return NULL if allocation failed.


> +		     uint64_t num_elements, uint64_t offset)
> +{
> +	unsigned char *dst, *psrc;
> +
> +	psrc = *(unsigned char **)ppsrc;
> +	dst = kvmalloc_array(num_elements, size, GFP_KERNEL);
> +	if (!dst)
> +		return -ENOMEM;
> +	memcpy(dst, psrc + offset, num_elements * size);
> +	*(void **)ppdst = dst;
> +
> +	return 0;
> +}
> +
> +static int
> +svm_range_copy_dma_addrs(struct svm_range *dst, struct svm_range *src)
> +{
> +	int i, r;
> +
> +	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
> +		if (!src->dma_addr[i])
> +			continue;
> +		r = svm_range_copy_array(&dst->dma_addr[i], &src->dma_addr[i],
> +					 sizeof(*src->dma_addr[i]), src->npages, 0);
> +		if (r)
> +			return r;
> +	}
> +
> +	return 0;
> +}
> +
>   static int
>   svm_range_split_array(void *ppnew, void *ppold, size_t size,
>   		      uint64_t old_start, uint64_t old_n,
>   		      uint64_t new_start, uint64_t new_n)
>   {
>   	unsigned char *new, *old, *pold;
> +	int r;
>   	uint64_t d;
>   
>   	if (!ppold)
> @@ -865,22 +900,16 @@ svm_range_split_array(void *ppnew, void *ppold, size_t size,
>   	if (!pold)
>   		return 0;
>   
> -	new = kvmalloc_array(new_n, size, GFP_KERNEL);
> -	if (!new)
> -		return -ENOMEM;
> -
>   	d = (new_start - old_start) * size;
> -	memcpy(new, pold + d, new_n * size);
> -
> -	old = kvmalloc_array(old_n, size, GFP_KERNEL);
> -	if (!old) {
> +	r = svm_range_copy_array(&new, ppold, size, new_n, d);
> +	if (r)
> +		return r;
> +	d = (new_start == old_start) ? new_n * size : 0;
> +	r = svm_range_copy_array(&old, ppold, size, old_n, d);
> +	if (r) {
>   		kvfree(new);
> -		return -ENOMEM;
> +		return r;
>   	}
> -
> -	d = (new_start == old_start) ? new_n * size : 0;
> -	memcpy(old, pold + d, old_n * size);
> -
>   	kvfree(pold);
>   	*(void **)ppold = old;
>   	*(void **)ppnew = new;
> @@ -2075,7 +2104,11 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   				r = -ENOMEM;
>   				goto out;
>   			}
> -
> +			r = svm_range_copy_dma_addrs(prange, old);

This should be in svm_range_clone instead.

Regards,
   Felix


> +			if (r) {
> +				svm_range_free(prange, false);
> +				goto out;
> +			}	
>   			list_add(&old->update_list, remove_list);
>   			list_add(&prange->list, insert_list);
>   			list_add(&prange->update_list, update_list);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 21b14510882b..9e668eeefb32 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -183,7 +183,7 @@ void svm_range_add_list_work(struct svm_range_list *svms,
>   void schedule_deferred_list_work(struct svm_range_list *svms);
>   void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>   			 unsigned long offset, unsigned long npages);
> -void svm_range_free_dma_mappings(struct svm_range *prange);
> +void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma);
>   int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
>   		       uint64_t *svm_priv_data_size);
>   int kfd_criu_checkpoint_svm(struct kfd_process *p,
