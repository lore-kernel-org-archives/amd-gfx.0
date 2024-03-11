Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95EBC5475B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 19:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13495112C39;
	Mon, 11 Mar 2024 19:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3mq2L5xz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDA3112C39
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 19:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9lw+Bp7X9kxpJNr43RVwzvIu+ZJ2ToMW9hqRCQNLs0V5ttOxlndhO1X6jiR5nKB1luB7HFNHiumWeNc58TCbMP8GgZOOZOo7huYhE+6gTl0IGNFuGpmYgBwVT1RqKoBRSM5fa625YzJ/dZ+nyFkBSqZz1ubbiJ3WV+CZj6CZnUNV6s0HFvSak3SXuqmmlkais09Dawj+UnVOOlSGTUKVwl/7IQIMHDRTfGjpqZEnS5nCbLLjYwi5ihDMncmC3tTZmLtLcfchTFnIYubwntMJArRjxqvOF/SOHMJC4Q1KixwJ5mKaaI2jfxUXEIkLXFat83OvZeILJx01MI4Zbz4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jo9QLMChCOIS1Axim5WGk8GscusbTAfCSAA3nnEdac=;
 b=Ntu13F9KSguSgt4qtSzxJdFlKdDE14IqYtEV78Imsv/d5tWtw1UGo78qFK/wiGIqVxkvF4uNRGe9V5uvEKHJKbaRxRMe466UTDkncOrA4WJ1LECESOvaTkOATpbMtdZ3CNgBtVRjPln5qpGYT6Nelb8L5/1aYnT7i8A4zIVeWpWjfGMzmoYE8NJRktf0VSPWwrlmjc5VM+TjVzgnnLuNMJ8N93aCIdWF4J+arUUXOnd3CIzyUdrEu1L20S3kqv71ci3Ug8qhyY7T/lVliV9DV90TFf42y2+Zwl3razOCzvmofE51pwD2HrM0UsrjLjN4m4guPbZADXQ4TEmakyUUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jo9QLMChCOIS1Axim5WGk8GscusbTAfCSAA3nnEdac=;
 b=3mq2L5xzCG0H+Ya0pk5aNM3xmNJHYpx6HLh14zDEgAoVQWIsIXvHe7uFoV5x6KYaleg0/ktWVdf4g+HZtddNcOZQpJTFXa/BvyqgWisa3R5HIbp2UGJ+yQJK6PbPZIOsEm+mab0EPkFq865ZDA5ieIVfxB/rG73slxaD9OHOLAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 19:48:37 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::f405:814f:a551:4b85]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::f405:814f:a551:4b85%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 19:48:37 +0000
Message-ID: <55c2650d-ae75-4b8a-9486-3ffda1ceef44@amd.com>
Date: Mon, 11 Mar 2024 15:48:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/amdgpu: implement TLB flush fence
To: "Sharma, Shashank" <shashank.sharma@amd.com>, Philip Yang
 <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240306144115.1007-1-shashank.sharma@amd.com>
 <939a8f23-952f-8993-9c1c-178bb0fd42b5@amd.com>
 <98f72106-e62e-ef02-ff9b-d92edeb6950d@amd.com>
