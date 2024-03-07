Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB14C54798
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 22:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9353310E415;
	Thu,  7 Mar 2024 22:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LvW0/+/Z";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89CBF10EE74
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 22:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxZFgKRGIswMohxgP7H3VVc61IvGbdnuLVLP7sicPI45HSfuO1NQ9Iw5H366ytkRwHvqAiL9yOYM/sNBtaYRiRB8wTnwCClJ+gRsT6NiYBrS9E3cjiUYPafvFkg/KQXlWhnqY7zbbwioQaFEClSrY7v90y6whYymnt6jVYaP5M4yVCe4ZWAnNDF1DR9x+MbyPhPGX+3AZ5AgtXkKwc2kM2uFTSqgMwcMQPlDlrR8z8tiQ4+uFKlZ18l8dnKUxvuCexHBnBbTCx+6+yOzE729n5cPZKHMNWVm5x/iDW0VeDca+2Oxnte4IJsdeACRRaNgV4pezoftQyIg3vBDpB69tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXWIJMcWgnLksJ2PYAwrTiwjL5X7dTGpSu4KyBbnRKs=;
 b=A1aCMKai4ZUPsQ76qFkcL+Ia9sxV6UH1qllD3OrH3beG0ynDjRvLtaU9kh7eqwItfj2wC8Y548v5vJt8SnWbMkus7VZT2N3M84VRUCyejjZEozNDVY7KsDwmg++9k3vfCsW6f5GRN+fKCK433Rk9siC7DQ+m+/UCuBJOGFu5fj7dQDzISJwuemckUh5iUu8kvlHr5MgapAJDQeWhKxAcidy6BUPsZh/iTwSWEPNUJeCD7u57uXkl2kTv3XFAE26f3kRtkTfeRRTYkvBZR0Vo4JOlhlc0eXmSeRcXhkRqVPA9UR2I2hFqjnrU/LAznwOJv9bG17NxTSoLoKBd8EriZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXWIJMcWgnLksJ2PYAwrTiwjL5X7dTGpSu4KyBbnRKs=;
 b=LvW0/+/ZSHUeMNrP7HpyrzhTvzFFMW0urjEPLv5WTitUh6PWb4Q4PTbQKqJPk0ws8sOEZqF+Tx/Yt2r5BipVlC40Nc2Cf830y8ij9aQUmnOKiNSJ9T7MK+PSZ91qQMjpR3ttatHdmqiAidibzkhTQVOJLjFobg/7HL4nHObJkbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 22:44:15 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::1bdc:c8ea:c3df:ee86]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::1bdc:c8ea:c3df:ee86%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 22:44:15 +0000
