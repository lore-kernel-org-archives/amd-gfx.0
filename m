Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC54EC48BF6
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 06:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5936710F0B9;
	Thu,  7 Mar 2024 06:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NwR6OUpS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E11810F0B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 06:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dul8xZ53Q3oD/9GCFjw31F+411a704dFOnxiLT6ZQsU/PaStIntnqMcQyEeL1Bs/OYKVJgzdwshVe1WJf7jrcR6yatpb2nWyHrtfMYTZaamEYkJbzFOZ0rsVb+GseRx7sqy56j7ktniW6RmAKHoo0XvQxspzfE+vynwUQ+QH6KMy87AxBT7/EwNHi4PZqESSdJ3+OoM3IkUPViMNgEFF2Ur8oRsx4LS59xR1ftsN99zcrb+DsEGmNeVHhxdzJRki8qjXrR+JbDUx7b1m8BZYy1lT+Ufm4nlh4IDrOWO4m7m8VU9Ri3txBoEyHWg5iJjDBScO6Eah6Tp3sMEMJmFVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh7UnmiYl+eLxHLMSE4cWgbhs50Knx0QwV+lq7d80w4=;
 b=nU4Way553FM4k8YWXF1jkbw3d3qTqquDxheXyk1hVhvk5+Sbx1z3e+hcCPTSSeD4ntnYB6E2vdod/2tmCHgI6AdrogdPmULPz0qaGoTq7mmcYUy2vvWl3WEPxRPoKydByYezSO4kKO10biT5XrHKHbObcgUAbgQnd/6i+ghwDPhExFkp1U9+qskklxENjG8154zXZ7vyuwBtRzkSzN/5mxrhEkLNzsbBYjiSw+aXMmjNdHrTzxOrqtranAskcGIPsXRw/kyrNMpqnXlO71NZUPzFwoAyuRCBuJFEVHTnAeClbAO2vgYmUh6A5O4cne1tIvLa6S54qEWi50J5o/v/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh7UnmiYl+eLxHLMSE4cWgbhs50Knx0QwV+lq7d80w4=;
 b=NwR6OUpSG8RH6EG2CHR7oTtJLhSIjY9ZxcMraTkkCfIi21SD4nUyX/cE3OPvYghTNqf176WjypWFd9y4lgQNG8JBEs/Xx1hvlqdBsulZ1ejqfVsq5Om/vPXhtNy0ZRQykc0uTtAUFXBkrFFhSDWZ7qTevKbilSezzfMonQEgFso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 06:39:08 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 06:39:08 +0000
