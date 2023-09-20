Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A030C00E86
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 15:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF0710E50C;
	Wed, 20 Sep 2023 15:25:22 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C243A10E50C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 15:25:19 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57af64cb99aso1934904eaf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695223519; x=1695828319; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLBdkkcc5PwsNd8EIVBvFmIDyv7RwqPj/HjIdXCb1Vw=;
 b=jyuVtbhzdIyDIkW+vdh4FYcBErHwgivDI2IKm2clc8ZGSoAIO9py4g4o/umxoYLHFJ
 0++czLPWh7psNXmtLIQhSAnc4F0BzGi7QApFpJRoc0+rgcj9OYc1ntn2CftSze4HIrE2
 vI4Gk2AjInfmhzW+ZoDWIMBE6CprTAsJHeIYeKlF2psXsWILNtBg81keJZIpIYbkR7GP
 YHUXh1Kr0GAfBU4Zhkr38lZj0UTY3SuI47/zFg0rUNjtQWBHM9J6TtLexzll1Uri05X0
 J23f7ExhXzchMkjfK8k6Tnn4DUezghs3YwwDTPbvhQLpBlUEZ7PQOx8j2Y6sgF3yr/Xz
 doaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695223519; x=1695828319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLBdkkcc5PwsNd8EIVBvFmIDyv7RwqPj/HjIdXCb1Vw=;
 b=TjTsi+43XxIZP0N9DE7pufOHWkO3dVOpWFWGFkNkFtRK+ch9X4WioAwmLuRH13YG05
 hEessu7tncR+G8PkYEHgKtSZcVXtcJUTjAqUM/duZwbqngMsLj8Y1u2ZGGo8o1KW4az7
 sLE2RX22li36HM4/AlDrdVXB2Dq952AHlvcjSI0lpQII1/dXuiNKgVuGveR0cz8PWiSC
 21/PtdhtMqJ/bZmQNbGHek3hyFUe8BicsRQhFxNRdx4k+yyi4cCoZ+TpAozF9AC12pfO
 uDbqMZLWXxgJ0pH+U4aTtkXtHnybNqm/TJ0qQeiMiLlQVPWyVqgMLdCiZ9/dC3WG1BNt
 f4Rw==
X-Gm-Message-State: AOJu0Yw6d5YUfEgdEyHRUQ488RePu5Sg2FJbqk+7Sb6kQhsWG0IOra1a
 kPuzcrDyWHxVqIGpRNmCwEFhsOVvaXxuobeF6MQNwbjO
X-Google-Smtp-Source: AGHT+IHdZu6Ol27EavjFYZECVQW/Tn25sAvM7xe1iQaWQC/SNBBtpeP2+6MJw9I3Szw+ih1v0BQGLJliwJYMTMA7wWU=
X-Received: by 2002:a05:6870:1693:b0:1bb:b9d6:a879 with SMTP id
 j19-20020a056870169300b001bbb9d6a879mr2848795oae.38.1695223518926; Wed, 20
 Sep 2023 08:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-9-shashank.sharma@amd.com>
In-Reply-To: <20230908160446.2188-9-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Sep 2023 11:25:08 -0400
Message-ID: <CADnq5_ML79WExXCw9_Kt1Fw7s3qjb5p1qbQxKT5aYDjOXKxSJw@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] drm/amdgpu: generate doorbell index for userqueue
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

On Fri, Sep 8, 2023 at 11:55=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> The userspace sends us the doorbell object and the relative doobell
> index in the object to be used for the usermode queue, but the FW
> expects the absolute doorbell index on the PCI BAR in the MQD. This
> patch adds a function to convert this relative doorbell index to
> absolute doorbell index.
>
> This patch is dependent on the doorbell manager series which is
> expected to be merged soon:
> Link: https://patchwork.freedesktop.org/series/115802/
>
> V5: Fix the db object reference leak (Christian)
> V6: Pin the doorbell bo in userqueue_create() function, and unpin it
>     in userqueue destoy (Christian)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 40 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>  3 files changed, 42 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> index 03fc8e89eafb..a311d4949bb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -32,6 +32,35 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr,=
 int qid)