Message-ID: <a38728b4-6e21-4218-b5d1-b0f615f99118@amd.com>
Date: Thu, 7 Mar 2024 17:44:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <yangp@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240306144115.1007-1-shashank.sharma@amd.com>
 <92ce9da0-9e89-4fa0-a85f-c6090a067525@amd.com>
 <7ab9ea0e-4545-c461-661a-7050cf88d812@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <7ab9ea0e-4545-c461-661a-7050cf88d812@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::24) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 061758ac-74b4-44b4-7097-08dc3ef81dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DeVo5D90v3bYkoT72vVascqvfuuK1tJ4NnDC6yhJB1t5pf2aRaJt5CR6We5idnWxzm6r2agarCWEKJXCELj1o2d73qdOA2kYhRpEPNVORL4QMGQP1c9uqvOJuOALYaKNQml9Z0MD79K9h42vFc30qbFSTWsrSovLB/BD1wg+Z0VfMh2/dJb0EWvOe7hCWiXuZl87/TQZDHRhYUG/bdGtd1HdnmM5QLeaLV5tDXl/DV5hQjC3Se5Wu183cLS/Mza6ZQixggMPPQaORoytxysVIIudfBh4XsaPE2Zu2NSn00WkiSOlSenN0jtdwUT7Di0XY2Nl9+sUVdPl/gPvmANg/WoEa3hpNgFxQyNvD6jVt4qJy2cMXTXmBLWg8sfUufwVjZ53QeRYykz/5JnljCtJwgP7+Cp84lZpm9LQAgLzaIdeAQqiW0JN0WIFEtRPjhMVqgWSWUvyYgqobsdAOwW1qmQHFqTcNPbk/1q1JVB2AmCUFduEkmqqPo3pQgNjPCvsQdTsrrYxMZ1WyZkGN7s0i21HNrGAhaEg18Cg30+Bunc5GTfopNE0ms5HbIhiWNYX0K48MLRipnWAF9o8k70bpaxLhkZHx+0w3Dz7/QNrPKtLoL5132W++EJ0EmhxFd3yRsx6sCovsoLq7bg2k+BbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2M4NElBbUZraENVMkRIV1h4ZVA0TFg0RWN5bHk1bkhrUW1CeGlwcW8wNUdx?=
 =?utf-8?B?TDRRakFodVVVSnpMdHpsT1pYQkpjRDB2dTlSd3VWRE1odVQzWC9FR0pVYnYw?=
 =?utf-8?B?VmJOdXkyUjc5SDhtdGw3dC83NXhESkxkUmdDd3Q3TUwwa2Y2ekEzNWlzYSta?=
 =?utf-8?B?eGZReStZWTM5OC95WVpkRkJVM1FlaXpNVVQ0MnNZb0JjaGNPV1BORlBSalhm?=
 =?utf-8?B?MnVLRVk1SkJLdmJJOWlkU3FLK1RLVUYwR0RzMU9lYmFNdCtCMGhFYktFejBu?=
 =?utf-8?B?ODV2NW5GOEt1bzJOMGVnTWtwWW9QU01BRzBwSDIrUnlnL0hQUEpNY25nVW5P?=
 =?utf-8?B?dERuT0Z6ZndyOW5xRnV0RDZlZzlMM08zY0JYU3phMkJUd2lSZEtZb3JxY0l3?=
 =?utf-8?B?NjVkV2tYNzBUYjRaajJBT1l0WmRCY0s1VzRycmZnTDB2SG0ybUk3NDFPc1Ux?=
 =?utf-8?B?dFF0R2RvemxjNGJQTjJZSld6cXdOenhEQWhGT1hRVnhrZ2dzK2podm12ZUZJ?=
 =?utf-8?B?UmpLSVVxdzZ2YS9yWFVFNUd1S1BBZ3I4alcvRHF4Y2FWMHRGUmpOdmtwSDVV?=
 =?utf-8?B?SWZ2eTNXUTg0QlV1TUp3Z2xoc3FSS3kxT2JqTktEblFSaCtMR0FjbjJqQjIy?=
 =?utf-8?B?UG96ZmlMZjVzNUx0Vm1CMEdZT09TY1FvdEVQYmZhRWJtU1FmUnV1c0FBWGZP?=
 =?utf-8?B?WlRwaHRHYlpydmhsRExBM1Z5VnorOEdDcGVxanMxWUpQVkw0RzZwSG1HbitY?=
 =?utf-8?B?N1B1cjhzbXNmWmxuRGVTcFdxMWtXUHl3TENOb2U5STRDblltYUNOZCsxWFJm?=
 =?utf-8?B?OWV2cFRJQmdFcWpQV0FuUDUxRXJvV21NY0NvdG1mYkpjeXdMQmkwbnpxWjJN?=
 =?utf-8?B?TXdyeHlMaVRmWFhtYkRzRWhrSzFqMi8zbDhqM2w2aE1jWWx0M3BsWlQ2T2pi?=
 =?utf-8?B?SnJ0TC80YWRCU3htcHJYMnh3b2FRdFlhTlhLcFpKTVd1RG5Za2NxQUdUbmFD?=
 =?utf-8?B?a2Nuejdjb0JkU3J1QUVCT0xxQWN1TTN0S0pjRThTWVNxTncrWm1kSHZBcS9L?=
 =?utf-8?B?MTIvTmg1QUtoby80Z1hvMGVBSnpqUnM1ZFc4TEVteVdtZGN4OUtydENEUkJv?=
 =?utf-8?B?dk9SSGtlVUJ3TXp0SHBIVDZsYUpsMG4yb1lOVUgvSlVqUUk2M1B3dDNqZ2Rs?=
 =?utf-8?B?QVZmYmZnYjRpa2lpOUFrWHU0OTlPdCtzVXVkWjFsNDlMczVaVDFFSkZXV0Zl?=
 =?utf-8?B?Ymtzdmk1ZnRmTXJZa3MwTE5rZGFSTEFFcnlpdjFtYXZDQlRsSnIxQWxuelJm?=
 =?utf-8?B?QXVmMlZmYUcrakZ1aTNGakFoQzNSS1NNdnFHNEkwL0NqdHFuZlpkdzZJNEtn?=
 =?utf-8?B?S3pETkZSbGZnT2dJVndYdjNmcEEyRkJONVQvdEw1K3Y1NnA2TE4yRlhyekkr?=
 =?utf-8?B?Z2JoZXhGZFdNblEyOVBySUNWeitobnloSGdYYTVDM3kxOCs4eHVmVU5CNWFt?=
 =?utf-8?B?Vk1xS0VHc25VcXBmaGhtQXpxYTJDMjV0Q1k5TjY2Wmxid2xKYWlKZkYvYWp5?=
 =?utf-8?B?MmVOYXZqVDdLRnliS1IrczN0R05tVjNiMVF4Qy94RTlzYU1TNFR0YVF3dHBL?=
 =?utf-8?B?OFJEc0NkSWEvYW12YzZGdXJlSWVPNTR4OHdJRDBCMm1GanBPS1Jvb0tiMnEw?=
 =?utf-8?B?bGRidFpqTWMxM2V0c0tCaDBwVU5pWkFqMU02Um43Tm40V0pLTWlEQVNJbDZY?=
 =?utf-8?B?MTdPdkVkaFZtZHhYWEJhdCtDKzJFRHpsbndlSFROUHJTaWs4TjZhQ01jY2ZV?=
 =?utf-8?B?NFZpbWFVVVFBYzJZTiswSnczK0Q5SElXaEtkbDlIaUhtdE1adXQwVmdGc2NM?=
 =?utf-8?B?elJWZjNKRWlQZlI1dmRiSy9PekNxeGxVVWVZUmVJcFR5eGNsME9XWFJRUTNp?=
 =?utf-8?B?WXhJb283UjFkLzQ4c1BSY2o0MCs5ME1rTWgxVEhPTjBUSXlLMUNQK2ovUmNq?=
 =?utf-8?B?MWVsbXZRYUZZTVNaQzVVRjNzbkxUa1NTK2pwRGt4VmNRSFF6Sm1mUXhtQkhM?=
 =?utf-8?B?eTEwVzZNSmlhQjE0MnhjUWVINzRCd1p1enpDcU00NWdMaTFWV3QwMDNLcnN2?=
 =?utf-8?Q?aSkJlCrbpwmlzFJArMEmqBWfl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061758ac-74b4-44b4-7097-08dc3ef81dad
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 22:44:15.2085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zj8USQM9QiNdRSNrIFnDEo863AbDm7yY3KX6XIudzO/Cp2Ly7tXqZnE106mNYdXQElTuIIaHz9aq0I+LzLKrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
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

