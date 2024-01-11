Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBB6C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 17:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48FB810E913;
	Thu, 11 Jan 2024 17:38:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BE310E913
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 17:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4XCRiN7NFA7L3XbihGbs36Jlg/Q8yYtGiJjCRUObcADU7HiMpfPDW6hFZ1Mey43/SK92UK2iOaS+GPam88jSeFeif5L8cIIjNQm/lyEsOz4DFCLjnmGcGV86rXwpsmIYb7OB72fVe5aTmjUdYyqmhM8A5/VP8hapdl7KwJjkVEfmgTz/0MOrQ7EgYFyRqEra6YtQAJbHMQvSAfu01mCQpz5zkkGIdj65zJOqtfS6o8c0hJ5mLhjF+K5YYqVGBxTC9YGxdRcWRmn0W6C9yHm+wt6QJmMe9Lmw/En3uyjBVKJ2HuvwWhw2jIw10dUBc7y6XuERys7/kRQusM+u+3A5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHHXaQFkQAaxR1RtZpcLXBsxXU84fyGu3gNEBwSGcmI=;
 b=AIsBya/8suKsiVmWE77l9zLZoueTa6mJGSOcGmbQd06Blrg4sLdm/EYXIvedErHOFK+jaG9FgAYBh7VnBTJ7We3Tpwsgd7upyDzAUK12TGkqqpF/NkJ3M3gDzdt5KEBnN3EbI1zsNhVu8Td84OsEei66r4ZsCu5seOl0byusius7WUKhd3lqOUO4G/PvFaaRAtH5rY8xagmKwnr8QOnG7zIsW0oR5/5+hRxvTlVOVbAFQL6pBQ6gZ1s7BJwfEIeXNnsCk4xMGsekpU4ydAXBbb9nGM56e2hR24+c1FZ+WzRJBYKlLOdAMvQwCXQf9v2XFr8zArtjMiFEWjESGOB5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHHXaQFkQAaxR1RtZpcLXBsxXU84fyGu3gNEBwSGcmI=;
 b=mLHw3b/Wv+4fGelypXcmo37TmM9UsGXMowiqlrV2lbgaCC6hexh3WrwflvDtoWMhqL6vcxHba7jqWQi5rwKqEKvcmZhc7k2GY47GdQ9DmRQxy5oULDuX5C58zOumw0hwsIPv1KRxn10EMK1DvufdXFWQr3rv9RTu3fD38dMCGHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.18; Thu, 11 Jan 2024 17:38:02 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8cf7:bb84:b64e:331]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8cf7:bb84:b64e:331%6]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 17:38:02 +0000
