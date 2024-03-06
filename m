Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771ABC5475B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 23:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32E110E485;
	Wed,  6 Mar 2024 23:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="siq5IB5O";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE8C310E485
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 23:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkYBqOXO6ioITFoABlq17pHbWHfIySBMrR3LtbbbgSz85ebLYoWwo4WB/2rnYfBo8piBks6xaA+rFwjZ7e/eL+sCptSLpr3xRdyGZhuSAOaRhy+y22zXj4ii7d6NKgupK92Nn1ROToohVeADonsBHG7Pw/j97BaY71B9MSn0cxnSiKQVeaHza9KjrlOmXm9Oe1HPB49jnhzZKni2cPHgSrvQDFIqoPitHRVmJuFi1Y4RCeuxnMXAeLRLXn1TIOyzVYM0pvCbvbad+EJVZ7KVpZdo2s8AgJUuBOldSgL8IFa3SHmDuCFXtLJFxsuQu3Ea3i8SmI7M7x50ws1zxVL21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYvqC1fajkBYstQjA/X1KPRKnsE7azosE2lwvZdNoqk=;
 b=l/JSY1gaIRoibbsnDf7vd00TjZ6L2sUVPsTPJDndj/hK08HxP0ASlZSGNnUyOIeAXjCUPv9SUPjQvVR/l7/14MNxzwP4RvG5L+CmdUfX0yLe/qMPXLPnf0ZaSV2o1MX9d7OwAvQ2f+zpzF5wVR6R7l8/XUAm5H/nnAYc/AdeivB+I0tcGtQiC97oMHYRznzLlnLEzbOpK5c05X0b35KkJpGyuLH1OkpYBZ6QRH0EchtWceNQCnbbleAKpon5LIlBafrBUFrl4Eqps2yHgWaEdnIrfpwAmE9e4+FYq7WV+5QRdibOiK5kZaloNGWyHEqtU63Ggyxr3UcwrSqVjCd6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYvqC1fajkBYstQjA/X1KPRKnsE7azosE2lwvZdNoqk=;
 b=siq5IB5OshxvT1VYod6WGYyeJNe8WkggumxfiBqlsY/SVTIpRmkSQ5BwnMhPCiuC4L/obDhG+CiBqLk8640ZVuum26As/MRj7+Ri/i/Jo5RznWOhtg+TIbGernB4iIoJSC+nRCZd7uEkEYRJgq0tvMrPq9/NT9eMoVK5sveQU80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 23:54:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 23:54:11 +0000
