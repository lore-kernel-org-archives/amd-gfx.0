Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B81C46467
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 14:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6236510E1F8;
	Tue,  3 Jan 2023 14:50:38 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0487A10E1F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 14:50:36 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id jo4so74252683ejb.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r8yPHNV1carnuoxmsxwfbnqR1npFTvB+6YP0dpFMiKE=;
 b=efQLpaHKpl3jKEcOdpDVSJQVLqGdei305spTANZ/24DbNkKy6JSsmjf+JutKeygpel
 coY65tJ8E3NCasu4BS0/93E8v079v4oCPOoTIbFSM+wAkuQdxz+s00pvzU586K9lEeIy
 MdNppAyD63RaTf6savsUEhCE+Kf2KagBaPbouFZXIVn4KE2RLsWQ3Eg+Uf/FmTVMR4MI
 iNrN049rzy38c6XYyrFIyZo0Yh0LA60KGcyMNyBffWbJtQ9osBzZhmPo6fF3h4Aa9p1W
 exoOfqKsEDukdETEY2v1rk2P/R0e2ZHw1pEkwYpW235Bp+hciozzG6mYKGVE9qL1PkQ7
 oHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r8yPHNV1carnuoxmsxwfbnqR1npFTvB+6YP0dpFMiKE=;
 b=Qu+f6T2Khk/25db5FhOFgSctPpXcVX3yklpFHp//leUhMJn1cL8UADoDd4tRc8hme1
 AbsDTQaLmdOwAs+nC8+oXzDmECaNnKB2D0T3I3njV1q+x8W+HI3tB3XUltzrTJqmGSBt
 kD8U0DyPI0cvgUhGpuWAov0pG1pU57nYpcjAaXrEvKKkMnxaU+LfyBTlFWZDlYreELJ1
 29PUPorWvfv4sKJN78iOdB2aW+Xq29Le+ao8qBGXDpnuYBeusOOuCvaSXRr3KuNk5o/N
 778MCfVc2xlT6JLjGtRVSWtrVE3+5nbTwrBOUghHkacN1V0Qhdk3X8sx85q9RJUrdLQJ
 q65w==
X-Gm-Message-State: AFqh2kpReaFI8ZtuDQXMeq6ma998TeCDBoiz0biE2Cu6g6heS00UwIkf
 uteKEXbm+4h2udth6juZh4w=
X-Google-Smtp-Source: AMrXdXujQF0KZ3n+1o5APXChlthv2mVr/KT9Jv3NyKqpA5dsxzKiGjeWnERv7zXw6KBJJzoRj71RAQ==
X-Received: by 2002:a17:906:656:b0:7ee:1596:4b6 with SMTP id
 t22-20020a170906065600b007ee159604b6mr37011505ejb.59.1672757434390; 
 Tue, 03 Jan 2023 06:50:34 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:a8ef:785e:5f2d:de51?
 ([2a02:908:1256:79a0:a8ef:785e:5f2d:de51])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a170906071100b0081bfd407ad0sm14081548ejb.135.2023.01.03.06.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jan 2023 06:50:33 -0800 (PST)
