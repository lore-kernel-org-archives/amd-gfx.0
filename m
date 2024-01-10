Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58231C4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 16:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC3710E77F;
	Wed, 10 Jan 2024 16:30:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC78310E77F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 16:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK2sy1LH7PaGV0ZA/Xuvr+tqlB5+7uAZt1yVQz8UPFkbB+yWngbN0IhIlRsjabi/71kGLZKcwalJEkc22WsdGbZELdYBt0PJ16wQ6YgW2542EMZyHTbepYQLu87nL5WihqTeDlZrlAc7jK3LdEsHj768tjW/NJPjvXnNap22mpcoACylSrqVUuU8eGaIzZB4hQe0EfM+9iG3I3cquLUknhKSgcBraKydmA1QF4s15aDixzfbUORo+/Sz3D421QpHZgwJAjaONeiX2mXbDhvBo+zPq49wpBjqZDZG1orObvdQUZLM2uKV3bl3mINdf39TW2137oI8Xuyu0mF6y+O1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2a+1a/5SEX5Kh6v/fh6Ef5XvQ88QHr0saC7umFBC2rI=;
 b=SzyKRK2HTHzhp2sB832yUVFpd/8YfqoW8JzYUfncQxABK4lzructBXwBthAuKS2EN1vF8QCXRCITDWkCKrE1wOMnxbv462r3Nl0Z+SmjM/vnJgg6pvVM2SCuO25w08edF2nzVoDHRm0sGXZwlA4m0AH8kyPw94za+LGzoKBvE3kK8pYFjqev6hYUw8UYOyyE3hQi6o5JlTRpKZQsV6QGcB5nZcNNqKUH05mfItPjBNENDA4jNIYS26q5Grj98wnLj0vI42t6w31SP6OZlvQgAlCBXlmfT/YYbxwLBPm8FfWFZg8UY0CCuAeAjrNBuDbnA4ABU86HCvlpkXXtTn6UYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2a+1a/5SEX5Kh6v/fh6Ef5XvQ88QHr0saC7umFBC2rI=;
 b=Den5ksJwSriGJ13MnL/8R3mClLNsU3RsirQkhLY8aFgzYCwgMVo/vbjx73mzZlf99fYbo4QoFk0Z/GSMXHYeO+zjIEGXvuz8Ec0oBgs5Oc1Wr+kVqcBPtE1koIatwuVT+GaPfX657deN/WQDAhiCU2m3TVVVt5HbXP5L6dsvTJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 16:30:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 16:30:52 +0000
