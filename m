Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C45C53210
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 14:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E95BA10E49A;
	Tue,  3 Jan 2023 14:34:36 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C98910E3EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 14:34:35 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-15085b8a2f7so12137982fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 06:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yYzVWKFt6MS3YIBz3Cn0mbc4xvPmDqjQomPv8df+wk=;
 b=prRztmPlZvd/CuW9gkl6U3Cwo3IKXe9zgwj6HQVOukfOOScdRl4/xb08fsYkJVyJsm
 LKGi3pZOwydW8PplivIJ/Zf813CiTiJBvtHuwU3bu24kHL8LTt+bC/i8vvKQrjfv5AYm
 +OtpKCVT0K5QLH15b5bFVbmx+PZuWMrqpczIsfG2oT8gonw4mn21HkT3s2lEoAZqWAWn
 D9w/UE/sY2rUXHgfL1Xz2B60z854RhqVkKKH3+VNO3NGBhMNPOWXPwgvpY6wygALjIc2
 2pKQjpJksEWOTZu5wTZc+wF7OxMOdA+LqoT4XWdavl6k+xJXBxaJvuaXVMJ1mL9GR3ms
 mJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yYzVWKFt6MS3YIBz3Cn0mbc4xvPmDqjQomPv8df+wk=;
 b=T/zLgID3KDex/XNPtxRU9A0fPTJ1DD7OMHkvFSAV+A51xClBhrPiZeaXVVgl2iF5ox
 Mzjl8ryd3taxkvT2zFCJNMDx3mWNhhH9JWBdiq9aJ4/6mhGm8+gdXSgxIHZVBF27EEgj
 EpQbeGfs1YISEbAUgHIc1kegxbcEpjct329YwQKVABr+gboJLQCJ3BxOfeXuU1Wdtk4q
 eJgKr8RLwTRHwRdrViECo8mFXlMT1EY7l24Zr2xb+WnxDbOEvTxyQ8fC69zFpFxq04vL
 Pg3aSuSMztvhiN6o5qYZURJgjtUH1l8sGpW19fkiRo+E9R7HVbwnwq+NWV3j+zvBo76D
 vWow==
X-Gm-Message-State: AFqh2kqQWxEOvDvHEGuAkZo/nGBA0hAM+zNv+dqET3H0vXysA7Cf6Ze6
 EXfGyK9kpRWBR2IrAkJKJIn/z8O+MuaSPW6JJqY+9Zyl
X-Google-Smtp-Source: AMrXdXuOiiqlw+w72AXacCeUVy1O+BZToNd595QG75xARFuGm41AfEKfnSA5/qR3fM/L5C+6lBFuCebJLjB4drPRkCI=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr3617698oaq.46.1672756474383; Tue, 03
 Jan 2023 06:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-3-shashank.sharma@amd.com>
 <fedb614a-6fcb-e2ff-0d79-1c15f18b92d1@gmail.com>
 <569ecf0d-59b5-b209-ccf0-2d3f648c9bf3@amd.com>
 <d859657f-05f3-5362-be99-b8b792c969a2@gmail.com>
 <a39eab00-ac3f-a217-6ba7-de31680fc4af@amd.com>
 <857effc7-9a67-02ce-f9e3-ae96053b1100@gmail.com>
 <92805757-f4f2-b7f5-7378-fecd05db6492@amd.com>
 <5f2b4546-f3cc-22f6-5b8d-44071b572378@gmail.com>
