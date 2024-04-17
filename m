Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A38C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 15:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BFA10F6B6;
	Wed, 17 Apr 2024 15:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1rXXGnc3";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB23B10F6B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 15:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLZKoNOS8M34caxByYk2uEGWSvWm7kJglb8QJJVduqjihx8q3nOYdsXQ0auquoML4C6MEXbMmxUAC6ae8ZmTF10GGfglM2B771o1SiLC3zWrjtvfNgiM+gV0BSZRFdk9TGSf2TiebMnodbzVdiLHfa7NXVxfYEgSK/JONIGc1/p6tQW02OnAV/faNyunFyB69XdgPJgfkWZ37w9HThDINpesHZIGeveX0rMTPbdrPFN7pASttpcj0hUpaHdw2BSMGby21kC/Iwiy+c1nCHx/7651O6uB5wXqRP54O1NIAuYGbZ29wRvhwY8Bgw9rikZ51jTqKe70BzEfRCjgywY8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDJxC+avlZmJZdcJ8Y+/gqlkUxb7xru29A9zb//uJGs=;
 b=eftGsVG01RwYaXpFdqBZCQXeSk8a9IJI6nu9zp/g+kuiaX3Wf58ts9lO+19HbfPJujrg6zrL9Ntcqct7O8gn4AovtesINkwBZX5IvG6zogvX3wml9SaZXwIgKr3r92i/rBaDKAam6IIk6B1Je06PzKe/nJq4MVW83mfYoKOUu+VNTbMVdhYjNVzU0NR69kpYnYzYW9qkqBilrskccHUcafJrHJe2Iw5wLcTfjMTi9ya2eIMg/yNtYXy2dumk8p2xdww6E34jkM2eG87dTxy0ZdsIPR0kxxQRGRj4Rd1PVYunXk5rDF/FxJTSOu4Cr9tOaqhV3xNfbbNsTtz4q7nZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDJxC+avlZmJZdcJ8Y+/gqlkUxb7xru29A9zb//uJGs=;
 b=1rXXGnc3bDJ2McKfTG0/tC9KEZ5mNFG706SKOU+GKa75W1cqBEIq0PZ26jrILynAVkWSboWmkw+jknJNZWCjuWHEBSmKAT0mDSGtRrwDGzl8QBI4cpT7TRMpIFxG2cKKTPxZSPVP5qrSQhJbwhFN5vBLJp6d8wnauaE0ecsIgIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 15:37:44 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 15:37:44 +0000
