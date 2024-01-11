Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF834C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 16:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3AC10E958;
	Thu, 11 Jan 2024 16:54:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CF910E958
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 16:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/Ra5JGORRtBGz6W+k5FzfNEsNoFkT2XbhBzPxYNuIF5WV+TZ9VBHDVl1zi6/JKDrviFBjEuepwGehJXY/U1y82yK6fPExUp0mpjeqUEIbZMZ2BsRcDpmwocmArsaPeKu0H5MMYF8cYDGVp9yYEpLact6mD15ecgJvoFikwg1VFcp10qjApJRIKmHl60JaPbO/ZbuGRAe1CA6bpC826E/6+kZ0ULiLsV2nR7JPATeBFw7qpTRKVKwuqx9bNcPVlwkmO1U4B4Q3YcLIiAlq9+a3robuKBH3em5qurbaYa6hA2gPPfhvHy4FbiEWEn7HBt+3hwM4bIs+aGhzg16Ad6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHSRxJyudQC+iHbaY57JORdmcukBxL9uaQVzXg2AHqw=;
 b=eUSCHgnxyE1mUOFqLyriJzm41Cc8Fh6GTJlCTO3cAOb/yY3HBj/A0b7hqDDbjWAXzkEUzpnru6B+IDR4Ip6MD6fs+rg/o151nzWtDCDrVb+A5Oqgu8xj1gVkB/46nhvXk46oxkKTUhwzY2PspuQT+qe+MM0dSuvBnuE36YbSsHelO5BbXGIe+sfzxm3pSAVH3j9Xu/FFPN/Av4KT+5likWgZuirIKTYr8o/gPbEOcdDMnQW7xecuh0cKcPZN+dNsS+jRsWg9BJLrxiM7nalLn1VwBGUNFm5zIWW6Z8KUa2Tg3XSZzx5vBbpR1Jtq6/ENIU8rmzgIQaJi9VM169JOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHSRxJyudQC+iHbaY57JORdmcukBxL9uaQVzXg2AHqw=;
 b=VnM7VG008ExZeZBwV4TdxK2XnUm1+SIyFs4kndtg9WIUfFUVQxWv5rNmSbl34LmyUH4dkuuoA8w+YiZCevk6xWIzcT98f6bzu7gPBfKuTyN2ojvE1RH04eVZEG8ZUb/0DsEjJ2QfWcnWg/FYir0eYEsQUe0gqAd+XBauZ1YfXoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 16:54:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 16:54:43 +0000
