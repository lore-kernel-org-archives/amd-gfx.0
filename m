Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C13CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 15:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E22F10E9D4;
	Thu, 30 Oct 2025 15:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZzR782wj";
	dkim-atps=neutral
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD83D10E9DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 15:07:33 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4eba5b415b8so6179941cf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761836853; x=1762441653; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5QZZ/6aoXrLBd/ulc4Zp91QA5+vF4Og0eYtDF5VEO3M=;
 b=ZzR782wjXGcE2AddMC/OgRCCRHDHczKLT0DhAnHYtGnpEroFN8qsFOUlLKnuMGwVdG
 +eCEuq0CE80X9mm+Z/HSDCqpTg/byumhfhQbAhIT+QF72hEBpbj9qWxHSX+K2flxwLkW
 HSWsHcWvX1d6AS+pKKjJUpC0nwEyRI6qO5cJGOHmjlh0G323nMuwcGBYWYZWob1nAwBK
 DXsF1XHJQ2bFzuHhgD8IxfZFokc1/mxoXv3ThB/1+LMgdJR6C8Q22coHpRJ/cJMhsKEH
 OgYCS4FMec+T7vaaJ9xSp/kqsx3QBcE823b/NG+NbKr7UtSTkGkm1HXVYTWYuL8nwwwq
 BtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761836853; x=1762441653;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5QZZ/6aoXrLBd/ulc4Zp91QA5+vF4Og0eYtDF5VEO3M=;
 b=eXoYREetjiQt8c8VuGaaWonY+tZP3a6hu05aEVlRXILZOLQpIS5iDPr7htQCO9sW/L
 9mGYABi/t2sCPbWLyuoF3A1zb+CR7LZSI/y4K0rDMPp3kzL1qENVRGWTD9dvb8YaRfL0
 ZCuDBdqLzKLYYgiXPGAR02gDNHD9WdShkeys6RAPX2TZCVFKjRf/2UK6oBkqyevKmOkh
 HQ5W9beriy76sK5jZEmpdJ9R9fIKG3VP0nWt2kSxjl2NfQCLCfHFvrTLa8M4XQB3FJN9
 GVUq0PQicyJZb3rQDEBy8vpQvQsVNyjw+c8sSAoIh+bHEGYKpYE0kmAoQ63a1bPtTAGE
 gBHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpkirZkfDZI0b0EEfXlUxwhhmZH3ZUrSY5igYdz8O9yeuM2S7qKN9ZPknNqIqCVKAaG9qlUUKO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxA0WH5XAhM+4D958ki8LXd0SgX7wZbDoIMjA0N+a5x3t7qn3Or
 3ZmhpPbbyh32lQ1jAhUr4SL8pXF2hLigAEl1OQ4mYKlk3bkm65Mg/nwm
X-Gm-Gg: ASbGncsVnVBiPzrSFsXnz9vuwRmopsX8SFSQBUi/dhUsWYgGks9zUbQMMdKtqlwDABt
 MntEgnHNY0Elj4wVvC8P15I9etjSoXTah1eZWYlxb0SBbGyAgoBzNFRA6ZeUktLWEgRl2HeC8YC
 /V6o5O3HRbc3xWwLomxqACRkhEySe1rGUl00mxIWuyjiGEKOotdbG+AooBIw9EzwlZ1cd3MFHmT
 PyXm7ekY/HC901emrF1wIniqOGeEzi5chIWdDG+N2afmnygqFk1tMTOE2VvfrciKef6lzdmnHzZ
 l5IX1Qoie+kgMFpAadWtVH6UCtANHlqKSaN0Cx0fcKBnAB0greBI179ebldkGi2gyf6KGvwMDc9
 CgRhVXyxvk2m4+BO6YYjQJY3WQD/t3EPS5+FmYRDElIpeH7ZorjTBrVzXuMB6qaHGjGxQcS7ZKp
 bq4s51NCMFRikEkVWv5PAhZxgA5h/vBDs=
X-Google-Smtp-Source: AGHT+IF8YqUiJV52w0PV8TjHUs6EsHEEeB6CvNzmqLSJpNxCjPFxpVpHvXFj2ep+5YexxejFzrZPLg==
X-Received: by 2002:a05:620a:31a5:b0:88e:293a:1c16 with SMTP id
 af79cd13be357-8aa2ca34be5mr417589785a.35.1761836852438; 
 Thu, 30 Oct 2025 08:07:32 -0700 (PDT)
Received: from [10.254.120.28] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ed308cf3easm170981cf.16.2025.10.30.08.07.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Oct 2025 08:07:32 -0700 (PDT)
Message-ID: <741496aa-2154-4939-9d3a-27ea6eff2fea@gmail.com>
Date: Thu, 30 Oct 2025 16:07:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] drm/amdgpu: independence for the amdkfd_fence!
To: Felix Kuehling <felix.kuehling@amd.com>, phasta@mailbox.org,
 alexdeucher@gmail.com, simona.vetter@ffwll.ch, tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251013143502.1655-1-christian.koenig@amd.com>
 <20251013143502.1655-15-christian.koenig@amd.com>
 <13862fb3-548c-44c1-9744-6b74dcff6ccd@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <13862fb3-548c-44c1-9744-6b74dcff6ccd@amd.com>
