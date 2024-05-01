Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCA1C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 21:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C53F3112454;
	Wed,  1 May 2024 21:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="evtHK73B";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150C8112454
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 21:29:17 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so5684734a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 May 2024 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714598956; x=1715203756; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOSSAmDmuyiUvzowGnInko9X0otIMbZGX1lAUCaM+Ck=;
 b=evtHK73BLJq/SLDa7SVqppGurKSAogNJ8uYH24fjxuQHtYS0zulehItr8IVywspB0+
 XfOZNuxz6K7+hhNWstxoVgCh1D67SBKDjkQ/8MipPxyqkqpv2cDcoKvlpyQugkn0A4cW
 1N2mWFd1DbuPgjMjBUTNYQqAmQZiNoS8whuoO57bl6YebaoFeB79Zs2/71/lequBYnrU
 BHYSYAzAvg+ZapyaEDnHB1thnLsDDZr75ZBFy49Uotshkj+8h25ecUdreiZ0cPao6AsZ
 g/EYtRcBaLX1BF9+tb5xHfoT8XDGjwix4hzAKbtNSbSKGORB0F2NY6e1EEzi97miePgh
 j1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714598956; x=1715203756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOSSAmDmuyiUvzowGnInko9X0otIMbZGX1lAUCaM+Ck=;
 b=cHAabs7hj85qkY/GrcHfJyNwS4+CLE3qOMLzASZIQuITMwz+8VmhpovfOd3ZgOXkcN
 65EJ7TifJx2+gD/TTQms7jMNqhzMLPGyMfUYeLxuZGR4+2eDZk09wSu4zRMmp1Do3c6W
 K8vYCvhqySyEErrfwQW8alT0xLTp7INDyyTDFaaC1T6kxg9/K5Nh9GiOx1ZK9ErNajvx
 ZpfG7hBa/HCPdi/iiPwwevEkr6WJ3P9Wx9tjmB1HoJJG1TlJMZQX75GSDY0o//eJLlRx
 6f3RkEtK9PYKN9l8AiTw/azEdAVDsDMq8A7byq3Rh4vN7+S8iEA4R9+wYE6BnJmIO4D2
 M2mQ==
X-Gm-Message-State: AOJu0YyqJpyFmwZ3ktUJjUfCvhUQmoCLKBY37xxvVN5aYF6wdhiBnxPu
 Hzra7Uxmp97yF+VB7clMP+y4f5m4KKExXs3vuvmbEbS7CxqPvdT9HOwjVxTIj+5CIz5YQFJkxQC
 vM9nXZl+E1OyJYRX1fTn4Pvo8oiwm4Q==
X-Google-Smtp-Source: AGHT+IGEcLwSN0JDkTNhklyfZ0mBDFH0frZgljx9ivFS/OVnylbkkISbvIEQ6bm2fHAIBscYj99sNrwRryrSbRlZoNg=
X-Received: by 2002:a17:90a:fc85:b0:2b2:81c0:268d with SMTP id
 ci5-20020a17090afc8500b002b281c0268dmr3225172pjb.43.1714598956456; Wed, 01
 May 2024 14:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-3-shashank.sharma@amd.com>
In-Reply-To: <20240426134810.1250-3-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 May 2024 17:29:04 -0400
Message-ID: <CADnq5_O+tN6ovOpyHq4kZS56_8JHyFvm=2=rrW_sv1s4CHMUhg@mail.gmail.com>
Subject: Re: [PATCH v9 02/14] drm/amdgpu: add usermode queue base code
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

On Fri, Apr 26, 2024 at 9:57=E2=80=AFAM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
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
> V6: Rebase
> V9: Rebase
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 40 ++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    | 61 +++++++++++++++++++
>  6 files changed, 113 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 4536c8ad0e11..05a2d1714070 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -260,6 +260,8 @@ amdgpu-y +=3D \
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
> index b3b84647207e..4ca14b02668b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -112,6 +112,7 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_seq64.h"
>  #include "amdgpu_reg_state.h"
> +#include "amdgpu_userqueue.h"
>
>  #define MAX_GPU_INSTANCE               64
>
> @@ -477,6 +478,7 @@ struct amdgpu_fpriv {
>         struct mutex            bo_list_lock;
>         struct idr              bo_list_handles;
>         struct amdgpu_ctx_mgr   ctx_mgr;
> +       struct amdgpu_userq_mgr userq_mgr;
>         /** GPU partition selection */
>         uint32_t                xcp_id;
>  };
> @@ -1039,6 +1041,7 @@ struct amdgpu_device {
>         bool                            enable_mes_kiq;
>         struct amdgpu_mes               mes;
>         struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
> +       const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
>
>         /* df */
>         struct amdgpu_df                df;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index e4277298cf1a..374970984a61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -50,6 +50,7 @@
>  #include "amdgpu_reset.h"
>  #include "amdgpu_sched.h"
>  #include "amdgpu_xgmi.h"
> +#include "amdgpu_userqueue.h"
>  #include "../amdxcp/amdgpu_xcp_drv.h"
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index a2df3025a754..d78b06af834e 100644
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
> @@ -1388,6 +1389,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev,=
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
> @@ -1457,6 +1462,7 @@ void amdgpu_driver_postclose_kms(struct drm_device =
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
> index 000000000000..93ebe4b61682
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -0,0 +1,61 @@
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
> +};
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amd=
gpu_device *adev);
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
> +
> +#endif
> --
> 2.43.2
>