Message-ID: <21fb682d-517e-4d23-b7fe-b1eeff683ab2@amd.com>
Date: Wed, 10 Jan 2024 11:30:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] amd/amdkfd: Set correct svm range actual loc after
 spliting
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240109200527.24039-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240109200527.24039-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: fb07230e-a0bd-45a0-a4b7-08dc11f982d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjY7DIdIO7okDJANUf/YwBa1xp+fCaOlzPm+RJr/JbsFDwDi4rrOEXmVAT/Cgxq+zT5uHh/UG/XPC4v2bKB+ZRcWhfAwNszPdFGR86+syretdRSD9R40q8tAU1S/Ij8xUbZ4MfHQRKWpPKWJAuhFIgKd+mTsYiJTItWrz3VwPLAPhNO4jit6QdGxPdMhIS/fM43fDEo/4jwqEFIycCCKlAm64o25T0ZIpUeb8LWlKY7AmJebeVEw5ey463yY7O0xfHOCXNj1bF5n6K2yS4JgziZBp0o/iAg0reIYZunDHVovmh6XiOvOzKMhPojRSLnk8MtzIs7FRBXAAXav/z/SGOSxi++X/C5PUmqZjksL81bCf693zzI7aKXPXu945aVzyxZS0sLvhf27G0P7aN02js+41eBQrB5pLzbk4THpMxbt0VQlgCUo5heaVVbfSncnFjxAJbpqVN5GWU30X5pA5qaI3B0Ed47H9CC7Vdp5glvTdrxu5BlGrQ+LL7SM+bFa8HLujtZmGX5ZT55jd+dz8mIHfpio1AFFY7ijt7CuwztLw1/cvHsi8shmMEt0mW+v9uN12HVXdQHQlmy8Nw6h3zQuZpaxpjpDyLyyQavc2SmjgP48Wr4BYi1DmvaXSOflL3K9OsF4gcNschE7Z/KRgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(478600001)(5660300002)(31696002)(6506007)(8676002)(6512007)(53546011)(6486002)(2616005)(36916002)(86362001)(66946007)(66556008)(41300700001)(316002)(66476007)(36756003)(38100700002)(83380400001)(26005)(8936002)(4326008)(44832011)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFhHRGU2Ymx1SWNoNTlDSXFmcklSMTh5UmZKcTY3ZENhYmtwYVl4S3c3ZHdi?=
 =?utf-8?B?dnNLM0swaFppV1luMWYwTWdiQnMrTXphd0lUdnNVR3JUQ1ZpSEpaSnpieFlr?=
 =?utf-8?B?T1ZJSHhKeFkxcTNMTElyaFQ2RVVmRDhzU29DMHRwT1JldVdUVkY4R1pQbnJJ?=
 =?utf-8?B?eGt4MlpXTUJGRTlMNlVEeUFPbXREb0hTdnZGcGN2R281Rk83aFVIVGtwQm0r?=
 =?utf-8?B?djBkSUV2cmthTUdNVXJKM0RpVE5KNlRXS1pMdjZZZEx3dFJPaEtmbmF2V2FS?=
 =?utf-8?B?cUIwNGk1SElHdkdSalE3ZWtRK2U4c3NTSVFSMzdpQnFwalBIbmpQNSt5YmJj?=
 =?utf-8?B?TXdGMW53YXdTNkwrWFdqakEwekpwRDJxcmNmVWlDYmhQRWNDd29EZHR3ZHpN?=
 =?utf-8?B?Q1FYYzFHeEhHVzRMNU1ZUjZSdDZWUGQ3c2NCdGY4S3UxZDdrQldobXh0a1lQ?=
 =?utf-8?B?bGh2aDAvWEN3RFM2SDNhbTZIWUU4ZVFmYWhFbUNvTE1kSnRyQ2hDVjFlT0hz?=
 =?utf-8?B?VEY0RDV6V0h1bFBEUGxkYi9aaWhid1AvSnZLREZ3R3dyTjQ1TWtKRk1VU1J0?=
 =?utf-8?B?TnJpQS84aW5FZnV2enZxZVBSQ0pXb1BoWFoyYy82TVVzbStmV2E3WmFON3RF?=
 =?utf-8?B?VzdUR2ViSnowVm1wbTd1N2kyeWdhcTdGK3FGZ25icCsyV2x2TlFPVzY0MDh2?=
 =?utf-8?B?WWRUOEhpcVZWU09LVUlmUTNWajRsSjMzcExWYlE1TFo2MHJDazdJWXVNSnRp?=
 =?utf-8?B?UHkySzJsUWlCbzgrZm8vYXVFaFZvQ3I5R3JBVmxkMUp2YktDakkzd1pqZG5a?=
 =?utf-8?B?ZEpmVElkWmx4STRHZk02bTRJNHhEc2NDT3V0dzRHZUpzTEpMalFlUmFXMlRF?=
 =?utf-8?B?UUNjZWZjSlZ5TlBOY1JvZlVJZGl2WktJZmZ1cXZjWVZWR05aRERpVXI0Q01r?=
 =?utf-8?B?RlR5dVIyblc3UndFTkIvTFZqU2oxNyttQ1UvWWFSRjgzRWMxVERVYjBtMWlJ?=
 =?utf-8?B?VDlKYlBHaXZDdHRMTmNpZjg2aDhjWUxsQkM4dXVRZi9ocXRQUU5Yb2djREZH?=
 =?utf-8?B?N2VOWDhZai83aEl0QXoxUDg0ajdnVHd4czZrV01Fa0dxbFdsOXBkK2hvaGR4?=
 =?utf-8?B?SkhkVDR5MGNJVERCa1R4UmJKUkNPaVNVazhBek5yYk1RL093OFdiL1JyUzJq?=
 =?utf-8?B?RDVKa25pZXJzSldqbFh5QVlzajRJWEpNNDJCZE9uNFdoaXFmRUxvN2F0SnFq?=
 =?utf-8?B?RWF3cngzanRGVGhlcS9xclcyN21xZGpyMjNtUzNISEFvRm5ZdkREZFhZMjVK?=
 =?utf-8?B?ZFhZQkk5dFh0bmdVNU8zT2FTTFltcWRWek9OVFh5SWdISjBVVmRVSHRHNkkz?=
 =?utf-8?B?dklOSUMwWWY5YVVNTjd1VHlmSkIwRk1JZVJmT3Q3cDFjaGQ2UDhaTFVzWDNl?=
 =?utf-8?B?WEVsVnY2eW1GZDAzZVJ1dU1KTE9ZU0xQb1IzUDZRTW9qb21NSWlyWXgwVGV3?=
 =?utf-8?B?ZnJXL3owQ3Bvenk2QU9FdlFtQXFLd1FSdmZ2bldjVVZZSHpvK2UyL0pnMWdV?=
 =?utf-8?B?OWszc1pNM3ZLS01ZZElXMUZZNTFCMmd4aFpkeHdTWE5xRDg4dkd1c3YwTjJv?=
 =?utf-8?B?ME5WK2psZmVnb0diQzlJQ2VPcGFKVnYyQ2N5SDBzaitTNmRoTHVjMEl2SnhP?=
 =?utf-8?B?ZnM0eGRMMHFBRW9ocm91WU5KZlcvc0xBNUhUcVp3V2xQQkpRWWxSUUdlZ2VG?=
 =?utf-8?B?SWZiZ2NyODd4dkhBZnZMZCswK1ZpeGNMNEYwSmJIOTIvWjM4Y01teTRSWVF4?=
 =?utf-8?B?aUhmUkJPSWdUdm5jdTYrOFhRRTV4QXltM1djcTBZaWQvcUlIdHdMQ3I3ZU9N?=
 =?utf-8?B?MEhodWxMWFpIcDdyOW9TM0hpdE5FeXRXcWRUaUhpTXZadVRMRm9rR29jZ0tU?=
 =?utf-8?B?S21JNWlibkh2cXduclZSTmRpZ3A1dDkwMHA0YXJZNHRISTZJYzRma1ZGM1lp?=
 =?utf-8?B?ZDhIVGZHTDZ4RnEzQzZpQVZ3eE9rZ20wUzBXTWRiT0xuUG1lR3RadzhFUFlY?=
 =?utf-8?B?VkxQbEMza1drclZSMmRaWHdHaUxlNERYOXRrQ280dUo2dGVpa2VBYmREZjZS?=
 =?utf-8?Q?uBHLP6aWHRXOnsB/H0KtGokNe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb07230e-a0bd-45a0-a4b7-08dc11f982d5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 16:30:52.0865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0gdIx0zUBsAGJ8PqafPl2RrcOAGmKUuMJ0seSfD4ZGpsYOvQFCQt4Dpue5qsqTkMmDkzwfH2n3i0UxR49CKEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
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
Cc: Xiaogang.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2024-01-09 15:05, Philip Yang wrote:
> After svm range partial migrating to system memory, unmap to cleanup the
> corresponding dma_addr vram domain flag, otherwise the future split will
> get incorrect vram_pages and actual loc.
>
> After range spliting, set new range and old range actual_loc:
> new range actual_loc is 0 if new->vram_pages is 0.
> old range actual_loc is 0 if old->vram_pages - new->vram_pages == 0.
>
> new range takes svm_bo ref only if vram_pages not equal to 0.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  3 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 35 +++++++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +-
>   3 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f856901055d3..e85bcda29db6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -839,6 +839,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   			prange->actual_loc = 0;
>   			svm_range_vram_node_free(prange);
>   		}
> +
> +		svm_range_dma_unmap(prange, start_mgr - prange->start,
> +				    last_mgr - start_mgr + 1);

