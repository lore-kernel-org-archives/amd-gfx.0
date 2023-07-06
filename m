Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034ABEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 16:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0F910E0D6;
	Thu,  6 Jul 2023 16:37:05 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75A710E0D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 16:37:03 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5636426c1b3so622322eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jul 2023 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688661423; x=1691253423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4G18zWoNxs1mIJxaZG9ktcgYgi1DLqNTtbUy5uP6rM=;
 b=V4HjkOUnbxCTnYFGd7D8mowsp7qDEgZkPsdFlUViPfQm18fTT9n7FaB35hKepILoR+
 /v28feCKnffYyuuM7CrducOb0BmQzKN6wsaFpRuhxlBK6nrQnyF7tH3vEF+tmCO/J9b+
 eCA69zc2hZ2TbgS4D0AsQqPNWL80811IsFNiG9hj756dDXkWDC4nEz4Rv2QlIJfDt+B1
 58P93boJdJzCml/84ydQROKdgSBhhnk4Mr3uhUcf/UnAv5V+3I53NPU6XnOmK4mdVbHY
 7FetAmAqR/L8aaImqjRbd0QoVzGUtZGsMr8VqhAbdTJADC4wv0JSFRiwPeWTfHsoFYJp
 yUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688661423; x=1691253423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K4G18zWoNxs1mIJxaZG9ktcgYgi1DLqNTtbUy5uP6rM=;
 b=aqMFZT9XM4USUp+TTrc5xtvNsmpDoXVvf+8DeLc9fvwug93D6TRu9N+GnzVu95XoS9
 9eSKjelAbWqRC6em6KynmF+Xj3GFWgdUmzTX6OMN3PJ3z6cgzBcXS52LmbRCTtbGr73f
 3etZ7Z2lNxcp2IQRUXca/2iTxdtm+IlDmCJ9s1yDno3lXSpduI/mycbNy/1EkDe98s3G
 hUdf+yNgcbkzYv4liiqvShwD1jwHI58jbqaLeI8RmkeH+4ibWOidUVWWfBjmL6DuEg8t
 OUmDMUa676gwnXREsedHBMcpV+xdIIZJzlwHEyXvIV0hD/spMXAh7ewIjMZPokC7RO/s
 mOIA==
X-Gm-Message-State: ABy/qLbtnGeKR6lqoreMnpQRkaYMibW6kH+IerjkprbKYjwUDv1PY1Qy
 URqmGQHMwOtaC2TBce5ifme81WduGHHU8nZyX7M=
X-Google-Smtp-Source: APBJJlFxq3seM0wEcM2Zd6kLf7FBoRqQQz/S99wg1m+lehExBO+idGU/UjeifYianPbyQ8baDdI9QYDGbkARFUk8t5k=
X-Received: by 2002:a4a:4110:0:b0:566:3723:a029 with SMTP id
 x16-20020a4a4110000000b005663723a029mr1920941ooa.3.1688661422546; Thu, 06 Jul
 2023 09:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-3-shashank.sharma@amd.com>
In-Reply-To: <20230706123602.2331-3-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jul 2023 12:36:50 -0400
Message-ID: <CADnq5_P6pHZVOOgRVd51rUfxf7+BxZt62Ty818670quuAUETFA@mail.gmail.com>
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

