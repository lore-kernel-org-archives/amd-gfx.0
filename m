Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480BBC77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 21:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B8A210E61C;
	Fri, 19 May 2023 21:19:31 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1511E10E61C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 21:19:27 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-55517975c5fso99667eaf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684531167; x=1687123167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FaVvE3AxIupevneg7eYo5coKc8pgguhdwu8pZ8k7nC0=;
 b=A3sYTT/gWSeScQVsPA65TAFzPXlhjhdarwCwGXgPecZ/W3/wZBmMzKF/l1o04EoeDw
 TPcgd0pJAwZ1COie6AOVg5nnpYf0i3nD1lPx1AUKvbYHoP0u+TAJjfV2jJEnRrc6qhH0
 IJzmzHxRp9xvr4a8hD4zM+Sb/mK3ehQMdygbLJ3bePCPOY3l/MwsZquuGAmD5BORFl1M
 wPdKPN7ibQIgPnYxQK5BcjkmUTtTZK/xfsw9WU7M+E9O/eUF7VAEDmV7KC6HSKY2oMJ5
 DGcwtRiOXOKOmiUs7987JQ704m2jLXxJ/s21FTD/dytGyNIZnfFUHxdvwPhE72e4DZ06
 Xrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684531167; x=1687123167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FaVvE3AxIupevneg7eYo5coKc8pgguhdwu8pZ8k7nC0=;
 b=TVpYPfLCod+VpL5jG1E8s+DNdhsG3e4eMS9v0oKuoeGNzbMSI7gke8elpKMthovpak
 sUDzwt7qD/78rgwVWPZpAqpwc7u8h+nZwkxCA1UmxN32cW2Om0aWRv30vSb2nqjE4cn0
 Dkl3mAc5kN5FnX2m73tJTsyOR0gsCTB6Wohk2G77Nf4lgf2t9AZE4DVnez4jfzpbtTi7
 X4V3D1MoHMt1M6vwPkr+vxTFTmEC0eAKA2Sng2y8QISfLVO6+/AcuDZDlLpZ5f5cdqiE
 niLn5T6JwusljU+BYlCNlVPDGb8pldaATtD5irZgCEeTBlfl8AnUy20AG75Hnj0umcOO
 VHfw==
X-Gm-Message-State: AC+VfDyIwm99mort7yNuCwI96KEFqJINK5E2VmKLNtF1YzN3y9RoYk3V
 5odvtoFzluCmDyKgjhee9275c9n6rpX+KMNRbv5qxbbntRk=
X-Google-Smtp-Source: ACHHUZ7tOZBZGtDKk6zG0jLAj6Eob7yGGNQqT7SrglFnvA61mR8IaYOY8kNrvI8Y96PUNE5rvQfYbAdA0c1ud0IBhys=
X-Received: by 2002:a4a:2705:0:b0:545:2420:2a77 with SMTP id
 l5-20020a4a2705000000b0054524202a77mr1258116oof.6.1684531167148; Fri, 19 May
 2023 14:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-5-shashank.sharma@amd.com>
In-Reply-To: <20230424173836.1441-5-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 May 2023 17:19:16 -0400
Message-ID: <CADnq5_NxpDhaqNaYX8dpQtHV7ULOXiv8=-kf1M9vnAyhprBbkw@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] drm/amdgpu: create GFX-gen11 MQD for userqueue
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
Cc: pierre-eric.pelloux-prayer@amd.com, arvind.yadav@amd.com,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 24, 2023 at 1:39=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
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
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 25 ++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 +++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
>  3 files changed, 89 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> index 333f31efbe7b..e95fb35b0cb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -81,6 +81,14 @@ static int amdgpu_userqueue_create_gfx(struct drm_file=
 *filp, union drm_amdgpu_u
>                 goto free_queue;
>         }
>
> +       if (uq_mgr->userq_funcs[queue->queue_type]->mqd_create) {
> +               r =3D uq_mgr->userq_funcs[queue->queue_type]->mqd_create(=
uq_mgr, queue);
> +               if (r) {
> +                       DRM_ERROR("Failed to create/map userqueue MQD\n")=
;
> +                       goto free_queue;
> +               }
> +       }
> +
>         args->out.queue_id =3D queue->queue_id;
>         args->out.flags =3D 0;
>         mutex_unlock(&uq_mgr->userq_mutex);
> @@ -119,6 +127,8 @@ static void amdgpu_userqueue_destroy(struct drm_file =
*filp, int queue_id)
>         }
>
>         mutex_lock(&uq_mgr->userq_mutex);
> +       if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
> +               uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mg=
r, queue);
>         amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>         mutex_unlock(&uq_mgr->userq_mutex);
>         kfree(queue);
> @@ -149,6 +159,20 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void =
*data,
>         return r;
>  }
>
> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
> +
> +static void
> +amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +       int maj;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       uint32_t version =3D adev->ip_versions[GC_HWIP][0];
> +
> +       /* We support usermode queue only for GFX IP as of now */
> +       maj =3D IP_VERSION_MAJ(version);
> +       if (maj =3D=3D 11)
> +               uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_gfx_v11_=
funcs;