On 2024-03-07 1:39, Sharma, Shashank wrote:
>
> On 07/03/2024 00:54, Felix Kuehling wrote:
>>
>> On 2024-03-06 09:41, Shashank Sharma wrote:
>>> From: Christian König <christian.koenig@amd.com>
>>>
>>> The problem is that when (for example) 4k pages are replaced
>>> with a single 2M page we need to wait for change to be flushed
>>> out by invalidating the TLB before the PT can be freed.
>>>
>>> Solve this by moving the TLB flush into a DMA-fence object which
>>> can be used to delay the freeing of the PT BOs until it is signaled.
>>>
>>> V2: (Shashank)
>>>      - rebase
>>>      - set dma_fence_error only in case of error
>>>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>>>      - use vm->pasid when f is NULL (Mukul)
>>>
>>> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>>>      - move the misplaced fence_create call to the end (Philip)
>>>
>>> V5: - free the f->dependency properly (Christian)
>>>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 
>>> ++++++++++++++++++
>>>   4 files changed, 128 insertions(+), 1 deletion(-)
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index fa26a4e3a99d..91ab4cf29b5b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o 
>>> amdgpu_kms.o \
>>>       amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>> -    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>> amdgpu_pll.o \
>>> +    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o 
>>> amdgpu_vm_tlb_fence.o \
>>> +    amdgpu_ib.o amdgpu_pll.o \
>>>       amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>> amdgpu_virt.o \
>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 0960e0a665d3..310aae6fb49b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -988,6 +988,15 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>         r = vm->update_funcs->commit(&params, fence);
>>>   +    /* Prepare a TLB flush fence to be attached to PTs */
>>> +    if (!unlocked && params.needs_flush && vm->is_compute_context) {
>>> +        amdgpu_vm_tlb_fence_create(adev, vm, fence);
>>
>> This schedules a TLB flush after "fence" signals and replaces "fence" 
>> with a new one that will signal after the TLB flush is done. That 
>> part I understand.
>>
>> I'm not sure why this only applies to compute contexts.
>>
>>
>>> +
>>> +        /* Makes sure no PD/PT is freed before the flush */
>>> +        dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>>> +                   DMA_RESV_USAGE_BOOKKEEP);
>>
>> But what's the point of adding the fence to the page table 
>> reservation? This is after the BOs have already been freed. Maybe it 
>> would make more sense to move this into the next patch, where the 
>> freeing is done after this point.
>
> To make it easier for code review, the split of the patches is like:
> - one patch introduces function creating tlb_flush_fence and uses it
>
> - the second patch does the rework and movement of freeing of the 
> buffer after the patch attach.
>
> If we move this change into next patch, in this patch we will just 
> create the fence, where one can argue why create the fence if no one 
> is using it.
>
> May be, we can make 'changes in freeing of buffers' as first patch in 
> sequence, and make this second patch in the series, so that you know 
> the background of changes better.