Message-ID: <92ce9da0-9e89-4fa0-a85f-c6090a067525@amd.com>
Date: Wed, 6 Mar 2024 18:54:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <yangp@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240306144115.1007-1-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240306144115.1007-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: e0529436-ba95-44f8-b076-08dc3e38b839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3XTyI1Rg8Ptx72bcigjIKi30FBJKZjJlSYmR/lXVbB/v0LWuN67bKmE4L7h9UYrxlMnNBSWnSApa9x4yDvQsaKo3SEcshEcoXg7g/usoSJL+k0x5jCP1cGgkQZFT/NXZyTPsuYIla7N7UTNEzJat0zAPTvgEwEK9hR9hUe0XNJJR0mvSSB7Rtdv1ixBB6rbgn2QCtiicAdSDa4jDQFnLErVXX80b0ZNWprHJzKa3v2Xz46r2P+bzLUYuJstSsRaRUMmp45ObMnVC2sL6QDgZAbZy3uZ/Ob9ieF+zdOhSVI1ip3awWU11IUbC2zr0fZuhtp0nrnhyda5HejPtdiho6YijA8iVR0pvhUahhkW8NXcM9DcC+nw7yNxZsOShzjL/TrTL1KnympMArRv0Jtc0AF3I0bM/4CiOOQpV8Ea+YK48PR8+RLMuWvJc2bbpZILidGp/dkycI7cYE+VlMK/h2vKUv7W85HP+smPqvH39ZcKyzBfR6BFaeash6APtsvXOSNdr0iQBAJiVg4+kG3glTt8U5zwq+ke2+/Rp1cLz51ZZ937+BcAXukNptxw+kgbf3gdbpPPRQu4J19/ZKQ7VtWOcaQU5IxjYWRp0+2xmU9wcvpwF/oBVrfe1H5KmzfL3kxE2SwESLt0iVMTt6xOIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG5POEY0UFplb3FoVkZ5V3g2ZGJqdm1ob0dkR2VzeHo0ZGZKR2RnVWlxUGJE?=
 =?utf-8?B?NjlHQjdKTEdkUDNKTmJ4c3BMcHUweENVZUs4UHAxK0RBc3JqSmFiZldlTS9K?=
 =?utf-8?B?SjhJRnVrWkhyV281NVlNb25TOXMwL2E4K0tRTU5ETGdTVnFlK1VqczNTTjha?=
 =?utf-8?B?MVlmYXlTR1FrZVBqNjRNZEsvSHZxaTh5Tk44b29yV0Y4Sm5vOWR6WlZSWkRP?=
 =?utf-8?B?MGNPY1N4ZnkwQ21hcXlNUi9MOHFCUG1DWks4OFdaWXA3L09PZmM5UGpIM0ph?=
 =?utf-8?B?M1lySXFGUEloOE1PWHZ4cDV5aTltaVY0S01qYjhJWithU1FMN1FPY3N4NUdK?=
 =?utf-8?B?QkthcnhpZU94RjRRRDlicmpLbnM4eDc4UWJMQnVBaTQwZUVoNHA3amh0dS83?=
 =?utf-8?B?ZEFGbi9CTzU4RlI2WGFhQnlPMGxPcWszYkI1ZGFEYjBjQ05zRzFLU3JYY09K?=
 =?utf-8?B?UlpsTUt5UGZBR29UdXRqMnFhMndMZ0ViTVlNWFowNUFsZEFpV0t0L0dWV2tF?=
 =?utf-8?B?WG1xbFlBKy9zTlpPZGFxamhESkI1Wmg1NVo0SWNEUXhDOVB4TVEycUtBVmFs?=
 =?utf-8?B?eU1FWmpCcHBtMnMxWktLR3h5VnlEN2pEZHNCOWJtWURFQ1RtaWdEZ1VRTjFn?=
 =?utf-8?B?b0R6aVF0WWNyeTlsOEFCYmpkY0JXWm5ZMHMydDJXeksrdUlzRFdlUVRPWFZw?=
 =?utf-8?B?SldNaHNpbkpUSytFSlRPMjBTY3pwclN5cjNkWnRqeE1BT3B4aEl5R3B0MDRU?=
 =?utf-8?B?NXluTW9aeFVOQWFxdDVmdzc0WFN6TlR5bVRucDdzOVNBNlY5R254Y3ZaYUZ1?=
 =?utf-8?B?NjNEalRaWUNEUDcwc3UvcXJGRFUxdUxDMERiaFRUMTlwbmZQNFMrWmlrcnlv?=
 =?utf-8?B?ZWUwZU1MT0hzd0t0NXFXVXVoSXRxd3FHc1B5NmpZOFhpdWQ2cS9CcEtyNEs5?=
 =?utf-8?B?RVFObi9rWlQ5bmdaQndXRWNxM1B0eUdtRk1kQk9LZEtKUDFzeGFJVG55QlJO?=
 =?utf-8?B?RVdPYjRsZk9PRkJmSFdEOHQ5RjRKczQxOVpNOTljZ1pLZ21LVmZUOVdLUVE5?=
 =?utf-8?B?TFd6MVhMSi9HSVZQTDY1SExpTS9lbmljSDlWS2Z1dmxjWE1leXJ6bmNuRmVH?=
 =?utf-8?B?Sm40cjFvcTRFcWFPeXVBY0JKK0lsdlpqZGx3VGhscFJsQzBWcUlRWDcrOUNS?=
 =?utf-8?B?NVZrL1g0aVlVMllTOVNtdVlMMWsyVzBybFVvYTIwaUhLdE1tTUxhR0tYd0JJ?=
 =?utf-8?B?K3R4UndQbFFzcHFPNVl1NWJ3dHFQaHNzSEJvUmpwOHg4VUJIeUNJQlY4R3Fy?=
 =?utf-8?B?R2k0c1gwUGFkNklod2tYOGd1U3p1aVBoL0QyM3RNcnZmKzUwQ0N6VkpaaXU2?=
 =?utf-8?B?ZVhnRUZ4bGlqU0xyS05oN1lJQ0lHQnZZdEovd0ZJYS9BT2xJVXludXpRTURv?=
 =?utf-8?B?VW4vMDg3RjQ5NERKbEZQOGhCSEZpRFRPdTZLWG9GY1ljN3ZxVTZ4dS9iL0Jx?=
 =?utf-8?B?TENxL2xiUE9XeHFNNU5kM0NPQ2hxRkJrZVZMOGpITkg3c25ad25nd3hYTStE?=
 =?utf-8?B?cVE5b2huTDhIVTJOYXllWHUyUjZjQUpBQXpIRitpZnU4S3JqMEZ3SWdsaEN2?=
 =?utf-8?B?ZU94V2RCTjJVd0c5Qy9IbmVCbHlJdFlDVkJrOVRvU2pENEZnWE40ZXQ1U2lF?=
 =?utf-8?B?TU9XNHdXUWswVGQ2RXpuNVRnVXFmblAxVFhZRGdFQmtzNnVzdUg3YkZ0azdx?=
 =?utf-8?B?dEZtRnV2aERXY2VwZTRpODZTcHVSeHNvWmxMdmRya0hwcVJSUFg1eW82a2NV?=
 =?utf-8?B?Rmx4VTdXQnNhUnRkWDRxd1prdDZ1enRWbE5sZnFjTWNKZWpxYkZYSGVNVTdV?=
 =?utf-8?B?VTQvU3RKTHZaNHJDRVZ0aExlRlBUcGtzNG9LYjBlUlh3YlNuRS9OYm9nb2JY?=
 =?utf-8?B?Y0JvTDVQVDV6bnJqeE5WNnRHZ1h1NklMbnZoVjh0b2VkekxpcXBReVlSNFht?=
 =?utf-8?B?NDdxUHYyK2poZHZiajJXV2hxTzBBMXV1Y2pjcEhiak9IS2huUE9Ud0lzZFNL?=
 =?utf-8?B?TEZsRHZ2bDlxbWNjWFRTWElSdlBRSk5XN0p2YXNKS1JIQ1lQS0pTRkpjbjU0?=
 =?utf-8?Q?0HpBz+kfy456Nw+/Yi/AGi0As?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0529436-ba95-44f8-b076-08dc3e38b839
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:54:11.0910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nO1cIiyxccDXYu6dB7HhUR0nMpgMb/hgZ9xQ4L8XZBcR+Aim4dKSootDgisSc4Ftvo2H6e52RRcHjZSFiE38Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
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


