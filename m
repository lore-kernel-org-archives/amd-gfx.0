Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C5EC07545
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 06:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C2510E2DD;
	Tue, 24 Oct 2023 06:01:01 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E1B10E2DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 06:00:59 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ba081173a3so643372266b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 23:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698127258; x=1698732058; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yItibheYKmuGuFXD0RO6DSdn65yFwOLuG7LRlUNNvtM=;
 b=kjEPV/ZghKorf3y2bzHAUnRwhj0mlS07z0M7xsKMyQfjJkAh4hKGOqFjpIdKdfG13o
 E0QH4fdl9tMjVt4dDBwXMf1SKyTADyD2QXx//OgAApEHKDGiiLMW01R+YHLveyCPliwg
 yvBz2pCwhrE2o4SjP+vX7N7JKIrUQYl0bBZ+z0NlwxPbH+S7RqhfhLyOkp50C0cXUZuq
 JSrCLM8afd9t5zF4C4D1uzYjv+BuO+2P1DGIXMq6XpVTuzQLLsHaSv+MEIZEAsJ8KJTW
 OFziYBd9Rvr8ER22L7zyC87wmxAh9dg1RCFRRlE6woWzk7W3hgJnh6AH6FG1bFQDHVUn
 VlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698127258; x=1698732058;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yItibheYKmuGuFXD0RO6DSdn65yFwOLuG7LRlUNNvtM=;
 b=ox/PV3TFsUETtCN05GUEsvbUrZqvzdeFHM5iutdIvv1iLgMLZjiujGZi9i/WzIoPWm
 BsMgf6Umbkti8p4NMnp7yK8cXmt52vhmwZoVYHjOz7XO6Tpe/11NI149nRjpa6fWj4sY
 DMZgX4WM6461MRGttu20rO/nQEtj6o6BPf+ukmNg7nTQ5kxKX6d614kaB/VoahVeIvdS
 I2e5ykpKw194Yu1I1tJw5DKO8xq2e7NP1NM4KrO24OHCFg0MwSXCHt9ns9WlJBqnIgPC
 +hn63GqYXZXyFRDifHPKv520u+IEInPA2ZeEX4jbp37B8BHYC/LC3pT0gvNHLzmBUdoo
 yv+Q==
X-Gm-Message-State: AOJu0Yz2OaqDVySY7JmPWwd5ssX94uNBJYLbwN0lvkUZA4gqat4dVG9m
 VCwfgSn9rWrt9OuUZgWbVmg=
X-Google-Smtp-Source: AGHT+IHMAlIlDBbaLBh3J2moddIj/y88b/oIMhIfw93Y3C9K/DdSz41FRdXYJ/YweJkyRt9FvyLGjg==
X-Received: by 2002:a17:907:6e8c:b0:9b2:765b:273b with SMTP id
 sh12-20020a1709076e8c00b009b2765b273bmr11288284ejc.70.1698127258085; 
 Mon, 23 Oct 2023 23:00:58 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.55.171])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a1709063bcc00b0099bc2d1429csm7662114ejf.72.2023.10.23.23.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 23:00:57 -0700 (PDT)
Message-ID: <bf4e2094-3304-412b-a196-27c289e080a5@gmail.com>
Date: Tue, 24 Oct 2023 08:00:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Initialize schedulers before using them
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20231023032344.164925-1-luben.tuikov@amd.com>
 <402f475c-bb67-4061-9521-2f811eca7657@gmail.com>
 <53e14f59-6743-4a11-bf27-151507071bb0@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <53e14f59-6743-4a11-bf27-151507071bb0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.10.23 um 04:55 schrieb Luben Tuikov:
> On 2023-10-23 01:49, Christian König wrote:
>>
>> Am 23.10.23 um 05:23 schrieb Luben Tuikov:
>>> Initialize ring schedulers before using them, very early in the amdgpu boot,
>>> at PCI probe time, specifically at frame-buffer dumb-create at fill-buffer.
>>>
>>> This was discovered by using dynamic scheduler run-queues, which showed that
>>> amdgpu was using a scheduler before calling drm_sched_init(), and the only
>>> reason it was working was because sched_rq[] was statically allocated in the
>>> scheduler structure. However, the scheduler structure had _not_ been
>>> initialized.
>>>
>>> When switching to dynamically allocated run-queues, this lack of
>>> initialization was causing an oops and a blank screen at boot up. This patch
>>> fixes this amdgpu bug.
>>>
>>> This patch depends on the "drm/sched: Convert the GPU scheduler to variable
>>> number of run-queues" patch, as that patch prevents subsequent scheduler
>>> initialization if a scheduler has already been initialized.
>>>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 4e51dce3aab5d6..575ef7e1e30fd4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -60,6 +60,7 @@
>>>    #include "amdgpu_atomfirmware.h"
>>>    #include "amdgpu_res_cursor.h"
>>>    #include "bif/bif_4_1_d.h"
>>> +#include "amdgpu_reset.h"
>>>    
>>>    MODULE_IMPORT_NS(DMA_BUF);
>>>    
>>> @@ -2059,6 +2060,19 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>>    
>>>    		ring = adev->mman.buffer_funcs_ring;
>>>    		sched = &ring->sched;
>>> +
>>> +		r = drm_sched_init(sched, &amdgpu_sched_ops,
>>> +				   DRM_SCHED_PRIORITY_COUNT,
>>> +				   ring->num_hw_submission, 0,
>>> +				   adev->sdma_timeout, adev->reset_domain->wq,
>>> +				   ring->sched_score, ring->name,
>>> +				   adev->dev);
>>> +		if (r) {
>>> +			drm_err(adev, "%s: couldn't initialize ring:%s error:%d\n",
>>> +				__func__, ring->name, r);
>>> +			return;
>>> +		}
>> That doesn't look correct either.
>>
>> amdgpu_ttm_set_buffer_funcs_status() should only be called with
>> enable=true as argument *after* the copy ring is initialized and valid
>> to use. One part of this ring initialization is to setup the scheduler.
> It's the only way to keep the functionality of amdgpu_fill_buffer()
> from amdgpu_mode_dumb_create(), from drm_client_framebuffer_create(),
> from ... without an oops and a blank screen at boot up.
>
> Here is a stack of the oops:
>
> Oct 20 22:12:34 fedora kernel: RIP: 0010:drm_sched_job_arm+0x1f/0x60 [gpu_sched]
> Oct 20 22:12:34 fedora kernel: Code: 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 53 48 8b 6f 58 48 85 ed 74 3f 48 89 fb 48 89 ef e8 95 34 00 00 48 8b 45 10 <48> 8b 50 08 48 89 53 18 8b 45 24 89 43 54 b8 01 00 00 00 f0 48 0f
> Oct 20 22:12:34 fedora kernel: RSP: 0018:ffffc90001613838 EFLAGS: 00010246
> Oct 20 22:12:34 fedora kernel: RAX: 0000000000000000 RBX: ffff88812f33b400 RCX: 0000000000000004
> Oct 20 22:12:34 fedora kernel: RDX: 0000000000000000 RSI: ffffc9000395145c RDI: ffff88812eacf850
> Oct 20 22:12:34 fedora kernel: RBP: ffff88812eacf850 R08: 0000000000000004 R09: 0000000000030000
> Oct 20 22:12:34 fedora kernel: R10: ffffffffc066b850 R11: ffffffffbc848ef1 R12: 0000000000000000
> Oct 20 22:12:34 fedora kernel: R13: 0000000000000004 R14: 0000008003000000 R15: 0000000001000000
> Oct 20 22:12:34 fedora kernel: FS:  00007f7be4866940(0000) GS:ffff88880ed00000(0000) knlGS:0000000000000000
> Oct 20 22:12:34 fedora kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Oct 20 22:12:34 fedora kernel: CR2: 0000000000000008 CR3: 000000012cf22000 CR4: 00000000003506e0
> Oct 20 22:12:34 fedora kernel: Call Trace:
> Oct 20 22:12:34 fedora kernel:  <TASK>
> Oct 20 22:12:34 fedora kernel:  ? __die+0x1f/0x70
> Oct 20 22:12:34 fedora kernel:  ? page_fault_oops+0x149/0x440
> Oct 20 22:12:34 fedora kernel:  ? drm_sched_fence_alloc+0x1a/0x40 [gpu_sched]
> Oct 20 22:12:34 fedora kernel:  ? amdgpu_job_alloc_with_ib+0x34/0xb0 [amdgpu]
> Oct 20 22:12:34 fedora kernel:  ? srso_return_thunk+0x5/0x10
> Oct 20 22:12:34 fedora kernel:  ? do_user_addr_fault+0x65/0x650
> Oct 20 22:12:34 fedora kernel:  ? drm_client_framebuffer_create+0xa3/0x280 [drm]
> Oct 20 22:12:34 fedora kernel:  ? exc_page_fault+0x7b/0x180
> Oct 20 22:12:34 fedora kernel:  ? asm_exc_page_fault+0x22/0x30
> Oct 20 22:12:34 fedora kernel:  ? local_pci_probe+0x41/0x90
> Oct 20 22:12:34 fedora kernel:  ? __pfx_sdma_v5_0_emit_fill_buffer+0x10/0x10 [amdgpu]
> Oct 20 22:12:34 fedora kernel:  ? drm_sched_job_arm+0x1f/0x60 [gpu_sched]
> Oct 20 22:12:34 fedora kernel:  ? drm_sched_job_arm+0x1b/0x60 [gpu_sched]
> Oct 20 22:12:34 fedora kernel:  amdgpu_job_submit+0xf/0x70 [amdgpu]
> Oct 20 22:12:34 fedora kernel:  amdgpu_fill_buffer+0x2b4/0x650 [amdgpu]
> Oct 20 22:12:34 fedora kernel:  amdgpu_bo_create+0x401/0x4a0 [amdgpu]
> Oct 20 22:12:34 fedora kernel:  ? srso_return_thunk+0x5/0x10
> Oct 20 22:12:34 fedora kernel:  amdgpu_bo_create_user+0x24/0x40 [amdgpu]
> Oct 20 22:12:34 fedora kernel:  amdgpu_mode_dumb_create+0xf8/0x1a0 [amdgpu]
> Oct 20 22:12:34 fedora kernel:  ? drm_client_framebuffer_create+0x69/0x280 [drm]
> Oct 20 22:12:34 fedora kernel:  ? __pfx_amdgpu_bo_user_destroy+0x10/0x10 [amdgpu]
> Oct 20 22:12:34 fedora kernel:  drm_client_framebuffer_create+0xa3/0x280 [drm]
> Oct 20 22:12:34 fedora kernel:  ? amdgpu_vm_bo_add+0x2a/0xb0 [amdgpu]
> Oct 20 22:12:34 fedora kernel:  drm_fbdev_generic_helper_fb_probe+0x61/0x190 [drm_kms_helper]
> Oct 20 22:12:34 fedora kernel:  __drm_fb_helper_initial_config_and_unlock+0x297/0x500 [drm_kms_helper]
> Oct 20 22:12:34 fedora kernel:  drm_fbdev_generic_client_hotplug+0x66/0xb0 [drm_kms_helper]
> Oct 20 22:12:34 fedora kernel:  drm_client_register+0x75/0xb0 [drm]
> Oct 20 22:12:34 fedora kernel:  amdgpu_pci_probe+0x3ac/0x440 [amdgpu]
> Oct 20 22:12:34 fedora kernel:  local_pci_probe+0x41/0x90
> Oct 20 22:12:34 fedora kernel:  pci_device_probe+0xb3/0x210
> Oct 20 22:12:34 fedora kernel:  really_probe+0x19e/0x3e0
> Oct 20 22:12:34 fedora kernel:  ? __pfx___driver_attach+0x10/0x10
> Oct 20 22:12:34 fedora kernel:  __driver_probe_device+0x78/0x160
> Oct 20 22:12:34 fedora kernel:  driver_probe_device+0x1f/0x90
> Oct 20 22:12:34 fedora kernel:  __driver_attach+0xce/0x1c0
> Oct 20 22:12:34 fedora kernel:  bus_for_each_dev+0x63/0xa0
> Oct 20 22:12:34 fedora kernel:  bus_add_driver+0x112/0x210
> Oct 20 22:12:34 fedora kernel:  driver_register+0x55/0x100
> Oct 20 22:12:34 fedora kernel:  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> Oct 20 22:12:34 fedora kernel:  do_one_initcall+0x46/0x310
> Oct 20 22:12:34 fedora kernel:  ? srso_return_thunk+0x5/0x10
> Oct 20 22:12:34 fedora kernel:  ? kmalloc_trace+0x26/0x90
> Oct 20 22:12:34 fedora kernel:  do_init_module+0x60/0x230
> Oct 20 22:12:34 fedora kernel:  init_module_from_file+0x75/0xa0
> Oct 20 22:12:34 fedora kernel:  idempotent_init_module+0xf9/0x270
> Oct 20 22:12:34 fedora kernel:  __x64_sys_finit_module+0x5a/0xb0
> Oct 20 22:12:34 fedora kernel:  do_syscall_64+0x3b/0x90
> Oct 20 22:12:34 fedora kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>
> It is at PCI probe time, when DRM probes for an fb dev.
>
>>
>>> +
>>>    		r = drm_sched_entity_init(&adev->mman.high_pr,
>>>    					  DRM_SCHED_PRIORITY_KERNEL, &sched,
>>>    					  1, NULL);
>> That here looks totally incorrect and misplaced to me.
>> amdgpu_ttm_set_buffer_funcs_status() should only enabled/disable using
>> the copy functions and not really initialize the entity.
>>
>> So the entity should only be created when enable=true and it should
>> especially *not* re-created all the time without properly destroying it.
>>
>> Can you look at the history of the code? I'm pretty sure that this was
>> at some time correctly implemented.
> Yeah, the drm_sched_entity_init() line above--which is not part of this
> patch--comes from this commit:
>
> commit c3aaca43fb07ce
> Author: Mukul Joshi <mukul.joshi@amd.com>
> Date:   Wed May 17 15:53:50 2023 -0400
>
>      drm/amdgpu: Add a low priority scheduler for VRAM clearing
>      
>      Add a low priority DRM scheduler for VRAM clearing instead of using
>      the exisiting high priority scheduler. Use the high priority scheduler
>      for migrations and evictions.
>      
>      Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>      Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> The options are,
>
> a) Revert c3aaca43fb07ce.
>
> b) Let this patch in, so that it's not blocking the DRM dynamic sched_rq,
>     and we can fix this properly in the future locally in amdgpu, as it is
>     a driver issue, and it shouldn't be blocking the DRM dynamic sched_rq.
>     If we had the dynamic sched_rq in before May 17 of this year, c3aaca43fb07ce
>     wouldn't have been able to go in (due to oops). More details in the commit
>     message of this patch above.
>
> I'm writing this from a 6.6.0-rc6 + {DRM dynamic sched_rq patch, this patch}.

Let me take a closer look first, there seems to be quite a bunch of 
stuff wrong here. Alex, if you can some input would be helpful as well.

In general "drm/amdgpu: Add a low priority scheduler for VRAM clearing" 
shouldn't have added the entity init in this place, but this is just a 
minor issue.

The bigger problem is that we call drm_client_register() *before* the 
hardware is fully initialized. That is certainly illegal and can cause 
quite a bunch of other problems as well.

What saved us so far was the fact that once the scheduler is created we 
ended up with the right result, e.g. a cleared and allocated buffer. But 
that was pure coincident and not proper engineering.

Thanks for looking into this,
Christian.

>
>> Thanks,
>> Christian.
>>
>>> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
>>> prerequisite-patch-id: c52673df9b6fc9ee001d6261c7ac107b618912a0

