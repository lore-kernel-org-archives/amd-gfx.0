Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17EEC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 21:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455BA10E223;
	Thu, 30 Mar 2023 21:18:16 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB7D10E223
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 21:18:15 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-177b78067ffso21211827fac.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680211094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/oCCt8lZonGLQJtH8dNXAJB7x6f/V29ICVjbZkCpcg=;
 b=XQ8XEtWC6UpPVjg2XtIsksqBz/OvDY63pkh9dHNyqvgfQal22vy1UOMWW6p/OKJAmy
 NVUM/IgCvSLbSqWl6mGtspvmPFz8w81HCPsGPq8B6PQ64MU1WbzIl0IkuR725c307GYt
 AW09sxdGT0ebUSskKAzmnR4/gb31LYx3KVVJhqRcthgUMHHEdPoIREWaG6v4bUEkToKg
 aBS6K9kVDGqKr2xFJcXKJdrtQwMcWd8bTAcaPJTpCfIQn0rvd1RXPms1jRiXkMWIVS/N
 zJUvVBycjRoELihhTuZ4q1n16sQQHn5XW002JNPbepCMm5NsfGMnag6f6OvKEYkfAZK/
 IodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680211094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/oCCt8lZonGLQJtH8dNXAJB7x6f/V29ICVjbZkCpcg=;
 b=NDUjvy+7jcdFwBNYtzxqIs8lRojyiD6APrpBp6Buk6M4KSdLdqY4kfRdIuUkAUjmRr
 ngv5DG+6O7lrQxWIyJ8uJn6eJCgAyQr2E9IFaMoeF9H5WI7oNJu1xQHzwhfIWv/PJRmK
 SkzPfQUhO8IXoGs3VHICM1LtG2ZT39KLPHYi1qj2rdI3kzxL+YHWoQsOuDBpCZ0v+xIp
 chQmsZ8aTtsPI2XlODJefSS2GKZ1XCjZyCHieAnnI1oj+G0wfpWOmKIw6aDnovVd5M/K
 ycwPSpn9Cous0ERJAel4pRmuY10UFp8QYEryE7juqdHlY/hiC2CIi8Ta0NtLx+CIbOTY
 MlkQ==
X-Gm-Message-State: AAQBX9e/nNpk0+4vNrwhMWUf9VluGJVyfqlxetjbc/l+Kvs+eavCApqv
 FbAO8O2VIIDlYWw3br2NgQNcEORJwmdwQm81PIE=
X-Google-Smtp-Source: AK7set/msTjcHex9q6P26PAypxjTi/C3fUHmcPjKEbw3mvX199vyKJOywWKox7uejLFbHlB5+19MvDGN7uUP3lO25oY=
X-Received: by 2002:a05:6870:1151:b0:17e:d308:776d with SMTP id
 17-20020a056870115100b0017ed308776dmr8429602oag.3.1680211094609; Thu, 30 Mar
 2023 14:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-5-shashank.sharma@amd.com>
In-Reply-To: <20230329160445.1300-5-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 17:18:03 -0400
Message-ID: <CADnq5_MpcdLZVqaFbAAg+4yEwAtYzU7Sf46z7xy0jXKRCm9drg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] drm/amdgpu: create GFX-gen11 MQD for userqueue
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
Cc: Felix Kuehling <felix.kuehling@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 12:05=E2=80=AFPM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> A Memory queue descriptor (MQD) of a userqueue defines it in the harware'=
s
> context. As MQD format can vary between different graphics IPs, we need g=
fx
> GEN specific handlers to create MQDs.
>
> This patch:
> - Introduces MQD hander functions for the usermode queues.
> - Adds new functions to create and destroy MQD for GFX-GEN-11-IP
>
> V1: Worked on review comments from Alex:
>     - Make MQD functions GEN and IP specific
>
> V2: Worked on review comments from Alex:
>     - Reuse the existing adev->mqd[ip] for MQD creation
>     - Formatting and arrangement of code
>
> V3:
>     - Integration with doorbell manager
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 21 +++++
>  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 84 +++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>  4 files changed, 113 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 2d90ba618e5d..2cc7897de7e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -212,6 +212,7 @@ amdgpu-y +=3D amdgpu_amdkfd.o
>
>  # add usermode queue
>  amdgpu-y +=3D amdgpu_userqueue.o
> +amdgpu-y +=3D amdgpu_userqueue_gfx_v11.o
>
>  ifneq ($(CONFIG_HSA_AMD),)
>  AMDKFD_PATH :=3D ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> index 353f57c5a772..052c2c1e8aed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -81,6 +81,12 @@ static int amdgpu_userqueue_create(struct drm_file *fi=
lp, union drm_amdgpu_userq
>          goto free_queue;
>      }
>
> +    r =3D uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, que=
ue);
> +    if (r) {
> +        DRM_ERROR("Failed to create/map userqueue MQD\n");
> +        goto free_queue;
> +    }
> +
>      args->out.queue_id =3D queue->queue_id;
>      args->out.flags =3D 0;
>      mutex_unlock(&uq_mgr->userq_mutex);
> @@ -105,6 +111,7 @@ static void amdgpu_userqueue_destroy(struct drm_file =
*filp, int queue_id)
>      }
>
>      mutex_lock(&uq_mgr->userq_mutex);
> +    uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>      amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>      mutex_unlock(&uq_mgr->userq_mutex);
>      kfree(queue);
> @@ -135,6 +142,19 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void =
*data,
>      return r;
>  }
>
> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
> +
> +static void
> +amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +    int maj;
> +    struct amdgpu_device *adev =3D uq_mgr->adev;
> +    uint32_t version =3D adev->ip_versions[GC_HWIP][0];
> +
> +    maj =3D IP_VERSION_MAJ(version);
> +    if (maj =3D=3D 11)
> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_gfx_v11_funcs;
> +}

