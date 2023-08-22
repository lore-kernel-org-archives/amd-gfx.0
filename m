Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841BFEE4996
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 14:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0693310E386;
	Tue, 22 Aug 2023 14:54:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED2410E386
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 14:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBQEunQAukkUzilitLOqBFJBpc/dIyLtkqade4mGB/+5Nhxl6IjTHpwan1SBTB1Y2BiXzZUgPJUz/gy8V/GbADFzcMtfnugTiVj7Tyj2YJivQiaJ33daSDrMaXAbBXlVq1jqXg9U7IA4/7s/WKimF5ckfWv0MZalzqmprKtZr9HDM8hhWjcGJHf1WF2fjqgENZCFXz5JxwrjvYNXjVa3GmsZlYJ9+toSvY8IlrGgEsiebP2XaidSmGGN3QRslUFXDPiG1pX4xkLzydmkqpyK7nfyzsMhOMiHDQl4ZF4Ouze6pOgltdmeK4Xas0ixG11SMiG7p3v7uFBrqVm0JJRhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMa/WbeHeWO4HS7L4nSsK25AGZfbVpW6qcnPGZ5zlc0=;
 b=Tr4NaECZoAxDtrJHFUORaf3vlBWmR/Wh0YCbZ27CbDThg3KlS9kO0zY/47rAz2uTDEvQR7ZfRQcjj8DgF/xKox34jnyM4ozk5qbC3v/3R1nQ7E+ql3sOKjdoSuAs6f5dZafVrPhcRiPNKZ0dJ7q5dypCiYNiLLeyMcKRfHaPwMio6Z53OHE1XrjUKQI5xYTZLxJ9tmHXkhwMXhva3VWRpcc0A/1A3+oy/26JDlHb0q1naRggQJSThid3k7ojplfo1B5jIJqZs+7iVNb0h+bLH6A4nt4cEaV9iPFQ270N0NhE+RcI5IHQ/sduS41LRvuFqBZ7pCY80lvZRtotBUSj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMa/WbeHeWO4HS7L4nSsK25AGZfbVpW6qcnPGZ5zlc0=;
 b=ow0Jz7/OagtmOdnrb5anmOr3h1R9zuTbC84cTSa05ypQnQoGvaFfWpjTcvQhawVhvdAwuZ016daEMlUs1SqnNnpCxHuxxmih9VORKRO8INA8R+HLmdo6cEoTQ28oz9knu/7cevSGd7YCPqhCLEbyWA3e5KK9vZjMC6b9YukF+uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 14:54:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:54:17 +0000