Content-Language: en-US
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <98f72106-e62e-ef02-ff9b-d92edeb6950d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::28) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c51424-51ba-4a14-a047-08dc42043e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CeUFMZMS7KRc9wPLujdETCFcMglZXqQ8B6pR6H6lxNmFIR6JSoJQuKjaXrejK0jxoQpjUZQNFrGXYDlcPsIOkE9HZYjaNPTDZ0JIbSH04qQELw0Ch/WPfLt6iP4CAOr243Xln3gzBi3OXQj4qRcbjbvU9HQzjtBl0rfWB0dst66O+nDeqdipOvL/Pseu6xDEdcVHCIfC606nDnGuWcI3UyHjZZ3OIcpBK3VP7hu9SQ9HoeEVw2xmHAOQgiRz/j5wcJmoU/5DYD8cp2qe4daMSn6OA2TlXLVikW+KmaE8gp3qxRKywXcRz6+KftP2du2mNOJvPwa4oey1sQXdwqmZ004JNiGRJBfkRu2ZeUA7kb3S4r975hH2oGN1Xl1+62guu20ePT1VycaYR9Zouih8OCSeqrU+PiNn4Hl8GvDI9mEnQiTPe1Uv6jfAHClOWauhbEOAXxBRDaLVSMaisy4lPHw2aezB1K2IahCVNhGvhVvObmwjpDzKOP1glT3AGneAFYd2q31XC1YIy3yeGL8Mj3gIHKDpy/fXaDNr+OYnIFAc9d91cxe7vGTGE7L/Vw3sXnvcfRgEbDHIzcOn+j6c+TNAl0i/YM1UpCa9k/2RZpFSXPohJW/bwdv7aN87QoVRNXDLnx+9RQZh0xuj+JtlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXZ4Y2dOL1R3cVNBbGFFYXh5bllTbG9JenZyaG4rWFJvMCtMSGtCbkw3dVk0?=
 =?utf-8?B?R0pGMTdqY3J3dUtrWXpwYXpUUXluU0ZnRzFBblEyTUt0aHdFclhESTNWWU1S?=
 =?utf-8?B?QU04VXNPbjRCRUlnVTU5S0VOTitOaFZPWHpmaDVBL2VYSDhnMG5IMHkrQjY4?=
 =?utf-8?B?eW1mQVJ5d1lvVXhtZXV4K0tjVFZEVzNieHRnYWRob09mSGxPb0VUNlFKemxz?=
 =?utf-8?B?TWxCWU5mWmw4YnhuTDJsNWd5K0xFYmh1eHgxcXJabGMrcnIyV1BiQSsrdnBL?=
 =?utf-8?B?WVZMVnNFOW1ndWx2MU54V0tQWEFrQTVKckQxdmRobFcxRXE5d3lCcWczLzFi?=
 =?utf-8?B?R3dRc0dYNFdUL0k4c0ptR2JZN3g4K3ZId2lPeVJKUE1uV1o1VTF2RmU0WlNo?=
 =?utf-8?B?WGtGK0x4MWQ5KzdLZTZ0WGY5U0VNSlNYM1dXejVoZlZtbXhVMWkra1hYd1Jk?=
 =?utf-8?B?bkFUcmEzWGhvbjhjWlVEVm9VSG4za0hUZjZyUEc5d1B6Y2s4ZDRJZWRNMkRw?=
 =?utf-8?B?MXlvelFQYjRWd0NreTJYbENOdk9QaGJUdGwxaDNkRnBsbzJyYkpzLzFSdFQy?=
 =?utf-8?B?WUM1bzhvMnRsYlBwV05CYm9NRkErWStjYUtuQ1JTMmRqQjVBNjNscUN1NzZa?=
 =?utf-8?B?MU90dUp5Tk0rSkFRWEh4Y2FTYUdML3BOeElkN2FqSHIxUVNMZkhTcmczdVZD?=
 =?utf-8?B?UlhzM1djV3l1REwyMGJaT3pXOGlJRU5ablErVTJvOGlsSHB3NnZoRy90czFE?=
 =?utf-8?B?OENJM29JczZYWktnd20vazZmU2pjR3pMN2MyQ09HMzNhRDkwLzJPUE8yQXBn?=
 =?utf-8?B?MXRWRjltZG5lWlJIekg0VmhEV1dmYTc1YUx1aUdOKzRKSjVLdm9Tampvdlh6?=
 =?utf-8?B?N2ZhbllzTjMrQVAxRUhUa0tjd2swY0FlQUt4cGJhVExUU0dwMkFsbjFod05m?=
 =?utf-8?B?YlVqbTdLRXUwbW1LT2V4MDB4TmllOEVRVW51M09qWlRORVZmbnlFeWxvdURY?=
 =?utf-8?B?Q3AreW1RRkx3N1J1S0t1RFJWQTlDYU9HOXVZV0l3Y0NJeVVEZFRDcjRaRXNV?=
 =?utf-8?B?ZU82UkI5L29KTzFPSWhRMWIwZ2xMeDNmdzNQS2tSVCtOV0FIelc3bXdaUzRh?=
 =?utf-8?B?UU9wTHErWDRieWsya0VxamNqd1VLc3RiVE5lQlZrQjkxaHQ1Mzc4N1Y5amg0?=
 =?utf-8?B?V0lhS2J3RUYrdEMray9KYWtWZ3hSdUtTZW41VDRaZXZQSE9KVFhVSC9HYU1m?=
 =?utf-8?B?YUp5NmJZcWYrZDFrKzlZeTVsMXh3dDdIV1FIa2NaNzBmMThFbk1lRjdxWVB4?=
 =?utf-8?B?QnBlN0ErdzNOL2lDQnQrbVBuS3B0eHFPZjB3TUFEOEw4NXZaVm1oUzgzL2Ir?=
 =?utf-8?B?RyszQTk3NHhiL091N2xReTRzZ0YxQUhSeDJBMXM2TktyRjh4ZWhERGhWdU9w?=
 =?utf-8?B?YjlqclhwZXNPWnhuU3FiejJDSEc3S1RWV0d1UTdwNzdFN1dyTzJzN1lTUlVV?=
 =?utf-8?B?MFo1OCtud3dPbmtjZFhlMitIV3hZaFJGV3B5QUExeUlMc1RaSWZxQkFVRGx0?=
 =?utf-8?B?YVpxWGhTcUtERHRyVlhXVVN3L2tOc0xHLytORzBGZkZBYTVIdENoMHppYkRC?=
 =?utf-8?B?NTI3SVY3aWhpZjdZR3FmdDdrZ1IwTGtBbE1rK2ZYY3J4QzlWUjFveEQyd3N1?=
 =?utf-8?B?TFZnMGg1SE10MWJ1QlpzNWRlemdSeS92L2FGYmdGYW9WWnM2dzVNN2lIUko2?=
 =?utf-8?B?dVYxRnJncHQ3bko0cTg3b3NETm9FMlVzcDc5N1UvV3YwbDQ1ZTFJRUlkL1Bn?=
 =?utf-8?B?WVRMNHFLcGxFNE5EZ2xUME5GUms5QmxUTk5MV1o5Nko4VWxRQ2pUc1hIVkNM?=
 =?utf-8?B?N0I3dTFtUjV0cmRxUTJmV1orS2RsUSs3VnZHbnRHMHFGTXNuYXhUTytEOG8v?=
 =?utf-8?B?eE9QUEpkNHZNT1kyTVVHcEVyeTVSbmFZbDhmQ2NLenFSeWptZDJvaVkwZ1N5?=
 =?utf-8?B?WklORUtGZWE5M3Q4T2Z0ZHgrTnByRzA5UlQxeiszS0crdFBDMVZtN3RZWHdE?=
 =?utf-8?B?ZUpnRmdHNElmYXVrZWx2SEtCMzNkR0pVY1E2VWpqajBRQXhKSzREQytXdjhi?=
 =?utf-8?Q?tsox6Rwu7YYFpZskbiid06Azf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c51424-51ba-4a14-a047-08dc42043e2f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 19:48:37.2620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri26XRcp6czn2hPxrqB1jXis+Wg44bEYXuRLSGw103wdNRNLh8xdEphaWTTy9zVNQECR+YniD43XW9Y6PuZlFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356
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

