Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C94DEE4996
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 13:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D1A410E36D;
	Tue, 22 Aug 2023 13:50:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDDA10E36C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 13:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4gMtDnNsHWrp6ad1o+6HIYvByLdFwepWnKD/H3KcHcH1UEPt1i3rDE9JyOPaBCg8OnInUTTtW60mhlU9fN4wH7v/yhcLPq2LQ3/zzTlTIaHnOPqidyGRbtJFLfbqvlI8L0/bKCtSZPTuZC/jagBQ7YI6nFgDqat4ScgdutQ/ieGwOdc1qwnFuyZLBketJiUu+lf1fcKXqIeHiUSWLe6KQse1fyim6t/zzo9tJllpiaK5PVtY6j3AMctp/CcdghpFGj6sOlq9SrMf5aMmg3SpTc9u1snkHkDR4iZ/58A89IwkvW+m/y4vvjlIw8TPrfPSKOO8Vh1Ti/5Ptt8vbo/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsyFe7RxIfS3ZtZychC/cl/knQxtz8AuPneqAP2iM7A=;
 b=HssQARred1hkWEgPXkWl4InpLTBy0Vr4pwOM1dQtzKZqI1VQlJW73bqBWCW+qwZBA/GPzbsJPE9sX07cDTKiXTRkQMWZ5Wjw13KoyrErfAhM7PdPiiL6CFV7NzJD6/DLA+UEh+WA4dQEQ8RidLy08rwIypsJ7BcbkJbX2m+R1gOxhcVO0Ao/pT6/qsJ+jNf4mkO7CHQVDbiWo1d7idunNe1iVGExjy4utZxIIiHbMgreFeNqCinu0qOOuEVGk5Dct8KvZOzRLCmtDPDaOg/EoHWyVxahz1zjvMZ+4ehoU6w7gFqTxUZP1wmvukJIvSW+lbwGzgEzimkeijNRPhhqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsyFe7RxIfS3ZtZychC/cl/knQxtz8AuPneqAP2iM7A=;
 b=yNi8TAOIu0YFjbvYdr0+4ioJl3i8FXqKBSyQd2EayySJwzLOSaDAOU7jvwUEb5m4n+YzH9yFV1EaiX4VO3eAg2v6SRzrStbTJ5s5HXc89twmlGCaj+Imn8dtZyd9UvTUT3YhfP11AQGGR+DW74COQFUL/wYbc7M8lhQHveGmWMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 22 Aug
 2023 13:50:01 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::c103:6f7d:4125:970a]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::c103:6f7d:4125:970a%5]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 13:49:56 +0000
