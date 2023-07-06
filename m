Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3D9EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 17:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFB110E478;
	Thu,  6 Jul 2023 17:34:38 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6216210E469
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 17:34:36 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1b0748bc78dso1353024fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jul 2023 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688664874; x=1691256874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0aCf2GKvhyCqqRh9M6DyFCkPw9umGTO4c0XbxYbNjC4=;
 b=hoSPnjqDrrDB2wmHvug4nVV8+L5c+jQ0gnxggl6EriYuNBVg+XxfZ2UjLxzEXHDHNn
 hBtv5jBbQv69p239pkS1SgN/agVBfasI+pthLzoNcoRc7VoFQcKOIOk1GLImidqDEEck
 WzMBuhHBv1ZSnwo34WbGl5ttlHe/YBpogL+Ogw821HTjLdgXCoX3ST5U+w5sEdcMjxL4
 zrj4K8p0Wpk+ZFy4Y8b/ObVtGnvgzQ9C5ifo0HFhSQgRtw5CNcW0L3SZsOPbiBC442ab
 XrKG0DIArwEG0z+EL/BtfXJf4SUD8+FtIZD3VAOCq52xNZ6iIE+U2VGU7uzyhKnh040i
 267w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688664874; x=1691256874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0aCf2GKvhyCqqRh9M6DyFCkPw9umGTO4c0XbxYbNjC4=;
 b=FTxBafT7L0+T/jlwGP/dj22c6ZTN1LtvoNkVV9h7In373TBRZk036kzIYy2Rr2VVe0
 vU979dv40bka4eKKZ8W6re/RoD/5+qdVL0rKz3uOJ/9P13+YWmTaijo5UCpXgUjwZeC9
 obYX25ZLdyYW0GEQ7LnrBXMdsAK25gahCtXlep0J695gwPDrlMN0lIGb2PMCQ3/Dcivz
 vuyGU09vmmeqq3a2lz+YVJpgRNO/i3b+jNlADM1tuk+hZuOscYrkbU5azZXWL2QRAgdv
 U/pj6MIYRfJRWyogj3CNIUIYDiSEyQebeRKGr+KyU/j7JVR5OERcyuL37goi50RDMfG8
 Tueg==
X-Gm-Message-State: ABy/qLbf0ogShpxzyvRm0ojOEnkgkd/1hKdBeOFC8CKdn9c9iB8WxsGd
 WswbIE2qRerCwivtVwX9XpcEm8nDrt1Uob4aWbW0OufT
X-Google-Smtp-Source: APBJJlEWuJ0VjVcQy76zWCUayc7EfSNkQPX/1doGdCnbNs2WA8DshSsJaGib7QDPxNxbijwS2zjmmoyMRpQBLbydj8M=
X-Received: by 2002:a05:6870:b524:b0:1b3:64d2:473b with SMTP id
 v36-20020a056870b52400b001b364d2473bmr2550467oap.6.1688664873897; Thu, 06 Jul
 2023 10:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-3-shashank.sharma@amd.com>
 <CADnq5_P6pHZVOOgRVd51rUfxf7+BxZt62Ty818670quuAUETFA@mail.gmail.com>
 <c1ed28d2-cfb6-031b-95af-86f5da85b342@amd.com>
