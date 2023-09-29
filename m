Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5ADE728DE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 19:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2472B10E1AE;
	Fri, 29 Sep 2023 19:44:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C3F10E1AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 19:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijfBdim41Rr9UHZfvozryXTB1/euvaxKVSd8cteAzpqkj1vaPVcnkgzaWprFwhJ++6Nov/3PByRng4EaSyHQUWZnOqI2MZ5xeZoxRldNWm+10aDN58aZC+J6kDFRrDe9JUQec/C4VR2+Wy8b0tyHYqmdTXLcY5FSRVlUOoU9c0GAZzsRvg6wRrfQV9HjPvxLVogAMX/z4Owkv4lPhQ+S8iCKjcV/ZC4u2EHz6LPjc9QW8pCew/001jaB+mYbThi9ZO+uzGWjmbJ3XsKCD2JQWtSfL1QETKLdWpULOnk4CrZFOdv8xrOAh6Huqm7PgJc9hvASzcKXhm3hugWE3UDZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaQC3q2AxmR929lrO2td8d0kpTT1QVnDp80Su4GG+uI=;
 b=OFq/LVzL6a1dMGUW4NA07kyzy79A702EzHqSbbIz4qVbMl4/Cucc1gqbOsbge75VBxYF0rlQ5MIKG0w3bed3HlKmMm/YcTY9osOMQZ52dq3HAKbfL+QkDUpyvplvFPFZExNsK0SJr67lyJXRjblN4B/vfJb399o1SmIyPz0W/x19OHUo4SJFhfDY1wmVblwF57nbsX6WQMUtSo1Ho82P6TpWazxutMaTq43J8BHtpQ5JFIUgIaMVs9gquJal813kRnZ9FDncP1GdFLQH065JHYrPYxFb17NEgPCpqxwoxfJK0kqHGyO/sMHu53+fHp58M3oreT485C2uXdFqZH7CsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaQC3q2AxmR929lrO2td8d0kpTT1QVnDp80Su4GG+uI=;
 b=KVa76egeDZ3ZYCI5SAD/Rc2FnLVmJ58iO9sYVj83yjw29ZjYyUtO2+wiu6we5Tl0wAAE8NCLvdMy7lpUqxZZDoNgKlb9vsklukp3ivG3Tb2ijZIf35l85Io8tifteioXmY4u6+yMEL1nqEgi81i0HiDBZZfhMLmmovIHR1Fgzkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.26; Fri, 29 Sep 2023 19:44:16 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f%7]) with mapi id 15.20.6838.016; Fri, 29 Sep 2023
 19:44:16 +0000
