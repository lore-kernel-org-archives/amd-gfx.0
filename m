Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FC4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7227560F48
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7227560F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9AC6EDEE;
	Fri, 24 Sep 2021 06:37:31 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA536EDEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 06:37:29 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id w17so23967530wrv.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=lpW/P5edHM3N8nIRcWIR9tX1q1peneiUW2W1g9+fsng=;
 b=C1SQc0iukqhwKAyFcZI96AFqTG7jNZLkmJoiVxuRPzT+7mFJKWI+/FvoK3dX4+LFCQ
 BkClOCUqtWJW2JPpljpHTmGTeoq0csEhHsLARsuveGGH0LmdnMXtSDXBcu1eOt5ueuWz
 HG0sQs+ykch8QlOHbsTqXoHQKLQiGoN8f+8avZw9LJW5WxlY9ZU3L5PBINVjCPSaryI2
 bbVwL9dTLkHcQBKnG8iOe+3db0rjkOygYsyx7WdOVPdo6m073kn5TJWcMqE8jJkvUw9g
 3g0TUxVCmFN2pJXBGeT6UNuJIJ+O/tZsIIF7cIl/gO4SXl+4p+1sD8JpY744qqxZCgTA
 HMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lpW/P5edHM3N8nIRcWIR9tX1q1peneiUW2W1g9+fsng=;
 b=X6DStXtYBFIVn4RfZCxw5eHjEZMZ5RNHJt4EgunH8WnvkgyS4pltXdtg7f0K+XsHRd
 76Jvp6EIYEo8zdMF2I0NHcBgFmStThRDh2fPk17oWKFnxCQyTakwVezvGrub8sFvwWdj
 V8c0bg+0Ll1bLbgT/L5WoTDHxsGF7uytpcjGqHXd+YejQU7xxETolUUO4gCzBh6k82tS
 9uquDTbBT64xSufVHnohg9yOKaekhu0ZSFjf8cxYae49qdvwYUdYtOBI6eKnCrKmQ8Fq
 6/L8o3WMJU42lzXUh96L+tifCrt0jqHot2N1r/6YegZbXuZ5f4HtBkiMFxoxtQaZQy/o
 EVTg==
X-Gm-Message-State: AOAM531DvTchNdkPDpmyR9grXCjvrW2zuT+s3CISjKqwSxg3sb3R+SNy
 8lmLw3eKB3h2OP1XnkEC2rDjcs439z0=
X-Google-Smtp-Source: ABdhPJzVswThZs/i3O4GrsQM1n1CvfiNVaDorPGxdOzcnGyLtkHumjPSLWe7EyeBMPAMFa8tUsRxFQ==
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr9395794wrw.219.1632465447641; 
 Thu, 23 Sep 2021 23:37:27 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:5264:89d9:5fe9:27b8?
 ([2a02:908:1252:fb60:5264:89d9:5fe9:27b8])
 by smtp.gmail.com with ESMTPSA id v20sm7387453wra.73.2021.09.23.23.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Sep 2021 23:37:27 -0700 (PDT)
Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
To: "Yu, Lang" <Lang.Yu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <dc3b075f-70f9-6724-9b00-3e00afa922fa@amd.com>
 <DM6PR12MB42507FAA5B24CB49218517ECFBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <066e138e-3eab-8c4c-04b9-6c7b5d6a4acc@amd.com>
 <DM6PR12MB425014A356EE6C8D865D5AC3FBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <6d9ae09f-4347-8a58-0cd4-1efb0955fe0f@amd.com>
 <DM6PR12MB4250C7EC2039EC6405C5EDAAFBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <1ae03ed5-95ee-7e8a-b850-d0958aa974e6@amd.com>
 <DM6PR12MB4250D2851824AA4F27BE7FDBFBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fc860cdc-e17a-ac94-b863-df8c21d4bacf@gmail.com>
Date: Fri, 24 Sep 2021 08:37:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB4250D2851824AA4F27BE7FDBFBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

