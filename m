Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B242C38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 19:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C8A10E1CF;
	Thu,  8 Sep 2022 19:07:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3A110E173
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 19:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wuz/sTVKRuh/kcE1Ngp8gQTm9Y2bY6SaavQSywkmo1EeGQhxDHFj3ThlxuqnRnp6FgetWV7JHqLCMTez0Nuuf/PNNl4X2dQIJLDS4mpPOAWXbxWsEBBqOZ9lovWunPrPJjfIIz3VYGTLP/1l3wOqqhdjR96DPeAvbtC6LjZcolk4RZBl+wup/5mQZ5/WLh3XfBKRJexPLTdFJA62F7RMg9wmbgjdkT2knccAlFdccqouPA5/C+bTj8EXof754H3B0lXlvUF8CLDC19kRmY0AvjP6rwHtE6GznT59q1zpC4lPMxTSplfUpmcxpyueTWn6+rBhXKXFF3RKhM/0WpfvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7IRg5zhZCzRa7zCT9G9W5+QaIeLbrUIxGU0i4Lu1Uo=;
 b=KbhUNEMOHBrwJjbD5LUzRCFDmpGcw69e3O7g8XsT3MS4dlgFvVVqNaA2heS+2tjCashZM9GMhuel77V4s4J6naMguPRrIziUKKzlhOyNMw38ZPC210JQ/uQDPCjD9ccKlXGb5yvgSkNKAhJfSm4kWLoxX7OHdfSOBwVkyKM63B34h0mLpgeIcVUjGtHGd6T+cfs1K4UJQKObcrje3IfKcHgIcs81Z+wpqiy0XFU1qnGDcv+/ltAS5mD5vxHwlXLOVB9g5NgyCGL9LpezizznpZeSSzCFYKIHBqsnlFtORmPdQRCVXcHyImkZo5h+m8Dwf28pmnL6CsiGiHjkkFRajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7IRg5zhZCzRa7zCT9G9W5+QaIeLbrUIxGU0i4Lu1Uo=;
 b=RmJ3N4Va/euQs204Gy5dgXTer693TdBpWa2YUcjWQqsj1yNwUhlzgLhFfTytVG0nh2q4M87z3GIrhPzmv+ynhmygfZpJPjwP2CCQuGpDLkYDQk/3zNph/ZKqvKP05NyeAOiJ4xZe3pkFo/CeZHVN7HnhM/j6rU198MeCO6hB6d4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Thu, 8 Sep
 2022 19:07:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 19:07:07 +0000
