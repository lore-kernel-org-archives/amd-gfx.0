Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD0DCAC582
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 21:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7240F10E5F0;
	Mon,  8 Sep 2025 21:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R+vwldTQ";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9598D10E5F0
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 21:51:34 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-248e01cd834so11051595ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 14:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757368294; x=1757973094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47gHsRx0IUu70WJKGk9U9/H9PziTDU5b5dnzjlOTnPc=;
 b=R+vwldTQC6ipQy9tTLT+p9XCIJEhRRgLIFSX7pz3aAJyxeFxIvGLpljI0/B2laxfMf
 QFYh5Owjd5FXtSldm1PJiA/Dl+XMbrvBmth0EmB1jPpOj46EvQNvKpvYIDabe2+jQVeC
 EA6WiMAcjdQzoMsYwf0eutM+aaW3VttOpIuxDefSYZOY+j08DI+t6ZaO07tm3jQHnGN8
 /QeUq/IIwK5jT4xFphXkgZjtmUgv7dgThoIjfWZSOi05YZACKeN1JGL933Wtou10BtDZ
 AiNXQew7jYVwi1tfo6bPTBGFa+96RIDYt1wHncJSb5xFxtCDfHBsUoXYY4N65xuA93MK
 TZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757368294; x=1757973094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47gHsRx0IUu70WJKGk9U9/H9PziTDU5b5dnzjlOTnPc=;
 b=GjAytQPgYRyEJ/Xwxy89/XNA5McA0ZiQ+F415WTA38htoCCHs7U+fS0s4xfmNbeAGO
 Ft+5X8ays8wA3QMSmpuVppp47N8eTHX2bC79nu/OWxRb1CKcarQTr36XUOV/macpfFqH
 ze0x1wVTGcFpz5wm0PJSR5g+f1l4+6tePuTVgaLdQeU8EvZkSPfNr+IuRGGjBbh9OJFl
 Fgtafo3Oz1/5ZWEYtMQmqi5+c5Pa1w/HWY2x6TbvawUx0WcGme0mPvwGWvfjEwjYjzPU
 fV227IetIgbJua+RRoM5J3OWn1LJ0bPjsO41T6NSu7ffQOSqPDP2uV5mMjI4KMGCBvik
 aFZw==
X-Gm-Message-State: AOJu0YxEebiTwtcIH6tRPwXm80iyPd/FYKnqDu4e6r1z4X4BLpOPWHmR
 g37MXF4iruOTta5RoN9upTu9HR3GelPkvYP02YqI21F3ANSAjPrlq5+Wx1155S68mklU0gmCu5t
 8vYSJecxu4A0p+aoMrL6JOMoeH1/NPx4=
X-Gm-Gg: ASbGncunohifuqm7FtfxUhm6xx9rbToRdjEdKBIG41slFoH2uEOd4bBWi5ELDxuSeK8
 hRLLdFhsh8vPwQeaTkPj/06//IJHxKWisfos+R3riZlzF9fwJuvV//yMXAV38ciBXMP65I9pRKA
 boKdSjpmpD5gjeir5BoMSiQEJAbRIkgmlA+Z6B07tKIyHqdpu9zEHvHnCqjdHI9RsYZXWycW3mH
 XdOYno=
X-Google-Smtp-Source: AGHT+IHEQN0E90W4u3uH8ilY3OvEXHRGn/8SMWzPo92Wr7bJueRztPxxek9/OuRbNlSd5UKfK0mgjusZhWY4oRD0Ox0=
X-Received: by 2002:a17:902:f54d:b0:24c:e213:ca4a with SMTP id
 d9443c01a7336-2516ed66d7amr75397745ad.2.1757368293992; Mon, 08 Sep 2025
 14:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
 <20250908084846.1873894-7-Prike.Liang@amd.com>
In-Reply-To: <20250908084846.1873894-7-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Sep 2025 17:51:22 -0400
X-Gm-Features: Ac12FXyvDWeU1pM0P458Qgn_6rO_xFROtNIXF-dGxdiUHBmKumNmBHw71JVs-4s
Message-ID: <CADnq5_NCi50X93ZctrzJH+Mf5DBUtZ6GY+pr4a6jcFdazbjKQQ@mail.gmail.com>
Subject: Re: [PATCH v10 07/14] drm/amdgpu: validate userq buffer virtual
 address and size
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com
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