Message-ID: <d3321aac-0f92-de01-a576-6fe71d709666@amd.com>
Date: Tue, 22 Aug 2023 09:49:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: Rework memory limits to allow big allocations
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230821192001.12370-1-rajneesh.bhardwaj@amd.com>
 <60f44d5f-bb03-379d-992d-1b7715e6e685@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <60f44d5f-bb03-379d-992d-1b7715e6e685@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0284.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::23) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 907404e4-b26a-4959-b290-08dba316ab2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qAOhPFy5LlbeVvxaMk5pabKDtw+t8xkPE2MCaBDEEkJgelCmoTQv/L6YJsdHNcHtPlkKVb5C7MTXCNBPok8Wf/J4hVC8Toy/iARxH1C5dvDo30vSfWIinxgMW5Y0MQe7fo6AzfIiXPppFmmr7QkePUKx58lCpV6MEpddWQdlNKDAZnX19VuaER6H8bD9DbOji8B267RXcrY1cnmKhd3ZjkW46tiUH4ZvXeO5fgWkQsKSt1rMTHwGSYBFH5f9jK51sUAc2EzrG4YlENeA1queHqDkyCIgMiNxM87LEaxtIVZviuxhYi75K5AgLsyNNjNc9YrY+EnMTJg55e2LYKPBqrqEyG9LXUDQ8MQKfKnwceb5vuGlv9bI1GDPwM0lH5VxtOUAx0quRTHnAZ7sbHgLkh1mp9EcZxdJ53WwEq/37WOZPdf2x5Uovf7CC/7X9qWK3FcGeDklwCLTeOVuf6MrMtBXST7rHDMBY9NNBanw+JY1BOM0YnWsLZFyBWHx2cSsuV9e2aAMDGtWo6WT1/wlbmEU5lh1awmrgudIMQBiqww7wAmADCKhIgtFoMqx1AXERPwjI1C3jto7UvmROpT7M1sDwxrAGqzHahEFWreghRzB+o25NYa3ysL9ZSsdf1Eg9go34V1m3tYvA9n41U+NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199024)(186009)(1800799009)(31686004)(478600001)(6486002)(6666004)(83380400001)(38100700002)(2906002)(26005)(6506007)(2616005)(6512007)(53546011)(36756003)(31696002)(86362001)(66556008)(66476007)(316002)(8676002)(66946007)(41300700001)(8936002)(4326008)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmdmMGd3UHdISDNVQURxYjZWVVB5L0thREhYMTNhaThuak9yS09sWEhaUnJT?=
 =?utf-8?B?WERFUEM4eFFsWlpzZTNIczk2YUtsT0VTRlJ3MmxOMy9RMXExUVRiaExFR2hZ?=
 =?utf-8?B?dUZPeXRjbW03VnZGRXY3ZGxxTEJyRkc1RzY4RFJPWWM3aTBBTm41NUtRYzhR?=
 =?utf-8?B?UjNKeDNkVVg5M2lSbVRUU2YwYmtxSUJSMzl2ZWdtK3JPczNoY1lqMk5uRS9u?=
 =?utf-8?B?MHJpY1F0alIxWlRYRlpWZ3hCTVJJYkNjaTNlR1dJdnFqcENnaTE0VFptbDR5?=
 =?utf-8?B?S3NQbzVYdnRJSnc3QjAybEhMT3g5NVdaaTQybENNNFpxOFZhUWEzTTdyZ1Zh?=
 =?utf-8?B?N0wwWmhTckhlY3YzdFJiV3RscVBuTGtWd2pCWGVvVklrRVJXakpDRGJhM0F2?=
 =?utf-8?B?NE9xNUhHQ2dTUVVPK1ZsNU9TSmd1Q3FkSWtZUkF1c0VNK2wwQVMramIyaXND?=
 =?utf-8?B?bnlUTEcvZnhGUnpzL3MrSUJpNWZPUXNDRzFTbjBoOGpNazBERFNBRUNaK1Zj?=
 =?utf-8?B?RTFrRkRUczRNM2FvUlFYNVNTNFZCQTh1R2VqbjhMNDBmYjQ0QTBWLzhGYk5a?=
 =?utf-8?B?MTFUWWNsdWErZjkyT1B6RERhOUF5TVNDSWllMUhMOGV1cUp0ejJWYTBhRitR?=
 =?utf-8?B?MTNSejRlSzVqZFBiOXJvTkp3bVRyaFRQazVWYWtzNVZqZXkwbHlGWVlwKzNO?=
 =?utf-8?B?QzN1akkydkNqZzRoVVpLbWVaVWlNVjhmTmdsWmVIWmdKeXI5aEVQOGJ3cE5W?=
 =?utf-8?B?TG5oTUN2Y3lHNjhrWmtlQkZ3WmVxMTJQekYzaFRBNEZiSnhqcUM3YWwwYmtW?=
 =?utf-8?B?QVhicHpYSmN1eFg5OEtTOXZwZTRHZDlrZHdPN3ZoWVhHb2lZN1k0K0YvRXZy?=
 =?utf-8?B?NkJhSHdxVnJ4Y1d2K2lkYkxReCswTkpLbGhXQU5WL2o1NGNyZG9nV3dyZ0Nk?=
 =?utf-8?B?eUlKdmQyYmxrSHBzZWQ0eDVlZ1BramdaN2ZIUHNhOC9NUGZhUkdSUWpCVHBZ?=
 =?utf-8?B?TFFlYUh1WDVZbUk2NlVGWHVjUUdaemRhZUd4S1ByZ0haRmk3bGg1SzF5OG11?=
 =?utf-8?B?TmFEMnFyOCtmN0JNanVVWWFnZ056V0EwK09hbkhSTGMxdUZZSEdDM21wN0lY?=
 =?utf-8?B?SExTclo1eWxhckI1T0dPVGh6ZGtLbVUwZW5oZHQxbk9WSGJKRTZGUWYrL2pI?=
 =?utf-8?B?RHlIV2N1d21sSHM2NEJDQjhkTXF0ZnpGMW0wcWkvZU5BV3h2cm1mV09KcHVj?=
 =?utf-8?B?OVBGeFV2QXFvbk42d2FmZkZiUGRBY0dOS2RBeFErbHNjN1RuZlBLbUxlNDly?=
 =?utf-8?B?cThQTmNJeURMODltQkdiZGEzUmw4a2NES3B6U2xFWS9EeVBrY3NlY0NhOFJM?=
 =?utf-8?B?QW8xeGs1cjhFUGhXcCtscnh2KzI5R2hPOTQybkM0TzNxTy94ckxWL1RYZ1BK?=
 =?utf-8?B?UldIWFVMT0huTmxpUS8yZE4xMUNBK09sOHNabnhjMnk1cjluNW45NCttYjY4?=
 =?utf-8?B?Nzd6VEJLSHlTS1IrTkpRYjVCUHVkaHdOUVN2ekcwcGJCcVkyTVk5Nk9SbG9B?=
 =?utf-8?B?NFRlUVIyRnhiRnpJL2lZTFpYbUdoWEZpTkxVRGp6eCsvRTRuOExhYWFEVHZX?=
 =?utf-8?B?OXByWk9qOHdmT252ZE1KT2Rpa1l0ZGF6ZGVVMjRsdkU5QzJyM0MzUzR1eVJv?=
 =?utf-8?B?SEcwVndIWXlmNGd2NGlTbzNaY1hSK1V4a3Fmc01SNXFBc3pYSThSRmVMZlQ3?=
 =?utf-8?B?SVd2Q0Uybld2NWsxY2RqODVlY2VqdkVMbFMxaHpBc213eVRZNkNLaXhpTTZn?=
 =?utf-8?B?d2thSE1adXhiRTFDVjlXNVVZU1o5cXgrY0dXU0Z2eDFNTE94ZDNKcENGUTJL?=
 =?utf-8?B?ZWJYSjJ2YzUxR0M3ckdKVjF4WW1EeThQMGFGYlBQeWtyd21KZUhnOHR2VGt0?=
 =?utf-8?B?RnIyblc3RC9YaDZObnpGMHFmZklmcnF5eTB2aG1Kcndwa2E5OXFtaVBIMEZC?=
 =?utf-8?B?cGRodTVHMm9SUlMxS0VyMXpoMnNWNXdJVExQc1YwNUJoSk5ISWJmNjd5QWR1?=
 =?utf-8?B?dmVQSXBhbUozdzNDVG1WSW9rUTg4RWlYNGE0cVU0UzR5NEpUQTJCMFJlT3dY?=
 =?utf-8?Q?5k7iAWwcX9LoP0n+aAn0/4rcx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907404e4-b26a-4959-b290-08dba316ab2f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 13:49:56.1494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShHMKUKjXXU5Ofc1McMtH5rc2/DqI763thM+nNd7MKfI40GsU74iGlar5qP35bQZeu+qWKoAbHH27Do7AGQzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/21/2023 4:32 PM, Felix Kuehling wrote:
>
> On 2023-08-21 15:20, Rajneesh Bhardwaj wrote:
>> Rework the KFD max system memory and ttm limit to allow bigger
>> system memory allocations upto 63/64 of the available memory which is
>> controlled by ttm module params pages_limit and page_pool_size. Also for
>> NPS1 mode, report the max ttm limit as the available VRAM size. For max
>> system memory limit, leave 1GB exclusively outside ROCm allocations i.e.
>> on 16GB system, >14 GB can be used by ROCm still leaving some memory for
>> other system applications and on 128GB systems (e.g. GFXIP 9.4.3 APU in
>> NPS1 mode) nearly >120GB can be used by ROCm.
>>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  5 ++--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 25 +++++++++++++------
>>   2 files changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 9e18fe5eb190..3387dcdf1bc9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -44,6 +44,7 @@
>>    * changes to accumulate
>>    */
>>   #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
>> +#define ONE_GB            (1UL << 30)
>>     /*
>>    * Align VRAM availability to 2MB to avoid fragmentation caused by 
>> 4K allocations in the tail 2MB
>> @@ -117,11 +118,11 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>           return;
>>         si_meminfo(&si);
>> -    mem = si.freeram - si.freehigh;
>> +    mem = si.totalram - si.totalhigh;
>>       mem *= si.mem_unit;
>>         spin_lock_init(&kfd_mem_limit.mem_limit_lock);
>> -    kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
>> +    kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6) - (ONE_GB);
>
> I believe this is an OK heuristic for large systems and medium-sized 
> systems. But it produces a negative number or an underflow for systems 
> with very small system memory (about 1.1GB).  It's not practical to 
> run ROCm on such a small system, but the code at least needs to be 
> robust here and produce something meaningful. E.g.


Sure, I agree.

>
>     kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6);
>     if (kfd_mem_limit.max_system_mem_limit < 2 * ONE_GB)
>         kfd_mem_limit.max_system_mem_limit <<= 1;
>     else
>         kfd_mem_limit.max_system_mem_limit -= ONE_GB;
>
> Since this change affects all GPUs and the change below is specific to 
> GFXv9.4.3 APUs, I'd separate this into two patches.


Ok, will split into two changes.

>
>
>>       kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() << 
>> PAGE_SHIFT;
>>       pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>>           (kfd_mem_limit.max_system_mem_limit >> 20),
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 8447fcada8bb..4962e35df617 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/pci.h>
>>     #include <drm/drm_cache.h>
>> +#include <drm/ttm/ttm_tt.h>
>>     #include "amdgpu.h"
>>   #include "gmc_v9_0.h"
>> @@ -1877,6 +1878,7 @@ static void
>>   gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
>>                     struct amdgpu_mem_partition_info *mem_ranges)
>>   {
>> +    uint64_t max_ttm_size = ttm_tt_pages_limit() << PAGE_SHIFT;
>>       int num_ranges = 0, ret, mem_groups;
>>       struct amdgpu_numa_info numa_info;
>>       int node_ids[MAX_MEM_RANGES];
>> @@ -1913,8 +1915,17 @@ gmc_v9_0_init_acpi_mem_ranges(struct 
>> amdgpu_device *adev,
>>         /* If there is only partition, don't use entire size */
>>       if (adev->gmc.num_mem_partitions == 1) {
>> -        mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
>> -        do_div(mem_ranges[0].size, mem_groups);
>> +        if (max_ttm_size > mem_ranges[0].size || max_ttm_size <= 0) {
>
> This gives some weird dis-continuous behaviour. For max_ttm_size > 
> mem_ranges[0].size it gives you 3/4. For max_ttm_size == 
> mem_ranges[0].size it gives you all the memory.
>
> Also, why is this only applied for num_mem_partitions == 1? The TTM 
> limit also applies when there are more memory partitions. Would it 
> make more sense to always evenly divide the ttm_tt_pages_limit between 
> all the memory partitions? And cap the size at the NUMA node size. I 
> think that would eliminate special cases for different 
> memory-partition configs and give you sensible behaviour in all cases.


I think TTM doesn't check what values are being passed to pages_limt or 
page_pool_size so when the user passes an arbitrary number here, I 
wanted to retain the default behavior for NPS1 mode i.e. 3/4th of the 
available NUMA memory should be reported as VRAM. Also for >NPS1 mode, 
the partition size is already proportionately divided i.e in TPX/NPS4 
mode, we have 1/4th NUMA memory visible as VRAM but KFD limits will be 
already bigger than that and we will be capped by VRAM size so this 
change was only for NPS1 mode where the memory ranges are limited by 
NUMA_NO_NODE special condition.

>
> Regards,
>   Felix
>
>
>> +            /* Report VRAM as 3/4th of available numa memory */
>> +            mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
>> +            do_div(mem_ranges[0].size, mem_groups);
>> +        } else {
>> +            /* Report VRAM as set by ttm.pages_limit or default ttm
>> +             * limit which is 1/2 of system memory
>> +             */
>> +            mem_ranges[0].size = max_ttm_size;
>> +        }
>> +        pr_debug("NPS1 mode, setting VRAM size = %llu\n", 
>> mem_ranges[0].size);
>>       }
>>   }
>>   @@ -2159,6 +2170,11 @@ static int gmc_v9_0_sw_init(void *handle)
>>         amdgpu_gmc_get_vbios_allocations(adev);
>>   +    /* Memory manager */
>> +    r = amdgpu_bo_init(adev);
>> +    if (r)
>> +        return r;
>> +
>>   #ifdef HAVE_ACPI_DEV_GET_FIRST_MATCH_DEV
>>       if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
>>           r = gmc_v9_0_init_mem_ranges(adev);
>> @@ -2167,11 +2183,6 @@ static int gmc_v9_0_sw_init(void *handle)
>>       }
>>   #endif
>>   -    /* Memory manager */
>> -    r = amdgpu_bo_init(adev);
>> -    if (r)
>> -        return r;
>> -
>>       r = gmc_v9_0_gart_init(adev);
>>       if (r)
>>           return r;
