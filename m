Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF776CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 15:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E9E10E682;
	Tue, 26 Aug 2025 15:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EEGd8mQ/";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4236D10E680
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 15:00:27 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b49cf060d2bso672762a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756220427; x=1756825227; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TA5Ry5I4yfYcXSZGlkjF5RKw5fHcdlNEkgWt+doj+Kk=;
 b=EEGd8mQ/AkaojAWWAVWVvAYlPp/GMEYq/PQKbkL6YHGLML9CoXrTjo0ECNDdpxMskF
 6Jv/ycpbcZy5llIDVWLjzZz8V2Ad3RqN6pjbFzzYkL35pRZVlagT7qv10RH+NCaY+Rys
 0TYl4mesfwltVCppVNf2li/STqBidix8QD8v6VSCZXfyaxlhN0RV4B1tudCaslkHx2Wq
 mZ/6N8nOr86J70xDxGxl7MTHUcpaWZ4YQKiB/BGuboonsrjnP8rUVilHs8VlNxkYFVeq
 bOlzfRQomWSBcfKLLV211YylNUQRZAzMkoxqdjNfCJMN16MSXEDN4pvo5PZQ2w7oCWbP
 kr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756220427; x=1756825227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TA5Ry5I4yfYcXSZGlkjF5RKw5fHcdlNEkgWt+doj+Kk=;
 b=ZzYM1TTib/H4KKQvK7LaYYhEusIRjGF6pa/DR+5YuiEFhSpOPjLksFB2jCaMuccj0C
 IHzsvBbQGGsziFAaQDs1C5am/EJook877W0NzG3SAfZ0JtbVQ2jevzUPEfenXVEPMl5M
 kZat5iFhqXetQAvF/2KCLwZOOeByQwtZCQnFHah93/eGOTByxWiM5h1fe2ErgJ/VEQYh
 7fLyDTMPvpCbkq2ICFDlN+GSIlUfn+eSpXesZb259MY3Sc4Dlt7N+1mNjHv12A2cdMUj
 VjjXkzXBD8BnsgR3Q/SptY9iMbKLYKsrRTOVGlN/a4932WY/+hv1eIhJLoeW1sl208/A
 3ijg==
X-Gm-Message-State: AOJu0YxFgakCzr5p8uAbMX3XtMYowKUb7TUWJNDECjoTpCrDtCAY7TAw
 RgB9I8bJh9iHtRXm0lbGADk7kePfx5V9oth7HIyW5Zr5G7gB3ggba9pJQvHtETuDwpIIQ85wBdK
 rM0rkPe5BjtWKpJAR3+O83tJL+/ryG2E=
X-Gm-Gg: ASbGncsdFAQn3QgX63fUOvcDQ/wtWF0kDq1albmaIozyFgtYQv4go0ReuPM2nV3v+2l
 eDAhuaqaxDXSmvkQa6bi9Ko8E5pLJi97Ijw1zNFXhlZUOhUrqKRKRRLfFhfi2W4f9JLY74LMK4O
 2p9lHKZKmPC8oUgkW7u8yWXBP0MeXjY5ZrxmywkGuYYC5WgHjZtYGPGAKTVN1zglf4XGc8dmmVF
 pWpEdk=
X-Google-Smtp-Source: AGHT+IEzvghgPdQDsaT67AGblCkQpqXYTIjiIIKKUyOxnB4RiQQGUr+6qqFnmZ0PGAgjx20oiXOiaAu50PW5y+5DoZ8=
X-Received: by 2002:a17:902:d50d:b0:240:25f3:5be9 with SMTP id
 d9443c01a7336-2462ef6f3fbmr119248715ad.10.1756220424848; Tue, 26 Aug 2025
 08:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
 <20250826074646.1775241-7-Prike.Liang@amd.com>
In-Reply-To: <20250826074646.1775241-7-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 11:00:12 -0400
X-Gm-Features: Ac12FXzrX3BLOLwFNsQ_YQdOwE22PA-ReKC8Ez2pQ3eGDIguFx9NQ9GMyeFLsy4
Message-ID: <CADnq5_PsrmrqtAQCYZjPXiYFJbmGoaTvgHbRBOEkg6=LX64pew@mail.gmail.com>
Subject: Re: [PATCH v9 07/14] drm/amdgpu: validate userq buffer virtual
 address and size
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Tue, Aug 26, 2025 at 4:03=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> It needs to validate the userq object virtual address to
> determin whether it is residented in a valid vm mapping.

determine

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 41 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 ++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 ++++++++++++
>  3 files changed, 65 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index b670ca8111f3..0aeb7a96ccbf 100644
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
> +
> +out_err:
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return r;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -399,6 +431,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>                 r =3D -ENOMEM;
>                 goto unlock;
>         }
> +
> +       /* Validate the userq virtual address.*/
> +       if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va,=
 args->in.queue_size) ||
> +           amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, =
PAGE_SIZE) ||
> +           amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, =
PAGE_SIZE)) {

I think the sizes here should be AMDGPU_GPU_PAGE_SIZE rather than PAGE_SIZE

> +               queue->state =3D AMDGPU_USERQ_STATE_INVALID_ARG;
> +               kfree(queue);
> +               goto unlock;
> +       }
>         queue->doorbell_handle =3D args->in.doorbell_handle;
>         queue->queue_type =3D args->in.ip_type;
>         queue->vm =3D &fpriv->vm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 694f850d102e..0eb2a9c2e340 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -135,4 +135,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
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
> index 1457fb49a794..6e29e85bbf9f 100644
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
> @@ -247,6 +250,12 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                         goto free_mqd;
>                 }
>
> +               if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd=
->eop_va,
> +                                       max_t(u32, PAGE_SIZE, AMDGPU_GPU_=
PAGE_SIZE))) {
> +                       queue->state =3D AMDGPU_USERQ_STATE_INVALID_ARG;

Rather than setting the queue->state, just return -EINVAL.  We
shouldn't create the queue in the first place if the addresses are
invalid.

> +                       goto free_mqd;
> +               }
> +
>                 userq_props->eop_gpu_addr =3D compute_mqd->eop_va;
>                 userq_props->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_N=
ORMAL;
>                 userq_props->hqd_queue_priority =3D AMDGPU_GFX_QUEUE_PRIO=
RITY_MINIMUM;
> @@ -274,6 +283,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                 userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
> +
> +               if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11=
->shadow_va,
> +                                       shadow_info.shadow_size)) {
> +                       queue->state =3D AMDGPU_USERQ_STATE_INVALID_ARG;

Same comment here.

> +                       goto free_mqd;
> +               }
> +
>                 kfree(mqd_gfx_v11);
>         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {
>                 struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
> @@ -291,6 +307,12 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                         goto free_mqd;
>                 }
>
> +               if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v1=
1->csa_va,
> +                                       shadow_info.csa_size)) {
> +                       queue->state =3D AMDGPU_USERQ_STATE_INVALID_ARG;

and here.

Alex

> +                       goto free_mqd;
> +               }
> +
>                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
>                 kfree(mqd_sdma_v11);
>         }
> --
> 2.34.1
>
