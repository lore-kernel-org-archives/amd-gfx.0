Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3119FC5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 09:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B539B10EB39;
	Fri,  8 Mar 2024 08:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mnYtoMeP";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E023910EB39
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 08:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGezjtuPGFV+OZAUMG+2zxZovdLM/mKNqxKZs3vfvwtceSIAgxkICNclWboO4peURxrC54DZaOSLM05u3SWtw0vLAEOsZYyhAT0eqv03cOvrE/EQSD9MV6eElvwoUQseuGlBvAgETEVvwUXFJQ4+WQ+78NaLMxiWnlTY22ny6QHA9+fsZ0Rrnz46+HQnKQsuop7k+Df+/lhLoDhMJcldhXYm0r/xv8R4Hx+254aqTIhYjXGm7x7eX5ZBjJcfYfXA5VCGqDICwifZy0M1+McBMK1DcmM+6SUl+hWB7V1WTHsho1XTJzA2JPbwqBhL7wWT0EF0UWYzT17nchgPCA/FqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFdO++iq0hfDX2P6ZTHdIHinSW+CTH/maVki6OpShN8=;
 b=CAL6qgXfRrURKoC2cgP7sEtdYm9VOeKUBbwOgnQyqsQbajZYNvEJ7JSWF0pu7o8Jnia1+qL8+wnC1+DlX0hgj2ut6hF6PheXX5tsBmqsrGPJgrcLaOht7Ax8UW/TMVbQGgNNWe3Bvzs1hYmu7VzIvCwU+Id2FNQ1yw+KM8t4DH9wY9nHsYn/bDHZJZ+SyM6LHWnycQdNuipNKFfuKSFF35NEa3xLuHJxv+rNuaPH1RYAd+KlU9rzFJk3Mbu0MqCnDL6MHiO9WW5SBGGE+bDma/PvuKmQ5IAq5jUjh06k3+7nxdM3jPiofkGEtXD1nsnZ3CHraGyNU+WcqIjYKuYx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFdO++iq0hfDX2P6ZTHdIHinSW+CTH/maVki6OpShN8=;
 b=mnYtoMePtp0ZxlBU3S52ay2ldTL0Bi4cfodPgiUNfIOt5GmaKUQtSaRHAtNZkOSqs0UjTxinlP0r5YhaVFPMHZSsnIDuGg9FR3FuJP8HSVGrapZuVNFnFU8vR/2uAF63DIcDQlch0rOUqdmQ06dbTpzdM9oMr5T/SWCQVPq6a2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 08:59:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 08:59:56 +0000