Message-ID: <c76951c2-6abc-49a2-be86-301aa87457ce@amd.com>
Date: Thu, 11 Jan 2024 11:54:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] amd/amdkfd: Set correct svm range actual loc after
 spliting
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240110220143.25973-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240110220143.25973-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cb857a-c854-45aa-03fc-08dc12c6026f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsyUtr3zUG8i4n4RJRu2pH1hRwqXQNNcROL1oOF4svXs6lEDuv+gEMVjvR/OrvULGa02JemAFM0eJaXk6Og62ESzYiGeFsRznfAJkgyXWYONQvyBr1r/7qTyIT8Gh+kNXpnsybAnUj7g0JyNvl9DjWymfWGHaRQaKNe8141a+l86RfLIGCcz/lus8YWK8TxKNhC0rvoZt+B5PR7YMpQIGo2lDMt/VHXZAkNbEMO1VK/VL/fMZkrs/OSU3VUsZSDyFXmrgNWg9uTwQxGCNOCRKFzwSrTxT/73JMdIoJUn9/3MC5b9PsNKiq2ZFh0qo6iqsIpbKG/rpZp9GcDGJ+GjOwCN0Au4wUppGFEfjZTxI1yEZbWdH1OvnR/qTMfRO/BpMn0g9QWoBeZdUg8T3HISqvfaEnN1nh/DjzcpcZngjO9RRUmdvJZWvP0mecMSkPZGOHtS2nOIn+VqTn5wTmTVBs42zSAbXEWUFpE5NSsHqGYh/hnF7LRINkX+s4GkekScgz/fTc/panzy5jpp9Mx79dmaW4sDNyAU1rq/ao34shFgunEQZOe3tJ5ry8X2DFrXNuymMdVD0METPsOOs0lqlt1Oht6KuK6wldGaguzx3QVcifSsavzmizQpu2ZCI0H1CKG8Q/IqF9zEQKHdHy2LmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(83380400001)(41300700001)(36756003)(86362001)(31696002)(66946007)(38100700002)(6506007)(26005)(2616005)(6512007)(53546011)(6486002)(2906002)(66556008)(66476007)(316002)(36916002)(478600001)(5660300002)(44832011)(4326008)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGs4WVF1QTZ2d3YzRnludzFVTzZFZTJxVSs4bVMrYTA4bWhNT0ZyT0dCOVpr?=
 =?utf-8?B?YkZ2ZlpyemRUVTBYMmlQaCtvNTduc0haTGRPTitUc2crM3dMNTNEZGZkaXJw?=
 =?utf-8?B?VDU5OE1sVUk3YkN4UmFoRmxGNE02czl2TGtlaXpkb1A3ZTBGZkMzUklkVWJy?=
 =?utf-8?B?VmFyWUlySVhOU1FKaThHNjNPeWFDUG9YMlBSY3RaRnA1WWJmY2ZIL3Ziamli?=
 =?utf-8?B?bGs0SVRkN2FtWFI1WkJFMVQrNjJSQ0xsc0JKNHFZbnN0ZEZmRlBIcTFhZWgy?=
 =?utf-8?B?VkVHcWtaVlVGVHhSSjBuZ21HZEZxN21DdUU2UEwweGVNVkYvTXZIeVhLcGV6?=
 =?utf-8?B?emp1N0UyU1NLVGZ6OHk4RWhjNW5wQXdzK1R0SmVMd2VpVDJmUG9ObXNZcDhq?=
 =?utf-8?B?RE5tYytDMEs1Qm9YLzFxR3hXbm9Kd0dtaEgwc0hyVkVkbmp0NHJNUjM2VTRs?=
 =?utf-8?B?RFpoQm9qZkNVTDlrOFZHbW5MSFJyZGE2TjIwV1pkMGkrWW84ZzNPcktFU29D?=
 =?utf-8?B?dFh2bVdjd2VqOVVBTTM5d0tMRW9SRkxhczFaclR2STcwblNOTXAwamZ1Yk52?=
 =?utf-8?B?S1N6Z1lRVERZNkllT201YU1MaVJwMXZMZCtscEprRVBRUzJ4NENyUnBVZWFJ?=
 =?utf-8?B?QnlXVUlPRStRTGlnWjBKYjBvWEJ1cFhPUTdhbW1MbWpCbUFSWjIvODRaMTJ1?=
 =?utf-8?B?TXFrT0dJdVRxUSsrQlg5QjVsNUUrL1hJb2tCeUtmYjhUWHJ1R1lKN09oU28r?=
 =?utf-8?B?WkIyN1lJNDF6SFpoSi9kQ25JVFhLTEJUZGs5bnBBWGRRa3U4a3NZcXcxTEJR?=
 =?utf-8?B?N00xOGNzQis5eHg2S3hvUU8yclZVNDNpeVhjL1orYXBvSXd1MDBYSGFFSThY?=
 =?utf-8?B?bTJwekRjVkI3OElNYkpxUG02Z0tGWElmS0d6SW9jZ1VVZzB2UENOOSt4Tndu?=
 =?utf-8?B?dnpWS1lHU00vTW1sL3ZDOXFEWlRMbXhTS1J6ZnRUaEo2V05nMlc3RWVpaG8z?=
 =?utf-8?B?cjVYWHRsUjNFdHZ1ZGtKd2lvUUU2NW9YbVEzL2dScU44UlVIRk9BR0drUmR1?=
 =?utf-8?B?VHAzVkhRT2g0OUhXcGJqZGRHVDY4aE15VzBMOXpHdy9kclhnUFdMS3VWQzRH?=
 =?utf-8?B?TDZtanlXandRYVNNMHQ4NTlpTVJpYXNaR2l6WTZkVmFhYkNsQjdkL3BGbEI4?=
 =?utf-8?B?bS84UVlWUEZ5QnV3ZkE2V21Td3VCeWFvTnJwU0V1SGxzMU52cjBRRmgxd1pT?=
 =?utf-8?B?YWZUYVIzMlY5MlM2UlBYQzFTYzVZYlcrakIrdGJtSEloYkFLSjFDMTRCZ0RV?=
 =?utf-8?B?bWNBTitMQUMrdngzcXJMeDNoRVYwNDVBbStPWHV0bDQwZ28ya0FnWVQ1a1Bl?=
 =?utf-8?B?dnFhbTVvQ1k1bDdxc0RNQUl2R0tVUG9aUmpnNTZMMkxIL251YlI5cHZhVW9H?=
 =?utf-8?B?akNxcytjODIrMisxdkNTVEZXTnFwdGxrWS81cURCZHczQzJ2YUgrNnBFMWpn?=
 =?utf-8?B?ak9wUnRlVDZmNU1KWFlMMk9LTW5tSFVoR2grbXlaVC8vcTJWR0Zpb09Wd3Zv?=
 =?utf-8?B?YTZQVXpNVUJxcXpUTlhZREo1QjFTT3RzTkZlQ2ZodjBiNk4zUStzejQrakdq?=
 =?utf-8?B?OWppdEY2V3Y1d0NZOTAralBYK3pXRkJ6dkZUcmdlOFRNaU5mY1hUc1JwVlk0?=
 =?utf-8?B?ZHk5UStGVUVDU0NpU2l2NmN2RytlWnl5dXlwVlJhelE3eWNOcXIrL2d4VGM5?=
 =?utf-8?B?NGVjaE1SRmZRWEo5M1I0ZmlLM1IrVWxscjNWekFQNHRoOEJUbkpUM0pPNDVV?=
 =?utf-8?B?VnFuRnN4b2lxQk1CTjlXSEJNa1BheVUxdVhtWTlBSnZocU1mREJuV2RsUE9h?=
 =?utf-8?B?QnZST1E3Wlg0Z21laEd0b3gxQVdqVTJwNHp6TC9iZnd1M3hXZUpXMHVVR0xx?=
 =?utf-8?B?MUlYRlJIUVllV2RMTVRKbUhSUE1ydFRxV2dtQWZCQ2VXWlVZQ3VqdzFHVCsv?=
 =?utf-8?B?N1M0cHpOZ1o4N2dHVXEyeWp2L0V6Q2pSc1h3YU5SWnYweVptMzlzR04wS1Ri?=
 =?utf-8?B?eUo2OXkyeEJEUy9tVUtIRzFKWVJ0ZGg5b1ZsOTJFMkdTbnROVWZrRzkvWmor?=
 =?utf-8?Q?dXFF8bU4Zik/Qrjfj8sKJz+VQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cb857a-c854-45aa-03fc-08dc12c6026f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:54:43.4652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bkj43QmG4mVBhb7e9DZmdJKQOCao/sjDTLMibS07eWBW8CWAfeuDRhlBZwWRUAw0votSeecgGrTStrEemJS9MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
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


