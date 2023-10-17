Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614BDCDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 18:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9EC10E040;
	Tue, 17 Oct 2023 18:07:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7762610E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 18:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VX7/J3yCUqcfr2DMUAOv2am6Pryavc8aJJFGmI2c1sX6vuZB7LQLapIzykc/gqHf+RExjIwycUu0hwniNFhySl9Cl7BdkoDF8lKAYRyhgOHWZqJfbS1Z8GZIA2xgEQVqprU7jPUdDlZPTuac6UyJZE0RJYWD/HHFnKrVoZPCJsPX+eopJPpAYeVDWXl6Jj50Sn5jXrSqB5O6YT7h7ndB7XLoqg8L0sIKpAHLG2Q8N6r3PAiwbVD/ctKn3TpCpvPYQkv/eOBU8gSkz8qRgF3mlUq2jqbBe6KVi/mUSHkLDkW8gkhdKaXR6CVn1zErbR59Gu95KxmNZ+9+LmGztzdgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o97cRBjQKfCZ13Zzgff0ZXDPaG54zMq5rTrIZ5jBemg=;
 b=N6mytYMojjUjTNwM2g04+SeEYBPWBwgxJc8WsUeebsgrVydAYbmu9BnQlPBCHRJDOEy30FVx4bXf6AyO1E8WU4clIQ+V5JW79ttwkfPax20zeaZbSzPq31EjLpQu1xsTra5O3hBBNAJQ/bEhgp95O4ZS2X3Hkz/NaxTotW9OI/4nAR2VRmElEDlEXU3V9ATjk53jJbm06VCSnq67kHHj74WV9ItvWxPoNHuWCVF8Rxg9NuRIahRyFXZEJFHVRFm89Yy2sDYaW1GNxXSgzHfdn5RCXAVzUEXQ5IVLHXPeLrMxeO/81wX7z39Si5lTUm8iKulOsW9r+s4qmYBLJf9qMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o97cRBjQKfCZ13Zzgff0ZXDPaG54zMq5rTrIZ5jBemg=;
 b=K2CoqD9OFNS9UH3po5xt/UTkx7rz1BzRWk4tcUClczdS3mEBO7sW8l5ccsnyZudNSo/Z5fguvTAcL024lcRX0uab2/kvEjj4nF9sQ+o5EMD5lVaCmmsQBggXB3sx7WKINkmSWWfPDpdgE54gr5Ic5ByzjPAeYv1ezg2jXKr0L7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 18:07:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 18:07:53 +0000