>         return idr_find(&uq_mgr->userq_idr, qid);
>  }
>
> +static uint64_t
> +amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> +                                    struct amdgpu_usermode_queue *queue,
> +                                    struct drm_file *filp,
> +                                    uint32_t doorbell_offset)
> +{
> +       uint64_t index;
> +       struct drm_gem_object *gobj;
> +
> +       gobj =3D drm_gem_object_lookup(filp, queue->doorbell_handle);
> +       if (gobj =3D=3D NULL) {
> +               DRM_ERROR("Can't find GEM object for doorbell\n");
> +               return -EINVAL;
> +       }
> +
> +       queue->db_bo =3D amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
> +       drm_gem_object_put(gobj);
> +
> +       /* Pin the BO before generating the index, unpin in queue destroy=
 */
> +       if (amdgpu_bo_pin(queue->db_bo, AMDGPU_GEM_DOMAIN_DOORBELL)) {
> +               DRM_ERROR("[Usermode queues] Failed to pin doorbell objec=
t\n");
> +               return -EINVAL;
> +       }
> +
> +       index =3D amdgpu_doorbell_index_on_bar(uq_mgr->adev, queue->db_bo=
, doorbell_offset);
> +       DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=3D%lld\n", ind=
ex);
> +       return index;
> +}
> +
>  static int
>  amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>  {
> @@ -50,6 +79,8 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int que=
ue_id)
>         }
>         uq_funcs =3D uq_mgr->userq_funcs[queue->queue_type];
>         uq_funcs->mqd_destroy(uq_mgr, queue);
> +       amdgpu_bo_unpin(queue->db_bo);
> +       amdgpu_bo_unref(&queue->db_bo);
>         idr_remove(&uq_mgr->userq_idr, queue_id);
>         kfree(queue);
>
> @@ -64,6 +95,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union dr=
m_amdgpu_userq *args)
>         struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
>         const struct amdgpu_userq_funcs *uq_funcs;
>         struct amdgpu_usermode_queue *queue;
> +       uint64_t index;
>         int qid, r =3D 0;
>
>         /* Usermode queues are only supported for GFX/SDMA engines as of =
now */
> @@ -93,6 +125,14 @@ amdgpu_userqueue_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
>         queue->flags =3D args->in.flags;
>         queue->vm =3D &fpriv->vm;
>
> +       /* Convert relative doorbell offset into absolute doorbell index =
*/
> +       index =3D amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp=
, args->in.doorbell_offset);
> +       if (index =3D=3D (uint64_t)-EINVAL) {
> +               DRM_ERROR("Failed to get doorbell for queue\n");
> +               goto unlock;
> +       }
> +       queue->doorbell_index =3D index;
> +
>         r =3D uq_funcs->mqd_create(uq_mgr, &args->in, queue);
>         if (r) {
>                 DRM_ERROR("Failed to create Queue\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index c0eb622dfc37..d855df9b7b37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6660,6 +6660,7 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu=
_userq_mgr *uq_mgr,
>         userq_props.queue_size =3D mqd_user.queue_size;
>         userq_props.hqd_base_gpu_addr =3D mqd_user.queue_va;
>         userq_props.mqd_gpu_addr =3D queue->mqd.gpu_addr;
> +       userq_props.doorbell_index =3D queue->doorbell_index;
>         userq_props.use_doorbell =3D true;
>
>         r =3D mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr,=
 &userq_props);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index ae155de62560..b5600cff086e 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
>         struct amdgpu_mqd_prop  *userq_prop;
>         struct amdgpu_userq_mgr *userq_mgr;
>         struct amdgpu_vm        *vm;
> +       struct amdgpu_bo        *db_bo;
>         struct amdgpu_userq_obj mqd;
>         struct amdgpu_userq_obj fw_obj;
>  };
> --
> 2.42.0
>