Message-ID: <ea5a247e-4f0d-46bd-9f5a-170064a6d32b@amd.com>
Date: Fri, 8 Mar 2024 09:59:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <yangp@amd.com>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20240306144115.1007-1-shashank.sharma@amd.com>
 <92ce9da0-9e89-4fa0-a85f-c6090a067525@amd.com>
 <7ab9ea0e-4545-c461-661a-7050cf88d812@amd.com>
 <a38728b4-6e21-4218-b5d1-b0f615f99118@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a38728b4-6e21-4218-b5d1-b0f615f99118@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c12a9d-b749-4381-f775-08dc3f4e2035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RgpdVuh37mVu6MeTxIz8Tr1srMCMrDm5lkfk9iyY0sDM4QYzTQmP52H5PPSJ3hwyqhBTeJtwTj43YAQjWlXji5p0/1oH9YiqYuVnzDiTdvyEMZs0RMzk4M7XVnVmhQdYM/nnXYQtydxU7yHGMWlzpsYYbj7m3GNJTALF6w/g7jtPdhB98BK3peZV6W6yB+jjKhoWR+y4+S2Tb6Sza0HwdwFFxgGsIFaPtTf8lWHZ7+cTZy1k1rPbTlhzIF7f42GyTlmwfo4M3Cx1MEAdEX7OkGrfITdYQRbk1qL1fG5SH9K7i2x9WPdKlCKr3m0NTxv6+zySXP/Y4YhPBi+baFn/5oRQhgEjFZPOxm3dOut97vL5gUVNO62udsTtBv8I5VV8aE6kV99Vj8hqWdXzQIhgF9M3tikWfP+mibaAUBuqJ8msqly2ZOtCzO6KSyjP0vFOAE9UWSeLmtjimHbU80r8xahl+LoQ7pRFcfmQ44zxqWYxq3Kl6YJVxDrbDHMPmH18KJjMLqo2dLR87u6QB9AaPVDPVit7Hcma5PJTJYVLaFuLJ5W9vXD4mQiWVJ6w9nQHvczfO+qKEU2to+rzNRwjk6yempxgxnl3O9vPpPaZ1uxpBMxPFfL1vOHS1A4YyoMWvgL8YANne45e4OikpQ85Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXB1ZmF0VWJzME4vZDV2TnlrTjdRYXB4Mmc0NDdWVXRRbXhicHZvQVg3MjYv?=
 =?utf-8?B?ZjFXdGZqSFpNRFlIMjFrQmVSV1FTS2tuZFRJQmEramU5Vi9heC84WWZSSGFS?=
 =?utf-8?B?a1hRbUtIOEdqanNVMU1zN0h6ZHIwUHJqTnY1bk9PL2JLREpuV2t3QitmNGZ5?=
 =?utf-8?B?czhCVUFyRHdmSDlDV2lxc0xHQjF0WU1ReGk0Q1lYUnNSTVR5dkI0UnRLWVNq?=
 =?utf-8?B?RUMwb2pCZ3NadGpEY0NsWUd2Vk9QR2ZmTS9JN3l6dUhTR3FzZGMwTkVvNkRy?=
 =?utf-8?B?akVOTkJUMC80MGl4SVVTZTRPUkxsMXJTTUV3UHBETVUzZXBEMXE3RlJaeWNu?=
 =?utf-8?B?bXVnT1JJYTltTTk4cmlyeWlsTnRmVk9LOXM3SWVQK0FYbVFINC9DWVIyOTBG?=
 =?utf-8?B?OGtDNWJHdS92VlRTUmducHpYVVNMZzl0cFdIdGdpVU8ycDYraEs0dEJHUW5X?=
 =?utf-8?B?cEtHeWdGUjQ3bHR4cUtGam5TUmJFajY2RVNrb3ZuZ2txR2duVVV3bEZLQkRJ?=
 =?utf-8?B?S3ZYZjZDRlh5d3h5WVBFalk2clRJOW1naEVkRGRZM1lIR0kwMVlNV3lSSndM?=
 =?utf-8?B?ak43a0lpeW9YSzRlc0ZTWDQ3NXNmUVdnOTRoMzJTQUx5UHcxWkEyOHhGR2Vm?=
 =?utf-8?B?ZE9kUDVqQzB1SVlmUlNDaGJlRHVJWG9DL0RKdFc4U0RDU3d5b2l1d1FtSDZ1?=
 =?utf-8?B?TjlURE9aa2haT05sbjloTlFVRmV2dnB5QmpsUHl1RkVDWjBMNkpCd1hrVnQ2?=
 =?utf-8?B?U1dUN1lteXJ2YXNSUzh4bEpod1N1R2xhTGRYa0JFT2R2ZG1pc2Y5R3JjeXcx?=
 =?utf-8?B?RHJOeWgzOE0rVC94clFkSHA3TEpMVmVZNTR4eEJ2d1BVUVhxdVRONHduV0pG?=
 =?utf-8?B?cFljUHZydEFRQWU3MmhaN2xLa3MxemY5QmVNRG9sNCtkL0NnNEpCckZBV3JN?=
 =?utf-8?B?d1ptTGlnY2ZCblFycnpwNU1TUUMzYTdTODlFNS9UQldCb1g3dk9VZWwzaERI?=
 =?utf-8?B?SW5LOEVNQjRwYVJQWjhkTWVwUXF1VmhLMG43Z2poelg1aWE2QVg1T0FGSGhX?=
 =?utf-8?B?VzVJSS9KVEY3WUtHYXJUUFY0UktpdWR6dG56aXBLdVVMbXRQWDRjejZqVUVN?=
 =?utf-8?B?ajNJM3Y1R2gwVHhEVWVMQ0FuK2JvOTBTK0w5WDFoT0oyT0tzRDA3U2VPNDdv?=
 =?utf-8?B?S2hCZGtkdFl4d0VCUG9yc204eEE2QkpmbkJHL2Vxei9iQ3NXV2djUGpMOEU0?=
 =?utf-8?B?Vm1zaFpKak8xeGFwcTNTa0xyaElpN05mL3NCZGJ1RnpTckxNQk5adXRaaE5U?=
 =?utf-8?B?MFJ1c1k3QXhjQjAwSGFrS245OGRhNVZENDgxd2VwRkFqNFErdnhTeFBmYkpL?=
 =?utf-8?B?ZmQ4NXhwdHk4QmQ4N2oraEFXeEMrbVJZVUVvVXF4M1F4Mk5laENkMVJ4OGZs?=
 =?utf-8?B?dTJCTmkxYlV5bndQSGlXUHloZTRJam02K3Ywa1RMb3JBdzR4azBuc2lIMGZz?=
 =?utf-8?B?ZE9Kczd2TlJIaS9lWE9tMW11R2VzTDRjemV0YmN3Wll0Q0xobzI0R3BTSFU5?=
 =?utf-8?B?RkxOTkl3K1h4OXBuK2NWUmJQQWJaNElSdHlZaHdYbzk2ZTZINGMyKzQ4U3VD?=
 =?utf-8?B?dCtyT09OdlFPTEt5NmFGVVF0WXduWnllcndja0pCL2FLOE8rQVBCWEIvTTFv?=
 =?utf-8?B?S1ltbllPenZ0dXhnN2Y3bGtZaHdoNWtHeEpvWms4YjlhNzd0YUNDdFkrWWsv?=
 =?utf-8?B?eE84eGd0UnhnZVpYb2FXN2dndm5LRVpnRllZNkVoZXUyZ00yeUc2bXc4WThw?=
 =?utf-8?B?WE8wWENRUHo2SGdEMEZ1ZitpeGlSaWNnZWRrdWVzVlhwRGtRc3o4SFJtUyto?=
 =?utf-8?B?b3pTK3g2c2JOa2MvdnRyV2w5citYaVNLK1l6Y1B4bSt6NU03TFpqc2R1Vnds?=
 =?utf-8?B?cSsrTitaM3VCUmhPU0ZoUlh6WmJ2TVQyS2ZwS3pQdmczVHQ0MnhSZE1XZE9X?=
 =?utf-8?B?NW94UWlZZ1hyaVQzaFEyU3lCTWhiNU5OWjBobHZ0R3RrRUc1c0NKSXFiekpN?=
 =?utf-8?B?STdGN2Era2pSd2tIQUlhWmREMkRERXRCTnR1c3ZaSERmM1R2K3h3VlJxYmVl?=
 =?utf-8?Q?0FvWtQlBZ7xnUYBwwxjeuJoEO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c12a9d-b749-4381-f775-08dc3f4e2035
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:59:56.1302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGvh3eIpyUSkV9TwZZ2fliV8GpBx5HqOynrVYVZEDByJG9+owIDiNEQmnU6fwfd/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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

