Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D046BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 19:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1D810E040;
	Fri,  1 Apr 2022 19:47:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72A610E040
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 19:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbXAD7lI37jsK6AeHJiO2YAwb2z3MF47Mr67NB9Tr/rlFVO7N/W538SvuJq89D7xl1qvFOLdhs6iDsNOD2w9qvRnN9j6xiIBUyF8f/mr6BekS3JQG4TSAgDg6L5VvnUvRsmkWY1SUaxG0ZK/UqVoINK0xUM72hTGdFWjGzYNvJxvNRoqLUOWSm+KIJiWbDgUacOhp6eJKI/ciZEuEr7yJ/k1rmX2s0txB3N/p/aSXm2l2sh98XZ1TMlMeH/pXDf3H9aUYTTjT5VednMAWSxCXWi7t4XAaFdBQnUmkh4PjCMtC6hZkJzhWSSntK9MnWFoqEi1qfUTzYAAFg8MvYi3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IJEEBziv8KAx3JPZo9Eml7meVIrT814XDSIfPW188Y=;
 b=jzQ2TUacmqCioCzn2sztGCIDZ0mHq8AHWDUlYWl7PsCdSOO1pJNbLFEiLkiq39QMIteXSd1ohFmbza0Mkpz7iCk0PZqm8JgnoPqrZiYxr6RE4xwJMO+u7WTO/6sXyh2vZGVc7dXBW8TZ6HE0VRYfx762cLht2pWH7DRTszZ2P/aljl9iLEDzCdlHH9qJ/BnSufkgyEoKeVQc54ew72QmDp5v4F6BfZh0fVjziU5fZ2y2bYyHHjEtCEJ7VQGmJjmwRfPFVRzcWzsnivcj2GX2dY+178lqOiQh+l0sFSL57SOl9AL0xHH63FdotIHwSzAlUC7YjvEx6jn9HL3jpei+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IJEEBziv8KAx3JPZo9Eml7meVIrT814XDSIfPW188Y=;
 b=RYul4D9K3tzBh3NcrPIideLORUBzg70BhsOLDAmTv/imyLWRKZKWHBh3g4f/3ROQqLQvUzkwGudyQ3gHc5HsMEaLhjH6YG3X16OluQI/UA2MLViaTTJoA6Ev15yaBlDcsr1LHoaGo1nFlrMNoK3Nk5xJgVWmodQCGdRMVebAUWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 1 Apr
 2022 19:47:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%3]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 19:47:25 +0000
Message-ID: <b968acc1-53d7-1562-30f9-20f80fbd83ea@amd.com>
Date: Fri, 1 Apr 2022 15:47:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: fix TLB flushing during eviction
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 philip yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org,
 Philip.Yang@amd.com
References: <20220330090032.16218-1-christian.koenig@amd.com>
 <d1191314-478d-cacd-76b3-14a39157231c@amd.com>
 <e957191b-789d-af36-6951-049f038bc47c@gmail.com>
 <03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com>
 <c561a97f-2d72-e50b-2e86-e52c605247a5@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <c561a97f-2d72-e50b-2e86-e52c605247a5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33f3a57f-6ef9-48d3-7050-08da14187207
