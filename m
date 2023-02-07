Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3609FC636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 18:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9327310E15B;
	Tue,  7 Feb 2023 18:32:27 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595F010E15B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 18:32:25 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id r28so13429925oiw.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Feb 2023 10:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a+QlElM6gcP5DgYFJG5Jb09sb+6oKtc22DmJwu1NWRk=;
 b=TXu5dQqZglBpJZZO1/IWz1jLw2A6SfnbCkrrBGl2N7KkCYpm08LR2p6xl+ZZ/yLKy2
 sX3Nmo3PNBaAaNoMvnNuyJ7vUX/KJLJyTfvpXHIYfmH0VPpCvYIcIyRvdwacGTD860YS
 WyDue9XL1/f2lHNEkZ7a1mFZ7h1TdrrcssqpY4Xyb6tKBDjyqL+gj9uciZOChG+ctCxz
 L29uZHhVvtnM1Q4LhCxxVQvQfm8Aol3igECM4qRS7/I0EM7V6uhHSMTD1X2iPK1akxqe
 knIeM5reo3GHD0HrqlSHcRu5SdDXXlPrOBpEohgedJV2EEhyadPEuoVBfLEGUe1J920m
 nXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a+QlElM6gcP5DgYFJG5Jb09sb+6oKtc22DmJwu1NWRk=;
 b=w7FztNLBfCZq2rFu1CcMK4kUq8yplRmfFm2341jOlBQdf/WDQsxVSp6GSOZczVrOhu
 aaPe4G79Cno5Jmt1M3ZCRDfGGkVfKzKgdKL/lHHRmvPNtyZvR8RIGxuVZeXNmHv4SEdn
 55zzm/Ij3cVSHAhpy2vYrDs8Mh5GUKhcevZqKT84VNOYImIxs1iqBBHLsM4o3VgGL6gR
 N3IgP8xpdTb3NcLaMM/L/whnvhs0O3cI01CB3xVBg3bniwleUsX/ucmY5zXdJQS80f5r
 IYsjxGz1x3r0J4+yLE/vwV9EOqQB1TU99lSw4+U84VlwvQeVOz6ZzLKr9gRt+lJxKp1i
 y0dw==
X-Gm-Message-State: AO0yUKW+pxRxai5mQ4AyOciL1ap8a4ShHa0IEYV1nxUBqT6Dyf9bXzyG
 yOBfPLpF4IlItoorSEKxwpMfr9GHV4lxudruyZg=
X-Google-Smtp-Source: AK7set/RLFHKZjJFUY9HJ8beJYL5UF5gK8XdYu8zvywHqR0RZDXePCvti2eFKtckNggrqZd8Wo4e/PceNe1ZWTHSj/s=
X-Received: by 2002:aca:3dd4:0:b0:378:4edd:a89c with SMTP id
 k203-20020aca3dd4000000b003784edda89cmr594oia.46.1675794744289; Tue, 07 Feb
 2023 10:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-5-shashank.sharma@amd.com>
 <CADnq5_M8wnDZUEvDVA_CdyE0sxgg0FragSbO19LjhRE_XMJ-OA@mail.gmail.com>
 <d6e62077-7c6e-1fb4-8abe-275ccdf72003@amd.com>
 <CADnq5_OGOeFLnJyspTYvoOyKv1E=3Tp6uUweCF_JYFRFftuphw@mail.gmail.com>
 <48c0d13f-7ccc-1f05-2a0a-e20bdb1e1fb5@amd.com>
 <CADnq5_P2o2r589ojnFa2mtSeviRvN-gZH96gpyn_FavfRsCBGg@mail.gmail.com>
 <a2f7bc74-736f-252f-8f9c-328466bf8cb1@amd.com>
 <CADnq5_PhjV8354-yJ5s8ZW2dsTJdZu1oZBBsTibqyq7NF=s2wg@mail.gmail.com>
 <6407bda2-f8f3-7d4b-3339-7b301e9fa0ca@amd.com>
In-Reply-To: <6407bda2-f8f3-7d4b-3339-7b301e9fa0ca@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Feb 2023 13:32:12 -0500
Message-ID: <CADnq5_P9aWaYBJZ7hracL0qp8GUFJyfP1Pkf0FKDyywxpa6jiw@mail.gmail.com>
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