Message-ID: <f999a611-a400-d55f-0c3e-45b5109cd616@amd.com>
Date: Fri, 29 Sep 2023 14:44:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230920173203.12760-1-xiaogang.chen@amd.com>
 <cdbc2263-d6c7-ab0a-0bf2-3361dd34a358@amd.com>
 <7ab40093-5e86-796d-eee8-c6172b41ef47@amd.com>
 <44d8ab8f-6ab3-54b3-d600-8cc6943b2ca3@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <44d8ab8f-6ab3-54b3-d600-8cc6943b2ca3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:805:de::20) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 9291e01f-7f7e-4400-ca24-08dbc12476ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxEbspvHXUCwDATyyefhHKEJ0L8IH6KmFVAUs4m3VkK2QatnmsoDMbxNXi9rRVASmq1/csKx36NAxn43R3X0Au4oM4RKAJt6GQlCaOYZdKIaE6G0q7ksReMZcfH23wWYOsjZIhwupUKErcK8b/LxBTcxixmXJWvC1dOjgdDEeQc31j2K4+hhdUnWTmYvCb26qX+uqqvkJgNyBz98MTurCQANkH8pS6cKY/Q0tCA7DegW3BXO5uvRBKUMy7Y3280kBcnfHOdldjFdZRWb1IB3nhkudooW+NPJAKeKw/nP8AFgH217ZCWoZYALhIJY5O8fYQ24ymwocMqR4a5p6fBUEhwvarkzl1fXe6uUKSVJ0xx1PZGMIEiHg+PrDq+Wd8lCRJ8cBIiqfstCyi9PLM0YMvkFmFH54zucsmle01froCTXqChbMjUL4i1FLSVVAdONqsGe88fBM/NJARzTUUmkjYcfU3yFr3VeDsUO0txIBAKCGDKGEArPW8KMQEf8Ih38N7cSR9i/HMwSM9dT4+hqukfjfnARlZ4JLrphl6f/I6ldaXXZwjRvZ/pu3uNmlep4lsQ9TJX7cs0jY5DoiBsJEptIAXxdchDFh/412K1S1B6jpbrL/tTpFD9V8UPDOL4trJLmK9hQCH+sqW0I4sylag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(8936002)(31686004)(8676002)(4326008)(26005)(30864003)(2906002)(478600001)(316002)(41300700001)(66556008)(66946007)(6486002)(966005)(66476007)(6666004)(6506007)(53546011)(6512007)(36756003)(2616005)(83380400001)(86362001)(31696002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnhhNGlWa2I0VzN4Z01sbFJ1eHlYK3pUL1NzREJ4ZWsvQXF6TEN4VldqYzRr?=
 =?utf-8?B?STZYYUszaVRaQ00ydzZ1ZWpNSjZwSkpsZXZqRjVETi9LSStrNzJ6c29HVEla?=
 =?utf-8?B?R2luOEp1eDN6ZUtLRkowcEhVZXFISTN2c1g2Qlp6N1lWV2dnUlNYTUNLRmdY?=
 =?utf-8?B?Wk9XY2VHMEtBeFRRVHFldXJ4RVF4ejlMbC9WamwxY2lOTUNUMkVoOU95OWdH?=
 =?utf-8?B?VWJ0ZGtGellrblZnc0U1TjhmMCtlNFgxb3UwaUxxV3NZUDZmSXNnTEt4VGFZ?=
 =?utf-8?B?TGxIbDc4OFpuejRpbTRMbW5RTWtWdmVxWTM5bXZ4WGxVVE44ZSs0ak9HWFhX?=
 =?utf-8?B?SDRVSUcwR0ZmbXhwSGxsL1ZybE8xbXZGQkgvV0ROTG9kRmg2VzVEQTBCYS8y?=
 =?utf-8?B?eWtvZWo1dXZBOVdFTXdGYWdlQlNTYXFlUGZBdWlGU0M5Z3RvbkJQK041d2Z4?=
 =?utf-8?B?YTM5aXJHSWdqTWxTRk10V2IrMjRxc0J5ZktQZUN0WDFVN1pKcWdKdGZmN2hh?=
 =?utf-8?B?UjNoWDdVVWdBbzN5VDV0RGJxVStUZCtJTFE2dDh1Rk55c1cxYzdxSHRNTmJ6?=
 =?utf-8?B?a1drbEZTTzdiYitjVGttK0FPZHQ1dXN5c0hHTGdsL2VwYTZXMmRFdUo2MW1k?=
 =?utf-8?B?bVlxL21wcit0M21QT1hEVTFBc3dSeVR6dkxKZHpNL2RId1g5bFVHQmEwTGV6?=
 =?utf-8?B?cnQxL25KMVRKZW80V3ZTZFB6NGpMV003OGJyWU16b00va2pOYXR1b082d3Zo?=
 =?utf-8?B?bXB6WG5rSUNsdm5hR3NhWUJROXcwcEZsemoya1c5R1BwZ1FDQnNsOU1OU2JM?=
 =?utf-8?B?VUlKTkRBWUl3dlBGWFZOVi96bEFNdUx0dHQyZ0VEeTB6eUJOdnpsN0dydWN1?=
 =?utf-8?B?elorMUNab3UrUEwyZnhOL0hyeWVUZ2d0bG05NDd4bGZGL0N6VVc2VWcwQUM0?=
 =?utf-8?B?VnJmWG5KblY4VVJPTE54bzkxamVZcHd4Vk1maTA5WEdLZFF1aS94QkZMYlNS?=
 =?utf-8?B?bE5tUnV6d2ZCSjhjQWJ5bitPK25jSVFkalFBMEhkUUM5MUZDL2NWQXZzbkZp?=
 =?utf-8?B?cmJOcGxMSGU1ekc4d1R3enJ2NGcyeG1ha3RPMFc3SCswQnhsOFpzS3NiOThr?=
 =?utf-8?B?TVBWTUxJa2dhc2RBYi81T2hETEY2MkpNc2VZMHA2dmtXbW82UW92NGRpc3d5?=
 =?utf-8?B?Yk5wMnJXMkV3LzRrUy9GdGV1enlmaWM1Ry9sUXRVQmVOdUh2SWxmUm1zL29k?=
 =?utf-8?B?cVN4cTY5Z0M4TFREenB0WDRKS1Q2Snh2L0p3czZPOFZzQWFJUWtKcVkvaU9U?=
 =?utf-8?B?ci9hRHEwd1dFaTUxV0hVTEtIWkxUdWlYRko1eXViUy9KTDlSWkF6T0Y2UlV0?=
 =?utf-8?B?bFVISFB5czJlZmNIUUdkaFNIWHlqQTFzdXJ5eEUxc2sybHVNZGx0SG93UlVo?=
 =?utf-8?B?bFo2bWkxTUxyRDVZTmxNVVNTZGl6S2xXazN3TzF4YW92UEd0RmU4NWFZN2hl?=
 =?utf-8?B?T3BWLzErVHJ2ZWpMalUrVVZkN0l4WnpPbU9SWGZKcEorSE8wbFphRzZWdEEy?=
 =?utf-8?B?RG41azdzSlVOaEtRTmNvNHNyZ3ZVMHd3M3JzdFMxVzVXOGljeGFlWko2ZXdF?=
 =?utf-8?B?Vk5FR3dWMGRIeTNxYnVKVHhsRVpDVXRDSXBkcjFUUlJXZTVOM2ZmZm5KTmc4?=
 =?utf-8?B?OTY5ZXNNZE1kYjcxVTRRb2hNL1Y5VTlpdHl0NkJtRW56R0hJTlgwVng2dU1O?=
 =?utf-8?B?dlMwNDVHOFpob0NNYzRTTmlpUlN0eDQvNmZhaHYzR09kNjJTcy82aWlodEtK?=
 =?utf-8?B?MldEaVp3TWo2UnZFMm1ac2M4RXc4ek0rbGxUYkxMQjJub2d5U3g0QzBxZlYw?=
 =?utf-8?B?bE1VMW9HVUJvK3kycE5oK2xkZmF0algwN2JNbzFJLzdmMmswZHk5Z2hVNU1T?=
 =?utf-8?B?TXhJbjVVbWJhTURGZ3lQRmNqKzdyd2JRQmFGUWpsVThIMkd4UjA3U0tvN0Nw?=
 =?utf-8?B?dm1RRXcxem4wNHk3WFJrbmVRVTdIMzVKbzl4WncvUW56cWpZSVRqTXNPbElF?=
 =?utf-8?B?WWlUczIrS3pPQWZmUnpQb1dEcVpyRUw4TnV0bWNuSlVpak9JclZWR0FIZUpI?=
 =?utf-8?Q?JVaU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9291e01f-7f7e-4400-ca24-08dbc12476ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 19:44:16.4813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WRU0yEu5J1mRjUt2RJT2KO82DlUe3GE5TAmrQFekJcycEfM2/UQDK4VXRp/so+P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437
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


On 9/29/2023 1:41 PM, Felix Kuehling wrote:
>
> On 2023-09-29 14:25, Chen, Xiaogang wrote:
>>
>> On 9/28/2023 4:26 PM, Felix Kuehling wrote:
>>> On 2023-09-20 13:32, Xiaogang.Chen wrote:
>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>
>>>> This patch implements partial migration in gpu page fault according 
>>>> to migration
>>>> granularity(default 2MB) and not split svm range in cpu page fault 
>>>> handling.
>>>> A svm range may include pages from both system ram and vram of one 
>>>> gpu now.
>>>> These chagnes are expected to improve migration performance and 
>>>> reduce mmu
>>>> callback and TLB flush workloads.
>>>>
>>>> Signed-off-by: xiaogang chen<xiaogang.chen@amd.com>
>>>
>>> Some more nit-picks inline.
> [snip]
>>> @@ -202,12 +200,24 @@ svm_range_dma_map_dev(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>   static int
>>>   svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>>>             unsigned long offset, unsigned long npages,
>>> -          unsigned long *hmm_pfns)
>>> +          unsigned long *hmm_pfns, uint64_t *vram_pages)
>>>   {
>>>       struct kfd_process *p;
>>>       uint32_t gpuidx;
>>> +    struct page **page;
>>>       int r;
>>>   +    page = kvcalloc(npages, sizeof(*page), GFP_KERNEL);
>>>
>>> Is there a reason this needs to be 0-initialized? The loop below 
>>> initializes all elements.
>> Will use kvmalloc_array instead. This array is not needed to init 
>> during alloc as it will  be set afterword.
>>>
>>> I'm also not happy about having to allocate this page array here. It 
>>> may be justified if the repeated calls to hmm_pfn_to_page were 
>>> expensive compared to the memory allocation and initialization. I'm 
>>> not convinced that's the case, though. With 
>>> CONFIG_SPARSEMEM_VMEMMAP, hmm_pfn_to_page basically boils down to 
>>> __pfn_to_page, which is a macro that does just this:
>>>
>>> #define __pfn_to_page(pfn)    (vmemmap + (pfn))
>>>
>>> See 
>>> https://elixir.bootlin.com/linux/v6.5.5/source/include/asm-generic/memory_model.h#L37.
>>>
>> We get page* array here, then we do not need get page at 
>> svm_range_dma_map_dev for each device since pages are same for all 
>> gpu devices. So we save calling hmm_pfn_to_page though calling 
>> hmm_pfn_to_page cost is low. Here we also want get vram page number 
>> during svm_range_dma_map.
>>
>> I think you do not want alloc a page array each time we do 
>> svm_range_dma_map? then can we put this struct page **page at 
>> svm_range, and alloc it each time create new prange(and clone/split 
>> prange)?
>
> Allocating and freeing memory in every dmamap call adds a point of 
> failure and non-deterministic overhead for the memory allocation. It's 
> non-deterministic because it depends on current memory pressure 
> situation and if the array is large, it also needs to update the 
> kernel page table and potentially flush CPU TLBs.
>
> Allocating the page pointer array permanently in the prange structure 
> would be even worse, because that increases our system memory 
> overhead. For each GB of virtual address space we manage, we waste 2MB 
> of system memory for the page arrays. To make matters worse, those 
> page arrays are allocated in kernel mode where they are not swappable. 
> It's like taking physical DIMM sticks out of your system. We worked 
> hard to eliminate redundant address and page array allocations from 
> the driver a few years ago.
>
> I'd prefer a small amount of redundant address calculations over the 
> memory or non-deterministic allocation overhead.
>
Then I think we can cal vram_pages atsvm_range_validate_and_map as the 
last version:

+for (int i = 0; i < npages; i++) {

  +if (is_zone_device_page(hmm_pfn_to_page(hmm_range->hmm_pfns[i])))

vram_pages++;

  +}

That will not alloc page* array, but have additional calling 
hmm_pfn_to_page.

Or add a parameter at svm_range_dma_map_dev to indicate whether cal 
vram_pages, and only one svm_range_dma_map_dev call will cal vram_pages.

Regards

Xiaogang

> Regards,
>   Felix
>
>
>>
>>>
>>>> +    if (!page)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    *vram_pages = 0;
>>>> +    for (int i = 0; i < npages; i++) {
>>>> +        page[i] = hmm_pfn_to_page(hmm_pfns[i]);
>>>> +        if (is_zone_device_page(page[i]))
>>>> +            (*vram_pages)++;
>>>> +    }
>>>> +
>>>>       p = container_of(prange->svms, struct kfd_process, svms);
>>>>         for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
>>>> @@ -221,11 +231,12 @@ svm_range_dma_map(struct svm_range *prange, 
>>>> unsigned long *bitmap,
>>>>           }
>>>>             r = svm_range_dma_map_dev(pdd->dev->adev, prange, 
>>>> offset, npages,
>>>> -                      hmm_pfns, gpuidx);
>>>> +                      hmm_pfns, gpuidx, page);
>>>>           if (r)
>>>>               break;
>>>>       }
>>>>   +    kvfree(page);
>>>>       return r;
>>>>   }
>>>>   @@ -347,6 +358,7 @@ svm_range *svm_range_new(struct 
>>>> svm_range_list *svms, uint64_t start,
>>>>       INIT_LIST_HEAD(&prange->child_list);
>>>>       atomic_set(&prange->invalid, 0);
>>>>       prange->validate_timestamp = 0;
>>>> +    prange->vram_pages = 0;
>>>>       mutex_init(&prange->migrate_mutex);
>>>>       mutex_init(&prange->lock);
>>>>   @@ -393,6 +405,8 @@ static void svm_range_bo_release(struct kref 
>>>> *kref)
>>>>                prange->start, prange->last);
>>>>           mutex_lock(&prange->lock);
>>>>           prange->svm_bo = NULL;
>>>> +        /* prange does not hold vram page now */
>>>> +        prange->actual_loc = 0;
>>>
>>> If you need this here, something probably went wrong elsewhere. 
>>> Before we release the BO, we should have migrated everything to 
>>> system memory, and actual_loc should already be 0. If anything, I'd 
>>> add a WARN_ON(prange->actual_loc) here.
>>>
>> Will replace by WARN_ON as mentioned before.
>>>
>>>> mutex_unlock(&prange->lock);
>>>>             spin_lock(&svm_bo->list_lock);
>>>> @@ -966,6 +980,11 @@ svm_range_split_nodes(struct svm_range *new, 
>>>> struct svm_range *old,
>>>>       new->svm_bo = svm_range_bo_ref(old->svm_bo);
>>>>       new->ttm_res = old->ttm_res;
>>>>   +    /* set new's vram_pages as old range's now, the acurate 
>>>> vram_pages
>>>> +     * will be updated during mapping
>>>> +     */
>>>> +    new->vram_pages = min(old->vram_pages, new->npages);
>>>> +
>>>>       spin_lock(&new->svm_bo->list_lock);
>>>>       list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>>>>       spin_unlock(&new->svm_bo->list_lock);
>>>> @@ -1610,6 +1629,7 @@ static int svm_range_validate_and_map(struct 
>>>> mm_struct *mm,
>>>>       struct svm_validate_context *ctx;
>>>>       unsigned long start, end, addr;
>>>>       struct kfd_process *p;
>>>> +    uint64_t vram_pages;
>>>>       void *owner;
>>>>       int32_t idx;
>>>>       int r = 0;
>>>> @@ -1678,11 +1698,13 @@ static int 
>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>           }
>>>>       }
>>>>   +    vram_pages = 0;
>>>>       start = prange->start << PAGE_SHIFT;
>>>>       end = (prange->last + 1) << PAGE_SHIFT;
>>>>       for (addr = start; addr < end && !r; ) {
>>>>           struct hmm_range *hmm_range;
>>>>           struct vm_area_struct *vma;
>>>> +        uint64_t vram_pages_vma;
>>>>           unsigned long next;
>>>>           unsigned long offset;
>>>>           unsigned long npages;
>>>> @@ -1711,12 +1733,14 @@ static int 
>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>             offset = (addr - start) >> PAGE_SHIFT;
>>>>           r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>>>> -                      hmm_range->hmm_pfns);
>>>> +                      hmm_range->hmm_pfns, &vram_pages_vma);
>>>>           if (r) {
>>>>               pr_debug("failed %d to dma map range\n", r);
>>>>               goto unreserve_out;
>>>>           }
>>>>   +        vram_pages += vram_pages_vma;
>>>> +
>>>>           svm_range_lock(prange);
>>>>           if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
>>>>               pr_debug("hmm update the range, need validate again\n");
>>>> @@ -1738,8 +1762,20 @@ static int svm_range_validate_and_map(struct 
>>>> mm_struct *mm,
>>>>           addr = next;
>>>>       }
>>>>   -    if (addr == end)
>>>> +    if (addr == end) {
>>>>           prange->mapped_to_gpu = true;
>>>> +        prange->vram_pages = vram_pages;
>>>> +
>>>> +        /* if pragne does not include any vram page and it
>>>
>>> Typo: prange
>>>
>> ok.
>>>
>>>> +         * has not released svm_bo drop its svm_bo reference
>>>> +         */
>>>> +        if (!vram_pages && prange->ttm_res) {
>>>> +            svm_range_vram_node_free(prange);
>>>> +            mutex_lock(&prange->lock);
>>>
>>> Is this lock really needed.
>>>
>> same as before, will remove mutex_lock/unlock(&prange->lock) as it 
>> seems overprotected.
>>>
>>>> +            prange->actual_loc = 0;
>>>> +            mutex_unlock(&prange->lock);
>>>> +        }
>>>> +    }
>>>>     unreserve_out:
>>>>       svm_range_unreserve_bos(ctx);
>>>> @@ -1996,6 +2032,7 @@ static struct svm_range 
>>>> *svm_range_clone(struct svm_range *old)
>>>>       new->actual_loc = old->actual_loc;
>>>>       new->granularity = old->granularity;
>>>>       new->mapped_to_gpu = old->mapped_to_gpu;
>>>> +    new->vram_pages = old->vram_pages;
>>>>       bitmap_copy(new->bitmap_access, old->bitmap_access, 
>>>> MAX_GPU_INSTANCE);
>>>>       bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>>>>   @@ -2903,6 +2940,7 @@ svm_range_restore_pages(struct 
>>>> amdgpu_device *adev, unsigned int pasid,
>>>>               uint32_t vmid, uint32_t node_id,
>>>>               uint64_t addr, bool write_fault)
>>>>   {
>>>> +    unsigned long start, last, size;
>>>>       struct mm_struct *mm = NULL;
>>>>       struct svm_range_list *svms;
>>>>       struct svm_range *prange;
>>>> @@ -3038,32 +3076,38 @@ svm_range_restore_pages(struct 
>>>> amdgpu_device *adev, unsigned int pasid,
>>>>       kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>>>>                          write_fault, timestamp);
>>>>   -    if (prange->actual_loc != best_loc) {
>>>> +    if (prange->actual_loc != 0 || best_loc != 0) {
>>>>           migration = true;
>>>> +        /* Align migration range start and size to granularity 
>>>> size */
>>>> +        size = 1UL << prange->granularity;
>>>> +        start = ALIGN_DOWN(addr, size);
>>>> +        last = ALIGN(addr + 1, size) - 1;
>>>> +
>>>> +        start = (start >= prange->start) ? start : prange->start;
>>>> +        last = (last <= prange->last) ? last : prange->last;
>>>
>>> Similar to the simplification I recommended in svm_migrate_to_ram, 
>>> this could be:
>>>
>>>     start = max(ALIGN_DOWN(addr, size), prange->start);
>>>     last = min(ALIGN(addr + 1, size) - 1, prange->last);
>>>
>> ok, overlooked last time.
>>
>> Regards
>>
>> Xiaogang
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> +
>>>>           if (best_loc) {
>>>> -            r = svm_migrate_to_vram(prange, best_loc, mm,
>>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>>> +            r = svm_migrate_to_vram(prange, best_loc, start, last,
>>>> +                    mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>>>               if (r) {
>>>>                   pr_debug("svm_migrate_to_vram failed (%d) at 
>>>> %llx, falling back to system memory\n",
>>>>                        r, addr);
>>>>                   /* Fallback to system memory if migration to
>>>>                    * VRAM failed
>>>>                    */
>>>> -                if (prange->actual_loc)
>>>> -                    r = svm_migrate_vram_to_ram(prange, mm,
>>>> -                       KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>>> -                       NULL);
>>>> +                if (prange->actual_loc && prange->actual_loc != 
>>>> best_loc)
>>>> +                    r = svm_migrate_vram_to_ram(prange, mm, start, 
>>>> last,
>>>> +                        KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>>                   else
>>>>                       r = 0;
>>>>               }
>>>>           } else {
>>>> -            r = svm_migrate_vram_to_ram(prange, mm,
>>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>>> -                    NULL);
>>>> +            r = svm_migrate_vram_to_ram(prange, mm, start, last,
>>>> +                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>>           }
>>>>           if (r) {
>>>>               pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
>>>> -                 r, svms, prange->start, prange->last);
>>>> +                r, svms, start, last);
>>>>               goto out_unlock_range;
>>>>           }
>>>>       }
>>>> @@ -3417,18 +3461,24 @@ svm_range_trigger_migration(struct 
>>>> mm_struct *mm, struct svm_range *prange,
>>>>       *migrated = false;
>>>>       best_loc = svm_range_best_prefetch_location(prange);
>>>>   -    if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
>>>> -        best_loc == prange->actual_loc)
>>>> +    /* when best_loc is a gpu node and same as prange->actual_loc
>>>> +     * we still need do migration as prange->actual_loc !=0 does
>>>> +     * not mean all pages in prange are vram. hmm migrate will pick
>>>> +     * up right pages during migration.
>>>> +     */
>>>> +    if ((best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED) ||
>>>> +        (best_loc == 0 && prange->actual_loc == 0))
>>>>           return 0;
>>>>         if (!best_loc) {
>>>> -        r = svm_migrate_vram_to_ram(prange, mm,
>>>> +        r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>>>> prange->last,
>>>>                       KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>>>>           *migrated = !r;
>>>>           return r;
>>>>       }
>>>>   -    r = svm_migrate_to_vram(prange, best_loc, mm, 
>>>> KFD_MIGRATE_TRIGGER_PREFETCH);
>>>> +    r = svm_migrate_to_vram(prange, best_loc, prange->start, 
>>>> prange->last,
>>>> +                    mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>>>>       *migrated = !r;
>>>>         return r;
>>>> @@ -3483,7 +3533,11 @@ static void 
>>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>>             mutex_lock(&prange->migrate_mutex);
>>>>           do {
>>>> +            /* migrate all vram pages in this prange to sys ram
>>>> +             * after that prange->actual_loc should be zero
>>>> +             */
>>>>               r = svm_migrate_vram_to_ram(prange, mm,
>>>> +                    prange->start, prange->last,
>>>>                       KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>>>>           } while (!r && prange->actual_loc && --retries);
>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>> index 5fd958a97a28..8574cc5eeabd 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>> @@ -78,6 +78,7 @@ struct svm_work_list_item {
>>>>    * @update_list:link list node used to add to update_list
>>>>    * @mapping:    bo_va mapping structure to create and update GPU 
>>>> page table
>>>>    * @npages:     number of pages
>>>> + * @vram_pages: vram pages number in this svm_range
>>>>    * @dma_addr:   dma mapping address on each GPU for system memory 
>>>> physical page
>>>>    * @ttm_res:    vram ttm resource map
>>>>    * @offset:     range start offset within mm_nodes
>>>> @@ -88,7 +89,9 @@ struct svm_work_list_item {
>>>>    * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
>>>>    * @perferred_loc: perferred location, 0 for CPU, or GPU id
>>>>    * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
>>>> - * @actual_loc: the actual location, 0 for CPU, or GPU id
>>>> + * @actual_loc: this svm_range location. 0: all pages are from sys 
>>>> ram;
>>>> + *              GPU id: this svm_range may include vram pages from 
>>>> GPU with
>>>> + *              id actual_loc.
>>>>    * @granularity:migration granularity, log2 num pages
>>>>    * @invalid:    not 0 means cpu page table is invalidated
>>>>    * @validate_timestamp: system timestamp when range is validated
>>>> @@ -112,6 +115,7 @@ struct svm_range {
>>>>       struct list_head        list;
>>>>       struct list_head        update_list;
>>>>       uint64_t            npages;
>>>> +    uint64_t            vram_pages;
>>>>       dma_addr_t            *dma_addr[MAX_GPU_INSTANCE];
>>>>       struct ttm_resource        *ttm_res;
>>>>       uint64_t            offset;
