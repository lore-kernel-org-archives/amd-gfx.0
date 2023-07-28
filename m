Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09747EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 22:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8F610E084;
	Fri, 28 Jul 2023 22:45:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C0F10E084
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 22:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6CGK7NAgl0OcfU25wHwueMqXn/QXGm7OVGarHuHjvGRkAagKla9gzRt1UPHUeJ94r7j3cLnO9DEuO3uM36vyo5IuF7zT/glWAEGZZLU0zaZEI6xCBH8EYE6vQ1mEjgrIj6WIF3gbTGFDn/ZXM5lwx8a0nCTf+9peop7ZRgGxldQcI6xH/kVMeHasQs0/FTIg5g9OiPnFJABPmKolF2IiiR/utLf2POwZRBozXjf9DmmNs3fnsZnudrpFX+s3KdQ5dQp8LpcjaLltduaIZcLJZ57rgF3mhZPsjGk599s7iGsY17zx4FbNZ16YQwEU1K40yGuI5noyRsEH+Pr9PVeSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlgX7RQNEbgo+bmXbrRtY067z+kItdmdqXyIsQIGlrA=;
 b=Y236MSkygqNWqZFX9K9NhrwwtZfPGEBrO+pyu7uC3G5bRSsqeLIVmd5wfs15k9fX0MjQIcHZ+aiflbNZVNCxSTzlE1RZTBa/kM1FupAsX3qWGzKzYtvvChbY5abxyzo0iZYRihJdc2vDhKMA/6RNDPQcuupJzgtU95iJVYHK+nFFiKXmULhFbIb+xAca4ymFgBc8mcwf6vQwGMEtMvwcNnfVKmyiR4YiOVvokLorZfII0seh9GZNvI3I5zUNlPF3jkOOJdkR3LkKcGzgGT2BQ8LvhJEhRMSb+lBvvqbazvM4qPhiaQd+rBswXAVNaZ3qFobM0EXNul2+mcpByGYgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlgX7RQNEbgo+bmXbrRtY067z+kItdmdqXyIsQIGlrA=;
 b=5jplFUDshOudczI69547UmaBRrUwLMkznCSGoIJ2VuQGyiX4NxVHh1bhOFQGAPQ2mHZCGsMCg/muGa91QYY9m8ZfCEUW0myKJyJuicFLKQwHIlc1uR5x2gSPEIMcygPfRWWBhniUrUMGj6Tjhqi6WR1dq0JvvZ1FLDV2uNTICTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 22:45:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 22:45:50 +0000