Message-ID: <80fbcbeb-a24a-8016-2ad0-4903177bd182@gmail.com>
Date: Tue, 3 Jan 2023 15:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-3-shashank.sharma@amd.com>
 <fedb614a-6fcb-e2ff-0d79-1c15f18b92d1@gmail.com>
 <569ecf0d-59b5-b209-ccf0-2d3f648c9bf3@amd.com>
 <d859657f-05f3-5362-be99-b8b792c969a2@gmail.com>
 <a39eab00-ac3f-a217-6ba7-de31680fc4af@amd.com>
 <857effc7-9a67-02ce-f9e3-ae96053b1100@gmail.com>
 <92805757-f4f2-b7f5-7378-fecd05db6492@amd.com>
 <5f2b4546-f3cc-22f6-5b8d-44071b572378@gmail.com>
 <CADnq5_N89pSB0dBuSG3Z55EG=YRWrFHMDAWc3X35U4Tw+yfF2A@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_N89pSB0dBuSG3Z55EG=YRWrFHMDAWc3X35U4Tw+yfF2A@mail.gmail.com>
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
Cc: arunpravin.paneerselvam@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 arvind.yadav@amd.com, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.01.23 um 15:34 schrieb Alex Deucher:
> On Tue, Jan 3, 2023 at 4:35 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 03.01.23 um 10:22 schrieb Shashank Sharma:
>>> On 03/01/2023 10:15, Christian König wrote:
>>>> Am 03.01.23 um 10:12 schrieb Shashank Sharma:
>>>>> On 02/01/2023 13:39, Christian König wrote:
>>>>>> Hi Shashank,
>>>>>>
>>>>>> Am 26.12.22 um 11:41 schrieb Shashank Sharma:
>>>>>>> [SNIP]
>>>>>>>>>          /* df */
>>>>>>>>>        struct amdgpu_df                df;
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>>>>>>> index 0fa0e56daf67..f7413859b14f 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>>>>>>> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>>>>>>>>>        unsigned long            ras_counter_ce;
>>>>>>>>>        unsigned long            ras_counter_ue;
>>>>>>>>>        uint32_t            stable_pstate;
>>>>>>>>> +    struct amdgpu_usermode_queue    *userq;
>>>>>>>> Why should we have this in the ctx here???
>>>>>>> We are allocating a few things dynamically for the queue, which
>>>>>>> would be valid until we destroy this queue. Also we need to save
>>>>>>> this queue
>>>>>>>
>>>>>>> container at some place for the destroy function,  and I thought
>>>>>>> it would make sense to keep this with the context ptr, as this is
>>>>>>> how we are
>>>>>>>
>>>>>>> identifying the incoming request.
>>>>>> I have absolutely no idea how you end up with that design.
>>>>>>
>>>>>> The ctx object is the CS IOCTL context, that is not even remotely
>>>>>> related to anything the user queues should be doing.
>>>>>>
>>>>>> Please completely drop that relationship and don't use any of the
>>>>>> ctx object stuff in the user queue code.
>>>>>>
>>>>> Historically the workload submission always came with a context (due
>>>>> to CS IOCTL), so we thought it would make sense to still have its
>>>>> relevance in the new workload submission method. Would you prefer
>>>>> this new submission to be independent of AMDGPU context ?
>>>> Well not prefer, the point is that this doesn't make any sense at all.
>>>>
>>>> See the amdgpu_ctx object contains the resulting fence pointers for
>>>> the CS IOCTL as well as information necessary for the CS IOCTL to
>>>> work (e.g. scheduler entities etc...).
>>>>
>>>> I don't see how anything from that stuff would be useful for the MES
>>>> or user queues.
>>>>
>>>> Christian.
>>>
>>> I am getting your point, and it makes sense as well. But in such
>>> scenario, we might have to create something parallel to
>>> AMDGPU_USERQ_CTX which is doing very much the same.
>>>
>>> We can still do it to make a logically separate entity, but any
>>> suggestions on where to keep this udev_ctx ptr (if not in adev, as
>>> well as not ctx) ?
>>
>> Take a look at the amdgpu_ctx_mgr object with the mutex and the idr and
>> how this is embedded into the amdgpu_fpriv object. It should become
>> pretty clear from there on.
>>
>> I don't think we need an userq_ctx or similar, each userq should be an
>> independent object. What we need is an userq_mgr object which holds the
>> collection of all the useq objects the client application has created
>> through it's fpriv connection to the driver.
> Don't we want to associate the queues to a ctx for guilty tracking
> purposes when there is a hang?

Nope, absolutely not.

The hang detection around the context was just another design bug we 
inherited from the windows driver.

What we should do instead is to use the error field in the dma_fence 
object just like every other driver and component does.

Christian.

