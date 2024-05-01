Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C2BC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 20:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35596112436;
	Wed,  1 May 2024 20:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R0Wch63n";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2058910FB31
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 20:50:25 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-1ec4dc64c6cso16989545ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 May 2024 13:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714596624; x=1715201424; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eO3TxXATxJJC/Xe33DaPZaL82+HGIk+sPJ1E2GshRrs=;
 b=R0Wch63nGbVcwyYpkJ1WJuVQxM6Tb71xSSXBiLtLhx9klHpvj09HHwWeSI9MTGGL9X
 m6UxESfp20TdmCbupOoCK/LxFpjj45rKkmdqC2Ubwf/cg9SQ1MrSlPhnc4A/9sJdUpVN
 251WTqc7xsZxtYoKxMVX5ZXP0+CgyCbLlM0KjTDrRnpBgVPb9Wt4oc2nSDsefV5wNfhS
 JT7GvewOrItcasMFSq37ZPatJ8SDxA+PLGeLQHTy52VEnmDsLOGvIc0B60HkVO+4rju8
 9lsGKpmsjjuSyDzA3cTj4wuKlVKcnYwtu9Z4tZv9tEMzJdKkFW7qzbncgVfNNBOenfzQ
 wocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714596624; x=1715201424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eO3TxXATxJJC/Xe33DaPZaL82+HGIk+sPJ1E2GshRrs=;
 b=ddbG6IvT0vO3kWhn59r7ryNUGLXnUKBZ6DdwOpMh9ZOBWUvBGI14rINb1kM+ez9xNG
 zYkY+m27FMEUwxqN6Jt5oR47eTSaF0lRAQmhCq7p/D6Yf+hKhTztZB6e1okMREO+SsZQ
 ZpU1/eDDg6+M1ZBkIBi8dgTj5XnqWUMoQv+OC3kMlV9uV7cjxx2oSR4KnaN0K3gbrHAV
 9k1RflaBpG0eYE0AibQkJ6efa1Bcnhl6dJSDRTG6CmVxqAIbAoqf2FFSfa8347BXkHHX
 doO4V+hvFQfFU8n/8sAckitx/cGMKuk6Fh9uQ/kWQeGK+T2SSWgqvEHXkuMSeKL0m1Yh
 2GeA==
X-Gm-Message-State: AOJu0YyBHd5FpLpaDvj6JMXYh7VxIoIN3lk+QqSzFFl/scuyXMcu9i6g
 qFQZW7s07yxI198n2cPRICQrkpcFV3CvoWExTM/FaLGR3yuQsY6U68fNq9XRkPh1NmWugCfPZde
 d+PzSOWdJ5Affzh9PEkuvsB0Fx8Y=
X-Google-Smtp-Source: AGHT+IF/RoqLjNDsCQiWD9qNKimIL/9jOD80ZVZ+KSoFAyNs4yvg2yWruq069zY/Dx/NFUYz1xaA1w7DvMzOWUd+5gI=
X-Received: by 2002:a17:902:dac3:b0:1ec:429a:8885 with SMTP id
 q3-20020a170902dac300b001ec429a8885mr4992141plx.68.1714596624251; Wed, 01 May
 2024 13:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-6-shashank.sharma@amd.com>