On Thu, Jul 6, 2023 at 8:36=E2=80=AFAM Shashank Sharma <shashank.sharma@amd=
.com> wrote:
>
> This patch adds skeleton code for amdgpu usermode queue.
> It contains:
> - A new files with init functions of usermode queues.
> - A queue context manager in driver private data.
>
> V1: Worked on design review comments from RFC patch series:
> (https://patchwork.freedesktop.org/series/112214/)
> - Alex: Keep a list of queues, instead of single queue per process.
> - Christian: Use the queue manager instead of global ptrs,
>            Don't keep the queue structure in amdgpu_ctx
>
> V2:
>  - Reformatted code, split the big patch into two
>
> V3:
> - Integration with doorbell manager
>
> V4:
> - Align the structure member names to the largest member's column
>   (Luben)
> - Added SPDX license (Luben)
>
> V5:
> - Do not add amdgpu.h in amdgpu_userqueue.h (Christian).
> - Move struct amdgpu_userq_mgr into amdgpu_userqueue.h (Christian).
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 40 ++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    | 62 +++++++++++++++++++
>  6 files changed, 113 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 415a7fa395c4..4b9bae995094 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -216,6 +216,8 @@ amdgpu-y +=3D \
>  # add amdkfd interfaces
>  amdgpu-y +=3D amdgpu_amdkfd.o
>
> +# add usermode queue
> +amdgpu-y +=3D amdgpu_userqueue.o
>
>  ifneq ($(CONFIG_HSA_AMD),)
>  AMDKFD_PATH :=3D ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 02b827785e39..fab842138cd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -107,6 +107,7 @@
>  #include "amdgpu_fdinfo.h"
>  #include "amdgpu_mca.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_userqueue.h"
>
>  #define MAX_GPU_INSTANCE               16
>
> @@ -463,6 +464,7 @@ struct amdgpu_fpriv {
>         struct mutex            bo_list_lock;
>         struct idr              bo_list_handles;
>         struct amdgpu_ctx_mgr   ctx_mgr;
> +       struct amdgpu_userq_mgr userq_mgr;
>  };
>
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)=
;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b1ca1ab6d6ad..4c5e44d41652 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -50,6 +50,7 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_reset.h"
> +#include "amdgpu_userqueue.h"
>
>  /*
>   * KMS wrapper.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 0efb38539d70..68e5375b648b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -44,6 +44,7 @@
>  #include "amdgpu_display.h"
>  #include "amdgpu_ras.h"
>  #include "amd_pcie.h"
> +#include "amdgpu_userqueue.h"
>
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -1234,6 +1235,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev,=
 struct drm_file *file_priv)
>
>         amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>
> +       r =3D amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
> +       if (r)
> +               DRM_WARN("Can't setup usermode queues, use legacy workloa=
d submission only\n");
> +
>         file_priv->driver_priv =3D fpriv;
>         goto out_suspend;
>
> @@ -1301,6 +1306,7 @@ void amdgpu_driver_postclose_kms(struct drm_device =
*dev,
>
>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>         amdgpu_vm_fini(adev, &fpriv->vm);
> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>
>         if (pasid)
>                 amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> new file mode 100644
> index 000000000000..effc0c7c02cf
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amd=
gpu_device *adev)
> +{
> +       mutex_init(&userq_mgr->userq_mutex);
> +       idr_init_base(&userq_mgr->userq_idr, 1);
> +       userq_mgr->adev =3D adev;
> +
> +       return 0;
> +}
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +       idr_destroy(&userq_mgr->userq_idr);
> +       mutex_destroy(&userq_mgr->userq_mutex);
> +}
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> new file mode 100644
> index 000000000000..79ffa131a514
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef AMDGPU_USERQUEUE_H_
> +#define AMDGPU_USERQUEUE_H_
> +
> +#define AMDGPU_MAX_USERQ_COUNT 512
> +
> +struct amdgpu_mqd_prop;
> +
> +struct amdgpu_usermode_queue {
> +       int                     queue_type;
> +       uint64_t                doorbell_handle;
> +       uint64_t                doorbell_index;
> +       uint64_t                flags;
> +       struct amdgpu_mqd_prop  *userq_prop;
> +       struct amdgpu_userq_mgr *userq_mgr;
> +       struct amdgpu_vm        *vm;
> +};
> +
> +struct amdgpu_userq_funcs {
> +       int (*mqd_create)(struct amdgpu_userq_mgr *uq_mgr,
> +                         struct drm_amdgpu_userq_in *args,
> +                         struct amdgpu_usermode_queue *queue);
> +       void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr,
> +                           struct amdgpu_usermode_queue *uq);
> +};
> +
> +/* Usermode queues for gfx */
> +struct amdgpu_userq_mgr {
> +       struct idr                      userq_idr;
> +       struct mutex                    userq_mutex;
> +       struct amdgpu_device            *adev;
> +       const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];

Why did we decide to put these in the userq_mgr rather than having
them in adev?  I tried to find the original v1 thread.  It just seems
like extra work to assign a bunch of pointers every time we create a
userq_mgr.  I don't see a case where we would ever want them to be
different per userq_mgr instance.  It also keeps all of the IP
specific knowledge in the IP specific code.  E.g., if some IP only
supports this for specific versions, we could assign the pointers to
adev in that IP's code rather than adding a bunch of logic to the
generic userq code to know which IP versions may or may not support
this.

Alex


> +};
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amd=
gpu_device *adev);
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
> +
> +#endif
> --
> 2.40.1
>
