Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604D6C38145
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 21:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB4310E333;
	Tue,  6 Sep 2022 21:58:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D552810E333
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 21:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSV3ZvqEDy2I40j4JSLDhfU1qbtmrTFSF5elvkG4Ufgk7IVbbxLZRBBOQWJz5YI13MTRVYCZtHTVzbkcPbtnyPXZFrrwDQvh6OTYBU82IUuWmLT01ezz48z7HvreH8ccWKqHVJQUQ/xgi6HraLHxAOXsl90hbYGqV87a8Kpalm28f2eyogqcsuY16IcPG5nU9E179UlVzpeUlG/ODliXGPvt5Z7TiDJO0jtSXI2Qr2vAmY7FQzB8Z2PWA4NvMLTTQ50LeH1VBXnqup3HLcMn7LRv2B736DZbCV5afV99R9maK47nLrP5gMUhs9KHMBVQiWdlPFxD3GLs1yLzipY1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cId6xeKzZCEHOyevo3CC1VPaJMGBiYae+jsfAyIxnVc=;
 b=O9u5saOQYA10JwAyW4Jlecac3jbS9S3FMpSa+Nj+/nrCshxkBW4DwypA6m7BKzHiRoMoedk3P1v2eO3jgRmErBUbwhHB6pwds4dboGAQCS379dwHaqdrXMWYT1HefE34apVI/mjp7CsuV9Zsu1FspsgbJQJNHrDf65HC91svJNihnBZKICDqROEkHgBT2s6Cuz/IPoDleA5eMKX0HM5t0k4VaW7PtxCGW2R58s6QNM4QhgWm5P0hUqVXf5/On8OZ0frrmZ8cjQWDXnYmeFUFK4LutVCryIROkgLpP+ol6b/KPrkPWQQz58xc8se6c5otJPlgz63DEIx6HRyfA0MHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cId6xeKzZCEHOyevo3CC1VPaJMGBiYae+jsfAyIxnVc=;
 b=pM8UZTJkwlZ9id8yL0Q9geGPPOWyIkE/s/JF4p110NYoBZfHMsIPNHNXpwWIsmRIPVR27kf9H+yx19qSoBqlqj8MbRyS+px98S/SfCltiUwF8dW3dhem2D2TDgEUAtxhXvR8ZFowc7ISPzAwsZcwUrkscgnYl1xrP8DhKGjU7ko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 21:58:24 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 21:58:24 +0000