Message-ID: <ddf80f9a-eaf9-a1cb-9b16-18420e160ef5@amd.com>
Date: Tue, 22 Aug 2023 10:54:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] drm/amdgpu: Rework memory limits to allow big allocations
To: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230821192001.12370-1-rajneesh.bhardwaj@amd.com>
 <60f44d5f-bb03-379d-992d-1b7715e6e685@amd.com>
 <d3321aac-0f92-de01-a576-6fe71d709666@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <d3321aac-0f92-de01-a576-6fe71d709666@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fc8b48-2ef1-4937-f1f0-08dba31fa8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/X1KLuJE1McW9au1DXbWvBY3V/nM5cmcMmwa4yK925JlwNnwTUZUTaIbo/QltoD3Q3QGPEQR/v2x0P1lkxA5AJ3xv+NUqEXKvITn/gaWjlH/7lK6OWTzCq5TVJzdYaijSNDu+dqNVB8x+wIxB4mEAfHtWENcOVjDqHa/ksWB8BtXYoRlPipWYb4bqr5kyswt83XYcH89hoTPNuLqbdyE0skA+pXalc4XNJq4N7ahQzlT8H+Q3fwLNWVkD+T1Yd3MLK4sHxdihQ83FYLepbnBl4/tlXmUGHrakrW3mOZBhWYOiLoUY+JU7g7UUM5CDvHbSFm4//MvLhPVE5Y98GOt45FfW7vdPsduvJ3ilqniWhqTzjUUZIw+bz9IgXaOPt0QP0Yvw+PFNKrwn6yItWlESFogvc595t+W4zx193taiWoix2WKA/MM3t0j1VAZsDVJASUmfG4A7Yn9AfTTpM1RbuCEyaYHYJS3kPKKMOt6Lv3u/MPC4IzgL8SZ5XU8Jjw5sTCiz9TB5kAYp/5nj5OdiUM2jLVxlQDg0BiYNGtvLvRq4qcdEgi5IVCwz17tnbXPtWXVpNBn4RdLSqU12zZY97EwXMV3YTlwsNjt9Yliho4HnYNdEQJWO6ycPRRBCEDrutw+Way2nyJRybGlMPqMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6486002)(53546011)(6506007)(83380400001)(2906002)(31686004)(31696002)(86362001)(44832011)(5660300002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUpMeUE5MDkrdVRzL2RMOTJGV1JZUjVmalNsVW0yRU9INE4rSm43M3Aya0s5?=
 =?utf-8?B?MSt1d2orZzMrYTVzbWlPVXplVEVaejdHR2l1RTZmc0tGaHQxaE5OOXg2Wjdu?=
 =?utf-8?B?bXNURXdid2djK05EY3R2RUdqcis4OW5JTEZiOUt2UHY0c0VEcE0vdU1IK3RT?=
 =?utf-8?B?OFczZHFERHN2OUkvaUVOSlhMcWhoNlR0ZUp5a0NyRTR3aUZ5REtKb09oeEpt?=
 =?utf-8?B?L0VKQm1vZlJ0WnNQQzF5ZkdjckNWREdDWWFBZ1BYTUZrcTRQV0lhQWU2anR3?=
 =?utf-8?B?ZXJMZkRhdllIaGd5REMrdHdhVGhESXdwUDF4MkJna3JiRnhIeFlleG1lU1Rs?=
 =?utf-8?B?TXdnSDNIaENBaXRhQXQxMU8vV2tjdjFmQ2ZlbTlpNnd4N0h0UGo1alp5NnRj?=
 =?utf-8?B?eStHaExHbC9TdTdRSm1XV25XbXJTajRCQm9KaDV5VUZvMGdOQ0JXQnV2T3U0?=
 =?utf-8?B?clNuWVhWd0YwODNCTUlOQTNjVjkxSTdFZzM1NWN0VDA2cGx6MlI4T25aNTFa?=
 =?utf-8?B?bE5yMVJFL2hzMXRmOGpIaWt3VU5MQWdJZ1ZNWHRubW03bWMxeUo5VDhKQThl?=
 =?utf-8?B?S3NEQTBTcE5pdGNxblo1TFpNNzkyK0FMbFlZOHJkeXZ1bzRrcWlmVmNEajFD?=
 =?utf-8?B?SWduQU1Ma29Lcmx5RUEvOVI5OGRIMTdvZUlycUl6SlFaSDZ2QVVRajhGaHNv?=
 =?utf-8?B?WVFwczdLSGlzSWlWeERiTVhrZ3ZmUEhKdUJ5ZHdqd0dXWlJGcHI5Z0VMTXox?=
 =?utf-8?B?SUFpeklXdlN2SjZlOFBWRkxaK2NualRJNEYzeS9CMnJaekZFVmY3ZmlpbGVy?=
 =?utf-8?B?S1M1ZG5IU0haVFJTU1NWWUMreVVyYWM5d0NrZnoxb3NWSHhJY0dFbEdaSFBW?=
 =?utf-8?B?SDNxaDIwaFhDaHpvZkVtVGZCS2VaSW56bzNKUHBMOWpiYWtGOEtCa29OM1Zn?=
 =?utf-8?B?dWZLYmFmTU9kMUZRMGlOL2QzRkRqcmNMSFZvU0JrVk4vTGgybG40RGpLYkRZ?=
 =?utf-8?B?YUZRVlRGcW43eDQ4blFDRUdEdDU3cGIzbHd3WjZPSS80TTRmZGRRWTkwc2wr?=
 =?utf-8?B?bXM0Y01SKzRXVzh5ZXUra1NJNkU2Z0ZDcGNpMitBbm5YeGZiejVNTlcvUnkr?=
 =?utf-8?B?Ry9vcEZmaW5jU0dmOGlpb0dXLzBlRmdwNm1JVk9nUTRuSFNxM0NOQTdPdGxC?=
 =?utf-8?B?and0K2VpYnYvK2NTWjc4V3lDb0VYVVVFcFIyVG9KWThUNjYrWks1Q2lLVE9a?=
 =?utf-8?B?dkZSL2VURTZJQ3RnUXRFa3E4ekhOTFJEbS9FNm5PYWdyeFNML3RDVkJPVUdY?=
 =?utf-8?B?N2tVSFhmTksrMXFZQzVCRFRKOVpKR3E5STU4ZWxJc25qK3pWWHNFSkJGaTQ1?=
 =?utf-8?B?aGl3YTdPUWcrNUEvU05XSmowM3o0eFFSZjJ4M0xvRkdNZVVZYWtRRUkxSGZR?=
 =?utf-8?B?TjlkRTMvTUVlcmdVWk9nK0ZHTE4zZTExbDdYVVR4Q2VYbVZ6VGE3N2M1Uklu?=
 =?utf-8?B?MGN0cUwrSkg5di9SQ3krRkhselkxYWRjRWpueElwd1FoOXJWUU5CNmVIM0lH?=
 =?utf-8?B?S0tBZlhlUVJKdzE4YWN3cXc1SWVzckhpR0h4d1dJSEpFZDE1RWExU05mUUU4?=
 =?utf-8?B?bU8xdXhWcElGUDJkNkd4WlNKY1duVVlscXB0Rm9mQUY0SkhGUWtjY01QRlov?=
 =?utf-8?B?RVpCTzRCelUxYjBZRnhMSFV0ZDhtVm5BUklKSWVUK1dIM09GMmhvaDU5blRj?=
 =?utf-8?B?Q0xZTDFhV3NzaURUMFl2NjUvWTIvaHJTaFh3ck9hb0hMTzJaaGxkdENzazhY?=
 =?utf-8?B?TlczQmdtM1ZySW5oak04d0dvL3ZMZUoxSWJnSXpaN2VpRkZoekc5dm9pblRN?=
 =?utf-8?B?SFRIL3hhcVB6QjN0OEZkcG8wdEpXQWcreEdiS0NWaWRtejArV0YxZGtkR283?=
 =?utf-8?B?YTVuVUlHbFFGRW1oUEFiWFF2OHhLeDVpU1lEdmVlNTVQVFZ1MTdWOUVzaWgy?=
 =?utf-8?B?YXNYZkhBb0hacG9RaVRVY2lkdE9TTThiLzRYelFic2pNdlZyMTVjOGJtd3lo?=
 =?utf-8?B?RmtyM3Ixek8zalpBRE1BNHI5dURjRnZJY1ExcnVaTmNobi83WWg4MVlyZFU4?=
 =?utf-8?Q?HJVip1ATs1me5+0NidcRRYltu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fc8b48-2ef1-4937-f1f0-08dba31fa8c8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:54:17.6031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNNJ6SLqoXmxV26A6p9q5uXWzHK0H5WsWXcv2oxYRSlgc8qehI/1cxEK3o+KzGaVw+O/s1nhi23LHlXn6U1Hbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991
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


