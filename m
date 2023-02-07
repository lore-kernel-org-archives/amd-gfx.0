Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB6DC636D4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 16:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D8E710E570;
	Tue,  7 Feb 2023 16:55:09 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D042310E4D6
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 16:55:06 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1442977d77dso19754211fac.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Feb 2023 08:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RuCPDP+14ZucxSm1gpMbXg2vxhHkUIU/4bfah+gqP3U=;
 b=J/DmA6RN5li23hUfJ0Rc/uXq9cTqqdooaDLOCaJYxFuT6xvWTbO/mwxT7kILVL7MUi
 KdC4ltXvcTiENehyX4RzSVApU7kq1Un18HvwtXQ+wRhsvZ9UoqfraxjDENKHsuSC8i+m
 64EtSRzpUk2YPJ7s7X+B+UyOJR+GjdM8QmHuNI8tKShU3j1Z6ZVzdD8x7T/ivWWZLdJV
 eLX4PV/KHSex9m6CPnYwD6eseuVRtOsU4VzKdI0kpbP7nW/LwEjPWf+Hhw/SVNdllk5V
 46UwRwwLgJl7s7GOdsD+bD4dAk0b/8mz+dWhEybmUtS8ttu2osdnAz0rdeH9G50bKd/Y
 XrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RuCPDP+14ZucxSm1gpMbXg2vxhHkUIU/4bfah+gqP3U=;
 b=qVjfVyp/S+bS3KQjUn4l2//hk9NCiiGU6kL7aEMlUSGRpelkoTKYHBk0tMej9T3e+Z
 Y/fNXeDek4XoRDAXqH5g97/W/5wxxEkWI/dIHnIxMA2u/0fyDAP1rsuUXmQHWW4FUXQr
 AGjc+PUKnaxIvn4U15JYpH+8S4+P88H1Y9/7jMm//QUSlkjSb0AInDqeR33pCbinNPHA
 8ofOrB3ml9YLnqlZ0L8w/gagkm+qkHmiHS6VGX2mPB3M1brk4++vkbnzFiPPOkk0aqHY
 ZAQPwfj3BVN4ZGrY1JvBpzNDNi1Hl9P6ZZRPSFnm4R0D1RfcGAvyehTST3C7JDluQCjP
 9h8g==
X-Gm-Message-State: AO0yUKXaiGmef4fZGmqf9b19HyEwpGjBYj4IFwtjE2a8YK9M5V7386qk
 lfV7P2/jbWp9kMToO60vMAJ0cOsyVxBx5pD9VQ375k1k
X-Google-Smtp-Source: AK7set+VqcjLOnJzyUSRLB54YV99SxJI2S25pMTGTBKAqVNnpst+4EVyxU/6hrHr1d0pkil2Sx+7gaSkld1cwUDkzck=
X-Received: by 2002:a05:6870:ac0d:b0:163:a303:fe2f with SMTP id
 kw13-20020a056870ac0d00b00163a303fe2fmr563187oab.96.1675788905973; Tue, 07
 Feb 2023 08:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-5-shashank.sharma@amd.com>
 <CADnq5_M8wnDZUEvDVA_CdyE0sxgg0FragSbO19LjhRE_XMJ-OA@mail.gmail.com>
 <d6e62077-7c6e-1fb4-8abe-275ccdf72003@amd.com>
 <CADnq5_OGOeFLnJyspTYvoOyKv1E=3Tp6uUweCF_JYFRFftuphw@mail.gmail.com>
 <48c0d13f-7ccc-1f05-2a0a-e20bdb1e1fb5@amd.com>