X-MS-TrafficTypeDiagnostic: PH0PR12MB5632:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB563233E295D2E0FAD10E264C92E09@PH0PR12MB5632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAUe+JR74wX5vMC91Qs3ivnwEeDyIl9HuQehE2ZBXPDAjSfCjcWO9LtgzOVYRCym6p0FN4uJSO9YgqWRotwCzLt7nO9rzgR9+jSthCx1wStIMGLqpWzyBFaalZyyxutoFdNQiZndWlvv8L1wnoteKuUL2SjHhGW15v0baYNA0Xvh6EkQGFX1uBejPy2u+yxJT3Ova8+YHdSHom85JrwNYv8RSnE6EwFJFr/BrVeMCNdE1QR7OlK+/gvpBwxmjpMJstXxobXzh5jXp0Y4h9MNtUf8018Xs9XWPBaN7ZSGPZBvrfwAsYEEEchxn0ISEG0XgFR8Zq/WTub4ZMU9epsby4vEVhDuIoGX2nC8JBiqq61jdK/ESH5x8dkFG+8At27Tv4W+TnwbJVnnKbGLsuKUL7fdx15Kw3J9r0DsIQNEkdE2iF+ANL+djsOK81n/7BFsX1lk49NQ+RwwVPDcB3a8bbFG6W6moaY9nBowPp6bMoEzXG5n3PgDaACOJtb712AGHKovoWXtlBHrNO8xJ4WLGObbjEfIU5hzm94hW84utPKRr17RSbwpeI8zPiCzzhVaoUpDvpy+fTRjHOPzHsCRxW616nOuy97Sgr+royCkyklqRlBxBFbQac3kpvZrz8D5MqHmoJVRPyxUNjinpX/rgdEaWUnSXZ3WzHHOkqH+QOPcqqkbbfY9eOxVV+c4z25NnBLI+s1kD3KiYTZw99lHZoB8Vcjs//+PJ+yfPCFeDoc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6636002)(110136005)(83380400001)(38100700002)(30864003)(31696002)(44832011)(4326008)(316002)(5660300002)(86362001)(66476007)(66946007)(66556008)(2906002)(6486002)(66574015)(8936002)(36916002)(6512007)(186003)(31686004)(508600001)(6506007)(8676002)(26005)(53546011)(2616005)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE8rL2xmcUZkM0hDWEgyc2wzSlRyTzBob1drTUdsUEVPU1lYeU9ZbGJxUkdF?=
 =?utf-8?B?eWVXL09hM1k4eXFvMXZLMWhzUUlCVFJrUmY2OFBkUjViWmtpVHc4ZE85N3Az?=
 =?utf-8?B?WVlncFViUkttYXNMd0pXbVV5N2QvaVBHUkhFMTBoc1g0V0pnYWdEUFJhcXRv?=
 =?utf-8?B?akRQV1NDcnRMNUhrY0p6bHRLTVlWY1VuSFoyc3NWODExUlZLNkc1OGM3OXY1?=
 =?utf-8?B?eEZRdTVhcDdkZHJkSDVWaDNYdzZlMGFDMWhncTNHOVJjd2trRGpkb0ZnUGdt?=
 =?utf-8?B?Q01LZ3JaUzRYV1F5T3VDa3JMNmtiL3I1NTdSQlNkSzRFQTVBb201VWlRUzkx?=
 =?utf-8?B?SGxwcnU3bEFDSkVpTXNaakIwdXN1Q2xzUEc5UjZ0bGRMbUlpcW43Unh1NWgy?=
 =?utf-8?B?WTUyRFNhbXpRTDNGQkMwU2lDMUVkckJubVJJQXFKUUxrWkplWk50TXZ4bFhD?=
 =?utf-8?B?K1dlNSt5WjlPUHpKY0twejg5MTBXd3ZEWXE2V1VOb25DTGprRTNrMU9abWF5?=
 =?utf-8?B?U2VGVVFhSEtiMWVNRFcxWmxqMnFnUXpxUUpWenVldjl0ZUJhRFR1OTV4UjRo?=
 =?utf-8?B?Zjg4YTlCMFBOUHdJUDBFTnFUU2ZPczVZTVNuTTRYWDVyU0lIMERLRGlTK0c3?=
 =?utf-8?B?cTFQZGp0NnZvVDVFTEZidHpjeEV3QVFCV2FLSlE3U1E1NjRKQm5VS2prK0RB?=
 =?utf-8?B?bGRaYzdCZ0djdjNWN2wwdzNiYTd4UWdmUXhIT0huTDNrV1VrL1NDNjNmN1Fw?=
 =?utf-8?B?VEpIQTY3UU8wWHltN01IdHh0YzVnUGd4TWxseFcvM0tiT1hYZFplK1pYN3dn?=
 =?utf-8?B?bFFDV1ZGUGNFL2djWmhYM3d1a1VRQTlqdFJIK016WTdHWm9OaTBXcFFaZi93?=
 =?utf-8?B?M21UWG1PVGFqYzN1M3NOSDNMa0c3ZWVqRGliOUZtSE5DcUxNcTNVSlE4S0Rp?=
 =?utf-8?B?U2lmUUNESXBzSElENGpjUmxOelN4aFZBU1JEbWtNbGlOUkh2b09lQitQdnJT?=
 =?utf-8?B?TVJvMHhIQlRkSkZpQUJLMTBYK3RIQml3YzlkWTJVZzFpZlZWYWorQVFzS2g3?=
 =?utf-8?B?OUtxbjltQ3ZoUlF1MElWd21XelRJbFV2YnpuMFJFZUExcm9RRFpUMmRxRnMx?=
 =?utf-8?B?OW82aG8yNkNsaXo2ZXJwcjhsU1FCQ0c4dFJVaDJ6c0c3NHoxS1BMWXhXZUcz?=
 =?utf-8?B?SjlFYXd1bXFxQzgxZHpOTFBweFY0aEZWc0dUMGdJRUwyQm5Ubk5tZUJyanFi?=
 =?utf-8?B?ZW5mbi9iTVp3WlhlQ2RHRFpxMzFacUxkSjhpRXFjWjBsYXdYVENtUUxmVVlS?=
 =?utf-8?B?cGM5REY0TnVWa3UvaXdZQUgzd2swZGZzYUc0cWpEREYveURmSldURDBacmZx?=
 =?utf-8?B?RHA3MTNsckd2R0hWRjJ0KzVwMW00NmYycTlDQVgyUyt1ZXJ4dTdOTFdmSSs1?=
 =?utf-8?B?OEdBUWJYYWtlYmUwckRxSEo3d2tIaS9WVytDaHdZd2d6bGZjcWlNQzFpdVBk?=
 =?utf-8?B?OWpPdFB2OGQwVE5ZaGo0ZXRRTU05UWVIVGQ5L2NZSVIwWk1QekJHcy9ucTBz?=
 =?utf-8?B?N0x0V2x5aWFjdHlObmYwYlhRbEFPU2pFYVVvdXF5bFJQLzYwb3QyY3VRclZM?=
 =?utf-8?B?TElSL3dNTEY4OGZ3R09MQzVHZWpHWkUyY1M4TEhRMExqRDJRaGh5UVJpT3pq?=
 =?utf-8?B?T3Vsd0F0U1pCYjdPYjMrZWZLOVhUR1lIYkd3VGk5Ty9XWUxZTzBOK3hubHha?=
 =?utf-8?B?TEdpY0J5MThJRFhNR2Y5UVRhZjg2bVZ2RlZQZG9mdmYwQ3RTd1Vka3ZCaWQ4?=
 =?utf-8?B?SFhGdTdVK2tzYUhwdlZuNkJLSlNjUG1ZajBVaXRiZG9keWRBQkRBNUFraFVG?=
 =?utf-8?B?K04wY3h1RjFKczBFWHEwY1pod3pFWWJTakUzOVZOdDF5MklVRUs5T29USWUz?=
 =?utf-8?B?QXJqeWV0N3J4RytsMjluc205Q3VVNWJMQmJvSkY5cVdqaldOeHhPbHg5d1Nk?=
 =?utf-8?B?WE9kbmhFWGFZNEZTcWQ2bmt2OExNNDM5RGduVmVsMlpGOUN2VHY1dXRoajN6?=
 =?utf-8?B?OSsxdkdyUFdoZ2tlbW9LMm1zOXFsOUx6c0xXZWNTREdEcnhzUXZLL1F6bjU5?=
 =?utf-8?B?NFA0SkVnMG9wR1p4WnRhTzdKT0orYUgwREsvTTRiVzRzVVhJOFdUbVJUcXJz?=
 =?utf-8?B?UmFxaEpyVGFsc1cva25Ic2RFK3ZwaXpzT1lmZkhEc1RhcXdJYlZpVnhzU1Ja?=
 =?utf-8?B?MGR2OVRKb0ZWU1ZMU1pxK0NxOCtFREJwQXBqSEN6R2V4RHp1emhTNXRaaFZp?=
 =?utf-8?B?R1F4OVREZ0FtVnlQVGlCdm5xRzRaUGRpeHdHZ1ZxVFFGZVpjTWlKZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f3a57f-6ef9-48d3-7050-08da14187207
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 19:47:25.3102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkndX2deeC433bS4AlBc4mYTzT3lcOpKufH1jTSyrfzcqGWGS6rxy7AP8oUSNvUK5p4wWA2zp9muZI1OxYPxHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-04-01 04:24, Christian König wrote:
> Am 31.03.22 um 16:37 schrieb Felix Kuehling:
>> Am 2022-03-31 um 02:27 schrieb Christian König:
>>> Am 30.03.22 um 22:51 schrieb philip yang:
>>>>
>>>>
>>>> On 2022-03-30 05:00, Christian König wrote:
>>>>> Testing the valid bit is not enough to figure out if we
>>>>> need to invalidate the TLB or not.
>>>>>
>>>>> During eviction it is quite likely that we move a BO from VRAM to 
>>>>> GTT and
>>>>> update the page tables immediately to the new GTT address.
>>>>>
>>>>> Rework the whole function to get all the necessary parameters 
>>>>> directly as
>>>>> value.
>>>>>
>>>>> Signed-off-by: Christian König<christian.koenig@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 63 
>>>>> ++++++++++++++------------
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 18 ++++----
>>>>>   3 files changed, 48 insertions(+), 48 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index 9992a7311387..1cac90ee3318 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -793,18 +793,19 @@ static void amdgpu_vm_tlb_seq_cb(struct 
>>>>> dma_fence *fence,
>>>>>   }
>>>>>     /**
>>>>> - * amdgpu_vm_bo_update_mapping - update a mapping in the vm page 
>>>>> table
>>>>> + * amdgpu_vm_update_range - update a range in the vm page table
>>>>>    *
>>>>> - * @adev: amdgpu_device pointer of the VM
>>>>> - * @bo_adev: amdgpu_device pointer of the mapped BO
>>>>> - * @vm: requested vm
>>>>> + * @adev: amdgpu_device pointer to use for commands
>>>>> + * @vm: the VM to update the range
>>>>>    * @immediate: immediate submission in a page fault
>>>>>    * @unlocked: unlocked invalidation during MM callback
>>>>> + * @flush_tlb: trigger tlb invalidation after update completed
>>>>>    * @resv: fences we need to sync to
>>>>>    * @start: start of mapped range
>>>>>    * @last: last mapped entry
>>>>>    * @flags: flags for the entries
>>>>>    * @offset: offset into nodes and pages_addr
>>>>> + * @vram_base: base for vram mappings
>>>>>    * @res: ttm_resource to map
>>>>>    * @pages_addr: DMA addresses to use for mapping
>>>>>    * @fence: optional resulting fence
>>>>> @@ -812,17 +813,14 @@ static void amdgpu_vm_tlb_seq_cb(struct 
>>>>> dma_fence *fence,
>>>>>    * Fill in the page table entries between @start and @last.
>>>>>    *
>>>>>    * Returns:
>>>>> - * 0 for success, -EINVAL for failure.
>>>>> + * 0 for success, negative erro code for failure.
>>>>>    */
>>>>> -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>>>>> -                struct amdgpu_device *bo_adev,
>>>>> -                struct amdgpu_vm *vm, bool immediate,
>>>>> -                bool unlocked, struct dma_resv *resv,
>>>>> -                uint64_t start, uint64_t last,
>>>>> -                uint64_t flags, uint64_t offset,
>>>>> -                struct ttm_resource *res,
>>>>> -                dma_addr_t *pages_addr,
>>>>> -                struct dma_fence **fence)
>>>>> +int amdgpu_vm_update_range(struct amdgpu_device *adev, struct 
>>>>> amdgpu_vm *vm,
>>>>> +               bool immediate, bool unlocked, bool flush_tlb,
>>>>> +               struct dma_resv *resv, uint64_t start, uint64_t last,
>>>>> +               uint64_t flags, uint64_t offset, uint64_t vram_base,
>>>>> +               struct ttm_resource *res, dma_addr_t *pages_addr,
>>>>> +               struct dma_fence **fence)
>>>>>   {
>>>>>       struct amdgpu_vm_update_params params;
>>>>>       struct amdgpu_vm_tlb_seq_cb *tlb_cb;
>>>>> @@ -910,8 +908,7 @@ int amdgpu_vm_bo_update_mapping(struct 
>>>>> amdgpu_device *adev,
>>>>>               }
>>>>>             } else if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
>>>>> -            addr = bo_adev->vm_manager.vram_base_offset +
>>>>> -                cursor.start;
>>>>> +            addr = vram_base + cursor.start;
>>>>>           } else {
>>>>>               addr = 0;
>>>>>           }
>>>>> @@ -927,7 +924,7 @@ int amdgpu_vm_bo_update_mapping(struct 
>>>>> amdgpu_device *adev,
>>>>>         r = vm->update_funcs->commit(&params, fence);
>>>>>   -    if (!(flags & AMDGPU_PTE_VALID) || params.table_freed) {
>>>>> +    if (flush_tlb || params.table_freed) {
>>>>
>>>> All change look good to me, but when I look at previous changes 
>>>> again, kfd_ioctl_map_memory_to_gpu is not correct now, as this 
>>>> should flush TLB if (!kfd_flush_tlb_after_unmap(dev)).
>>>>
>>>
>>> That was intentionally dropped as Felix said it wouldn't be 
>>> necessary any more with the TLB flush rework.
>>>
>>> Is that really causing any trouble?
>>
>> I discussed it with Philip offline. The TLB flushing in 
>> kfd_ioctl_map_memory_to_gpu is still there, but it is no longer 
>> conditional on !kfd_flush_tlb_after_unmap. Instead kfd_flush_tlb 
>> checks the sequence number to find out if the flush is needed 
>> (presumably because we didn't flush after unmap).
>>
>> There is one case on Vega20+XGMI where PTEs get inadvertently cached 
>> in L2 texture cache.
>
> Ah, that one. Yeah I do remember that issue.
>
>> In that case, we probably need to flush more frequently because a 
>> cache line in L2 may contain stale invalid PTEs. So kfd_flush_tlb 
>> would need to ignore the sequence number and heavy-weight flush TLB 
>> unconditionally in this case.
>
> Ok, but I think that is outside of the scope of the VM handling then. 
> Or should we somehow handle that in the VM code as well?

I think it would make sense to apply the workaround in the VM code now. 
You'd need to do this on all mappings on Vega20+XGMI. It doesn't matter 
whether the mapping itself involves XGMI. AIUI, the incorrect caching 
happens for all mappings when the XGMI bridge is physically present.


>
> I mean incrementing the sequence when the involved BO is mapped 
> through XGMI is trivial. I just can't easily signal that we need a 
> heavy-weight flush.

There is already code in gmc_v9_0.c to force heavy-weight flushing, and 
doing an double flush to make sure the TLB is flushed after the L2 
texture cache. grep -A4 "Vega20+XGMI" gmc_v9_0.c for details.

Regards,
   Felix


>
> Thanks,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>>
>>> Christian.
>>>
>>>> To fix it, seems we need beow change, then pass flush_tlb flag via 
>>>> kfd_ioctl_map_memory_to_gpu -> map_bo_to_gpuvm -> update_gpuvm_pte 
>>>> -> amdgpu_vm_bo_update
>>>>
>>>> -int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct 
>>>> amdgpu_bo_va *bo_va,
>>>>             bool clear)
>>>>
>>>> -    bool flush_tlb = clear;
>>>>
>>>> +int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct 
>>>> amdgpu_bo_va *bo_va,
>>>>             bool clear, bool flush_tlb)
>>>>
>>>> + flush_tlb |= clear;
>>>>
>>>> Regards,
>>>>
>>>> Philip
>>>>
>>>>>           tlb_cb->vm = vm;
>>>>>           if (!fence || !*fence ||
>>>>>               dma_fence_add_callback(*fence, &tlb_cb->cb,
>>>>> @@ -1010,9 +1007,10 @@ int amdgpu_vm_bo_update(struct 
>>>>> amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>>>       dma_addr_t *pages_addr = NULL;
>>>>>       struct ttm_resource *mem;
>>>>>       struct dma_fence **last_update;
>>>>> +    bool flush_tlb = clear;
>>>>>       struct dma_resv *resv;
>>>>> +    uint64_t vram_base;
>>>>>       uint64_t flags;
>>>>> -    struct amdgpu_device *bo_adev = adev;
>>>>>       int r;
>>>>>         if (clear || !bo) {
>>>>> @@ -1037,14 +1035,18 @@ int amdgpu_vm_bo_update(struct 
>>>>> amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>>>       }
>>>>>         if (bo) {
>>>>> +        struct amdgpu_device *bo_adev = adev;
>>>>> +
>>>>>           flags = amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, mem);
>>>>>             if (amdgpu_bo_encrypted(bo))
>>>>>               flags |= AMDGPU_PTE_TMZ;
>>>>>             bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>>>> +        vram_base = bo_adev->vm_manager.vram_base_offset;
>>>>>       } else {
>>>>>           flags = 0x0;
>>>>> +        vram_base = 0;
>>>>>       }
>>>>>         if (clear || (bo && bo->tbo.base.resv ==
>>>>> @@ -1054,7 +1056,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>>>> *adev, struct amdgpu_bo_va *bo_va,
>>>>>           last_update = &bo_va->last_pt_update;
>>>>>         if (!clear && bo_va->base.moved) {
>>>>> -        bo_va->base.moved = false;
>>>>> +        flush_tlb = true;
>>>>>           list_splice_init(&bo_va->valids, &bo_va->invalids);
>>>>>         } else if (bo_va->cleared != clear) {
>>>>> @@ -1077,11 +1079,11 @@ int amdgpu_vm_bo_update(struct 
>>>>> amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>>>             trace_amdgpu_vm_bo_update(mapping);
>>>>>   -        r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, 
>>>>> false, false,
>>>>> -                        resv, mapping->start,
>>>>> -                        mapping->last, update_flags,
>>>>> -                        mapping->offset, mem,
>>>>> -                        pages_addr, last_update);
>>>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, 
>>>>> flush_tlb,
>>>>> +                       resv, mapping->start, mapping->last,
>>>>> +                       update_flags, mapping->offset,
>>>>> +                       vram_base, mem, pages_addr,
>>>>> +                       last_update);
>>>>>           if (r)
>>>>>               return r;
>>>>>       }
>>>>> @@ -1104,6 +1106,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>>>> *adev, struct amdgpu_bo_va *bo_va,
>>>>>         list_splice_init(&bo_va->invalids, &bo_va->valids);
>>>>>       bo_va->cleared = clear;
>>>>> +    bo_va->base.moved = false;
>>>>>         if (trace_amdgpu_vm_bo_mapping_enabled()) {
>>>>>           list_for_each_entry(mapping, &bo_va->valids, list)
>>>>> @@ -1272,10 +1275,10 @@ int amdgpu_vm_clear_freed(struct 
>>>>> amdgpu_device *adev,
>>>>>               mapping->start < AMDGPU_GMC_HOLE_START)
>>>>>               init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
>>>>>   -        r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, 
>>>>> false,
>>>>> -                        resv, mapping->start,
>>>>> -                        mapping->last, init_pte_value,
>>>>> -                        0, NULL, NULL, &f);
>>>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, true, 
>>>>> resv,
>>>>> +                       mapping->start, mapping->last,
>>>>> +                       init_pte_value, 0, 0, NULL, NULL,
>>>>> +                       &f);
>>>>>           amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>>>           if (r) {
>>>>>               dma_fence_put(f);
>>>>> @@ -2519,8 +2522,8 @@ bool amdgpu_vm_handle_fault(struct 
>>>>> amdgpu_device *adev, u32 pasid,
>>>>>           goto error_unlock;
>>>>>       }
>>>>>   -    r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, 
>>>>> false, NULL, addr,
>>>>> -                    addr, flags, value, NULL, NULL, NULL);
>>>>> +    r = amdgpu_vm_update_range(adev, vm, true, false, false, 
>>>>> NULL, addr,
>>>>> +                   addr, flags, value, 0, NULL, NULL, NULL);
>>>>>       if (r)
>>>>>           goto error_unlock;
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index 6b7682fe84f8..1a814fbffff8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -402,15 +402,12 @@ int amdgpu_vm_handle_moved(struct 
>>>>> amdgpu_device *adev,
>>>>>                  struct amdgpu_vm *vm);
>>>>>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>>>>                   struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>>>>> -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>>>>> -                struct amdgpu_device *bo_adev,
>>>>> -                struct amdgpu_vm *vm, bool immediate,
>>>>> -                bool unlocked, struct dma_resv *resv,
>>>>> -                uint64_t start, uint64_t last,
>>>>> -                uint64_t flags, uint64_t offset,
>>>>> -                struct ttm_resource *res,
>>>>> -                dma_addr_t *pages_addr,
>>>>> -                struct dma_fence **fence);
>>>>> +int amdgpu_vm_update_range(struct amdgpu_device *adev, struct 
>>>>> amdgpu_vm *vm,
>>>>> +               bool immediate, bool unlocked, bool flush_tlb,
>>>>> +               struct dma_resv *resv, uint64_t start, uint64_t last,
>>>>> +               uint64_t flags, uint64_t offset, uint64_t vram_base,
>>>>> +               struct ttm_resource *res, dma_addr_t *pages_addr,
>>>>> +               struct dma_fence **fence);
>>>>>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>>>>               struct amdgpu_bo_va *bo_va,
>>>>>               bool clear);
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> index 27533f6057e0..907b02045824 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> @@ -1188,9 +1188,9 @@ svm_range_unmap_from_gpu(struct 
>>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>>         pr_debug("[0x%llx 0x%llx]\n", start, last);
>>>>>   -    return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, 
>>>>> true, NULL,
>>>>> -                       start, last, init_pte_value, 0,
>>>>> -                       NULL, NULL, fence);
>>>>> +    return amdgpu_vm_update_range(adev, vm, false, true, true, 
>>>>> NULL, start,
>>>>> +                      last, init_pte_value, 0, 0, NULL, NULL,
>>>>> +                      fence);
>>>>>   }
>>>>>     static int
>>>>> @@ -1277,12 +1277,12 @@ svm_range_map_to_gpu(struct 
>>>>> kfd_process_device *pdd, struct svm_range *prange,
>>>>>                (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>>>>>                pte_flags);
>>>>>   -        r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, 
>>>>> false, false,
>>>>> -                        NULL, last_start,
>>>>> -                        prange->start + i, pte_flags,
>>>>> -                        last_start - prange->start,
>>>>> -                        NULL, dma_addr,
>>>>> -                        &vm->last_update);
>>>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, false, 
>>>>> NULL,
>>>>> +                       last_start, prange->start + i,
>>>>> +                       pte_flags,
>>>>> +                       last_start - prange->start,
>>>>> + bo_adev->vm_manager.vram_base_offset,
>>>>> +                       NULL, dma_addr, &vm->last_update);
>>>>>             for (j = last_start - prange->start; j <= i; j++)
>>>>>               dma_addr[j] |= last_domain;
>>>
>