Content-Type: text/plain; charset=UTF-8
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



On 10/18/25 00:22, Felix Kuehling wrote:
> 
> On 2025-10-13 09:48, Christian König wrote:
>> This should allow amdkfd_fences to outlive the amdgpu module.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 ++++
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  | 36 +++++++------------
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  7 ++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +--
>>   4 files changed, 24 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 9e120c934cc1..35c59c784b7b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -196,6 +196,7 @@ int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
>>   #endif
>>   #if IS_ENABLED(CONFIG_HSA_AMD)
>>   bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
>> +void amdkfd_fence_signal(struct dma_fence *f);
>>   struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
>>   void amdgpu_amdkfd_remove_all_eviction_fences(struct amdgpu_bo *bo);
>>   int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>> @@ -210,6 +211,11 @@ bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
>>       return false;
>>   }
>>   +static inline
>> +void amdkfd_fence_signal(struct dma_fence *f)
>> +{
>> +}
>> +
>>   static inline
>>   struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> index 09c919f72b6c..69bca4536326 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> @@ -127,29 +127,9 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
>>           if (!svm_range_schedule_evict_svm_bo(fence))
>>               return true;
>>       }
>> -    return false;
>> -}
>> -
>> -/**
>> - * amdkfd_fence_release - callback that fence can be freed
>> - *
>> - * @f: dma_fence
>> - *
>> - * This function is called when the reference count becomes zero.
>> - * Drops the mm_struct reference and RCU schedules freeing up the fence.
>> - */
>> -static void amdkfd_fence_release(struct dma_fence *f)
>> -{
>> -    struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
>> -
>> -    /* Unconditionally signal the fence. The process is getting
>> -     * terminated.
>> -     */
>> -    if (WARN_ON(!fence))
>> -        return; /* Not an amdgpu_amdkfd_fence */
>> -
>>       mmdrop(fence->mm);
>> -    kfree_rcu(f, rcu);
>> +    fence->mm = NULL;
>> +    return false;
>>   }
>>     /**
>> @@ -174,9 +154,19 @@ bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
>>       return false;
>>   }
>>   +void amdkfd_fence_signal(struct dma_fence *f)
>> +{
>> +    struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
>> +
>> +    if (fence) {
>> +        mmdrop(fence->mm);
>> +        fence->mm = NULL;
> 
> Isn't fence->mm already NULL here if it was dropped in amdkfd_fence_enable_signaling?

It looked like ther're some use cases which signals the fence without going through amdkfd_fence_enable_signaling.

E.g. kfd_process_wq_release which is most likely used on process tear down.

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>> +    }
>> +    dma_fence_signal(f);
>> +}
>> +
>>   static const struct dma_fence_ops amdkfd_fence_ops = {
>>       .get_driver_name = amdkfd_fence_get_driver_name,
>>       .get_timeline_name = amdkfd_fence_get_timeline_name,
>>       .enable_signaling = amdkfd_fence_enable_signaling,
>> -    .release = amdkfd_fence_release,
>>   };
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index ddfe30c13e9d..779d7701bac9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1177,7 +1177,7 @@ static void kfd_process_wq_release(struct work_struct *work)
>>       synchronize_rcu();
>>       ef = rcu_access_pointer(p->ef);
>>       if (ef)
>> -        dma_fence_signal(ef);
>> +        amdkfd_fence_signal(ef);
>>         kfd_process_remove_sysfs(p);
>>       kfd_debugfs_remove_process(p);
>> @@ -1986,7 +1986,6 @@ kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
>>   static int signal_eviction_fence(struct kfd_process *p)
>>   {
>>       struct dma_fence *ef;
>> -    int ret;
>>         rcu_read_lock();
>>       ef = dma_fence_get_rcu_safe(&p->ef);
>> @@ -1994,10 +1993,10 @@ static int signal_eviction_fence(struct kfd_process *p)
>>       if (!ef)
>>           return -EINVAL;
>>   -    ret = dma_fence_signal(ef);
>> +    amdkfd_fence_signal(ef);
>>       dma_fence_put(ef);
>>   -    return ret;
>> +    return 0;
>>   }
>>     static void evict_process_worker(struct work_struct *work)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 91609dd5730f..01ce2d853602 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -428,7 +428,7 @@ static void svm_range_bo_release(struct kref *kref)
>>         if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
>>           /* We're not in the eviction worker. Signal the fence. */
>> -        dma_fence_signal(&svm_bo->eviction_fence->base);
>> +        amdkfd_fence_signal(&svm_bo->eviction_fence->base);
>>       dma_fence_put(&svm_bo->eviction_fence->base);
>>       amdgpu_bo_unref(&svm_bo->bo);
>>       kfree(svm_bo);
>> @@ -3628,7 +3628,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>>       mmap_read_unlock(mm);
>>       mmput(mm);
>>   -    dma_fence_signal(&svm_bo->eviction_fence->base);
>> +    amdkfd_fence_signal(&svm_bo->eviction_fence->base);
>>         /* This is the last reference to svm_bo, after svm_range_vram_node_free
>>        * has been called in svm_migrate_vram_to_ram