On 2024-01-10 17:01, Philip Yang wrote:
> While svm range partial migrating to system memory, clear dma_addr vram
> domain flag, otherwise the future split will get incorrect vram_pages
> and actual loc.
>
> After range spliting, set new range and old range actual_loc:
> new range actual_loc is 0 if new->vram_pages is 0.
> old range actual_loc is 0 if old->vram_pages - new->vram_pages == 0.
>
> new range takes svm_bo ref only if vram_pages not equal to 0.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 +++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 24 ++++++++++++++----------
>   2 files changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f856901055d3..dae05f70257b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -563,18 +563,30 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			struct migrate_vma *migrate, struct dma_fence **mfence,
>   			dma_addr_t *scratch, uint64_t npages)
>   {
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	struct device *dev = adev->dev;
> +	dma_addr_t *dma_addr;
>   	uint64_t *src;
>   	dma_addr_t *dst;
>   	struct page *dpage;
>   	uint64_t i = 0, j;
>   	uint64_t addr;
> +	s32 gpuidx;
> +	u64 offset;
>   	int r = 0;
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
>   		 prange->last);
>   
> -	addr = prange->start << PAGE_SHIFT;

Is this another bug fix for partial migration? If so, it may be worth 
making that a separate patch.


> +	gpuidx = kfd_process_gpuidx_from_gpuid(p, prange->actual_loc);
> +	if (gpuidx < 0) {
> +		pr_debug("no GPU id 0x%x found\n", prange->actual_loc);
> +		return -EINVAL;
> +	}
> +
> +	addr = migrate->start;
> +	offset = (addr >> PAGE_SHIFT) - prange->start;
> +	dma_addr = prange->dma_addr[gpuidx];
>   
>   	src = (uint64_t *)(scratch + npages);
>   	dst = scratch;
> @@ -623,6 +635,12 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			goto out_oom;
>   		}
>   
> +		/* Clear VRAM flag when page is migrated to ram, to count vram
> +		 * pages correctly when spliting the range.
> +		 */
> +		if (dma_addr && (dma_addr[offset + i] & SVM_RANGE_VRAM_DOMAIN))
> +			dma_addr[offset + i] = 0;
> +

I'm not a big fan of messing with the DMA arrays here, but I don't have 
a good alternative. I think what bothers me is, how the DMA address 
array and handling of vram page count is now spread out across so many 
places. It feels fragile.

Maybe it would be good to add a helper in kfd_svm.c: 
svm_get_dma_addr_for_page_count(prange, offset). That way you can keep 
the choice of gpuid and offset calculation in one place in kfd_svm.c, 
close to svm_range_copy_array.

Other than that, the patch looks good to me.

Regards,
   Felix


>   		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
>   				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cc24f30f88fb..35ee9e648cca 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -362,7 +362,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	INIT_LIST_HEAD(&prange->child_list);
>   	atomic_set(&prange->invalid, 0);
>   	prange->validate_timestamp = 0;
> -	prange->vram_pages = 0;
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> @@ -980,9 +979,14 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
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
> @@ -1002,13 +1006,14 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
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
> @@ -1058,7 +1063,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   	new->flags = old->flags;
>   	new->preferred_loc = old->preferred_loc;
>   	new->prefetch_loc = old->prefetch_loc;
> -	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
>   	new->mapped_to_gpu = old->mapped_to_gpu;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
