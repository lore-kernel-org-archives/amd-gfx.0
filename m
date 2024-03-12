Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AF6C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6811110F334;
	Tue, 12 Mar 2024 09:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cu0kTbuj";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0EC10F334
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDmDUxZOL8LEe+u0uFFMdtgDU0M0cIM3b0ag8DC+XROdUvkTWbCPj+kDnrGY37Kc99Kf3GUBpTXEf2qsK6FbNH6n8xOgClv6J9bGIlQwQQcJRGGpRwo7UF3gitm/WC9Cu5vAMdzfqwy5qHK8N2YxQDoxsmypbXhOOmrWsV4nN4eeHOPjsgljADXK0gsYIzr/YyXMdy4XEOvn2TCcEn4OGFMuLfjvsa85f9HfpPeDZHVyxCoBLWZz/sKUSG9S5f2xrJqcqTCNQkf9RjxULUJxUVBCRqoAgKpxQIUi5viY4RK/86V1+m87yMjVqM3UG9zjzG6Sf0zNv/ZHl2JxDF5iWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx9XXDRH7xh2HWk9jDiuwXDVrWAXsW9cuBgJjGeuKao=;
 b=NhGPSIe91LYjwWlFj3plHBTfaBR4MP9eoQLABnO35tKqUSAjQ3lEfM9GYxlmjObh3fURD669nAKj7y9DpZ4yJ5gExClGeFfFOO77uJGzvw8LPl8XntJmB2hXBWR3M4hObsmk09CuZEh1I1lgYb4MemzK6LWFSWqz6pJN08TuRtrK1KhBubapAO68tWtP/i4lRyvtG/BjYEVAfIH0nJsF60W1tdoKPo/MHPGSf7PEc6KQPws3nMpdayKngdurktzocoZ/H3fsPA83cyBjuUSlBYnuUXlyNO0eVnZ4mr7cMufqbf68iyF2gKulZHtUMjwo50w5kFeB6JDN7esPQOTk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx9XXDRH7xh2HWk9jDiuwXDVrWAXsW9cuBgJjGeuKao=;
 b=Cu0kTbujnzb3Myyro+X7vzxB2SvTKk/MF7BKCZn3hP20lVvNq+If5eoIBPo0EOa39Kn0dti7k6HKp0kK2wcY4VO8Ed33nkTJhpZVlDFDt+nDvjVqtoWCXum8t4KPrg723fizPXaSTr7NgR8fLV0ws6+JupzuK13z7o61SDo32NM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:35:44 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7362.024; Tue, 12 Mar 2024
 09:35:44 +0000