Message-ID: <3ed20ad0-552a-45e2-a606-129ab1dc3f96@amd.com>
Date: Wed, 17 Apr 2024 21:07:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Modify the contiguous flags behaviour
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, philip.yang@amd.com
References: <20240417062121.3779-1-Arunpravin.PaneerSelvam@amd.com>
 <0ebbd37d-1872-4d54-9aa1-842a6090c678@amd.com>
 <b5460307-ce38-4a34-af22-e0936507a3cc@amd.com>
 <ea5d73f1-0bf9-41a1-95b7-6479ea4c6ad8@amd.com>
 <16517871-3b50-15b1-2011-e6b08dbe0525@amd.com>
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <16517871-3b50-15b1-2011-e6b08dbe0525@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::9) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bf0469-bc47-461e-4382-08dc5ef4534c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7xmjWXXl9/JcmRx1rMFVlKsasbuz+jf6yKqlGwdEFkrpua0rKixUtuW669wJ6vhPdPutCorivSbvEd7ANvX9QWMMsCK/Ifz0lBleFtw6bQUY4Pbf+CG0+KAyjGUEk3o40Rwu6nNnA/O0LVdIRzLXZgDuKysQF3x3q/downxjP+bqVh1W+CFVHvuM6SMRNAYmRQ61muNuzY4r/z8sNIhkhPOJv8ooQK7e4zJ44gezTAbIK+DiK5MrBiv5FUrrOy7P6Vkiqy2bZHu2EpxynugPkKDPy2WcwVgqoHsBVurrgBoxkMHX4vR1F3EZQ7GLOZ5pd+1uMuyX67OJ9DMSEpQ7o1CYNlccdKvQTv+lynwho/FtqxmwNjxULjt9gedsu0UPtPrZnkitnTVZYQEWkW6wgvixcGK3AnakGyX1mHMhcJNfBV3WASccQSQyadVKxQry1K69qukpJ4HCflx5cqoo2clreu3FEH5zIzLo5NiYjf00evv+kDFJ016lLh1E2HoaaRPIymXwwmgcdEO6roRoPD45SoBwv1LNNq5iPNYbtlNskzIWBDoVrYraLtBVvLHqCE2bIg/rvO1iwAmVI9NOoeaXFGGB+ze+UNeM8dFLYLewAdk9NLDKLT16WJUTOYZdsxcx1FdjAliOq7Hhzo6v6UNKJYvlJZU7PNos7Y92O4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVqbUQxOHViM2lDZWhhTFJVd3hPT1dqb2EzVXl1dnZhTEt5YlFTUk5TUnU4?=
 =?utf-8?B?OFo5YkdLNjZ6Y0tkT2gzS0paTnZvVUNDMW1RMnVoRlJlQkdDc1EyTFBFbkxp?=
 =?utf-8?B?dGlnRDc0eUpVeU95TUZNVU1RRHpuRGgzSHBtZmozWWZqN1lSRzhBMTNIY2ZP?=
 =?utf-8?B?UjU2VExkRlQ2MXRzeE8zd0lPRnJyb2JCTlByajFoQVFHdXB4THZhZ0xBRGRW?=
 =?utf-8?B?Wm1KWGVGYm4xVEFrSXoxdHlpQmMvTmpndmRoQ2d3OHNkd1BWU0xoNy9QYnRD?=
 =?utf-8?B?anU1WkJVQ0xZY1o0QStCRTEzOURFaHl3MHc4WmVzNXRjYjczSWdoUmxTVUlj?=
 =?utf-8?B?SWc0cXBIWlFzakZUd2xldGpHaGxzQ0U0bjYzZ1I2c1Q2RHdJN2VmeFdsZUpW?=
 =?utf-8?B?TThvN2tnYkgyVkZFdzNKeDB6UVVsV1RnaGdOY3pXcktKUGxUbEhPZks5bDJs?=
 =?utf-8?B?U0RFYVlOWWczbVJEQ2FJRVI1ZDlCWHZlZUxzalJpSUJCaHM3bWNjSkU4Qjlp?=
 =?utf-8?B?aFVqMjhzZENiMWUwd3NHVk9SUVZlRUsvQ1JYM2xBbFkwb1pXUkFwV2E5T3lr?=
 =?utf-8?B?RVA2YkpaM3pzdytGQ2lPNi9hN083SVBKeW80MzQ5VkJBSHVUcFVnWWFISjJS?=
 =?utf-8?B?bGw4aWh2dFlxMm1ZcnI2T0MxOVR0T3luU0lDZDVFSlhLUzF6QjFlcFBjdGxG?=
 =?utf-8?B?Q083RXdCa3lWK1hocnVnYWd6VE4wcmpWR1BJNnNNcG5HanlIbzZ0OTlxcFlR?=
 =?utf-8?B?bXJWSmpnMi84aVp4ZUtVaVUxT2d2TlhUZXhFRFh6R1BvTk5MalZRam82cENq?=
 =?utf-8?B?QjV6QWRVVjV3VkxQdkRmZXJLeUdIWldpclRNVXA2QkgzNStsSyswWVVHUE1S?=
 =?utf-8?B?dld6UEhSd1duMUlTWjVGR0wvSlhTVzg3cmpwc1JOTERMb0djamk4dWpWRVdE?=
 =?utf-8?B?bmE0cU9uSnBMYnBvT0VyOVpUNU5yNi85NUE5dXNZUkVUVmtsQVloeFh3SFM3?=
 =?utf-8?B?d3RDQXd6Z1hmZmxYREJPdXA2RTVHNVl6cVdiSmdFVlNiZVU1anBKQ1pRYlRm?=
 =?utf-8?B?RUpFdkxjR3VoaWQ0Y1pnTk9RWkNOMjB5ejlvLzVqVjkvdSsxaUJ3RDZ4YjZR?=
 =?utf-8?B?a0lWNHBTWkNIYXUrL0Z1VjRJWk4rVm5QNzNHbTZldUdaODFnSkhFRDMxa3pi?=
 =?utf-8?B?UEZVZ0lNYy9haXRsYjRpRkdLZW5GNVF1SFFvVDBEeWtiWVo5Mlo0dWhjMU8x?=
 =?utf-8?B?MXducU5LQVlaZ1g1WnB3Y3lMOUNMZjhCVFNFWkhYbWZscFlZZ0t5M2pWRW1H?=
 =?utf-8?B?OWlzV21NQjJYbHhWUFRVUjFYRHBEL24zcFBQQnlQMmFxNTBIblRBb1IxRHpU?=
 =?utf-8?B?L3pYcW5TUDB6aWFIQlhHd00wUDZxNlhZUklyRzNmemhuRDBXa0VmWE4wNmlX?=
 =?utf-8?B?TW9wd2JVYUtVdkhVQUxnWVFocjMwdHVWV1hDbE8vdk9MQTRkT0cxNWF0ZXhM?=
 =?utf-8?B?dmY0Si9va1ZaMTIwdndWd202WGZ5a0wyMk5nVHZLejJXNVVNUFRKUjNoUjdz?=
 =?utf-8?B?TEN6dUR1c2xPOERYVUIwNDJtbjAvZGpMNzdCSmtFUXJEeHFtd3JZSXNSaHBD?=
 =?utf-8?B?am1Hb2p2dWtnVElQTVNKTzhWb0QySnA5dU45dnVCZGtuUjRqZGd1ZmM0UWkz?=
 =?utf-8?B?eWJlQUVQbldScmRLUmhnR0RNbC8yaVhHeDZKR2E1RmVrb0oxaUpZTDFOUmFn?=
 =?utf-8?B?NklmbERURTE0WlpvcEZFTXhnN0xQSkI1Y1RiNDV4cFNMMDRsU204ZDZLN1Rn?=
 =?utf-8?B?WTJwbVRVVmtSQWovQm5OOEtpY01wQ3JiVU12MTFxYkU2YmVYZWs0ZFhUNW5P?=
 =?utf-8?B?aGdpZkRzMkpUbU52QUhubCtUQVBzcWxVYkt2STRmSUFnTjJKSG4rNTdqMGZD?=
 =?utf-8?B?bHlxOU5CV2FFNEYyTlJmNTJ6QzdMNWlEVkgyWmIreHdqdU52cEVqbmJoQ2R6?=
 =?utf-8?B?eHU4ckhBMjZjWEJiUGdWQ3hHQTlQbzNYckc1RTZXMWNiWlB0bm16bW53OXhM?=
 =?utf-8?B?R0kyelVrbEcva2ZJSVp0WnZxaldGM3dkZ0lMSC9QNFUvb2hOVS9QK2FIT05x?=
 =?utf-8?Q?wFaqTA0Io8aDcci3A6qcs6OOh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bf0469-bc47-461e-4382-08dc5ef4534c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 15:37:44.5632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZtOBLlMn0Ms4OHqlxmKh6f/nROGNQcgxnkASIT3xsnEoSpnq+KeUf/IOSTcYfDJv4UMZjVSbmrcNMDXcJeOXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