Message-ID: <f7fdea7a-27f2-00a9-2c7d-1b39e6d2821b@amd.com>
Date: Thu, 11 Jan 2024 11:37:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] amd/amdkfd: Set correct svm range actual loc after
 spliting
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240110220143.25973-1-Philip.Yang@amd.com>
 <c76951c2-6abc-49a2-be86-301aa87457ce@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <c76951c2-6abc-49a2-be86-301aa87457ce@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0174.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::29) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8af8f9-193a-4556-393f-08dc12cc0f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YI8D7zy8qiwiEquVvBlVurPpodI7jxhba4IsHa0d+vDozW1wQxNEq791DtefIv0gkTZNWD9svDfJEuZp675vhJlaMZOkYND+jzaa6ywAeo5YfzZoY3fxNWmBxtgGtRVCzzDneKNHRDm4dS/JZjANknQLaIKLzFcNcEVv2jYiZROfmDdX3GjyUgbufN9UTXwaJUKTsGkWR2/qBRVjQB3vu5zxrsJoMEvjHLgUV/pdo2EoI4eJYf5oKzfDNZkfneMMd+21eb96uDz7zuVgIYrz4WsWQJypW/o2pFWw0dT3NzFwiADtzV/yHIQ5der1+vVzCTjv7h5bRxu9s9svSjIQmp2jVbH3Dzxn0V+weNbZr7nZ7mVcAN0aWhqNzXt5rVvHQMST/+CMt3gvIDuADxjghx+jJrG0WJOLJPkfpSW2FxRvPHzLfKSCIAA+dYxXSTt/noLLrOqyWUbvSHyEx3+Aezj3Cq6xcKbKVgDrkFr9GK/5L9wsnpId0Xrzk87nlqNjPfbEehzrMmJiDXckJPrq6oe+QK4rDpe43HbFX6fPp9XUYu4E4Y3z9gxrqfriP1yokiL5Eluxuggy5GarYzK3FnSAqyU4/JhI5OQd/jOyb3MO5qK7Da2Na2HzwTNiY4WXPJSdo3rNW4Xvhs0qg+WuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6506007)(2616005)(26005)(478600001)(6512007)(53546011)(6666004)(5660300002)(83380400001)(2906002)(6486002)(66946007)(8936002)(110136005)(316002)(66476007)(8676002)(66556008)(86362001)(38100700002)(36756003)(31696002)(41300700001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkR3OEE1SjBtTHJrMzlxaVRBQlZjTWEzbWdmUFFKRGpoa2tiUjNKUjVRTGFO?=
 =?utf-8?B?emVQYkRTdUswSGxFNlN2Y1FnRm5sNzRmMUxmV3M5RExkTUJOUGNuU3d2UGRD?=
 =?utf-8?B?b203UjB5Znd4c21CTHJvTHhLM1Y3TklRd1pFQUcrN04waGFjUFBycnhNMGl5?=
 =?utf-8?B?eE9nVDgzQ01oOWQzeDI5Q1Q0ajNxU3Q2SGgyM2tjYVQxSkpqMmVTdXVkSWhp?=
 =?utf-8?B?eDQzUzlPMkhjUDlyaEdIWXphYkVOTXV2VlYxQW1URnF3cjhwbThoWTR1ZlBB?=
 =?utf-8?B?YTR3WXN4cHdyakJnaUF3bWNtcHBWQ3Q4UVNuVTVNSnN3d2tlUCtOVEdBRkVF?=
 =?utf-8?B?c0Z5UFBWZmkvc2xFMEdacEdtazJtUG5zbWhSNG9jb0xUbUJ4TC8rcEhHTUMx?=
 =?utf-8?B?NGR4TTY1cEU3NU1hdFQ1U3BpWGo5Tk5ocEVYQmpmaVNIcjdEZkJiOWdVWlpT?=
 =?utf-8?B?UXdqdUNxaXE0ei9UVVRCSnd1MGMwelR1OWIrdEdiZUZzWENFTERMOHAxeEZX?=
 =?utf-8?B?dHZoajVuaUY5YTVJTFBZL3N2QUFQbTZQV3I2L053dUllcXcwSVB5MFJ1SlB5?=
 =?utf-8?B?aklJVnRuTU5aM2s0MjlsUnpHNEdsdGxrR1BlYjdYQ3BYU04yaG9CdmVNcXlW?=
 =?utf-8?B?TGl2ZVRUeXpJdHNTeXB4bmloaW55QWRydkM3eFdrQ3E5T1ljbHJJT2d4aWRN?=
 =?utf-8?B?YUZyMjc4VHB2RUJibUdOK3c4UWRTZUZvVE5yYjRpUEwwZ2gwV2dQc0Mwcy83?=
 =?utf-8?B?YnhrZDN6Q29RUC9QZkc2dzNqTGNYS29CeXFaVTJTV0J4R09icUUvSlNSdXhK?=
 =?utf-8?B?S0Zpc3k3d013akhOSzVPMGt0azBmNUtkbk0yalhIeW9QakNCd0lubVdUVXdw?=
 =?utf-8?B?eGNYOG54eWRHTHJSRlA0amR6Q1o2N0xDQXpzN0xWYjdmcWszZElVT3QvTzZI?=
 =?utf-8?B?ditjYmFLdFAzZWpBWWxJM21VWXRmcEYxN0FLa0VDRnBDb0RvL2tqdjRDWFZv?=
 =?utf-8?B?c1llNzd6aHNQNzVsZUxIUHpzTVp2UDJUSHhKVnZFNVBwUnNuQmZzSXVoS1pJ?=
 =?utf-8?B?STBWc05Qb0RkTktLaVcydm1vRm9FYkljR2xEQWpUQ041c2FhMWU5VWtyaGlO?=
 =?utf-8?B?WlBSNDZKT1U2c1dvN2o4K1lxYWdaZDJJNEowWmtaaks3VlVlc2R0eGdOWk1m?=
 =?utf-8?B?SHVSbEFmUFBKb3hXa0tCeEFPUFFtZHFjU1hjZ1NscXZCNEFoWlMzVGdKNmdl?=
 =?utf-8?B?SVUyaFdQSFhnb3BwTGpkeTVZdkxaYnliV3RtMC8vaHZGTTcxSW1mSnd2Ym9y?=
 =?utf-8?B?Z2UzMFlCMjByRUdlbllzek1KZGlhYmN3TDU2eU43a0ZmZy8rNE5qZ3VuZkRU?=
 =?utf-8?B?bFg2enZiangxdW5LSldyMXg0MjJtbGlSNTV3Wk1zeE9PUlA0K0dma3VFSVdY?=
 =?utf-8?B?Z0RaYXNpbFZFTS9nNUJwYkYvZUhKbSt5UEwrNThLT04wK3ZqUk5LRGVYUzht?=
 =?utf-8?B?K2NiS1R2cTdMRVlCbHpsaGY0L0RqY3NiOW1GYVRYMWNwOWx6S29YV2FWMDJw?=
 =?utf-8?B?c3RGVytPRHIwaFhXcFlaWnNBZWd1emJjY3hCRWxxa2ZST2FFblFDNXZtZ3lS?=
 =?utf-8?B?a0RTTDYvdWNseE1RdE1TVEZiUVQ2TGh2elYxVVF1ZWN4SzZwaXNGMmxhb0Vn?=
 =?utf-8?B?K2oxbHVPUnpaN2IwUnRkSDVhOU1KWG9sM0Y0ZURPK090ZEZzOWRGRjNNTzgy?=
 =?utf-8?B?eDdlSlJsR3R3dWg4aTlxY0FwTTdQa042czY0Q2h2QW9RTXJFS0JBVW1neHFY?=
 =?utf-8?B?VWQ2UVFQVlBkUXNBQTJqWHdWbnIraFh2Qmp5TDc2WEkwNlpnWW5qTFVRVld1?=
 =?utf-8?B?RG1CVnVYY01OVFZCcWZMV3ZrWG0xUGswMjFlSUxJMmp2MmFaeS9UM0JWVmVR?=
 =?utf-8?B?L2Yya2U2K0hyNlpKTjBlRitxSmtEYzhjQXcrdVRJLzJ4bkFJQjhDbWNmako1?=
 =?utf-8?B?cHFSbzhOamdSTzNNcDY4WHpYR2lhUjNnRDRZejVJOTB1S0lZVndNWWkxSWd4?=
 =?utf-8?B?L2VnelpzQ2JUem5icUFWMmIwRW85QzN0QmV1RThhSnY3SkxXQ0NrUVZvSWlH?=
 =?utf-8?Q?Ek8A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8af8f9-193a-4556-393f-08dc12cc0f69
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:38:02.2103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZRKLopPossLaM7g6ASW5a3K3knbLCecjSK5rk8uFslvvlXUuqHeycjcf5A91X2H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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


On 1/11/2024 10:54 AM, Felix Kuehling wrote:
>
> On 2024-01-10 17:01, Philip Yang wrote:
>> While svm range partial migrating to system memory, clear dma_addr vram
>> domain flag, otherwise the future split will get incorrect vram_pages
>> and actual loc.
>>
>> After range spliting, set new range and old range actual_loc:
>> new range actual_loc is 0 if new->vram_pages is 0.
>> old range actual_loc is 0 if old->vram_pages - new->vram_pages == 0.
>>
>> new range takes svm_bo ref only if vram_pages not equal to 0.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 +++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 24 ++++++++++++++----------
>>   2 files changed, 33 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index f856901055d3..dae05f70257b 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -563,18 +563,30 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>               struct migrate_vma *migrate, struct dma_fence **mfence,
>>               dma_addr_t *scratch, uint64_t npages)
>>   {
>> +    struct kfd_process *p = container_of(prange->svms, struct 
>> kfd_process, svms);
>>       struct device *dev = adev->dev;
>> +    dma_addr_t *dma_addr;
>>       uint64_t *src;
>>       dma_addr_t *dst;
>>       struct page *dpage;
>>       uint64_t i = 0, j;
>>       uint64_t addr;
>> +    s32 gpuidx;
>> +    u64 offset;
>>       int r = 0;
>>         pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, 
>> prange->start,
>>            prange->last);
>>   -    addr = prange->start << PAGE_SHIFT;
>
> Is this another bug fix for partial migration? If so, it may be worth 
> making that a separate patch.
>
Seems it is also a bug when prange is across multiple vma. With partial 
migration it become obvious.
>
>> +    gpuidx = kfd_process_gpuidx_from_gpuid(p, prange->actual_loc);
>> +    if (gpuidx < 0) {
>> +        pr_debug("no GPU id 0x%x found\n", prange->actual_loc);
>> +        return -EINVAL;
>> +    }
>> +
>> +    addr = migrate->start;
>> +    offset = (addr >> PAGE_SHIFT) - prange->start;
>> +    dma_addr = prange->dma_addr[gpuidx];
>>         src = (uint64_t *)(scratch + npages);
>>       dst = scratch;
>> @@ -623,6 +635,12 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>               goto out_oom;
>>           }
>>   +        /* Clear VRAM flag when page is migrated to ram, to count 
>> vram
>> +         * pages correctly when spliting the range.
>> +         */
>> +        if (dma_addr && (dma_addr[offset + i] & SVM_RANGE_VRAM_DOMAIN))
>> +            dma_addr[offset + i] = 0;
>> +
>
When come here we already know the page has been moved to system ram, do 
we still need check