In-Reply-To: <c1ed28d2-cfb6-031b-95af-86f5da85b342@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jul 2023 13:34:22 -0400
Message-ID: <CADnq5_Picr7eMM8TNO_=bAQxohVfAZFyvmAjZsXVsepP8rWTmg@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] drm/amdgpu: add usermode queue base code
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 6, 2023 at 12:53=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
>
> On 06/07/2023 18:36, Alex Deucher wrote:
> > On Thu, Jul 6, 2023 at 8:36=E2=80=AFAM Shashank Sharma <shashank.sharma=
@amd.com> wrote:
> >> This patch adds skeleton code for amdgpu usermode queue.
> >> It contains:
> >> - A new files with init functions of usermode queues.
> >> - A queue context manager in driver private data.
> >>
> >> V1: Worked on design review comments from RFC patch series:
> >> (https://patchwork.freedesktop.org/series/112214/)
> >> - Alex: Keep a list of queues, instead of single queue per process.
> >> - Christian: Use the queue manager instead of global ptrs,
> >>             Don't keep the queue structure in amdgpu_ctx
> >>
> >> V2:
> >>   - Reformatted code, split the big patch into two
> >>
> >> V3:
> >> - Integration with doorbell manager
> >>
> >> V4:
> >> - Align the structure member names to the largest member's column
> >>    (Luben)
> >> - Added SPDX license (Luben)
> >>
> >> V5:
> >> - Do not add amdgpu.h in amdgpu_userqueue.h (Christian).
> >> - Move struct amdgpu_userq_mgr into amdgpu_userqueue.h (Christian).
> >>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Christian Koenig <christian.koenig@amd.com>
> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 ++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 40 ++++++++++++
> >>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 62 +++++++++++++++++=
++
> >>   6 files changed, 113 insertions(+)
> >>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd=
/amdgpu/Makefile
> >> index 415a7fa395c4..4b9bae995094 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> >> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> >> @@ -216,6 +216,8 @@ amdgpu-y +=3D \
> >>   # add amdkfd interfaces
> >>   amdgpu-y +=3D amdgpu_amdkfd.o
> >>
> >> +# add usermode queue
> >> +amdgpu-y +=3D amdgpu_userqueue.o
> >>
> >>   ifneq ($(CONFIG_HSA_AMD),)
> >>   AMDKFD_PATH :=3D ../amdkfd
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h
> >> index 02b827785e39..fab842138cd5 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -107,6 +107,7 @@
> >>   #include "amdgpu_fdinfo.h"
> >>   #include "amdgpu_mca.h"
> >>   #include "amdgpu_ras.h"
> >> +#include "amdgpu_userqueue.h"
> >>
> >>   #define MAX_GPU_INSTANCE               16
> >>
> >> @@ -463,6 +464,7 @@ struct amdgpu_fpriv {
> >>          struct mutex            bo_list_lock;
> >>          struct idr              bo_list_handles;
> >>          struct amdgpu_ctx_mgr   ctx_mgr;
> >> +       struct amdgpu_userq_mgr userq_mgr;
> >>   };
> >>
> >>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fp=
riv);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c
> >> index b1ca1ab6d6ad..4c5e44d41652 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -50,6 +50,7 @@
> >>   #include "amdgpu_ras.h"
> >>   #include "amdgpu_xgmi.h"
> >>   #include "amdgpu_reset.h"
> >> +#include "amdgpu_userqueue.h"
> >>
> >>   /*
> >>    * KMS wrapper.
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c
> >> index 0efb38539d70..68e5375b648b 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> @@ -44,6 +44,7 @@
> >>   #include "amdgpu_display.h"
> >>   #include "amdgpu_ras.h"
> >>   #include "amd_pcie.h"
> >> +#include "amdgpu_userqueue.h"
> >>
> >>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
> >>   {
> >> @@ -1234,6 +1235,10 @@ int amdgpu_driver_open_kms(struct drm_device *d=
ev, struct drm_file *file_priv)
> >>
> >>          amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
> >>
> >> +       r =3D amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
> >> +       if (r)
> >> +               DRM_WARN("Can't setup usermode queues, use legacy work=
load submission only\n");
> >> +
> >>          file_priv->driver_priv =3D fpriv;
> >>          goto out_suspend;
> >>
> >> @@ -1301,6 +1306,7 @@ void amdgpu_driver_postclose_kms(struct drm_devi=
ce *dev,
> >>
> >>          amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> >>          amdgpu_vm_fini(adev, &fpriv->vm);
> >> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> >>
> >>          if (pasid)
> >>                  amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_userqueue.c
> >> new file mode 100644
> >> index 000000000000..effc0c7c02cf
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >> @@ -0,0 +1,40 @@
> >> +// SPDX-License-Identifier: MIT
> >> +/*
> >> + * Copyright 2023 Advanced Micro Devices, Inc.
> >> + *
> >> + * Permission is hereby granted, free of charge, to any person obtain=
ing a
> >> + * copy of this software and associated documentation files (the "Sof=
tware"),
> >> + * to deal in the Software without restriction, including without lim=
itation
> >> + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,
> >> + * and/or sell copies of the Software, and to permit persons to whom =
the
> >> + * Software is furnished to do so, subject to the following condition=
s:
> >> + *
> >> + * The above copyright notice and this permission notice shall be inc=
luded in
> >> + * all copies or substantial portions of the Software.
> >> + *
> >> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EX=
PRESS OR
> >> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> >> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT=
 SHALL
> >> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR
> >> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,
> >> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR
> >> + * OTHER DEALINGS IN THE SOFTWARE.
> >> + *
> >> + */
> >> +
> >> +#include "amdgpu.h"
> >> +
> >> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct =
amdgpu_device *adev)
> >> +{
> >> +       mutex_init(&userq_mgr->userq_mutex);
> >> +       idr_init_base(&userq_mgr->userq_idr, 1);
> >> +       userq_mgr->adev =3D adev;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
> >> +{
> >> +       idr_destroy(&userq_mgr->userq_idr);
> >> +       mutex_destroy(&userq_mgr->userq_mutex);
> >> +}
> >> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/=
gpu/drm/amd/include/amdgpu_userqueue.h
> >> new file mode 100644
> >> index 000000000000..79ffa131a514
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >> @@ -0,0 +1,62 @@
> >> +/* SPDX-License-Identifier: MIT */
> >> +/*
> >> + * Copyright 2023 Advanced Micro Devices, Inc.
> >> + *
> >> + * Permission is hereby granted, free of charge, to any person obtain=
ing a
> >> + * copy of this software and associated documentation files (the "Sof=
tware"),
> >> + * to deal in the Software without restriction, including without lim=
itation
> >> + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,
> >> + * and/or sell copies of the Software, and to permit persons to whom =
the
> >> + * Software is furnished to do so, subject to the following condition=
s:
> >> + *
> >> + * The above copyright notice and this permission notice shall be inc=
luded in
> >> + * all copies or substantial portions of the Software.
> >> + *
> >> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EX=
PRESS OR
> >> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> >> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT=
 SHALL
> >> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR
> >> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,
> >> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR
> >> + * OTHER DEALINGS IN THE SOFTWARE.
> >> + *
> >> + */
> >> +
> >> +#ifndef AMDGPU_USERQUEUE_H_
> >> +#define AMDGPU_USERQUEUE_H_
> >> +
> >> +#define AMDGPU_MAX_USERQ_COUNT 512
> >> +
> >> +struct amdgpu_mqd_prop;
> >> +
> >> +struct amdgpu_usermode_queue {
> >> +       int                     queue_type;
> >> +       uint64_t                doorbell_handle;
> >> +       uint64_t                doorbell_index;
> >> +       uint64_t                flags;
> >> +       struct amdgpu_mqd_prop  *userq_prop;
> >> +       struct amdgpu_userq_mgr *userq_mgr;
> >> +       struct amdgpu_vm        *vm;
> >> +};
> >> +
> >> +struct amdgpu_userq_funcs {
> >> +       int (*mqd_create)(struct amdgpu_userq_mgr *uq_mgr,
> >> +                         struct drm_amdgpu_userq_in *args,
> >> +                         struct amdgpu_usermode_queue *queue);
> >> +       void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr,
> >> +                           struct amdgpu_usermode_queue *uq);
> >> +};
> >> +
> >> +/* Usermode queues for gfx */
> >> +struct amdgpu_userq_mgr {
> >> +       struct idr                      userq_idr;
> >> +       struct mutex                    userq_mutex;
> >> +       struct amdgpu_device            *adev;
> >> +       const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM]=
;
> > Why did we decide to put these in the userq_mgr rather than having
> > them in adev?  I tried to find the original v1 thread.  It just seems
> > like extra work to assign a bunch of pointers every time we create a
> > userq_mgr.  I don't see a case where we would ever want them to be
> > different per userq_mgr instance.  It also keeps all of the IP
> > specific knowledge in the IP specific code.  E.g., if some IP only
> > supports this for specific versions, we could assign the pointers to
> > adev in that IP's code rather than adding a bunch of logic to the
> > generic userq code to know which IP versions may or may not support
> > this.
>
> So far we have been discussing on why not to keep this whole structure
> in adev, which was as discussed due to a previous review comment (want
> to make this data specific to a session between open() and close(), and
> also not to overpopulate adev), but we do not have a specific reason to
> keep these function ptrs in uq_mgr. I can move just these function
> pointers in adev and we can initialize this once during the IP init, the
> small cost to pay would be right now all the things related to usermode
> queue is at this one place, in the other case it would be scattered
> across two (Which can be ignored, if we prefer :))

Having a single structure somewhere makes more sense to me.  It
wouldn't have to live in adev if there is some other per device
structure that makes more sense as long as the IP specific code is the
one that populates it.  That said, if you or Christian feel strongly
about it, I could be persuaded.

Alex


Alex


>
> - Shashank
>
> > Alex
> >
> >
> >> +};
> >> +
> >> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct =
amdgpu_device *adev);
> >> +
> >> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
> >> +
> >> +#endif
> >> --
> >> 2.40.1
> >>