On 2024-03-06 09:41, Shashank Sharma wrote:
> From: Christian König <christian.koenig@amd.com>
>
> The problem is that when (for example) 4k pages are replaced
> with a single 2M page we need to wait for change to be flushed
> out by invalidating the TLB before the PT can be freed.
>
> Solve this by moving the TLB flush into a DMA-fence object which
> can be used to delay the freeing of the PT BOs until it is signaled.
>
> V2: (Shashank)
>      - rebase
>      - set dma_fence_error only in case of error
>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>      - use vm->pasid when f is NULL (Mukul)
>
> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>      - move the misplaced fence_create call to the end (Philip)
>
> V5: - free the f->dependency properly (Christian)
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 ++++++++++++++++++
>   4 files changed, 128 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index fa26a4e3a99d..91ab4cf29b5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>   	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>   	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>   	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
> -	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
> +	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
> +	amdgpu_ib.o amdgpu_pll.o \
>   	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>   	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
>   	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0960e0a665d3..310aae6fb49b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -988,6 +988,15 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	r = vm->update_funcs->commit(&params, fence);
>   
> +	/* Prepare a TLB flush fence to be attached to PTs */
> +	if (!unlocked && params.needs_flush && vm->is_compute_context) {
> +		amdgpu_vm_tlb_fence_create(adev, vm, fence);

This schedules a TLB flush after "fence" signals and replaces "fence" 
with a new one that will signal after the TLB flush is done. That part I 
understand.

I'm not sure why this only applies to compute contexts.


> +
> +		/* Makes sure no PD/PT is freed before the flush */
> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> +				   DMA_RESV_USAGE_BOOKKEEP);