Do we need to keep function pointers in uq_mgr?  It would be nice to
keep the logic in the IPs directly.  E.g, in gfx_v11_0.c, we could set
adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_gfx_v11_funcs;
then the userq code can just check

       if (adev->userq_funcs[queue->queue_type]->mqd_destroy)
               adev->userq_funcs[queue->queue_type]->mqd_destroy(adev, queu=
e);

etc.

> +}
>
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amd=
gpu_device *adev)
>  {
> @@ -156,6 +180,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *us=
erq_mgr, struct amdgpu_devi
>         idr_init_base(&userq_mgr->userq_idr, 1);
>         userq_mgr->adev =3D adev;
>
> +       amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index a56c6e106d00..9f7b14966ac8 100644
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
> @@ -6404,3 +6405,59 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_=
block =3D
>         .rev =3D 0,
>         .funcs =3D &gfx_v11_0_ip_funcs,
>  };
> +
> +static int
> +gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_=
usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_userq_ctx_space *mqd =3D &queue->mqd;
> +       struct amdgpu_mqd *gfx_v11_mqd =3D &adev->mqds[queue->queue_type]=
;
> +       int size =3D gfx_v11_mqd->mqd_size;
> +       int r;
> +
> +       r =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_GTT,
> +                                   &mqd->obj,
> +                                   &mqd->gpu_addr,
> +                                   &mqd->cpu_ptr);
> +       if (r) {
> +               DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
> +               return r;
> +       }
> +
> +       memset(mqd->cpu_ptr, 0, size);
> +       r =3D amdgpu_bo_reserve(mqd->obj, false);
> +       if (unlikely(r !=3D 0)) {
> +               DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
> +               goto free_mqd;
> +       }
> +
> +       queue->userq_prop.use_doorbell =3D true;
> +       queue->userq_prop.mqd_gpu_addr =3D mqd->gpu_addr;
> +       r =3D gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->u=
serq_prop);
> +       amdgpu_bo_unreserve(mqd->obj);
> +       if (r) {
> +               DRM_ERROR("Failed to init MQD for queue\n");
> +               goto free_mqd;
> +       }
> +
> +       DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
> +       return 0;
> +
> +free_mqd:
> +       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
> +       return r;
> +}
> +
> +static void
> +gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu=
_usermode_queue *queue)
> +{
> +       struct amdgpu_userq_ctx_space *mqd =3D &queue->mqd;
> +
> +       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
> +}
> +
> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs =3D {
> +       .mqd_create =3D gfx_v11_userq_mqd_create,
> +       .mqd_destroy =3D gfx_v11_userq_mqd_destroy,
> +};

These functions and structures should start with gfx_v11_0_ for consistency=
.

> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index 8d8f6b3bcda5..e7da27918bd2 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -28,6 +28,12 @@
>  #include "amdgpu.h"
>  #define AMDGPU_MAX_USERQ 512
>
> +struct amdgpu_userq_ctx_space {
> +       uint64_t         gpu_addr;
> +       void             *cpu_ptr;
> +       struct amdgpu_bo *obj;
> +};
> +
>  struct amdgpu_usermode_queue {
>         int                     queue_id;
>         int                     queue_type;
> @@ -36,6 +42,7 @@ struct amdgpu_usermode_queue {
>         struct amdgpu_mqd_prop  userq_prop;
>         struct amdgpu_userq_mgr *userq_mgr;
>         struct amdgpu_vm        *vm;
> +       struct amdgpu_userq_ctx_space mqd;
>  };
>
>  struct amdgpu_userq_funcs {
> --
> 2.40.0
>
