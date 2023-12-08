Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7205FC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 10:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A2E10EA4B;
	Fri,  8 Dec 2023 10:11:33 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C804910EA4B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 10:11:31 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40b595bf5d2so22275325e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Dec 2023 02:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702030290; x=1702635090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=im9nnALNwN7E//WCxEa1aZN0RojtWf9cHUEF5mzT8cc=;
 b=hKfce6GbcYqan3Ps/OpDEi3ggycIFKkstERMA7Z29/ygTvHEbjAbrGkc18aWZVRbyi
 lN2o/ax5vRvQ4a+OllWP86m/6UcB2qbmLn3EL+P30PhtaO8P200ZLKX4Mh80GiJv+0L/
 Tg4WC1rVfg/+4JpdXrwOBS/34o0lzz/T7TgUUuJSBdqni5AFbooSWT8YHd+4N8r2whCl
 GdP49mXXwcrufsBv67iG6U6LcbRjDa5bvst1G6qUMtQuOlxHKL5NTkU/JI4SgMBc3+nu
 +fATg9y30vMLk9nqOZLDEDkRB+hN3WLSctDxEabObH4Qmufm7i8L/EqIGGWQSc2ptn4w
 j6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702030290; x=1702635090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=im9nnALNwN7E//WCxEa1aZN0RojtWf9cHUEF5mzT8cc=;
 b=sNfH+3IjzDvtzF8MyW6mxuxwCpUK3HjFUoMsoCc1F+7eO/AVKwe4elft+GtDufMpUo
 zrsNUtLxOlw5VIyQBLDd4jCdCdZM9Z1EGHb/BVjGosH8stxBCsRP84pnMBGUdQwHWWjB
 cG7aHgELEE7yujAgs64sLsDv3kXmnE8SqOEkunrQzHqnBNRD18xz5j3EzTa7mJf+Syvz
 bEYnCnpow1jJ6v8PgBPCxdwhS+cMRu5OeMSgGs7QGt8HuVA8+exzBQmtd8jdOMbwey+2
 Iup5NXUcRESiYILsRr69Sm80Kj2Y0X0U9JDARdvupF9NQAnOrmw4L/YjHRR89Y6tXqsv
 NB5A==
X-Gm-Message-State: AOJu0YwE+iwKBYRkyDG2xGxIDw3MccKrhS75ImxmTX+mJmU7Wz/mfTUH
 e9LdgoAn7qkD+awhi31+g8GG1xOFtA0=
X-Google-Smtp-Source: AGHT+IF0r5ma6il8jDSDiDeWMYx0Kx8GaC2ZYvhGNJCfRxCYlNty4j0giO6YcnEU7nbUYZq3uiahww==
X-Received: by 2002:a05:600c:198d:b0:40b:5e1a:db91 with SMTP id
 t13-20020a05600c198d00b0040b5e1adb91mr1670501wmq.50.1702030289956; 
 Fri, 08 Dec 2023 02:11:29 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b0040c31bb66dcsm2200191wmq.20.2023.12.08.02.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 02:11:29 -0800 (PST)
Message-ID: <a6411c81-d0ea-4002-bfc6-a725a83eb9bf@gmail.com>
Date: Fri, 8 Dec 2023 11:11:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix sparse __rcu annotation warnings
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231205222026.2108094-1-Felix.Kuehling@amd.com>
 <e879ea47-4281-4830-a4db-5a144999198a@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <e879ea47-4281-4830-a4db-5a144999198a@amd.com>
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
Cc: linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.12.23 um 20:14 schrieb Felix Kuehling:
>
> On 2023-12-05 17:20, Felix Kuehling wrote:
>> Properly mark kfd_process->ef as __rcu and consistently access it with
>> rcu_dereference_protected.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: 
>> https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> ping.
>
> Christian, would you review this patch, please?

Looks a bit suspicious, especially the rcu_dereference_protected() use.

What is the static checker complaining about in the first place?

Regards,
Christian.

>
> Thanks,
>   Felix
>
>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h            | 2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 6 ++++--
>>   4 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index f2e920734c98..20cb266dcedd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -314,7 +314,7 @@ void 
>> amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>>   int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, 
>> struct amdgpu_bo *bo);
>>     int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>> -                        struct dma_fence **ef);
>> +                        struct dma_fence __rcu **ef);
>>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>>                             struct kfd_vm_fault_info *info);
>>   int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device 
>> *adev, int fd,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 7d91f99acb59..8ba6f6c8363d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2806,7 +2806,7 @@ static void 
>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>       put_task_struct(usertask);
>>   }
>>   -static void replace_eviction_fence(struct dma_fence **ef,
>> +static void replace_eviction_fence(struct dma_fence __rcu **ef,
>>                      struct dma_fence *new_ef)
>>   {
>>       struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
>> @@ -2841,7 +2841,7 @@ static void replace_eviction_fence(struct 
>> dma_fence **ef,
>>    * 7.  Add fence to all PD and PT BOs.
>>    * 8.  Unreserve all BOs
>>    */
>> -int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct 
>> dma_fence **ef)
>> +int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct 
>> dma_fence __rcu **ef)
>>   {
>>       struct amdkfd_process_info *process_info = info;
>>       struct amdgpu_vm *peer_vm;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 45366b4ca976..5a24097a9f28 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -917,7 +917,7 @@ struct kfd_process {
>>        * fence will be triggered during eviction and new one will be 
>> created
>>        * during restore
>>        */
>> -    struct dma_fence *ef;
>> +    struct dma_fence __rcu *ef;
>>         /* Work items for evicting and restoring BOs */
>>       struct delayed_work eviction_work;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 71df51fcc1b0..14b11d61f8dd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1110,6 +1110,8 @@ static void kfd_process_wq_release(struct 
>> work_struct *work)
>>   {
>>       struct kfd_process *p = container_of(work, struct kfd_process,
>>                            release_work);
>> +    struct dma_fence *ef = rcu_dereference_protected(p->ef,
>> +        kref_read(&p->ref) == 0);
>>         kfd_process_dequeue_from_all_devices(p);
>>       pqm_uninit(&p->pqm);
>> @@ -1118,7 +1120,7 @@ static void kfd_process_wq_release(struct 
>> work_struct *work)
>>        * destroyed. This allows any BOs to be freed without
>>        * triggering pointless evictions or waiting for fences.
>>        */
>> -    dma_fence_signal(p->ef);
>> +    dma_fence_signal(ef);
>>         kfd_process_remove_sysfs(p);
>>   @@ -1127,7 +1129,7 @@ static void kfd_process_wq_release(struct 
>> work_struct *work)
>>       svm_range_list_fini(p);
>>         kfd_process_destroy_pdds(p);
>> -    dma_fence_put(p->ef);
>> +    dma_fence_put(ef);
>>         kfd_event_free_process(p);