Am 24.09.21 um 08:34 schrieb Yu, Lang:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, September 24, 2021 1:54 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
>>
>>
>> Am 24.09.21 um 07:50 schrieb Yu, Lang:
>>> [AMD Official Use Only]
>>>> [SNIP]
>>>>>>> Hi Christian,
>>>>>>>
>>>>>>> Thanks for your explanation and advice. I got your point.
>>>>>>> Actually, these BOs are allocated and pinned during a kfd process lifecycle.
>>>>>>> I will try to add a flag into struct kgd_mem to indicate which BO
>>>>>>> is pined and should be unpinned. Which will make
>>>>>>> amdgpu_bo_pin/amdgpu_bo_unpin calls balanced. Thanks!
>>>>>> That isn't to much better. The real solution would be to unpin them
>>>>>> when the kfd process is destroyed.
>>>>> Yes, will unpin them when the kfd process is destroyed.
>>>>> But we should indicate which BO is pinned and should be unpinned. Right?
>>>> Well not with a flag or something like that.
>>>>
>>>> The knowledge which BO is pinned and needs to be unpinned should come
>>>> from the control logic and not be papered over by some general handling.
>>>> That's the background why we have removed the general handling for
>>>> this from TTM in the first place.
>>>>
>>>> In other words when you need to pin a BO because it is kmapped it
>>>> should be unpinned when it is kunmapped and if you don't kunmap at
>>>> all then there is something wrong with the code structure from a higher level
>> point of view.
>>> Yes, this function "amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel" did a
>>> kmap, but without a kunmap when the kfd process is destroyed. The flag
>> actually indicates kmap/kunmap.
>>
>> Well that's the wrong approach then. I mean you need to have the BO reference
>> and the mapped pointer somewhere, don't you?
>>
>> How do you clean those up?
> They are respectively cleaned by " kfd_process_device_free_bos " and " kfd_process_destroy_pdds".
> Let me put the code here. Thanks!
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index ec028cf963f5..d65b3bf13fd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -81,6 +81,7 @@ struct kgd_mem {
>
>          bool aql_queue;
>          bool is_imported;
> +       bool is_mapped_to_kernel;

Yeah, that is exactly what you absolutely should NOT do.

>   };
>
>   /* KFD Memory Eviction */
> @@ -278,6 +279,8 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>                  struct kgd_dev *kgd, struct kgd_mem *mem, bool intr);
>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
>                  struct kgd_mem *mem, void **kptr, uint64_t *size);

The real question is who is calling this function here?

> +void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_dev *kgd,
> +               struct kgd_mem *mem);
>   int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>                                              struct dma_fence **ef);
>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2d6b2d77b738..45ccbe9f63ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1857,6 +1857,8 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
>
>          amdgpu_bo_unreserve(bo);
>
> +       mem->is_mapped_to_kernel = true;
> +
>          mutex_unlock(&mem->process_info->lock);
>          return 0;
>
> @@ -1870,6 +1872,20 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
>          return ret;
>   }
>
> +void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_dev *kgd, struct kgd_mem *mem)
> +{
> +       struct amdgpu_bo *bo = mem->bo;
> +
> +       if (!mem->is_mapped_to_kernel)
> +               return;
> +
> +       amdgpu_bo_reserve(bo, true);
> +       amdgpu_bo_kunmap(bo);
> +       amdgpu_bo_unpin(bo);
> +       amdgpu_bo_unreserve(bo);
> +       mem->is_mapped_to_kernel = false;
> +}
> +
>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
>                                                struct kfd_vm_fault_info *mem)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 21ec8a18cad2..f5506b153aed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -941,6 +941,8 @@ static void kfd_process_device_free_bos(struct kfd_process_device *pdd)
>                                  peer_pdd->dev->kgd, mem, peer_pdd->drm_priv);
>                  }
>
> +               amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(pdd->dev->kgd, mem);
> +

That's a general cleanup function for user space allocations and should 
not be abused for stuff like that.

Regards,
Christian.

>                  amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->kgd, mem,
>                                                         pdd->drm_priv, NULL);
>                  kfd_process_device_remove_obj_handle(pdd, id);
>
> Regards,
> Lang
>
>> Regards,
>> Christian.

