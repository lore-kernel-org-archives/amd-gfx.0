Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04318E728DE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 19:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA9C10E710;
	Fri, 29 Sep 2023 19:48:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FBA010E710
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 19:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrPYITjjMYo5SZWxODgm+D/IFqzepvG60l/YMqfDmrmDFU+OyvDR2ERLQEHbDvNNiVsnZM1oHePnd+H3UupmkMY5Y/Y7AVoWnM74iBUxyd9x/R45XDAzW6pmK0BkJp9fhQxpBmnZaM0igngcQO/2fRIzcJg2yg7u9SQXfQbpXOxx8tHvbXShjq+8vSlT/72PyaoHMnVs4yqbG0Je7cGlJy50ZG7fEdy3iiEcCGfzB8lUqjMYBajCEJrgbO3yu85jJciBZ7rW+Tvly04fVAX+XTHFKvlHBaqPvYFIM80e17dO8YoSnUIsTjInTYVB+vUy+xJ/OzA5fGwQMzE63MbnQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFbONR8iGhyKlrCD65Q2a9igBp71O8VMs2mS/2YHhio=;
 b=kYxkUFOjAHA1/taE30HTs1waoSvMvwuZ0kUcdZ85PV0fXX+B8uvZnYmZAcyyI519Vz12cTpkCpgMfMEZ3hlC/VWZqmh+8XBczvA9AJgzk3r9RGca328GK9zp1L2SEqBAj4b0ij8Ab3BFcYIVwmzDbAJPUWnxIxF7AnbB0XdZUwyhRG9/T3PpZ2VTcR2/4G6Qf9DWq3mi+ODr7fNE/+MwbGLVZaz0fPce5lWx+QN5HxTl05gQ98utpGvADTeNiXmc/psoVjLmQaMbPthunRGc42gYUI1Vyrav+MU/oOiYSkqrIC5FJtgJr0k+fHgXoPx8tUogtQpUNDTRpkvAjTMUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFbONR8iGhyKlrCD65Q2a9igBp71O8VMs2mS/2YHhio=;
 b=xH//eXvVNDEsCgOsCr7kDqU23AHGR157SNctrU19Voh+f/s6uWhX3As9bjhosHaETJ8oY17m/8fVxYTcSO+3g1x+2l7NOIeJ11Bf7POb5l81rMx86XtUCLmrtAkJeMAThbDoEVs12js47MiRM3z5FZUHN9B2ynOmtuw0F7NQRT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 19:48:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 19:48:11 +0000