On Mon, Sep 8, 2025 at 4:59=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> wr=
ote:
>
> It needs to validate the userq object virtual address to
> determine whether it is residented in a valid vm mapping.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 40 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 ++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 16 +++++++++
>  3 files changed, 58 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 8cdb1880315b..739135c3f450 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -44,6 +44,38 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
evice *adev)
>         return userq_ip_mask;
>  }
>
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +                               u64 expected_size)
> +{
> +       struct amdgpu_bo_va_mapping *va_map;
> +       u64 user_addr;
> +       u64 size;
> +       int r =3D 0;
> +
> +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SH=
IFT;
> +       size =3D expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> +       if (r)
> +               return r;
> +
> +       va_map =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +       if (!va_map) {
> +               r =3D -EINVAL;
> +               goto out_err;
> +       }
> +       /* Only validate the userq whether resident in the VM mapping ran=
ge */
> +       if (user_addr >=3D va_map->start  &&
> +           va_map->last - user_addr + 1 >=3D size) {
> +               amdgpu_bo_unreserve(vm->root.bo);
> +               return 0;
> +       }

This is where we should set the bo_va critical buffer flag.

Alex

> +
> +out_err:
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return r;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -399,6 +431,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>                 r =3D -ENOMEM;
>                 goto unlock;
>         }
> +
> +       /* Validate the userq virtual address.*/
> +       if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va,=
 args->in.queue_size) ||
> +           amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, =
AMDGPU_GPU_PAGE_SIZE ) ||
> +           amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, =
AMDGPU_GPU_PAGE_SIZE)) {
> +               kfree(queue);
> +               goto unlock;
> +       }
>         queue->doorbell_handle =3D args->in.doorbell_handle;
>         queue->queue_type =3D args->in.ip_type;
>         queue->vm =3D &fpriv->vm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 743f08c9bd71..46e927df67c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -134,4 +134,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
uct amdgpu_device *adev,
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device =
*adev,
>                                                    u32 idx);
>
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +                       u64 expected_size);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 1457fb49a794..3bf328eb7b69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>         struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_ty=
pe];
>         struct drm_amdgpu_userq_in *mqd_user =3D args_in;
>         struct amdgpu_mqd_prop *userq_props;
> +       struct amdgpu_gfx_shadow_info shadow_info;
>         int r;
>
>         /* Structure to initialize MQD for userqueue using generic MQD in=
it function */
> @@ -231,6 +232,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>         userq_props->doorbell_index =3D queue->doorbell_index;
>         userq_props->fence_address =3D queue->fence_drv->gpu_addr;
>
> +       if (adev->gfx.funcs->get_gfx_shadow_info)
> +               adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, =
true);
>         if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>                 struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
>
> @@ -247,6 +250,10 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                         goto free_mqd;
>                 }
>
> +               if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd=
->eop_va,
> +                                       max_t(u32, PAGE_SIZE, AMDGPU_GPU_=
PAGE_SIZE)))
> +                       goto free_mqd;
> +
>                 userq_props->eop_gpu_addr =3D compute_mqd->eop_va;
>                 userq_props->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_N=
ORMAL;
>                 userq_props->hqd_queue_priority =3D AMDGPU_GFX_QUEUE_PRIO=
RITY_MINIMUM;
> @@ -274,6 +281,11 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                 userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
> +
> +               if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11=
->shadow_va,
> +                                       shadow_info.shadow_size))
> +                       goto free_mqd;
> +
>                 kfree(mqd_gfx_v11);
>         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {
>                 struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
> @@ -291,6 +303,10 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                         goto free_mqd;
>                 }
>
> +               if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v1=
1->csa_va,
> +                                       shadow_info.csa_size))
> +                       goto free_mqd;
> +
>                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
>                 kfree(mqd_sdma_v11);
>         }
> --
> 2.34.1
>