In-Reply-To: <5f2b4546-f3cc-22f6-5b8d-44071b572378@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Jan 2023 09:34:23 -0500
Message-ID: <CADnq5_N89pSB0dBuSG3Z55EG=YRWrFHMDAWc3X35U4Tw+yfF2A@mail.gmail.com>
Subject: Re: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jan 3, 2023 at 4:35 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 03.01.23 um 10:22 schrieb Shashank Sharma:
> >
> > On 03/01/2023 10:15, Christian K=C3=B6nig wrote:
> >> Am 03.01.23 um 10:12 schrieb Shashank Sharma:
> >>>
> >>> On 02/01/2023 13:39, Christian K=C3=B6nig wrote:
> >>>> Hi Shashank,
> >>>>
> >>>> Am 26.12.22 um 11:41 schrieb Shashank Sharma:
> >>>>> [SNIP]
> >>>>>>>         /* df */
> >>>>>>>       struct amdgpu_df                df;
> >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> >>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> >>>>>>> index 0fa0e56daf67..f7413859b14f 100644
> >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> >>>>>>> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
> >>>>>>>       unsigned long            ras_counter_ce;
> >>>>>>>       unsigned long            ras_counter_ue;
> >>>>>>>       uint32_t            stable_pstate;
> >>>>>>> +    struct amdgpu_usermode_queue    *userq;
> >>>>>>
> >>>>>> Why should we have this in the ctx here???
> >>>>>
> >>>>> We are allocating a few things dynamically for the queue, which
> >>>>> would be valid until we destroy this queue. Also we need to save
> >>>>> this queue
> >>>>>
> >>>>> container at some place for the destroy function,  and I thought
> >>>>> it would make sense to keep this with the context ptr, as this is
> >>>>> how we are
> >>>>>
> >>>>> identifying the incoming request.
> >>>>
> >>>> I have absolutely no idea how you end up with that design.
> >>>>
> >>>> The ctx object is the CS IOCTL context, that is not even remotely
> >>>> related to anything the user queues should be doing.
> >>>>
> >>>> Please completely drop that relationship and don't use any of the
> >>>> ctx object stuff in the user queue code.
> >>>>
> >>> Historically the workload submission always came with a context (due
> >>> to CS IOCTL), so we thought it would make sense to still have its
> >>> relevance in the new workload submission method. Would you prefer
> >>> this new submission to be independent of AMDGPU context ?
> >>
> >> Well not prefer, the point is that this doesn't make any sense at all.
> >>
> >> See the amdgpu_ctx object contains the resulting fence pointers for
> >> the CS IOCTL as well as information necessary for the CS IOCTL to
> >> work (e.g. scheduler entities etc...).
> >>
> >> I don't see how anything from that stuff would be useful for the MES
> >> or user queues.
> >>
> >> Christian.
> >
> >
> > I am getting your point, and it makes sense as well. But in such
> > scenario, we might have to create something parallel to
> > AMDGPU_USERQ_CTX which is doing very much the same.
> >
> > We can still do it to make a logically separate entity, but any
> > suggestions on where to keep this udev_ctx ptr (if not in adev, as
> > well as not ctx) ?
>
>
> Take a look at the amdgpu_ctx_mgr object with the mutex and the idr and
> how this is embedded into the amdgpu_fpriv object. It should become
> pretty clear from there on.
>
> I don't think we need an userq_ctx or similar, each userq should be an
> independent object. What we need is an userq_mgr object which holds the
> collection of all the useq objects the client application has created
> through it's fpriv connection to the driver.

Don't we want to associate the queues to a ctx for guilty tracking
purposes when there is a hang?

Alex