Acked-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On 3/11/2024 10:37 AM, Sharma, Shashank wrote:
>
> On 07/03/2024 20:22, Philip Yang wrote:
>>
>>
>> On 2024-03-06 09:41, Shashank Sharma wrote:
>>> From: Christian König<christian.koenig@amd.com>
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
>>> Cc: Christian Koenig<christian.koenig@amd.com>
>>> Cc: Felix Kuehling<Felix.Kuehling@amd.com>
>>> Cc: Rajneesh Bhardwaj<rajneesh.bhardwaj@amd.com>
>>> Cc: Alex Deucher<alexander.deucher@amd.com>
>>> Reviewed-by: Shashank Sharma<shashank.sharma@amd.com>
>>> Signed-off-by: Christian König<christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma<shashank.sharma@amd.com>
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
>>> +
>>> +        /* Makes sure no PD/PT is freed before the flush */
>>> +        dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>>> +                   DMA_RESV_USAGE_BOOKKEEP);
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
>>
>> To flush all XCCs, as this is a corner case, we could start with this 
>> to make it correct for SPX mode for now, with extra flush for other 
>> modes.
>>
>>     int num_xcc = f->adev->gfx.xcc_mask ? 
>> NUM_XCC(f->adev->gfx.xcc_mask) : 1;
>>     uint32_t xcc_mask = GENMASK(num_xcc - 1, 0);
>>     int i;
>>
>>     for_each_inst(i, xcc_mask)
>>          r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 
>> TLB_FLUSH_LEGACY, true, i);
>
> Thanks for this input, Philip.
>
> @Christian, your feedback for this ?
>
> - Shashank
>
>>
>> Regards,
>> Philip
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