Hi Philip,

On 4/17/2024 8:58 PM, Philip Yang wrote:
>
>
> On 2024-04-17 10:32, Paneer Selvam, Arunpravin wrote:
>> Hi Christian,
>>
>> On 4/17/2024 6:57 PM, Paneer Selvam, Arunpravin wrote:
>>> Hi Christian,
>>>
>>> On 4/17/2024 12:19 PM, Christian König wrote:
>>>> Am 17.04.24 um 08:21 schrieb Arunpravin Paneer Selvam:
>>>>> Now we have two flags for contiguous VRAM buffer allocation.
>>>>> If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
>>>>> it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
>>>>> buffer's placement function.
>>>>>
>>>>> This patch will change the default behaviour of the two flags.
>>>>>
>>>>> When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
>>>>> - This means contiguous is not mandatory.
>>>>> - we will try to allocate the contiguous buffer. Say if the
>>>>>    allocation fails, we fallback to allocate the individual pages.
>>>>>
>>>>> When we setTTM_PL_FLAG_CONTIGUOUS
>>>>> - This means contiguous allocation is mandatory.
>>>>> - we are setting this in amdgpu_bo_pin_restricted() before bo 
>>>>> validation
>>>>>    and check this flag in the vram manager file.
>>>>> - if this is set, we should allocate the buffer pages contiguously.
>>>>>    the allocation fails, we return -ENOSPC.
>>>>>
>>>>> v2:
>>>>>    - keep the mem_flags and bo->flags check as is(Christian)
>>>>>    - place the TTM_PL_FLAG_CONTIGUOUS flag setting into the
>>>>>      amdgpu_bo_pin_restricted function placement range iteration
>>>>>      loop(Christian)
>>>>>    - rename find_pages with amdgpu_vram_mgr_calculate_pages_per_block
>>>>>      (Christian)
>>>>>    - Keep the kernel BO allocation as is(Christain)
>>>>>    - If BO pin vram allocation failed, we need to return -ENOSPC as
>>>>>      RDMA cannot work with scattered VRAM pages(Philip)
>>>>>
>>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  8 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57 
>>>>> +++++++++++++++-----
>>>>>   2 files changed, 50 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> index 8bc79924d171..caaef7b1df49 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> @@ -153,8 +153,10 @@ void amdgpu_bo_placement_from_domain(struct 
>>>>> amdgpu_bo *abo, u32 domain)
>>>>>           else
>>>>>               places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>>>>>   -        if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>>>>> +        if (abo->tbo.type == ttm_bo_type_kernel &&
>>>>> +            flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>>>>>               places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>>>> +
>>>>>           c++;
>>>>>       }
>>>>>   @@ -966,6 +968,10 @@ int amdgpu_bo_pin_restricted(struct 
>>>>> amdgpu_bo *bo, u32 domain,
>>>>>           if (!bo->placements[i].lpfn ||
>>>>>               (lpfn && lpfn < bo->placements[i].lpfn))
>>>>>               bo->placements[i].lpfn = lpfn;
>>>>> +
>>>>> +        if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>>>>> +            bo->placements[i].mem_type == TTM_PL_VRAM)
>>>>> +            bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>>>>       }
>>>>>         r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>
>>>> Nice work, up till here that looks exactly right as far as I can see.
>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> index 8db880244324..4be8b091099a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> @@ -88,6 +88,29 @@ static inline u64 
>>>>> amdgpu_vram_mgr_blocks_size(struct list_head *head)
>>>>>       return size;
>>>>>   }
>>>>>   +static inline unsigned long
>>>>> +amdgpu_vram_mgr_calculate_pages_per_block(struct 
>>>>> ttm_buffer_object *tbo,
>>>>> +                      const struct ttm_place *place,
>>>>> +                      unsigned long bo_flags)
>>>>> +{
>>>>> +    unsigned long pages_per_block;
>>>>> +
>>>>> +    if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>>>>> +        pages_per_block = ~0ul;
>>>>
>>>> If I understand it correctly this here enforces the allocation of a 
>>>> contiguous buffer in the way that it says we should have only one 
>>>> giant page for the whole BO.
>>> yes, for contiguous we don't have the 2MB limit, hence we are 
>>> setting to maximum to avoid restricting the min_block_size to 2MB 
>>> limitation.
>>>>
>>>>> +    } else {
>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>> +        pages_per_block = HPAGE_PMD_NR;
>>>>> +#else
>>>>> +        /* default to 2MB */
>>>>> +        pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>>>>> +#endif
>>>>> +        pages_per_block = max_t(uint32_t, pages_per_block,
>>>>> +                    tbo->page_alignment);
>>>>> +    }
>>>>> +
>>>>> +    return pages_per_block;
>>>>> +}
>>>>> +
>>>>>   /**
>>>>>    * DOC: mem_info_vram_total
>>>>>    *
>>>>> @@ -451,8 +474,10 @@ static int amdgpu_vram_mgr_new(struct 
>>>>> ttm_resource_manager *man,
>>>>>       struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
>>>>>       struct amdgpu_device *adev = to_amdgpu_device(mgr);
>>>>>       u64 vis_usage = 0, max_bytes, min_block_size;
>>>>> +    struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>>>>       struct amdgpu_vram_mgr_resource *vres;
>>>>>       u64 size, remaining_size, lpfn, fpfn;
>>>>> +    unsigned long bo_flags = bo->flags;
>>>>>       struct drm_buddy *mm = &mgr->mm;
>>>>>       struct drm_buddy_block *block;
>>>>>       unsigned long pages_per_block;
>>>>> @@ -468,18 +493,9 @@ static int amdgpu_vram_mgr_new(struct 
>>>>> ttm_resource_manager *man,
>>>>>       if (tbo->type != ttm_bo_type_kernel)
>>>>>           max_bytes -= AMDGPU_VM_RESERVED_VRAM;
>>>>>   -    if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
>>>>> -        pages_per_block = ~0ul;
>>>>> -    } else {
>>>>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>> -        pages_per_block = HPAGE_PMD_NR;
>>>>> -#else
>>>>> -        /* default to 2MB */
>>>>> -        pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>>>>> -#endif
>>>>> -        pages_per_block = max_t(uint32_t, pages_per_block,
>>>>> -                    tbo->page_alignment);
>>>>> -    }
>>>>> +    pages_per_block =
>>>>> +        amdgpu_vram_mgr_calculate_pages_per_block(tbo, place,
>>>>> +                              bo_flags);
>>>>>         vres = kzalloc(sizeof(*vres), GFP_KERNEL);
>>>>>       if (!vres)
>>>>> @@ -498,7 +514,7 @@ static int amdgpu_vram_mgr_new(struct 
>>>>> ttm_resource_manager *man,
>>>>>       if (place->flags & TTM_PL_FLAG_TOPDOWN)
>>>>>           vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>>>>>   -    if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
>>>>> +    if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>>>>>           vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>>>>
>>>> And this here just optimizes it in the way that it says try harder 
>>>> to make it look contiguous.
>>> Here I removed the TTM_PL_FLAG_CONTIGUOUS. AFAIU, in both cases (BO 
>>> pinning and normal contiguous request)
>>> this flag AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS is always set.
>>>>
>>>> Question is if that also works with pages_per_block of 2MiB or does 
>>>> that only kick in when pages_per_block is maximal?
>>> AFAIU, if this flag AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS is set, we are 
>>> setting the pages_per_block as maximal, thus
>>> we dont limit the BO. when we set the pages_per_block as maximal, 
>>> the min_block_size would be the tbo->page_alignment,
>>> and this tbo->page_alignment would be the same value as the required 
>>> size. Required size can be less than 2MB or more than 2MB.
>>> Below we have check size >= pages_per_block, when the 
>>> pages_per_block is maximal we don't limit the min_block_size.
>> a small correction, when we set the pages_per_block as maximal, we 
>> don't set the min_block_size, the buddy allocator will set the 
>> min_block_size
>> as roundup_pow_of_two(size).
>
> If setting 2MB pages_per_block, without 
> DRM_BUDDY_CONTIGUOUS_ALLOCATION flag, does buddy alloc from free 2MB 
> blocks first, or buddy split larger blocks into smaller blocks, as we 
> want to keep larger block for contiguous allocation.
>
when we set the 2MB pages_per_block without contiguous flag, buddy 
allocator first tries to find the 2MB blocks in the free list, if it 
doesn't find the blocks it will go to the next power of two (say 4MB) 
and split that into 2BM to satisfy the minimum alignment (2MB limitation).

If the required size is less than 2MB, buddy allocator goes with the 
tbo->page_alignment(if this is set) or default size (4KB).

Thanks,
Arun.
>
> Regards,
>
> Philip
>
>>
>> Thanks,
>> Arun.
>>>>
>>>>>         if (fpfn || lpfn != mgr->mm.size)
>>>>> @@ -529,8 +545,21 @@ static int amdgpu_vram_mgr_new(struct 
>>>>> ttm_resource_manager *man,
>>>>>                          min_block_size,
>>>>>                          &vres->blocks,
>>>>>                          vres->flags);
>>>>> -        if (unlikely(r))
>>>>> +        if (unlikely(r)) {
>>>>> +            if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>>>>> +                !(place->flags & TTM_PL_FLAG_CONTIGUOUS)) {
>>>>> +                /* Fallback to non contiguous allocation */
>>>>> +                vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>>>>> +                bo_flags &= ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>>
>>>> Well I would say that this is a rather hacky implementation and 
>>>> should be avoided if possible.
>>> sure, I will try to rewrite the code.
>>>>
>>>>> +
>>>>> +                pages_per_block =
>>>>> + amdgpu_vram_mgr_calculate_pages_per_block(tbo,
>>>>> +                                          place,
>>>>> +                                          bo_flags);
>>>>
>>>> Rather move the AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS handling out of 
>>>> amdgpu_vram_mgr_calculate_pages_per_block().
>>> sure.
>>>
>>> Thanks,
>>> Arun.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +                continue;
>>>>> +            }
>>>>>               goto error_free_blocks;
>>>>> +        }
>>>>>             if (size > remaining_size)
>>>>>               remaining_size = 0;
>>>>
>>>
>>