Message-ID: <2a9c06ec-9152-49b4-8974-c3976404103e@amd.com>
Date: Tue, 17 Oct 2023 14:07:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] amd/amdkfd: Add granularity bitmap mapped to gpu
 flag
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231010144024.3016-1-Philip.Yang@amd.com>
 <20231010144024.3016-3-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231010144024.3016-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: c73f9af7-a011-4ed1-55c7-08dbcf3bfb89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8Voo8k+ak4dYe+3M5xdu/Tr7S4F/PH2L8w69r33rVgpXwEnFiaQYzL8gG5oPIlwO/jjYyh5r5yQrhW37vYOWvSCc/OWgFOVWq8mSg42rTixZzmZ6oeDRSB9pCOI6IDbvBfufzh0IzrjzuntYAK6NQniHf3YcGcLEkyw1i+67ziZzBHBLyxEDoJ6m2VlYocq2HON2xuQULvFBNnHepTVNyBQN901gDGP5VjHVoBzK9Pf4OozFtm7TE4x8QWDt8hsDZ+n52D97W23qchPveAqDaSwRmFY1OjywT7s0q0KSnk+IcB14AFWH8Evo5C3FZDChH2UHERaIPkn5Y6D0iNvD11zljznmdXQEmu6et8hnDhX2TnuAwHgHQdkrnjR9/GNduyA03Hj8RCS9N/nBeQm9+ByLF68MREx9l/tHUmYf+qwttJwrYuscN/QWG3tyLIUhrFUQGf5SrP8ZNTw7CWPDdYhCUT4BJeUER/idyX/YDAZyaan1wEBriLe8HeShjPnEd1kloom1sG7cgPcP1xYF1MwFp0AVzyI9sKn9ivsSuRCV001EHM9rnw/U/VeqVU+MPkMQ6FVcMt/JmAKnSw3qlpC0/TD29EIP1ADpHXudD8ymoVS6Fy4acWTezVe2H27zhWe4OJ2KA7BiPBMI3s/gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(30864003)(316002)(66946007)(66476007)(86362001)(4001150100001)(2906002)(31696002)(66556008)(5660300002)(44832011)(41300700001)(8936002)(8676002)(36756003)(2616005)(31686004)(38100700002)(478600001)(6506007)(53546011)(36916002)(6512007)(6486002)(26005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBYZktHUnpwLzNNUVZUTWF6SU83N0wzZGxQZmt5MTNrLzAraHhSNjZpUlFZ?=
 =?utf-8?B?WVJWMGJvQ0NOdUtXUnlZU1RvV3BUYkNVLzUrMUNISlpGR1lyeGhKb0tBUmhr?=
 =?utf-8?B?VkNLZ3A4RjZGem51Z1c0dk5zbEs3bkxHR2N4UmtpWUptSkJYWTRmQ2NLL1VI?=
 =?utf-8?B?WUNwWFQzRTJuUE82cHVqdFJkYnd6b1c4YndDeU12VTNPRG8zeW51VkhMTUMx?=
 =?utf-8?B?OUloclppNTYrZDJCWVc1aUQvSTZrTmRjeXAwSDFZNldUN0FhcXBJS1RmY01u?=
 =?utf-8?B?T0gzMk12Nkd1OTZtWjk3NEhwTE9FTU44SEpOUEVpbXFMZ1R6NVQzWTd3cmhM?=
 =?utf-8?B?b1VDbTBpckRTVEhWZC9qYmRsSWxac053TTBUY2IxeWZpZXVHZEZSZVFlVWNQ?=
 =?utf-8?B?aW1GOVQrVXQ0amJNcUdNUE1acWp0N2c0eWdLNjE3Y0IwSjZzU2N4R1NidjMz?=
 =?utf-8?B?MXY1WkRCeGMxUmkwN3R1enpMZ0UxZk54QlNhd2R0WDkxMjQzOW9LRWxoK0FF?=
 =?utf-8?B?MTNwb25zWFNNaUtyTTFKRDRwMkJpQnU5bjQwcEIzaFd0MVdYbTZQa2lmMUJv?=
 =?utf-8?B?c2RHWkdJMks5UXZvY3VBWlREa3RhSFBUbjNCdUtNdnF3SnR0UHRKVU1UK2Fo?=
 =?utf-8?B?dUU2clF4SUQxMGdjcHlBbnM0czdpaEVBMTRTaUc5a3BlazRKMlRsd3JrUmgv?=
 =?utf-8?B?K3lSdERTQyt0bGg1UXl5NkNEc2UvdFYrUDB4U3hxL0FBa1ozem8yZzBlL0I0?=
 =?utf-8?B?enQ0dlpWMTVtN0ZSLzBNNmhtQTE1cGRtS2o4c2pSN1J2cGVYTkdsK3dtbTN1?=
 =?utf-8?B?VHU1Z3MvcUxIWXorUVJVWitXNHdTMEp2bU5CVGVRaGg5Qjk2NWdiRVBkVFR6?=
 =?utf-8?B?VWVRZlZ2YUxheXoxOU9nbFp1ci9sejhWOTI2ZVBIdHU3MnN5MEorcEZZZ3Ft?=
 =?utf-8?B?M3k5ME1HdUdEbnA0bDFUbDB5KzJRc0MvSjZkY0hFcE5FLzNpVE5EbFVucVIv?=
 =?utf-8?B?cHZNSVhveUpHVXprZEEyVlowV1h4d2MxRWUyQzBxWXZ1Z0ZGeWJkOG5ZdVpY?=
 =?utf-8?B?TjdnRHZoUS9odHY0R2pBUnZVM0tXN05XcGh1WDlKWHJ6alNPQWxOdWNzaFdC?=
 =?utf-8?B?NFFhNC92MkZSZkQ0QXJXcitSem1vU1A5aWs1ZWgyL2xxTStaTWVadFpXdCt6?=
 =?utf-8?B?dlFSdDloL1czaDZFblBjdm1ONFdRTEsxc0VXSmFINkZYSFJ3LzczTzFjeG83?=
 =?utf-8?B?YWNpRDZjVnQvbUI5SWl2dHJ6eVdpRzR3UzRKeFdnWm9YVUZYUHBWQkVFZ2tZ?=
 =?utf-8?B?b3hVSkxzVWdrVFlodW9XeW1ZZjZhbTE4UVY0TTBBMEdCK3dlWGVjWmgxRkxv?=
 =?utf-8?B?N3RlQnY1M1JvY0NMMlVLOEZ2QmorU1VmbXBoMERsOFF5VUlUbkZHRVRINTA2?=
 =?utf-8?B?VFYrZUVXanVzbGp6ODV5UFEwdWNrd2FmRmV6ZTN3MldkOUorRVcrOVFVYmwr?=
 =?utf-8?B?dG5XZ1hxL2ROK2xodXVTSHYrQWE2RzNURkhncTAyMEdna09rQ0VDaTBkbzEy?=
 =?utf-8?B?Tk41aTVYcUxqWm4xR0Z2UGN1OEVUSElxWEs5c3p5dVk4R1U5dm03WEVXM0Mv?=
 =?utf-8?B?QWEvNVRNYlFnaEt2cnd5d0hwbXQ2WS96ZWp4RjV4WTJsY3M1YlNEbUFwcHl5?=
 =?utf-8?B?TEVoMy8zQnljUTlZNTdDcDJOTHFOdjdWQklSeStRTFVJUHBDdHZjTFRqb0Ro?=
 =?utf-8?B?SHRaS1VydEI4UkwyYW5XdTE4YkZ4V29kelhSSG5GQVM2cnpwY0dRSHRhdXNr?=
 =?utf-8?B?eTZIVDdaV0tpOFlZZ0dMb0ZSK3lWYlRvTDMxRkN4MmVPazZuMFRiL2VMUjVv?=
 =?utf-8?B?SjdDZzJTaXV6T3pSN3pIOEU5Uk5xME5KRlMvWnF5YkJreWNjWmRkWnNWVlVF?=
 =?utf-8?B?WDFhU1JOazZrQVJPU2c2elRZOENyTk1ZTXZJZUp6RjEwbytzakk2WWFrU3Bj?=
 =?utf-8?B?Sk5uM2o3aytoQkpacWNMdUtMTEEvbnZCU3lwUEhidGZvZ0wzOExTUWZLMEdX?=
 =?utf-8?B?aVg1ai81VUkzMmJEMUxXSWNYVHNYTHBna2tPZFF0NlZQM1FFMkE0UmFmWkNN?=
 =?utf-8?Q?VlDpBBBJSGbQZ1pkZJXF0CE4+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73f9af7-a011-4ed1-55c7-08dbcf3bfb89
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:07:53.4201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjweRo1JTBO/gdh+ZkT9v7wOC6buf+yJmzNZlqd+ouenpHfrRihtbA/2ZHVRJq93oTQ8WiQANsi8Fdq4iMF4KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
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


On 2023-10-10 10:40, Philip Yang wrote:
> Replace prange->mapped_to_gpu with prange->bitmap_mapped[], which is per
> GPU flag and based on prange granularity, updated when map to GPUS or
> unmap from GPUs, to optimize multiple GPU map, unmap and retry fault
> recover.
>
> svm_range_partial_mapped is false only if no part of the range mapping
> on any GPUs.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 256 +++++++++++++++++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |   8 +-
>   2 files changed, 213 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fb22b857adbc..4e1af4b181ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -296,12 +296,12 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
>   	}
>   
> -	/* free dma_addr array for each gpu */
> +	/* free dma_addr array, bitmap_mapped for each gpu */
>   	for (gpuidx = 0; gpuidx < MAX_GPU_INSTANCE; gpuidx++) {
> -		if (prange->dma_addr[gpuidx]) {
> +		if (prange->dma_addr[gpuidx])
>   			kvfree(prange->dma_addr[gpuidx]);
> -				prange->dma_addr[gpuidx] = NULL;
> -		}
> +		if (prange->bitmap_mapped[gpuidx])
> +			bitmap_free(prange->bitmap_mapped[gpuidx]);
>   	}
>   
>   	mutex_destroy(&prange->lock);
> @@ -327,19 +327,38 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	uint64_t size = last - start + 1;
>   	struct svm_range *prange;
>   	struct kfd_process *p;
> -
> -	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
> -	if (!prange)
> -		return NULL;
> +	unsigned int nbits;
> +	uint32_t gpuidx;
>   
>   	p = container_of(svms, struct kfd_process, svms);
>   	if (!p->xnack_enabled && update_mem_usage &&
>   	    amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
>   				    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0)) {
>   		pr_info("SVM mapping failed, exceeds resident system memory limit\n");
> -		kfree(prange);
>   		return NULL;
>   	}
> +
> +	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
> +	if (!prange)
> +		return NULL;
> +
> +	svm_range_set_default_attributes(&prange->preferred_loc,
> +					 &prange->prefetch_loc,
> +					 &prange->granularity, &prange->flags);
> +
> +	nbits = svm_range_mapped_nbits(start, last, prange->granularity);
> +	pr_debug("prange 0x%p [0x%llx 0x%llx] bitmap_mapped nbits %d\n", prange,
> +		 start, last, nbits);
> +	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +		prange->bitmap_mapped[gpuidx] = bitmap_zalloc(nbits, GFP_KERNEL);
> +		if (!prange->bitmap_mapped[gpuidx]) {
> +			while (gpuidx--)
> +				bitmap_free(prange->bitmap_mapped[gpuidx]);
> +			kfree(prange);
> +			return NULL;
> +		}
> +	}
> +
>   	prange->npages = size;
>   	prange->svms = svms;
>   	prange->start = start;
> @@ -359,10 +378,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>   			    MAX_GPU_INSTANCE);
>   
> -	svm_range_set_default_attributes(&prange->preferred_loc,
> -					 &prange->prefetch_loc,
> -					 &prange->granularity, &prange->flags);
> -
>   	pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
>   
>   	return prange;
> @@ -984,6 +999,47 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
>   	return 0;
>   }
>   
> +static int
> +svm_range_split_bitmap_mapped(struct svm_range *new, struct svm_range *old,
> +			      uint64_t start, uint64_t last)
> +{
> +	struct kfd_process *p = container_of(new->svms, struct kfd_process, svms);
> +	unsigned int nbits, old_nbits, old_nbits2;
> +	unsigned long *bits;
> +	uint32_t gpuidx;
> +
> +	nbits = svm_range_mapped_nbits(new->start, new->last, new->granularity);
> +	old_nbits = svm_range_mapped_nbits(old->start, old->last, old->granularity);
> +	old_nbits2 = svm_range_mapped_nbits(start, last, old->granularity);
> +
> +	pr_debug("old 0x%p [0x%lx 0x%lx] => [0x%llx 0x%llx] nbits %d => %d\n",
> +		 old, old->start, old->last, start, last, old_nbits, old_nbits2);
> +	pr_debug("new 0x%p [0x%lx 0x%lx] nbits %d\n", new, new->start, new->last,
> +		 nbits);
> +
> +	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +		bits = bitmap_alloc(old_nbits2, GFP_KERNEL);
> +		if (!bits)
> +			return -ENOMEM;
> +
> +		if (start == old->start) {
> +			bitmap_shift_right(new->bitmap_mapped[gpuidx],
> +					   old->bitmap_mapped[gpuidx],
> +					   old_nbits2 - 1, old_nbits);
> +			bitmap_copy(bits, old->bitmap_mapped[gpuidx], old_nbits2);
> +		} else {
> +			bitmap_copy(new->bitmap_mapped[gpuidx],
> +				    old->bitmap_mapped[gpuidx], nbits);
> +			bitmap_shift_right(bits, old->bitmap_mapped[gpuidx],
> +					   nbits - 1, old_nbits);
> +		}
> +		bitmap_free(old->bitmap_mapped[gpuidx]);
> +		old->bitmap_mapped[gpuidx] = bits;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * svm_range_split_adjust - split range and adjust
>    *
> @@ -1024,6 +1080,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   			return r;
>   	}
>   
> +	r = svm_range_split_bitmap_mapped(new, old, start, last);
> +	if (r)
> +		return r;
> +
>   	old->npages = last - start + 1;
>   	old->start = start;
>   	old->last = last;
> @@ -1032,7 +1092,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   	new->prefetch_loc = old->prefetch_loc;
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
> -	new->mapped_to_gpu = old->mapped_to_gpu;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>   
> @@ -1346,6 +1405,108 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   				      fence);
>   }
>   
> +/**
> + * svm_range_partial_mapped_dev - check if prange mapped on the specific GPU
> + *
> + * @gpuidx: the GPU index to check
> + * @prange: prange to check
> + * @start: the start address in pages
> + * @last: the last address in pages
> + *
> + * Return:
> + * true: if any part of the range within [start, last] mapped on the GPU
> + * false: if the entire range [start, last] not mapped on the GPU
> + */
> +static bool
> +svm_range_partial_mapped_dev(uint32_t gpuidx, struct svm_range *prange,
> +			     unsigned long start, unsigned long last)
> +{
> +	unsigned long start_index, last_index;
> +
> +	start = max(start, prange->start);
> +	last = min(last, prange->last);
> +	if (last < start)
> +		return false;
> +
> +	start_index = (start - prange->start) >> prange->granularity;
> +	last_index = (last - prange->start) >> prange->granularity;
> +	return find_next_bit(prange->bitmap_mapped[gpuidx], last_index + 1,
> +			     start_index) <= last_index;
> +}
> +
> +/**
> + * svm_range_partial_mapped - check if prange mapped on any GPU
> + *
> + * @prange: prange to check
> + * @start: the start address in pages
> + * @last: the last address in pages
> + *
> + * Return:
> + * true: if any part of prange mapped on any GPU currently
> + * false: if the entire range is not mapped on any GPU
> + */
> +static bool
> +svm_range_partial_mapped(struct svm_range *prange, unsigned long start,
> +			 unsigned long last)
> +{
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +	struct svm_range *pchild;
> +	uint32_t gpuidx;
> +
> +	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +		list_for_each_entry(pchild, &prange->child_list, child_list) {
> +			if (svm_range_partial_mapped_dev(gpuidx, pchild, start, last))
> +				return true;
> +		}
> +
> +		if (svm_range_partial_mapped_dev(gpuidx, prange, start, last))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/**
> + * svm_range_complete_mapped - check if prange mapped on all GPUs completely
> + *
> + * @prange: prange to check
> + *
> + * Return:
> + * true: if the entire prange mapped completely on all GPUs that need access
> + * otherwise return false
> + */
> +static bool svm_range_complete_mapped(struct svm_range *prange)
> +{
> +	int nbits = svm_range_mapped_nbits(prange->start, prange->last, prange->granularity);
> +	DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
> +	uint32_t gpuidx;
> +	int r;
> +
> +	r = svm_range_need_access_gpus(bitmap, prange);
> +	if (r)
> +		return false;
> +
> +	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE)
> +		if (!bitmap_full(prange->bitmap_mapped[gpuidx], nbits))
> +			return false;
> +	return true;
> +}
> +
> +static void
> +svm_range_update_mapped(uint32_t gpuidx, struct svm_range *prange,
> +			unsigned long start, unsigned long last, bool mapped)
> +{
> +	unsigned long index, nbits;
> +
> +	index = (start - prange->start) >> prange->granularity;

This aligns the address "buckets" represented by bits in the bitmap with 
the start of the range. To be effective to protect page table fragments 
and PDE-PTEs, I think you need to align the buckets with the range 
granularity. That means that both the first and the last bucket may be 
less than the granularity size.

With that, I think the index calculation here should be:

     index = (start >> prange->granularity) - (prange->start >> 
prange->granularity);

This probably has more consequences throughout the rest of this patch, 
including calculating the size of the bitmap correctly.

Regards,
   Felix


> +	nbits = svm_range_mapped_nbits(start, last, prange->granularity);
> +	if (mapped)
> +		bitmap_set(prange->bitmap_mapped[gpuidx], index, nbits);
> +	else
> +		bitmap_clear(prange->bitmap_mapped[gpuidx], index, nbits);
> +	pr_debug("prange 0x%p [0x%lx 0x%lx] update mapped %d nbits %ld gpu %d\n",
> +		 prange, start, last, mapped, nbits, gpuidx);
> +}
> +
>   static int
>   svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   			  unsigned long last, uint32_t trigger)
> @@ -1357,29 +1518,28 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   	uint32_t gpuidx;
>   	int r = 0;
>   
> -	if (!prange->mapped_to_gpu) {
> -		pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
> -			 prange, prange->start, prange->last);
> -		return 0;
> -	}
> -
> -	if (prange->start == start && prange->last == last) {
> -		pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, prange);
> -		prange->mapped_to_gpu = false;
> -	}
> -
>   	bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
>   		  MAX_GPU_INSTANCE);
>   	p = container_of(prange->svms, struct kfd_process, svms);
>   
>   	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
> -		pr_debug("unmap from gpu idx 0x%x\n", gpuidx);
>   		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
>   		if (!pdd) {
>   			pr_debug("failed to find device idx %d\n", gpuidx);
> -			return -EINVAL;
> +			continue;
>   		}
>   
> +		if (!svm_range_partial_mapped_dev(gpuidx, prange, start, last)) {
> +			pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] not mapped on gpu %d\n",
> +				 prange->svms, prange, start, last, gpuidx);
> +			continue;
> +		}
> +
> +		svm_range_update_mapped(gpuidx, prange, start, last, false);
> +
> +		pr_debug("unmap svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu %d\n",
> +			 prange->svms, prange, start, last, gpuidx);
> +
>   		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
>   					     start, last, trigger);
>   
> @@ -1519,6 +1679,10 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   		if (r)
>   			break;
>   
> +		if (!r)
> +			svm_range_update_mapped(gpuidx, prange, prange->start + offset,
> +						prange->start + offset + npages - 1, true);
> +
>   		if (fence) {
>   			r = dma_fence_wait(fence, false);
>   			dma_fence_put(fence);
> @@ -1670,7 +1834,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>   		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> -		if (!prange->mapped_to_gpu ||
> +		if (!svm_range_partial_mapped(prange, prange->start, prange->last) ||
>   		    bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>   			r = 0;
>   			goto free_ctx;
> @@ -1755,9 +1919,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
>   						  ctx->bitmap, flush_tlb);
>   
> -		if (!r && next == end)
> -			prange->mapped_to_gpu = true;
> -
>   		svm_range_unlock(prange);
>   
>   		addr = next;
> @@ -1939,22 +2100,8 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   	if (!p->xnack_enabled ||
>   	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>   		int evicted_ranges;
> -		bool mapped = prange->mapped_to_gpu;
> -
> -		list_for_each_entry(pchild, &prange->child_list, child_list) {
> -			if (!pchild->mapped_to_gpu)
> -				continue;
> -			mapped = true;
> -			mutex_lock_nested(&pchild->lock, 1);
> -			if (pchild->start <= last && pchild->last >= start) {
> -				pr_debug("increment pchild invalid [0x%lx 0x%lx]\n",
> -					 pchild->start, pchild->last);
> -				atomic_inc(&pchild->invalid);
> -			}
> -			mutex_unlock(&pchild->lock);
> -		}
>   
> -		if (!mapped)
> +		if (!svm_range_partial_mapped(prange, start, last))
>   			return r;
>   
>   		if (prange->start <= last && prange->last >= start)
> @@ -2005,7 +2152,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   
>   static struct svm_range *svm_range_clone(struct svm_range *old)
>   {
> +	struct kfd_process *p = container_of(old->svms, struct kfd_process, svms);
>   	struct svm_range *new;
> +	uint32_t gpuidx;
> +	int nbits;
>   
>   	new = svm_range_new(old->svms, old->start, old->last, false);
>   	if (!new)
> @@ -2027,8 +2177,13 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	new->prefetch_loc = old->prefetch_loc;
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
> -	new->mapped_to_gpu = old->mapped_to_gpu;
>   	new->vram_pages = old->vram_pages;
> +	nbits = svm_range_mapped_nbits(new->start, new->last, new->granularity);
> +	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +		bitmap_copy(new->bitmap_mapped[gpuidx],
> +			    old->bitmap_mapped[gpuidx],
> +			    nbits);
> +	};
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>   
> @@ -2147,7 +2302,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   		next_start = min(node->last, last) + 1;
>   
>   		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
> -		    prange->mapped_to_gpu) {
> +		    svm_range_complete_mapped(prange)) {
>   			/* nothing to do */
>   		} else if (node->start < start || node->last > last) {
>   			/* node intersects the update range and its attributes
> @@ -3641,7 +3796,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   		if (migrated && (!p->xnack_enabled ||
>   		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
> -		    prange->mapped_to_gpu) {
> +		    svm_range_partial_mapped(prange, prange->start, prange->last)) {
>   			pr_debug("restore_work will update mappings of GPUs\n");
>   			mutex_unlock(&prange->migrate_mutex);
>   			continue;
> @@ -3652,7 +3807,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			continue;
>   		}
>   
> -		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
> +		flush_tlb = !migrated && update_mapping &&
> +			    svm_range_partial_mapped(prange, prange->start, prange->last);
>   
>   		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
>   					       true, flush_tlb);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index bf2fde008115..7e165854bc0e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -136,7 +136,7 @@ struct svm_range {
>   	struct list_head		child_list;
>   	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
> -	bool				mapped_to_gpu;
> +	unsigned long			*bitmap_mapped[MAX_GPU_INSTANCE];
>   };
>   
>   static inline void svm_range_lock(struct svm_range *prange)
> @@ -167,6 +167,12 @@ static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
>   		return NULL;
>   }
>   
> +static inline int svm_range_mapped_nbits(uint64_t start, uint64_t last,
> +					 uint8_t granularity)
> +{
> +	return (last >> granularity) - (start >> granularity) + 1;
> +}
> +
>   int svm_range_list_init(struct kfd_process *p);
>   void svm_range_list_fini(struct kfd_process *p);
>   int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
