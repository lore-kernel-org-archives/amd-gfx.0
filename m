Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE41D1F9DA
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 21:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD6310E131;
	Tue, 15 Oct 2024 21:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hWfaFdto";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5E310E131
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 21:57:00 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-a9a123f2eb3so29425666b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729029419; x=1729634219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMsHBLmljA6z86/yhWrzw4ssA52Lka8ycNc8ToXSy5Y=;
 b=hWfaFdtomNr2IcicA4tBte3v1nGX36POzelwmuSfNR3eti8P75UIZWxMF3e1tLhlaW
 8Ct9RcnRmcQ7ZCLDaTIViV5Bqkjs9frz5B4KfTPRUoayjhfC3u6wgirqhbGJ73L1f4Tf
 YBewijsY7wqa8BghMswivVQk/eogNl0LQ6W+1lZl/NI7S4AaEPljPajb38zQIsf/8LAt
 AXrRQpciMva3kiIvT/3nesNuVdtwAhYGcxXsgCD0j2XPlIasDwGx1G2JkKkjvgvlpeiw
 U3Ogb3x4lqI99x7WM/2tPpuGbXz+z6poL7CO8bIAba4i2KQeQiJdMa9NF3gMo3RXCf5w
 KOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729029419; x=1729634219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMsHBLmljA6z86/yhWrzw4ssA52Lka8ycNc8ToXSy5Y=;
 b=JBIiq8ZHSYQwCYTbohn5hH9QGXKV2pQRcKmbSfyn5LOeR5y8ohL61C4SzhBVuw2Vl5
 ahR3ERZy+x+KzyCVCBUPXA+b9ZkOkE5+1pjHGDstBtYIt1Lk1c4BFKLlGKoqgwZvpkrC
 c8RBL66SaA6g4c+lxOyNHR3rVbx4SKIoAqKPuHb7mcFNpAixMw/pF0vmUlICDK6ZS9e/
 /X0Dc1VxKTdpOsp6nSPzMBRQYQt6PXhrLtrWFIYIDzRizSwTKmRrjrIODP7q/vevZLpN
 /ZB8KDgeBlRdaULHQ9cZnwf6nXnWNayTNASwJJdsg8iJI5eeYaa7t7oLiI14V+aMoByY
 WJHg==
X-Gm-Message-State: AOJu0YwvoZYvmcupaxCi7XjHIYQX50ArdhstygKURUiwQWtMcMGsaEew
 MSYx+pwohhq9UlSBFA1WpOfJczgJ8DjY+93spMfiFZtvjXfZqEWCTvJMbA3b6LYmuDosQC4pyBy
 YejEH9Exkmt1owiZvmso5+EAz31M=
X-Google-Smtp-Source: AGHT+IGUtdrB8q3bpluoo9Kv7xkAcSZhIXuQca8v4tABF+MiJqq9D6a6u+YHp/wg0stop3DnJL+nqi5ZZg/ILeRZopU=
X-Received: by 2002:a17:907:36cd:b0:a99:4a35:2400 with SMTP id
 a640c23a62f3a-a99b9420486mr720772966b.7.1729029418813; Tue, 15 Oct 2024
 14:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
 <20241015074309.2484264-9-Arunpravin.PaneerSelvam@amd.com>
In-Reply-To: <20241015074309.2484264-9-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 15 Oct 2024 17:56:22 -0400
Message-ID: <CAAxE2A7UawQE4UtCzj-SGpmT4iLsxQ_cZuBsrPTe+uq6B8=p+g@mail.gmail.com>
Subject: Re: [PATCH v4 09/09] drm/amdgpu: Add separate array of read and write
 for BO handles
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 alexander.deucher@amd.com,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
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