On 2023-08-22 9:49, Bhardwaj, Rajneesh wrote:
>
> On 8/21/2023 4:32 PM, Felix Kuehling wrote:
>>
>> On 2023-08-21 15:20, Rajneesh Bhardwaj wrote:
>>> Rework the KFD max system memory and ttm limit to allow bigger
>>> system memory allocations upto 63/64 of the available memory which is
>>> controlled by ttm module params pages_limit and page_pool_size. Also 
>>> for
>>> NPS1 mode, report the max ttm limit as the available VRAM size. For max
>>> system memory limit, leave 1GB exclusively outside ROCm allocations 
>>> i.e.
>>> on 16GB system, >14 GB can be used by ROCm still leaving some memory 
>>> for
>>> other system applications and on 128GB systems (e.g. GFXIP 9.4.3 APU in
>>> NPS1 mode) nearly >120GB can be used by ROCm.
>>>
>>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  5 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 25 
>>> +++++++++++++------
>>>   2 files changed, 21 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 9e18fe5eb190..3387dcdf1bc9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -44,6 +44,7 @@
>>>    * changes to accumulate
>>>    */
>>>   #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
>>> +#define ONE_GB            (1UL << 30)
>>>     /*
>>>    * Align VRAM availability to 2MB to avoid fragmentation caused by 
>>> 4K allocations in the tail 2MB
>>> @@ -117,11 +118,11 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>           return;
>>>         si_meminfo(&si);
>>> -    mem = si.freeram - si.freehigh;
>>> +    mem = si.totalram - si.totalhigh;
>>>       mem *= si.mem_unit;
>>>         spin_lock_init(&kfd_mem_limit.mem_limit_lock);
>>> -    kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
>>> +    kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6) - (ONE_GB);
>>
>> I believe this is an OK heuristic for large systems and medium-sized 
>> systems. But it produces a negative number or an underflow for 
>> systems with very small system memory (about 1.1GB).  It's not 
>> practical to run ROCm on such a small system, but the code at least 
>> needs to be robust here and produce something meaningful. E.g.
>
>
> Sure, I agree.
>
>>
>>     kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6);
>>     if (kfd_mem_limit.max_system_mem_limit < 2 * ONE_GB)
>>         kfd_mem_limit.max_system_mem_limit <<= 1;
>>     else
>>         kfd_mem_limit.max_system_mem_limit -= ONE_GB;
>>
>> Since this change affects all GPUs and the change below is specific 
>> to GFXv9.4.3 APUs, I'd separate this into two patches.
>
>
> Ok, will split into two changes.
>
>>
>>
>>>       kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() << 
>>> PAGE_SHIFT;
>>>       pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>>>           (kfd_mem_limit.max_system_mem_limit >> 20),
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 8447fcada8bb..4962e35df617 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -25,6 +25,7 @@
>>>   #include <linux/pci.h>
>>>     #include <drm/drm_cache.h>
>>> +#include <drm/ttm/ttm_tt.h>
>>>     #include "amdgpu.h"
>>>   #include "gmc_v9_0.h"
>>> @@ -1877,6 +1878,7 @@ static void
>>>   gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
>>>                     struct amdgpu_mem_partition_info *mem_ranges)
>>>   {
>>> +    uint64_t max_ttm_size = ttm_tt_pages_limit() << PAGE_SHIFT;
>>>       int num_ranges = 0, ret, mem_groups;
>>>       struct amdgpu_numa_info numa_info;
>>>       int node_ids[MAX_MEM_RANGES];
>>> @@ -1913,8 +1915,17 @@ gmc_v9_0_init_acpi_mem_ranges(struct 
>>> amdgpu_device *adev,
>>>         /* If there is only partition, don't use entire size */
>>>       if (adev->gmc.num_mem_partitions == 1) {
>>> -        mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
>>> -        do_div(mem_ranges[0].size, mem_groups);
>>> +        if (max_ttm_size > mem_ranges[0].size || max_ttm_size <= 0) {
>>
>> This gives some weird dis-continuous behaviour. For max_ttm_size > 
>> mem_ranges[0].size it gives you 3/4. For max_ttm_size == 
>> mem_ranges[0].size it gives you all the memory.
>>
>> Also, why is this only applied for num_mem_partitions == 1? The TTM 
>> limit also applies when there are more memory partitions. Would it 
>> make more sense to always evenly divide the ttm_tt_pages_limit 
>> between all the memory partitions? And cap the size at the NUMA node 
>> size. I think that would eliminate special cases for different 
>> memory-partition configs and give you sensible behaviour in all cases.
>
>
> I think TTM doesn't check what values are being passed to pages_limt 
> or page_pool_size so when the user passes an arbitrary number here, I 
> wanted to retain the default behavior for NPS1 mode i.e. 3/4th of the 
> available NUMA memory should be reported as VRAM. Also for >NPS1 mode, 
> the partition size is already proportionately divided i.e in TPX/NPS4 
> mode, we have 1/4th NUMA memory visible as VRAM but KFD limits will be 
> already bigger than that and we will be capped by VRAM size so this 
> change was only for NPS1 mode where the memory ranges are limited by 
> NUMA_NO_NODE special condition.

I'll clarify my concern on an example of a 1P NPS4 system. You have 3 
NUMA nodes for the GPUs. Each is 1/4 of the memory in the socket, so 
they add up to 3/4 of the total memory in the socket. The default TTM 
limit is 1/2 of the memory. So you cannot allocate 3/4 of the memory 
between the 3 memory partitions without running into TTM limits. 
Therefore I think the reported VRAM sizes of the 3 partitions should be 
reduced in this case. Each memory partition should not be 1/4 of the 
total memory, but 1/6. That is

     partition-size = max(numa-node-size, ttm-pages-limit / n-partitions)

In a 4P system, n-partitions in this case has to be the total number of 
GPU memory partitions across all GPUs. In NPS1 mode that's the total 
number of NUMA nodes. In NPS4 mode it's the total number of NUMA nodes * 
3/4.

Regards,
   Felix


>
>>
>> Regards,
>>   Felix
>>
>>
>>> +            /* Report VRAM as 3/4th of available numa memory */
>>> +            mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 
>>> 1);
>>> +            do_div(mem_ranges[0].size, mem_groups);
>>> +        } else {
>>> +            /* Report VRAM as set by ttm.pages_limit or default ttm
>>> +             * limit which is 1/2 of system memory
>>> +             */
>>> +            mem_ranges[0].size = max_ttm_size;
>>> +        }
>>> +        pr_debug("NPS1 mode, setting VRAM size = %llu\n", 
>>> mem_ranges[0].size);
>>>       }
>>>   }
>>>   @@ -2159,6 +2170,11 @@ static int gmc_v9_0_sw_init(void *handle)
>>>         amdgpu_gmc_get_vbios_allocations(adev);
>>>   +    /* Memory manager */
>>> +    r = amdgpu_bo_init(adev);
>>> +    if (r)
>>> +        return r;
>>> +
>>>   #ifdef HAVE_ACPI_DEV_GET_FIRST_MATCH_DEV
>>>       if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
>>>           r = gmc_v9_0_init_mem_ranges(adev);
>>> @@ -2167,11 +2183,6 @@ static int gmc_v9_0_sw_init(void *handle)
>>>       }
>>>   #endif
>>>   -    /* Memory manager */
>>> -    r = amdgpu_bo_init(adev);
>>> -    if (r)
>>> -        return r;
>>> -
>>>       r = gmc_v9_0_gart_init(adev);
>>>       if (r)
>>>           return r;
