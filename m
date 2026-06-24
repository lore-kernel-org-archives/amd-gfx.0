Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DF4CDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 15:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D187410E096;
	Wed, 24 Jun 2026 15:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="gL1vubPV";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7073F10E096
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 15:52:34 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso753309f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1782316353; x=1782921153; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F9f4nYUvDKjRFE4M/8PFMIViAjPbEFHyasU1OoAkZRI=;
 b=gL1vubPVcbVTkvwq1kxH5QjyPTPEDi8bx4MQMZCiglzWDUEA5tkN4JZKH0IGSl+NDS
 dy/fSI+djQpLJWw3mnl30uEpLPJ2cCfNJVHoEUieeMmCy4Iuzm6/Xx/C10R9fuSZ5waX
 zreTvQB8PHFkOJo0aljIv7GS0iLZTUENGCRPxs5XpSNk+mtRhXQ6ZSrS/ahAhxA1cwsg
 CLTAsBcv7sLUi/c+nezEBj0tXLNJ8AqWKsMS/lDDOZpyJCyOObV1OiGl0w7Y8q+JXCcL
 +A86E3+JFPksWnQ9hHw68RJ732yoOMHZ/z9Yw8L7O5GAdQozVnxJzf8BPeTVRiLKlbrq
 Xb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782316353; x=1782921153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F9f4nYUvDKjRFE4M/8PFMIViAjPbEFHyasU1OoAkZRI=;
 b=bRygZ8Mij60xYpGPd0igFfDh7zYr4dNTqUqvSY83pInJwdoJnR8mbJHboThOMrJ1TD
 CLES9pXev54yG312NOIlFQPu4JXrxkTTgyVwnmNgEv4iI/QoTWv9ny35utwuI395E8au
 30VNtqc4tVUPO8w55QRMBW/hr8PJbaWC5xWgGDA2IkUpps44rxpenjKwdI4X+kgqVmKk
 doyAsM4JMvvZ0jxT1/VoatBMkVAOZOhzhJUo6UPS2Oj2o91Bo5Vx1rATzheNyWqHYPom
 RrpVDo/eFuDCyICGawJrW8mVP3eRyznzasNx+/mKI2uKQNtppSBzQo+jtTDYxbd6DN3N
 Vkhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKb7DlPddP8r+RGwGUL5kYUtW59gLBybP5TetO6a0ijAdL3qaRJvB0F5w4YT1Ood8lOtAkNcjk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyERHYCADj1jyYF5eP+92lvcpKEbl8rij/nOJIrHuf0m0YmLh3Q
 5ucj5PXxVj60Q65ziYfDNaYc/f7dxyBDn9Aks+1diBjCjLeirjc6rF/5eYbwV1kcolo=
X-Gm-Gg: AfdE7cmiVGOtn2ulrjx6LJUQ0T7v2aXjNIN5p9I9fvuLfl4utxqxHJVepfkJw7hPbBp
 ou1vO0ekmy+1yOCqGh0p54HKb3sGxEWCor6hsfv8TLg9UO1WQzTyJ3qmie7bdup/mijYKec0Zru
 BrDnClnKoGZ+GFboKdcVXYY+bZrajJi9NehRMTbGawWjr+guXY2ycSLNLNnYx8yxVEAnWeyYXf9
 v+efeEXTmgQ5NBYkCLSX/ifCTrFZeQsCgUzJtrXQ0HTT7eM9DbleKCIJD0oHjs+LCHGkGsYfrD9
 Hc7oJIatraTEZmdNv0xUEipSBXCI3r73GJ0akK2KqR1wBxe55tqxXR+XRaiWDoMfftGBXWYIsU9
 DFa0KWiDIMriX218EVOxFDnhf7rPJslDlqzgAWTG9cknen92DYoJC8Ih229WPpBkj0ftEp9Q0Jc
 E3T2mSKw3BvJl9oYAV1TZeP1Dwxc8iAQL0qA==
