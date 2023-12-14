Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40569C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 21:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B60E10E261;
	Thu, 14 Dec 2023 21:40:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C03A10E30A
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 21:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpx3WUbTzDreGZDICUXt96PeMPJVgamGzKRKRg+8AqtB+QyDKZEaG9T7sG7AWNH8KRpZ93yUr5uAY2LPEIB6SxhN5gRottaZG/Kdr0vSuGyy5yXTWjTHe6BUuUpxXVcf6/zUD8X6TCRFt4VMAawqd+v/pkpoDkoKaca/2xtCx68kmar6+HvdyVqZ8zNzPDG54Xj1P79jTIsWXRJWb4aCjeyPy9JvdgWEwjq6cAc3FlQmY8TLw5HT9XmKjLEFgFHjWDBJx4th8hruEGyzU+NYNuMuv7bNtu6PidRvzr7KW7mUt2yY5jc42ZHUVmqy1ODQxT/pJC0jopcsnrEmyMbThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6HwronCQMPyHc97tMfG3Ch7wyz3YfNUqyxqzy3bZko=;
 b=Tj5BhTU4+a+hvdvPatRmD884G9PFXr82JeS518a1wmZRlzGCzYcGpbgwarng9P0w3F9CATK4sqzD8O8wGMy324VvGMUpjiKR1UoL6vUKK76/aQ9cJL8ouw+WGoVNAWvBkV3QUkvVWnHgBpO1fYv6hyk8M0lJo/9VgGmXaMYEWxhA8JtZpxvTtxjuP0lNCWq7IYh/p0iGO9eQbo+9fgyzLoEOJWt1WmHdYg72pazWfoTPSQJzIH2Zd1O9k4mxPn+bfUzezEeoJwSIO4/PeNcb53uDqwbr5bHRCWy61pRtE41zwYkT5z/4Tl1TLjLHjRmGSNRH7R/DgBM5cAP8jFxTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6HwronCQMPyHc97tMfG3Ch7wyz3YfNUqyxqzy3bZko=;
 b=1qQ/kJZ9rzbBrA1+ONlosLk0ZO5EbcN52Kylvht5ecjmknXJS+yu303lOtEBMiiFBXMtEb+30BIbMlk7W9IGJAkQbTLTeyzIJW0AeUY3eaq6tW2wLoCJTghYViI6VuUwpGFOIcb24/dCYCPKKE9d0XBdBJ273dBIigq7ZJ/L7tQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 21:40:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 21:40:03 +0000
