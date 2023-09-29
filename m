Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61694E728CF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 18:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29DF10E1AD;
	Fri, 29 Sep 2023 18:41:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5161510E1AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 18:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoBeO+w5xtZv4oRZ8CS1T616CnsrHKOKV4AomrdSqwn994kZgX9H4+uwoXL8GYNz0wRuWjpXU3/taTZS7Ia0Z1R+n9ZmjN6fOIdK3qfcTYV2L00pqHB4gKXM3+oFdCXWOGFLHUH4BjGowWdBYuVwOryRdMHrsQ6Mp1Urlkr5L6UogNg2E0RlP5jpebLK1rAPOo9JjYb3P5QZJcZHwk2GA/S+uihAVgAA9nEL1Sl/wHNcUN6onsEqY5B9EqB5+dvjkGRkl6Ne3VFfpiO8CKnV85gdabJCvmjOxGWHjbghYrNbOeHpSKiuRd2RuqFGomXpwTCjZT5DwsfseWGZIKzViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Nb6ZaJIKA5E7EMk24/D9ydebdpzHYngU0HwvsfhB9s=;
 b=aXkvuiiBSvVTEDPl4sO8dwgdMhYGYJkJwrj73d1I8w5RUHavtaTVD83xSDg0AS25HFJZ3dIwNsXIsgMU0qfGH69KrXYAaHbj+0WZTCFXAQVNibo5p1glO5qSfYvqBSE7DtQXnBDVFU41YpiB4cM3dyoHRsO/VGI9zSaD4TAPc61EUZoIgdr2IljUfBvkdLVW7LCYfEYws8TBgO4kSM76cphXITEJHbyHW69Pjf1wFiDSo1JETMQ4WFKOKV1AYBfL8g9+cgahLE7BJJDFtKUXtunc3FcoN4x3R5nBFa4k7/38Z4VqmclNAxM4d7teS092iTBUYRh2sq0ZYfU/kFodlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Nb6ZaJIKA5E7EMk24/D9ydebdpzHYngU0HwvsfhB9s=;
 b=HPRdY80XDgK1qnWcdZGIzbog2sSIdf2HMaa52k5Xq945d+tcYWstPddRrKaVlih2kT1mjKOTCxPmag+G2pxA9ICEC0issn0VumiHQOv6q86Q7Mfwo2/IB3idoxwmHz+htBa5FU8WIbSZ7p4nleMsqsjZqSLS6645ax8PNVPk4wQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Fri, 29 Sep
 2023 18:41:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 18:41:09 +0000
