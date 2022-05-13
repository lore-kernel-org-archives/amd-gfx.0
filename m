Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29363C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 10:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BFE10FBA0;
	Fri, 13 May 2022 10:25:23 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1582810FBA0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 10:25:22 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id ks9so15377899ejb.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 03:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=CETqr8ydFms8MWZxco2i4EEBTir6wgF6kgBI2CtxzJQ=;
 b=clCZnv5tcABq6BT3BKjpg594x8BZL0hORB+giCFMiMHQdqmQubaWcAoABXHgY+U8yf
 DzizCCVimvxL4qRh9+lg1RNrxzeZ7orVvjHWOWT/rW9U6i3yPsR8S+c6W3BkBf4t13Hk
 VsGbZDDmrfT64fLakmPE3Alzl5A2bxAm4o0S3lASdE/EZt+H1Lm7rdlSKcHZXvqZBYeT
 fC2ObN+AHpYQQACaAGuyQpSvvw7PpbuTLRsolNe1bfVC70m3sjPuKklcm7ad3LBTUp6q
 NLOIiUoGT7Qvo2z3wLLRhbk1fUpKrdADEOMoieuLP3KIkGL1OnYpAOdNYKm2mE9s2Yee
 7N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=CETqr8ydFms8MWZxco2i4EEBTir6wgF6kgBI2CtxzJQ=;
 b=IwGwOXJl2/frMdgQRM3qE07ogERm03DJv+tweqvkB0Dx7s39oPRMcelN5rxtDT7yE3
 Qay4CXJcD+vZAx9C9550bmbNvP4LRzYU8IjLKTIsol8aj7wWOEBdh9i6Y4l/BR5Zz8kZ
 sU+SSBIMeRoHDYhzMl41jBAQ6y77JQsXEMvj6BR0c+8BY68h/RnWZ+woCCjn8IchkGN5
 djb6S7VljtrMviaQvN1H0xDVudF3AFX4AcoaFTlusGFWjil+s+M1xOgZGOA1Pxa6yuKK
 pGTNOTqYsK8VLh5YQxmT+gkmFTPPeTSzuZJa/SMz0qSEsoqtVIaVRFNP7Zblr9MIUw6I
 oS3Q==
X-Gm-Message-State: AOAM533t81XK2XSjRPQbbjokr0Nd2yhaiYMIAAmQj8ZP+tsrBF4zvpiN
 pwOoo4RlkOwDo2/rorgz7Pw=
X-Google-Smtp-Source: ABdhPJx6y+yWV3UfRCyxleG4/SmEMLfbNyhwXDedaZx4qVkxj1i5GXLSGyIabFbEl0xilCj+qvr6vg==
X-Received: by 2002:a17:907:6284:b0:6e0:f895:15a with SMTP id
 nd4-20020a170907628400b006e0f895015amr3609360ejc.713.1652437520474; 
 Fri, 13 May 2022 03:25:20 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:4107:8049:874f:2444?
 ([2a02:908:1256:79a0:4107:8049:874f:2444])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a056402171500b0042617ba639esm770803edu.40.2022.05.13.03.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 May 2022 03:25:19 -0700 (PDT)
Message-ID: <51fac87f-d2c0-c64b-6440-3225d98d89c6@gmail.com>
Date: Fri, 13 May 2022 12:25:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Convert to common fdinfo format v3
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220511120250.3066-1-christian.koenig@amd.com>
 <45400d34-b7c8-851a-bc15-e9b4171c0356@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <45400d34-b7c8-851a-bc15-e9b4171c0356@amd.com>
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
Cc: Alexander.Deucher@amd.com, tvrtko.ursulin@linux.intel.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, daniel@ffwll.ch,
 David M Nieto <David.Nieto@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.05.22 um 10:18 schrieb Sharma, Shashank:
> Hey Christian,
>
> On 5/11/2022 2:02 PM, Christian König wrote:
>> [SNIP]
>> @@ -162,17 +162,49 @@ static unsigned int 
>> amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>>       return hw_prio;
>>   }
>>   +/* Calculate the time spend on the hw */
>> +static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
>> +{
>> +    struct drm_sched_fence *s_fence;
>> +
>> +    if (!fence)
>> +        return ns_to_ktime(0);
>> +
>> +    /* When the fence is not even scheduled it can't have spend time */
>> +    s_fence = to_drm_sched_fence(fence);
>> +    if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, 
>> &s_fence->scheduled.flags))
>> +        return ns_to_ktime(0);
>> +
>> +    if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, 
>> &s_fence->finished.flags))
>> +        return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
> shouldn't this be s_fence->finished.timestamp instead of 
> s_fence->scheduled.timestamp ?