Am 07.03.24 um 23:44 schrieb Felix Kuehling:
> On 2024-03-07 1:39, Sharma, Shashank wrote:
>>
>> On 07/03/2024 00:54, Felix Kuehling wrote:
>>>
>>> On 2024-03-06 09:41, Shashank Sharma wrote:
>>>> From: Christian König <christian.koenig@amd.com>
>>>>
>>>> The problem is that when (for example) 4k pages are replaced
>>>> with a single 2M page we need to wait for change to be flushed
>>>> out by invalidating the TLB before the PT can be freed.
>>>>
>>>> Solve this by moving the TLB flush into a DMA-fence object which
>>>> can be used to delay the freeing of the PT BOs until it is signaled.
>>>>
>>>> V2: (Shashank)
>>>>      - rebase
>>>>      - set dma_fence_error only in case of error
>>>>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>>>>      - use vm->pasid when f is NULL (Mukul)
>>>>
>>>> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>>>>      - move the misplaced fence_create call to the end (Philip)
>>>>
>>>> V5: - free the f->dependency properly (Christian)
>>>>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 
>>>> ++++++++++++++++++
>>>>   4 files changed, 128 insertions(+), 1 deletion(-)
>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> index fa26a4e3a99d..91ab4cf29b5b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o 
>>>> amdgpu_kms.o \
>>>>       amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>> -    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>>> amdgpu_pll.o \
>>>> +    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o 
>>>> amdgpu_vm_tlb_fence.o \
>>>> +    amdgpu_ib.o amdgpu_pll.o \
>>>>       amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>>> amdgpu_virt.o \
>>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 0960e0a665d3..310aae6fb49b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -988,6 +988,15 @@ int amdgpu_vm_update_range(struct 
>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>         r = vm->update_funcs->commit(&params, fence);
>>>>   +    /* Prepare a TLB flush fence to be attached to PTs */
>>>> +    if (!unlocked && params.needs_flush && vm->is_compute_context) {
>>>> +        amdgpu_vm_tlb_fence_create(adev, vm, fence);
>>>
>>> This schedules a TLB flush after "fence" signals and replaces 
>>> "fence" with a new one that will signal after the TLB flush is done. 
>>> That part I understand.
>>>
>>> I'm not sure why this only applies to compute contexts.
>>>
>>>
>>>> +
>>>> +        /* Makes sure no PD/PT is freed before the flush */
>>>> + dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>>>> +                   DMA_RESV_USAGE_BOOKKEEP);
>>>
>>> But what's the point of adding the fence to the page table 
>>> reservation? This is after the BOs have already been freed. Maybe it 
>>> would make more sense to move this into the next patch, where the 
>>> freeing is done after this point.
>>
>> To make it easier for code review, the split of the patches is like:
>> - one patch introduces function creating tlb_flush_fence and uses it
>>
>> - the second patch does the rework and movement of freeing of the 
>> buffer after the patch attach.
>>
>> If we move this change into next patch, in this patch we will just 
>> create the fence, where one can argue why create the fence if no one 
>> is using it.
>>
>> May be, we can make 'changes in freeing of buffers' as first patch in 
>> sequence, and make this second patch in the series, so that you know 
>> the background of changes better.
>
> Sure. I don't think it's super important. I was just trying to 
> understand how the two patches fit together. I think it makes sense 
> now. I discussed this also with Philip offline. We think there may be 
> an easier way to solve the "wait for TLB flush before freeing BOs" 
> thing, but I believe using the new TLB flush fence is architecturally 
> cleaner, and that fence will be useful to solve some other issues that 
> are either still lingering, or currently have only some ugly 
> workarounds. I'll need to dig through the code and my memory to 
> remember the details.
>
> I'm still not sure whether the creation of the TLB flush fence should 
> be limited to compute contexts, but I'm happy to get them at least 
> there for now.

Shashank is working on this because we need the TLB flush fence for GFX 
user queues as well. So limiting it to compute VMs is just the first 
step to solve the KFD problem and MES will come later on.

> The series is
>
> Acked-by: Felix Kuehling <felix.kuehling@amd.com>

Thanks,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> - Shashank
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> +    }
>>>> +
>>>>   error_unlock:
>>>>       amdgpu_vm_eviction_unlock(vm);
>>>>       drm_dev_exit(idx);
>>>> @@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm,
>>>>         mutex_init(&vm->eviction_lock);
>>>>       vm->evicting = false;
>>>> +    vm->tlb_fence_context = dma_fence_context_alloc(1);
>>>>         r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>>>>                   false, &root, xcp_id);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index 64b3f69efa57..298f604b8e5f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -341,6 +341,7 @@ struct amdgpu_vm {
>>>>       atomic64_t        tlb_seq;
>>>>       uint64_t        tlb_seq_va;
>>>>       uint64_t        *tlb_seq_cpu_addr;
>>>> +    uint64_t        tlb_fence_context;
>>>>         atomic64_t        kfd_last_flushed_seq;
>>>>   @@ -594,5 +595,8 @@ void amdgpu_vm_update_fault_cache(struct 
>>>> amdgpu_device *adev,
>>>>                     uint64_t addr,
>>>>                     uint32_t status,
>>>>                     unsigned int vmhub);
>>>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>>>> +                 struct amdgpu_vm *vm,
>>>> +                 struct dma_fence **fence);
>>>>     #endif
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>>> new file mode 100644
>>>> index 000000000000..51cddfa3f1e8
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>>> @@ -0,0 +1,112 @@
>>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>>> +/*
>>>> + * Copyright 2023 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person 
>>>> obtaining a
>>>> + * copy of this software and associated documentation files (the 
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without 
>>>> limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>> sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>> whom the
>>>> + * Software is furnished to do so, subject to the following 
>>>> conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be 
>>>> included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>> USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + */
>>>> +
>>>> +#include <linux/dma-fence.h>
>>>> +#include <linux/workqueue.h>
>>>> +
>>>> +#include "amdgpu.h"
>>>> +#include "amdgpu_vm.h"
>>>> +#include "amdgpu_gmc.h"
>>>> +
>>>> +struct amdgpu_tlb_fence {
>>>> +    struct dma_fence    base;
>>>> +    struct amdgpu_device    *adev;
>>>> +    struct dma_fence    *dependency;
>>>> +    struct work_struct    work;
>>>> +    spinlock_t        lock;
>>>> +    uint16_t        pasid;
>>>> +
>>>> +};
>>>> +
>>>> +static const char *amdgpu_tlb_fence_get_driver_name(struct 
>>>> dma_fence *fence)
>>>> +{
>>>> +    return "amdgpu tlb fence";
>>>> +}
>>>> +
>>>> +static const char *amdgpu_tlb_fence_get_timeline_name(struct 
>>>> dma_fence *f)
>>>> +{
>>>> +    return "amdgpu tlb timeline";
>>>> +}
>>>> +
>>>> +static void amdgpu_tlb_fence_work(struct work_struct *work)
>>>> +{
>>>> +    struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), 
>>>> work);
>>>> +    int r;
>>>> +
>>>> +    if (f->dependency) {
>>>> +        dma_fence_wait(f->dependency, false);
>>>> +        dma_fence_put(f->dependency);
>>>> +        f->dependency = NULL;
>>>> +    }
>>>> +
>>>> +    r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 
>>>> 0);
>>>> +    if (r) {
>>>> +        dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
>>>> +            f->pasid);
>>>> +        dma_fence_set_error(&f->base, r);
>>>> +    }
>>>> +
>>>> +    dma_fence_signal(&f->base);
>>>> +    dma_fence_put(&f->base);
>>>> +}
>>>> +
>>>> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>>>> +    .use_64bit_seqno = true,
>>>> +    .get_driver_name = amdgpu_tlb_fence_get_driver_name,
>>>> +    .get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>>>> +};
>>>> +
>>>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct 
>>>> amdgpu_vm *vm,
>>>> +                struct dma_fence **fence)
>>>> +{
>>>> +    struct amdgpu_tlb_fence *f;
>>>> +
>>>> +    f = kmalloc(sizeof(*f), GFP_KERNEL);
>>>> +    if (!f) {
>>>> +        /*
>>>> +         * We can't fail since the PDEs and PTEs are already 
>>>> updated, so
>>>> +         * just block for the dependency and execute the TLB flush
>>>> +         */
>>>> +        if (*fence)
>>>> +            dma_fence_wait(*fence, false);
>>>> +
>>>> +        amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>>>> +        *fence = dma_fence_get_stub();
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    f->adev = adev;
>>>> +    f->dependency = *fence;
>>>> +    f->pasid = vm->pasid;
>>>> +    INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>>>> +    spin_lock_init(&f->lock);
>>>> +
>>>> +    dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
>>>> +               vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
>>>> +
>>>> +    /* TODO: We probably need a separate wq here */
>>>> +    dma_fence_get(&f->base);
>>>> +    schedule_work(&f->work);
>>>> +
>>>> +    *fence = &f->base;
>>>> +}