These can be per device and done in each IP's init code.

>
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amd=
gpu_device *adev)
>  {
> @@ -142,6 +162,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *us=
erq_mgr, struct amdgpu_devi
>      idr_init_base(&userq_mgr->userq_idr, 1);
>      userq_mgr->adev =3D adev;
>
> +    amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>      return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> new file mode 100644
> index 000000000000..12e1a785b65a
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
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
> +#include "amdgpu.h"
> +#include "amdgpu_userqueue.h"
> +
> +static int
> +amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct =
amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_device *adev =3D uq_mgr->adev;
> +    struct amdgpu_userq_ctx_space *mqd =3D &queue->mqd;
> +    struct amdgpu_mqd *gfx_v11_mqd =3D &adev->mqds[queue->queue_type];
> +    int size =3D gfx_v11_mqd->mqd_size;
> +    int r;
> +
> +    r =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_GTT,
> +                                &mqd->obj,
> +                                &mqd->gpu_addr,
> +                                &mqd->cpu_ptr);
> +    if (r) {
> +        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
> +        return r;
> +    }
> +
> +    memset(mqd->cpu_ptr, 0, size);
> +    r =3D amdgpu_bo_reserve(mqd->obj, false);
> +    if (unlikely(r !=3D 0)) {
> +        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
> +        goto free_mqd;
> +    }
> +
> +    queue->userq_prop.use_doorbell =3D true;
> +    queue->userq_prop.mqd_gpu_addr =3D mqd->gpu_addr;
> +    r =3D gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->user=
q_prop);
> +    amdgpu_bo_unreserve(mqd->obj);
> +    if (r) {
> +        DRM_ERROR("Failed to init MQD for queue\n");
> +        goto free_mqd;
> +    }
> +
> +    DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
> +    return 0;
> +
> +free_mqd:
> +    amdgpu_bo_free_kernel(&mqd->obj,
> +                          &mqd->gpu_addr,
> +                          &mqd->cpu_ptr);
> +   return r;
> +}
> +
> +static void
> +amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct=
 amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_userq_ctx_space *mqd =3D &queue->mqd;
> +
> +    amdgpu_bo_free_kernel(&mqd->obj,
> +                          &mqd->gpu_addr,
> +                          &mqd->cpu_ptr);
> +}
> +
> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs =3D {
> +    .mqd_create =3D amdgpu_userq_gfx_v11_mqd_create,
> +    .mqd_destroy =3D amdgpu_userq_gfx_v11_mqd_destroy,
> +};

We can just stick these in gfx_v11_0.c.  No need for a new file.

Alex

> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index 7625a862b1fc..2911c88d0fed 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -27,6 +27,12 @@
>  #include "amdgpu.h"
>  #define AMDGPU_MAX_USERQ 512
>
> +struct amdgpu_userq_ctx_space {
> +       struct amdgpu_bo *obj;
> +       uint64_t gpu_addr;
> +       void *cpu_ptr;
> +};
> +
>  struct amdgpu_usermode_queue {
>         int queue_id;
>         int queue_type;
> @@ -35,6 +41,7 @@ struct amdgpu_usermode_queue {
>         struct amdgpu_vm *vm;
>         struct amdgpu_userq_mgr *userq_mgr;
>         struct amdgpu_mqd_prop userq_prop;
> +       struct amdgpu_userq_ctx_space mqd;
>  };
>
>  struct amdgpu_userq_funcs {
> --
> 2.40.0
>