Message-ID: <63f22f79-75d3-ae73-7375-04bb7804bcda@amd.com>
Date: Tue, 12 Mar 2024 10:35:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240306144115.1007-1-shashank.sharma@amd.com>
 <939a8f23-952f-8993-9c1c-178bb0fd42b5@amd.com>
 <98f72106-e62e-ef02-ff9b-d92edeb6950d@amd.com>
 <dac63b64-7b25-439f-a883-393e37826fb3@gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <dac63b64-7b25-439f-a883-393e37826fb3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a91e3d-84f8-444c-4960-08dc4277ca15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlBDB1lLdL08rY7uonDP4VwhxYWWKxzMhMV5wVwf7QFcMbS+dkjrmleJlRsMcu22iBiR3LjzkWqYz6AMu8PsdwX7ua9Cmn/dIS5Xo0ZS6knU4Z8OEM+ldk0yhcgTPnCe/IER9FK7Yr6cLR/GYtOCiYCljm9Ent5kojAZi3lXNlBYezvh8HxZ6Bpr8fgyHB6N2PQlT3JoOdUMjnTT2o5r69v9ozc7AyRDb3jZ/SEhzSub1VzAganux9XJOCS/+qcKA5l2VVgyauwhvgabibsm5pWT8RkwgwrMyuyLpusViYOsPMaPLOcubXoZ9iKplLguCCnlnOb932pzHHWb484m/FVqD3jdWmlH537GtIPv6nr12lIElE8VVXC9p8atLgn98VBOXVaguhBTTh//2XhlpTCzP1ZYo/+jykZ+rTix8+LMkarmdHqv5wFgdAG/mfUXfWwnu2GNVYO64Vfi+zLczsJzejZu8BKKK//UsSuC8UiUAduaVtkG3ki8bAVh0qWnDJErBnGsLyHQO3KT2QtDDFNGmsyWpjB9/kW/QxnD1+SS5mqJ0z8v2t1T1V5Zv1p43WKtSGeeXwoK+9+oKt2gWF1ZJkL1jm+z8YsIhWatobnMe3DxfEQEk30g08jqUeg4Fk9mj3PfTpGaYW981LdhVqNcS/EchDHJZZWF5KYioB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0VjV1BwV2RNQUN4OVI1cHRzYVlkNjNxOUN3enp1bDlHNUJxTDBwOHVZMVBu?=
 =?utf-8?B?Nm9hb0hIUmpDSW1Fa2wyeFdROWJFVUwzZHcrZDFDaVZ0ek1QVVRYN0tBMVp2?=
 =?utf-8?B?Nmx6QVpLa0Fmdm9CQ2FvaEo0NkNmTW9weE4vbXJvemVPMTFQMXkxdUFzclFK?=
 =?utf-8?B?RjIwU1RETm9tSndwKytObTlHNk5lcGFycUllcHVWdTljbFJTaDVGZ3hCT24w?=
 =?utf-8?B?b3BMeUhxZkdPMWdobkloeWFqVWF6T3grZ0srU2VEUkk4aTQ3VFg0YUg5UTM1?=
 =?utf-8?B?bFRWYk5JY0E1OVBoZFlkRUd3SmlkS2VycC9TNURNdy92TjNxeVpSVHFTbWlG?=
 =?utf-8?B?TzNvSVBHN3BPZ0MvSW03WW1NOHVTekpNOHdZaGhrT1V5UWxCRmNmN2M2L1l3?=
 =?utf-8?B?bFlPcldKRXFvSzJxUm9xTnA4a0plYWYydlRib1ZNSTB1b1h1Um5jV1JGRWRt?=
 =?utf-8?B?SXgzUnFUWFc5bEFIL2tsUVdyL1Yva3d6Wm5lWlp3Y1JNalBUMjlyK1FJZURV?=
 =?utf-8?B?bjhRaHFuUkpPd1pWeEVHTStKMzlaMGJZcUJ3UU45SDc3RjBhSGJqSUhrL1Nm?=
 =?utf-8?B?YnErNzJaM05rdjhPSFpVNGI5cytObVVhb05ka1RiV05GRkV1dGVyMUxYZUxE?=
 =?utf-8?B?L1ZtM0xvZmMzdTNJbGp2Y21MQ3d1WHJOOGJQK1hWR21SdWFocFZMWjFaMTF6?=
 =?utf-8?B?SGloRXpmWEk3WUpOUndKRDRvMlRHZ1hWK0RwaTFpSG9wdXR2UGgxYmpMODc1?=
 =?utf-8?B?TU5tbExoNUpId1ZqUWE0anh3eWZNbWZCZHpydWp5bTQzK215Y1dRVExTSXZE?=
 =?utf-8?B?ZE9uenMxdGRsMUpIYndEeFcvbnlqUEVHdXBBY0M2YzRHZThoUXdTaUhrT0pY?=
 =?utf-8?B?TGY5N0pkY1cwRDliTm5lK1E0NFVpYyswOTl2T3diSU1YK0M3UStXN3p2cGVj?=
 =?utf-8?B?MlpibHBKam9KajVyNk1IOU5laDZVL0VPYzdHNlhFREJHL21GRWk0cHd6Q0ly?=
 =?utf-8?B?STJaWVZhYW5SUnI4bDNKNStnUmNRa2EyTnRxVXgxVG9samx4dDdwMWhWemFF?=
 =?utf-8?B?aUlYcEQycnA4UlNLRk94KzZ4NXZRSFd3eVcwajROZnFxT0dhdU02TGZUKyts?=
 =?utf-8?B?WkpFTXE1YmdmNEQwSG1OSWJVQ2I5VUc2T2dTWE1WZEVKZlJZUDJCL2tkYU1l?=
 =?utf-8?B?eFljUURqeThwM3J6VjdmdTQ0R0FCdjhZWCtJVUpIVEpZTGhZRVJiTnkyWjBo?=
 =?utf-8?B?U1haYitJSmpkWGxGYkFzT0tKSkM0N2hPc3BKOGtnWG9vY1RaUGxBUWpHNkxW?=
 =?utf-8?B?cGwzSEhaWEQyRlB6TTM2ZWtaT1NpVXpRWkRUSjIvTVh0d1dOQ3VYNThxT0hN?=
 =?utf-8?B?UG5LbjVQckRLbEtRelM1WkdWVmladmNuTGtPaTU1THREYkx1UlF2Tk1RMmxj?=
 =?utf-8?B?U3lEZVRmMjFpR0cvMVVzSGNGbkx4K2FaVmtlRkZ2RzJXU29WWDZId3RaM0lx?=
 =?utf-8?B?bHZud3dNUXFqKzBlU1lnNk9QV1h1MTN1MmoyRnozYzRzdTg1dzYvei9RQ05n?=
 =?utf-8?B?cjI3T00zYWRoeS9kL2RGeGFWZjNNZExyc3cwOWppTVdYcEZDUHhYTFpGV2ZR?=
 =?utf-8?B?OFpMcjZDT1BabFVOUjZEbm5wQ3d6U3RRencva2R4WENmL0d2MEFBRHZ0TTY4?=
 =?utf-8?B?M3ZVaC9NRFBTZ1hxbkJ1RE80QmxMc0xLQXhBTVAvKy81eWowSTk4M1Z0SnlL?=
 =?utf-8?B?T2Vab05QaXhqMUgrbkNQNDVZWDVscHM0cUsrcndYeU5BYkpYRkpPaU1ESUFH?=
 =?utf-8?B?b3phVHNGUlR3RG41TDF0Y0oxQy8yc1hsRXF1eGxiZURqMEUxK0c3MWYzMFZO?=
 =?utf-8?B?MFBHYU1qWnB6VUd2aXdERDFrU3FJN1lpR0QvR3dhZmY5R1g5L29vNGxueUFo?=
 =?utf-8?B?NUxJMUl4Z1h4Rmp5dVJKd0kwQXZ2RnZJeUJUcHZwWkRKWlZHWFdpSjlmQk84?=
 =?utf-8?B?Z0tqZlU0VEErNE9iS3RVaWRLNkx5Q2dlTW9PaU9oWVd2SFNoL29mdXFDVFE4?=
 =?utf-8?B?Ymw2bmoyTWNoQk1wUUZrUVZUaFVXNzNmeWF5dTRGOXh6WHJtci9HUFNoc1Ex?=
 =?utf-8?Q?FxjYm4jUG0yJuMaUeQmpwoVBB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a91e3d-84f8-444c-4960-08dc4277ca15
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:35:44.1325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5s8yH9oi4ptimAPOISGeTSnw5UaYN8dTav6TvupkkTW+NpY3Muz0sL9v+0MtXLbSFyOnFIJop2CdQU/MsC3xUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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