On Tue, Feb 7, 2023 at 1:28 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>
>
> On 07/02/2023 18:57, Alex Deucher wrote:
> > On Tue, Feb 7, 2023 at 12:14 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
> >>
> >> On 07/02/2023 17:54, Alex Deucher wrote:
> >>> On Tue, Feb 7, 2023 at 11:37 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
> >>>> On 07/02/2023 17:05, Alex Deucher wrote:
> >>>>> On Tue, Feb 7, 2023 at 10:43 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
> >>>>>> On 07/02/2023 16:17, Alex Deucher wrote:
> >>>>>>> On Fri, Feb 3, 2023 at 4:55 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
> >>>>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
> >>>>>>>>
> >>>>>>>> MQD describes the properies of a user queue to the HW, and allows it to
> >>>>>>>> accurately configure the queue while mapping it in GPU HW. This patch
> >>>>>>>> adds:
> >>>>>>>> - A new header file which contains the userqueue MQD definition for
> >>>>>>>>       V11 graphics engine.
> >>>>>>>> - A new function which fills it with userqueue data and prepares MQD
> >>>>>>>> - A function which sets-up the MQD function ptrs in the generic userqueue
> >>>>>>>>       creation code.
> >>>>>>>>
> >>>>>>>> V1: Addressed review comments from RFC patch series
> >>>>>>>>         - Reuse the existing MQD structure instead of creating a new one
> >>>>>>>>         - MQD format and creation can be IP specific, keep it like that
> >>>>>>>>
> >>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> >>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>>>>>> ---
> >>>>>>>>      drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
> >>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  28 ++++
> >>>>>>>>      .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 132 ++++++++++++++++++
> >>>>>>>>      drivers/gpu/drm/amd/include/v11_structs.h     |  16 +--
> >>>>>>>>      4 files changed, 169 insertions(+), 8 deletions(-)
> >>>>>>>>      create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> >>>>>>>> index 764801cc8203..6ae9d5792791 100644
> >>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> >>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> >>>>>>>> @@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
> >>>>>>>>
> >>>>>>>>      # add usermode queue
> >>>>>>>>      amdgpu-y += amdgpu_userqueue.o
> >>>>>>>> +amdgpu-y += amdgpu_userqueue_mqd_gfx_v11.o
> >>>>>>>>
> >>>>>>>>      ifneq ($(CONFIG_HSA_AMD),)
> >>>>>>>>      AMDKFD_PATH := ../amdkfd
> >>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>>>>> index 625c2fe1e84a..9f3490a91776 100644
> >>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>>>>> @@ -202,13 +202,41 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> >>>>>>>>          return r;
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> +extern const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs;
> >>>>>>>> +
> >>>>>>>> +static int
> >>>>>>>> +amdgpu_userqueue_setup_mqd_funcs(struct amdgpu_userq_mgr *uq_mgr)
> >>>>>>>> +{
> >>>>>>>> +    int maj;
> >>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
> >>>>>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
> >>>>>>>> +
> >>>>>>>> +    maj = IP_VERSION_MAJ(version);
> >>>>>>>> +    if (maj == 11) {
> >>>>>>>> +        uq_mgr->userq_mqd_funcs = &userq_gfx_v11_mqd_funcs;
> >>>>>>>> +    } else {
> >>>>>>>> +        DRM_WARN("This IP doesn't support usermode queues\n");
> >>>>>>>> +        return -EINVAL;
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>> I think it would be cleaner to just store these callbacks in adev.
> >>>>>>> Maybe something like adev->user_queue_funcs[AMDGPU_HW_IP_NUM].  Then
> >>>>>>> in early_init for each IP, we can register the callbacks.  When the
> >>>>>>> user goes to create a new user_queue, we can check check to see if the
> >>>>>>> function pointer is NULL or not for the queue type:
> >>>>>>>
> >>>>>>> if (!adev->user_queue_funcs[ip_type])
> >>>>>>>       return -EINVAL
> >>>>>>>
> >>>>>>> r = adev->user_queue_funcs[ip_type]->create_queue();
> >>>>>> Sounds like a good idea, we can do this.
> >>>>>>
> >>>>>>> Actually, there is already an mqd manager interface (adev->mqds[]).
> >>>>>>> Maybe you can leverage that interface.
> >>>>>> Yep, I saw that and initially even tried to work on that interface
> >>>>>> itself, and then realized that it doesn't allow us to pass some
> >>>>>>
> >>>>>> additional parameters (like queue->vm, various BOs like proc_ctx_bo,
> >>>>>> gang_ctx_bo's and so on). All of these are required in the MQD
> >>>>>>
> >>>>>> and we will need them to be added into MQD. I even thought of expanding
> >>>>>> this structure with additional parameters, but I felt like
> >>>>>>
> >>>>>> it defeats the purpose of this MQD properties. But if you feel strongly
> >>>>>> about that, we can work around it.
> >>>>> I think it would be cleaner to just add whatever additional mqd
> >>>>> properties you need to amdgpu_mqd_prop, and then you can share
> >>>>> gfx_v11_0_gfx_mqd_init() and gfx_v11_0_compute_mqd_init()  for GFX and
> >>>>> sdma_v6_0_mqd_init() for SDMA.  That way if we make changes to the MQD
> >>>>> configuration, we only have to change one function.
> >>>>>
> >>>>> Alex
> >>>> Noted,
> >>>>
> >>>> We might have to add some additional fptrs for .prepare_map() and
> >>>> .prepare_unmap(). in the mqd funcs.
> >>>>
> >>>> These are the required to prepare data for MES HW queue mapping.
> >>> OK.  I think we could start with just using the existing init_mqd
> >>> callbacks from your create/destroy queue functions for now.
> >> Ok,
> >>> That
> >>> said, do we need the prepare_(un)map callbacks?  I think just
> >>> create/destory callbacks should be fine.  In the create callback, we
> >>> can init the mqd and map it, then in destroy, we can unmap and free.
> >> If you observe the kernel MES framework, it expects the data to be fed
> >> in a particular format, in form of queue_properties, and
> >>
> >> creates the map_queue_packet using those. So we need to re-arrange the
> >> data we have in MQD or drm_mqd_in in format
> >>
> >> of properties, which is being done in prepare_map/unmap. Now, as the MQD
> >> is IP specific, we will need this
> >>
> >> function to be IP specific as well, so I added a new fptr callback.
> >>
> >>
> >> So the idea here is, IP specific stuff like:
> >>
> >> - preparing the MQD
> >>
> >> - preparing the properties for map_queue_packet
> >>
> >> - preparing the context BOs
> >>
> >> is being done in IP specific functions in amdgpu_vxx_userqueue.c
> >>
> >>
> >> and
> >>
> >> - initializing the queue
> >>
> >> - handling the IOCTL
> >>
> >> - adding/mapping the queue to MES
> > This seems weird to me.  Why have this in the asic independent code?
> > I was thinking the IOCTL would mostly just be a wrapper around IP
> > specific callbacks for create and destroy.  The callback would take a
> > generic mqd struct as a parameter, that was basically just a
> > passthrough from the IOCTL mqd struct.
> >
> > struct amdgpu_user_queue_mqd {
> >      u32 flags;
> >      struct amdgpu_bo doorbell_bo;
> >      u32 doorbell_offset;
> >      struct amdgpu_bo queue_bo;
> >      struct amdgpu_bo rptr_bo;
> >      struct amdgpu_bo wptr_bo;
> >      u64 queue_gpu_va;
> >      u64 rptr_gpu_va;
> >      u64 wptr_gpu_va;
> >      int gang;
> >      ...
> > };
> >
> > Then something like:
> >
> > static int gfx_v11_0_create_gfx_user_queue(struct amdgpu_device *adev,
> > struct amdgpu_user_queue_mqd *user_mqd)
> > {
> >      struct gfx_v11_mqd mqd;
> >
> >      mqd = kmalloc(size_of(struct gfx_v11_mqd mqd));
> >      ...
> >      // allocate any meta data, ctx buffers, etc.
> >      mqd->ctx_bo = amdgpu_bo_create();
> >      ...
> >      // populate the IP specific mqd with the generic stuff
> >      mqd->mqd_gpu_addr = user_mqd->queue_gpu_va;
> >      ...
> >      // init mqd
> >      r = adev->mqds[AMDGPU_HW_IP_GFX].init_mqd();
>
> Actually, we are doing the same thing, but instead of doing in one large
> function we are doing in 3 smaller functions,
>
> instead if having one big create_v11_mqd function, we have split its
> functionality into 3 parts:
>
> - create_mqd_v11, create_ctx_mqd_v11, prepare_map_mqd_v11
>
> I thought it would be easier to read, maintain and review modular
> functions for specific part. But probably I can get rid of the fptrs for
> them.
>
> The IP independent functions are mostly passthrough who arrange
> data/handle memory management changes and call these IP functions.
>
> >      // add gang, or increase ref count
> >      r = amdgpu_mes_add_gang();
> >      // map mqd
> >      r = amdgpu_mes_add_ring();
>
> we can't directly use most of these amdgpu_mes_* APIs as they expect
> data to be created and arranged in MES metadata format, which is not
>
> aligned with how we are getting/preparing the data.
>
>
> But I am getting your design points, and based on your inputs, I can try
> to re-arrange the code like this:
>
> - Reuse existing MQD mgr and its fptr (create/destroy mqd) for
> add/destroy queue functionality
>
> - mqd_create() can reuse the existing mqd_init() call and then
> internally call the create_ctx() and prepare_map() functions from the
> same file, we don't need separate fptrs.
>
> - amdhpu_usermode_queue.c file can contain just the following:
>     - init/fini function
>
>     - the IOCTL handler
>
>     - two wrappers, to call IP specific create/destroy functions.
>
> This should take us close to what you are expecting.

Yes, I think we are on the same page.

Thanks,

Alex

>
> - Shashank
>
>
> > }
> > static int gfx_v11_0_destroy_gfx_user_queue(struct amdgpu_device
> > *adev, struct amdgpu_user_queue_mqd *user_mqd)
> > {
> >      // unmap mqd
> >      amdgpu_mes_remove_ring();
> >      // drop reference to the gang
> >      amdgpu_mes_remove_gang();
> >
> >      // free any meta data, ctx buffers, etc.
> >      amdgpu_bo_unref(mqd->ctx_bo);
> >     kfree(mqd);
> > }
> >
> >> - any bookkeeping
> >>
> >> is being done from the IP independent amdgpu_userqueue.c functions.
> >>
> >> - Shashank
> >>> Alex
> >>>
> >>>
> >>> Alex
> >>>
> >>>> - Shashank
> >>>>
> >>>>>>>> +    return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>      int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
> >>>>>>>>      {
> >>>>>>>> +    int r;
> >>>>>>>> +
> >>>>>>>>          mutex_init(&userq_mgr->userq_mutex);
> >>>>>>>>          idr_init_base(&userq_mgr->userq_idr, 1);
> >>>>>>>>          INIT_LIST_HEAD(&userq_mgr->userq_list);
> >>>>>>>>          userq_mgr->adev = adev;
> >>>>>>>>
> >>>>>>>> +    r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
> >>>>>>>> +    if (r) {
> >>>>>>>> +        DRM_ERROR("Failed to setup MQD functions for usermode queue\n");
> >>>>>>>> +        return r;
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>>>          return 0;
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> >>>>>>>> new file mode 100644
> >>>>>>>> index 000000000000..57889729d635
> >>>>>>>> --- /dev/null
> >>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> >>>>>>>> @@ -0,0 +1,132 @@
> >>>>>>>> +/*
> >>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
> >>>>>>>> + *
> >>>>>>>> + * Permission is hereby granted, free of charge, to any person obtaining a
> >>>>>>>> + * copy of this software and associated documentation files (the "Software"),
> >>>>>>>> + * to deal in the Software without restriction, including without limitation
> >>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> >>>>>>>> + * and/or sell copies of the Software, and to permit persons to whom the
> >>>>>>>> + * Software is furnished to do so, subject to the following conditions:
> >>>>>>>> + *
> >>>>>>>> + * The above copyright notice and this permission notice shall be included in
> >>>>>>>> + * all copies or substantial portions of the Software.
> >>>>>>>> + *
> >>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> >>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> >>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> >>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> >>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> >>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
> >>>>>>>> + *
> >>>>>>>> + */
> >>>>>>>> +#include "amdgpu.h"
> >>>>>>>> +#include "amdgpu_userqueue.h"
> >>>>>>>> +#include "v11_structs.h"
> >>>>>>>> +#include "amdgpu_mes.h"
> >>>>>>>> +#include "gc/gc_11_0_0_offset.h"
> >>>>>>>> +#include "gc/gc_11_0_0_sh_mask.h"
> >>>>>>>> +
> >>>>>>>> +static int
> >>>>>>>> +amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> >>>>>>>> +{
> >>>>>>>> +    uint32_t tmp, rb_bufsz;
> >>>>>>>> +    uint64_t hqd_gpu_addr, wb_gpu_addr;
> >>>>>>>> +    struct v11_gfx_mqd *mqd = queue->mqd_cpu_ptr;
> >>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
> >>>>>>>> +
> >>>>>>>> +    /* set up gfx hqd wptr */
> >>>>>>>> +    mqd->cp_gfx_hqd_wptr = 0;
> >>>>>>>> +    mqd->cp_gfx_hqd_wptr_hi = 0;
> >>>>>>>> +
> >>>>>>>> +    /* set the pointer to the MQD */
> >>>>>>>> +    mqd->cp_mqd_base_addr = queue->mqd_gpu_addr & 0xfffffffc;
> >>>>>>>> +    mqd->cp_mqd_base_addr_hi = upper_32_bits(queue->mqd_gpu_addr);
> >>>>>>>> +
> >>>>>>>> +    /* set up mqd control */
> >>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL);
> >>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
> >>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
> >>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
> >>>>>>>> +    mqd->cp_gfx_mqd_control = tmp;
> >>>>>>>> +
> >>>>>>>> +    /* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
> >>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
> >>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
> >>>>>>>> +    mqd->cp_gfx_hqd_vmid = 0;
> >>>>>>>> +
> >>>>>>>> +    /* set up default queue priority level
> >>>>>>>> +    * 0x0 = low priority, 0x1 = high priority */
> >>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
> >>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
> >>>>>>>> +    mqd->cp_gfx_hqd_queue_priority = tmp;
> >>>>>>>> +
> >>>>>>>> +    /* set up time quantum */
> >>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
> >>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
> >>>>>>>> +    mqd->cp_gfx_hqd_quantum = tmp;
> >>>>>>>> +
> >>>>>>>> +    /* set up gfx hqd base. this is similar as CP_RB_BASE */
> >>>>>>>> +    hqd_gpu_addr = queue->queue_gpu_addr >> 8;
> >>>>>>>> +    mqd->cp_gfx_hqd_base = hqd_gpu_addr;
> >>>>>>>> +    mqd->cp_gfx_hqd_base_hi = upper_32_bits(hqd_gpu_addr);
> >>>>>>>> +
> >>>>>>>> +    /* set up hqd_rptr_addr/_hi, similar as CP_RB_RPTR */
> >>>>>>>> +    wb_gpu_addr = queue->rptr_gpu_addr;
> >>>>>>>> +    mqd->cp_gfx_hqd_rptr_addr = wb_gpu_addr & 0xfffffffc;
> >>>>>>>> +    mqd->cp_gfx_hqd_rptr_addr_hi =
> >>>>>>>> +    upper_32_bits(wb_gpu_addr) & 0xffff;
> >>>>>>>> +
> >>>>>>>> +    /* set up rb_wptr_poll addr */
> >>>>>>>> +    wb_gpu_addr = queue->wptr_gpu_addr;
> >>>>>>>> +    mqd->cp_rb_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
> >>>>>>>> +    mqd->cp_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
> >>>>>>>> +
> >>>>>>>> +    /* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
> >>>>>>>> +    rb_bufsz = order_base_2(queue->queue_size / 4) - 1;
> >>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
> >>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
> >>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
> >>>>>>>> +#ifdef __BIG_ENDIAN
> >>>>>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
> >>>>>>>> +#endif
> >>>>>>>> +    mqd->cp_gfx_hqd_cntl = tmp;
> >>>>>>>> +
> >>>>>>>> +    /* set up cp_doorbell_control */
> >>>>>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
> >>>>>>>> +    if (queue->use_doorbell) {
> >>>>>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> >>>>>>>> +                    DOORBELL_OFFSET, queue->doorbell_index);
> >>>>>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> >>>>>>>> +                    DOORBELL_EN, 1);
> >>>>>>>> +    } else {
> >>>>>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> >>>>>>>> +                    DOORBELL_EN, 0);
> >>>>>>>> +    }
> >>>>>>>> +    mqd->cp_rb_doorbell_control = tmp;
> >>>>>>>> +
> >>>>>>>> +    /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
> >>>>>>>> +    mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
> >>>>>>>> +
> >>>>>>>> +    /* activate the queue */
> >>>>>>>> +    mqd->cp_gfx_hqd_active = 1;
> >>>>>>>> +
> >>>>>>> Can you use gfx_v11_0_gfx_mqd_init() and gfx_v11_0_compute_mqd_init()
> >>>>>>> directly or leverage adev->mqds[]?
> >>>>>> Let us try this out and come back.
> >>>>>>
> >>>>>> - Shashank
> >>>>>>
> >>>>>>
> >>>>>>> Alex
> >>>>>>>
> >>>>>>>> +    return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static void
> >>>>>>>> +amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> >>>>>>>> +{
> >>>>>>>> +
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
> >>>>>>>> +{
> >>>>>>>> +    return sizeof(struct v11_gfx_mqd);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
> >>>>>>>> +    .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
> >>>>>>>> +    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
> >>>>>>>> +    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
> >>>>>>>> +};
> >>>>>>>> diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
> >>>>>>>> index b8ff7456ae0b..f8008270f813 100644
> >>>>>>>> --- a/drivers/gpu/drm/amd/include/v11_structs.h
> >>>>>>>> +++ b/drivers/gpu/drm/amd/include/v11_structs.h
> >>>>>>>> @@ -25,14 +25,14 @@
> >>>>>>>>      #define V11_STRUCTS_H_
> >>>>>>>>
> >>>>>>>>      struct v11_gfx_mqd {
> >>>>>>>> -       uint32_t reserved_0; // offset: 0  (0x0)
> >>>>>>>> -       uint32_t reserved_1; // offset: 1  (0x1)
> >>>>>>>> -       uint32_t reserved_2; // offset: 2  (0x2)
> >>>>>>>> -       uint32_t reserved_3; // offset: 3  (0x3)
> >>>>>>>> -       uint32_t reserved_4; // offset: 4  (0x4)
> >>>>>>>> -       uint32_t reserved_5; // offset: 5  (0x5)
> >>>>>>>> -       uint32_t reserved_6; // offset: 6  (0x6)
> >>>>>>>> -       uint32_t reserved_7; // offset: 7  (0x7)
> >>>>>>>> +       uint32_t shadow_base_lo; // offset: 0  (0x0)
> >>>>>>>> +       uint32_t shadow_base_hi; // offset: 1  (0x1)
> >>>>>>>> +       uint32_t gds_bkup_base_lo; // offset: 2  (0x2)
> >>>>>>>> +       uint32_t gds_bkup_base_hi; // offset: 3  (0x3)
> >>>>>>>> +       uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
> >>>>>>>> +       uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
> >>>>>>>> +       uint32_t shadow_initialized; // offset: 6  (0x6)
> >>>>>>>> +       uint32_t ib_vmid; // offset: 7  (0x7)
> >>>>>>>>             uint32_t reserved_8; // offset: 8  (0x8)
> >>>>>>>>             uint32_t reserved_9; // offset: 9  (0x9)
> >>>>>>>>             uint32_t reserved_10; // offset: 10  (0xA)
> >>>>>>>> --
> >>>>>>>> 2.34.1
> >>>>>>>>
