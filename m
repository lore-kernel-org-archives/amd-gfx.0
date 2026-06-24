Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467E0CDE003
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 15:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C982110EF8B;
	Wed, 24 Jun 2026 15:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="JrormuXq";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072E410EF8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 15:15:03 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso11843835e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1782314101; x=1782918901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YtURglbfLV4XbGOwQoKjLfQal1ocgll1cKsA/m9+c4Y=;
 b=JrormuXqO7XiikegK8FWl7veJ3Hioqh7qf/I9lZJpmOpoLLHKADyXrs1s5UsdNsdoj
 cOi2lLqlBOTM/Cw6WaBrg7njg7T99TJgiCkNc3UVNHCqoYBb4h5LdOiH1f/O7wvH4g7J
 yxkSkjiIQtZPB6aUWkquV0/QfBsbYLcR+Q3JuKw2cVy1cW2Z+X3oVYy3wgX/tXKu+lqS
 hb9lRQMMAXZoNy+nDLJArj6BqKDYU8vE0Nx4kNxBDJ5X4A6WgxJDelki8Cf00E+uaSoZ
 MSmXH+cmm3419jkDrHp2gMJXgoAWtJpaFUw3PP0nqnr8Fy5W8zu1WyNUMwK/JuFFvZu0
 NSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782314101; x=1782918901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YtURglbfLV4XbGOwQoKjLfQal1ocgll1cKsA/m9+c4Y=;
 b=Ye4DJWwR8ttnXiEKCDlSv3WCORvcDEDGLc2K47AkU6DK2U0B8gHOKOUcvCMgLRWnH9
 s5BLvyc0QVjtCD47dUn5gPRwjTrQNYVTpnpTYrH7iOPw1oIWs5Oq+MYuYVXfbLgY5jwr
 x3cOn/eWRyYP5XCGAN3uG7iEVjsjQ6RxMnT8euOrCtQjsjkC8QqoK2H63TSQlYgea/mz
 /1lnOeJSHQq0Qh3ELcaxrQrnXHPkuAgrN1ScZhryx/sYKeZo9oMKSXO0jCspKUK0Fwwc
 FBgyRJAqOrOjvOrMOnffIOjHZzqM1wrfKDMh4YQwTtX8WeEjvfDwj4oumuAXg1lxi5vQ
 i3Vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pSQA17lefQfwpwilidtS3Ftq6bC95JRlqbmijyNZ772DjokSR/SZm6o/2tU9DbJU5MC5kUdff@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3OHPsemT4fI/pbXSLUAz6RaZiX1I5Mu+8qN1sTS3WQzwuLwSn
 kdnHamfdeeLxI4z2PkaD0vg/9I4WO1Z1U6AmJTrCO91isUdneiHhLYexX0HxSHgQHpU=
X-Gm-Gg: AfdE7cl35ZaDnIuIpeTX0Eix42VEWOEX2x1Uk/syEVOzKSWQwtDehv6PUY1UcmklUYd
 Kdeb+VhmBSDmztKPrJSEmIAEmsnAkvFZahjtOszFelY49zkVXXvyoknKoyzlNhr8ZW1zAgFSE0e
 IC8AT7Ax6lQM3DcO9FiMR6iELefcbKWZNu2XovBOAhP0+xmr8yTk7FoixeMVfR9saofmOX6EtpL
 VcFa+0SH2DOXspUWi5+TKAU03zNAAF1P0mcbbcRYIJC59s9PG4DpOxpVZEfR1jZ0S2pFWAMqiZ2
 GMZ83ZYXstbyd8xGpb1L2S02ntkal7hdOy0dyOKPzbauHUxN+72FN/1atCuBQS8scfHmWHpZ3EP
 qvgkJBWkUOEEgGdLhPNPK/v+7wH4DYCBbF/4aVDgUF2Sw9KG5leIT5jiSt2yH7pv9zsozb+zwSY
 +OWgEnyDNHp8l1p5f8hvx68ZLBXYVagqRM20XVU8FiCu2s
X-Received: by 2002:a05:600c:350a:b0:490:b473:8f78 with SMTP id
 5b1f17b1804b1-49260873705mr56697925e9.17.1782314101040; 
 Wed, 24 Jun 2026 08:15:01 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926105821esm41168645e9.1.2026.06.24.08.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 08:15:00 -0700 (PDT)