Message-ID: <c2bd349f-b5b5-0890-2a08-8cf1df7d77d9@amd.com>
Date: Thu, 8 Sep 2022 15:07:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Remove prefault before migrating to
 VRAM
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220908001630.15437-1-Philip.Yang@amd.com>
 <20220908001630.15437-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220908001630.15437-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:610:5b::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fba359e-8093-4638-ee49-08da91cd52d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfP7za4K9L0VL3uUctGpW0ojCOXxvfoPcTzru25uvm36ZVmuQmi9XNW0waNAG670sN41t/lXPYPOi+9U6OozKdBrMXpLrV/xe/pXRM9CAekZ/mZZ4h9yPcXfPAQYiqmUEE9MdgX0rriaBH2y2P0XjGy8sJJpMh+p8B34ULnuZoJd81XeRa1FmFI6Kf+rVpYR2qvrTjQrlnUowB9ZKw7OrTaIps84AU5odaiPAZrQ2FeIF9HKHhLm/5eQ4NhWsi1eVe4Xoj8CxHAc7KzBfMBMbxKp1f5nmyJartKFwCGwwTOksliq3vt/rZeYS9iX+ldTuQVP9Qsjrcisf2On0Y/jUAjV+E0oWDpdqp8wkUC37w28DOdrrhr2eGUfVlvTn7k7i/be/8VoPglaRyoAAa3t5DhNawDeB53PLhomKRVJGDPUceMhsJeqXfRRH4pEfGBpcO2nTjd0dJBRA0LuJHForod2SXCKUCFr6nwKoe6yi9deq+PX4+qRDb8ANd4ZDBwP/tCxgzHDx1VWR3Fjrnj7RSI32Uu7vGhKCMj9iPq2IjvqMlccMKztdySXtnBmLesgdIaxdn8BdJo+U3KqLNmMGBeXlmkef12/H0ixM2FRGky9v3TFxHef2jP60pA7tVNc23dfWMrIi93Z8VB1tP75fAb0Rq1SPFBlDorY6jhWTEBQZuN+R5FF9bYOp/wRNXBIqSb8qde84YvfnEJDEKZHfvTyWABHFWYTlDN3duEDl+iLqwJt2yvR1+mPLsep2qBPrDeOaIO/Dr72tQ5bCYO1M+kazz2iyK8RISsAytXaI0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(31686004)(66476007)(316002)(36756003)(6486002)(66946007)(31696002)(6506007)(2906002)(36916002)(26005)(6512007)(86362001)(44832011)(83380400001)(53546011)(8676002)(66556008)(5660300002)(8936002)(478600001)(186003)(38100700002)(2616005)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXhVRGNQWVowMjhXMjUyUE1ESWprOVBPKytoVHV6ZllvSURDUVVMZXlaWHBr?=
 =?utf-8?B?dDRLczh5ZVdrbVJEaW85cWZnaVBDUmFrYXhOVUk3TU5uQ2EybDFiSlF4WFNN?=
 =?utf-8?B?YkFtenBZOWlmM2lvajRZdnpra3RJc2x3aWs0Yzhab0owYlhBSHVxVFlHVW1x?=
 =?utf-8?B?QjBCVDdveWgrK0NDYWdwMnI5RGx6WUIzYyt1ZGEzOExjR09aS1JTWHpGeU1H?=
 =?utf-8?B?d2Q2aklkM3Jia3hyQzdQQVZlcmpjV2ltRGpZc0hXWlk5V0lUU1kzRW5GQ3hu?=
 =?utf-8?B?UDhLYUNUa2VsOFlGaTVxNWlPY2tMbG9NaFgwZHFDVTNtZUhzZkdBdDZvNFZt?=
 =?utf-8?B?MDlHUlZDOWl6cVlMcUt2V0FERmRvc0lsb3dZWXhhL2lxVXhyYnE4MDdrUUFa?=
 =?utf-8?B?QXhuWFMzZkRBUCtOUUhhZ0w3aURVbFF1dnV1L3FselZ1TFFtcjFhc0tPVW5w?=
 =?utf-8?B?RWFEaWs1cVhPcWt5ZjhhcWJTb0l3VXdvL2VrU1BWR25kNkxsSnNJUUNub1gx?=
 =?utf-8?B?NnNRSXBHNW9xVUh1SE1KYi9rZHdyN0IyTm9IZ2s5SDkrTUR2RG9NOTBKU2hJ?=
 =?utf-8?B?NjhxalNIcGo5djVYTXkyb0ZWUEsrbDJxYWxnaStUVmtQL0oxQjRVNlRkYkFX?=
 =?utf-8?B?OHNkRlkyWmF1eVhXQ1BFQ1FWVmptMlEzWm1BU2Q4Q3FYSGlubXBjOXZDTGhL?=
 =?utf-8?B?SHNMd3kyNkhMT1ZwSTlTTThmcmNseElQQnpJcGZDcENkMTZ1OEFhV0pseGEr?=
 =?utf-8?B?M0M3ZE80WS9VeTFydSt4WUR2N3pGMFd2TktCL3ptcjRDMk5BVVlDWnpTNlpE?=
 =?utf-8?B?eWplYzBucU5rM2pHWVdJbmJFbklHZEFNbTRROUU2WlB5dUplQUhmWnpBZkY3?=
 =?utf-8?B?UFI3LzhNL1U0dS81dW9HQzRkZXAxUEcySDdYbEtzdmFpSHpRMzRrTGNvZDcx?=
 =?utf-8?B?SitlTnZGRVFkQWNRRTNDc3hwdzNLU3ViUlB0L1U5clhxZWR6T2FhcTdUYVBF?=
 =?utf-8?B?Y05EVXN2bUtRQVppZmhoUmh2enBWQk8zaHNXTUN2ZVNLK05NcWJibTN1eWRR?=
 =?utf-8?B?OWNBUFV0U2lMckh5NzhTakptS1doNllFSmgwNFp1YW95VlkrYnJ6MU93MCtI?=
 =?utf-8?B?ZzhEYmdsU2x2VUExdVRaM2VwZStTZlQxSldja2MzUTJMWUgvWWFOQUQ0U0dv?=
 =?utf-8?B?YVJJNkRiWHFvZXFzWkVlUTQxZnQ4emdSQ3hTbjVQOXZaOEpMVlg5T0tZUlZp?=
 =?utf-8?B?TkRxMlhxeFV3Mno1c0xveThPSUFaaFZsYU5ROEliRDE4Z0dMRUNFSi9CaWxP?=
 =?utf-8?B?ZU51NndXdVlJWjlFU040amFFbHVaOHpGTy9qSVFIN3VaY3o4WFQxQlF1ZE90?=
 =?utf-8?B?RVRMaVYya2F4L3VHeXdJOVFwRy8ydjY2UnZ5dDJPN3pZUnAzeWxoQTdlQ1VN?=
 =?utf-8?B?V3pibHVwaEF6UzU2OUhwR1N2ZmRWSTQrTmp3U1FmU1VQb1picUlMMGJFMkRz?=
 =?utf-8?B?ZnR1SGgxYUYwenpmaHI5anF4Z0JMejRlTHN3d29MdnpNM2VkN1RjbDk3a1Az?=
 =?utf-8?B?cmVBbE5MSlR2NkVuYlNSbFVPcVkvbStnQnZoWU5MYWNnYVpWMXNGTTMwb29p?=
 =?utf-8?B?R3hDak9IYW5DdmhmTERBL3VCUUpRelJOMy9mQ2QxbnE5dVFsU3c0SmRWUHFw?=
 =?utf-8?B?WW5vZ2NkSjlGeGJrclUyYVlqeXRHMEZDZ2lpODBZdUNKWElKb2Vmb3JNbDlu?=
 =?utf-8?B?azg4YzYrMk40OXBkZzg2T1BTNHdXSGg1QVErVHpOYVlPd0IrTjJ2WUtXRGNv?=
 =?utf-8?B?VlJveEgxUXJEODNRaWZqYkx0ZkROMC9qeDg0eFhnOFZDZXp5bGl4elNjZDJR?=
 =?utf-8?B?OUluWEduSDNDRE1OdFdPVno5ZDB1TU5LWXh4MERwYlBud2VQWnpZa0tHNWlm?=
 =?utf-8?B?bFpTcHFjakh4NG45d3Mwa2VRM1g5bFY5eDk0V2MwTWFEUjYzOThtcE1Vd0Yy?=
 =?utf-8?B?WmM3bElPd3VzVzNDNGVwMUdta2doTjExUS9HcTlkTytBWHpWK0lsdHFuWlpE?=
 =?utf-8?B?b3UwNWVQdDNWbHlUdyttNkZxWGJpVGt3UnQzK2ZKN0ZaSDdsQWRIOXRpU2xq?=
 =?utf-8?Q?7cYrKCAhN19BAS5Y6zMcMfm4X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fba359e-8093-4638-ee49-08da91cd52d7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:07:07.1646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh5hRqT7rxg1Hif9h0bPjQ+2wA3wzADk/6gYiak2SoP/vlcSe67/vTbpHO8qOPgiDV8+G/B82zaR3MhQp+Yohw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
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


