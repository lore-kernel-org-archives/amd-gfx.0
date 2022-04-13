Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA3DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 08:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E77C10FC19;
	Wed, 13 Apr 2022 08:34:33 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 927BB10FC19
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 08:34:32 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id t11so2371582eju.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 01:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=PdJdAqHxgf5vZn+OGgAf3kyQvsLTfVAX0wKlNojC+VU=;
 b=kOZIuEXXPHe/X1sv18X6wiVnMcm/il0x1yZBIhvQdRb5gpxMy0QxZB/0dz1H3Cb889
 bhsD4iHfbaYbV7SY6/OedD8ePA8OHRNKVva/JAWnCYs7FfE24ksRjEgF0p58Vp6FB/1J
 z5bhNrsNxSSFn/1IbtYIHWaUC2T09laigAwHX0gDBK4zA+IziKVTrr2f6Jz85lAXheW3
 VYPfOlxx8GBm2sHMNaAdSCo8DjnpW+/WT+M27EZFM9+Ys7b1Icqwd9KzbdSfy+nkLjjG
 z0IahnX9dDbFEXEmG6z4nnWXRwig6W99Pw3bPXWu3GKDA4f0ODnwN1Je5YqmyFHHkXlw
 k4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=PdJdAqHxgf5vZn+OGgAf3kyQvsLTfVAX0wKlNojC+VU=;
 b=gxp+iDTTevMC0BW6W8C5ZI3aX5tRDLfn5+mGdWoa5j4yB0+dM9mckWyBsd+1bxcxZo
 +7+VD6davIxlQtLPqYRbpF7dF3IoTAC/XErreEJXtjvQnJKB8CmimjR5i3nMwzjqLARE
 pwOEufruMgQmteV9rEqMcYp6YSnycErbHLs3YbAbxsbUVXXSgRR8xuKS6u//o+Xr94Kq
 c8zN+e1iMHJokQ8SqvWlFajJcjsWlBGiV8w6Ragr37rYf9wJZlyVmfF2I74tiQi476Jx
 Qa/8m53x1q19TRdiah/7Mwk2dc/JQu/2kzTjM3AuoEEOpevHhXZ0uBJDIZM+wwmCFtFY
 063Q==
X-Gm-Message-State: AOAM531Ta6GTdfwh3d6Hy5byFodGAOLuD2+ZrV4HvEwOiQO0uuaQqEWT
 PpoDvZUtCGoe8nCONx27pwk=
X-Google-Smtp-Source: ABdhPJxXXKVjxbn7ADFzZtQ4JXrv5CBg7Ln96v0JsefkeJUTEIu2WZHChyve2G7dctmidxcIFLsgNg==
X-Received: by 2002:a17:906:a147:b0:6e8:46a4:25a9 with SMTP id
 bu7-20020a170906a14700b006e846a425a9mr22949652ejb.213.1649838870994; 
 Wed, 13 Apr 2022 01:34:30 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b9e1.dip0.t-ipconnect.de.
 [87.176.185.225]) by smtp.gmail.com with ESMTPSA id
 ah13-20020a1709069acd00b006e8a0b3e071sm2471025ejc.110.2022.04.13.01.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Apr 2022 01:34:30 -0700 (PDT)
Message-ID: <d41146ad-ddf1-3860-dff9-bda422469b7c@gmail.com>
Date: Wed, 13 Apr 2022 10:34:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggb25lIHVz?=
 =?UTF-8?Q?e-after-free_of_VM?=
Content-Language: en-US
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20220412120322.28169-1-xinhui.pan@amd.com>
 <299dca93-dc4d-8b1a-6de7-bfab8ebc8c19@amd.com>
 <DM4PR12MB5165048F72922FDF9211ADA087EC9@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM4PR12MB5165048F72922FDF9211ADA087EC9@DM4PR12MB5165.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think for now we should just have a the following code in amdgpu_vm_fini:

dma_fence_wait(vm->last_tlb_flush, false);
/* Make sure that all fence callbacks have completed*/
spinlock(vm->last_tlb_flush->lock);
spinunlock(vm->last_tlb_flush->lock);
dma_fence_put(vm->last_tlb_flush);

Cleaning that up in a larger context can come later on and is probably 
my job as DMA-buf maintainer.

Thanks,
Christian.