Message-ID: <74c4c1ea-c621-46de-8810-eae7af5a360f@amd.com>
Date: Thu, 14 Dec 2023 16:40:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Auto-validate DMABuf imports in
 compute VMs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231206214413.2440998-1-Felix.Kuehling@amd.com>
 <88e15819-885e-45f6-8f31-1df647383195@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <88e15819-885e-45f6-8f31-1df647383195@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: b634f6cf-f76d-40fb-3942-08dbfced3b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfxFkJSKSQTUdnbj1pkwjMBTxyJK6kYJ+Y5oE0ir8h+skJaDtMknoGTy6s0HJVMo0C0lEfFfFYIdkwFFWfPHSXbEX/zoFRYVL5hit2xqEP9ZioVrvjjBceRt8K2j0h8AL28fspkoBY5QbL7HGxH/jz279VHKg+V3+NwFpf6dSF4TAKLuxaXpM1ssd8DCveKr8500EP2I3BBZlzKuxUkIATgFNmuEZMAb6IBRzap02R9dmIFB/HKRf+vLRz57fyapFIIg4yPRKmx53TaFjVdyvN7APh8Slx63nEt+u5oIdXPiDAqBlHafyDHwMS6qtCAwHedA6VfX9KkZt6I8TcGrpD3DaBPXvJZ4rPxIpvrnD7bwvvaQWQY0xB5uTA9pqgwmylCeLET7dYASQzX8/9AjulTvbjbsI6hYiLRY9xQMoA63LgjIre3zFRkUViS8STGNZejA5bBdTPf1Vb3Atg2Q5X3PDvDG7JI9Kw0x/3SrdDODJ19xIMWtmRnB7JtZ1fPqmCnqaTPNac/rvg3szQRWxyms5JAafupWJozOlDvw2yi4I8H2QiIoCBBLL2h4BfnC2EZmUHV1SJeehSEaNT4Bm07sils3Hf2FQZx+cN3OkdWDHrMSNZPzyvkfZOClgbk7tEVCQqiroP+4PZytbblHXKnXF33uo8P8YPdzZ4bSLsA47Y764IsXxvmTHre6yB7f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(53546011)(316002)(36916002)(6506007)(2616005)(478600001)(66946007)(66556008)(66476007)(6486002)(38100700002)(6512007)(86362001)(8936002)(4326008)(8676002)(31696002)(26005)(4001150100001)(30864003)(15650500001)(5660300002)(2906002)(66574015)(41300700001)(36756003)(44832011)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJUVys4SGVPUnJoU2IwVXpya2JkZ1dsY01mMjhxS2JVLzhPRjd1aFI4UFlY?=
 =?utf-8?B?T3hLSUgwRkpHWnJjUVNXdk5DWnpTaVNhTUkrWmdXV2JNZ2Z2bTAyekhzbFRj?=
 =?utf-8?B?ME5JOGg1U055Yk84Q0VIVkVYdlp2RnpKK2M5MXBSRUdLQU50RFJ3VThoMDE2?=
 =?utf-8?B?d1k5RWI3a3hGSHYrblNmWHVsenQwNjcxY21GKzZvY25qMWhWU2ljRGFSUHMv?=
 =?utf-8?B?ZGc3bkVNT0NjbWxoOXFzKzZjUkF6K0w4L0hYNmpFOVhRbDRzSW1nNjNxRkkr?=
 =?utf-8?B?aC94RFZxQWlmYWFBRitUcGMrdkRrbEtYNTZnMk12ZzBmNW5SQlhuWm03L3Vw?=
 =?utf-8?B?Vi9NWThsSE9zM2pJT3FZV2lJTWQ0d0F4cVAxRk9MWmUrd0NET3NSR3c4dit4?=
 =?utf-8?B?WTloRW5Kczk5d0NWeWNnNytoanlkSmNNVnlUVDd3aENyT0FrNndHeXo2R2p4?=
 =?utf-8?B?aXZWK2pZT2ZrZGNoRndDYzVyM3p0SmViYU9nUFlMTUdEeW9GcURjbksyS0Uv?=
 =?utf-8?B?em5remdVOXRzM0tuVjRLdVhKckdGaDg0TWRWZzFwNmxHOURmVFR2d1ZvOEsy?=
 =?utf-8?B?YnFNQjg4bkJ5QlQzNVViNjNHdC9Nb1lqd2tOTnJySVlLdDdhdDg2YnRUNTBY?=
 =?utf-8?B?dDkrcnpNK2xTdmNjVUg5LzZYUnNqSExoLy9ERWIySkNsdVV1RkxucWNXbllG?=
 =?utf-8?B?Q2RVTEdJS1RIU2t5a21XbFpQOFArWDZvdXQ1TTFON2tkMm1yaFJYSUpWYUND?=
 =?utf-8?B?UjZwMFJpWWRPZGpNcVVNS05VekhSWENiOHc5MFhBTmZwaWNxQ0pnZDNQaGFF?=
 =?utf-8?B?R1ZKcEQyN2lFWnhrQWdlbGc0TWx3ZVNDWjQ4L1dTbXFIc2xHYkozZC9KZFdu?=
 =?utf-8?B?L1g5ejJaVVh5MGJYYkkyR1NjaVdzQjRnR252VzhncE4ySUtmZFBsSTJXYUhY?=
 =?utf-8?B?cXpCNmZIY1lpbkZoR3ErZ3VacC9wbFhqZnZYbG9TN0Z5SFkxdzF6eXdNdjdF?=
 =?utf-8?B?WkFLN0hzT3pXQURyazNwQjFIblFjalc4dkl2ZURkRm1VanpVU2xyeUZqbEFG?=
 =?utf-8?B?M2g0c1Q2VCswdTZ4RUh2a0J4WDk0K3dhNjN4bjdxNG84bXFwbUVLTllvRzVq?=
 =?utf-8?B?TUQwc1l4VzZTU1ViNG8vOHhPbkF3VGpHRjBiZ3FWZmZRWHpYR001ZVRsTnY1?=
 =?utf-8?B?M2oyZnNSbHozM2dpNzdRUmUvSVlYaUwrbVo2U1JuN1ZnNGF2UHYxckxsYUkv?=
 =?utf-8?B?N0hiNEJjTFJxeGFUcGxYdFJNWmpqak5wUFJkRHVHODBSS2VqaWoycm1OckJB?=
 =?utf-8?B?QnZRWjlnendRVFVPaHk5L3RxdENTYzBkaDVwc0Rab3pQZTdSZUZSVXV3VE1K?=
 =?utf-8?B?UTR3ekY3T2FCV24yNDNKQkl6dTVWTlphZnBSQWw2RGdRVXErVFR6bDkvb2lw?=
 =?utf-8?B?RnJaekV6VlF0UHBnS3RUWUVBMUgyQTdyU2EwTXBpR01PcVBSSURKb3I0MUdu?=
 =?utf-8?B?d0xaTGtKQWh5STg0dFFrdkJESXdFNFhxVVJCc2FoM0toVWU2V284aUdiaGVz?=
 =?utf-8?B?b09WRTlVWFYxOU9UOUtRSy93U3hvdE5jbC9UZnQvcEZrWWZNNzZaT1IyTU5D?=
 =?utf-8?B?MStjMmFPSTRtKzZmdjJnQkNwNHVzRVVKajRJbkhKbjI4ZGNSWGQ5akEwRmtt?=
 =?utf-8?B?eVNQS09BVXZqUkNHZFRueG9kQi9VVnhpL1ZzNE9FUVl2SG1rZGdVc0YrQTJu?=
 =?utf-8?B?SnZMQ3VtVjlCVmM5WHdEQnpIaG80ci91REVGM0dnblVVaVMzdHZBZm9SOCtP?=
 =?utf-8?B?dS9DZFpMcTEweDVFdWwwUGtvL3hwb0ZncEN2d1MvT0RYN3kwWS93KzhMdGJM?=
 =?utf-8?B?ZHBvNUdlVUg0WndGODRaaGYwcjBMcVJUVXFkMVlvWFBnN0tJTHN4TUIzZDRX?=
 =?utf-8?B?NnFVOUVSYlUxczQ2SVlmejIySTNaMFJQZGJIc2QrWHZ6UTB4NjBieVY5cFJJ?=
 =?utf-8?B?SUdVTksvVnhoOFkyL1o1UnpiM3FSSXd1VVZIc1BZSDJJMEdINmFXYW90a3pQ?=
 =?utf-8?B?ZTZ3Uks3ZmFVVzVlOWlNTjk5MXRTbEwwTU1wNTRXYzBiRmJuVG8yNTU2V1lO?=
 =?utf-8?Q?IB5jV1xEzy6wu9dunMe2HtmJw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b634f6cf-f76d-40fb-3942-08dbfced3b10
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 21:40:03.2928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oFlVFfMsf9fTNgXn+DUgzgQUZqJLb10NfOBFGpa7B3a5motizbxD/7/Fbe5os0ZjEISGRvX3SvtTI+qSPzhZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-13 09:30, Christian König wrote:
> Am 06.12.23 um 22:44 schrieb Felix Kuehling:
>> DMABuf imports in compute VMs are not wrapped in a kgd_mem object on the
>> process_info->kfd_bo_list. There is no explicit KFD API call to validate
>> them or add eviction fences to them.
>>
>> This patch automatically validates and fences dymanic DMABuf imports 
>> when
>> they are added to a compute VM. Revalidation after evictions is handled
>> in the VM code.
>>
>> v2:
>> * Renamed amdgpu_vm_validate_evicted_bos to amdgpu_vm_validate
>> * Eliminated evicted_user state, use evicted state for VM BOs and 
>> user BOs
>> * Fixed and simplified amdgpu_vm_fence_imports, depends on reserved BOs
>> * Moved dma_resv_reserve_fences for amdgpu_vm_fence_imports into
>>    amdgpu_vm_validate, outside the vm->status_lock
>> * Added dummy version of amdgpu_amdkfd_bo_validate_and_fence for builds
>>    without KFD
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  10 ++
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  44 +++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   6 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   4 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  28 ++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 101 ++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  10 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  10 +-
>>   8 files changed, 177 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index f262b9d89541..584a0cea5572 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -191,6 +191,9 @@ struct amdgpu_amdkfd_fence 
>> *to_amdgpu_amdkfd_fence(struct dma_fence *f);
>>   int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
>>   int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>>                   unsigned long cur_seq, struct kgd_mem *mem);
>> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
>> +                    uint32_t domain,
>> +                    struct dma_fence *fence);
>>   #else
>>   static inline
>>   bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
>> @@ -216,6 +219,13 @@ int amdgpu_amdkfd_evict_userptr(struct 
>> mmu_interval_notifier *mni,
>>   {
>>       return 0;
>>   }
>> +static inline
>> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
>> +                    uint32_t domain,
>> +                    struct dma_fence *fence)
>> +{
>> +    return 0;
>> +}
>>   #endif
>>   /* Shared API */
>>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t 
>> size,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 5f445d856769..fbabb1e63a67 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -426,9 +426,9 @@ static int amdgpu_amdkfd_bo_validate(struct 
>> amdgpu_bo *bo, uint32_t domain,
>>       return ret;
>>   }
>>   -static int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
>> -                           uint32_t domain,
>> -                           struct dma_fence *fence)
>> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
>> +                    uint32_t domain,
>> +                    struct dma_fence *fence)
>>   {
>>       int ret = amdgpu_bo_reserve(bo, false);
>>   @@ -464,13 +464,15 @@ static int amdgpu_amdkfd_validate_vm_bo(void 
>> *_unused, struct amdgpu_bo *bo)
>>    * again. Page directories are only updated after updating page
>>    * tables.
>>    */
>> -static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
>> +static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm,
>> +                 struct ww_acquire_ctx *ticket)
>>   {
>>       struct amdgpu_bo *pd = vm->root.bo;
>>       struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
>>       int ret;
>>   -    ret = amdgpu_vm_validate_pt_bos(adev, vm, 
>> amdgpu_amdkfd_validate_vm_bo, NULL);
>> +    ret = amdgpu_vm_validate(adev, vm, ticket,
>> +                 amdgpu_amdkfd_validate_vm_bo, NULL);
>>       if (ret) {
>>           pr_err("failed to validate PT BOs\n");
>>           return ret;
>> @@ -1310,14 +1312,15 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
>>       return ret;
>>   }
>>   -static int process_validate_vms(struct amdkfd_process_info 
>> *process_info)
>> +static int process_validate_vms(struct amdkfd_process_info 
>> *process_info,
>> +                struct ww_acquire_ctx *ticket)
>>   {
>>       struct amdgpu_vm *peer_vm;
>>       int ret;
>>         list_for_each_entry(peer_vm, &process_info->vm_list_head,
>>                   vm_list_node) {
>> -        ret = vm_validate_pt_pd_bos(peer_vm);
>> +        ret = vm_validate_pt_pd_bos(peer_vm, ticket);
>>           if (ret)
>>               return ret;
>>       }
>> @@ -1402,7 +1405,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, 
>> void **process_info,
>>       ret = amdgpu_bo_reserve(vm->root.bo, true);
>>       if (ret)
>>           goto reserve_pd_fail;
>> -    ret = vm_validate_pt_pd_bos(vm);
>> +    ret = vm_validate_pt_pd_bos(vm, NULL);
>>       if (ret) {
>>           pr_err("validate_pt_pd_bos() failed\n");
>>           goto validate_pd_fail;
>> @@ -2043,7 +2046,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>>           bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
>>           is_invalid_userptr = true;
>>   -    ret = vm_validate_pt_pd_bos(avm);
>> +    ret = vm_validate_pt_pd_bos(avm, NULL);
>>       if (unlikely(ret))
>>           goto out_unreserve;
>>   @@ -2122,7 +2125,7 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>>           goto unreserve_out;
>>       }
>>   -    ret = vm_validate_pt_pd_bos(avm);
>> +    ret = vm_validate_pt_pd_bos(avm, NULL);
>>       if (unlikely(ret))
>>           goto unreserve_out;
>>   @@ -2620,7 +2623,7 @@ static int validate_invalid_user_pages(struct 
>> amdkfd_process_info *process_info)
>>           }
>>       }
>>   -    ret = process_validate_vms(process_info);
>> +    ret = process_validate_vms(process_info, NULL);
>>       if (ret)
>>           goto unreserve_out;
>>   @@ -2880,11 +2883,6 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> __rcu *
>>         amdgpu_sync_create(&sync_obj);
>>   -    /* Validate PDs and PTs */
>> -    ret = process_validate_vms(process_info);
>> -    if (ret)
>> -        goto validate_map_fail;
>> -
>>       /* Validate BOs and map them to GPUVM (update VM page tables). */
>>       list_for_each_entry(mem, &process_info->kfd_bo_list,
>>                   validate_list) {
>> @@ -2935,6 +2933,13 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> __rcu *
>>       if (failed_size)
>>           pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
>>   +    /* Validate PDs, PTs and evicted DMABuf imports last. 
>> Otherwise BO
>> +     * validations above would invalidate DMABuf imports again.
>> +     */
>> +    ret = process_validate_vms(process_info, &exec.ticket);
>> +    if (ret)
>> +        goto validate_map_fail;
>> +
>>       /* Update mappings not managed by KFD */
>>       list_for_each_entry(peer_vm, &process_info->vm_list_head,
>>               vm_list_node) {
>> @@ -3006,7 +3011,7 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> __rcu *
>> &process_info->eviction_fence->base,
>>                      DMA_RESV_USAGE_BOOKKEEP);
>>       }
>> -    /* Attach eviction fence to PD / PT BOs */
>> +    /* Attach eviction fence to PD / PT BOs and DMABuf imports */
>>       list_for_each_entry(peer_vm, &process_info->vm_list_head,
>>                   vm_list_node) {
>>           struct amdgpu_bo *bo = peer_vm->root.bo;
>> @@ -3014,6 +3019,11 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> __rcu *
>>           dma_resv_add_fence(bo->tbo.base.resv,
>> &process_info->eviction_fence->base,
>>                      DMA_RESV_USAGE_BOOKKEEP);
>> +
>> +        ret = amdgpu_vm_fence_imports(peer_vm, &exec.ticket,
>> + &process_info->eviction_fence->base);
>> +        if (ret)
>> +            break;
>>       }
>>     validate_map_fail:
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index e50be6500030..dc7fac778417 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -952,10 +952,10 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>       p->bytes_moved = 0;
>>       p->bytes_moved_vis = 0;
>>   -    r = amdgpu_vm_validate_pt_bos(p->adev, &fpriv->vm,
>> -                      amdgpu_cs_bo_validate, p);
>> +    r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
>> +                   amdgpu_cs_bo_validate, p);
>>       if (r) {
>> -        DRM_ERROR("amdgpu_vm_validate_pt_bos() failed.\n");
>> +        DRM_ERROR("amdgpu_vm_validate() failed.\n");
>>           goto out_free_user_pages;
>>       }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index decbbe3d4f06..055ba2ea4c12 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -377,6 +377,10 @@ amdgpu_dma_buf_move_notify(struct 
>> dma_buf_attachment *attach)
>>       struct amdgpu_vm_bo_base *bo_base;
>>       int r;
>>   +    /* FIXME: This should be after the "if", but needs a fix to 
>> make sure
>> +     * DMABuf imports are initialized in the right VM list.
>> +     */
>> +    amdgpu_vm_bo_invalidate(adev, bo, false);
>>       if (!bo->tbo.resource || bo->tbo.resource->mem_type == 
>> TTM_PL_SYSTEM)
>>           return;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index b1ce22a9b186..68bab2879696 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -187,7 +187,33 @@ static int amdgpu_gem_object_open(struct 
>> drm_gem_object *obj,
>>       else
>>           ++bo_va->ref_count;
>>       amdgpu_bo_unreserve(abo);
>> -    return 0;
>> +
>> +    /* Validate and add eviction fence to DMABuf imports with dynamic
>> +     * attachment in compute VMs. Re-validation will be done by
>> +     * amdgpu_vm_validate and the fence will be updated by
>> +     * amdgpu_vm_fence_imports in 
>> amdgpu_amdkfd_gpuvm_restore_process_bos.
>> +     *
>> +     * Nested locking below for the case that a GEM object is opened in
>> +     * kfd_mem_export_dmabuf. Since the lock below is only taken for 
>> imports,
>> +     * but not for export, this is a different lock class that 
>> cannot lead to
>> +     * circular lock dependencies.
>> +     */
>> +    if (!vm->is_compute_context || !vm->process_info)
>> +        return 0;
>> +    if (!obj->import_attach ||
>> +        !dma_buf_is_dynamic(obj->import_attach->dmabuf))
>> +        return 0;
>> +    mutex_lock_nested(&vm->process_info->lock, 1);
>> +    if (!WARN_ON(!vm->process_info->eviction_fence)) {
>> +        r = amdgpu_amdkfd_bo_validate_and_fence(abo, 
>> AMDGPU_GEM_DOMAIN_GTT,
>> + &vm->process_info->eviction_fence->base);
>> +        if (r)
>> +            dev_warn(adev->dev, "%d: validate_and_fence failed: %d\n",
>> +                 vm->task_info.pid, r);
>> +    }
>> +    mutex_unlock(&vm->process_info->lock);
>> +
>> +    return r;
>>   }
>>     static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 7da71b6a9dc6..ab2662ab4ab8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -426,24 +426,29 @@ uint64_t amdgpu_vm_generation(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>   }
>>     /**
>> - * amdgpu_vm_validate_pt_bos - validate the page table BOs
>> + * amdgpu_vm_validate - validate evicted BOs tracked in the VM
>>    *
>>    * @adev: amdgpu device pointer
>>    * @vm: vm providing the BOs
>> + * @ticket: optional reservation ticket used to reserve the VM
>>    * @validate: callback to do the validation
>>    * @param: parameter for the validation callback
>>    *
>> - * Validate the page table BOs on command submission if neccessary.
>> + * Validate the page table BOs and per-VM BOs on command submission if
>> + * necessary. If a ticket is given, also try to validate evicted 
>> user queue
>> + * BOs. They must already be reserved with the given ticket.
>>    *
>>    * Returns:
>>    * Validation result.
>>    */
>> -int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm,
>> -                  int (*validate)(void *p, struct amdgpu_bo *bo),
>> -                  void *param)
>> +int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm 
>> *vm,
>> +               struct ww_acquire_ctx *ticket,
>> +               int (*validate)(void *p, struct amdgpu_bo *bo),
>> +               void *param)
>>   {
>>       struct amdgpu_vm_bo_base *bo_base;
>>       struct amdgpu_bo *shadow;
>> +    struct dma_resv *resv;
>>       struct amdgpu_bo *bo;
>>       int r;
>>   @@ -464,8 +469,27 @@ int amdgpu_vm_validate_pt_bos(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>           spin_unlock(&vm->status_lock);
>>             bo = bo_base->bo;
>> +        resv = bo->tbo.base.resv;
>>           shadow = amdgpu_bo_shadowed(bo);
>>   +        if (resv != vm->root.bo->tbo.base.resv) {
>> +            if (!ticket) {
>> +                /* We need to move the BO out of the evicted
>> +                 * list to avoid an infinite loop. It will be
>> +                 * moved back to evicted in the next
>> +                 * amdgpu_vm_handle_moved.
>> +                 */
>> +                amdgpu_vm_bo_invalidated(bo_base);
>> +                spin_lock(&vm->status_lock);
>> +                continue;
>> +            }
>> +            if (dma_resv_locking_ctx(resv) != ticket) {
>> +                pr_warn_ratelimited("Evicted user BO is not reserved 
>> in pid %d\n",
>> +                            vm->task_info.pid);
>
> I'm not sure if that's the most defensive option. Might be better to 
> handle this in the "if (!ticket..." case above.

Do you mean, printing the warning, or aborting the validation with an error?

The "if (!ticket)" case above is for callers that don't need to validate 
user BOs for user mode queue usage. This error here is in the case where 
the caller wants to validate user BOs for user mode queues, and the 
caller did not reserve all those BOs. In this case I think I need to 
terminate with an error to avoid enabling queues with invalid BOs.



>
>> +                return -EINVAL;
>> +            }
>> +        }
>> +
>>           r = validate(param, bo);
>>           if (r)
>>               return r;
>> @@ -475,7 +499,13 @@ int amdgpu_vm_validate_pt_bos(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>                   return r;
>>           }
>>   -        if (bo->tbo.type != ttm_bo_type_kernel) {
>> +        if (resv != vm->root.bo->tbo.base.resv) {
>> +            /* Fence reservation for amdgpu_vm_fence_imports */
>> +            r = dma_resv_reserve_fences(resv, 1);
>> +            if (r)
>> +                return r;
>
> Fence slot reservation should bet done by the caller and not here.

The caller doesn't necessarily have the BO list to create all those 
fences. The whole point of doing this in the VM code was, to use the "BO 
lists" maintained by the VM state machine. Having to find all the BOs in 
the caller to add these fences kind of defeats the purpose. Then I can 
do the validation there too, and I don't need to do the validation in 
the VM code at all.

The idea here is, that I reserve the fence slots in amdgpu_vm_validate 
and use the fence slots in amdgpu_vm_fence_imports. Conceptually, 
amdgpu_vm_validate is where we enumerate and validate BOs before command 
submission. This is a convenient place because I already require that 
the BOs must be reserved. amdgpu_vm_fence_imports is where we add the 
fences after command submission. At that point the BOs are not reserved 
any more, and I cannot reserve them without risking race conditions, 
because I'm holding the VM state spinlock.


>
>
>> + amdgpu_vm_bo_invalidated(bo_base);
>> +        } if (bo->tbo.type != ttm_bo_type_kernel) {
>>               amdgpu_vm_bo_moved(bo_base);
>>           } else {
>> vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
>> @@ -1425,11 +1455,21 @@ int amdgpu_vm_handle_moved(struct 
>> amdgpu_device *adev,
>>           }
>>             r = amdgpu_vm_bo_update(adev, bo_va, clear);
>> -        if (r)
>> -            return r;
>>             if (unlock)
>>               dma_resv_unlock(resv);
>> +        if (r)
>> +            return r;
>> +
>> +        /* Remember evicted DMABuf imports in compute VMs for later
>> +         * validation
>> +         */
>> +        if (vm->is_compute_context && bo_va->base.bo &&
>> +            bo_va->base.bo->tbo.base.import_attach &&
>> +            (!bo_va->base.bo->tbo.resource ||
>> +             bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>> +            amdgpu_vm_bo_evicted(&bo_va->base);
>> +
>>           spin_lock(&vm->status_lock);
>>       }
>>       spin_unlock(&vm->status_lock);
>> @@ -1437,6 +1477,51 @@ int amdgpu_vm_handle_moved(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   +/**
>> + * amdgpu_vm_fence_imports - add fence to valid DMABuf imports
>> + *
>> + * @vm: requested vm
>> + * @ticket: reservation ticket used to reserve the VM
>> + * @fence: fence to add
>> + *
>> + * Add the specified fence to all dynamic DMABuf imports that are 
>> valid.
>> + *
>> + * Returns:
>> + * 0 for success.
>> + */
>> +int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
>> +                struct ww_acquire_ctx *ticket,
>> +                struct dma_fence *fence)
>> +{
>> +    struct amdgpu_bo_va *bo_va, *tmp;
>> +    struct dma_resv *resv;
>> +
>> +    if (!vm->is_compute_context)
>> +        return 0;
>> +    if (!ticket)
>> +        return -EINVAL;
>> +
>> +    spin_lock(&vm->status_lock);
>> +    list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>
> Why using list_for_each_entry_safe() here?

Hmm, not sure any more. I must have thought the VM state could change 
here, so things would get removed from the vm->idle list. Must be a 
left-over from a previous revision. I think you're right, I don't need 
the safe version here.

Regards,
   Felix


>
> Regards,
> Christian.
>
>> +        if (!bo_va->base.bo || 
>> !bo_va->base.bo->tbo.base.import_attach ||
>> + !dma_buf_is_dynamic(bo_va->base.bo->tbo.base.import_attach->dmabuf))
>> +            continue;
>> +
>> +        resv = bo_va->base.bo->tbo.base.resv;
>> +        if (dma_resv_locking_ctx(resv) != ticket) {
>> +            pr_warn_ratelimited("Imported BO is not reserved in pid 
>> %d\n",
>> +                        vm->task_info.pid);
>> +            continue;
>> +        }
>> +        dma_resv_add_fence(resv, fence,
>> +                   DMA_RESV_USAGE_BOOKKEEP);
>> +
>> +    }
>> +    spin_unlock(&vm->status_lock);
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * amdgpu_vm_flush_compute_tlb - Flush TLB on compute VM
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index b6cd565562ad..eff301976eee 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -434,9 +434,10 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, 
>> struct drm_exec *exec,
>>                 unsigned int num_fences);
>>   bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>>   uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm);
>> -int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm,
>> -                  int (*callback)(void *p, struct amdgpu_bo *bo),
>> -                  void *param);
>> +int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm 
>> *vm,
>> +               struct ww_acquire_ctx *ticket,
>> +               int (*callback)(void *p, struct amdgpu_bo *bo),
>> +               void *param);
>>   int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job 
>> *job, bool need_pipe_sync);
>>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>                 struct amdgpu_vm *vm, bool immediate);
>> @@ -446,6 +447,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device 
>> *adev,
>>   int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>>                  struct amdgpu_vm *vm,
>>                  struct ww_acquire_ctx *ticket);
>> +int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
>> +                struct ww_acquire_ctx *ticket,
>> +                struct dma_fence *fence);
>>   int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>>                   struct amdgpu_vm *vm,
>>                   uint32_t flush_type,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 2834fb351818..9f29bbdb9050 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1509,9 +1509,9 @@ static int svm_range_reserve_bos(struct 
>> svm_validate_context *ctx, bool intr)
>>               goto unreserve_out;
>>           }
>>   -        r = amdgpu_vm_validate_pt_bos(pdd->dev->adev,
>> -                          drm_priv_to_vm(pdd->drm_priv),
>> -                          svm_range_bo_validate, NULL);
>> +        r = amdgpu_vm_validate(pdd->dev->adev,
>> +                       drm_priv_to_vm(pdd->drm_priv), NULL,
>> +                       svm_range_bo_validate, NULL);
>>           if (r) {
>>               pr_debug("failed %d validate pt bos\n", r);
>>               goto unreserve_out;
>> @@ -1630,7 +1630,9 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>           goto free_ctx;
>>       }
>>   -    svm_range_reserve_bos(ctx, intr);
>> +    r = svm_range_reserve_bos(ctx, intr);
>> +    if (r)
>> +        goto free_ctx;
>>         p = container_of(prange->svms, struct kfd_process, svms);
>>       owner = kfd_svm_page_owner(p, find_first_bit(ctx->bitmap,
>
