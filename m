Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD833C5478C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 13:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 148D210ECE9;
	Fri,  1 Mar 2024 13:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fNRF6ImN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A1B10ECDC
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 13:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHacHo6tQOBJarXev2/v0hiG6bTNSrNm7lEctFD248Zvvgk7W8qRvg7ByifDr1+XvZIJJODwpH7hEFd/KCv0gCk1XksvkVxM7T7Oe09H5DuVnqVqNyzY0MJW82otiiLjZHaDx7AwS+f+FKTDVTZ9bSKV5ouS320ru0QcBPZbJQzZjWaO6DJ9nXcznKMVtMcdCKyWEwQW3UMrycOoRMoBctIp7UvZClIYqRH+U8DiOfNLdayAoFJyUkmgzckSOUTh7xiEaahE7uJ8ZQuQuKfTq8bmAhqTuej2LOAY1rAhtV31mA7gcy63SW9bf6DT9YtDY0+tG1Hk/PCE5Fh87JrIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhfMIQ25br4hy3zcMZknbj8VYDl4rPZG7pG/WB5D/Ew=;
 b=IT2mZdROM7NIp4wA5K8zrbWEUuvsRa+HzknEcldeoHd465uRG9fvW4fd0PURAg43Ed6pxnA+25mUUi/gNPjETaG+uc7Led9ZBH3dkpiEYgPwrEnsI89+FVBW+IX95DgVI6UOMO+8PxZxI9nw7/fwUED+JBIYa+9U76Crpn5wzzpZrl/ycYg3e7WZmntr08HEyhw7S2ha73ivAjXOxRi4jNnhobiy9b/Nxuzk34nKP9p1AcCdOPPgH1R7AGEN0zuzlX7RXu52DZNEDtw0F8d3rwWCi/5asiFiEwI0zL6w8AcWwjXCjCFabSICWQUJ3ZYj09khaoODZ6Jv2pJf1oXexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhfMIQ25br4hy3zcMZknbj8VYDl4rPZG7pG/WB5D/Ew=;
 b=fNRF6ImNUon9UX+9v/9FG4wB1O8ZjyuxYq4TejdmLjjq2Zz4RyWUxKZJjPrjpVzhCs75/QsU7YW8Iu/ZXz8aJqSXq44gie4anPvsAS2yrYc43SluE/ONTpthcwprf2lYvAGbu14C6rqamz3wNO2cLGvIHzif8v5Cb1uFch5pIrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 13:08:45 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::baa0:7590:7bdd:e60]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::baa0:7590:7bdd:e60%2]) with mapi id 15.20.7316.023; Fri, 1 Mar 2024
 13:08:45 +0000