Am 13.04.22 um 05:07 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> we make something like dma_fence_release does.
>
> @@ -783,11 +783,15 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
>          unsigned long flags;
>          signed long ret = timeout ? timeout : 1;
>
> -       if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
> +       if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) &&
> +           list_empty(&fence->cb_list))
>                  return ret;
>
>          spin_lock_irqsave(fence->lock, flags);
>
> +       if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
> +               goto out;
> +
>          if (intr && signal_pending(current)) {
>                  ret = -ERESTARTSYS;
>                  goto out;
> ________________________________________
> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
> 发送时间: 2022年4月12日 20:11
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org; Daniel Vetter
> 抄送: Deucher, Alexander
> 主题: Re: [PATCH] drm/amdgpu: Fix one use-after-free of VM
>
> Am 12.04.22 um 14:03 schrieb xinhui pan:
>> VM might already be freed when amdgpu_vm_tlb_seq_cb() is called.
>> We see the calltrace below.
>>
>> Fix it by keeping the last flush fence around and wait for it to signal
>>
>> BUG kmalloc-4k (Not tainted): Poison overwritten
>>
>> 0xffff9c88630414e8-0xffff9c88630414e8 @offset=5352. First byte 0x6c
>> instead of 0x6b Allocated in amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
>> age=44 cpu=0 pid=2343
>>    __slab_alloc.isra.0+0x4f/0x90
>>    kmem_cache_alloc_trace+0x6b8/0x7a0
>>    amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
>>    drm_file_alloc+0x222/0x3e0 [drm]
>>    drm_open+0x11d/0x410 [drm]
>>    drm_stub_open+0xdc/0x230 [drm]
>>    chrdev_open+0xa5/0x1e0
>>    do_dentry_open+0x16c/0x3c0
>>    vfs_open+0x2d/0x30
>>    path_openat+0x70a/0xa90
>>    do_filp_open+0xb2/0x120
>>    do_sys_openat2+0x245/0x330
>>    do_sys_open+0x46/0x80
>>    __x64_sys_openat+0x20/0x30
>>    do_syscall_64+0x38/0xc0
>>    entry_SYSCALL_64_after_hwframe+0x44/0xae
>> Freed in amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu] age=22 cpu=1
>> pid=2485
>>    kfree+0x4a2/0x580
>>    amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu]
>>    drm_file_free+0x24e/0x3c0 [drm]
>>    drm_close_helper.isra.0+0x90/0xb0 [drm]
>>    drm_release+0x97/0x1a0 [drm]
>>    __fput+0xb6/0x280
>>    ____fput+0xe/0x10
>>    task_work_run+0x64/0xb0
>>    do_exit+0x406/0xcf0
>>    do_group_exit+0x50/0xc0
>>    __x64_sys_exit_group+0x18/0x20
>>    do_syscall_64+0x38/0xc0
>>    entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 22 +++++++++++++++++++---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
>>    2 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 645ce28277c2..e2486e95ca69 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -932,9 +932,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>
>>        if (flush_tlb || params.table_freed) {
>>                tlb_cb->vm = vm;
>> -             if (!fence || !*fence ||
>> -                 dma_fence_add_callback(*fence, &tlb_cb->cb,
>> -                                        amdgpu_vm_tlb_seq_cb))
>> +             if (fence && *fence &&
>> +                 !dma_fence_add_callback(*fence, &tlb_cb->cb,
>> +                                        amdgpu_vm_tlb_seq_cb)) {
>> +                     dma_fence_put(vm->last_delayed_tlb_flush);
>> +                     vm->last_delayed_tlb_flush = dma_fence_get(*fence);
>> +             } else
>>                        amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>>                tlb_cb = NULL;
>>        }
>> @@ -2258,6 +2261,19 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>        dma_fence_wait(vm->last_unlocked, false);
>>        dma_fence_put(vm->last_unlocked);
>>
>> +     if (vm->last_delayed_tlb_flush) {
> You can initialize last_delayed_tlb_flush() with the dummy fence, see
> how last_unlocked works.
>
>> +             /* Wait until fence is signaled.
>> +              * But must double check to make sure fence cb is called.
>> +              * As dma_fence_default_wait checks DMA_FENCE_FLAG_SIGNALED_BIT without
>> +              * holding fence lock(the first test_bit).
>> +              * So call dma_fence_get_status which will hold the fence lock.
>> +              * Then we can make sure fence cb has been called.
>> +              */
> Uff, that is a really good point and most likely a bug in dma_fence_wait().
>
> I'm pretty sure that a couple of other callers rely on that as well.
>
> Daniel what's you opinion about that?
>
> Thanks,
> Christian.
>
>> +             (void)dma_fence_wait(vm->last_delayed_tlb_flush, false);
>> +             (void)dma_fence_get_status(vm->last_delayed_tlb_flush);
>> +             dma_fence_put(vm->last_delayed_tlb_flush);
>> +     }
>> +
>>        list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>>                if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
>>                        amdgpu_vm_prt_fini(adev, vm);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 1a814fbffff8..c1a48f5c1019 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -286,6 +286,7 @@ struct amdgpu_vm {
>>
>>        /* Last finished delayed update */
>>        atomic64_t              tlb_seq;
>> +     struct dma_fence        *last_delayed_tlb_flush;
>>
>>        /* Last unlocked submission to the scheduler entities */
>>        struct dma_fence        *last_unlocked;

