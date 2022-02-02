Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2291C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 08:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4661210F9CF;
	Wed,  2 Feb 2022 08:36:08 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AAD910F9CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 08:36:06 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id c192so14635640wma.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Feb 2022 00:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=5GhMl4b7O5ZSznx3cfYB4JSYQsIHDM59HHa/xHIR7Ow=;
 b=kvK7UAEUeSsmaZ428z47kGlcoz/8zDsxrhf9CcmCPSnnvRNQ93ytbX3kuGT/H7v8dK
 KVGzoxxgJMSRHSrbcODF4+2Qzha5SPMNt0hajcbwufYAPjkhWNneE+WVXucrW04llfj1
 7b7/RQ/hFd7L1LPC9g0VdQ2NHRZ0+XyHOCjv3BMyWBUXA5f4+9TYbocbV9T9XG7c/cik
 KkWDERAK2pOmHtbjYDXCIQo1CWC/qFzBJfiCl6rnPVzVh6UFf7KDr7PWMBGieJfEv2n7
 jiHjb8qLBSyqiA6Ce871r32RpuuYiq3uUY8kyPP7FJcmfDeBThEJr9kLAIInhlsphfof
 5j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=5GhMl4b7O5ZSznx3cfYB4JSYQsIHDM59HHa/xHIR7Ow=;
 b=ZWkPLW+IwRDP70Cp0ScK2ZcKuscxuPhsEaG5lO/K1BjoUfjUgpCVZrDXv9A76Y63aD
 GXMeShAGOxuM86fvSfVWzC2AXOSK+MFdt6kGlyof+7Jd2yvYG88UzBtzWLZZs9GY9USe
 BY4OAOfbA312a0d9TZ45B5o7WcGKpYuAln+kCQHwhCi6SSeQKGnpLUhgk1O4O92Jjwmn
 SegdFFa1wMHBxWa2w+UcYtv3WMD/qPEa1xvBLP+UnZgza1dmaX/OPTmzwTkKHxJp1+sP
 z7of89Z2RAdDByXFxyEQ2i1xuFAnE5JpGLdlvKpLUQ8oWkNyjaAXdm9mBsb73S8VejKN
 EGDg==
X-Gm-Message-State: AOAM530VASjQbW7FM2rYbmSf9yyz8Urnp6bPEDe8yVJdE3NPBtLu6Yt3
 l2+crwEC3VTgl6JyKSz7W9g=
X-Google-Smtp-Source: ABdhPJzhqsV9R7xmw1SQo/BthrXpF5JLxaBgluzOdOdexKmMRTU+A+2d8XcbbYu94z9AlzEah8lTWQ==
X-Received: by 2002:a7b:cb8c:: with SMTP id m12mr5069296wmi.154.1643790965039; 
 Wed, 02 Feb 2022 00:36:05 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id a9sm4746978wmm.32.2022.02.02.00.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Feb 2022 00:36:04 -0800 (PST)
Message-ID: <95da54e0-7406-ea27-a8f9-d99bebd17624@gmail.com>
Date: Wed, 2 Feb 2022 09:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: rename amdgpu_vm_bo_rmv to _del
Content-Language: en-US
To: Daniel Vetter <daniel@ffwll.ch>
References: <20220201152802.12159-1-christian.koenig@amd.com>
 <20220201152802.12159-2-christian.koenig@amd.com>
 <CAKMK7uEwnC4EzJODd64sXB7ntR3+6jQK+nTHskTWgmv25H=sUA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAKMK7uEwnC4EzJODd64sXB7ntR3+6jQK+nTHskTWgmv25H=sUA@mail.gmail.com>
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.02.22 um 17:27 schrieb Daniel Vetter:
> On Tue, Feb 1, 2022 at 4:28 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Some people complained about the name and this matches much
>> more Linux naming conventions for object functions.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> "some people" sounds mightily ominous :-)

That's intentional, you were not the only one :)

Cheers,
Christian.

>
> On both patches: Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Cheers, Daniel
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c          | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c          | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 2 +-
>>   6 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 5df387c4d7fb..5d00a6878ef2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -778,7 +778,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>>                          continue;
>>                  if (attachment[i]->bo_va) {
>>                          amdgpu_bo_reserve(bo[i], true);
>> -                       amdgpu_vm_bo_rmv(adev, attachment[i]->bo_va);
>> +                       amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
>>                          amdgpu_bo_unreserve(bo[i]);
>>                          list_del(&attachment[i]->list);
>>                  }
>> @@ -795,7 +795,7 @@ static void kfd_mem_detach(struct kfd_mem_attachment *attachment)
>>
>>          pr_debug("\t remove VA 0x%llx in entry %p\n",
>>                          attachment->va, attachment);
>> -       amdgpu_vm_bo_rmv(attachment->adev, attachment->bo_va);
>> +       amdgpu_vm_bo_del(attachment->adev, attachment->bo_va);
>>          drm_gem_object_put(&bo->tbo.base);
>>          list_del(&attachment->list);
>>          kfree(attachment);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>> index da21e60bb827..c6d4d41c4393 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>> @@ -98,7 +98,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>
>>          if (r) {
>>                  DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
>> -               amdgpu_vm_bo_rmv(adev, *bo_va);
>> +               amdgpu_vm_bo_del(adev, *bo_va);
>>                  ttm_eu_backoff_reservation(&ticket, &list);
>>                  return r;
>>          }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 7c1f1b8ca77d..b4c0a4e77525 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -221,7 +221,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>>          if (!bo_va || --bo_va->ref_count)
>>                  goto out_unlock;
>>
>> -       amdgpu_vm_bo_rmv(adev, bo_va);
>> +       amdgpu_vm_bo_del(adev, bo_va);
>>          if (!amdgpu_vm_ready(vm))
>>                  goto out_unlock;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index ee3c17bd02fc..efd13898c83e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1194,12 +1194,12 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>          if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
>>                  amdgpu_vce_free_handles(adev, file_priv);
>>
>> -       amdgpu_vm_bo_rmv(adev, fpriv->prt_va);
>> +       amdgpu_vm_bo_del(adev, fpriv->prt_va);
>>
>>          if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
>>                  /* TODO: how to handle reserve failure */
>>                  BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
>> -               amdgpu_vm_bo_rmv(adev, fpriv->csa_va);
>> +               amdgpu_vm_bo_del(adev, fpriv->csa_va);
>>                  fpriv->csa_va = NULL;
>>                  amdgpu_bo_unreserve(adev->virt.csa_obj);
>>          }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 7910046fe11a..8174d71764d7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2653,7 +2653,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
>>   }
>>
>>   /**
>> - * amdgpu_vm_bo_rmv - remove a bo to a specific vm
>> + * amdgpu_vm_bo_del - remove a bo to a specific vm
>>    *
>>    * @adev: amdgpu_device pointer
>>    * @bo_va: requested bo_va
>> @@ -2662,7 +2662,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
>>    *
>>    * Object have to be reserved!
>>    */
>> -void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
>> +void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>                        struct amdgpu_bo_va *bo_va)
>>   {
>>          struct amdgpu_bo_va_mapping *mapping, *next;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 85fcfb8c5efd..a40a6a993bb0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -435,7 +435,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>>   struct amdgpu_bo_va_mapping *amdgpu_vm_bo_lookup_mapping(struct amdgpu_vm *vm,
>>                                                           uint64_t addr);
>>   void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket);
>> -void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
>> +void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>                        struct amdgpu_bo_va *bo_va);
>>   void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>>                             uint32_t fragment_size_default, unsigned max_level,
>> --
>> 2.25.1
>>
>