Message-ID: <50b62ba1-c709-4f9e-818d-956bc431c89b@ursulin.net>
Date: Wed, 24 Jun 2026 16:14:59 +0100
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
 <20260529103059.21470-3-timur.kristof@gmail.com>
 <55bb616f-343f-4189-8ef8-e9f20429cdbb@ursulin.net>
 <2746166.fDdHjke4Dd@timur-max>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <2746166.fDdHjke4Dd@timur-max>
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


On 24/06/2026 15:52, Timur Kristóf wrote:
> On 2026. június 24., szerda 16:31:20 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> On 29/05/2026 11:30, Timur Kristóf wrote:
>>> Add a fence callback to the VM update and ACK the retry CAM
>>> after the VM update is finished. Previously, we would ACK it
>>> immediately after calling amdgpu_vm_handle_fault() which
>>> caused a race condition that was likely to trigger the same
>>> interrupt again, causing the same fault to be handled
>>> multiple times.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 28 +++++++++++++++++++--
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  8 ++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  2 +-
>>>    4 files changed, 36 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
>>> 26aea960e2759..21c8d87477448 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -545,6 +545,16 @@ void amdgpu_gmc_filter_faults_remove(struct
>>> amdgpu_device *adev, uint64_t addr,>
>>>    	} while (fault->timestamp < tmp);
>>>    
>>>    }
>>>
>>> +static void amdgpu_gmc_retry_fault_handled(struct dma_fence *fence,
>>> +					   struct dma_fence_cb
> *cb)
>>> +{
>>> +	struct amdgpu_fence_cb *afc = container_of(cb, struct
> amdgpu_fence_cb,
>>> cb); +	struct amdgpu_device *adev = afc->adev;
>>> +
>>> +	/* CAM index is the array index of the current callback struct */
>>> +	adev->irq.ih_funcs->retry_cam_ack(adev, afc - &adev-
>> gmc.retry_cb[0]);
>>
>> Is the "afc - &adev->gmc.retry_cb[0]" part correct? It will be the index
>> of the array element, while ->retry_cam_ack() expects the content of
>> that element, no?
> 
> Like the comment says, the CAM index is the array index.
> We just need the CAM index in order to tell the CAM to ACK the current entry.
> The contents of the array are just there to make dma_fence_add_callback() work
> with this callback function.

Ah you are right, I got confused. But it is also a bit bad, and I mean 
not just the array sizing dilema from lower in the email. But since the 
cam_index comes from the hardware and then below we blindly do:

	if (dma_fence_add_callback(fence, &adev->gmc.retry_cb[cam_index].cb, 
amdgpu_gmc_retry_fault_handled))

Should hardware manage to send two faults with the same cam_index when 
the previous one hasn't been handled, that is the very same callback is 
already installed and unsignaled (expect the unexpected), we have just 
upgraded the hardware bug to a kernel crash.

If I now understand it right, you want to "remember" the cam_index 
received so callback knows what to handle. Hmm.. Allocating memory does 
seem allowed if I follow correctly that amdgpu_vm_handle_fault() is 
calling dma_resv_reserve_fences(). So unless I am missing something 
perhaps kmalloc of struct amdgpu_fence_cb would be fine after all? And 
if so you should also probably rename it to a less generic name along 
the lines of amgpud_retry_fault_cb or so. Workable?

Regards,

Tvrtko

>>
>>> +}
>>> +
>>>
>>>    int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
>>>    
>>>    				  struct amdgpu_iv_entry *entry,
>>>    				  u64 addr,
>>>
>>> @@ -552,6 +562,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device
>>> *adev,>
>>>    				  u32 node_id,
>>>    				  bool write_fault)
>>>    
>>>    {
>>>
>>> +	struct dma_fence *fence = NULL;
>>>
>>>    	int ret;
>>>    	
>>>    	if (adev->irq.retry_cam_enabled) {
>>>
>>> @@ -564,8 +575,21 @@ int amdgpu_gmc_handle_retry_fault(struct
>>> amdgpu_device *adev,>
>>>    		}
>>>    		
>>>    		ret = amdgpu_vm_handle_fault(adev, entry->pasid,
> entry->vmid, node_id,
>>>
>>> -					     addr, entry-
>> timestamp, write_fault, NULL);
>>> -		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
>>> +					     addr, entry-
>> timestamp, write_fault, &fence);
>>> +
>>> +		/* If the update is already done, ACK now, otherwise
> when it's done. */
>>> +		if (fence) {
>>> +			adev->gmc.retry_cb[cam_index].adev = adev;
>>
>> Why is 16 retry_cb elements enough? I see in the code cam_index extraced
>> from the IV entry with a mask such as 0x3ff.
> 
> I think this came up in a conversation after I had already submitted the
> patch. The maximum amount of CAM entries are specified by the
> IH_RETRY_INT_CAM_CNTL.CAM_SIZE field.  The content of the field will need to be
> interpreted as something like this:
> ((CAM_SIZE + 1) * 64) = (15 + 1) * 64 = 1024
> 
> It is a good question whether we actually want to statically allocate that
> many items. We should very much avoid doing dynamic allocation in the page
> fault handler. I'm open to suggestions on how to move forward with this.
> 
>>
>>> +
>>> +			if (dma_fence_add_callback(fence, &adev-
>> gmc.retry_cb[cam_index].cb,
>>> +						
> amdgpu_gmc_retry_fault_handled))
>>> +				adev->irq.ih_funcs-
>> retry_cam_ack(adev, cam_index);
>>> +
>>> +			dma_fence_put(fence);
>>> +		} else {
>>> +			adev->irq.ih_funcs->retry_cam_ack(adev,
> cam_index);
>>> +		}
>>> +
>>>
>>>    		if (ret)
>>>    		
>>>    			return 1;
>>>    	
>>>    	} else {
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h index
>>> 77eb153802845..3bfb06e011a86 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> @@ -27,6 +27,7 @@
>>>
>>>    #define __AMDGPU_GMC_H__
>>>    
>>>    #include <linux/types.h>
>>>
>>> +#include <linux/dma-fence.h>
>>>
>>>    #include "amdgpu_irq.h"
>>>    #include "amdgpu_xgmi.h"
>>>
>>> @@ -214,6 +215,11 @@ struct amdgpu_gmc_memrange {
>>>
>>>    	int nid_mask;
>>>    
>>>    };
>>>
>>> +struct amdgpu_fence_cb {
>>> +	struct amdgpu_device *adev;
>>> +	struct dma_fence_cb cb;
>>> +};
>>> +
>>>
>>>    enum amdgpu_gart_placement {
>>>    
>>>    	AMDGPU_GART_PLACEMENT_BEST_FIT = 0,
>>>    	AMDGPU_GART_PLACEMENT_HIGH,
>>>
>>> @@ -305,6 +311,8 @@ struct amdgpu_gmc {
>>>
>>>    	} fault_hash[AMDGPU_GMC_FAULT_HASH_SIZE];
>>>    	uint64_t		last_fault:AMDGPU_GMC_FAULT_RING_ORDER;
>>>
>>> +	struct amdgpu_fence_cb retry_cb[16];
>>> +
>>>
>>>    	bool tmz_enabled;
>>>    	bool is_app_apu;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index
>>> 8c3ba7213eb22..f5e9b97e92a8c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -3035,7 +3035,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
>>> *adev, u32 pasid,>
>>>    	r = amdgpu_vm_update_pdes(adev, vm, true);
>>>
>>> -	*fence = vm->last_update;
>>> +	*fence = dma_fence_get(vm->last_update);
>>
>> Ah! But passing over since you said you are dropping that patch anyway.
> 
> That line should have gone to the previous patch and was added to this one by
> mistake.
> 
>>
>>>    error_unlock:
>>>    	amdgpu_bo_unreserve(root);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c index
>>> 2eb64df6daa94..6e28f0e435bf5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>> @@ -132,7 +132,7 @@ static int amdgpu_vm_sdma_commit(struct
>>> amdgpu_vm_update_params *p,>
>>>    				   DMA_RESV_USAGE_BOOKKEEP);
>>>    	
>>>    	}
>>>
>>> -	if (fence && !p->immediate) {
>>> +	if (fence) {
>>
>> Is this deliberate and if so what it is about? Commit message should
>> explain it as well.
> 
> The reason it is changed is because previously it wouldn't return a fence in
> immediate mode. This line also should have gone to the previous patch and was
> added to this one by mistake.
> 
> Thanks & best regards,
> Timur
> 
> 
> 