Message-ID: <7ab9ea0e-4545-c461-661a-7050cf88d812@amd.com>
Date: Thu, 7 Mar 2024 07:39:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <yangp@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240306144115.1007-1-shashank.sharma@amd.com>
 <92ce9da0-9e89-4fa0-a85f-c6090a067525@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <92ce9da0-9e89-4fa0-a85f-c6090a067525@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bccbf5-4e84-453a-c459-08dc3e714a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nx31VXG0xGNHtRFDjQi0txRSNC/q3rqHEmcmvuHfG1D6IC433Dnx5aaawv55pQ4WyzqA9eO+zCvRPn4Xzrkb0xXrSPQzeMEBUQ8z0t6Xa39p49+ZRq2pWghJP0Z2AcFb5dNm5dxXOYM9ttxXp0q4syR0CT1oqp3G2ySKrL50qIsng+mLqLU2gjPtZ3Lyrx+yNL7xo42qMPDLpgXU41t3UboLQnv2dCn9a0THmtsTcaNnvo/rKp7U2hYtFVxeNKTWyjpjMcctPW0vxTTJGllnowwtncOl6wLkwgBo1f4NLm9Yr1/XyUlht+bn4Mn9f88LgNoXtjXw23orpCv78/5JASoRBTGwk3AnlQoaqz2V2csBILcSII5b7SCPW2zoPZQfGXxDhgblyrVjvu4et6TTBHr0x4a5PDl2BRx00eA7lYQLvRiXtGHiqwb5aGNHSI4ek9glBMJ/U9SHjdp+AHIT+8oWTUl36rYpelgLhfxhwUf74Ptn8pdotZUec7cn1IzyEqwpF+t49irEa4WkLIugJ/oNv0pQAGDfrdcDcnnFAUJEBl5+TLyMAjCng4IGfELKZyOcjaEcGKruflt/XAdXPK779DohumNZwesF1TQdHPfcgF3VExbm/pUlD3BYHkkHtgJwkqu9YT8Lrgim3pu/CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFjek93U0pQQ0JQZjljYllxeDNwQkhvcHEzU0tkbm1pbVR2em5HRDAvNHBD?=
 =?utf-8?B?V28rZStTTmQya0ttQlFnTGlJRHhISzFHSWtScGpGOEc1WnRHWkx1RGNTd2pt?=
 =?utf-8?B?QlFXM2VBTmhtM2dldVVwY3NxL3ZUdnpIZmNkWXJqMnlqY00wWUpyL256RGt3?=
 =?utf-8?B?WGlVQ0F3LzR3Uyt1SUJTUll2T1d2QUV6RHdhcS9LVTlhNUtRMVhGWDduUERu?=
 =?utf-8?B?bEYxKzdIQUU3MFRKZXc2eVNOMnhycmVheUY2VUFrRGYvbGFIRG0zWExZRkN6?=
 =?utf-8?B?MVFCTWhRMFRXR3dISzc1Z3VKdmJOT1V2TkN4Rkh3cU1iVmpobTFueG5hWTUv?=
 =?utf-8?B?OWlYd1F2TnJJbThLemZXU1JxTVREZEI3dkQ0YVdaNHJQekJzcDRvSmRHOFRZ?=
 =?utf-8?B?bnd1UkhDQWh4VVBSYk5QVElRWTBLbW8wT1FNWS9tbGk3YTBVOW1YSy90OHNO?=
 =?utf-8?B?TVdXdWY5cTltcERYdmtEbjJnWTNOL2s4anR1UmtEYUd3MXlGRzRyV3JCTE54?=
 =?utf-8?B?cU9wTEJDQmFFMko4OG16VFZGZWF1SHdqSU1PQWE2RzVvNlczbHR5d2FNUHM5?=
 =?utf-8?B?WjF4bTM3Q1NaOHo0LzR2b2hWazRQZExqVVFWNU1LdEhTcWRjRjNMUHpLTUlh?=
 =?utf-8?B?N2hqaG44cy9IYUN5YU9IdHI5aHlQRHR4cmhQYzFIMjNjSGdYYVFxaGJLb1dD?=
 =?utf-8?B?ckt1TG5OZkVYZk5nWTZSMkI5WFNldS9lNno2dm9YQTNIdFBiWFVxRTdyam5i?=
 =?utf-8?B?b2t5bW1zbFAzcGFRWnJ3eVg1UkR5cmZQamI3alVTRVpHOTFUNm9EOHRteTB3?=
 =?utf-8?B?SXpVdTgrT0dmd0h0aW9PcDZKT29IYmF0VHoxK05jTUZxbDFSL0dDa0VNajIv?=
 =?utf-8?B?MGIvdWRyempTak1EdU1mSm5kOEc2bFJHd3ZndGJmSUNEOFdkaGRGZGV5SlBY?=
 =?utf-8?B?Nmx1RW9hNkhaNEVEODkrdDc0OFJMYTIwcHR1U3NxME1LbnBDSWtsbWZqdDVj?=
 =?utf-8?B?SktMWGFYYzBRTlAzVVdmaFhOWW4yek45RWp1c3NIUnZrUTl6V1YyZWlmRUJZ?=
 =?utf-8?B?SzhiZy9CUUpaYU1Xd20vOExDSkxRRDdTYitJNHZOU3NJczBkV0V3QWlVaEdy?=
 =?utf-8?B?dTREbUlheGxaY1NSbnBJdlN4WEllTUVCeEs3bVd4RDc3alZaeFlYYkhpbC9I?=
 =?utf-8?B?a3ZzcHJxVFRseWorMTN4QVA0YVA5UXNHOTN4aitjbHVlQnQ4RGJXRGxwOGI5?=
 =?utf-8?B?ZG1DbVhxWG9rNFhyY1N6QXlqdkI3QUFTQXlQNldlaUFJdEtCYXVYY2I2T1RW?=
 =?utf-8?B?OVJlQ0Ntc2Y0Nml4SmJKNVM0Qzg4Z01rRjh1R2RxTDEvbjRVYzZMdXBMTm03?=
 =?utf-8?B?U0lBNXM1WFh6czZ2UlVMc1ZPTzhQbFJPYW9lam1YdHgyZ0JwNFpmZkVHcStJ?=
 =?utf-8?B?amJ3UnZBZEFQRHA4K3hqM1oxcDIyUVNXVlRTSzJoalo5eGJvMVNCY1Z5bHhB?=
 =?utf-8?B?Q3AvbDJrVmcvNm41OVN3dFd3dmM1VXQ1Nlo4ditGMDVYMzk1UituTDVadWRK?=
 =?utf-8?B?UW56QVNmZ1F1QVJBT1k0MVBMQ1hWWlF5MmxkREN4UVhsNlNGbkk0SmZDaUlM?=
 =?utf-8?B?Z1FEODB1VXZHNjZvZW55RGRxMmNQYUY1WWNCVm9VQU5yb0RsaWcxZW1qOTB0?=
 =?utf-8?B?dXRrOWVIOHNrM2pNTDI2dDJ1K3VXOW1YdDhUZkRUeHJiendjcm1SSnNieGxB?=
 =?utf-8?B?M1JwdDVHbWpISDFCUlZnYkZpKzJpbk5yVU9sbFhoNWFNckRUV2cyWkJZTDgz?=
 =?utf-8?B?d1NqSmpIVmVrNFNRby9VdFdlaTBTMU5qVlhaU0RObFJEVVI0a0VTYlFDMzlP?=
 =?utf-8?B?UWNjc0c4VVdDd0lHNWZNdTVoRFNNQWlYYVRNcU5WQWRNYUU2VWc4WDdMU2t1?=
 =?utf-8?B?Tk5tNEJnRGMxSGNUWmxoRHlVcDdWcEZvZk1JV1ZSWVNoMHRQb0JFUVVFR0F4?=
 =?utf-8?B?azZvYllQeUpXeVU0UUlkZzlzNDJCeXA0OTQyam9Xb0EzVVd6a3cxdjY5SFBx?=
 =?utf-8?B?R2h4WTVtMWFRRzlCcXU0UEJrQkp2WlBtUzFGeFZVU1ptVFdxN1FpeWwvMWo5?=
 =?utf-8?Q?tb07mcrz2sVHZPPxK8LNYueg4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bccbf5-4e84-453a-c459-08dc3e714a49
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 06:39:08.1074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1sUKFWxJyaTp4JvUsTAZvLmTbZMzew9MUDJ8VINwISo+DMha6uhSotW03nRA8AVaHJH6xsP/FQ64hHUOu+C1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
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