X-Received: by 2002:a05:6000:402b:b0:460:65bc:780f with SMTP id
 ffacd0b85a97d-46c08999604mr6788582f8f.13.1782316352633; 
 Wed, 24 Jun 2026 08:52:32 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c225b2988sm7388172f8f.25.2026.06.24.08.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 08:52:32 -0700 (PDT)
Message-ID: <51f1d604-f1e2-436a-92cd-f218bf064316@ursulin.net>
Date: Wed, 24 Jun 2026 16:52:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu: ACK the retry CAM after VM update finishes
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
 <2746166.fDdHjke4Dd@timur-max>
 <50b62ba1-c709-4f9e-818d-956bc431c89b@ursulin.net>
 <2343144.t9SDvczpPo@timur-max>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <2343144.t9SDvczpPo@timur-max>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 24/06/2026 16:42, Timur Kristóf wrote:
> On 2026. június 24., szerda 17:14:59 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> On 24/06/2026 15:52, Timur Kristóf wrote:
>>> On 2026. június 24., szerda 16:31:20 közép-európai nyári idő Tvrtko
>>> Ursulin
>>>
>>> wrote:
>>>> On 29/05/2026 11:30, Timur Kristóf wrote:
>>>>> Add a fence callback to the VM update and ACK the retry CAM
>>>>> after the VM update is finished. Previously, we would ACK it
>>>>> immediately after calling amdgpu_vm_handle_fault() which
>>>>> caused a race condition that was likely to trigger the same
>>>>> interrupt again, causing the same fault to be handled
>>>>> multiple times.
>>>>>
>>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>> ---
>>>>>
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 28
>>>>>     +++++++++++++++++++--
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  8 ++++++
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  2 +-
>>>>>     4 files changed, 36 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
>>>>> 26aea960e2759..21c8d87477448 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> @@ -545,6 +545,16 @@ void amdgpu_gmc_filter_faults_remove(struct
>>>>> amdgpu_device *adev, uint64_t addr,>
>>>>>
>>>>>     	} while (fault->timestamp < tmp);
>>>>>     
>>>>>     }
>>>>>
>>>>> +static void amdgpu_gmc_retry_fault_handled(struct dma_fence *fence,
>>>>> +					   struct dma_fence_cb
>>>
>>> *cb)
>>>
>>>>> +{
>>>>> +	struct amdgpu_fence_cb *afc = container_of(cb, struct
>>>
>>> amdgpu_fence_cb,
>>>
>>>>> cb); +	struct amdgpu_device *adev = afc->adev;
>>>>> +
>>>>> +	/* CAM index is the array index of the current callback struct */
>>>>> +	adev->irq.ih_funcs->retry_cam_ack(adev, afc - &adev-
>>>>
>>>> gmc.retry_cb[0]);
>>>>
>>>> Is the "afc - &adev->gmc.retry_cb[0]" part correct? It will be the index
>>>> of the array element, while ->retry_cam_ack() expects the content of
>>>> that element, no?
>>>
>>> Like the comment says, the CAM index is the array index.
>>> We just need the CAM index in order to tell the CAM to ACK the current
>>> entry. The contents of the array are just there to make
>>> dma_fence_add_callback() work with this callback function.
>>
>> Ah you are right, I got confused. But it is also a bit bad, and I mean
>> not just the array sizing dilema from lower in the email. But since the
>> cam_index comes from the hardware and then below we blindly do:
>>
>> 	if (dma_fence_add_callback(fence, &adev-
>> gmc.retry_cb[cam_index].cb,
>> amdgpu_gmc_retry_fault_handled))
>>
>> Should hardware manage to send two faults with the same cam_index when
>> the previous one hasn't been handled
> 
> The retry CAM exists to filter page fault interrupts and prevent sending
> multiple interrupts for the same fault. It won't send and interrupt with the
> same cam_index until we ACK the previous one.

Okay, but at least kernel needs to be defensive and check to avoid a crash.

>> that is the very same callback is
>> already installed and unsignaled (expect the unexpected), we have just
>> upgraded the hardware bug to a kernel crash.
>>
>> If I now understand it right, you want to "remember" the cam_index
>> received so callback knows what to handle. Hmm.. Allocating memory does
>> seem allowed if I follow correctly that amdgpu_vm_handle_fault() is
>> calling dma_resv_reserve_fences(). So unless I am missing something
>> perhaps kmalloc of struct amdgpu_fence_cb would be fine after all?
> 
> It may be fine, but I'd very much prefer to avoid it if possible.

One option is to not free the callback struct upon handling it, but 
stash it somewhere so the following interrupt can simply take it. You 
can coordinate using cmpxchg for example.

So on the interrupt arriving the flow would be:

if "grab previously stashed unused callback via cmpxchg"
else
	"allocate a new one"

On signalling:

cmpxchg to store the executed callback into the slot and free what was 
in the slot, if anything.

Slot possibly goes into struct gmc.

If you want to optimise for multiple parallel cam indices you would need 
multiple slots. Maybe hash the index read from hardware to limit the 
number of slots placeholds to less than 1024 that you mentioned. Depends 
how many parallel interrupts you want to handle on the fast path (no 
allocations).

And free the used slot(s) on driver exit of course.

Regards,

Tvrtko

>> And
>> if so you should also probably rename it to a less generic name along
>> the lines of amgpud_retry_fault_cb or so. Workable?
> 
> I'm OK to rename it for sure.
> 
> Timur
> 
>>
>>>>> +}
>>>>> +
>>>>>
>>>>>     int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
>>>>>     
>>>>>     				  struct amdgpu_iv_entry *entry,
>>>>>     				  u64 addr,
>>>>>
>>>>> @@ -552,6 +562,7 @@ int amdgpu_gmc_handle_retry_fault(struct
>>>>> amdgpu_device
>>>>> *adev,>
>>>>>
>>>>>     				  u32 node_id,
>>>>>     				  bool write_fault)
>>>>>     
>>>>>     {
>>>>>
>>>>> +	struct dma_fence *fence = NULL;
>>>>>
>>>>>     	int ret;
>>>>>     	
>>>>>     	if (adev->irq.retry_cam_enabled) {
>>>>>
>>>>> @@ -564,8 +575,21 @@ int amdgpu_gmc_handle_retry_fault(struct
>>>>> amdgpu_device *adev,>
>>>>>
>>>>>     		}
>>>>>     		
>>>>>     		ret = amdgpu_vm_handle_fault(adev, entry->pasid,
>>>
>>> entry->vmid, node_id,
>>>
>>>>> -					     addr, entry-
>>>>
>>>> timestamp, write_fault, NULL);
>>>>
>>>>> -		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
>>>>> +					     addr, entry-
>>>>
>>>> timestamp, write_fault, &fence);
>>>>
>>>>> +
>>>>> +		/* If the update is already done, ACK now, otherwise
>>>
>>> when it's done. */
>>>
>>>>> +		if (fence) {
>>>>> +			adev->gmc.retry_cb[cam_index].adev = adev;
>>>>
>>>> Why is 16 retry_cb elements enough? I see in the code cam_index extraced
>>>> from the IV entry with a mask such as 0x3ff.
>>>
>>> I think this came up in a conversation after I had already submitted the
>>> patch. The maximum amount of CAM entries are specified by the
>>> IH_RETRY_INT_CAM_CNTL.CAM_SIZE field.  The content of the field will need
>>> to be interpreted as something like this:
>>> ((CAM_SIZE + 1) * 64) = (15 + 1) * 64 = 1024
>>>
>>> It is a good question whether we actually want to statically allocate that
>>> many items. We should very much avoid doing dynamic allocation in the page
>>> fault handler. I'm open to suggestions on how to move forward with this.
>>>
>>>>> +
>>>>> +			if (dma_fence_add_callback(fence, &adev-
>>>>
>>>> gmc.retry_cb[cam_index].cb,
>>>>
>>>>> +
>>>
>>> amdgpu_gmc_retry_fault_handled))
>>>
>>>>> +				adev->irq.ih_funcs-
>>>>
>>>> retry_cam_ack(adev, cam_index);
>>>>
>>>>> +
>>>>> +			dma_fence_put(fence);
>>>>> +		} else {
>>>>> +			adev->irq.ih_funcs->retry_cam_ack(adev,
>>>
>>> cam_index);
>>>
>>>>> +		}
>>>>> +
>>>>>
>>>>>     		if (ret)
>>>>>     		
>>>>>     			return 1;
>>>>>     	
>>>>>     	} else {
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h index
>>>>> 77eb153802845..3bfb06e011a86 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> @@ -27,6 +27,7 @@
>>>>>
>>>>>     #define __AMDGPU_GMC_H__
>>>>>     
>>>>>     #include <linux/types.h>
>>>>>
>>>>> +#include <linux/dma-fence.h>
>>>>>
>>>>>     #include "amdgpu_irq.h"
>>>>>     #include "amdgpu_xgmi.h"
>>>>>
>>>>> @@ -214,6 +215,11 @@ struct amdgpu_gmc_memrange {
>>>>>
>>>>>     	int nid_mask;
>>>>>     
>>>>>     };
>>>>>
>>>>> +struct amdgpu_fence_cb {
>>>>> +	struct amdgpu_device *adev;
>>>>> +	struct dma_fence_cb cb;
>>>>> +};
>>>>> +
>>>>>
>>>>>     enum amdgpu_gart_placement {
>>>>>     
>>>>>     	AMDGPU_GART_PLACEMENT_BEST_FIT = 0,
>>>>>     	AMDGPU_GART_PLACEMENT_HIGH,
>>>>>
>>>>> @@ -305,6 +311,8 @@ struct amdgpu_gmc {
>>>>>
>>>>>     	} fault_hash[AMDGPU_GMC_FAULT_HASH_SIZE];
>>>>>     	uint64_t		last_fault:AMDGPU_GMC_FAULT_RING_ORDER;
>>>>>
>>>>> +	struct amdgpu_fence_cb retry_cb[16];
>>>>> +
>>>>>
>>>>>     	bool tmz_enabled;
>>>>>     	bool is_app_apu;
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index
>>>>> 8c3ba7213eb22..f5e9b97e92a8c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -3035,7 +3035,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
>>>>> *adev, u32 pasid,>
>>>>>
>>>>>     	r = amdgpu_vm_update_pdes(adev, vm, true);
>>>>>
>>>>> -	*fence = vm->last_update;
>>>>> +	*fence = dma_fence_get(vm->last_update);
>>>>
>>>> Ah! But passing over since you said you are dropping that patch anyway.
>>>
>>> That line should have gone to the previous patch and was added to this one
>>> by mistake.
>>>
>>>>>     error_unlock:
>>>>>     	amdgpu_bo_unreserve(root);
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c index
>>>>> 2eb64df6daa94..6e28f0e435bf5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>>>> @@ -132,7 +132,7 @@ static int amdgpu_vm_sdma_commit(struct
>>>>> amdgpu_vm_update_params *p,>
>>>>>
>>>>>     				   DMA_RESV_USAGE_BOOKKEEP);
>>>>>     	
>>>>>     	}
>>>>>
>>>>> -	if (fence && !p->immediate) {
>>>>> +	if (fence) {
>>>>
>>>> Is this deliberate and if so what it is about? Commit message should
>>>> explain it as well.
>>>
>>> The reason it is changed is because previously it wouldn't return a fence
>>> in immediate mode. This line also should have gone to the previous patch
>>> and was added to this one by mistake.
>>>
>>> Thanks & best regards,
>>> Timur
> 
> 
> 
> 