On 12/03/2024 09:31, Christian König wrote:
> Am 11.03.24 um 15:37 schrieb Sharma, Shashank:
>>
>> On 07/03/2024 20:22, Philip Yang wrote:
>>>
>>>
>>> On 2024-03-06 09:41, Shashank Sharma wrote:
>>>> From: Christian König<christian.koenig@amd.com>
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
>>>> Cc: Christian Koenig<christian.koenig@amd.com>
>>>> Cc: Felix Kuehling<Felix.Kuehling@amd.com>
>>>> Cc: Rajneesh Bhardwaj<rajneesh.bhardwaj@amd.com>
>>>> Cc: Alex Deucher<alexander.deucher@amd.com>
>>>> Reviewed-by: Shashank Sharma<shashank.sharma@amd.com>
>>>> Signed-off-by: Christian König<christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma<shashank.sharma@amd.com>
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
>>>> +
>>>> +        /* Makes sure no PD/PT is freed before the flush */
>>>> + dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>>>> +                   DMA_RESV_USAGE_BOOKKEEP);
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
>>>
>>> To flush all XCCs, as this is a corner case, we could start with 
>>> this to make it correct for SPX mode for now, with extra flush for 
>>> other modes.
>>>
>>>     int num_xcc = f->adev->gfx.xcc_mask ? 
>>> NUM_XCC(f->adev->gfx.xcc_mask) : 1;
>>>     uint32_t xcc_mask = GENMASK(num_xcc - 1, 0);
>>>     int i;
>>>
>>>     for_each_inst(i, xcc_mask)
>>>          r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 
>>> TLB_FLUSH_LEGACY, true, i);
>>
>> Thanks for this input, Philip.
>>
>> @Christian, your feedback for this ?
>
> IIRC Felix and I talked about that before. In theory each VM should 
> only clear one XCC, but in practice that won't work.
>
> I suggest to just make it another parameter and maybe separate fence 
> allocation from actually arming it.


Based on the recent MI300 validation feedback, it seems the current 
patch is good enough to handle the problem. Should we go ahead and merge 
the current series now and keep this for a follow-up patch ?

- Shashank

>
> Christian.
>
>>
>> - Shashank
>>
>>>
>>> Regards,
>>> Philip
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
>
