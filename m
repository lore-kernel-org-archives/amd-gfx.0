Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB46CE7AF3
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 20:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3FC210E13B;
	Fri, 29 Sep 2023 20:24:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B7D10E13B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 20:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+mrIaTKBMsNjmjSKRLnX3TnC6yhH1PFIc/ri6ri8PnpJhG7jNY1Y/vZj9iO3XOyNVGCBUPsI3g9UzbP+ioHcsDVKB4qT6+lks0jJ2sVYmMnuqkiDPpxDMdt4fLGgr6eRCrQBmc6O14FeH2KG1u/iK434su1JBbT+5YfNeVuAdSSdRmUQal3bZqP5obq0PTJcDRGdrywtgxOVoO1ApheMtySMg2xt0FHqRwdvrkz20XxUb7aB+qrayuNnwryq7cpjeT7sR0X69maR978UHoSWAC3hPVwrqzpd3vXKWVIWpXjsxy2WtICNIkcvMvjrjw7MxsDJa9P5/sHRJZ/2JXc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGjggTIry1pWbCY/IIqBz4Oz3IOaxyZM8bw55x8vlqg=;
 b=ZEl9F9+/j9VDcYxsh/fWnw3+dEWIZKRr7D/6XhUrLRlvYF3b0klVqmZ/EM2OPP1UCLKv/ddcBMgUrD+LgoHq0dpX3pdXiEplCe8IJKwJTzjhOvcU2lvQX3+Uikzh4RDI9SrVzKuKVPT8i9vE3Q/ITUcGf88KYoaU7BqCe4K4AWICX0vdEjKm8YnxM25l5IM17av2DxVsZkvsk2ZjS0q35Gr9y7ijj4QwJZ+e0/T2YAOsWoPQJli5zH7WcXvejB0OSdVEVp0t9BVgyyh0J6opex5hJz+1M+yNcfSAs0w6bTHGLz/GZFLCYJ9HiuNemKvWhE/flVN16EwNhr6LSka1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGjggTIry1pWbCY/IIqBz4Oz3IOaxyZM8bw55x8vlqg=;
 b=E8/9yiPd2MHVxCbVnONSXx4CHeAkQjh5eQyFlDvRrVPd3bqDn8+dTZd3Oe7FVPUDNEwnr6QHWm/EkcoVzGunJEpWDyjHvg2zXLiFmWeP2WkGrol2/InKJAeVkaAICYH259kI4aiLrNOdKKhDva9zPkScoeljRjCRdAAuzDVnJy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Fri, 29 Sep 2023 20:24:36 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f%7]) with mapi id 15.20.6838.016; Fri, 29 Sep 2023
 20:24:36 +0000