In-Reply-To: <20240426134810.1250-6-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 May 2024 16:50:12 -0400
Message-ID: <CADnq5_NJy9NB8eohN65s5EcnSVpLJ+xjtp1VMgQTGH_r-GtC0A@mail.gmail.com>
Subject: Re: [PATCH v9 05/14] drm/amdgpu: create MES-V11 usermode queue for GFX
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 26, 2024 at 9:48=E2=80=AFAM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> A Memory queue descriptor (MQD) of a userqueue defines it in
> the hw's context. As MQD format can vary between different
> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>
> This patch:
> - Adds a new file which will be used for MES based userqueue
>   functions targeting GFX and SDMA IP.
> - Introduces MQD handler functions for the usermode queues.
> - Adds new functions to create and destroy userqueue MQD for
>   MES-V11 for GFX IP.
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
> V4: Review comments addressed:
>     - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>     - Align name of structure members (Luben)
>     - Don't break up the Cc tag list and the Sob tag list in commit
>       message (Luben)
> V5:
>    - No need to reserve the bo for MQD (Christian).
>    - Some more changes to support IP specific MQD creation.
>
> V6:
>    - Add a comment reminding us to replace the amdgpu_bo_create_kernel()
>      calls while creating MQD object to amdgpu_bo_create() once eviction
>      fences are ready (Christian).
>
> V7:
>    - Re-arrange userqueue functions in adev instead of uq_mgr (Alex)
>    - Use memdup_user instead of copy_from_user (Christian)
>
> V9:
>    - Moved userqueue code from gfx_v11_0.c to new file mes_v11_0.c so
>      that it can be reused for SDMA userqueues as well (Shashank, Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +
>  .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 110 ++++++++++++++++++
>  3 files changed, 116 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 05a2d1714070..a640bfa468ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -184,7 +184,8 @@ amdgpu-y +=3D \
>  amdgpu-y +=3D \
>         amdgpu_mes.o \
>         mes_v10_1.o \
> -       mes_v11_0.o
> +       mes_v11_0.o \
> +       mes_v11_0_userqueue.o
>
>  # add UVD block
>  amdgpu-y +=3D \
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index f7325b02a191..525bd0f4d3f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1331,6 +1331,8 @@ static int gfx_v11_0_rlc_backdoor_autoload_enable(s=
truct amdgpu_device *adev)
>         return 0;
>  }
>
> +extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;
> +
>  static int gfx_v11_0_sw_init(void *handle)
>  {
>         int i, j, k, r, ring_id =3D 0;
> @@ -1347,6 +1349,7 @@ static int gfx_v11_0_sw_init(void *handle)
>                 adev->gfx.mec.num_mec =3D 2;
>                 adev->gfx.mec.num_pipe_per_mec =3D 4;
>                 adev->gfx.mec.num_queue_per_pipe =3D 4;
> +               adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_mes_v11_0_=
funcs;
>                 break;
>         case IP_VERSION(11, 0, 1):
>         case IP_VERSION(11, 0, 4):
> @@ -1358,6 +1361,7 @@ static int gfx_v11_0_sw_init(void *handle)
>                 adev->gfx.mec.num_mec =3D 1;
>                 adev->gfx.mec.num_pipe_per_mec =3D 4;
>                 adev->gfx.mec.num_queue_per_pipe =3D 4;
> +               adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_mes_v11_0_=
funcs;

Does this work on APUs yet?  If not, we should limit it to just dGPUs
for now.  Also, we should add minimum firmware version checks for user
queue support.

>                 break;
>         default:
>                 adev->gfx.me.num_me =3D 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/g=
pu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> new file mode 100644
> index 000000000000..9e7dee77d344
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
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
> +#include "amdgpu_gfx.h"
> +#include "v11_structs.h"
> +#include "mes_v11_0.h"
> +#include "amdgpu_userqueue.h"
> +
> +static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
> +                                     struct drm_amdgpu_userq_in *args_in=
,
> +                                     struct amdgpu_usermode_queue *queue=
)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_ty=
pe];
> +       struct drm_amdgpu_userq_mqd *mqd_user;
> +       struct amdgpu_mqd_prop *userq_props;
> +       int r;
> +
> +       /* Incoming MQD parameters from userspace to be saved here */
> +       memset(&mqd_user, 0, sizeof(mqd_user));
> +
> +       /* Structure to initialize MQD for userqueue using generic MQD in=
it function */
> +       userq_props =3D kzalloc(sizeof(struct amdgpu_mqd_prop), GFP_KERNE=
L);
> +       if (!userq_props) {
> +               DRM_ERROR("Failed to allocate memory for userq_props\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (args_in->mqd_size !=3D sizeof(struct drm_amdgpu_userq_mqd)) {
> +               DRM_ERROR("MQD size mismatch\n");
> +               r =3D -EINVAL;
> +               goto free_props;
> +       }
> +
> +       mqd_user =3D memdup_user(u64_to_user_ptr(args_in->mqd), args_in->=
mqd_size);
> +       if (IS_ERR(mqd_user)) {
> +               DRM_ERROR("Failed to read user MQD\n");
> +               r =3D -EFAULT;
> +               goto free_props;
> +       }
> +
> +       r =3D amdgpu_userqueue_create_object(uq_mgr, &queue->mqd, mqd_hw_=
default->mqd_size);
> +       if (r) {
> +               DRM_ERROR("Failed to create MQD object for userqueue\n");
> +               goto free_mqd_user;
> +       }
> +
> +       /* Initialize the MQD BO with user given values */
> +       userq_props->wptr_gpu_addr =3D mqd_user->wptr_va;
> +       userq_props->rptr_gpu_addr =3D mqd_user->rptr_va;
> +       userq_props->queue_size =3D mqd_user->queue_size;
> +       userq_props->hqd_base_gpu_addr =3D mqd_user->queue_va;
> +       userq_props->mqd_gpu_addr =3D queue->mqd.gpu_addr;

We should validate the user virtual addresses and make sure they are
non-0 and not part of the reserved areas of the address space.

Alex

> +       userq_props->use_doorbell =3D true;
> +
> +       queue->userq_prop =3D userq_props;
> +
> +       r =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, =
userq_props);
> +       if (r) {
> +               DRM_ERROR("Failed to initialize MQD for userqueue\n");
> +               goto free_mqd;
> +       }
> +
> +       return 0;
> +
> +free_mqd:
> +       amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> +
> +free_mqd_user:
> +       kfree(mqd_user);
> +
> +free_props:
> +       kfree(userq_props);
> +
> +       return r;
> +}
> +
> +static void
> +mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
> +                           struct amdgpu_usermode_queue *queue)
> +{
> +       kfree(queue->userq_prop);
> +       amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> +}
> +
> +const struct amdgpu_userq_funcs userq_mes_v11_0_funcs =3D {
> +       .mqd_create =3D mes_v11_0_userq_mqd_create,
> +       .mqd_destroy =3D mes_v11_0_userq_mqd_destroy,
> +};
> --
> 2.43.2
>