On Tue, Oct 15, 2024 at 3:58=E2=80=AFAM Arunpravin Paneer Selvam
<Arunpravin.PaneerSelvam@amd.com> wrote:
>
> Drop AMDGPU_USERQ_BO_WRITE as this should not be a global option
> of the IOCTL, It should be option per buffer. Hence adding separate
> array for read and write BO handles.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 238 +++++++++++++-----
>  include/uapi/drm/amdgpu_drm.h                 |  48 ++--
>  2 files changed, 206 insertions(+), 80 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 279dece6f6d7..96091a3e9372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -386,12 +386,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *de=
v, void *data,
>         struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
>         struct amdgpu_userq_mgr *userq_mgr =3D &fpriv->userq_mgr;
>         struct drm_amdgpu_userq_signal *args =3D data;
> +       struct drm_gem_object **gobj_write =3D NULL;
> +       struct drm_gem_object **gobj_read =3D NULL;
>         struct amdgpu_usermode_queue *queue;
> -       struct drm_gem_object **gobj =3D NULL;
>         struct drm_syncobj **syncobj =3D NULL;
> +       u32 *bo_handles_write, num_write_bo_handles;
>         u32 *syncobj_handles, num_syncobj_handles;
> -       u32 *bo_handles, num_bo_handles;
> -       int r, i, entry, boentry;
> +       u32 *bo_handles_read, num_read_bo_handles;
> +       int r, i, entry, rentry, wentry;
>         struct dma_fence *fence;
>         struct drm_exec exec;
>         u64 wptr;
> @@ -417,32 +419,59 @@ int amdgpu_userq_signal_ioctl(struct drm_device *de=
v, void *data,
>                 }
>         }
>
> -       num_bo_handles =3D args->num_bo_handles;
> -       bo_handles =3D memdup_user(u64_to_user_ptr(args->bo_handles_array=
),
> -                                sizeof(u32) * num_bo_handles);
> -       if (IS_ERR(bo_handles))
> +       num_read_bo_handles =3D args->num_read_bo_handles;
> +       bo_handles_read =3D memdup_user(u64_to_user_ptr(args->bo_handles_=
read_array),
> +                                     sizeof(u32) * num_read_bo_handles);
> +       if (IS_ERR(bo_handles_read))
>                 goto free_syncobj;
>
> -       /* Array of pointers to the GEM objects */
> -       gobj =3D kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL)=
;
> -       if (!gobj) {
> +       /* Array of pointers to the GEM read objects */
> +       gobj_read =3D kmalloc_array(num_read_bo_handles, sizeof(*gobj_rea=
d), GFP_KERNEL);
> +       if (!gobj_read) {
>                 r =3D -ENOMEM;
> -               goto free_bo_handles;
> +               goto free_bo_handles_read;
>         }
>
> -       for (boentry =3D 0; boentry < num_bo_handles; boentry++) {
> -               gobj[boentry] =3D drm_gem_object_lookup(filp, bo_handles[=
boentry]);
> -               if (!gobj[boentry]) {
> +       for (rentry =3D 0; rentry < num_read_bo_handles; rentry++) {
> +               gobj_read[rentry] =3D drm_gem_object_lookup(filp, bo_hand=
les_read[rentry]);
> +               if (!gobj_read[rentry]) {
>                         r =3D -ENOENT;
> -                       goto put_gobj;
> +                       goto put_gobj_read;
>                 }
>         }
>
> -       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles)=
;
> +       num_write_bo_handles =3D args->num_write_bo_handles;
> +       bo_handles_write =3D memdup_user(u64_to_user_ptr(args->bo_handles=
_write_array),
> +                                      sizeof(u32) * num_write_bo_handles=
);
> +       if (IS_ERR(bo_handles_write))
> +               goto put_gobj_read;
> +
> +       /* Array of pointers to the GEM write objects */
> +       gobj_write =3D kmalloc_array(num_write_bo_handles, sizeof(*gobj_w=
rite), GFP_KERNEL);
> +       if (!gobj_write) {
> +               r =3D -ENOMEM;
> +               goto free_bo_handles_write;
> +       }
> +
> +       for (wentry =3D 0; wentry < num_write_bo_handles; wentry++) {
> +               gobj_write[wentry] =3D drm_gem_object_lookup(filp, bo_han=
dles_write[wentry]);
> +               if (!gobj_write[wentry]) {
> +                       r =3D -ENOENT;
> +                       goto put_gobj_write;
> +               }
> +       }
> +
> +       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +                     (num_read_bo_handles + num_write_bo_handles));
>
>         /* Lock all BOs with retry handling */
>         drm_exec_until_all_locked(&exec) {
> -               r =3D drm_exec_prepare_array(&exec, gobj, num_bo_handles,=
 1);
> +               r =3D drm_exec_prepare_array(&exec, gobj_read, num_read_b=
o_handles, 1);
> +               drm_exec_retry_on_contention(&exec);
> +               if (r)
> +                       goto exec_fini;
> +
> +               r =3D drm_exec_prepare_array(&exec, gobj_write, num_write=
_bo_handles, 1);
>                 drm_exec_retry_on_contention(&exec);
>                 if (r)
>                         goto exec_fini;
> @@ -468,13 +497,20 @@ int amdgpu_userq_signal_ioctl(struct drm_device *de=
v, void *data,
>         dma_fence_put(queue->last_fence);
>         queue->last_fence =3D dma_fence_get(fence);
>
> -       for (i =3D 0; i < num_bo_handles; i++) {
> -               if (!gobj || !gobj[i]->resv)
> +       for (i =3D 0; i < num_read_bo_handles; i++) {
> +               if (!gobj_read || !gobj_read[i]->resv)
>                         continue;
>
> -               dma_resv_add_fence(gobj[i]->resv, fence,
> -                                  dma_resv_usage_rw(args->bo_flags &
> -                                  AMDGPU_USERQ_BO_WRITE));
> +               dma_resv_add_fence(gobj_read[i]->resv, fence,
> +                                  DMA_RESV_USAGE_READ);
> +       }
> +
> +       for (i =3D 0; i < num_write_bo_handles; i++) {
> +               if (!gobj_write || !gobj_write[i]->resv)
> +                       continue;
> +
> +               dma_resv_add_fence(gobj_read[i]->resv, fence,
> +                                  DMA_RESV_USAGE_WRITE);
>         }
>
>         /* Add the created fence to syncobj/BO's */
> @@ -486,12 +522,18 @@ int amdgpu_userq_signal_ioctl(struct drm_device *de=
v, void *data,
>
>  exec_fini:
>         drm_exec_fini(&exec);
> -put_gobj:
> -       while (boentry-- > 0)
> -               drm_gem_object_put(gobj[boentry]);
> -       kfree(gobj);
> -free_bo_handles:
> -       kfree(bo_handles);
> +put_gobj_write:
> +       while (wentry-- > 0)
> +               drm_gem_object_put(gobj_write[wentry]);
> +       kfree(gobj_write);
> +free_bo_handles_write:
> +       kfree(bo_handles_write);
> +put_gobj_read:
> +       while (rentry-- > 0)
> +               drm_gem_object_put(gobj_read[rentry]);
> +       kfree(gobj_read);
> +free_bo_handles_read:
> +       kfree(bo_handles_read);
>  free_syncobj:
>         while (entry-- > 0)
>                 if (syncobj[entry])
> @@ -506,28 +548,35 @@ int amdgpu_userq_signal_ioctl(struct drm_device *de=
v, void *data,
>  int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>                             struct drm_file *filp)
>  {
> -       u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_ha=
ndles;
> -       u32 num_syncobj, num_bo_handles, num_points;
> +       u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_ha=
ndles_read, *bo_handles_write;
> +       u32 num_syncobj, num_read_bo_handles, num_write_bo_handles, num_p=
oints;
>         struct drm_amdgpu_userq_fence_info *fence_info =3D NULL;
>         struct drm_amdgpu_userq_wait *wait_info =3D data;
> +       struct drm_gem_object **gobj_write;
> +       struct drm_gem_object **gobj_read;
>         struct dma_fence **fences =3D NULL;
> -       struct drm_gem_object **gobj;
> +       int r, i, rentry, wentry, cnt;
>         struct drm_exec exec;
> -       int r, i, entry, cnt;
>         u64 num_fences =3D 0;
>
> -       num_bo_handles =3D wait_info->num_bo_handles;
> -       bo_handles =3D memdup_user(u64_to_user_ptr(wait_info->bo_handles_=
array),
> -                                sizeof(u32) * num_bo_handles);
> -       if (IS_ERR(bo_handles))
> -               return PTR_ERR(bo_handles);
> +       num_read_bo_handles =3D wait_info->num_read_bo_handles;
> +       bo_handles_read =3D memdup_user(u64_to_user_ptr(wait_info->bo_han=
dles_read_array),
> +                                     sizeof(u32) * num_read_bo_handles);
> +       if (IS_ERR(bo_handles_read))
> +               return PTR_ERR(bo_handles_read);
> +
> +       num_write_bo_handles =3D wait_info->num_write_bo_handles;
> +       bo_handles_write =3D memdup_user(u64_to_user_ptr(wait_info->bo_ha=
ndles_write_array),
> +                                      sizeof(u32) * num_write_bo_handles=
);
> +       if (IS_ERR(bo_handles_write))
> +               goto free_bo_handles_read;
>
>         num_syncobj =3D wait_info->num_syncobj_handles;
>         syncobj_handles =3D memdup_user(u64_to_user_ptr(wait_info->syncob=
j_handles_array),
>                                       sizeof(u32) * num_syncobj);
>         if (IS_ERR(syncobj_handles)) {
>                 r =3D PTR_ERR(syncobj_handles);
> -               goto free_bo_handles;
> +               goto free_bo_handles_write;
>         }
>
>         num_points =3D wait_info->num_points;
> @@ -545,29 +594,51 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev,=
 void *data,
>                 goto free_timeline_handles;
>         }
>
> -       gobj =3D kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL)=
;
> -       if (!gobj) {
> +       gobj_read =3D kmalloc_array(num_read_bo_handles, sizeof(*gobj_rea=
d), GFP_KERNEL);
> +       if (!gobj_read) {
>                 r =3D -ENOMEM;
>                 goto free_timeline_points;
>         }
>
> -       for (entry =3D 0; entry < num_bo_handles; entry++) {
> -               gobj[entry] =3D drm_gem_object_lookup(filp, bo_handles[en=
try]);
> -               if (!gobj[entry]) {
> +       for (rentry =3D 0; rentry < num_read_bo_handles; rentry++) {
> +               gobj_read[rentry] =3D drm_gem_object_lookup(filp, bo_hand=
les_read[rentry]);
> +               if (!gobj_read[rentry]) {
> +                       r =3D -ENOENT;
> +                       goto put_gobj_read;
> +               }
> +       }
> +
> +       gobj_write =3D kmalloc_array(num_write_bo_handles, sizeof(*gobj_w=
rite), GFP_KERNEL);
> +       if (!gobj_write) {
> +               r =3D -ENOMEM;
> +               goto put_gobj_read;
> +       }
> +
> +       for (wentry =3D 0; wentry < num_write_bo_handles; wentry++) {
> +               gobj_write[wentry] =3D drm_gem_object_lookup(filp, bo_han=
dles_write[wentry]);
> +               if (!gobj_write[wentry]) {
>                         r =3D -ENOENT;
> -                       goto put_gobj;
> +                       goto put_gobj_write;
>                 }
>         }
>
> -       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles)=
;
> +       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +                     (num_read_bo_handles + num_write_bo_handles));
>
>         /* Lock all BOs with retry handling */
>         drm_exec_until_all_locked(&exec) {
> -               r =3D drm_exec_prepare_array(&exec, gobj, num_bo_handles,=
 0);
> +               r =3D drm_exec_prepare_array(&exec, gobj_read, num_read_b=
o_handles, 0);
> +               drm_exec_retry_on_contention(&exec);
> +               if (r) {
> +                       drm_exec_fini(&exec);
> +                       goto put_gobj_write;
> +               }
> +
> +               r =3D drm_exec_prepare_array(&exec, gobj_write, num_write=
_bo_handles, 0);
>                 drm_exec_retry_on_contention(&exec);
>                 if (r) {
>                         drm_exec_fini(&exec);
> -                       goto put_gobj;
> +                       goto put_gobj_write;
>                 }
>         }
>
> @@ -608,13 +679,21 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev,=
 void *data,
>                 }
>
>                 /* Count GEM objects fence */
> -               for (i =3D 0; i < num_bo_handles; i++) {
> +               for (i =3D 0; i < num_read_bo_handles; i++) {
>                         struct dma_resv_iter resv_cursor;
>                         struct dma_fence *fence;
>
> -                       dma_resv_for_each_fence(&resv_cursor, gobj[i]->re=
sv,
> -                                               dma_resv_usage_rw(wait_in=
fo->bo_wait_flags &
> -                                               AMDGPU_USERQ_BO_WRITE), f=
ence)
> +                       dma_resv_for_each_fence(&resv_cursor, gobj_read[i=
]->resv,
> +                                               DMA_RESV_USAGE_READ, fenc=
e)
> +                               num_fences++;
> +               }
> +
> +               for (i =3D 0; i < num_write_bo_handles; i++) {
> +                       struct dma_resv_iter resv_cursor;
> +                       struct dma_fence *fence;
> +
> +                       dma_resv_for_each_fence(&resv_cursor, gobj_write[=
i]->resv,
> +                                               DMA_RESV_USAGE_WRITE, fen=
ce)
>                                 num_fences++;
>                 }
>
> @@ -640,14 +719,30 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev,=
 void *data,
>                         goto free_fence_info;
>                 }
>
> -               /* Retrieve GEM objects fence */
> -               for (i =3D 0; i < num_bo_handles; i++) {
> +               /* Retrieve GEM read objects fence */
> +               for (i =3D 0; i < num_read_bo_handles; i++) {
>                         struct dma_resv_iter resv_cursor;
>                         struct dma_fence *fence;
>
> -                       dma_resv_for_each_fence(&resv_cursor, gobj[i]->re=
sv,
> -                                               dma_resv_usage_rw(wait_in=
fo->bo_wait_flags &
> -                                               AMDGPU_USERQ_BO_WRITE), f=
ence) {
> +                       dma_resv_for_each_fence(&resv_cursor, gobj_read[i=
]->resv,
> +                                               DMA_RESV_USAGE_READ, fenc=
e) {
> +                               if (WARN_ON_ONCE(num_fences >=3D wait_inf=
o->num_fences)) {
> +                                       r =3D -EINVAL;
> +                                       goto free_fences;
> +                               }
> +
> +                               fences[num_fences++] =3D fence;
> +                               dma_fence_get(fence);
> +                       }
> +               }
> +
> +               /* Retrieve GEM write objects fence */
> +               for (i =3D 0; i < num_write_bo_handles; i++) {
> +                       struct dma_resv_iter resv_cursor;
> +                       struct dma_fence *fence;
> +
> +                       dma_resv_for_each_fence(&resv_cursor, gobj_write[=
i]->resv,
> +                                               DMA_RESV_USAGE_WRITE, fen=
ce) {
>                                 if (WARN_ON_ONCE(num_fences >=3D wait_inf=
o->num_fences)) {
>                                         r =3D -EINVAL;
>                                         goto free_fences;
> @@ -763,14 +858,19 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev,=
 void *data,
>         }
>
>         drm_exec_fini(&exec);
> -       for (i =3D 0; i < num_bo_handles; i++)
> -               drm_gem_object_put(gobj[i]);
> -       kfree(gobj);
> +       for (i =3D 0; i < num_read_bo_handles; i++)
> +               drm_gem_object_put(gobj_read[i]);
> +       kfree(gobj_read);
> +
> +       for (i =3D 0; i < num_write_bo_handles; i++)
> +               drm_gem_object_put(gobj_write[i]);
> +       kfree(gobj_write);
>
>         kfree(timeline_points);
>         kfree(timeline_handles);
>         kfree(syncobj_handles);
> -       kfree(bo_handles);
> +       kfree(bo_handles_write);
> +       kfree(bo_handles_read);
>
>         return 0;
>
> @@ -782,18 +882,24 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev,=
 void *data,
>         kfree(fence_info);
>  exec_fini:
>         drm_exec_fini(&exec);
> -put_gobj:
> -       while (entry-- > 0)
> -               drm_gem_object_put(gobj[entry]);
> -       kfree(gobj);
> +put_gobj_write:
> +       while (wentry-- > 0)
> +               drm_gem_object_put(gobj_write[wentry]);
> +       kfree(gobj_write);
> +put_gobj_read:
> +       while (rentry-- > 0)
> +               drm_gem_object_put(gobj_read[rentry]);
> +       kfree(gobj_read);
>  free_timeline_points:
>         kfree(timeline_points);
>  free_timeline_handles:
>         kfree(timeline_handles);
>  free_syncobj_handles:
>         kfree(syncobj_handles);
> -free_bo_handles:
> -       kfree(bo_handles);
> +free_bo_handles_write:
> +       kfree(bo_handles_write);
> +free_bo_handles_read:
> +       kfree(bo_handles_read);
>
>         return r;
>  }
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index eeb345ddbf57..8d21e765094b 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -443,9 +443,6 @@ struct drm_amdgpu_userq_mqd_compute_gfx_v11 {
>         __u64   eop_va;
>  };
>
> -/* dma_resv usage flag */
> -#define AMDGPU_USERQ_BO_WRITE  1
> -
>  /* userq signal/wait ioctl */
>  struct drm_amdgpu_userq_signal {
>         /**
> @@ -475,20 +472,32 @@ struct drm_amdgpu_userq_signal {
>          */
>         __u64   syncobj_point;
>         /**
> -        * @bo_handles_array: An array of GEM BO handles used by the user=
q fence creation
> -        * IOCTL to install the created dma_fence object which can be uti=
lized by
> +        * @bo_handles_read_array: An array of GEM read BO handles used b=
y the userq fence
> +        * creation IOCTL to install the created dma_fence object which c=
an be utilized by
> +        * userspace to synchronize the BO usage between user processes.

This should just say: The list of BO handles that the submitted user
queue job is using for read only. This will update BO fences in the
kernel.

Internal kernel details shouldn't be here. This file should only
document the observed behavior, not the implementation. This applies
to all comments in this file.

Similar for the BO handles write array.

Marek

> +        */
> +       __u64   bo_handles_read_array;
> +       /**
> +        * @bo_handles_write_array: An array of GEM write BO handles used=
 by the userq fence
> +        * creation IOCTL to install the created dma_fence object which c=
an be utilized by
>          * userspace to synchronize the BO usage between user processes.
>          */
> -       __u64   bo_handles_array;
> +       __u64   bo_handles_write_array;
> +       /**
> +        * @num_read_bo_handles: A count that represents the number of GE=
M read BO handles in
> +        * @bo_handles_read_array.
> +        */
> +       __u32   num_read_bo_handles;
>         /**
> -        * @num_bo_handles: A count that represents the number of GEM BO =
handles in
> -        * @bo_handles_array.
> +        * @num_write_bo_handles: A count that represents the number of G=
EM write BO handles in
> +        * @bo_handles_write_array.
>          */
> -       __u32   num_bo_handles;
> +       __u32   num_write_bo_handles;
>         /**
>          * @bo_flags: flags to indicate BOs synchronize for READ or WRITE
>          */
>         __u32   bo_flags;
> +       __u32   pad;
>  };
>
>  struct drm_amdgpu_userq_fence_info {
> @@ -542,20 +551,31 @@ struct drm_amdgpu_userq_wait {
>          */
>         __u64   syncobj_timeline_points;
>         /**
> -        * @bo_handles_array: An array of GEM BO handles defined to fetch=
 the fence
> +        * @bo_handles_read_array: An array of GEM read BO handles define=
d to fetch the fence
>          * wait information of every BO handles in the array.
>          */
> -       __u64   bo_handles_array;
> +       __u64   bo_handles_read_array;
> +       /**
> +        * @bo_handles_write_array: An array of GEM write BO handles defi=
ned to fetch the fence
> +        * wait information of every BO handles in the array.
> +        */
> +       __u64   bo_handles_write_array;
>         /**
>          * @num_syncobj_handles: A count that represents the number of sy=
ncobj handles in
>          * @syncobj_handles_array.
>          */
>         __u32   num_syncobj_handles;
>         /**
> -        * @num_bo_handles: A count that represents the number of GEM BO =
handles in
> -        * @bo_handles_array.
> +        * @num_read_bo_handles: A count that represents the number of GE=
M BO handles in
> +        * @bo_handles_read_array.
> +        */
> +       __u32   num_read_bo_handles;
> +       /**
> +        * @num_write_bo_handles: A count that represents the number of G=
EM BO handles in
> +        * @bo_handles_write_array.
>          */
> -       __u32   num_bo_handles;
> +       __u32   num_write_bo_handles;
> +       __u32   pad;
>         /**
>          * @userq_fence_info: An array of fence information (va and value=
) pair of each
>          * objects stored in @syncobj_handles_array and @bo_handles_array=
.
> --
> 2.34.1
>