On 2022-09-07 20:16, Philip Yang wrote:
> Prefaulting potentially allocates system memory pages before a
> migration. This adds unnecessary overhead. Instead we can skip
> unallocated pages in the migration and just point migrate->dst to a
> 0-initialized VRAM page directly. Then the VRAM page will be inserted
> to the PTE. A subsequent CPU page fault will migrate the page back to
> system memory.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 +++++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 22 ----------------------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 --
>   3 files changed, 5 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 8562dd0eb4b6..f62c4561f0f4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -322,12 +322,13 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	for (i = j = 0; i < npages; i++) {
>   		struct page *spage;
>   
> +		dst[i] = cursor.start + (j << PAGE_SHIFT);
> +		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> +		svm_migrate_get_vram_page(prange, migrate->dst[i]);
> +		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
> +
>   		spage = migrate_pfn_to_page(migrate->src[i]);
>   		if (spage && !is_zone_device_page(spage)) {
> -			dst[i] = cursor.start + (j << PAGE_SHIFT);
> -			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> -			svm_migrate_get_vram_page(prange, migrate->dst[i]);
> -			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>   			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
>   					      DMA_TO_DEVICE);
>   			r = dma_mapping_error(dev, src[i]);
> @@ -522,9 +523,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	pr_debug("svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n", prange->svms,
>   		 prange->start, prange->last, best_loc);
>   
> -	/* FIXME: workaround for page locking bug with invalid pages */
> -	svm_range_prefault(prange, mm, SVM_ADEV_PGMAP_OWNER(adev));
> -
>   	start = prange->start << PAGE_SHIFT;
>   	end = (prange->last + 1) << PAGE_SHIFT;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 11074cc8c333..cf5b4005534c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3181,28 +3181,6 @@ svm_range_best_prefetch_location(struct svm_range *prange)
>   	return best_loc;
>   }
>   
> -/* FIXME: This is a workaround for page locking bug when some pages are
> - * invalid during migration to VRAM
> - */
> -void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
> -			void *owner)
> -{
> -	struct hmm_range *hmm_range;
> -	int r;
> -
> -	if (prange->validated_once)
> -		return;
> -
> -	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
> -				       prange->start << PAGE_SHIFT,
> -				       prange->npages, &hmm_range,
> -				       false, true, owner);
> -	if (!r) {
> -		amdgpu_hmm_range_get_pages_done(hmm_range);
> -		prange->validated_once = true;
> -	}
> -}
> -
>   /* svm_range_trigger_migration - start page migration if prefetch loc changed
>    * @mm: current process mm_struct
>    * @prange: svm range structure
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index cfac13ad06ef..012c53729516 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -181,8 +181,6 @@ void schedule_deferred_list_work(struct svm_range_list *svms);
>   void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>   			 unsigned long offset, unsigned long npages);
>   void svm_range_free_dma_mappings(struct svm_range *prange);
> -void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
> -			void *owner);
>   int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
>   		       uint64_t *svm_priv_data_size);
>   int kfd_criu_checkpoint_svm(struct kfd_process *p,
