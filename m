Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D2AC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 21:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE215112465;
	Wed,  1 May 2024 21:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BhmctVGx";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84EE6112465
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 21:30:12 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2b27eec1eb1so1649380a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 May 2024 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714599012; x=1715203812; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1jZuWnl+7B+TMQg1ghRC9epZHbpAzTT5vQlu1ju8RU=;
 b=BhmctVGxyk3IaaGauD08hE4qwD036rXbijm1+DKR2ChzU82qUl1LpbDPf0yRtzmtEd
 3BwXyrtZTb0d0oXL4wH68vFKQssmhUpfKSD5J5HVoB3vG8xgAeuJRnbuqo5soU4D7KHU
 GVixqkJGhf/BUEqtRhHUd1AZrDopsOFFPy7Umu5nEQS4CHjurXqk7xogTkcM1LbrFtRA
 rsVxhXV/WxT0KZ+M2ZlxKwVfozkwSlfc3vrm1Qp8J7WC7D/ox1ZT2OLJ9DDU1AleRzQO
 T/CVQI1nL1ss9Oz4bNXVb7jEPOP1osoostZgH2AVlWeHxRh4EmBqwFc9RTlrQ3Zbke4C
 /e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714599012; x=1715203812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1jZuWnl+7B+TMQg1ghRC9epZHbpAzTT5vQlu1ju8RU=;
 b=ZvdbUB8LqAx8+rrduYrkDJeab+aJT349cGuPUAiDPNRZPhly4o6I5EDT7pADhsQaYl
 y9JXbWzr8bmz14BrJobmtnRyd3SzLOGZPAtlHlqB8xLm6KNEJjXe14o5yrOULH33iy5r
 lPTWd0Lu7j+pbwrJ/nmQElHe7pGcDECrWqMuZPLo7g6bUzoD88Yw2NpFJBFEjn0kdI6u
 oXytBH25iAvCAgi6DhlF1NNJ7QiZkDPa9GxzGiAu04hEqTtNBMMmnEtmQKXxpigSyR6P
 fMuzeWtfZ3YY7Em8kMYZ8nuhff8KbmCcIFRD3T41vfzO482FHKK8CJigr8o6WL2T5FCV
 gzvA==
X-Gm-Message-State: AOJu0Yy3T/QP0F20ulderS+4iFVwCgQN/WifLncvd3+sbmya1uyeapCq
 70bieBOQxwRkyzWiLQ5oiWrArs6J16Sl+bbcdF0jMGSxO7T7ZxtAuxEEq6uyuowDetn19gReWeI
 f3w5H+F0xb60AGD3iVWbN5A9KnuQ=
X-Google-Smtp-Source: AGHT+IF8qtUi9iElVLK2uuedfKY+1MBtTZ0k5MZ2DYXHilIOdE4QD174tCfg6dzZI5Rt91Vx9oq0lZbum0Nxgokx0xQ=
X-Received: by 2002:a17:90b:2282:b0:2ae:6277:16a with SMTP id
 kx2-20020a17090b228200b002ae6277016amr3706818pjb.36.1714599011828; Wed, 01
 May 2024 14:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-5-shashank.sharma@amd.com>
In-Reply-To: <20240426134810.1250-5-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 May 2024 17:30:00 -0400
Message-ID: <CADnq5_M5d5-NdSRaQO4L+oQLQd-iFWOqJkk6ibg5MqT0=f+6Lw@mail.gmail.com>
Subject: Re: [PATCH v9 04/14] drm/amdgpu: add helpers to create userqueue
 object
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

On Fri, Apr 26, 2024 at 10:07=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> This patch introduces amdgpu_userqueue_object and its helper
> functions to creates and destroy this object. The helper
> functions creates/destroys a base amdgpu_bo, kmap/unmap it and
> save the respective GPU and CPU addresses in the encapsulating
> userqueue object.
>
> These helpers will be used to create/destroy userqueue MQD, WPTR
> and FW areas.
>
> V7:
> - Forked out this new patch from V11-gfx-userqueue patch to prevent
>   that patch from growing very big.
> - Using amdgpu_bo_create instead of amdgpu_bo_create_kernel in prep
>   for eviction fences (Christian)
>
> V9:
>  - Rebase
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 62 +++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    | 13 ++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> index df97b856f891..65cab0ad97a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -32,6 +32,68 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr,=
 int qid)
>         return idr_find(&uq_mgr->userq_idr, qid);
>  }
>
> +int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
> +                                  struct amdgpu_userq_obj *userq_obj,
> +                                  int size)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_bo_param bp;
> +       int r;
> +
> +       memset(&bp, 0, sizeof(bp));
> +       bp.byte_align =3D PAGE_SIZE;
> +       bp.domain =3D AMDGPU_GEM_DOMAIN_GTT;
> +       bp.flags =3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> +                  AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +       bp.type =3D ttm_bo_type_kernel;
> +       bp.size =3D size;
> +       bp.resv =3D NULL;
> +       bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);
> +
> +       r =3D amdgpu_bo_create(adev, &bp, &userq_obj->obj);
> +       if (r) {
> +               DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
> +               return r;
> +       }
> +
> +       r =3D amdgpu_bo_reserve(userq_obj->obj, true);
> +       if (r) {
> +               DRM_ERROR("Failed to reserve BO to map (%d)", r);
> +               goto free_obj;
> +       }
> +
> +       r =3D amdgpu_ttm_alloc_gart(&(userq_obj->obj)->tbo);
> +       if (r) {
> +               DRM_ERROR("Failed to alloc GART for userqueue object (%d)=
", r);
> +               goto unresv;
> +       }
> +
> +       r =3D amdgpu_bo_kmap(userq_obj->obj, &userq_obj->cpu_ptr);
> +       if (r) {
> +               DRM_ERROR("Failed to map BO for userqueue (%d)", r);
> +               goto unresv;
> +       }
> +
> +       userq_obj->gpu_addr =3D amdgpu_bo_gpu_offset(userq_obj->obj);
> +       amdgpu_bo_unreserve(userq_obj->obj);
> +       memset(userq_obj->cpu_ptr, 0, size);
> +       return 0;
> +
> +unresv:
> +       amdgpu_bo_unreserve(userq_obj->obj);
> +
> +free_obj:
> +       amdgpu_bo_unref(&userq_obj->obj);
> +       return r;
> +}
> +
> +void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
> +                                  struct amdgpu_userq_obj *userq_obj)
> +{
> +       amdgpu_bo_kunmap(userq_obj->obj);
> +       amdgpu_bo_unref(&userq_obj->obj);
> +}
> +
>  static int
>  amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>  {
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index b739274c72e1..bbd29f68b8d4 100644
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
> @@ -60,4 +67,10 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *use=
rq_mgr, struct amdgpu_devi
>
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>
> +int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
> +                                  struct amdgpu_userq_obj *userq_obj,
> +                                  int size);
> +
> +void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
> +                                    struct amdgpu_userq_obj *userq_obj);
>  #endif
> --
> 2.43.2
>