Message-ID: <54ca8ea3-6702-e87b-333f-d771900f235a@amd.com>
Date: Fri, 28 Jul 2023 18:45:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: avoid unmap dma address when svm_ranges are
 split
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230728214157.17697-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230728214157.17697-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8a1723-7641-4188-ba0c-08db8fbc6473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g4UVkf8eAnrmv8sBpAdr5itULcnhcYnDcGlSmH2/0SmOTyGfxmwou6/lMMss86Na6SqGlerufDyM9e7kLpueDGbnmXRNQwkSTehi/8q11SroaDQVvhvVr1Atra3ZfNCSlrNyeolluVMz0krd8SUuG5uZQkb5dw5F/RIsfyuE/MZWelB3QzsKqkBfpX9aBJHdB4n4AhIsa5UUBfN/SBl+i9oXV11pCX1AfN+zb5iYpNWlF+X8wz3Q/1kIVqaNy97ZsyV8eh8sDdNpeJPAdUWB1xvtM2Wc1zgLzDplMQFk7ZECrv+2nYZ3sVRs0W0reVSR2IEZVAWp/9Qi6iIvhEZUftziLYJxLWCVXq6lQCa4aIHh9/DNt3124mfqAB1eaOw9XDanxqr91DpMc30zG0AK8y7zS964h61Guf9PsC/w4aTXb/wib+JFNdsKWDkCBTXWFp8RAqx2c0EZwz30goMK8KNTP+8jHA+E+6Cntd8+nOQR0+oTiIUyFZ+9nNaXZAosMq0UJ2J55qVD2R+pswTuNVZNKLlBzvdBDHP1xUjmlyTieIeSNE049HeBqn4VKBWWyD91hish+v/u9RWUUR8KPsBsBbvsu+2JoJn4Yk3AUTncOtLZh61+zNPPSleJ7w+yqvTuR5mFfz4JKtE1CvaqKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(36756003)(86362001)(31696002)(2906002)(44832011)(31686004)(186003)(83380400001)(53546011)(2616005)(6506007)(26005)(6512007)(66556008)(38100700002)(6666004)(36916002)(478600001)(6486002)(8936002)(4326008)(66476007)(316002)(5660300002)(8676002)(66946007)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0wzL0NHd25tdFJvRndBb0t5L3VLdU42SXVaalhRVmNYaXhzbjI1aVlKVzlJ?=
 =?utf-8?B?elBFcS9hMmhNWnFhOWx5ZGRUbnRlVTdJU2ZqWEorYVdneW9RcENFbXVsSXVS?=
 =?utf-8?B?ZXhjRDlUc1l2T25KbFZCa3dsZEd3MkFzNHNOSXdlYm91dTVFN0NpMnp6Vk8z?=
 =?utf-8?B?eU9jVW02ayt0TDZCN3NYcXJtR1VWZ1JZNnkxOStBbnNLcE4zWGp6YmtDTGRa?=
 =?utf-8?B?K1Z5d3JiVGRWQklxRFNJUUhObkxVWG1vVzN2QUZoQUQyZDVOUEVUVjZXaThi?=
 =?utf-8?B?bVRVQ0dRamw1cWxmem54Yzh4aVpFZkkxcHpKaXIyS0I2ZEF6QnBJTkdtTk15?=
 =?utf-8?B?aHlTOUZKaVYzSG4xbzNKTnAyWTdhL2hvc1gxenNkWDcvK2FiMG9yQy9xOWts?=
 =?utf-8?B?WkFZTEtDL1l4cVhxb1NmRkNXZzVJUDljMGZjaWtxYU1PeEo3QkVGVUhQK0hs?=
 =?utf-8?B?cjQrQXlyMmd2N2UrMUZlejBRVmFEZ0Z6SjEvY1RrMjdFS0wrOG4rNTNkakli?=
 =?utf-8?B?TkVYN0xOMnliUUVNRk5ITjM1QmdSclc0NzFpd3lWd0lVc1RzNy9NVmVYdGw4?=
 =?utf-8?B?M0dpVC9UYmV2WDR4V0tzWTRrcXZud1Rwd2ZHSk1ZVW5vVGR6WFZhUWo4RGtn?=
 =?utf-8?B?LzdYOHltdEJtY0grN2NwVDR4dWlEMElpbzFiMktQQ29JTmVCaVdldVJFM3dY?=
 =?utf-8?B?cXltNzZydTNrcFNWODRCd2ZsSXRadTZtT09JZzBJcXFXUmNOUktGL2tFWUZR?=
 =?utf-8?B?WHRZZkhjQ0NKTmxyL0dkZ1hrWWo0ODFnN2dRRHdZdjAzWXhXUDZxN0dpdnhM?=
 =?utf-8?B?SHkyamdmTkVPU3lRTEdGMHV6UG1ZT0hUNWtJckRyc0JqUlFiUWlZSnNWU0Vk?=
 =?utf-8?B?UmZUd2paamJzck5ERjJrWXJpVTJLckpUQkprMGpCRGlUdjRqcEJIWml3TEkr?=
 =?utf-8?B?SGoxRmpvaFJGcndjZHEyM2xieWRndFBVSjFrWVZ4VmlidGg4TG5SWjdWdVlE?=
 =?utf-8?B?S0tETXJIZlBHYThYWjVJbjMyWG44bnhLdnFWMzF2dWhpYUNPLzdaWGc3Wmk4?=
 =?utf-8?B?Q3VHTEI1Y09MK3JHQUFQOFBmMTZkbGN3MFpTSC9KU3dXSkVzd1lUOTFFV3BI?=
 =?utf-8?B?enBKQWJSTUxYanRqVWFBRXdId0kyRWJUZ2EvZHMxWmpTd3dkZk9lQ0hFenhT?=
 =?utf-8?B?N3M2UXVGN1o0OTlrUE95WUNKSXBIcjdpQ3dnS0ljTU55bmtRMGRod245ZUpK?=
 =?utf-8?B?dVdWM1VaYW12LzV4azZuZUswcnM0Y0Q2amd1aFVWTnZsVFJNeVc2dC9jSjFh?=
 =?utf-8?B?d1BmaDI1SytpN1U2S1RHWjV3VStDaDZ3R1hzYXVWclFVdHcxMG03TFVZandY?=
 =?utf-8?B?aEpBNUlYRHFqaWFoTFJRRzVLV1hPMGpLVEtjRzE2akdCejNLOHNPTWJlWnNw?=
 =?utf-8?B?aU9VTzNRZFUwTjlkU2twUGlTSWxjODg2T1h2S3Y2bTM5eHJPMVdCaHgxSTBS?=
 =?utf-8?B?ZnR2ME5MTHJCTnhERStidHhlUUgrR1lVaUIzcmNaM3plN05EYlFKVHhPRU5l?=
 =?utf-8?B?NHVDVTRicVlla2d4L3VNTUtZQUcvdmhUNXJsbXhrdHVFTDl4UFkyME1pWlht?=
 =?utf-8?B?cTN1ODRHa2pYTDNjMjl1QjB2aFlWaDlZSGVjMkFjVFE5SkZnZDN3T2l4a3Vu?=
 =?utf-8?B?eTZGSUR4NXJMMktPZlVFejZFOWxNZDlHN2ZJTGxNQW0xQ0xDS0w5WXBxa2VR?=
 =?utf-8?B?cnlxdUxVcGducERMREFMSlZidVJrWkxuMmFnZlhnMDVVcW8vbDgrU3p1b0RP?=
 =?utf-8?B?VnY3OU10Ni9NOVFhR3hyTDVkWFM3QXEzdFRmbklJSkZKNGZRU01HbUhsV0Y4?=
 =?utf-8?B?NVVla3hXMnRkOVpHRm4yajhBWnBLaE1leDRoSXJDVDJpY2VvZlUwQk04QWlt?=
 =?utf-8?B?Ny9yY3FmNTNFV0NyNkpTSjVyYkppU2dvamFKMlA1N0pFZmNBLzZvOE1Sb2VL?=
 =?utf-8?B?UldRWG83dE0vaHA1KzFBa0lyUHY5UU5vdk5wMmFxN2lBUXJZclZ0ejQvMUJu?=
 =?utf-8?B?VWpMbmxiSWlMekFEbW1qNXhkMWZORU5TSGpRU0tXQWU4WWQxMkdmL2NIbUVo?=
 =?utf-8?Q?Xtx6qBZyu3MBciaggdhMF44kR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8a1723-7641-4188-ba0c-08db8fbc6473
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 22:45:50.6460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlFjqGwWSXFDDyXu0ukds8Ztt1etNJs7wVGtBJuwP/+2xs1qLRkdd6Pur48NqdkQ0RwWfJaBpCBqecSW5ks68w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092
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