>
> Alex
>
>> Regards,
>> Christian.
>>
>>> - Shashank
>>>
>>>
>>>>> - Shashank
>>>>>
>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>> - Shashank
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>    };
>>>>>>>>>      struct amdgpu_ctx_mgr {
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..3b6e8f75495c
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>>> @@ -0,0 +1,187 @@
>>>>>>>>> +/*
>>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>>> + *
>>>>>>>>> + * Permission is hereby granted, free of charge, to any person
>>>>>>>>> obtaining a
>>>>>>>>> + * copy of this software and associated documentation files
>>>>>>>>> (the "Software"),
>>>>>>>>> + * to deal in the Software without restriction, including
>>>>>>>>> without limitation
>>>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>>>>>>>> sublicense,
>>>>>>>>> + * and/or sell copies of the Software, and to permit persons to
>>>>>>>>> whom the
>>>>>>>>> + * Software is furnished to do so, subject to the following
>>>>>>>>> conditions:
>>>>>>>>> + *
>>>>>>>>> + * The above copyright notice and this permission notice shall
>>>>>>>>> be included in
>>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>>> + *
>>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>>>>>>>>> KIND, EXPRESS OR
>>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>>>>>>> MERCHANTABILITY,
>>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
>>>>>>>>> EVENT SHALL
>>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
>>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>>>>>>> OTHERWISE,
>>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
>>>>>>>>> THE USE OR
>>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>>> + *
>>>>>>>>> + */
>>>>>>>>> +
>>>>>>>>> +#include "amdgpu.h"
>>>>>>>>> +#include "amdgpu_vm.h"
>>>>>>>>> +#include "amdgpu_mes.h"
>>>>>>>>> +#include "amdgpu_usermode_queue.h"
>>>>>>>>> +#include "soc15_common.h"
>>>>>>>>> +
>>>>>>>>> +#define CHECK_ACCESS(a) (access_ok((const void __user *)a,
>>>>>>>>> sizeof(__u64)))
>>>>>>>>> +
>>>>>>>>> +static int
>>>>>>>>> +amdgpu_userqueue_index(struct amdgpu_device *adev)
>>>>>>>>> +{
>>>>>>>>> +    int index;
>>>>>>>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>>>>>>>> +
>>>>>>>>> +    index = ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ,
>>>>>>>>> GFP_KERNEL);
>>>>>>>>> +    return index;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static void
>>>>>>>>> +amdgpu_userqueue_remove_index(struct amdgpu_device *adev,
>>>>>>>>> struct amdgpu_usermode_queue *queue)
>>>>>>>>> +{
>>>>>>>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>>>>>>>> +
>>>>>>>>> +    ida_simple_remove(&uqg->ida, queue->queue_id);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int
>>>>>>>>> +amdgpu_userqueue_validate_input(struct amdgpu_device *adev,
>>>>>>>>> struct drm_amdgpu_userq_mqd *mqd_in)
>>>>>>>>> +{
>>>>>>>>> +    if (mqd_in->queue_va == 0 || mqd_in->doorbell_handle == 0
>>>>>>>>> || mqd_in->doorbell_offset == 0) {
>>>>>>>>> +        DRM_ERROR("Invalid queue object address\n");
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    if (mqd_in->queue_size == 0 || mqd_in->rptr_va == 0 ||
>>>>>>>>> mqd_in->wptr_va == 0) {
>>>>>>>>> +        DRM_ERROR("Invalid queue object value\n");
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type
>>>>>>>>>> = AMDGPU_HW_IP_NUM) {
>>>>>>>>> +        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    if (!CHECK_ACCESS(mqd_in->queue_va) ||
>>>>>>>>> !CHECK_ACCESS(mqd_in->rptr_va) ||
>>>>>>>>> +        !CHECK_ACCESS(mqd_in->wptr_va)) {
>>>>>>>>> +            DRM_ERROR("Invalid mapping of queue ptrs, access
>>>>>>>>> error\n");
>>>>>>>>> +            return -EINVAL;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    DRM_DEBUG_DRIVER("Input parameters to create queue are
>>>>>>>>> valid\n");
>>>>>>>>> +    return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +int amdgpu_userqueue_create(struct amdgpu_device *adev, struct
>>>>>>>>> drm_file *filp,
>>>>>>>>> +                            union drm_amdgpu_userq *args)
>>>>>>>>> +{
>>>>>>>>> +    int r, pasid;
>>>>>>>>> +    struct amdgpu_usermode_queue *queue;
>>>>>>>>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>>>>>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>>>>>>>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv,
>>>>>>>>> args->in.ctx_id);
>>>>>>>>> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>>>>>>>>> +
>>>>>>>>> +    if (!ctx) {
>>>>>>>>> +        DRM_ERROR("Invalid GPU context\n");
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    if (vm->pasid < 0) {
>>>>>>>>> +        DRM_WARN("No PASID info found\n");
>>>>>>>>> +        pasid = 0;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    mutex_lock(&adev->userq.userq_mutex);
>>>>>>>>> +
>>>>>>>>> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue),
>>>>>>>>> GFP_KERNEL);
>>>>>>>>> +    if (!queue) {
>>>>>>>>> +        DRM_ERROR("Failed to allocate memory for queue\n");
>>>>>>>>> + mutex_unlock(&adev->userq.userq_mutex);
>>>>>>>>> +        return -ENOMEM;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    r = amdgpu_userqueue_validate_input(adev, mqd_in);
>>>>>>>>> +    if (r < 0) {
>>>>>>>>> +        DRM_ERROR("Invalid input to create queue\n");
>>>>>>>>> +        goto free_queue;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    queue->vm = vm;
>>>>>>>>> +    queue->pasid = pasid;
>>>>>>>>> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
>>>>>>>>> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
>>>>>>>>> +    queue->queue_size = mqd_in->queue_size;
>>>>>>>>> +    queue->queue_type = mqd_in->ip_type;
>>>>>>>>> +    queue->paging = false;
>>>>>>>>> +    queue->flags = mqd_in->flags;
>>>>>>>>> +    queue->queue_id = amdgpu_userqueue_index(adev);
>>>>>>>>> +
>>>>>>>>> +    ctx->userq = queue;
>>>>>>>>> +    args->out.q_id = queue->queue_id;
>>>>>>>>> +    args->out.flags = 0;
>>>>>>>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>>>>>>>> +    return 0;
>>>>>>>>> +
>>>>>>>>> +free_queue:
>>>>>>>>> +    amdgpu_userqueue_remove_index(adev, queue);
>>>>>>>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>>>>>>>> +    kfree(queue);
>>>>>>>>> +    return r;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +void amdgpu_userqueue_destroy(struct amdgpu_device *adev,
>>>>>>>>> struct drm_file *filp,
>>>>>>>>> +                              union drm_amdgpu_userq *args)
>>>>>>>>> +{
>>>>>>>>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>>>>>>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv,
>>>>>>>>> args->in.ctx_id);
>>>>>>>>> +    struct amdgpu_usermode_queue *queue = ctx->userq;
>>>>>>>>> +
>>>>>>>>> +    mutex_lock(&adev->userq.userq_mutex);
>>>>>>>>> +    amdgpu_userqueue_remove_index(adev, queue);
>>>>>>>>> +    ctx->userq = NULL;
>>>>>>>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>>>>>>>> +    kfree(queue);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>>>>>>> +               struct drm_file *filp)
>>>>>>>>> +{
>>>>>>>>> +    union drm_amdgpu_userq *args = data;
>>>>>>>>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>>>>>>>>> +    int r = 0;
>>>>>>>>> +
>>>>>>>>> +    switch (args->in.op) {
>>>>>>>>> +    case AMDGPU_USERQ_OP_CREATE:
>>>>>>>>> +        r = amdgpu_userqueue_create(adev, filp, args);
>>>>>>>>> +        if (r)
>>>>>>>>> +            DRM_ERROR("Failed to create usermode queue\n");
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    case AMDGPU_USERQ_OP_FREE:
>>>>>>>>> +        amdgpu_userqueue_destroy(adev, filp, args);
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    default:
>>>>>>>>> +        DRM_ERROR("Invalid user queue op specified: %d\n",
>>>>>>>>> args->in.op);
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    return r;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +int amdgpu_userqueue_init(struct amdgpu_device *adev)
>>>>>>>>> +{
>>>>>>>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>>>>>>>> +
>>>>>>>>> +    mutex_init(&uqg->userq_mutex);
>>>>>>>>> +    return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +void amdgpu_userqueue_fini(struct amdgpu_device *adev)
>>>>>>>>> +{
>>>>>>>>> +
>>>>>>>>> +}
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>>>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..c1fe39ffaf72
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>>>>>>>> @@ -0,0 +1,50 @@
>>>>>>>>> +/*
>>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>>> + *
>>>>>>>>> + * Permission is hereby granted, free of charge, to any person
>>>>>>>>> obtaining a
>>>>>>>>> + * copy of this software and associated documentation files
>>>>>>>>> (the "Software"),
>>>>>>>>> + * to deal in the Software without restriction, including
>>>>>>>>> without limitation
>>>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>>>>>>>> sublicense,
>>>>>>>>> + * and/or sell copies of the Software, and to permit persons to
>>>>>>>>> whom the
>>>>>>>>> + * Software is furnished to do so, subject to the following
>>>>>>>>> conditions:
>>>>>>>>> + *
>>>>>>>>> + * The above copyright notice and this permission notice shall
>>>>>>>>> be included in
>>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>>> + *
>>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>>>>>>>>> KIND, EXPRESS OR
>>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>>>>>>> MERCHANTABILITY,
>>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
>>>>>>>>> EVENT SHALL
>>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
>>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>>>>>>> OTHERWISE,
>>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
>>>>>>>>> THE USE OR
>>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>>> + *
>>>>>>>>> + */
>>>>>>>>> +
>>>>>>>>> +#ifndef AMDGPU_USERMODE_QUEUE_H_
>>>>>>>>> +#define AMDGPU_USERMODE_QUEUE_H_
>>>>>>>>> +
>>>>>>>>> +#define AMDGPU_MAX_USERQ 512
>>>>>>>>> +
>>>>>>>>> +struct amdgpu_usermode_queue {
>>>>>>>>> +    int        queue_id;
>>>>>>>>> +    int        queue_type;
>>>>>>>>> +    int        queue_size;
>>>>>>>>> +    int        paging;
>>>>>>>>> +    int        pasid;
>>>>>>>>> +    int        use_doorbell;
>>>>>>>>> +    int        doorbell_index;
>>>>>>>>> +
>>>>>>>>> +    uint64_t    mqd_gpu_addr;
>>>>>>>>> +    uint64_t    wptr_gpu_addr;
>>>>>>>>> +    uint64_t    rptr_gpu_addr;
>>>>>>>>> +    uint64_t    queue_gpu_addr;
>>>>>>>>> +    uint64_t    flags;
>>>>>>>>> +    void         *mqd_cpu_ptr;
>>>>>>>>> +
>>>>>>>>> +    struct amdgpu_bo    *mqd_obj;
>>>>>>>>> +    struct amdgpu_vm        *vm;
>>>>>>>>> +    struct list_head     list;
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +#endif