Message-ID: <f97d3750-cc39-4de2-7bfc-6c0b52bdc72a@amd.com>
Date: Fri, 29 Sep 2023 15:24:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230920173203.12760-1-xiaogang.chen@amd.com>
 <cdbc2263-d6c7-ab0a-0bf2-3361dd34a358@amd.com>
 <7ab40093-5e86-796d-eee8-c6172b41ef47@amd.com>
 <44d8ab8f-6ab3-54b3-d600-8cc6943b2ca3@amd.com>
 <f999a611-a400-d55f-0c3e-45b5109cd616@amd.com>
 <182de8b7-6d44-05df-bc69-9f3412301c71@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <182de8b7-6d44-05df-bc69-9f3412301c71@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::19) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 50744dca-662f-45b3-382a-08dbc12a191a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IvBURYQu8/j8X1c2QF2rHAiMfVUNUs30lQWfCUyR/hPGBAuub+YLTG1IJl1jF9uOg5NonsEXiOceMkMIxXYm77VmFzrbBkHf3C0k6izrMqoxRlqWyi5sbYnoqvZeRj+8TM18Dm4fsnwOURz2p7xpeE6HaDuqbm6W4SZGA6zNfUfhPL0hI0oGF5gxSi4OXdNeSleu6FAndbFVBKpocH7XR5FBWoB4zz8QvZti/4gRStmqfeLsmlRaTlIfd28/lKDox7sWA1yRFenZWvaQ+o0b69ql21yvGFF/LqeqqqAr0lmy+V4JV01164R3GycWJgDbwzJ+bjhFhWk97fsLDYZ51Qv7LjFSedFXGZnEFd76GiCBHX9U8YUyuEq0AwULX8k+UwXpiWRuda8P3xUHZxeM+5ny9s1srJqmYbqaUN2d50zApeE6pxMf0gaTDELaavVjnKdFFnW2GLT9/qfZkYBk3HGsMG2wMivn5pnRRUWXcxacVe1d0f8teuSGr3SUB4EkYRW0WpHbAariZxkoxTK+I/t80EYcq25w/eA0waowJG4BQBE4iA5xb12Mx/u/p0FqF3SDlz080JVn2d4TRGkKeCcfFNbY9CwTO0aqFspuHWr0jSuqCrtZ9naWfN34T3pjjjqSiG0b7O2deVXlmoEMvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(5660300002)(31696002)(8936002)(4326008)(86362001)(8676002)(2906002)(36756003)(2616005)(53546011)(6666004)(6512007)(83380400001)(26005)(478600001)(966005)(6486002)(38100700002)(6506007)(31686004)(30864003)(66946007)(316002)(66476007)(66556008)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEJDVlc0aEVIVjR2STJ6RjY4aHpxVk9zUllrMENlenZWcGtVaUZwS3Y4c1h0?=
 =?utf-8?B?MWJLMGV3V1E0ZDNybVZOZzhXNzdwSXp2QXg4ZTkxNS9HM2dBUzRvVCtaZDAz?=
 =?utf-8?B?cW4rbk10K3d4SCtJNS83TkRJRFNlckxBdTREOEdQc0pLRzJiaStGLzI1NE9x?=
 =?utf-8?B?QVllcWZHbG05SmJXdEwvVHFrVXpWV3dSMVBwYWN4MlQxMkx3bHdzMXk4cFBl?=
 =?utf-8?B?bnNaNE9wOEkwMkpzb25lT0wrLzN6TWF6VVBySU1QZTBad3ZWTTNaS3pCOVV6?=
 =?utf-8?B?Y3dUSWpUUGthK2VsVURJdG9zK2VKWFJtY2swY3JDV0RhRVhDdk0wbHBzc3ZF?=
 =?utf-8?B?VWxvTHlSaFRENHQrbktwT1gvdjAyWUk5UkY0eXZtUmNOVHlGK0lSdSt5WnlJ?=
 =?utf-8?B?Q2JyelpoTWQ0ZWNNZ2h1TEN4b3VNcEdROE10MmU3WVpVQWsycm5rOVd3S2Ny?=
 =?utf-8?B?ZitvWHBqdk1IOFJWQUJyRlJlQng4cFptODlmeFZSenNjZk5nMnRGSzlJWUNU?=
 =?utf-8?B?S3hPOTNWc2FCb2pFSkg2YVJCcDV1b3JpNm1IQVRBYUJqbEFYcmdJOWw2Nkwz?=
 =?utf-8?B?bzZvRmt1VjZ2bU1vODdUQ0hsU2gvMzFZV1NONVR2anVCR2ZCajlFZlBYNnRL?=
 =?utf-8?B?SUo2Z2hwQzBwbzF0dWhpMHFJblVUaTVXdUtCOG9nQW1ibEJVQjAvaDBscUdD?=
 =?utf-8?B?UmRQSFpiSXdObWkwcVJ5MGJFNzl1c0RGYTlScW15NUNQVS84Z2xQWTVLemNT?=
 =?utf-8?B?dTMrSlFxTlluZnN4RjF2ZGVCQVgyZnFOOHhMUzhSZ2c5aXdyaXRrQWRsZit1?=
 =?utf-8?B?TFJ6TlRCbjBpbXhMTDdvZEw0Z3kyVjNwV0gxSGtVS3ltMzUyZTQ2UU8wTENv?=
 =?utf-8?B?WXhabytSYU5LV1l0SnVyajdTcTRXbE4wcDRHVUlFU3Y1ZThTZ3FTNGFjU0dh?=
 =?utf-8?B?OUF2dUFkTy9SWE1pMzMzMWU3b0J0emMzdFdDY1loNWlJWEZiRjJSZGlIRlJI?=
 =?utf-8?B?NHNiVzhuQ0VWVWh5SWVjblFUbkloT25ydzFKVGZENTh5UHNmTmgydXd1OFN4?=
 =?utf-8?B?Y2hpRW81N1RlaGlHb3JjWlhpYWY1T0tvWnNEZlgyZkd4Q0x6ZlNXYXY3ZFJ3?=
 =?utf-8?B?SVpCMzZhRTB4b2xnUG8vWkQ3MzhJRVpTQVB5eEZWVHVkTndZNGkzREhNMXhu?=
 =?utf-8?B?SXZzK3A3dzdqb2o5bXJCSEZPZkVJak10V0lzOW5LK2llcnFNTzlhQmdWVDVH?=
 =?utf-8?B?ZTdPVVVBRWNYRkR3R1Fxaks0UExpMThrNEEvVnZsaWU2aHZiNGZicGxndnNU?=
 =?utf-8?B?anRkbzZubFdUbEV0RzlydnFjR0dhU0pJczQ2SkhnaEpjQkhVTEVtNEM1bUJC?=
 =?utf-8?B?Nlk2V2JTYXdGME5WVjYrWHlmVjFaUmdNcTlXL1VjZnNNSVVROHB6KzR6VWc4?=
 =?utf-8?B?UUNLT3Z2aXVhWE4xcENsRVdiY3I4Q2gzOXlLTCtNTHMreVBTQ0o1dWFuaXhk?=
 =?utf-8?B?ZGZpVUZtaGZWN1c4K1ZNZG1yZXNtTVB6ZHZoUitzdjZPLzJ0WTIvVGZPZUhk?=
 =?utf-8?B?OVQ1SGRTZ0FaZDFYSGN4bFlRb3pZZm1UNktwKzRLcjNaajdFNVNjRkJzZkh0?=
 =?utf-8?B?MWN2a2s1T2xkaER1Z3dRMCt3cG9tR2NJK2JrYStqNkx2SXBIKzU0blQxL0Fl?=
 =?utf-8?B?VTF3QUs1T2RsWHNlRFJnZVhIdCtHd3hrTU1BbzNlekMvM2JvZ0x0RUZCSVdQ?=
 =?utf-8?B?T2UxRDU2TC8wbkZkQ1JIZlI2ZTc0ZndJMkJJR2pDL2dKR3RDOWsxNEJJb3di?=
 =?utf-8?B?dmpkZXk1S3ZwazB4MUlkZHU2aE42SjdSNlcwbXhBUnhyc253aGc4OS91YVhi?=
 =?utf-8?B?MmNNcUxhamhSTm1pUTczMVByTFF2UVQvNjErUE1oZldNZWRHVzBRODBOcDJ4?=
 =?utf-8?B?YWd4N0Z0YXpncFFvek5oSFJYWDc4N2MwOGtkREh6MVJ3Rk51cHYwbDRrNUhP?=
 =?utf-8?B?VTN0dkJjS0JuM3lVWWpIcndEZFJvV2pqZklZMnpKYVJSMnNMV2QyU3lIenVV?=
 =?utf-8?B?bVhmdXpaMW5oMzM1RlFiZ2ZZTW10bTF5WG5BVnBmU250NG8waGpmbmRTRmVT?=
 =?utf-8?Q?jSkM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50744dca-662f-45b3-382a-08dbc12a191a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 20:24:35.9735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkGxZ4pligKz8Pk5tiIWKiUrW0C1D5JUUVfud++/50QuwWFKvDNRXhvkH5j7lM4H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
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