On 2023-07-28 17:41, Alex Sierra wrote:
> DMA address reference within svm_ranges should be unmapped only after
> the memory has been released from the system. In case of range
> splitting, the DMA address information should be copied to the
> corresponding range after this has split. But leaving dma mapping
> intact.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  7 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 61 +++++++++++++++++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 +-
>   3 files changed, 50 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 709ac885ca6d..7d82c7da223a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -461,7 +461,6 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   				    0, node->id, trigger);
>   
>   	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
> -	svm_range_free_dma_mappings(prange);
>   
>   out_free:
>   	kvfree(buf);
> @@ -543,10 +542,12 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   		addr = next;
>   	}
>   
> -	if (cpages)
> +	if (cpages) {
>   		prange->actual_loc = best_loc;
> -	else
> +		svm_range_free_dma_mappings(prange, true);
> +	} else {
>   		svm_range_vram_node_free(prange);
> +	}
>   
>   	return r < 0 ? r : 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 1b50eae051a4..a69994ff1c2f 100644
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
> @@ -262,13 +262,14 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
>   			continue;
>   		}
>   		dev = &pdd->dev->adev->pdev->dev;
> -		svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
> +		if (unmap_dma)
> +			svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
>   		kvfree(dma_addr);
>   		prange->dma_addr[gpuidx] = NULL;
>   	}
>   }
>   
> -static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
> +static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   {
>   	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> @@ -277,9 +278,9 @@ static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
>   		 prange->start, prange->last);
>   
>   	svm_range_vram_node_free(prange);
> -	svm_range_free_dma_mappings(prange);
> +	svm_range_free_dma_mappings(prange, do_unmap);
>   
> -	if (update_mem_usage && !p->xnack_enabled) {
> +	if (do_unmap && !p->xnack_enabled) {
>   		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
>   		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>   					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
> @@ -851,6 +852,37 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
>   	}
>   }
>   
> +static void *
> +svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
> +		     uint64_t offset)
> +{
> +	unsigned char *dst;
> +
> +	dst = kvmalloc_array(num_elements, size, GFP_KERNEL);
> +	if (!dst)
> +		return NULL;
> +	memcpy(dst, (unsigned char *)psrc + offset, num_elements * size);
> +
> +	return (void *)dst;
> +}
> +
> +static int
> +svm_range_copy_dma_addrs(struct svm_range *dst, struct svm_range *src)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
> +		if (!src->dma_addr[i])
> +			continue;
> +		dst->dma_addr[i] = svm_range_copy_array(src->dma_addr[i],
> +					sizeof(*src->dma_addr[i]), src->npages, 0);
> +		if (!dst->dma_addr[i])
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>   static int
>   svm_range_split_array(void *ppnew, void *ppold, size_t size,
>   		      uint64_t old_start, uint64_t old_n,
> @@ -865,22 +897,16 @@ svm_range_split_array(void *ppnew, void *ppold, size_t size,
>   	if (!pold)
>   		return 0;
>   
> -	new = kvmalloc_array(new_n, size, GFP_KERNEL);
> +	d = (new_start - old_start) * size;
> +	new = svm_range_copy_array(pold, size, new_n, d);
>   	if (!new)
>   		return -ENOMEM;
> -
> -	d = (new_start - old_start) * size;
> -	memcpy(new, pold + d, new_n * size);
> -
> -	old = kvmalloc_array(old_n, size, GFP_KERNEL);
> +	d = (new_start == old_start) ? new_n * size : 0;
> +	old = svm_range_copy_array(pold, size, old_n, d);
>   	if (!old) {
>   		kvfree(new);
>   		return -ENOMEM;
>   	}
> -
> -	d = (new_start == old_start) ? new_n * size : 0;
> -	memcpy(old, pold + d, old_n * size);
> -
>   	kvfree(pold);
>   	*(void **)ppold = old;
>   	*(void **)ppnew = new;
> @@ -1929,7 +1955,10 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	new = svm_range_new(old->svms, old->start, old->last, false);
>   	if (!new)
>   		return NULL;
> -
> +	if (svm_range_copy_dma_addrs(new, old)) {
> +		svm_range_free(new, false);
> +		return NULL;
> +	}
>   	if (old->svm_bo) {
>   		new->ttm_res = old->ttm_res;
>   		new->offset = old->offset;
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