In-Reply-To: <48c0d13f-7ccc-1f05-2a0a-e20bdb1e1fb5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Feb 2023 11:54:54 -0500
Message-ID: <CADnq5_P2o2r589ojnFa2mtSeviRvN-gZH96gpyn_FavfRsCBGg@mail.gmail.com>
Subject: Re: [PATCH 4/8] drm/amdgpu: Add V11 graphics MQD functions
To: Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: alexander.deucher@amd.com, Arvind Yadav <arvind.yadav@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 7, 2023 at 11:37 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>
>
> On 07/02/2023 17:05, Alex Deucher wrote:
> > On Tue, Feb 7, 2023 at 10:43 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
> >>
> >> On 07/02/2023 16:17, Alex Deucher wrote:
> >>> On Fri, Feb 3, 2023 at 4:55 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
> >>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
> >>>>
> >>>> MQD describes the properies of a user queue to the HW, and allows it to
> >>>> accurately configure the queue while mapping it in GPU HW. This patch
> >>>> adds:
> >>>> - A new header file which contains the userqueue MQD definition for
> >>>>     V11 graphics engine.
> >>>> - A new function which fills it with userqueue data and prepares MQD
> >>>> - A function which sets-up the MQD function ptrs in the generic userqueue
> >>>>     creation code.
> >>>>
> >>>> V1: Addressed review comments from RFC patch series
> >>>>       - Reuse the existing MQD structure instead of creating a new one
> >>>>       - MQD format and creation can be IP specific, keep it like that
> >>>>
> >>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> >>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  28 ++++
> >>>>    .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 132 ++++++++++++++++++
> >>>>    drivers/gpu/drm/amd/include/v11_structs.h     |  16 +--
> >>>>    4 files changed, 169 insertions(+), 8 deletions(-)
> >>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> >>>> index 764801cc8203..6ae9d5792791 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> >>>> @@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
> >>>>
> >>>>    # add usermode queue
> >>>>    amdgpu-y += amdgpu_userqueue.o
> >>>> +amdgpu-y += amdgpu_userqueue_mqd_gfx_v11.o
> >>>>
> >>>>    ifneq ($(CONFIG_HSA_AMD),)
> >>>>    AMDKFD_PATH := ../amdkfd
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>> index 625c2fe1e84a..9f3490a91776 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>> @@ -202,13 +202,41 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> >>>>        return r;
> >>>>    }
> >>>>
> >>>> +extern const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs;
> >>>> +
> >>>> +static int
> >>>> +amdgpu_userqueue_setup_mqd_funcs(struct amdgpu_userq_mgr *uq_mgr)
> >>>> +{
> >>>> +    int maj;
> >>>> +    struct amdgpu_device *adev = uq_mgr->adev;
> >>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
> >>>> +
> >>>> +    maj = IP_VERSION_MAJ(version);
> >>>> +    if (maj == 11) {
> >>>> +        uq_mgr->userq_mqd_funcs = &userq_gfx_v11_mqd_funcs;
> >>>> +    } else {
> >>>> +        DRM_WARN("This IP doesn't support usermode queues\n");
> >>>> +        return -EINVAL;
> >>>> +    }
> >>>> +
> >>> I think it would be cleaner to just store these callbacks in adev.
> >>> Maybe something like adev->user_queue_funcs[AMDGPU_HW_IP_NUM].  Then
> >>> in early_init for each IP, we can register the callbacks.  When the
> >>> user goes to create a new user_queue, we can check check to see if the
> >>> function pointer is NULL or not for the queue type:
> >>>
> >>> if (!adev->user_queue_funcs[ip_type])
> >>>     return -EINVAL
> >>>
> >>> r = adev->user_queue_funcs[ip_type]->create_queue();
> >> Sounds like a good idea, we can do this.
> >>
> >>> Actually, there is already an mqd manager interface (adev->mqds[]).
> >>> Maybe you can leverage that interface.
> >> Yep, I saw that and initially even tried to work on that interface
> >> itself, and then realized that it doesn't allow us to pass some
> >>
> >> additional parameters (like queue->vm, various BOs like proc_ctx_bo,
> >> gang_ctx_bo's and so on). All of these are required in the MQD
> >>
> >> and we will need them to be added into MQD. I even thought of expanding
> >> this structure with additional parameters, but I felt like
> >>
> >> it defeats the purpose of this MQD properties. But if you feel strongly
> >> about that, we can work around it.
> > I think it would be cleaner to just add whatever additional mqd
> > properties you need to amdgpu_mqd_prop, and then you can share
> > gfx_v11_0_gfx_mqd_init() and gfx_v11_0_compute_mqd_init()  for GFX and
> > sdma_v6_0_mqd_init() for SDMA.  That way if we make changes to the MQD
> > configuration, we only have to change one function.
> >
> > Alex
>
> Noted,
>
> We might have to add some additional fptrs for .prepare_map() and
> .prepare_unmap(). in the mqd funcs.
>
> These are the required to prepare data for MES HW queue mapping.

OK.  I think we could start with just using the existing init_mqd
callbacks from your create/destroy queue functions for now.  That
said, do we need the prepare_(un)map callbacks?  I think just
create/destory callbacks should be fine.  In the create callback, we
can init the mqd and map it, then in destroy, we can unmap and free.

Alex


Alex

>
> - Shashank
>
> >
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>>    int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
> >>>>    {
> >>>> +    int r;
> >>>> +
> >>>>        mutex_init(&userq_mgr->userq_mutex);
> >>>>        idr_init_base(&userq_mgr->userq_idr, 1);
> >>>>        INIT_LIST_HEAD(&userq_mgr->userq_list);
> >>>>        userq_mgr->adev = adev;
> >>>>
> >>>> +    r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
> >>>> +    if (r) {
> >>>> +        DRM_ERROR("Failed to setup MQD functions for usermode queue\n");
> >>>> +        return r;
> >>>> +    }
> >>>> +
> >>>>        return 0;
> >>>>    }
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> >>>> new file mode 100644
> >>>> index 000000000000..57889729d635
> >>>> --- /dev/null
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> >>>> @@ -0,0 +1,132 @@
> >>>> +/*
> >>>> + * Copyright 2022 Advanced Micro Devices, Inc.
> >>>> + *
> >>>> + * Permission is hereby granted, free of charge, to any person obtaining a
> >>>> + * copy of this software and associated documentation files (the "Software"),
> >>>> + * to deal in the Software without restriction, including without limitation
> >>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> >>>> + * and/or sell copies of the Software, and to permit persons to whom the
> >>>> + * Software is furnished to do so, subject to the following conditions:
> >>>> + *
> >>>> + * The above copyright notice and this permission notice shall be included in
> >>>> + * all copies or substantial portions of the Software.
> >>>> + *
> >>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> >>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> >>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> >>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> >>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> >>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >>>> + * OTHER DEALINGS IN THE SOFTWARE.
> >>>> + *
> >>>> + */
> >>>> +#include "amdgpu.h"
> >>>> +#include "amdgpu_userqueue.h"
> >>>> +#include "v11_structs.h"
> >>>> +#include "amdgpu_mes.h"
> >>>> +#include "gc/gc_11_0_0_offset.h"
> >>>> +#include "gc/gc_11_0_0_sh_mask.h"
> >>>> +
> >>>> +static int
> >>>> +amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> >>>> +{
> >>>> +    uint32_t tmp, rb_bufsz;
> >>>> +    uint64_t hqd_gpu_addr, wb_gpu_addr;
> >>>> +    struct v11_gfx_mqd *mqd = queue->mqd_cpu_ptr;
> >>>> +    struct amdgpu_device *adev = uq_mgr->adev;
> >>>> +
> >>>> +    /* set up gfx hqd wptr */
> >>>> +    mqd->cp_gfx_hqd_wptr = 0;
> >>>> +    mqd->cp_gfx_hqd_wptr_hi = 0;
> >>>> +
> >>>> +    /* set the pointer to the MQD */
> >>>> +    mqd->cp_mqd_base_addr = queue->mqd_gpu_addr & 0xfffffffc;
> >>>> +    mqd->cp_mqd_base_addr_hi = upper_32_bits(queue->mqd_gpu_addr);
> >>>> +
> >>>> +    /* set up mqd control */
> >>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL);
> >>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
> >>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
> >>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
> >>>> +    mqd->cp_gfx_mqd_control = tmp;
> >>>> +
> >>>> +    /* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
> >>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
> >>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
> >>>> +    mqd->cp_gfx_hqd_vmid = 0;
> >>>> +
> >>>> +    /* set up default queue priority level
> >>>> +    * 0x0 = low priority, 0x1 = high priority */
> >>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
> >>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
> >>>> +    mqd->cp_gfx_hqd_queue_priority = tmp;
> >>>> +
> >>>> +    /* set up time quantum */
> >>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
> >>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
> >>>> +    mqd->cp_gfx_hqd_quantum = tmp;
> >>>> +
> >>>> +    /* set up gfx hqd base. this is similar as CP_RB_BASE */
> >>>> +    hqd_gpu_addr = queue->queue_gpu_addr >> 8;
> >>>> +    mqd->cp_gfx_hqd_base = hqd_gpu_addr;
> >>>> +    mqd->cp_gfx_hqd_base_hi = upper_32_bits(hqd_gpu_addr);
> >>>> +
> >>>> +    /* set up hqd_rptr_addr/_hi, similar as CP_RB_RPTR */
> >>>> +    wb_gpu_addr = queue->rptr_gpu_addr;
> >>>> +    mqd->cp_gfx_hqd_rptr_addr = wb_gpu_addr & 0xfffffffc;
> >>>> +    mqd->cp_gfx_hqd_rptr_addr_hi =
> >>>> +    upper_32_bits(wb_gpu_addr) & 0xffff;
> >>>> +
> >>>> +    /* set up rb_wptr_poll addr */
> >>>> +    wb_gpu_addr = queue->wptr_gpu_addr;
> >>>> +    mqd->cp_rb_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
> >>>> +    mqd->cp_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
> >>>> +
> >>>> +    /* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
> >>>> +    rb_bufsz = order_base_2(queue->queue_size / 4) - 1;
> >>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
> >>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
> >>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
> >>>> +#ifdef __BIG_ENDIAN
> >>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
> >>>> +#endif
> >>>> +    mqd->cp_gfx_hqd_cntl = tmp;
> >>>> +
> >>>> +    /* set up cp_doorbell_control */
> >>>> +    tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
> >>>> +    if (queue->use_doorbell) {
> >>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> >>>> +                    DOORBELL_OFFSET, queue->doorbell_index);
> >>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> >>>> +                    DOORBELL_EN, 1);
> >>>> +    } else {
> >>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> >>>> +                    DOORBELL_EN, 0);
> >>>> +    }
> >>>> +    mqd->cp_rb_doorbell_control = tmp;
> >>>> +
> >>>> +    /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
> >>>> +    mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
> >>>> +
> >>>> +    /* activate the queue */
> >>>> +    mqd->cp_gfx_hqd_active = 1;
> >>>> +
> >>> Can you use gfx_v11_0_gfx_mqd_init() and gfx_v11_0_compute_mqd_init()
> >>> directly or leverage adev->mqds[]?
> >> Let us try this out and come back.
> >>
> >> - Shashank
> >>
> >>
> >>> Alex
> >>>
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +static void
> >>>> +amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> >>>> +{
> >>>> +
> >>>> +}
> >>>> +
> >>>> +static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
> >>>> +{
> >>>> +    return sizeof(struct v11_gfx_mqd);
> >>>> +}
> >>>> +
> >>>> +const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
> >>>> +    .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
> >>>> +    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
> >>>> +    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
> >>>> +};
> >>>> diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
> >>>> index b8ff7456ae0b..f8008270f813 100644
> >>>> --- a/drivers/gpu/drm/amd/include/v11_structs.h
> >>>> +++ b/drivers/gpu/drm/amd/include/v11_structs.h
> >>>> @@ -25,14 +25,14 @@
> >>>>    #define V11_STRUCTS_H_
> >>>>
> >>>>    struct v11_gfx_mqd {
> >>>> -       uint32_t reserved_0; // offset: 0  (0x0)
> >>>> -       uint32_t reserved_1; // offset: 1  (0x1)
> >>>> -       uint32_t reserved_2; // offset: 2  (0x2)
> >>>> -       uint32_t reserved_3; // offset: 3  (0x3)
> >>>> -       uint32_t reserved_4; // offset: 4  (0x4)
> >>>> -       uint32_t reserved_5; // offset: 5  (0x5)
> >>>> -       uint32_t reserved_6; // offset: 6  (0x6)
> >>>> -       uint32_t reserved_7; // offset: 7  (0x7)
> >>>> +       uint32_t shadow_base_lo; // offset: 0  (0x0)
> >>>> +       uint32_t shadow_base_hi; // offset: 1  (0x1)
> >>>> +       uint32_t gds_bkup_base_lo; // offset: 2  (0x2)
> >>>> +       uint32_t gds_bkup_base_hi; // offset: 3  (0x3)
> >>>> +       uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
> >>>> +       uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
> >>>> +       uint32_t shadow_initialized; // offset: 6  (0x6)
> >>>> +       uint32_t ib_vmid; // offset: 7  (0x7)
> >>>>           uint32_t reserved_8; // offset: 8  (0x8)
> >>>>           uint32_t reserved_9; // offset: 9  (0x9)
> >>>>           uint32_t reserved_10; // offset: 10  (0xA)
> >>>> --
> >>>> 2.34.1
> >>>>
