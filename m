Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093FBE776C4
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 18:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DEE10E310;
	Tue,  3 Oct 2023 18:56:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5777A10E30F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 18:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+S44eRqd2swSh58QMnp64lXjcd3kYyagnUAZe2m7HYcxeql+Rq/uYMn7qKt70+aXNhJFdV3STDuREPcr7ML2/+tLhcTV1c8dEhP/h02Be1IP/DyNqw+tPGm06asE48HtvkGydp6ZNPb31RwAe86o1wbE1OwfL7wtRCdyCEHhl0UjUqYvhIDXXAM04VgRNRliVu8FQXLxoeaHUpbXAxlI4e7j9WlJj0vvl+ds+FZWaPJUaO3+LR4WoMPn3LnYi3AD+H6pqkObTeinGDOu5fkFjCp0Q6mC8V+c1A6ZaHGhCSrmfjbZ7wXwyXdDXsrSrJVxIeEKdDNR111axXf4TwJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foaRWm4siVS6EkGwiVA5SI7xJ6vwlrEfZsTXcavEfoQ=;
 b=SY+ApPglTZ5I1G1HzI3l6h2Y0QG3EoY2J93VtL9XXQWO+k2ryDx2scfFfm9Umw1k93pRuj68Se24Vc9OlDOHR/bkDBBYRDs98vytcvFKTn33XgjYGIxXvsjcKlPpqlOBbo7LdIk9TnpvaxrhMpaQjtuiF8bxOi8GbV6CX0YzWLE0uY+AhesJSXnBjRt0riaWpUKXcOsW4nQYBG65Orv6KOzYg4v2M9swGBI9wTO1+s+XDDQvq7VEWBjgYi3Ek/iyEdI0vlgBOBLAlGEF29g9ICH9unB3iEfpc6ykBHwQCywVNkW6uvtyg1jiJ3IjnP/GJYSnXNp0/DicswRv1b9Mhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foaRWm4siVS6EkGwiVA5SI7xJ6vwlrEfZsTXcavEfoQ=;
 b=4HsrBXtEQC2TwWg2xTuJ5QahI8jZwSrshHubOa+44OJ/FpNJ/ovo0nc8CGBWtDSqfCg4707nKxzwC0pI7Ap9AX+ZpFekRFTR74kNILHi0m/GcJHYXYUVEoXawI/5Xi+cqU5e+6mUIkBr2gKsncg4Y4ccpOE4oJnFwlZ9d1CgQ84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 DM4PR12MB5085.namprd12.prod.outlook.com (2603:10b6:5:388::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Tue, 3 Oct 2023 18:56:00 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::d192:af9a:25fc:4945]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::d192:af9a:25fc:4945%7]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 18:56:00 +0000
Message-ID: <337079e2-ac4d-8ce6-13bb-7c3256dfcd31@amd.com>
Date: Tue, 3 Oct 2023 14:55:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [Patch v2 2/2] drm/amdgpu: Use ttm_pages_limit to override vram
 reporting
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231002202117.2690645-1-rajneesh.bhardwaj@amd.com>
 <20231002202117.2690645-2-rajneesh.bhardwaj@amd.com>
 <1c199b0a-451c-be81-a0b1-b7bc144c40ce@amd.com>