On 9/29/2023 2:48 PM, Felix Kuehling wrote:
>
> On 2023-09-29 15:44, Chen, Xiaogang wrote:
>>
>> On 9/29/2023 1:41 PM, Felix Kuehling wrote:
>>>
>>> On 2023-09-29 14:25, Chen, Xiaogang wrote:
>>>>
>>>> On 9/28/2023 4:26 PM, Felix Kuehling wrote:
>>>>> On 2023-09-20 13:32, Xiaogang.Chen wrote:
>>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>>
>>>>>> This patch implements partial migration in gpu page fault 
>>>>>> according to migration
>>>>>> granularity(default 2MB) and not split svm range in cpu page 
>>>>>> fault handling.
>>>>>> A svm range may include pages from both system ram and vram of 
>>>>>> one gpu now.
>>>>>> These chagnes are expected to improve migration performance and 
>>>>>> reduce mmu
>>>>>> callback and TLB flush workloads.
>>>>>>
>>>>>> Signed-off-by: xiaogang chen<xiaogang.chen@amd.com>
>>>>>
>>>>> Some more nit-picks inline.
>>> [snip]
>>>>> @@ -202,12 +200,24 @@ svm_range_dma_map_dev(struct amdgpu_device 
>>>>> *adev, struct svm_range *prange,
>>>>>   static int
>>>>>   svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>>>>>             unsigned long offset, unsigned long npages,
>>>>> -          unsigned long *hmm_pfns)
>>>>> +          unsigned long *hmm_pfns, uint64_t *vram_pages)
>>>>>   {
>>>>>       struct kfd_process *p;
>>>>>       uint32_t gpuidx;
>>>>> +    struct page **page;
>>>>>       int r;
>>>>>   +    page = kvcalloc(npages, sizeof(*page), GFP_KERNEL);
>>>>>
>>>>> Is there a reason this needs to be 0-initialized? The loop below 
>>>>> initializes all elements.
>>>> Will use kvmalloc_array instead. This array is not needed to init 
>>>> during alloc as it will  be set afterword.
>>>>>
>>>>> I'm also not happy about having to allocate this page array here. 
>>>>> It may be justified if the repeated calls to hmm_pfn_to_page were 
>>>>> expensive compared to the memory allocation and initialization. 
>>>>> I'm not convinced that's the case, though. With 
>>>>> CONFIG_SPARSEMEM_VMEMMAP, hmm_pfn_to_page basically boils down to 
>>>>> __pfn_to_page, which is a macro that does just this:
>>>>>
>>>>> #define __pfn_to_page(pfn)    (vmemmap + (pfn))
>>>>>
>>>>> See 
>>>>> https://elixir.bootlin.com/linux/v6.5.5/source/include/asm-generic/memory_model.h#L37.
>>>>>
>>>> We get page* array here, then we do not need get page at 
>>>> svm_range_dma_map_dev for each device since pages are same for all 
>>>> gpu devices. So we save calling hmm_pfn_to_page though calling 
>>>> hmm_pfn_to_page cost is low. Here we also want get vram page number 
>>>> during svm_range_dma_map.
>>>>
>>>> I think you do not want alloc a page array each time we do 
>>>> svm_range_dma_map? then can we put this struct page **page at 
>>>> svm_range, and alloc it each time create new prange(and clone/split 
>>>> prange)?
>>>
>>> Allocating and freeing memory in every dmamap call adds a point of 
>>> failure and non-deterministic overhead for the memory allocation. 
>>> It's non-deterministic because it depends on current memory pressure 
>>> situation and if the array is large, it also needs to update the 
>>> kernel page table and potentially flush CPU TLBs.
>>>
>>> Allocating the page pointer array permanently in the prange 
>>> structure would be even worse, because that increases our system 
>>> memory overhead. For each GB of virtual address space we manage, we 
>>> waste 2MB of system memory for the page arrays. To make matters 
>>> worse, those page arrays are allocated in kernel mode where they are 
>>> not swappable. It's like taking physical DIMM sticks out of your 
>>> system. We worked hard to eliminate redundant address and page array 
>>> allocations from the driver a few years ago.
>>>
>>> I'd prefer a small amount of redundant address calculations over the 
>>> memory or non-deterministic allocation overhead.
>>>
>> Then I think we can cal vram_pages atsvm_range_validate_and_map as 
>> the last version:
>>
>> +for (int i = 0; i < npages; i++) {
>>
>>  +if (is_zone_device_page(hmm_pfn_to_page(hmm_range->hmm_pfns[i])))
>>
>> vram_pages++;
>>
>>  +}
>>
>> That will not alloc page* array, but have additional calling 
>> hmm_pfn_to_page.
>>
>> Or add a parameter at svm_range_dma_map_dev to indicate whether cal 
>> vram_pages, and only one svm_range_dma_map_dev call will cal vram_pages.
>
> svm_range_dma_map_dev has the 
> is_zone_device_page(hmm_pfn_to_page(...)) check already. Always 
> counting VRAM pages in svm_range_dma_map_dev would be trivial. Adding 
> a condition would only make it slower.
>
> Whether or not use use the vram_pages count in the end is a different 
> matter. But I think just unconditionally adding vram_pages++ in 
> svm_range_dma_map_dev would have negligible overhead.

ok, adding a check at svm_range_dma_map_dev would spoil code cache or 
branch prediction. Always do vram_pages++ even though get same result 
for all gpu devices.

Regards

Xiaogang

>
> Regards,
>   Felix
>
>
>>
>> Regards
>>
>> Xiaogang
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>>>
>>>>>> +    if (!page)
>>>>>> +        return -ENOMEM;
>>>>>> +
>>>>>> +    *vram_pages = 0;
>>>>>> +    for (int i = 0; i < npages; i++) {
>>>>>> +        page[i] = hmm_pfn_to_page(hmm_pfns[i]);
>>>>>> +        if (is_zone_device_page(page[i]))
>>>>>> +            (*vram_pages)++;
>>>>>> +    }
>>>>>> +
>>>>>>       p = container_of(prange->svms, struct kfd_process, svms);
>>>>>>         for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
>>>>>> @@ -221,11 +231,12 @@ svm_range_dma_map(struct svm_range *prange, 
>>>>>> unsigned long *bitmap,
>>>>>>           }
>>>>>>             r = svm_range_dma_map_dev(pdd->dev->adev, prange, 
>>>>>> offset, npages,
>>>>>> -                      hmm_pfns, gpuidx);
>>>>>> +                      hmm_pfns, gpuidx, page);
>>>>>>           if (r)
>>>>>>               break;
>>>>>>       }
>>>>>>   +    kvfree(page);
>>>>>>       return r;
>>>>>>   }
>>>>>>   @@ -347,6 +358,7 @@ svm_range *svm_range_new(struct 
>>>>>> svm_range_list *svms, uint64_t start,
>>>>>>       INIT_LIST_HEAD(&prange->child_list);
>>>>>>       atomic_set(&prange->invalid, 0);
>>>>>>       prange->validate_timestamp = 0;
>>>>>> +    prange->vram_pages = 0;
>>>>>>       mutex_init(&prange->migrate_mutex);
>>>>>>       mutex_init(&prange->lock);
>>>>>>   @@ -393,6 +405,8 @@ static void svm_range_bo_release(struct 
>>>>>> kref *kref)
>>>>>>                prange->start, prange->last);
>>>>>>           mutex_lock(&prange->lock);
>>>>>>           prange->svm_bo = NULL;
>>>>>> +        /* prange does not hold vram page now */
>>>>>> +        prange->actual_loc = 0;
>>>>>
>>>>> If you need this here, something probably went wrong elsewhere. 
>>>>> Before we release the BO, we should have migrated everything to 
>>>>> system memory, and actual_loc should already be 0. If anything, 
>>>>> I'd add a WARN_ON(prange->actual_loc) here.
>>>>>
>>>> Will replace by WARN_ON as mentioned before.
>>>>>
>>>>>> mutex_unlock(&prange->lock);
>>>>>>             spin_lock(&svm_bo->list_lock);
>>>>>> @@ -966,6 +980,11 @@ svm_range_split_nodes(struct svm_range *new, 
>>>>>> struct svm_range *old,
>>>>>>       new->svm_bo = svm_range_bo_ref(old->svm_bo);
>>>>>>       new->ttm_res = old->ttm_res;
>>>>>>   +    /* set new's vram_pages as old range's now, the acurate 
>>>>>> vram_pages
>>>>>> +     * will be updated during mapping
>>>>>> +     */
>>>>>> +    new->vram_pages = min(old->vram_pages, new->npages);
>>>>>> +
>>>>>>       spin_lock(&new->svm_bo->list_lock);
>>>>>>       list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>>>>>>       spin_unlock(&new->svm_bo->list_lock);
>>>>>> @@ -1610,6 +1629,7 @@ static int 
>>>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>>>       struct svm_validate_context *ctx;
>>>>>>       unsigned long start, end, addr;
>>>>>>       struct kfd_process *p;
>>>>>> +    uint64_t vram_pages;
>>>>>>       void *owner;
>>>>>>       int32_t idx;
>>>>>>       int r = 0;
>>>>>> @@ -1678,11 +1698,13 @@ static int 
>>>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>>>           }
>>>>>>       }
>>>>>>   +    vram_pages = 0;
>>>>>>       start = prange->start << PAGE_SHIFT;
>>>>>>       end = (prange->last + 1) << PAGE_SHIFT;
>>>>>>       for (addr = start; addr < end && !r; ) {
>>>>>>           struct hmm_range *hmm_range;
>>>>>>           struct vm_area_struct *vma;
>>>>>> +        uint64_t vram_pages_vma;
>>>>>>           unsigned long next;
>>>>>>           unsigned long offset;
>>>>>>           unsigned long npages;
>>>>>> @@ -1711,12 +1733,14 @@ static int 
>>>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>>>             offset = (addr - start) >> PAGE_SHIFT;
>>>>>>           r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>>>>>> -                      hmm_range->hmm_pfns);
>>>>>> +                      hmm_range->hmm_pfns, &vram_pages_vma);
>>>>>>           if (r) {
>>>>>>               pr_debug("failed %d to dma map range\n", r);
>>>>>>               goto unreserve_out;
>>>>>>           }
>>>>>>   +        vram_pages += vram_pages_vma;
>>>>>> +
>>>>>>           svm_range_lock(prange);
>>>>>>           if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
>>>>>>               pr_debug("hmm update the range, need validate 
>>>>>> again\n");
>>>>>> @@ -1738,8 +1762,20 @@ static int 
>>>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>>>           addr = next;
>>>>>>       }
>>>>>>   -    if (addr == end)
>>>>>> +    if (addr == end) {
>>>>>>           prange->mapped_to_gpu = true;
>>>>>> +        prange->vram_pages = vram_pages;
>>>>>> +
>>>>>> +        /* if pragne does not include any vram page and it
>>>>>
>>>>> Typo: prange
>>>>>
>>>> ok.
>>>>>
>>>>>> +         * has not released svm_bo drop its svm_bo reference
>>>>>> +         */
>>>>>> +        if (!vram_pages && prange->ttm_res) {
>>>>>> +            svm_range_vram_node_free(prange);
>>>>>> +            mutex_lock(&prange->lock);
>>>>>
>>>>> Is this lock really needed.
>>>>>
>>>> same as before, will remove mutex_lock/unlock(&prange->lock) as it 
>>>> seems overprotected.
>>>>>
>>>>>> +            prange->actual_loc = 0;
>>>>>> +            mutex_unlock(&prange->lock);
>>>>>> +        }
>>>>>> +    }
>>>>>>     unreserve_out:
>>>>>>       svm_range_unreserve_bos(ctx);
>>>>>> @@ -1996,6 +2032,7 @@ static struct svm_range 
>>>>>> *svm_range_clone(struct svm_range *old)
>>>>>>       new->actual_loc = old->actual_loc;
>>>>>>       new->granularity = old->granularity;
>>>>>>       new->mapped_to_gpu = old->mapped_to_gpu;
>>>>>> +    new->vram_pages = old->vram_pages;
>>>>>>       bitmap_copy(new->bitmap_access, old->bitmap_access, 
>>>>>> MAX_GPU_INSTANCE);
>>>>>>       bitmap_copy(new->bitmap_aip, old->bitmap_aip, 
>>>>>> MAX_GPU_INSTANCE);
>>>>>>   @@ -2903,6 +2940,7 @@ svm_range_restore_pages(struct 
>>>>>> amdgpu_device *adev, unsigned int pasid,
>>>>>>               uint32_t vmid, uint32_t node_id,
>>>>>>               uint64_t addr, bool write_fault)
>>>>>>   {
>>>>>> +    unsigned long start, last, size;
>>>>>>       struct mm_struct *mm = NULL;
>>>>>>       struct svm_range_list *svms;
>>>>>>       struct svm_range *prange;
>>>>>> @@ -3038,32 +3076,38 @@ svm_range_restore_pages(struct 
>>>>>> amdgpu_device *adev, unsigned int pasid,
>>>>>>       kfd_smi_event_page_fault_start(node, p->lead_thread->pid, 
>>>>>> addr,
>>>>>>                          write_fault, timestamp);
>>>>>>   -    if (prange->actual_loc != best_loc) {
>>>>>> +    if (prange->actual_loc != 0 || best_loc != 0) {
>>>>>>           migration = true;
>>>>>> +        /* Align migration range start and size to granularity 
>>>>>> size */
>>>>>> +        size = 1UL << prange->granularity;
>>>>>> +        start = ALIGN_DOWN(addr, size);
>>>>>> +        last = ALIGN(addr + 1, size) - 1;
>>>>>> +
>>>>>> +        start = (start >= prange->start) ? start : prange->start;
>>>>>> +        last = (last <= prange->last) ? last : prange->last;
>>>>>
>>>>> Similar to the simplification I recommended in svm_migrate_to_ram, 
>>>>> this could be:
>>>>>
>>>>>     start = max(ALIGN_DOWN(addr, size), prange->start);
>>>>>     last = min(ALIGN(addr + 1, size) - 1, prange->last);
>>>>>
>>>> ok, overlooked last time.
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>> +
>>>>>>           if (best_loc) {
>>>>>> -            r = svm_migrate_to_vram(prange, best_loc, mm,
>>>>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>>>>> +            r = svm_migrate_to_vram(prange, best_loc, start, last,
>>>>>> +                    mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>>>>>               if (r) {
>>>>>>                   pr_debug("svm_migrate_to_vram failed (%d) at 
>>>>>> %llx, falling back to system memory\n",
>>>>>>                        r, addr);
>>>>>>                   /* Fallback to system memory if migration to
>>>>>>                    * VRAM failed
>>>>>>                    */
>>>>>> -                if (prange->actual_loc)
>>>>>> -                    r = svm_migrate_vram_to_ram(prange, mm,
>>>>>> - KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>>>>> -                       NULL);
>>>>>> +                if (prange->actual_loc && prange->actual_loc != 
>>>>>> best_loc)
>>>>>> +                    r = svm_migrate_vram_to_ram(prange, mm, 
>>>>>> start, last,
>>>>>> + KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>>>>                   else
>>>>>>                       r = 0;
>>>>>>               }
>>>>>>           } else {
>>>>>> -            r = svm_migrate_vram_to_ram(prange, mm,
>>>>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>>>>> -                    NULL);
>>>>>> +            r = svm_migrate_vram_to_ram(prange, mm, start, last,
>>>>>> +                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>>>>           }
>>>>>>           if (r) {
>>>>>>               pr_debug("failed %d to migrate svms %p [0x%lx 
>>>>>> 0x%lx]\n",
>>>>>> -                 r, svms, prange->start, prange->last);
>>>>>> +                r, svms, start, last);
>>>>>>               goto out_unlock_range;
>>>>>>           }
>>>>>>       }
>>>>>> @@ -3417,18 +3461,24 @@ svm_range_trigger_migration(struct 
>>>>>> mm_struct *mm, struct svm_range *prange,
>>>>>>       *migrated = false;
>>>>>>       best_loc = svm_range_best_prefetch_location(prange);
>>>>>>   -    if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
>>>>>> -        best_loc == prange->actual_loc)
>>>>>> +    /* when best_loc is a gpu node and same as prange->actual_loc
>>>>>> +     * we still need do migration as prange->actual_loc !=0 does
>>>>>> +     * not mean all pages in prange are vram. hmm migrate will pick
>>>>>> +     * up right pages during migration.
>>>>>> +     */
>>>>>> +    if ((best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED) ||
>>>>>> +        (best_loc == 0 && prange->actual_loc == 0))
>>>>>>           return 0;
>>>>>>         if (!best_loc) {
>>>>>> -        r = svm_migrate_vram_to_ram(prange, mm,
>>>>>> +        r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>>>>>> prange->last,
>>>>>>                       KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>>>>>>           *migrated = !r;
>>>>>>           return r;
>>>>>>       }
>>>>>>   -    r = svm_migrate_to_vram(prange, best_loc, mm, 
>>>>>> KFD_MIGRATE_TRIGGER_PREFETCH);
>>>>>> +    r = svm_migrate_to_vram(prange, best_loc, prange->start, 
>>>>>> prange->last,
>>>>>> +                    mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>>>>>>       *migrated = !r;
>>>>>>         return r;
>>>>>> @@ -3483,7 +3533,11 @@ static void 
>>>>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>>>>             mutex_lock(&prange->migrate_mutex);
>>>>>>           do {
>>>>>> +            /* migrate all vram pages in this prange to sys ram
>>>>>> +             * after that prange->actual_loc should be zero
>>>>>> +             */
>>>>>>               r = svm_migrate_vram_to_ram(prange, mm,
>>>>>> +                    prange->start, prange->last,
>>>>>>                       KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>>>>>>           } while (!r && prange->actual_loc && --retries);
>>>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>>> index 5fd958a97a28..8574cc5eeabd 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>>> @@ -78,6 +78,7 @@ struct svm_work_list_item {
>>>>>>    * @update_list:link list node used to add to update_list
>>>>>>    * @mapping:    bo_va mapping structure to create and update 
>>>>>> GPU page table
>>>>>>    * @npages:     number of pages
>>>>>> + * @vram_pages: vram pages number in this svm_range
>>>>>>    * @dma_addr:   dma mapping address on each GPU for system 
>>>>>> memory physical page
>>>>>>    * @ttm_res:    vram ttm resource map
>>>>>>    * @offset:     range start offset within mm_nodes
>>>>>> @@ -88,7 +89,9 @@ struct svm_work_list_item {
>>>>>>    * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
>>>>>>    * @perferred_loc: perferred location, 0 for CPU, or GPU id
>>>>>>    * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
>>>>>> - * @actual_loc: the actual location, 0 for CPU, or GPU id
>>>>>> + * @actual_loc: this svm_range location. 0: all pages are from 
>>>>>> sys ram;
>>>>>> + *              GPU id: this svm_range may include vram pages 
>>>>>> from GPU with
>>>>>> + *              id actual_loc.
>>>>>>    * @granularity:migration granularity, log2 num pages
>>>>>>    * @invalid:    not 0 means cpu page table is invalidated
>>>>>>    * @validate_timestamp: system timestamp when range is validated
>>>>>> @@ -112,6 +115,7 @@ struct svm_range {
>>>>>>       struct list_head        list;
>>>>>>       struct list_head        update_list;
>>>>>>       uint64_t            npages;
>>>>>> +    uint64_t            vram_pages;
>>>>>>       dma_addr_t            *dma_addr[MAX_GPU_INSTANCE];
>>>>>>       struct ttm_resource        *ttm_res;
>>>>>>       uint64_t            offset;