Message-ID: <182de8b7-6d44-05df-bc69-9f3412301c71@amd.com>
Date: Fri, 29 Sep 2023 15:48:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230920173203.12760-1-xiaogang.chen@amd.com>
 <cdbc2263-d6c7-ab0a-0bf2-3361dd34a358@amd.com>
 <7ab40093-5e86-796d-eee8-c6172b41ef47@amd.com>
 <44d8ab8f-6ab3-54b3-d600-8cc6943b2ca3@amd.com>
 <f999a611-a400-d55f-0c3e-45b5109cd616@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <f999a611-a400-d55f-0c3e-45b5109cd616@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da763af-e91a-436f-ae1b-08dbc1250347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNW9bPYQXmRlZBVXnxt69Y2HM4moCDs6VptkfFA7vEghGvdSHq6MhlYQmxw6+WsahZEDm0q+g7f8iN++jVKuBbMYlQMNv981xR3eV2/VWrqEefo25RVmhbCwzhlKDAAjiQnSX/e5iss3m2zNTkmGOx2XpKr8uSu19wcrymvD56FsrXvqzmeoqkvIa6p7DrRa5id79eiHrXBrDOPHUuiDCaJ6qvPzJ5TvE00sg1rC9Pqy0YpgeKpftQr2w6x+NylooqATFqUAn6bZK4Y64OFxeviWOE0Dttp8eoJLrg2Yoy0OGTvY50yy5McXXUVrq1sdKC+l/O1QHmKZSdzYJHV8/Fbmbc5aIlk6GU3B2UD35ewtjcdRIM1eMIe01/1HtpH/2jI8vEgLLeFk/YN4IGJcJCptYn7kDJebMtGn0fH5SXezhSBuMSkayJPE49uPe9IIPyM2qrprxb5Hkpf/WHMlit+VoSxmC8qrMLS+uIBpS5jVeMyCanF5GH5CdK0KSy6zRzYqQ2LtJgSwF8d8EckW0Y4GLwROT6d1qlVRpIdpWGj7V+ks/zAI8rXmth94YH+/XgN1bCNeHczMZKpOZ18r75xBXc+LACw19Ho/EqGdwzML+JVhIl6W6tBZapD+i54JjhuClJSaprO51xydHHe7aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(30864003)(2906002)(44832011)(5660300002)(31686004)(8936002)(4326008)(8676002)(2616005)(36756003)(26005)(41300700001)(66946007)(66476007)(66556008)(316002)(6512007)(6506007)(53546011)(36916002)(83380400001)(478600001)(966005)(6486002)(38100700002)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmVKbTRXdHQ4KzB5UEdJSFN2QWRtM1J5M1FXUE5vdzMwNWJyMmpvTWNmZDJ2?=
 =?utf-8?B?ZldkMUVkUlZvSmoyelUzMGNENWhSOXpLeHJ4WlVXZ1A3d1lTNVlYU1VYdFoy?=
 =?utf-8?B?dXBvUU1FM2ZGV3JBMXh5RUM2MEFoUzlyUTlkSTZnKzEzbGFiY2FOdlhUN2Vm?=
 =?utf-8?B?RnpEcWlQYTJ0Sy9hYW5rbmNxclcva2d0OHBsdlZjNkxmSVVGK1YxQ1JmN1dO?=
 =?utf-8?B?NldxWVFIU3JNR25LU0w2amlkT0luYTlzV2pTd09Zc0VWUXIyMkRkTmZqaGZr?=
 =?utf-8?B?RzJ2Mk1UTVdMZklndDJsRi8zNWtodWhld1o0eTc5OG5uWE16MEEweWUyMVpR?=
 =?utf-8?B?UE54ZVhheGVEUzFhUk9LUk5CNTVGekN1N1cvWjQ4L0NKb3ZENXQ3WGUyZ1ov?=
 =?utf-8?B?RlMwR1dZRWFDbDUwTXp4V0hjOEdtNUU5ak5FVDJJUHY2RWRiZlJ6dUsvOEV5?=
 =?utf-8?B?ZGhRVW90WGtVQjVlSWdFb3JaWnROU2VPL0VlUiswbkFWdlJEOUlBL2FYeW9y?=
 =?utf-8?B?L1NicGJkeWFPdktoTDFCYktBbjRlUlBUUGNPSEZQYkRjaGtwdzAwUkx5QnNt?=
 =?utf-8?B?VzRzZlFDRVF3V1dOcE1LRnNVeitBMXYxL2E0bGFweTlkV2svVnVrQ2J4Z3NZ?=
 =?utf-8?B?M1lOeEFyZnpSSW9lUGRUQnJxMTJ6K0I5UUl3TGRxeDNnRkZxN3Nhd1drSG1I?=
 =?utf-8?B?bFB1ZWM4NTArbU5pRFc1TmpaN3FuZG12Mm8vWGtTSUJ0SlJqMnpYaHE5aW1T?=
 =?utf-8?B?OTE4S0FUaGIzTWlSU1VBQXJTb09SbytoYmp1MmpEczJCdXRwSy9hb1ZvWHY0?=
 =?utf-8?B?U2s0TDlpRElqb2dKSXorM3JuTnJQNm5lbEpQK3ZEdXhRdjZMMEovRjJQWEFa?=
 =?utf-8?B?QkdzRnE2TnJGYUt4Q3h1bC9VTTk5Y2szaEtvSU1xU3pOTzA1eHZiVG50TnNq?=
 =?utf-8?B?elhMOHdKSGtwL0FvQ1p5eTFBSC83ZFVtcDVyRDg0cFI2QU54NzNVdmZFOVVU?=
 =?utf-8?B?Nzk2S0NadUtUMnRIY1BKNU0xQWh1Ulc2VERrR1BXeGJtSlRDazRLbFNNY21P?=
 =?utf-8?B?bkhwU2tyY0JRZFYva0xlKzlkSmdITG9jWEEwTk0vcGFaRzRoMWhDb1MyeDFE?=
 =?utf-8?B?VWR6RFkyVzNRZkV0Y0laRC9Zb0NPWlNqYW03MlV1TjhtNE91SUJzREdpYVl6?=
 =?utf-8?B?R2VvOE5lK28vOEFKeHhUcmxoWUZadmNoWHJqeW9jbzIzVSsxZ1loenAwSktr?=
 =?utf-8?B?MGNwMnVRbDk5THNVWHlKUmdsbEpndDBSZ1dYQ2pxMkNacUhDYnRPUVR6SFg3?=
 =?utf-8?B?T3VkUy9rTjUzd3o2T2lweVdPYm5QMUJqUnFDb0I1c2wvQy9XQXg4UlJlclhH?=
 =?utf-8?B?aDZSelg2TmtLdjJDWDltZUlQUyttWkZDTnJ5MDZjNG9MMVk4SlcwekhiTkxC?=
 =?utf-8?B?ZzJtL043cUdYZnB3WTczNWJEbjl3L2prbHNmWFF5RW52S2NwRW1vdU1teXdo?=
 =?utf-8?B?ZkM0ZlB1L2NpbzNQcDJxZFF0Tk94MnlqY0VaenhaZnhqYnBpUCtzUXpvbXJP?=
 =?utf-8?B?ZTJ5ZVpCWWs5bm5pYm5Pb2RSUUZEcm9GbGZxdmQrWmFnY3c0OUMxSkQ2WFFi?=
 =?utf-8?B?Nyt5VzFQMFR2M0hsUXJnR0I0a0FHdWpwbzVhY1NRU1B5ZjJpUko2c2JTMGJQ?=
 =?utf-8?B?UjhYMjc2K1JDL1ZuQURCVm01YzVzQVFHb0Vnbk1TckJyZnc3WXV0Q01qRTZ3?=
 =?utf-8?B?d1pJOFpDNkZqcEhNQjd5NXZjd3MrWTd5UlNFOWVjUm1kZEc0Mi8yRGlLWktT?=
 =?utf-8?B?S29tbTErT25BSWNiRkJIVCtlZ2tCQlQ0ZmFwd1RrdEF4Z3JXZ1U0aGVIRVlv?=
 =?utf-8?B?Sy9lekVKS2tSeE1mTG5xamJpOGpJV1ZGalBsNkRoUnV1cVF4L212Y2ZrWEdP?=
 =?utf-8?B?aFNkaHYyelNvSHNvdURHMnB6TDdNMFZrNmJqVG53QWJXbXN2ZUhkdDRoWU43?=
 =?utf-8?B?UmFhZ0E5WGNRTGlGZDZFUTBBb0p3M0dwN3lCa3BwRGszRTQzekIxNE9pdHQz?=
 =?utf-8?B?Zi9VZ29malRydHRNREZIdC8zN2gyQ3orelpFTUhMZzJPemtZZHM4SlJVMHhV?=
 =?utf-8?Q?fhDBre0bKtp7/6V1X4C3lJZ6k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da763af-e91a-436f-ae1b-08dbc1250347
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 19:48:11.7362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypgYRNTJnBbQUOa8hs8cSJadsuYtiAP5G5q9oy5OYoTHs7ypk/PLXNluD4TjuvvmMal4/ZrxnObrKt58ZQV7ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
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