Message-ID: <566475c2-47fe-1217-945b-00377a8923ab@amd.com>
Date: Tue, 6 Sep 2022 17:58:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Remove prefault before migrating to VRAM
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220906193414.1261-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220906193414.1261-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0409.namprd03.prod.outlook.com
 (2603:10b6:610:11b::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7725d023-5b70-4957-3ac2-08da9052ebb4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4071:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nm7qCOkkPYJdxiYwe6YXR4KRWE8LDeWSzlqBoLLjd3Tna02bt8RsvOZa2NrQ+ftHZRltmW9kk+L5QBXK8UoilYrzegbFF2a/Fj31BjcM3KEo7S+1iiILWiz0LI+nQI/EbFsZX58GEIpe3wbOSaBpmDzEoZ5WMGWecpUKSh6brMOySjAOj3P0DPPRmb3wiPASQwMOEyGy6K9bFdBgq4fnQQqppHzFrHIFJFYQcLky5jTV/sFiH7B2hZtWxL67jcmwnWw5q+uOuhM4UdxzD4CBIQXGhbng5vfwnRTz/GZvjysK3lGv6c6PF3NEOhON8KhBVGckUn6tEyGqng3XSSLbEJhgQbjcUgZf0uQpUhwjJCo6bfcI6FQNFJyDCW2WDY9rkKeK96r1e4Ro/y2vWLk1tKvb8m4ZyR88DBe0MP20T8enqC67m9WscRbQZg5bO4Pfp6tvXjhH5o3UmonD/3kHay14X78QkQ9b4C4/ZSa/qk2e7BevvPCkFxTW1PiWS/Z8CzX6fmwDWAL7v6dKaWb+HlKFbTaPXMPzQCAOmx4yFgeWbn068nui76KcgwGKIyPDq7byFz4XvNPlykJJQi4UzAks5YnK/aORSCBpK8vO2DD7UUYEaDBnBVgWxxKy+HMgYPILR7eN2UE8BJEoCqxC/341tubCPPP5XaeOhw1RYUpot2svC52wKF0QNizzB7fYh9sIr67xiWMXIcCFzu6e4jqxQKH0bZ+pq0B22klCJWihFYrVUXOk5HrvWI0Xby4VTm2+TXIupH5m4cRShv7s77E50Kl3QRoAzhCKZgtBDjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(36916002)(2616005)(186003)(41300700001)(6512007)(478600001)(31696002)(6486002)(26005)(6506007)(38100700002)(86362001)(53546011)(5660300002)(83380400001)(316002)(44832011)(2906002)(8936002)(8676002)(31686004)(66476007)(36756003)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REkyZFlaNmFIVXpZTEEzcU5ZeWNhVUJwMC9lWWVvMStDQ2J0YXZvTlFiUjUw?=
 =?utf-8?B?SERPTUR4ZHczaTNXbkFKTmxoeGdTZUtvMUhRWnRDcWNPWnIzcWdzVVNNS0FE?=
 =?utf-8?B?cnhITExqbnZIUDk2N0lITHRXdEhEWFYxcEc5dG4xbGZ0SCthRzY0VUZSbkNr?=
 =?utf-8?B?d0NxQnNrdk1PVDJMQ1Faa2c3VDNPN2c5M1dDSjE0Q1VsVFA5VHhCS0pWQlFo?=
 =?utf-8?B?VzhUa2psZmFTUGhVTUhITjZkNHRyNGVYU3pOMGsyd3RQbFRUU29MYWtzT1ZO?=
 =?utf-8?B?WlFwSVJ3cG15VzNGc1FENXMrdDdzNFYxYk1lT3NpYWowS0JrNnZQSER5dGtm?=
 =?utf-8?B?QXFrbGljUlNyMXRqV3RRN2RjZmNFK2h6TlVQR3NKalBEeFhqTUlFNVVCbGp0?=
 =?utf-8?B?VGpQT0VBSmYxTWJ1MjdWTUdpa0pIZXlUOThWQnZLWmN1elZXUTdkeHpBR3FX?=
 =?utf-8?B?Rlk0dENpNVBtWEpFOWRIalMwZTVQbUhNNzNqN3kvaWRpMVdzdG1DbEdvWG1Z?=
 =?utf-8?B?WVJXcHpla25SR0x3WXVoRStSSmJGZlZoN2szc3hGbW9za1hYWGw5eTdxSlJL?=
 =?utf-8?B?R2gvYUVpeUlvMW9OQ3A2QnpqWWdydXdXaEpFNGZxYjdXeVhOZ1RVL09zblgx?=
 =?utf-8?B?dXQ2WkgyU29oSFAvSHZ2TlFWS0VDMXYvaWFrRWIrME9SVVN3UmNIUXNGWHha?=
 =?utf-8?B?Yk9TcDEzZ2tqZFltYlhmSkxNck5QMnpwQVE1TXhPTXJ3Z3doT2tqUlFUZXBa?=
 =?utf-8?B?UTR2MjlIS0o1SUpHZjBFQnlTOFRpOTdhM3dTQlZER2xHeG5IUUZMeXlOWU40?=
 =?utf-8?B?akpUQ1JoU2JuMGhmTWZWZWR5cnUyd0JnWmJZdnF4UDRxQ1ArRmRVWml2V3py?=
 =?utf-8?B?czVKL1ZIbU5vaXJMSkd5YjRIM0hoemxTS2RZK0YyOW5wcWQvaE1wK2Z6SFg5?=
 =?utf-8?B?aldSemJESGZIYzR0RGlOVXBZaWZOOE5NMElNcEFUN2l6OFUvdDBWc2s0eTNV?=
 =?utf-8?B?OWI1VGsxakhRdlROSGM1NndrZVE5RlAxWXRXbldiVm1Hc0FJYk03NnVad2VY?=
 =?utf-8?B?cTVlN09RR2ZsSEtmdlhyeS9wL2ozaGxTUU1EL0owWktWcmNyTTN2Nmwxdkhr?=
 =?utf-8?B?WmNBYkFsYUduaURqeGFEYkJMMTBJUEtRTkdLOEcrRUlsQWY3VkJUTEVCd3JT?=
 =?utf-8?B?Z3NJZUpTUXNRNHFySlNPMnNJOCsxZ252SlZyVEdJVUgwZHlQYVMwQThOYXZm?=
 =?utf-8?B?L1FGcWZHUWsxa1lHZUZYbllYVFJBZXIzcGxKZ08wZjBnUVlkN3k2YUFZMGZN?=
 =?utf-8?B?SmdBN0hER05waWFVQ3dEZjliNGNqWjdmeXNwcmMrK01idGdmaFlMRm5SdVln?=
 =?utf-8?B?alFjWEp5YjN1MW1CTFJ1NHZHZmk1V2RLS21scy8zUjhFYVVpbjYvUEZ5SnJJ?=
 =?utf-8?B?d256VHVPU3JKMHlqUGdud1Q5TlRDNG90c0pTcUp1QXJoZEk5NExOUGJQT2dJ?=
 =?utf-8?B?MFBxcXJYQTZrcXhEa1J4NFVtVCs1ejdabURjeTVUVmpoVkdUVXlLdjZtV2lM?=
 =?utf-8?B?bGthZ3gwLzVPeGNYanVKZEFDYUZwT1FyZ0kxVnhFZTk3WGRDTFQyU3gzMkpl?=
 =?utf-8?B?bldia1VyVk1IWEpIWWx1Y29ZQ1Y4cmNVT2VyY3ZxeXlhdGhmV0xObmZYMWZD?=
 =?utf-8?B?Y0RkNmE4K3ZrZG5yODBndUcrOUNFeW93cUJ4WklVVkVkQnZiK3F0MmhZWG8x?=
 =?utf-8?B?SGNaWTRKSmtkc2VaWG40VzdyVEJDdWNZZUJnVE9LY1o4aVdiRUVLalJwbUVD?=
 =?utf-8?B?S2lFVTdGSGtTVm1ZQm81Z2JsOWRUd0VuOFIreFdpSEw5cFhWblRTZmk4cGtM?=
 =?utf-8?B?UFhTbjJOeWxyalJWcTEzYWlnSnFFQUZCampBWm5TQzNGODVpMmYvRXJ0VkYw?=
 =?utf-8?B?NnZSSnlHNnRNYzJDYlc5ckFVOW5ZMmxHT2VWY3UxajJHbDBCTk1IZC8xczgr?=
 =?utf-8?B?a2R6U3ErM1F4d0lZaGxORjZhZEkrd1VKV2NVUjJxMVlPaFIwcVpiR3o1OFVJ?=
 =?utf-8?B?ZlllOVZ0blRzWjlsaksya3RFZlNqN3FnbzhGaDhqMjVIamMxc3pIY3l6cm5B?=
 =?utf-8?Q?YTlfLklAqbf0TDzf7jlv/9lwr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7725d023-5b70-4957-3ac2-08da9052ebb4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 21:58:24.4396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9v8+TvyLnVuxc7tTDLYjXQzOc52dGj6T1czWdmnTmcp2pizywF7/sNlIcFifqPA9A0bvt6H92rBMqrxntA1L4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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


On 2022-09-06 15:34, Philip Yang wrote:
> If svm range no back system memory pages, migrate the range to GPU VRAM
> don't need prefault on system pages to migrate pages. Instead we just
> alloc VRAM pages and setup migrate->dst with the corresponding device
> page and skip the page migration. The device page will be inserted to
> PTE. Then CPU page fault will migrate the page back to system memory.

There are some English grammar issues that make this explanation hard to 
understand. Let me try to fix that:

    Prefaulting potentially allocates system memory pages before a
    migration. This adds unnecessary overhead. Instead we can skip
    unallocated pages in the migration and just point migrate->dst to a
    0-initialized VRAM page directly. Then the VRAM page will be
    inserted to the PTE. A subsequent CPU page fault will migrate the
    page back to system memory.


As we discussed offline, there is still one potential issue with CPU 
page faults in a child process with COW mappings that we need to address 
before submitting this patch.

Thanks,
   Felix


>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 +++++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 22 ----------------------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 --
>   3 files changed, 5 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 373e5bfd4e91..d3ebbde21241 100644
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
