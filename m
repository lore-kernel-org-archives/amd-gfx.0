Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058B9EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 16:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623C110E482;
	Thu,  6 Jul 2023 16:27:35 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C4810E48A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 16:27:33 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b3ca17f2a6so868799fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jul 2023 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688660852; x=1691252852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwVM8xTGHgfuy19WWDlQKhbX+8QAq0w6rxaB9H6ErMY=;
 b=U2dHDfHZcNO2yukX5JtP38IcLKvLuLqA6V4nBX+tfHh6u47hCTZfzUetxkf6CsdJIe
 gJjmnnYuwN1j0x4PPYGxxiJ6SepSn0Y4zNYv+fP/4f6HV/E2sYRtW17SVoTmWoUKp+qq
 txbtGGZ4l8SmVzgvZwQ8IwK/o2iEp8MaDo7zjTe21mpXQMM0NFUJz865MINcWyJgNZbF
 m5TcHNrhL0+Ahj5JKlTngPkxoWZHP8SnwuM1t4spamHSHXzxFlYB9bBVVO6e0ysgtUY4
 0Sw/LeBCGHr81SILtDIbkjkeBV35EjAb/IY7mJ2xGooKYrJ8y0De8lbCuSJDz/0lRqCu
 HBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688660852; x=1691252852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QwVM8xTGHgfuy19WWDlQKhbX+8QAq0w6rxaB9H6ErMY=;
 b=DlGLGWnP6O0F7FLVxDVgGU/D377zWJa2SOWSFsp+FlI1za/FdFIADgTS28kAhqtHUc
 ks28LBk4pPNHcpMZX9wGe4AtkNWkB65vp1N1U8C2niwlBB8q43lb0S0OC+xT5oyGNh62
 Ctc+6U2A7t++6XSKpTIT/f9RuIpo3kdJHF1nuLEk5mfMJ6U79NxC8QIQfTinlEiW2SZ+
 8yAMaEzegoTTG9MUA+H41gTAavNHrBLl4fKSxO4i+NgDQuWnn86FD1sVTKm4Q59yZS6y
 1u9QO+7/sVn15YFy3HwWmzdK35KGzQ9ekispeq7NuaOtCH5BiiAPsEJevLj6kYRQvQV5
 OjFw==
X-Gm-Message-State: ABy/qLZH/6nG/ddSiuW+bjtmKKVcnS5BWbl9j76mJURmSY8JeWN0PDEo
 d/cIqkKirsh/sMnXIPHkgl3f7gQeqFHr0Q0PxJCHIFmueR4=
X-Google-Smtp-Source: APBJJlHRj7fZ0fgvpfceFjRp/NihT3iH7YmP+9jLfxQmRPvHXSEVIk4CNQT1WLhvqWrqVqI9WlYBmr9ziQtqoUGS4ds=
X-Received: by 2002:a05:6871:54e:b0:1b0:8288:e698 with SMTP id
 t14-20020a056871054e00b001b08288e698mr2617565oal.55.1688660852329; Thu, 06
 Jul 2023 09:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
In-Reply-To: <20230706123602.2331-5-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jul 2023 12:27:21 -0400
Message-ID: <CADnq5_Pj+C3ARsG5OwNaF=zv5FAyRnaDHRP8Xdq9WPvBDhT-ew@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
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
> A Memory queue descriptor (MQD) of a userqueue defines it in
> the hw's context. As MQD format can vary between different
> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>
> This patch:
> - Introduces MQD handler functions for the usermode queues.
> - Adds new functions to create and destroy userqueue MQD for
>   GFX-GEN-11 IP
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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 +++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>  3 files changed, 96 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> index e37b5da5a0d0..bb774144c372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
 *data,
>         return r;
>  }
>
> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;

Just add this to gfx_v11_0.h and include that here.