If this is just for clearing the VRAM flags, then we should probably 
create another helper function for that. DMA unmapping system memory 
pages that didn't even move is not necessary here.

Also, as Xiaogang pointed out, the migration may have missed some pages 
due to page locking race conditions. If you want this to give you 
accurate VRAM page counts, you should only clear the VRAM flags for 
pages that were actually migrated.

Regards,
   Felix


>   	}
>   
>   	return r < 0 ? r : 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cc24f30f88fb..2202bdcde057 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -254,6 +254,10 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   		return;
>   
>   	for (i = offset; i < offset + npages; i++) {
> +		if (dma_addr[i] & SVM_RANGE_VRAM_DOMAIN) {
> +			dma_addr[i] = 0;
> +			continue;
> +		}
>   		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>   			continue;
>   		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
> @@ -262,7 +266,8 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   	}
>   }
>   
> -void svm_range_dma_unmap(struct svm_range *prange)
> +void svm_range_dma_unmap(struct svm_range *prange, unsigned long offset,
> +			 unsigned long npages)
>   {
>   	struct kfd_process_device *pdd;
>   	dma_addr_t *dma_addr;
> @@ -284,7 +289,7 @@ void svm_range_dma_unmap(struct svm_range *prange)
>   		}
>   		dev = &pdd->dev->adev->pdev->dev;
>   
> -		svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages);
> +		svm_range_dma_unmap_dev(dev, dma_addr, offset, npages);
>   	}
>   }
>   
> @@ -299,7 +304,7 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   
>   	svm_range_vram_node_free(prange);
>   	if (do_unmap)
> -		svm_range_dma_unmap(prange);
> +		svm_range_dma_unmap(prange, 0, prange->npages);
>   
>   	if (do_unmap && !p->xnack_enabled) {
>   		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
> @@ -362,7 +367,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	INIT_LIST_HEAD(&prange->child_list);
>   	atomic_set(&prange->invalid, 0);
>   	prange->validate_timestamp = 0;
> -	prange->vram_pages = 0;
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> @@ -980,9 +984,14 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
>   		if (r)
>   			return r;
>   	}
> -	if (old->actual_loc)
> +	if (old->actual_loc && new->vram_pages) {
>   		old->vram_pages -= new->vram_pages;
> -
> +		new->actual_loc = old->actual_loc;
> +		if (!old->vram_pages)
> +			old->actual_loc = 0;
> +	}
> +	pr_debug("new->vram_pages 0x%llx loc 0x%x old->vram_pages 0x%llx loc 0x%x\n",
> +		 new->vram_pages, new->actual_loc, old->vram_pages, old->actual_loc);
>   	return 0;
>   }
>   
> @@ -1002,13 +1011,14 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
>   		new->offset = old->offset + npages;
>   	}
>   
> -	new->svm_bo = svm_range_bo_ref(old->svm_bo);
> -	new->ttm_res = old->ttm_res;
> -
> -	spin_lock(&new->svm_bo->list_lock);
> -	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
> -	spin_unlock(&new->svm_bo->list_lock);
> +	if (new->vram_pages) {
> +		new->svm_bo = svm_range_bo_ref(old->svm_bo);
> +		new->ttm_res = old->ttm_res;
>   
> +		spin_lock(&new->svm_bo->list_lock);
> +		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
> +		spin_unlock(&new->svm_bo->list_lock);
> +	}
>   	return 0;
>   }
>   
> @@ -1058,7 +1068,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   	new->flags = old->flags;
>   	new->preferred_loc = old->preferred_loc;
>   	new->prefetch_loc = old->prefetch_loc;
> -	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
>   	new->mapped_to_gpu = old->mapped_to_gpu;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 026863a0abcd..778f108911cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -182,7 +182,8 @@ void svm_range_add_list_work(struct svm_range_list *svms,
>   void schedule_deferred_list_work(struct svm_range_list *svms);
>   void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   			 unsigned long offset, unsigned long npages);
> -void svm_range_dma_unmap(struct svm_range *prange);
> +void svm_range_dma_unmap(struct svm_range *prange, unsigned long offset,
> +			 unsigned long npages);
>   int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
>   		       uint64_t *svm_priv_data_size);
>   int kfd_criu_checkpoint_svm(struct kfd_process *p,