>
> Regards,
> Christian.
>
> >
> > - Shashank
> >
> >
> >>
> >>>
> >>> - Shashank
> >>>
> >>>
> >>>> Christian.
> >>>>
> >>>>>
> >>>>> - Shashank
> >>>>>
> >>>>>>
> >>>>>> Regards,
> >>>>>> Christian.
> >>>>>>
> >>>>>>>   };
> >>>>>>>     struct amdgpu_ctx_mgr {
> >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>>>> new file mode 100644
> >>>>>>> index 000000000000..3b6e8f75495c
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>>>> @@ -0,0 +1,187 @@
> >>>>>>> +/*
> >>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
> >>>>>>> + *
> >>>>>>> + * Permission is hereby granted, free of charge, to any person
> >>>>>>> obtaining a
> >>>>>>> + * copy of this software and associated documentation files
> >>>>>>> (the "Software"),
> >>>>>>> + * to deal in the Software without restriction, including
> >>>>>>> without limitation
> >>>>>>> + * the rights to use, copy, modify, merge, publish, distribute,
> >>>>>>> sublicense,
> >>>>>>> + * and/or sell copies of the Software, and to permit persons to
> >>>>>>> whom the
> >>>>>>> + * Software is furnished to do so, subject to the following
> >>>>>>> conditions:
> >>>>>>> + *
> >>>>>>> + * The above copyright notice and this permission notice shall
> >>>>>>> be included in
> >>>>>>> + * all copies or substantial portions of the Software.
> >>>>>>> + *
> >>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> >>>>>>> KIND, EXPRESS OR
> >>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> >>>>>>> MERCHANTABILITY,
> >>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
> >>>>>>> EVENT SHALL
> >>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
> >>>>>>> CLAIM, DAMAGES OR
> >>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> >>>>>>> OTHERWISE,
> >>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> >>>>>>> THE USE OR
> >>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
> >>>>>>> + *
> >>>>>>> + */
> >>>>>>> +
> >>>>>>> +#include "amdgpu.h"
> >>>>>>> +#include "amdgpu_vm.h"
> >>>>>>> +#include "amdgpu_mes.h"
> >>>>>>> +#include "amdgpu_usermode_queue.h"
> >>>>>>> +#include "soc15_common.h"
> >>>>>>> +
> >>>>>>> +#define CHECK_ACCESS(a) (access_ok((const void __user *)a,
> >>>>>>> sizeof(__u64)))
> >>>>>>> +
> >>>>>>> +static int
> >>>>>>> +amdgpu_userqueue_index(struct amdgpu_device *adev)
> >>>>>>> +{
> >>>>>>> +    int index;
> >>>>>>> +    struct amdgpu_userq_globals *uqg =3D &adev->userq;
> >>>>>>> +
> >>>>>>> +    index =3D ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ,
> >>>>>>> GFP_KERNEL);
> >>>>>>> +    return index;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void
> >>>>>>> +amdgpu_userqueue_remove_index(struct amdgpu_device *adev,
> >>>>>>> struct amdgpu_usermode_queue *queue)
> >>>>>>> +{
> >>>>>>> +    struct amdgpu_userq_globals *uqg =3D &adev->userq;
> >>>>>>> +
> >>>>>>> +    ida_simple_remove(&uqg->ida, queue->queue_id);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int
> >>>>>>> +amdgpu_userqueue_validate_input(struct amdgpu_device *adev,
> >>>>>>> struct drm_amdgpu_userq_mqd *mqd_in)
> >>>>>>> +{
> >>>>>>> +    if (mqd_in->queue_va =3D=3D 0 || mqd_in->doorbell_handle =3D=
=3D 0
> >>>>>>> || mqd_in->doorbell_offset =3D=3D 0) {
> >>>>>>> +        DRM_ERROR("Invalid queue object address\n");
> >>>>>>> +        return -EINVAL;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>> +    if (mqd_in->queue_size =3D=3D 0 || mqd_in->rptr_va =3D=3D 0 =
||
> >>>>>>> mqd_in->wptr_va =3D=3D 0) {
> >>>>>>> +        DRM_ERROR("Invalid queue object value\n");
> >>>>>>> +        return -EINVAL;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>> +    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type
> >>>>>>> >=3D AMDGPU_HW_IP_NUM) {
> >>>>>>> +        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
> >>>>>>> +        return -EINVAL;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>> +    if (!CHECK_ACCESS(mqd_in->queue_va) ||
> >>>>>>> !CHECK_ACCESS(mqd_in->rptr_va) ||
> >>>>>>> +        !CHECK_ACCESS(mqd_in->wptr_va)) {
> >>>>>>> +            DRM_ERROR("Invalid mapping of queue ptrs, access
> >>>>>>> error\n");
> >>>>>>> +            return -EINVAL;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>> +    DRM_DEBUG_DRIVER("Input parameters to create queue are
> >>>>>>> valid\n");
> >>>>>>> +    return 0;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +int amdgpu_userqueue_create(struct amdgpu_device *adev, struct
> >>>>>>> drm_file *filp,
> >>>>>>> +                            union drm_amdgpu_userq *args)
> >>>>>>> +{
> >>>>>>> +    int r, pasid;
> >>>>>>> +    struct amdgpu_usermode_queue *queue;
> >>>>>>> +    struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> >>>>>>> +    struct amdgpu_vm *vm =3D &fpriv->vm;
> >>>>>>> +    struct amdgpu_ctx *ctx =3D amdgpu_ctx_get(fpriv,
> >>>>>>> args->in.ctx_id);
> >>>>>>> +    struct drm_amdgpu_userq_mqd *mqd_in =3D &args->in.mqd;
> >>>>>>> +
> >>>>>>> +    if (!ctx) {
> >>>>>>> +        DRM_ERROR("Invalid GPU context\n");
> >>>>>>> +        return -EINVAL;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>> +    if (vm->pasid < 0) {
> >>>>>>> +        DRM_WARN("No PASID info found\n");
> >>>>>>> +        pasid =3D 0;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>> +    mutex_lock(&adev->userq.userq_mutex);
> >>>>>>> +
> >>>>>>> +    queue =3D kzalloc(sizeof(struct amdgpu_usermode_queue),
> >>>>>>> GFP_KERNEL);
> >>>>>>> +    if (!queue) {
> >>>>>>> +        DRM_ERROR("Failed to allocate memory for queue\n");
> >>>>>>> + mutex_unlock(&adev->userq.userq_mutex);
> >>>>>>> +        return -ENOMEM;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>> +    r =3D amdgpu_userqueue_validate_input(adev, mqd_in);
> >>>>>>> +    if (r < 0) {
> >>>>>>> +        DRM_ERROR("Invalid input to create queue\n");
> >>>>>>> +        goto free_queue;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>> +    queue->vm =3D vm;
> >>>>>>> +    queue->pasid =3D pasid;
> >>>>>>> +    queue->wptr_gpu_addr =3D mqd_in->wptr_va;
> >>>>>>> +    queue->rptr_gpu_addr =3D mqd_in->rptr_va;
> >>>>>>> +    queue->queue_size =3D mqd_in->queue_size;
> >>>>>>> +    queue->queue_type =3D mqd_in->ip_type;
> >>>>>>> +    queue->paging =3D false;
> >>>>>>> +    queue->flags =3D mqd_in->flags;
> >>>>>>> +    queue->queue_id =3D amdgpu_userqueue_index(adev);
> >>>>>>> +
> >>>>>>> +    ctx->userq =3D queue;
> >>>>>>> +    args->out.q_id =3D queue->queue_id;
> >>>>>>> +    args->out.flags =3D 0;
> >>>>>>> +    mutex_unlock(&adev->userq.userq_mutex);
> >>>>>>> +    return 0;
> >>>>>>> +
> >>>>>>> +free_queue:
> >>>>>>> +    amdgpu_userqueue_remove_index(adev, queue);
> >>>>>>> +    mutex_unlock(&adev->userq.userq_mutex);
> >>>>>>> +    kfree(queue);
> >>>>>>> +    return r;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +void amdgpu_userqueue_destroy(struct amdgpu_device *adev,
> >>>>>>> struct drm_file *filp,
> >>>>>>> +                              union drm_amdgpu_userq *args)
> >>>>>>> +{
> >>>>>>> +    struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> >>>>>>> +    struct amdgpu_ctx *ctx =3D amdgpu_ctx_get(fpriv,
> >>>>>>> args->in.ctx_id);
> >>>>>>> +    struct amdgpu_usermode_queue *queue =3D ctx->userq;
> >>>>>>> +
> >>>>>>> +    mutex_lock(&adev->userq.userq_mutex);
> >>>>>>> +    amdgpu_userqueue_remove_index(adev, queue);
> >>>>>>> +    ctx->userq =3D NULL;
> >>>>>>> +    mutex_unlock(&adev->userq.userq_mutex);
> >>>>>>> +    kfree(queue);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> >>>>>>> +               struct drm_file *filp)
> >>>>>>> +{
> >>>>>>> +    union drm_amdgpu_userq *args =3D data;
> >>>>>>> +    struct amdgpu_device *adev =3D drm_to_adev(dev);
> >>>>>>> +    int r =3D 0;
> >>>>>>> +
> >>>>>>> +    switch (args->in.op) {
> >>>>>>> +    case AMDGPU_USERQ_OP_CREATE:
> >>>>>>> +        r =3D amdgpu_userqueue_create(adev, filp, args);
> >>>>>>> +        if (r)
> >>>>>>> +            DRM_ERROR("Failed to create usermode queue\n");
> >>>>>>> +        break;
> >>>>>>> +
> >>>>>>> +    case AMDGPU_USERQ_OP_FREE:
> >>>>>>> +        amdgpu_userqueue_destroy(adev, filp, args);
> >>>>>>> +        break;
> >>>>>>> +
> >>>>>>> +    default:
> >>>>>>> +        DRM_ERROR("Invalid user queue op specified: %d\n",
> >>>>>>> args->in.op);
> >>>>>>> +        return -EINVAL;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>> +    return r;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +int amdgpu_userqueue_init(struct amdgpu_device *adev)
> >>>>>>> +{
> >>>>>>> +    struct amdgpu_userq_globals *uqg =3D &adev->userq;
> >>>>>>> +
> >>>>>>> +    mutex_init(&uqg->userq_mutex);
> >>>>>>> +    return 0;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +void amdgpu_userqueue_fini(struct amdgpu_device *adev)
> >>>>>>> +{
> >>>>>>> +
> >>>>>>> +}
> >>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> >>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> >>>>>>> new file mode 100644
> >>>>>>> index 000000000000..c1fe39ffaf72
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> >>>>>>> @@ -0,0 +1,50 @@
> >>>>>>> +/*
> >>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
> >>>>>>> + *
> >>>>>>> + * Permission is hereby granted, free of charge, to any person
> >>>>>>> obtaining a
> >>>>>>> + * copy of this software and associated documentation files
> >>>>>>> (the "Software"),
> >>>>>>> + * to deal in the Software without restriction, including
> >>>>>>> without limitation
> >>>>>>> + * the rights to use, copy, modify, merge, publish, distribute,
> >>>>>>> sublicense,
> >>>>>>> + * and/or sell copies of the Software, and to permit persons to
> >>>>>>> whom the
> >>>>>>> + * Software is furnished to do so, subject to the following
> >>>>>>> conditions:
> >>>>>>> + *
> >>>>>>> + * The above copyright notice and this permission notice shall
> >>>>>>> be included in
> >>>>>>> + * all copies or substantial portions of the Software.
> >>>>>>> + *
> >>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> >>>>>>> KIND, EXPRESS OR
> >>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> >>>>>>> MERCHANTABILITY,
> >>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
> >>>>>>> EVENT SHALL
> >>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
> >>>>>>> CLAIM, DAMAGES OR
> >>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> >>>>>>> OTHERWISE,
> >>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> >>>>>>> THE USE OR
> >>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
> >>>>>>> + *
> >>>>>>> + */
> >>>>>>> +
> >>>>>>> +#ifndef AMDGPU_USERMODE_QUEUE_H_
> >>>>>>> +#define AMDGPU_USERMODE_QUEUE_H_
> >>>>>>> +
> >>>>>>> +#define AMDGPU_MAX_USERQ 512
> >>>>>>> +
> >>>>>>> +struct amdgpu_usermode_queue {
> >>>>>>> +    int        queue_id;
> >>>>>>> +    int        queue_type;
> >>>>>>> +    int        queue_size;
> >>>>>>> +    int        paging;
> >>>>>>> +    int        pasid;
> >>>>>>> +    int        use_doorbell;
> >>>>>>> +    int        doorbell_index;
> >>>>>>> +
> >>>>>>> +    uint64_t    mqd_gpu_addr;
> >>>>>>> +    uint64_t    wptr_gpu_addr;
> >>>>>>> +    uint64_t    rptr_gpu_addr;
> >>>>>>> +    uint64_t    queue_gpu_addr;
> >>>>>>> +    uint64_t    flags;
> >>>>>>> +    void         *mqd_cpu_ptr;
> >>>>>>> +
> >>>>>>> +    struct amdgpu_bo    *mqd_obj;
> >>>>>>> +    struct amdgpu_vm        *vm;
> >>>>>>> +    struct list_head     list;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +#endif
> >>>>>>
> >>>>
> >>
>