dma_addr[offset + i] & SVM_RANGE_VRAM_DOMAIN)

You want to set dma_addr[offset + i] = 0 anyway.


> I'm not a big fan of messing with the DMA arrays here, but I don't 
> have a good alternative. I think what bothers me is, how the DMA 
> address array and handling of vram page count is now spread out across 
> so many places. It feels fragile.
>
> Maybe it would be good to add a helper in kfd_svm.c: 
> svm_get_dma_addr_for_page_count(prange, offset). That way you can keep 
> the choice of gpuid and offset calculation in one place in kfd_svm.c, 
> close to svm_range_copy_array.
>
> Other than that, the patch looks good to me.

svm_migrate_copy_to_ram already has scratch which save dma addresses of 
destination pages. Maybe we can check it after svm_migrate_copy_to_ram, 
before svm_range_dma_unmap_dev, that looks better.

Regards

Xiaogang


>
> Regards,
>   Felix
>
>
>>           pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
>>                        dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index cc24f30f88fb..35ee9e648cca 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -362,7 +362,6 @@ svm_range *svm_range_new(struct svm_range_list 
>> *svms, uint64_t start,
>>       INIT_LIST_HEAD(&prange->child_list);
>>       atomic_set(&prange->invalid, 0);
>>       prange->validate_timestamp = 0;
>> -    prange->vram_pages = 0;
>>       mutex_init(&prange->migrate_mutex);
>>       mutex_init(&prange->lock);
>>   @@ -980,9 +979,14 @@ svm_range_split_pages(struct svm_range *new, 
>> struct svm_range *old,
>>           if (r)
>>               return r;
>>       }
>> -    if (old->actual_loc)
>> +    if (old->actual_loc && new->vram_pages) {
>>           old->vram_pages -= new->vram_pages;
>> -
>> +        new->actual_loc = old->actual_loc;
>> +        if (!old->vram_pages)
>> +            old->actual_loc = 0;
>> +    }
>> +    pr_debug("new->vram_pages 0x%llx loc 0x%x old->vram_pages 0x%llx 
>> loc 0x%x\n",
>> +         new->vram_pages, new->actual_loc, old->vram_pages, 
>> old->actual_loc);
>>       return 0;
>>   }
>>   @@ -1002,13 +1006,14 @@ svm_range_split_nodes(struct svm_range 
>> *new, struct svm_range *old,
>>           new->offset = old->offset + npages;
>>       }
>>   -    new->svm_bo = svm_range_bo_ref(old->svm_bo);
>> -    new->ttm_res = old->ttm_res;
>> -
>> -    spin_lock(&new->svm_bo->list_lock);
>> -    list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>> -    spin_unlock(&new->svm_bo->list_lock);
>> +    if (new->vram_pages) {
>> +        new->svm_bo = svm_range_bo_ref(old->svm_bo);
>> +        new->ttm_res = old->ttm_res;
>>   +        spin_lock(&new->svm_bo->list_lock);
>> +        list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>> +        spin_unlock(&new->svm_bo->list_lock);
>> +    }
>>       return 0;
>>   }
>>   @@ -1058,7 +1063,6 @@ svm_range_split_adjust(struct svm_range *new, 
>> struct svm_range *old,
>>       new->flags = old->flags;
>>       new->preferred_loc = old->preferred_loc;
>>       new->prefetch_loc = old->prefetch_loc;
>> -    new->actual_loc = old->actual_loc;
>>       new->granularity = old->granularity;
>>       new->mapped_to_gpu = old->mapped_to_gpu;
>>       bitmap_copy(new->bitmap_access, old->bitmap_access, 
>> MAX_GPU_INSTANCE);