Content-Language: en-US
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <1c199b0a-451c-be81-a0b1-b7bc144c40ce@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::7) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|DM4PR12MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d92ef3-71cd-4ff1-ce70-08dbc4426228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFHBI33UxFfjENF4DJV5t21NGaHV3gU6z+4l9Oua32ZEQ7vO7j+SpMvoymW0rSIF5zjV8A9VCUvI5QWKTNxv+o1S/vvH8+tGQfHbuqbYl8eJPIyv3NChdWcrZiZVYAFzvT9Uw1W5iQrI/jY8n8JOq4KUOjxD4BePj4O/5eFON52obfUqyakWPa7ICMJB7td4p6iyErQ++qwkSychk0GeCisYIXd+fOpXJdDMjjFi5r7BYMRnuyNF9UPgitZ7K/y9x9C7rblX7ReBIGh/3EK3PTOZeDhAJ9LgZGANLbU503LCxpHJGWda8aIu3NJ8vhFj4jZ0kOeeWNIhAeSiXka9/t/do6Mv+ry1ow5TSHdKFDf2fK9y7VRr9E5IMFIUSsZIkfMV6DGFbgfljElAFhAPp9i/Zejq48VLQihXeOmHu2Vx3jKK9PKWoqlEX2yeVkfZL12fAEg6+FKiYOIdRWERCdPvM1FoXladsjbMDo9FydFxGi9zoYpBOgLqfkqZDpzcY/D3ZAZYA4ixrt/WPkaCYcnGkukBj8b3TV6rY5t0HA3OoHdYOi2PcHE1rmUCmYLF2jTJJ7DRZPgEGODr1HRWpe2j9JqLS1ELOnakfzhGaf4VTA7e/59KWtsNW5P0UXtvPttTKc0N81ZynR0MGklUgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(41300700001)(6486002)(2616005)(6506007)(6512007)(66946007)(66556008)(66476007)(316002)(8676002)(4326008)(8936002)(26005)(5660300002)(6666004)(478600001)(53546011)(31686004)(83380400001)(2906002)(36756003)(38100700002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk9Cb08wdG9GUVM1WFhva3hRMmR2TTd4T0xGN0ZqZ3hSeVYvVzZRbVNKU2F4?=
 =?utf-8?B?bzJwcFJyZGRaV2hHL3E4aHl4eGlYYnYwcDRCTjI2VmcwYVpWdWw4Qm1wdXJ0?=
 =?utf-8?B?NVFmWC9pcFJybXJ1UHQzN0pGMG5veENPNmI4SC95UjBvWEpkd3I2QnI5bVZ1?=
 =?utf-8?B?b2ozNTZpTlA2L1VEZ0VmRUczK0ZvZmRlOGpDWndkN0d0T29TNmVvSkJpR3pT?=
 =?utf-8?B?NWlXbE42R1hIbTNEemJUM09aMW5KS0l6OU1xOVJubUFvYjRrbWNpbDNhaDl0?=
 =?utf-8?B?SzNOSVE3ZUp1UUt6M2RBM1grclp0aDl4c1FPeGJvMUdUSU1HNnV1d2lGOTFW?=
 =?utf-8?B?a0NYQjN0QTh3bEtKSlZ0U3pwREtZeWJXNUpzekdTaGs4WEM4elBiSVRBVEs0?=
 =?utf-8?B?c291WWFVN01lcG11SFdiL0xpU2dVTFdITGtlUzAyQkk1KzRFWUJxTGova29p?=
 =?utf-8?B?QlZpTEhWbFViSEhRUnJUUjJuT1dLRVM1VWpFeE4wWHlmQWtzOWVRc3M3dFZa?=
 =?utf-8?B?OVppakZReXIwVDBQOXVLOGRjaWR2bkphNHYxS2NxaXVqS1hiektwamJyVUhT?=
 =?utf-8?B?TTJMcGRYTjhucUNQMG96WTRkemtwSzNSNVE1Wi9ZaGtLc2FsaTVYNU4vTVhl?=
 =?utf-8?B?WitUTERqa2xYcE5GNGlMSTZ5RGlwRVRmdDBZVGltajVuTWFmSGJGazZOZFZV?=
 =?utf-8?B?dVliRGJZRGdxQzZMa055T1VYUEVjTEVmR0JTRGdqb3pZYkcraG03SHFOaWhL?=
 =?utf-8?B?SmdVTlVOVFpZOE1MYm55NlVnL1l3WWh4K1FYYklXdG9Zc2V3cVMyUnBQNXFy?=
 =?utf-8?B?YU8xbVBFWk53akRVZy9pUnlGY2ludksrL0YwemMyRUdrUDA2UlpGTkFGT2t5?=
 =?utf-8?B?SXNNNE44VENFOEJqS1g2blJnUWRMSnNBYU1TcndkeGhRZ3lmb3h1aTFwTmFm?=
 =?utf-8?B?R05wM0oxbHdzZ1hCQkxnME9hU2lMUGhsb2R5b1MzNWdmOS8vS0NwMC9zMnBP?=
 =?utf-8?B?ODNxLzYvSmNQU1hiTkpQeFZ0U01XM2lFR3lmeXVsQ0JiQ1V3NFlxTTBqbGJq?=
 =?utf-8?B?Z1owdmtkUFh1bmRhYjV4WTVpQ1lFVVIyMHpkUkZOZnRWM1lsYmhpY29LdUpH?=
 =?utf-8?B?OW5MMzluOHNNdFFwT2RuZGVKQk5YSGdsTkM3RHNCN3Y5RDl1aXhOdmdkTmUz?=
 =?utf-8?B?OTExczlUWTZTUWZ0cVQrL1lnOUY0WkJKT2lUWHAyYzVuemR0Y3c2RXR1ek04?=
 =?utf-8?B?VWE3VXAvM2ZKc2xlMWwxOHFUUnZxbTRadmhvdTQ4UldNMjVUaGFCYVdqWFVN?=
 =?utf-8?B?aG5NUHgzM3hqZFFKWDFEM3ZNSjJaQzZ2K2s2eEtxTXU1Q2hVYW8rL0hxK3N1?=
 =?utf-8?B?MHJYN3NQOHQ4SEVPQ1NKc2FoV2QrMURiSlAyUGRVaUFIa3lhcHZBSXNuSW9X?=
 =?utf-8?B?VXVMWVVSUzl2N3RkZ2d3WUhlUnJqdENNNUFSdUdNVmZPRFZsYVF2dE0xK25J?=
 =?utf-8?B?RWw4OXpuVzU2U2VDd1d0QzIzbWx1di91YW45VXJORDVZM1F0Vm1Dcm1GSlMr?=
 =?utf-8?B?Z21MaGtjZUR0N1ZxQzNmTVRuWENqbVlYMlZPRWNDK3dYNUlISzd6emxYcm9X?=
 =?utf-8?B?V2lxZDZxOUlPZ3p4WnVGMXIxMU1sd1pJSzkyT2NjbUh5clVlYWJ5dFdHZ2l5?=
 =?utf-8?B?RDBmejQ1b3ZQS29oejV5cnNJV256UzBpdVNnd2RHMk9Ed3daaUFYMkE3VCtr?=
 =?utf-8?B?d3ltTDVoNDYvUk12UHlWeDF6czlXUEZpZDNtaWZ3eHNuWGhCTjNoU3Buc2RE?=
 =?utf-8?B?THBSalhQSE5EcktYdW12VHRmaFpoTElrQm1oaU5XK0hMclErcnhFdFk0VlRp?=
 =?utf-8?B?cG5tODI3Wjh3b0svTHVDV09UVi9LdWozd1AvUFpUUityVld2cFdLL0FLY2cx?=
 =?utf-8?B?UzRZQXpXVWRzNkhkdjAzVHRuN1FUMzh1aTBzc0N0U2VwVzVRL2lrUThyTXdY?=
 =?utf-8?B?TkZkcjNEY0hwY1E2VS9jenhiRVFsME5ZYXZpQUY1VklKWG9BMGtNemdDZkpj?=
 =?utf-8?B?WEtRaXNMeUw3eUlsQ0oyZmM1SzF4NFVybFJlczBDQTNJdkR3SkJoMW13a3pE?=
 =?utf-8?Q?lhFDF/PcYB8+lzLsTNZ3UBH7R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d92ef3-71cd-4ff1-ce70-08dbc4426228
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 18:55:59.8948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSCSHj/7iwubDSf1HvOuz062KQ6F77l727seSu3kl83z3EvoqCvkGLlxfJNTymErWkuXzGlXndoC4Ihl32vEoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5085
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
Cc: philip.yang@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/3/2023 2:07 PM, Felix Kuehling wrote:
>
> On 2023-10-02 16:21, Rajneesh Bhardwaj wrote:
>> On GFXIP9.4.3 APU, allow the memory reporting as per the ttm pages
>> limit in NPS1 mode.
>>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 17 ++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 +--------
>>   2 files changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 38b5457baded..131e150d8a93 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -28,6 +28,7 @@
>>   #include "amdgpu.h"
>>   #include "amdgpu_gfx.h"
>>   #include "amdgpu_dma_buf.h"
>> +#include <drm/ttm/ttm_tt.h>
>>   #include <linux/module.h>
>>   #include <linux/dma-buf.h>
>>   #include "amdgpu_xgmi.h"
>> @@ -806,10 +807,24 @@ void amdgpu_amdkfd_unlock_kfd(struct 
>> amdgpu_device *adev)
>>   u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int 
>> xcp_id)
>>   {
>>       u64 tmp;
>> +    int num_nodes;
>>       s8 mem_id = KFD_XCP_MEM_ID(adev, xcp_id);
>>         if (adev->gmc.num_mem_partitions && xcp_id >= 0 && mem_id >= 
>> 0) {
>> -        tmp = adev->gmc.mem_partitions[mem_id].size;
>> +        if (adev->gmc.is_app_apu && adev->gmc.num_mem_partitions == 
>> 1) {
>> +            num_nodes = num_online_nodes();
>> +            /* In NPS1 mode, we should restrict the vram reporting
>> +             * tied to the ttm_pages_limit which is 1/2 of the system
>> +             * memory. For other partition modes, the HBM is uniformly
>> +             * divided already per numa node reported. If user wants to
>> +             * go beyond the default ttm limit and maximize the ROCm
>> +             * allocations, they can go up to max ttm and sysmem 
>> limits.
>> +             */
>> +
>> +            tmp = (ttm_tt_pages_limit() << PAGE_SHIFT) / num_nodes;
>
> I don't know why you need a local variable for num_nodes. Just divide 
> by num_online_nodes(). Other than that, the series is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


Thanks for the review. I will amend this and push with your reviewed-by 
tag to amd-staging-drm-next.

>
>
>> +        } else {
>> +            tmp = adev->gmc.mem_partitions[mem_id].size;
>> +        }
>>           do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
>>           return ALIGN_DOWN(tmp, PAGE_SIZE);
>>       } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 268ee533e7c1..b090cd42f81f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1896,15 +1896,14 @@ static void
>>   gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
>>                     struct amdgpu_mem_partition_info *mem_ranges)
>>   {
>> -    int num_ranges = 0, ret, mem_groups;
>>       struct amdgpu_numa_info numa_info;
>>       int node_ids[MAX_MEM_RANGES];
>> +    int num_ranges = 0, ret;
>>       int num_xcc, xcc_id;
>>       uint32_t xcc_mask;
>>         num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>>       xcc_mask = (1U << num_xcc) - 1;
>> -    mem_groups = hweight32(adev->aid_mask);
>>         for_each_inst(xcc_id, xcc_mask)    {
>>           ret = amdgpu_acpi_get_mem_info(adev, xcc_id, &numa_info);
>> @@ -1929,12 +1928,6 @@ gmc_v9_0_init_acpi_mem_ranges(struct 
>> amdgpu_device *adev,
>>       }
>>         adev->gmc.num_mem_partitions = num_ranges;
>> -
>> -    /* If there is only partition, don't use entire size */
>> -    if (adev->gmc.num_mem_partitions == 1) {
>> -        mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
>> -        do_div(mem_ranges[0].size, mem_groups);
>> -    }
>>   }
>>     static void