But what's the point of adding the fence to the page table reservation? 
This is after the BOs have already been freed. Maybe it would make more 
sense to move this into the next patch, where the freeing is done after 
this point.

Regards,
   Felix


> +	}
> +
>   error_unlock:
>   	amdgpu_vm_eviction_unlock(vm);
>   	drm_dev_exit(idx);
> @@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	mutex_init(&vm->eviction_lock);
>   	vm->evicting = false;
> +	vm->tlb_fence_context = dma_fence_context_alloc(1);
>   
>   	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>   				false, &root, xcp_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 64b3f69efa57..298f604b8e5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -341,6 +341,7 @@ struct amdgpu_vm {
>   	atomic64_t		tlb_seq;
>   	uint64_t		tlb_seq_va;
>   	uint64_t		*tlb_seq_cpu_addr;
> +	uint64_t		tlb_fence_context;
>   
>   	atomic64_t		kfd_last_flushed_seq;
>   
> @@ -594,5 +595,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>   				  uint64_t addr,
>   				  uint32_t status,
>   				  unsigned int vmhub);
> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
> +				 struct amdgpu_vm *vm,
> +				 struct dma_fence **fence);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> new file mode 100644
> index 000000000000..51cddfa3f1e8
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <linux/dma-fence.h>
> +#include <linux/workqueue.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_gmc.h"
> +
> +struct amdgpu_tlb_fence {
> +	struct dma_fence	base;
> +	struct amdgpu_device	*adev;
> +	struct dma_fence	*dependency;
> +	struct work_struct	work;
> +	spinlock_t		lock;
> +	uint16_t		pasid;
> +
> +};
> +
> +static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
> +{
> +	return "amdgpu tlb fence";
> +}
> +
> +static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
> +{
> +	return "amdgpu tlb timeline";
> +}
> +
> +static void amdgpu_tlb_fence_work(struct work_struct *work)
> +{
> +	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
> +	int r;
> +
> +	if (f->dependency) {
> +		dma_fence_wait(f->dependency, false);
> +		dma_fence_put(f->dependency);
> +		f->dependency = NULL;
> +	}
> +
> +	r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
> +	if (r) {
> +		dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
> +			f->pasid);
> +		dma_fence_set_error(&f->base, r);
> +	}
> +
> +	dma_fence_signal(&f->base);
> +	dma_fence_put(&f->base);
> +}
> +
> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
> +	.use_64bit_seqno = true,
> +	.get_driver_name = amdgpu_tlb_fence_get_driver_name,
> +	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
> +};
> +
> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +				struct dma_fence **fence)
> +{
> +	struct amdgpu_tlb_fence *f;
> +
> +	f = kmalloc(sizeof(*f), GFP_KERNEL);
> +	if (!f) {
> +		/*
> +		 * We can't fail since the PDEs and PTEs are already updated, so
> +		 * just block for the dependency and execute the TLB flush
> +		 */
> +		if (*fence)
> +			dma_fence_wait(*fence, false);
> +
> +		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
> +		*fence = dma_fence_get_stub();
> +		return;
> +	}
> +
> +	f->adev = adev;
> +	f->dependency = *fence;
> +	f->pasid = vm->pasid;
> +	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
> +	spin_lock_init(&f->lock);
> +
> +	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
> +		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
> +
> +	/* TODO: We probably need a separate wq here */
> +	dma_fence_get(&f->base);
> +	schedule_work(&f->work);
> +
> +	*fence = &f->base;
> +}