> +
> +static void
> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +       int maj;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       uint32_t version =3D adev->ip_versions[GC_HWIP][0];
> +
> +       /* We support usermode queue only for GFX V11 as of now */
> +       maj =3D IP_VERSION_MAJ(version);
> +       if (maj =3D=3D 11)
> +               uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_gfx_v11_=
funcs;
> +}
> +
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amd=
gpu_device *adev)
>  {
>         mutex_init(&userq_mgr->userq_mutex);
>         idr_init_base(&userq_mgr->userq_idr, 1);
>         userq_mgr->adev =3D adev;
>
> +       amdgpu_userqueue_setup_gfx(userq_mgr);
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index c4940b6ea1c4..e76e1b86b434 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -30,6 +30,7 @@
>  #include "amdgpu_psp.h"
>  #include "amdgpu_smu.h"
>  #include "amdgpu_atomfirmware.h"
> +#include "amdgpu_userqueue.h"
>  #include "imu_v11_0.h"
>  #include "soc21.h"
>  #include "nvd.h"
> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_=
block =3D
>         .rev =3D 0,
>         .funcs =3D &gfx_v11_0_ip_funcs,
>  };
> +
> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
> +                                     struct drm_amdgpu_userq_in *args_in=
,
> +                                     struct amdgpu_usermode_queue *queue=
)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_mqd *mqd_gfx_generic =3D &adev->mqds[AMDGPU_HW_IP_G=
FX];
> +       struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
> +       struct amdgpu_mqd_prop userq_props;
> +       int r;
> +
> +       /* Incoming MQD parameters from userspace to be saved here */
> +       memset(&mqd_user, 0, sizeof(mqd_user));
> +
> +       /* Structure to initialize MQD for userqueue using generic MQD in=
it function */
> +       memset(&userq_props, 0, sizeof(userq_props));
> +
> +       if (args_in->mqd_size !=3D sizeof(struct drm_amdgpu_userq_mqd_gfx=
_v11_0)) {
> +               DRM_ERROR("MQD size mismatch\n");
> +               return -EINVAL;
> +       }
> +
> +       if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), args=
_in->mqd_size)) {
> +               DRM_ERROR("Failed to get user MQD\n");
> +               return -EFAULT;
> +       }
> +
> +       /* Create BO for actual Userqueue MQD now */
> +       r =3D amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, PA=
GE_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_GTT,
> +                                   &queue->mqd.obj,
> +                                   &queue->mqd.gpu_addr,
> +                                   &queue->mqd.cpu_ptr);
> +       if (r) {
> +               DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
> +               return -ENOMEM;
> +       }
> +       memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
> +
> +       /* Initialize the MQD BO with user given values */
> +       userq_props.wptr_gpu_addr =3D mqd_user.wptr_va;
> +       userq_props.rptr_gpu_addr =3D mqd_user.rptr_va;
> +       userq_props.queue_size =3D mqd_user.queue_size;
> +       userq_props.hqd_base_gpu_addr =3D mqd_user.queue_va;
> +       userq_props.mqd_gpu_addr =3D queue->mqd.gpu_addr;
> +       userq_props.use_doorbell =3D true;
> +
> +       r =3D mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr,=
 &userq_props);
> +       if (r) {
> +               DRM_ERROR("Failed to initialize MQD for userqueue\n");
> +               goto free_mqd;
> +       }
> +
> +       return 0;
> +
> +free_mqd:
> +       amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, &que=
ue->mqd.cpu_ptr);
> +       return r;
> +}
> +
> +static void
> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdg=
pu_usermode_queue *queue)
> +{
> +       struct amdgpu_userq_obj *mqd =3D &queue->mqd;
> +
> +       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
> +}
> +
> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs =3D {

gfx_v11_0_userq_funcs for consistency with the rest of the file.

Alex


> +       .mqd_create =3D gfx_v11_0_userq_mqd_create,
> +       .mqd_destroy =3D gfx_v11_0_userq_mqd_destroy,
> +};
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index 55ed6512a565..240f92796f00 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -29,6 +29,12 @@
>
>  struct amdgpu_mqd_prop;
>
> +struct amdgpu_userq_obj {
> +       void             *cpu_ptr;
> +       uint64_t         gpu_addr;
> +       struct amdgpu_bo *obj;
> +};
> +
>  struct amdgpu_usermode_queue {
>         int                     queue_type;
>         uint64_t                doorbell_handle;
> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>         struct amdgpu_mqd_prop  *userq_prop;
>         struct amdgpu_userq_mgr *userq_mgr;
>         struct amdgpu_vm        *vm;
> +       struct amdgpu_userq_obj mqd;
>  };
>
>  struct amdgpu_userq_funcs {
> --
> 2.40.1
>