On 07/03/2024 00:54, Felix Kuehling wrote:
>
> On 2024-03-06 09:41, Shashank Sharma wrote:
>> From: Christian König <christian.koenig@amd.com>
>>
>> The problem is that when (for example) 4k pages are replaced
>> with a single 2M page we need to wait for change to be flushed
>> out by invalidating the TLB before the PT can be freed.
>>
>> Solve this by moving the TLB flush into a DMA-fence object which
>> can be used to delay the freeing of the PT BOs until it is signaled.
>>
>> V2: (Shashank)
>>      - rebase
>>      - set dma_fence_error only in case of error
>>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>>      - use vm->pasid when f is NULL (Mukul)
>>
>> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>>      - move the misplaced fence_create call to the end (Philip)
>>
>> V5: - free the f->dependency properly (Christian)
>>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 ++++++++++++++++++
>>   4 files changed, 128 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index fa26a4e3a99d..91ab4cf29b5b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o 
>> amdgpu_kms.o \
>>       amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>> -    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>> amdgpu_pll.o \
>> +    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
>> +    amdgpu_ib.o amdgpu_pll.o \
>>       amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>> amdgpu_virt.o \
>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 0960e0a665d3..310aae6fb49b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -988,6 +988,15 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>         r = vm->update_funcs->commit(&params, fence);
>>   +    /* Prepare a TLB flush fence to be attached to PTs */
>> +    if (!unlocked && params.needs_flush && vm->is_compute_context) {
>> +        amdgpu_vm_tlb_fence_create(adev, vm, fence);
>
> This schedules a TLB flush after "fence" signals and replaces "fence" 
> with a new one that will signal after the TLB flush is done. That part 
> I understand.
>
> I'm not sure why this only applies to compute contexts.
>
>
>> +
>> +        /* Makes sure no PD/PT is freed before the flush */
>> +        dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>> +                   DMA_RESV_USAGE_BOOKKEEP);
>
> But what's the point of adding the fence to the page table 
> reservation? This is after the BOs have already been freed. Maybe it 
> would make more sense to move this into the next patch, where the 
> freeing is done after this point.