On 2023-09-29 15:44, Chen, Xiaogang wrote:
>
> On 9/29/2023 1:41 PM, Felix Kuehling wrote:
>>
>> On 2023-09-29 14:25, Chen, Xiaogang wrote:
>>>
>>> On 9/28/2023 4:26 PM, Felix Kuehling wrote:
>>>> On 2023-09-20 13:32, Xiaogang.Chen wrote:
>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>
>>>>> This patch implements partial migration in gpu page fault 
>>>>> according to migration
>>>>> granularity(default 2MB) and not split svm range in cpu page fault 
>>>>> handling.
>>>>> A svm range may include pages from both system ram and vram of one 
>>>>> gpu now.
>>>>> These chagnes are expected to improve migration performance and 
>>>>> reduce mmu
>>>>> callback and TLB flush workloads.
>>>>>
>>>>> Signed-off-by: xiaogang chen<xiaogang.chen@amd.com>
>>>>
>>>> Some more nit-picks inline.
>> [snip]
>>>> @@ -202,12 +200,24 @@ svm_range_dma_map_dev(struct amdgpu_device 
>>>> *adev, struct svm_range *prange,
>>>>   static int
>>>>   svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>>>>             unsigned long offset, unsigned long npages,
>>>> -          unsigned long *hmm_pfns)
>>>> +          unsigned long *hmm_pfns, uint64_t *vram_pages)
>>>>   {
>>>>       struct kfd_process *p;
>>>>       uint32_t gpuidx;
>>>> +    struct page **page;
>>>>       int r;
>>>>   +    page = kvcalloc(npages, sizeof(*page), GFP_KERNEL);
>>>>
>>>> Is there a reason this needs to be 0-initialized? The loop below 
>>>> initializes all elements.
>>> Will use kvmalloc_array instead. This array is not needed to init 
>>> during alloc as it will  be set afterword.
>>>>
>>>> I'm also not happy about having to allocate this page array here. 
>>>> It may be justified if the repeated calls to hmm_pfn_to_page were 
>>>> expensive compared to the memory allocation and initialization. I'm 
>>>> not convinced that's the case, though. With 
>>>> CONFIG_SPARSEMEM_VMEMMAP, hmm_pfn_to_page basically boils down to 
>>>> __pfn_to_page, which is a macro that does just this:
>>>>
>>>> #define __pfn_to_page(pfn)    (vmemmap + (pfn))
>>>>
>>>> See 
>>>> https://elixir.bootlin.com/linux/v6.5.5/source/include/asm-generic/memory_model.h#L37.
>>>>
>>> We get page* array here, then we do not need get page at 
>>> svm_range_dma_map_dev for each device since pages are same for all 
>>> gpu devices. So we save calling hmm_pfn_to_page though calling 
>>> hmm_pfn_to_page cost is low. Here we also want get vram page number 
>>> during svm_range_dma_map.
>>>
>>> I think you do not want alloc a page array each time we do 
>>> svm_range_dma_map? then can we put this struct page **page at 
>>> svm_range, and alloc it each time create new prange(and clone/split 
>>> prange)?
>>
>> Allocating and freeing memory in every dmamap call adds a point of 
>> failure and non-deterministic overhead for the memory allocation. 
>> It's non-deterministic because it depends on current memory pressure 
>> situation and if the array is large, it also needs to update the 
>> kernel page table and potentially flush CPU TLBs.
>>
>> Allocating the page pointer array permanently in the prange structure 
>> would be even worse, because that increases our system memory 
>> overhead. For each GB of virtual address space we manage, we waste 
>> 2MB of system memory for the page arrays. To make matters worse, 
>> those page arrays are allocated in kernel mode where they are not 
>> swappable. It's like taking physical DIMM sticks out of your system. 
>> We worked hard to eliminate redundant address and page array 
>> allocations from the driver a few years ago.
>>
>> I'd prefer a small amount of redundant address calculations over the 
>> memory or non-deterministic allocation overhead.
>>
> Then I think we can cal vram_pages atsvm_range_validate_and_map as the 
> last version:
>
> +for (int i = 0; i < npages; i++) {
>
>  +if (is_zone_device_page(hmm_pfn_to_page(hmm_range->hmm_pfns[i])))
>
> vram_pages++;
>
>  +}
>
> That will not alloc page* array, but have additional calling 
> hmm_pfn_to_page.
>
> Or add a parameter at svm_range_dma_map_dev to indicate whether cal 
> vram_pages, and only one svm_range_dma_map_dev call will cal vram_pages.

svm_range_dma_map_dev has the is_zone_device_page(hmm_pfn_to_page(...)) 
check already. Always counting VRAM pages in svm_range_dma_map_dev would 
be trivial. Adding a condition would only make it slower.

Whether or not use use the vram_pages count in the end is a different 
matter. But I think just unconditionally adding vram_pages++ in 
svm_range_dma_map_dev would have negligible overhead.

Regards,
   Felix


>
> Regards
>
> Xiaogang
>
>> Regards,
>>   Felix
>>
>>
>>>
>>>>
>>>>> +    if (!page)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    *vram_pages = 0;
>>>>> +    for (int i = 0; i < npages; i++) {
>>>>> +        page[i] = hmm_pfn_to_page(hmm_pfns[i]);
>>>>> +        if (is_zone_device_page(page[i]))
>>>>> +            (*vram_pages)++;
>>>>> +    }
>>>>> +
>>>>>       p = container_of(prange->svms, struct kfd_process, svms);
>>>>>         for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
>>>>> @@ -221,11 +231,12 @@ svm_range_dma_map(struct svm_range *prange, 
>>>>> unsigned long *bitmap,
>>>>>           }
>>>>>             r = svm_range_dma_map_dev(pdd->dev->adev, prange, 
>>>>> offset, npages,
>>>>> -                      hmm_pfns, gpuidx);
>>>>> +                      hmm_pfns, gpuidx, page);
>>>>>           if (r)
>>>>>               break;
>>>>>       }
>>>>>   +    kvfree(page);
>>>>>       return r;
>>>>>   }
>>>>>   @@ -347,6 +358,7 @@ svm_range *svm_range_new(struct 
>>>>> svm_range_list *svms, uint64_t start,
>>>>>       INIT_LIST_HEAD(&prange->child_list);
>>>>>       atomic_set(&prange->invalid, 0);
>>>>>       prange->validate_timestamp = 0;
>>>>> +    prange->vram_pages = 0;
>>>>>       mutex_init(&prange->migrate_mutex);
>>>>>       mutex_init(&prange->lock);
>>>>>   @@ -393,6 +405,8 @@ static void svm_range_bo_release(struct kref 
>>>>> *kref)
>>>>>                prange->start, prange->last);
>>>>>           mutex_lock(&prange->lock);
>>>>>           prange->svm_bo = NULL;
>>>>> +        /* prange does not hold vram page now */
>>>>> +        prange->actual_loc = 0;
>>>>
>>>> If you need this here, something probably went wrong elsewhere. 
>>>> Before we release the BO, we should have migrated everything to 
>>>> system memory, and actual_loc should already be 0. If anything, I'd 
>>>> add a WARN_ON(prange->actual_loc) here.
>>>>
>>> Will replace by WARN_ON as mentioned before.
>>>>
>>>>> mutex_unlock(&prange->lock);
>>>>>             spin_lock(&svm_bo->list_lock);
>>>>> @@ -966,6 +980,11 @@ svm_range_split_nodes(struct svm_range *new, 
>>>>> struct svm_range *old,
>>>>>       new->svm_bo = svm_range_bo_ref(old->svm_bo);
>>>>>       new->ttm_res = old->ttm_res;
>>>>>   +    /* set new's vram_pages as old range's now, the acurate 
>>>>> vram_pages
>>>>> +     * will be updated during mapping
>>>>> +     */
>>>>> +    new->vram_pages = min(old->vram_pages, new->npages);
>>>>> +
>>>>>       spin_lock(&new->svm_bo->list_lock);
>>>>>       list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>>>>>       spin_unlock(&new->svm_bo->list_lock);
>>>>> @@ -1610,6 +1629,7 @@ static int svm_range_validate_and_map(struct 
>>>>> mm_struct *mm,
>>>>>       struct svm_validate_context *ctx;
>>>>>       unsigned long start, end, addr;
>>>>>       struct kfd_process *p;
>>>>> +    uint64_t vram_pages;
>>>>>       void *owner;
>>>>>       int32_t idx;
>>>>>       int r = 0;
>>>>> @@ -1678,11 +1698,13 @@ static int 
>>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>>           }
>>>>>       }
>>>>>   +    vram_pages = 0;
>>>>>       start = prange->start << PAGE_SHIFT;
>>>>>       end = (prange->last + 1) << PAGE_SHIFT;
>>>>>       for (addr = start; addr < end && !r; ) {
>>>>>           struct hmm_range *hmm_range;
>>>>>           struct vm_area_struct *vma;
>>>>> +        uint64_t vram_pages_vma;
>>>>>           unsigned long next;
>>>>>           unsigned long offset;
>>>>>           unsigned long npages;
>>>>> @@ -1711,12 +1733,14 @@ static int 
>>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>>             offset = (addr - start) >> PAGE_SHIFT;
>>>>>           r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>>>>> -                      hmm_range->hmm_pfns);
>>>>> +                      hmm_range->hmm_pfns, &vram_pages_vma);
>>>>>           if (r) {
>>>>>               pr_debug("failed %d to dma map range\n", r);
>>>>>               goto unreserve_out;
>>>>>           }
>>>>>   +        vram_pages += vram_pages_vma;
>>>>> +
>>>>>           svm_range_lock(prange);
>>>>>           if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
>>>>>               pr_debug("hmm update the range, need validate 
>>>>> again\n");
>>>>> @@ -1738,8 +1762,20 @@ static int 
>>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>>           addr = next;
>>>>>       }
>>>>>   -    if (addr == end)
>>>>> +    if (addr == end) {
>>>>>           prange->mapped_to_gpu = true;
>>>>> +        prange->vram_pages = vram_pages;
>>>>> +
>>>>> +        /* if pragne does not include any vram page and it
>>>>
>>>> Typo: prange
>>>>
>>> ok.
>>>>
>>>>> +         * has not released svm_bo drop its svm_bo reference
>>>>> +         */
>>>>> +        if (!vram_pages && prange->ttm_res) {
>>>>> +            svm_range_vram_node_free(prange);
>>>>> +            mutex_lock(&prange->lock);
>>>>
>>>> Is this lock really needed.
>>>>
>>> same as before, will remove mutex_lock/unlock(&prange->lock) as it 
>>> seems overprotected.
>>>>
>>>>> +            prange->actual_loc = 0;
>>>>> +            mutex_unlock(&prange->lock);
>>>>> +        }
>>>>> +    }
>>>>>     unreserve_out:
>>>>>       svm_range_unreserve_bos(ctx);
>>>>> @@ -1996,6 +2032,7 @@ static struct svm_range 
>>>>> *svm_range_clone(struct svm_range *old)
>>>>>       new->actual_loc = old->actual_loc;
>>>>>       new->granularity = old->granularity;
>>>>>       new->mapped_to_gpu = old->mapped_to_gpu;
>>>>> +    new->vram_pages = old->vram_pages;
>>>>>       bitmap_copy(new->bitmap_access, old->bitmap_access, 
>>>>> MAX_GPU_INSTANCE);
>>>>>       bitmap_copy(new->bitmap_aip, old->bitmap_aip, 
>>>>> MAX_GPU_INSTANCE);
>>>>>   @@ -2903,6 +2940,7 @@ svm_range_restore_pages(struct 
>>>>> amdgpu_device *adev, unsigned int pasid,
>>>>>               uint32_t vmid, uint32_t node_id,
>>>>>               uint64_t addr, bool write_fault)
>>>>>   {
>>>>> +    unsigned long start, last, size;
>>>>>       struct mm_struct *mm = NULL;
>>>>>       struct svm_range_list *svms;
>>>>>       struct svm_range *prange;
>>>>> @@ -3038,32 +3076,38 @@ svm_range_restore_pages(struct 
>>>>> amdgpu_device *adev, unsigned int pasid,
>>>>>       kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>>>>>                          write_fault, timestamp);
>>>>>   -    if (prange->actual_loc != best_loc) {
>>>>> +    if (prange->actual_loc != 0 || best_loc != 0) {
>>>>>           migration = true;
>>>>> +        /* Align migration range start and size to granularity 
>>>>> size */
>>>>> +        size = 1UL << prange->granularity;
>>>>> +        start = ALIGN_DOWN(addr, size);
>>>>> +        last = ALIGN(addr + 1, size) - 1;
>>>>> +
>>>>> +        start = (start >= prange->start) ? start : prange->start;
>>>>> +        last = (last <= prange->last) ? last : prange->last;
>>>>
>>>> Similar to the simplification I recommended in svm_migrate_to_ram, 
>>>> this could be:
>>>>
>>>>     start = max(ALIGN_DOWN(addr, size), prange->start);
>>>>     last = min(ALIGN(addr + 1, size) - 1, prange->last);
>>>>
>>> ok, overlooked last time.
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>> +
>>>>>           if (best_loc) {
>>>>> -            r = svm_migrate_to_vram(prange, best_loc, mm,
>>>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>>>> +            r = svm_migrate_to_vram(prange, best_loc, start, last,
>>>>> +                    mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>>>>               if (r) {
>>>>>                   pr_debug("svm_migrate_to_vram failed (%d) at 
>>>>> %llx, falling back to system memory\n",
>>>>>                        r, addr);
>>>>>                   /* Fallback to system memory if migration to
>>>>>                    * VRAM failed
>>>>>                    */
>>>>> -                if (prange->actual_loc)
>>>>> -                    r = svm_migrate_vram_to_ram(prange, mm,
>>>>> -                       KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>>>> -                       NULL);
>>>>> +                if (prange->actual_loc && prange->actual_loc != 
>>>>> best_loc)
>>>>> +                    r = svm_migrate_vram_to_ram(prange, mm, 
>>>>> start, last,
>>>>> + KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>>>                   else
>>>>>                       r = 0;
>>>>>               }
>>>>>           } else {
>>>>> -            r = svm_migrate_vram_to_ram(prange, mm,
>>>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>>>> -                    NULL);
>>>>> +            r = svm_migrate_vram_to_ram(prange, mm, start, last,
>>>>> +                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>>>           }
>>>>>           if (r) {
>>>>>               pr_debug("failed %d to migrate svms %p [0x%lx 
>>>>> 0x%lx]\n",
>>>>> -                 r, svms, prange->start, prange->last);
>>>>> +                r, svms, start, last);
>>>>>               goto out_unlock_range;
>>>>>           }
>>>>>       }
>>>>> @@ -3417,18 +3461,24 @@ svm_range_trigger_migration(struct 
>>>>> mm_struct *mm, struct svm_range *prange,
>>>>>       *migrated = false;
>>>>>       best_loc = svm_range_best_prefetch_location(prange);
>>>>>   -    if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
>>>>> -        best_loc == prange->actual_loc)
>>>>> +    /* when best_loc is a gpu node and same as prange->actual_loc
>>>>> +     * we still need do migration as prange->actual_loc !=0 does
>>>>> +     * not mean all pages in prange are vram. hmm migrate will pick
>>>>> +     * up right pages during migration.
>>>>> +     */
>>>>> +    if ((best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED) ||
>>>>> +        (best_loc == 0 && prange->actual_loc == 0))
>>>>>           return 0;
>>>>>         if (!best_loc) {
>>>>> -        r = svm_migrate_vram_to_ram(prange, mm,
>>>>> +        r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>>>>> prange->last,
>>>>>                       KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>>>>>           *migrated = !r;
>>>>>           return r;
>>>>>       }
>>>>>   -    r = svm_migrate_to_vram(prange, best_loc, mm, 
>>>>> KFD_MIGRATE_TRIGGER_PREFETCH);
>>>>> +    r = svm_migrate_to_vram(prange, best_loc, prange->start, 
>>>>> prange->last,
>>>>> +                    mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>>>>>       *migrated = !r;
>>>>>         return r;
>>>>> @@ -3483,7 +3533,11 @@ static void 
>>>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>>>             mutex_lock(&prange->migrate_mutex);
>>>>>           do {
>>>>> +            /* migrate all vram pages in this prange to sys ram
>>>>> +             * after that prange->actual_loc should be zero
>>>>> +             */
>>>>>               r = svm_migrate_vram_to_ram(prange, mm,
>>>>> +                    prange->start, prange->last,
>>>>>                       KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>>>>>           } while (!r && prange->actual_loc && --retries);
>>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>> index 5fd958a97a28..8574cc5eeabd 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>> @@ -78,6 +78,7 @@ struct svm_work_list_item {
>>>>>    * @update_list:link list node used to add to update_list
>>>>>    * @mapping:    bo_va mapping structure to create and update GPU 
>>>>> page table
>>>>>    * @npages:     number of pages
>>>>> + * @vram_pages: vram pages number in this svm_range
>>>>>    * @dma_addr:   dma mapping address on each GPU for system 
>>>>> memory physical page
>>>>>    * @ttm_res:    vram ttm resource map
>>>>>    * @offset:     range start offset within mm_nodes
>>>>> @@ -88,7 +89,9 @@ struct svm_work_list_item {
>>>>>    * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
>>>>>    * @perferred_loc: perferred location, 0 for CPU, or GPU id
>>>>>    * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
>>>>> - * @actual_loc: the actual location, 0 for CPU, or GPU id
>>>>> + * @actual_loc: this svm_range location. 0: all pages are from 
>>>>> sys ram;
>>>>> + *              GPU id: this svm_range may include vram pages 
>>>>> from GPU with
>>>>> + *              id actual_loc.
>>>>>    * @granularity:migration granularity, log2 num pages
>>>>>    * @invalid:    not 0 means cpu page table is invalidated
>>>>>    * @validate_timestamp: system timestamp when range is validated
>>>>> @@ -112,6 +115,7 @@ struct svm_range {
>>>>>       struct list_head        list;
>>>>>       struct list_head        update_list;
>>>>>       uint64_t            npages;
>>>>> +    uint64_t            vram_pages;
>>>>>       dma_addr_t            *dma_addr[MAX_GPU_INSTANCE];
>>>>>       struct ttm_resource        *ttm_res;
>>>>>       uint64_t            offset;