Sure. I don't think it's super important. I was just trying to 
understand how the two patches fit together. I think it makes sense now. 
I discussed this also with Philip offline. We think there may be an 
easier way to solve the "wait for TLB flush before freeing BOs" thing, 
but I believe using the new TLB flush fence is architecturally cleaner, 
and that fence will be useful to solve some other issues that are either 
still lingering, or currently have only some ugly workarounds. I'll need 
to dig through the code and my memory to remember the details.

I'm still not sure whether the creation of the TLB flush fence should be 
limited to compute contexts, but I'm happy to get them at least there 
for now. The series is

Acked-by: Felix Kuehling <felix.kuehling@amd.com>

Regards,
   Felix


>
> - Shashank
>
>>
>> Regards,
>>   Felix
>>
>>
>>> +    }
>>> +
>>>   error_unlock:
>>>       amdgpu_vm_eviction_unlock(vm);
>>>       drm_dev_exit(idx);
>>> @@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>>> struct amdgpu_vm *vm,
>>>         mutex_init(&vm->eviction_lock);
>>>       vm->evicting = false;
>>> +    vm->tlb_fence_context = dma_fence_context_alloc(1);
>>>         r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>>>                   false, &root, xcp_id);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 64b3f69efa57..298f604b8e5f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -341,6 +341,7 @@ struct amdgpu_vm {
>>>       atomic64_t        tlb_seq;
>>>       uint64_t        tlb_seq_va;
>>>       uint64_t        *tlb_seq_cpu_addr;
>>> +    uint64_t        tlb_fence_context;
>>>         atomic64_t        kfd_last_flushed_seq;
>>>   @@ -594,5 +595,8 @@ void amdgpu_vm_update_fault_cache(struct 
>>> amdgpu_device *adev,
>>>                     uint64_t addr,
>>>                     uint32_t status,
>>>                     unsigned int vmhub);
>>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>>> +                 struct amdgpu_vm *vm,
>>> +                 struct dma_fence **fence);
>>>     #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>> new file mode 100644
>>> index 000000000000..51cddfa3f1e8
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>> @@ -0,0 +1,112 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>> +/*
>>> + * Copyright 2023 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the 
>>> "Software"),
>>> + * to deal in the Software without restriction, including without 
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to 
>>> whom the
>>> + * Software is furnished to do so, subject to the following 
>>> conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be 
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + */
>>> +
>>> +#include <linux/dma-fence.h>
>>> +#include <linux/workqueue.h>
>>> +
>>> +#include "amdgpu.h"
>>> +#include "amdgpu_vm.h"
>>> +#include "amdgpu_gmc.h"
>>> +
>>> +struct amdgpu_tlb_fence {
>>> +    struct dma_fence    base;
>>> +    struct amdgpu_device    *adev;
>>> +    struct dma_fence    *dependency;
>>> +    struct work_struct    work;
>>> +    spinlock_t        lock;
>>> +    uint16_t        pasid;
>>> +
>>> +};
>>> +
>>> +static const char *amdgpu_tlb_fence_get_driver_name(struct 
>>> dma_fence *fence)
>>> +{
>>> +    return "amdgpu tlb fence";
>>> +}
>>> +
>>> +static const char *amdgpu_tlb_fence_get_timeline_name(struct 
>>> dma_fence *f)
>>> +{
>>> +    return "amdgpu tlb timeline";
>>> +}
>>> +
>>> +static void amdgpu_tlb_fence_work(struct work_struct *work)
>>> +{
>>> +    struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
>>> +    int r;
>>> +
>>> +    if (f->dependency) {
>>> +        dma_fence_wait(f->dependency, false);
>>> +        dma_fence_put(f->dependency);
>>> +        f->dependency = NULL;
>>> +    }
>>> +
>>> +    r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
>>> +    if (r) {
>>> +        dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
>>> +            f->pasid);
>>> +        dma_fence_set_error(&f->base, r);
>>> +    }
>>> +
>>> +    dma_fence_signal(&f->base);
>>> +    dma_fence_put(&f->base);
>>> +}
>>> +
>>> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>>> +    .use_64bit_seqno = true,
>>> +    .get_driver_name = amdgpu_tlb_fence_get_driver_name,
>>> +    .get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>>> +};
>>> +
>>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm,
>>> +                struct dma_fence **fence)
>>> +{
>>> +    struct amdgpu_tlb_fence *f;
>>> +
>>> +    f = kmalloc(sizeof(*f), GFP_KERNEL);
>>> +    if (!f) {
>>> +        /*
>>> +         * We can't fail since the PDEs and PTEs are already 
>>> updated, so
>>> +         * just block for the dependency and execute the TLB flush
>>> +         */
>>> +        if (*fence)
>>> +            dma_fence_wait(*fence, false);
>>> +
>>> +        amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>>> +        *fence = dma_fence_get_stub();
>>> +        return;
>>> +    }
>>> +
>>> +    f->adev = adev;
>>> +    f->dependency = *fence;
>>> +    f->pasid = vm->pasid;
>>> +    INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>>> +    spin_lock_init(&f->lock);
>>> +
>>> +    dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
>>> +               vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
>>> +
>>> +    /* TODO: We probably need a separate wq here */
>>> +    dma_fence_get(&f->base);
>>> +    schedule_work(&f->work);
>>> +
>>> +    *fence = &f->base;
>>> +}