Message-ID: <44d8ab8f-6ab3-54b3-d600-8cc6943b2ca3@amd.com>
Date: Fri, 29 Sep 2023 14:41:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230920173203.12760-1-xiaogang.chen@amd.com>
 <cdbc2263-d6c7-ab0a-0bf2-3361dd34a358@amd.com>
 <7ab40093-5e86-796d-eee8-c6172b41ef47@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <7ab40093-5e86-796d-eee8-c6172b41ef47@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0196.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da53710-e202-49bb-5d7d-08dbc11ba60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rssTCU0XtuC377Zy9RYUUH2w7c1+2FrGVz4BZ8BaVqQBBJnwvPvKthrbKgwMO0AToAeJiv5Rwfr/IMFciOEOKqDV+MMWfyvZ3+GbUtaFRegO68VisY4tkDPTbfxaHDJIutVEwF76sfpc+B8/Vgc2UhvESsDPjMn5ma2yvi1bL6XNFqLbFbuHzSdTAU4j5kuVwiPZbw2nFSyxA+ZU+zU2p8k0s7wnf3iYmeDChfIHSig6Nrat2iixfBtgqUTf0V/O4EaioejJc17F2YOJ2sKrqfLNlxiNREHnXKFNzmUSerFwFgDHTDLrewYGz6XEiwjKEb3lnltv/RBNUxPuz9df1azvX5M0hSpop+aJv6hd0x/HrH98FlY2+VjYYRtWq91dZwdbIukvUSyq1oBiaBSA+TcCCdn2X5kTgDltjskWYXz7pdR3bd75xWTm7g1YHScgrQ9unQH35uHi62Txcob+fU67YIlpQYCay2EncIZEXp/spfZOjuwdtDtRBntxNrStNdcCTqoGVKkO1iJru1GaN5Q4YsHni04sgGdTJRRgxn4CVYgr/cvReFR3Idw1mGYdNCAlqsOxH0ekzJd9lmFbTEMXOmU6xYk24uPIwELQSYQZnOKIgarLy3KvqunmX+E5gv4DV2jLHBM+yvOjyzWwOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(478600001)(5660300002)(31686004)(8936002)(8676002)(2906002)(26005)(30864003)(66476007)(966005)(66946007)(4326008)(44832011)(66556008)(316002)(41300700001)(6486002)(36916002)(6506007)(6512007)(53546011)(36756003)(2616005)(83380400001)(31696002)(86362001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0dwSlpwdzMxQi9DeXhoTUpGMWlSa2w0MkNvZWRmWmtMWEhnY0dUckJOb0Y5?=
 =?utf-8?B?YkRtdGlMOER2RlU3d3lHM04wUU9haFcyK1JhYTdjM2JKT0JJaWZFTDYyWVQx?=
 =?utf-8?B?OVo1MTYrREVYbHBMWVFqdC92L2xBQzh6TUpwQVk0b3RDdnpZYzhtSTJWdWpN?=
 =?utf-8?B?Q1V0cjIwSWRwcjk2M3BGNGgwS0JWUDcvMHk0TWo5RHBQeWhqVlN1NFRqOGU3?=
 =?utf-8?B?ZzFBZnJ2empsM2RaNi9EYitkUzliZUlsQmxiYXVMblBVKzBxQW1nbGdlY1F2?=
 =?utf-8?B?S1NDUWlLdk1TazQwMkZGTmM0ZlVGaTRGUElIL215NVkrcUVpblRETDVmRXlp?=
 =?utf-8?B?V1JqS24wcGtwUzIvSzFGSHJ6U3NGYkErMHFoWXNYNk5pY0Q0amdjUXFhMHB1?=
 =?utf-8?B?RkptN3QvL1FGUHNMZ0ZqU1FyU3BnclpTZmR2VEtsN1BZTG1rUlN3Ui9GRmxh?=
 =?utf-8?B?dkI1ZEJxNklpWE5RWXE2NmpNcmNQQ2J1UXRsVmMvQmpGSzgrYjgxQWM4OHE5?=
 =?utf-8?B?SEVSWjAzb3BHRWVsYzh6dHhCZVJJWDd2VXdGaWY2M0NwbGVJUjIxVjZzMzh4?=
 =?utf-8?B?eXdpbUo2UnpCdURVRExqeERLOUV4OHdNMTRaTzRwU25TYTg1bkwwQmwyMUxC?=
 =?utf-8?B?Z0wwdXZRcWtyVkdDMFV2VGhxOXVWbWw4c1VnR2dvVWFmUklQU1k0YzI2Tlhz?=
 =?utf-8?B?eTVVNFRGSU9TdjFsR3loMHRBL1JSZW1SZCtjSTJOS3BlTkY5ZGpWeFBZNUQx?=
 =?utf-8?B?dEdURGNRNm10dTRZUHpJdWw5Rm1xY0tXWG5Ja1Fha3NEK3V1SS84dndFTnNL?=
 =?utf-8?B?MWxKZFFhY1Iyem1HYkJKeWNQdmVKZEhsbWcybjNrOUlCY0N1NTVMb0dHUGpy?=
 =?utf-8?B?V2dETjNYZG84ckpqV0pQTUcvWExSSHYycVJHMlhSKzJzWnVacHpjN3lxTHJL?=
 =?utf-8?B?MWJsc1dFeHBWZzJZZVFOSGFROFBIQTFtaWl4ejRHb1ZBdTZEY00xbE5oZm5E?=
 =?utf-8?B?azBrZzB2RjhNeHo5amVWYkFiSXhQU2tPdURJdmpYbVJTWVhTek1hVEJLSkxO?=
 =?utf-8?B?enJsVFR5QnBkV2IxcUJ1alNYNFRFZUExOHZKajFjeWJXNlpEZW1iZkdJTDY3?=
 =?utf-8?B?WGRBZjkxN2h2RkZhYXU5Q3JWcEM3dHhIcnpQU1hDWXIwL1UzdFFsY3RiTldq?=
 =?utf-8?B?WE12TGJGUnN4T2tRbDR2b1RpL3pOQ3YyWWJSbUR4aVhUOUFKcjRkUVNhYW03?=
 =?utf-8?B?T2tLSFBHV3ZIdjlnWXJOZWJwcVhmNXhxNGlNdDNwaEFyVHdxVzAyTnplZXl0?=
 =?utf-8?B?cktuamU0NXZHTVBzQnZDVFdoT1IwZjBtZFVGWXkyNW1yRnJHMStYR3dvT1Rx?=
 =?utf-8?B?b0pqQmQ4Rk5TTUpVTExRZWdDZDFBSDVIVloxWjd0TkJwaVNHQkIralBJQTFO?=
 =?utf-8?B?MlN3Y2xiTGFsRjZZOVhZT3NISk5SL3RWTUcyVWF4UGtYUzN1bzJRUVlxTkFt?=
 =?utf-8?B?VUlWU2FmRk12Q0pYa2t4WEtvZ0YweGdHdk1maFJTMWI5cDVjOEJvUHJjQnhj?=
 =?utf-8?B?b1FqQk5kQjZOem5SdWlvc2ZNczc2cDZEWVlwRngrLzB1UTMwSlhia3E2ckNU?=
 =?utf-8?B?L2lqS2dVMGRhbDB1dFFVczRzeUc4a1JTbFdsK3dKOTZGUzN6eGM0dXNmL1JN?=
 =?utf-8?B?WVlLaEpOUGQvT2lRZlFlV1hyMzFKUG5YTUdXMnNWR3AzSzNXZ0h5MERuOWcx?=
 =?utf-8?B?SlJhb1BEdFJKaWFscVdORzJwNG5iRWFXcy82NHZYczE5M0JUMlZuR1NVVWNk?=
 =?utf-8?B?TGZlcUtwVGNlQUxScGRjSkxwTVBtZUgwRkUyb0s1elZtc2swY2R4NmM2L1Nw?=
 =?utf-8?B?RWVHMXRRdnA2ZlNzcHU4cXkzQlhlYXFWVUxDNHRsdnZtOFcvNkpnZFhiUEh4?=
 =?utf-8?B?ZjIzZWkrUjM5bCs0Zm5LcElaWUZWd214d1Zpck0vSkVHVncxTkpjZUNGR1VE?=
 =?utf-8?B?bmFlbHMvbkRqZUd5OVpIVWtrQ1MrOXdxT2RxelVWV2VHb1lBZ01ZSXd1Zm1V?=
 =?utf-8?B?UDhBalBvcldsV3owMWJTZjN0N3BGVkhNMENPNGJ2ZWpITCtFUEpvK0I1dXBw?=
 =?utf-8?Q?p/TihfDNNZIM+1Lx30CZQlpVh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da53710-e202-49bb-5d7d-08dbc11ba60b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:41:09.8351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKWKMtl2saNvjpTGkUfVxrEbGGwgK5AeFJVTlyeoS+PRmTpx9gOcCCetDWOCX2XZwupu4JmiuOGgM1mg1gkE6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
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


On 2023-09-29 14:25, Chen, Xiaogang wrote:
>
> On 9/28/2023 4:26 PM, Felix Kuehling wrote:
>> On 2023-09-20 13:32, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> This patch implements partial migration in gpu page fault according 
>>> to migration
>>> granularity(default 2MB) and not split svm range in cpu page fault 
>>> handling.
>>> A svm range may include pages from both system ram and vram of one 
>>> gpu now.
>>> These chagnes are expected to improve migration performance and 
>>> reduce mmu
>>> callback and TLB flush workloads.
>>>
>>> Signed-off-by: xiaogang chen<xiaogang.chen@amd.com>
>>
>> Some more nit-picks inline.
[snip]
>> @@ -202,12 +200,24 @@ svm_range_dma_map_dev(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>   static int
>>   svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>>             unsigned long offset, unsigned long npages,
>> -          unsigned long *hmm_pfns)
>> +          unsigned long *hmm_pfns, uint64_t *vram_pages)
>>   {
>>       struct kfd_process *p;
>>       uint32_t gpuidx;
>> +    struct page **page;
>>       int r;
>>   +    page = kvcalloc(npages, sizeof(*page), GFP_KERNEL);
>>
>> Is there a reason this needs to be 0-initialized? The loop below 
>> initializes all elements.
> Will use kvmalloc_array instead. This array is not needed to init 
> during alloc as it will  be set afterword.
>>
>> I'm also not happy about having to allocate this page array here. It 
>> may be justified if the repeated calls to hmm_pfn_to_page were 
>> expensive compared to the memory allocation and initialization. I'm 
>> not convinced that's the case, though. With CONFIG_SPARSEMEM_VMEMMAP, 
>> hmm_pfn_to_page basically boils down to __pfn_to_page, which is a 
>> macro that does just this:
>>
>> #define __pfn_to_page(pfn)    (vmemmap + (pfn))
>>
>> See 
>> https://elixir.bootlin.com/linux/v6.5.5/source/include/asm-generic/memory_model.h#L37.
>>
> We get page* array here, then we do not need get page at 
> svm_range_dma_map_dev for each device since pages are same for all gpu 
> devices. So we save calling hmm_pfn_to_page though calling 
> hmm_pfn_to_page cost is low. Here we also want get vram page number 
> during svm_range_dma_map.
>
> I think you do not want alloc a page array each time we do 
> svm_range_dma_map? then can we put this struct page **page at 
> svm_range, and alloc it each time create new prange(and clone/split 
> prange)?

Allocating and freeing memory in every dmamap call adds a point of 
failure and non-deterministic overhead for the memory allocation. It's 
non-deterministic because it depends on current memory pressure 
situation and if the array is large, it also needs to update the kernel 
page table and potentially flush CPU TLBs.

Allocating the page pointer array permanently in the prange structure 
would be even worse, because that increases our system memory overhead. 
For each GB of virtual address space we manage, we waste 2MB of system 
memory for the page arrays. To make matters worse, those page arrays are 
allocated in kernel mode where they are not swappable. It's like taking 
physical DIMM sticks out of your system. We worked hard to eliminate 
redundant address and page array allocations from the driver a few years 
ago.

I'd prefer a small amount of redundant address calculations over the 
memory or non-deterministic allocation overhead.

Regards,
   Felix


>
>>
>>> +    if (!page)
>>> +        return -ENOMEM;
>>> +
>>> +    *vram_pages = 0;
>>> +    for (int i = 0; i < npages; i++) {
>>> +        page[i] = hmm_pfn_to_page(hmm_pfns[i]);
>>> +        if (is_zone_device_page(page[i]))
>>> +            (*vram_pages)++;
>>> +    }
>>> +
>>>       p = container_of(prange->svms, struct kfd_process, svms);
>>>         for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
>>> @@ -221,11 +231,12 @@ svm_range_dma_map(struct svm_range *prange, 
>>> unsigned long *bitmap,
>>>           }
>>>             r = svm_range_dma_map_dev(pdd->dev->adev, prange, 
>>> offset, npages,
>>> -                      hmm_pfns, gpuidx);
>>> +                      hmm_pfns, gpuidx, page);
>>>           if (r)
>>>               break;
>>>       }
>>>   +    kvfree(page);
>>>       return r;
>>>   }
>>>   @@ -347,6 +358,7 @@ svm_range *svm_range_new(struct svm_range_list 
>>> *svms, uint64_t start,
>>>       INIT_LIST_HEAD(&prange->child_list);
>>>       atomic_set(&prange->invalid, 0);
>>>       prange->validate_timestamp = 0;
>>> +    prange->vram_pages = 0;
>>>       mutex_init(&prange->migrate_mutex);
>>>       mutex_init(&prange->lock);
>>>   @@ -393,6 +405,8 @@ static void svm_range_bo_release(struct kref 
>>> *kref)
>>>                prange->start, prange->last);
>>>           mutex_lock(&prange->lock);
>>>           prange->svm_bo = NULL;
>>> +        /* prange does not hold vram page now */
>>> +        prange->actual_loc = 0;
>>
>> If you need this here, something probably went wrong elsewhere. 
>> Before we release the BO, we should have migrated everything to 
>> system memory, and actual_loc should already be 0. If anything, I'd 
>> add a WARN_ON(prange->actual_loc) here.
>>
> Will replace by WARN_ON as mentioned before.
>>
>>> mutex_unlock(&prange->lock);
>>>             spin_lock(&svm_bo->list_lock);
>>> @@ -966,6 +980,11 @@ svm_range_split_nodes(struct svm_range *new, 
>>> struct svm_range *old,
>>>       new->svm_bo = svm_range_bo_ref(old->svm_bo);
>>>       new->ttm_res = old->ttm_res;
>>>   +    /* set new's vram_pages as old range's now, the acurate 
>>> vram_pages
>>> +     * will be updated during mapping
>>> +     */
>>> +    new->vram_pages = min(old->vram_pages, new->npages);
>>> +
>>>       spin_lock(&new->svm_bo->list_lock);
>>>       list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>>>       spin_unlock(&new->svm_bo->list_lock);
>>> @@ -1610,6 +1629,7 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>       struct svm_validate_context *ctx;
>>>       unsigned long start, end, addr;
>>>       struct kfd_process *p;
>>> +    uint64_t vram_pages;
>>>       void *owner;
>>>       int32_t idx;
>>>       int r = 0;
>>> @@ -1678,11 +1698,13 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>           }
>>>       }
>>>   +    vram_pages = 0;
>>>       start = prange->start << PAGE_SHIFT;
>>>       end = (prange->last + 1) << PAGE_SHIFT;
>>>       for (addr = start; addr < end && !r; ) {
>>>           struct hmm_range *hmm_range;
>>>           struct vm_area_struct *vma;
>>> +        uint64_t vram_pages_vma;
>>>           unsigned long next;
>>>           unsigned long offset;
>>>           unsigned long npages;
>>> @@ -1711,12 +1733,14 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>             offset = (addr - start) >> PAGE_SHIFT;
>>>           r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>>> -                      hmm_range->hmm_pfns);
>>> +                      hmm_range->hmm_pfns, &vram_pages_vma);
>>>           if (r) {
>>>               pr_debug("failed %d to dma map range\n", r);
>>>               goto unreserve_out;
>>>           }
>>>   +        vram_pages += vram_pages_vma;
>>> +
>>>           svm_range_lock(prange);
>>>           if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
>>>               pr_debug("hmm update the range, need validate again\n");
>>> @@ -1738,8 +1762,20 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>           addr = next;
>>>       }
>>>   -    if (addr == end)
>>> +    if (addr == end) {
>>>           prange->mapped_to_gpu = true;
>>> +        prange->vram_pages = vram_pages;
>>> +
>>> +        /* if pragne does not include any vram page and it
>>
>> Typo: prange
>>
> ok.
>>
>>> +         * has not released svm_bo drop its svm_bo reference
>>> +         */
>>> +        if (!vram_pages && prange->ttm_res) {
>>> +            svm_range_vram_node_free(prange);
>>> +            mutex_lock(&prange->lock);
>>
>> Is this lock really needed.
>>
> same as before, will remove mutex_lock/unlock(&prange->lock) as it 
> seems overprotected.
>>
>>> +            prange->actual_loc = 0;
>>> +            mutex_unlock(&prange->lock);
>>> +        }
>>> +    }
>>>     unreserve_out:
>>>       svm_range_unreserve_bos(ctx);
>>> @@ -1996,6 +2032,7 @@ static struct svm_range 
>>> *svm_range_clone(struct svm_range *old)
>>>       new->actual_loc = old->actual_loc;
>>>       new->granularity = old->granularity;
>>>       new->mapped_to_gpu = old->mapped_to_gpu;
>>> +    new->vram_pages = old->vram_pages;
>>>       bitmap_copy(new->bitmap_access, old->bitmap_access, 
>>> MAX_GPU_INSTANCE);
>>>       bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>>>   @@ -2903,6 +2940,7 @@ svm_range_restore_pages(struct amdgpu_device 
>>> *adev, unsigned int pasid,
>>>               uint32_t vmid, uint32_t node_id,
>>>               uint64_t addr, bool write_fault)
>>>   {
>>> +    unsigned long start, last, size;
>>>       struct mm_struct *mm = NULL;
>>>       struct svm_range_list *svms;
>>>       struct svm_range *prange;
>>> @@ -3038,32 +3076,38 @@ svm_range_restore_pages(struct amdgpu_device 
>>> *adev, unsigned int pasid,
>>>       kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>>>                          write_fault, timestamp);
>>>   -    if (prange->actual_loc != best_loc) {
>>> +    if (prange->actual_loc != 0 || best_loc != 0) {
>>>           migration = true;
>>> +        /* Align migration range start and size to granularity size */
>>> +        size = 1UL << prange->granularity;
>>> +        start = ALIGN_DOWN(addr, size);
>>> +        last = ALIGN(addr + 1, size) - 1;
>>> +
>>> +        start = (start >= prange->start) ? start : prange->start;
>>> +        last = (last <= prange->last) ? last : prange->last;
>>
>> Similar to the simplification I recommended in svm_migrate_to_ram, 
>> this could be:
>>
>>     start = max(ALIGN_DOWN(addr, size), prange->start);
>>     last = min(ALIGN(addr + 1, size) - 1, prange->last);
>>
> ok, overlooked last time.
>
> Regards
>
> Xiaogang
>
>> Regards,
>>   Felix
>>
>>
>>> +
>>>           if (best_loc) {
>>> -            r = svm_migrate_to_vram(prange, best_loc, mm,
>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>> +            r = svm_migrate_to_vram(prange, best_loc, start, last,
>>> +                    mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>>               if (r) {
>>>                   pr_debug("svm_migrate_to_vram failed (%d) at %llx, 
>>> falling back to system memory\n",
>>>                        r, addr);
>>>                   /* Fallback to system memory if migration to
>>>                    * VRAM failed
>>>                    */
>>> -                if (prange->actual_loc)
>>> -                    r = svm_migrate_vram_to_ram(prange, mm,
>>> -                       KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>> -                       NULL);
>>> +                if (prange->actual_loc && prange->actual_loc != 
>>> best_loc)
>>> +                    r = svm_migrate_vram_to_ram(prange, mm, start, 
>>> last,
>>> +                        KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>                   else
>>>                       r = 0;
>>>               }
>>>           } else {
>>> -            r = svm_migrate_vram_to_ram(prange, mm,
>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>> -                    NULL);
>>> +            r = svm_migrate_vram_to_ram(prange, mm, start, last,
>>> +                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>           }
>>>           if (r) {
>>>               pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
>>> -                 r, svms, prange->start, prange->last);
>>> +                r, svms, start, last);
>>>               goto out_unlock_range;
>>>           }
>>>       }
>>> @@ -3417,18 +3461,24 @@ svm_range_trigger_migration(struct mm_struct 
>>> *mm, struct svm_range *prange,
>>>       *migrated = false;
>>>       best_loc = svm_range_best_prefetch_location(prange);
>>>   -    if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
>>> -        best_loc == prange->actual_loc)
>>> +    /* when best_loc is a gpu node and same as prange->actual_loc
>>> +     * we still need do migration as prange->actual_loc !=0 does
>>> +     * not mean all pages in prange are vram. hmm migrate will pick
>>> +     * up right pages during migration.
>>> +     */
>>> +    if ((best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED) ||
>>> +        (best_loc == 0 && prange->actual_loc == 0))
>>>           return 0;
>>>         if (!best_loc) {
>>> -        r = svm_migrate_vram_to_ram(prange, mm,
>>> +        r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>>> prange->last,
>>>                       KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>>>           *migrated = !r;
>>>           return r;
>>>       }
>>>   -    r = svm_migrate_to_vram(prange, best_loc, mm, 
>>> KFD_MIGRATE_TRIGGER_PREFETCH);
>>> +    r = svm_migrate_to_vram(prange, best_loc, prange->start, 
>>> prange->last,
>>> +                    mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>>>       *migrated = !r;
>>>         return r;
>>> @@ -3483,7 +3533,11 @@ static void 
>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>             mutex_lock(&prange->migrate_mutex);
>>>           do {
>>> +            /* migrate all vram pages in this prange to sys ram
>>> +             * after that prange->actual_loc should be zero
>>> +             */
>>>               r = svm_migrate_vram_to_ram(prange, mm,
>>> +                    prange->start, prange->last,
>>>                       KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>>>           } while (!r && prange->actual_loc && --retries);
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> index 5fd958a97a28..8574cc5eeabd 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> @@ -78,6 +78,7 @@ struct svm_work_list_item {
>>>    * @update_list:link list node used to add to update_list
>>>    * @mapping:    bo_va mapping structure to create and update GPU 
>>> page table
>>>    * @npages:     number of pages
>>> + * @vram_pages: vram pages number in this svm_range
>>>    * @dma_addr:   dma mapping address on each GPU for system memory 
>>> physical page
>>>    * @ttm_res:    vram ttm resource map
>>>    * @offset:     range start offset within mm_nodes
>>> @@ -88,7 +89,9 @@ struct svm_work_list_item {
>>>    * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
>>>    * @perferred_loc: perferred location, 0 for CPU, or GPU id
>>>    * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
>>> - * @actual_loc: the actual location, 0 for CPU, or GPU id
>>> + * @actual_loc: this svm_range location. 0: all pages are from sys 
>>> ram;
>>> + *              GPU id: this svm_range may include vram pages from 
>>> GPU with
>>> + *              id actual_loc.
>>>    * @granularity:migration granularity, log2 num pages
>>>    * @invalid:    not 0 means cpu page table is invalidated
>>>    * @validate_timestamp: system timestamp when range is validated
>>> @@ -112,6 +115,7 @@ struct svm_range {
>>>       struct list_head        list;
>>>       struct list_head        update_list;
>>>       uint64_t            npages;
>>> +    uint64_t            vram_pages;
>>>       dma_addr_t            *dma_addr[MAX_GPU_INSTANCE];
>>>       struct ttm_resource        *ttm_res;
>>>       uint64_t            offset;