No, the finished fence is not yet signaled. So it's timestamp isn't valid.

>> +
>> +    return ktime_sub(s_fence->finished.timestamp,
>> +             s_fence->scheduled.timestamp);
>> +}
>> +
>> +static ktime_t amdgpu_ctx_entity_time(struct amdgpu_ctx *ctx,
>> +                      struct amdgpu_ctx_entity *centity)
>> +{
>> +    ktime_t res = ns_to_ktime(0);
>> +    uint32_t i;
>> +
>> +    spin_lock(&ctx->ring_lock);
>> +    for (i = 0; i < amdgpu_sched_jobs; i++) {
>> +        res = ktime_add(res, 
>> amdgpu_ctx_fence_time(centity->fences[i]));
>> +    }
>> +    spin_unlock(&ctx->ring_lock);
>> +    return res;
>> +}
>>     static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>                     const u32 ring)
>>   {
>> -    struct amdgpu_device *adev = ctx->adev;
>> -    struct amdgpu_ctx_entity *entity;
>>       struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
>> -    unsigned num_scheds = 0;
>> -    int32_t ctx_prio;
>> -    unsigned int hw_prio;
>> +    struct amdgpu_device *adev = ctx->mgr->adev;
>> +    struct amdgpu_ctx_entity *entity;
>>       enum drm_sched_priority drm_prio;
>> +    unsigned int hw_prio, num_scheds;
>> +    int32_t ctx_prio;
>>       int r;
>>         entity = kzalloc(struct_size(entity, fences, amdgpu_sched_jobs),
>> @@ -182,6 +214,7 @@ static int amdgpu_ctx_init_entity(struct 
>> amdgpu_ctx *ctx, u32 hw_ip,
>>         ctx_prio = (ctx->override_priority == 
>> AMDGPU_CTX_PRIORITY_UNSET) ?
>>               ctx->init_priority : ctx->override_priority;
>> +    entity->hw_ip = hw_ip;
>>       entity->sequence = 1;
>>       hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>>       drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
>> @@ -220,11 +253,29 @@ static int amdgpu_ctx_init_entity(struct 
>> amdgpu_ctx *ctx, u32 hw_ip,
>>       return r;
>>   }
>>   -static int amdgpu_ctx_init(struct amdgpu_device *adev,
>> +static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
>> +{
>> +    ktime_t res = ns_to_ktime(0);
>> +    int i;
>> +
>> +    if (!entity)
>> +        return res;
>> +
>> +    for (i = 0; i < amdgpu_sched_jobs; ++i) {
>> +        res = ktime_add(res, amdgpu_ctx_fence_time(entity->fences[i]));
>> +        dma_fence_put(entity->fences[i]);
> Don't we need a corresponding _get() for this put() ?

The get is in amdgpu_ctx_add_fence().

> I had a quick look at amdgpu_ctx_fence_time() too, and it seems it had 
> its own pair of get/put.

Yeah, which was completely superfluous. The fence is guaranteed to stay 
valid as long as the lock is hold.

> [SNIP]
>>
>> @@ -40,7 +44,7 @@ struct amdgpu_ctx_entity {
>>     struct amdgpu_ctx {
>>       struct kref            refcount;
>> -    struct amdgpu_device        *adev;
>> +    struct amdgpu_ctx_mgr        *mgr;
> A suggestion here, should we split this patch in 2 parts:
> - introduce ctx_mgr and change the respective APIs
> - use ctx_mgr and calculate the time spent per context
>
> It would make it easier to read and review.

Good point.

Thanks,
Christian.

>
> - Shashank
>
>>       unsigned            reset_counter;
>>       unsigned            reset_counter_query;
>>       uint32_t            vram_lost_counter;
>> @@ -61,6 +65,7 @@ struct amdgpu_ctx_mgr {
>>       struct mutex        lock;
>>       /* protected by lock */
>>       struct idr        ctx_handles;
>> +    atomic64_t        time_spend[AMDGPU_HW_IP_NUM];
>>   };
>>     extern const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM];
>> @@ -70,9 +75,10 @@ int amdgpu_ctx_put(struct amdgpu_ctx *ctx);
>>     int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 
>> instance,
>>                 u32 ring, struct drm_sched_entity **entity);
>> -void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>> -              struct drm_sched_entity *entity,
>> -              struct dma_fence *fence, uint64_t *seq);
>> +uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx_mgr *mgr,
>> +                  struct amdgpu_ctx *ctx,
>> +                  struct drm_sched_entity *entity,
>> +                  struct dma_fence *fence);
>>   struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>>                          struct drm_sched_entity *entity,
>>                          uint64_t seq);
>> @@ -85,10 +91,11 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void 
>> *data,
>>   int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
>>                      struct drm_sched_entity *entity);
>>   -void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);
>> +void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>> +             struct amdgpu_device *adev);
>>   void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
>>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long 
>> timeout);
>>   void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
>> -ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, 
>> uint32_t hwip,
>> -        uint32_t idx, uint64_t *elapsed);
>> +ktime_t amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr, uint32_t 
>> hwip);
>> +
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> index 5a6857c44bb6..52c2b90925a0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> @@ -32,6 +32,7 @@
>>     #include <drm/amdgpu_drm.h>
>>   #include <drm/drm_debugfs.h>
>> +#include <drm/drm_drv.h>
>>     #include "amdgpu.h"
>>   #include "amdgpu_vm.h"
>> @@ -55,10 +56,10 @@ static const char 
>> *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
>>   void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>>   {
>>       struct amdgpu_fpriv *fpriv;
>> -    uint32_t bus, dev, fn, i, domain;
>>       uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
>>       struct drm_file *file = f->private_data;
>>       struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
>> +    uint32_t bus, dev, fn, domain, hw_ip;
>>       struct amdgpu_bo *root;
>>       int ret;
>>   @@ -83,29 +84,25 @@ void amdgpu_show_fdinfo(struct seq_file *m, 
>> struct file *f)
>>       amdgpu_bo_unreserve(root);
>>       amdgpu_bo_unref(&root);
>>   -    seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", 
>> domain, bus,
>> -            dev, fn, fpriv->vm.pasid);
>> -    seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
>> -    seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
>> -    seq_printf(m, "cpu mem:\t%llu kB\n", cpu_mem/1024UL);
>> -    for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
>> -        uint32_t count = amdgpu_ctx_num_entities[i];
>> -        int idx = 0;
>> -        uint64_t total = 0, min = 0;
>> -        uint32_t perc, frac;
>> +    /*
>> +     * 
>> ******************************************************************
>> +     * For text output format description please see 
>> drm-usage-stats.rst!
>> +     * 
>> ******************************************************************
>> +     */
>>   -        for (idx = 0; idx < count; idx++) {
>> -            total = amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mgr,
>> -                i, idx, &min);
>> -            if ((total == 0) || (min == 0))
>> -                continue;
>> +    seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
>> +    seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", 
>> domain, bus,
>> +            dev, fn, fpriv->vm.pasid);
>> +    seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
>> +    seq_printf(m, "drm-memory-gtt:\t%llu KiB\n", gtt_mem/1024UL);
>> +    seq_printf(m, "drm-memory-cpu:\t%llu KiB\n", cpu_mem/1024UL);
>> +    for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>> +        ktime_t usage = amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, hw_ip);
>>   -            perc = div64_u64(10000 * total, min);
>> -            frac = perc % 100;
>> +        if (!usage)
>> +            continue;
>>   -            seq_printf(m, "%s%d:\t%d.%d%%\n",
>> -                    amdgpu_ip_name[i],
>> -                    idx, perc/100, frac);
>> -        }
>> +        seq_printf(m, "drm-engine-%s:\t%Ld ns\n",
>> +               amdgpu_ip_name[hw_ip], ktime_to_ns(usage));
>>       }
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 6b626c293e72..0814e6508a00 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1144,7 +1144,7 @@ int amdgpu_driver_open_kms(struct drm_device 
>> *dev, struct drm_file *file_priv)
>>       mutex_init(&fpriv->bo_list_lock);
>>       idr_init(&fpriv->bo_list_handles);
>>   -    amdgpu_ctx_mgr_init(&fpriv->ctx_mgr);
>> +    amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>>         file_priv->driver_priv = fpriv;
>>       goto out_suspend;