Message-ID: <07246105-5464-cdcd-49b6-d2cb89db3d90@amd.com>
Date: Fri, 1 Mar 2024 14:08:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Philip Yang <yangp@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240301110724.947-1-shashank.sharma@amd.com>
 <33c50082-c9d2-425f-9f6d-74ed43ba565d@gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <33c50082-c9d2-425f-9f6d-74ed43ba565d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: b25d1f10-a011-4ac3-ecc8-08dc39f0b9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuYK6K6tEgtn58CUlSPoRE89T7VeXZBYr9kLXhG8c2Z0GpW6snYr+wbR+b9i4aJNNyc0PMiFngudMraGDVYidgqpBF8U/SjFiA0Z1egSoRfNF4kq0UfAx8LdoboBn5jmxlbv8NfFwNwtT0+n1kwVwfcYW8NZHFU8KeuK2ryE54yM1jle5Y7DFECoQ6oI+LKx2BSp+X2MPiux9tbPh56KowJv0HIUeErxIkJN1TeGpWJjHxOJGKQ8AndewO30greSRQ/oCGlD5Xmig+Y86BKDdkCeIcS6geKmfnEfWSbPwxKkhVmy3g1B0DrghOjCtEllJGKTIqhoQEhur7C0HxScsGomO1Ct6XG7W00LBVtlrnoNgTSA8kvy0Hl9p2cDn811vjT45Onn5ODSuWe3q9WbBSAXfV/7w8CIlcVEfRsdiG24K7Jb4oU4Zzr9mzFXjgjFED4uyyt6wpNaA3jWUDggVRgruvIs8BzDImVx6v5iBONyXUOKOBXIdC/4bWGHX3cXqc2eM48KwFZhJ+t/29ozJbLVgMcisBaWtUAJsECFpFognS/NsMa8P0V8+AKuBrMb7wxsX+ptJq/XK9ZKvr9XkqGgLVg9ESRUDE0SF+wxW9fkZLINu5TACS8mxYUARX3e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEhHMktnMnFxaDZOc2pQTnNBbDRqRTlvbTdiaVhjRFB2U2tPbEdxMXArRVlQ?=
 =?utf-8?B?ZGJMLy9ibjZnWkhNcWI1TVdEZEx4WFIvRjdXdFluR2trNU5hcXdBWlhnQi9U?=
 =?utf-8?B?Tyt4K0lBelBFblNkbEE1R0doSGNpN25JNFV3OTZIZ2lxV1dsUGU5MjdQTy9J?=
 =?utf-8?B?aHFvNU5KYU4vMnJJY1dicUw0eDNBaHFQUlNBVkttNUZySnVJdTk4aXBiYVFh?=
 =?utf-8?B?aXlQSTg4aEFmcUI2T0k1WXE1Ulh3SFVQY0p6VVV1dkNBL2pKMnQwY3V5bzB5?=
 =?utf-8?B?UXBvYVVzUVBVT1hLdm9lcXh6YlUvdzVPUWVHaXQxUVBvWjU4VFdDbFpQR0Jw?=
 =?utf-8?B?eTF5YWtCZzc4N3ZyOStvVVpQdHViN3ZYUVk0Zko0U29GTEorZ3JjMTZsbGV4?=
 =?utf-8?B?MzRHckpieEdaemRCZ2VlWUl5NHZjOW0xdTFINE1takNWcUJaV0xTNi9oZTdM?=
 =?utf-8?B?T3BtWEM1azVhb0hQTThMS3U2TTh1ZUs0M3B1a2hwczVWWHppVll1N21ucW1p?=
 =?utf-8?B?eSswNE54bENKUmlJbGUweXpVL1E3NDU0dzRtbXl6UkdKVmFDekc1NjAvb3Vw?=
 =?utf-8?B?TGJ2OVNQcmRJMU9ZMlRKZDA0amoxYzJ0b3FoTGVYelB3YlF4WVFKSlNkN1R1?=
 =?utf-8?B?S2ZLN05XOVI5Q2c1dWsvalBEVXJpSmk1NS9KNFBBcHdLdFBlWk9vS1FlcEtM?=
 =?utf-8?B?R0JjKzFqaXp4UHVUaENXTUQvay81N25xd1pMSFFEem5hVDdqUzlnNk5JLzN2?=
 =?utf-8?B?ZXNNamRTTEgyaTVsWWs3MVQ1UzhSRFZpaVZxYzNPV3Urb2cyMCtuRmZWUHdB?=
 =?utf-8?B?NVlDdmdQa2ZEQUJoS2lzS1VWczViUWFIK2IveTlzMTl0ZEdzVHUxaHdJVU9t?=
 =?utf-8?B?M3JBQi9STnlmaVp4SXBIalRMY2NSRkJXd255cWlyYXBIeFFsVkx0cFFSSXli?=
 =?utf-8?B?Zk5TTGY0SnNNSDBvV1FUeDNEVU51eVp4c2ZTbjRCdVc2SzhUR3V0TDczaEg2?=
 =?utf-8?B?NTMvcjF6TjAxZkRaM3R5ZUVMeWFrR0MrR3R6ZkVHaFN4QWF4eERMc05CNVpN?=
 =?utf-8?B?MHN0a1k4TlpacXpaUTYxUHJVTHFiZDZvdWc0RjdyZjF1YjFKbWFSd2xLaUVu?=
 =?utf-8?B?WHFBNVpnMW9XbDg3MnE2UEIyZHhQNEdZWHFKcW85NVFJNDhXa2xoL1E5OVJZ?=
 =?utf-8?B?dENERXdvb2FSQW5xTUc0RXZja0tTTVlCVG5BYXdHNnN6RytHOENEMForTGNH?=
 =?utf-8?B?YURZUmxzNUhrZWZJdEI0U1VKTitXL3BqVUs4amZxTi9zaHlUN0RiRmJFeDFr?=
 =?utf-8?B?QngrUXlFY2psYkFwdzlvb2RiNzVuR3BHUWpuVUdTT3cvUW9NM0xJQnl5bDZY?=
 =?utf-8?B?V2ZKOWFFMUFlVm9hZ0YwS0ZBanpBSGJsWWxEcDZTVUlrWjBhTFRtT3VDYXdr?=
 =?utf-8?B?QzVLYUZrUnBsdXhqb1FWNDJEMFVtQllWRW0zbTdBOHI5WVNHV2tVMW8rN3Az?=
 =?utf-8?B?WGhuRmNWTlRUZE5ua2NIS2EwaHovVW5FZXRyWGNDY2pIVFJVRTg5c3VneEZv?=
 =?utf-8?B?WTZhbmQxTThsZlVwUGJ5TWxxMmVKKzgyMXFtWHpkRmVpR25MVk80M0JIN3hQ?=
 =?utf-8?B?MldlV0kwaVZ1VVpydnJoeXU5NHQydldpT1JxYk5kM2oyOE5UOXhRZmxEMWZu?=
 =?utf-8?B?TkYxUVRSWEN3UERtVEk4Y0oyZjFvS0tRZzRCZThIRlZJK1JDTDlKUVM4S3Rk?=
 =?utf-8?B?Vm1aVHZsZi8vT3hqeStZSEZmek9jZlZTMU5vSC9UdEpCdjdjNDhiVmE5M0lC?=
 =?utf-8?B?ZlA5aVVzQ00vSTlPY2l1ME85MkZUSDNGMC8vZFNackNFNlo1MTE1dm9KaklL?=
 =?utf-8?B?TzhRZGxHdEx2QjlzMkxDMWkxb0cwRlloR21Idk9FZ0ozL1V0RHFoSFZpMmFk?=
 =?utf-8?B?dVprMHZGbjBaN3E5RGE5d0lHeVNqbXB3QmNLbEdOd1ZpZ09pd1BRUUdsUnlJ?=
 =?utf-8?B?RS9vYTNBTlVSdWM3QzhQNEo0RmhkdzlQWjUyNG1QODE5ZHBlWW4veFk1WS8y?=
 =?utf-8?B?WUhoMDZZYS9RUXhNZFQ5RWpaMkxHbFBQMFVQUmJ5QkNGblZqcU00Yno0L29I?=
 =?utf-8?Q?rd51Dv/sPVwAmtBuDXoPbKIt7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25d1f10-a011-4ac3-ecc8-08dc39f0b9ea
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 13:08:45.6662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHKwJvHa5DHnCGv4/MfwQtlJA14G1i/eJ4cx/SIeoWO0hQ0OA9YLlDWllYZTfpu3liAFDZfCwZV9kLLELm7rBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
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


On 01/03/2024 13:59, Christian König wrote:
> Am 01.03.24 um 12:07 schrieb Shashank Sharma:
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
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 111 ++++++++++++++++++
>>   4 files changed, 127 insertions(+), 1 deletion(-)
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
>> +
>> +        /* Makes sure no PD/PT is freed before the flush */
>> +        dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>> +                   DMA_RESV_USAGE_BOOKKEEP);
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
>> index 000000000000..54c33c24fa46
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> @@ -0,0 +1,111 @@
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
>> +        f->dependency = dma_fence_get_stub();
>
> That doesn't correctly drops the f->depency reference.
>
> You need something like "dma_fence_put(f->depency); f->dependency = 
> NULL;" here instead.
>
> Apart from that looks good to me,


Noted, will update.

- Shashank

> Christian.
>
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
>