To make it easier for code review, the split of the patches is like:
- one patch introduces function creating tlb_flush_fence and uses it

- the second patch does the rework and movement of freeing of the buffer 
after the patch attach.

If we move this change into next patch, in this patch we will just 
create the fence, where one can argue why create the fence if no one is 
using it.

May be, we can make 'changes in freeing of buffers' as first patch in 
sequence, and make this second patch in the series, so that you know the 
background of changes better.

- Shashank

>
> Regards,
>   Felix
>
>
>> +    }
>> +
>>   error_unlock:
>>       amdgpu_vm_eviction_unlock(vm);
>>       drm_dev_exit(idx);
>> @@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm,
>>         mutex_init(&vm->eviction_lock);
>>       vm->evicting = false;
>> +    vm->tlb_fence_context = dma_fence_context_alloc(1);
>>         r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>>                   false, &root, xcp_id);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 64b3f69efa57..298f604b8e5f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -341,6 +341,7 @@ struct amdgpu_vm {
>>       atomic64_t        tlb_seq;
>>       uint64_t        tlb_seq_va;
>>       uint64_t        *tlb_seq_cpu_addr;
>> +    uint64_t        tlb_fence_context;
>>         atomic64_t        kfd_last_flushed_seq;
>>   @@ -594,5 +595,8 @@ void amdgpu_vm_update_fault_cache(struct 
>> amdgpu_device *adev,
>>                     uint64_t addr,
>>                     uint32_t status,
>>                     unsigned int vmhub);
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>> +                 struct amdgpu_vm *vm,
>> +                 struct dma_fence **fence);
>>     #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> new file mode 100644
>> index 000000000000..51cddfa3f1e8
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include <linux/dma-fence.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_gmc.h"
>> +
>> +struct amdgpu_tlb_fence {
>> +    struct dma_fence    base;
>> +    struct amdgpu_device    *adev;
>> +    struct dma_fence    *dependency;
>> +    struct work_struct    work;
>> +    spinlock_t        lock;
>> +    uint16_t        pasid;
>> +
>> +};
>> +
>> +static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence 
>> *fence)
>> +{
>> +    return "amdgpu tlb fence";
>> +}
>> +
>> +static const char *amdgpu_tlb_fence_get_timeline_name(struct 
>> dma_fence *f)
>> +{
>> +    return "amdgpu tlb timeline";
>> +}
>> +
>> +static void amdgpu_tlb_fence_work(struct work_struct *work)
>> +{
>> +    struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
>> +    int r;
>> +
>> +    if (f->dependency) {
>> +        dma_fence_wait(f->dependency, false);
>> +        dma_fence_put(f->dependency);
>> +        f->dependency = NULL;
>> +    }
>> +
>> +    r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
>> +    if (r) {
>> +        dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
>> +            f->pasid);
>> +        dma_fence_set_error(&f->base, r);
>> +    }
>> +
>> +    dma_fence_signal(&f->base);
>> +    dma_fence_put(&f->base);
>> +}
>> +
>> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>> +    .use_64bit_seqno = true,
>> +    .get_driver_name = amdgpu_tlb_fence_get_driver_name,
>> +    .get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>> +};
>> +
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm,
>> +                struct dma_fence **fence)
>> +{
>> +    struct amdgpu_tlb_fence *f;
>> +
>> +    f = kmalloc(sizeof(*f), GFP_KERNEL);
>> +    if (!f) {
>> +        /*
>> +         * We can't fail since the PDEs and PTEs are already 
>> updated, so
>> +         * just block for the dependency and execute the TLB flush
>> +         */
>> +        if (*fence)
>> +            dma_fence_wait(*fence, false);
>> +
>> +        amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>> +        *fence = dma_fence_get_stub();
>> +        return;
>> +    }
>> +
>> +    f->adev = adev;
>> +    f->dependency = *fence;
>> +    f->pasid = vm->pasid;
>> +    INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>> +    spin_lock_init(&f->lock);
>> +
>> +    dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
>> +               vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
>> +
>> +    /* TODO: We probably need a separate wq here */
>> +    dma_fence_get(&f->base);
>> +    schedule_work(&f->work);
>> +
>> +    *fence = &f->base;
>> +}
