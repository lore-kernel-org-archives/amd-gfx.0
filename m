Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE74CC5B543
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 21:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E8BF10E899;
	Fri, 30 May 2025 21:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fDO6ACct";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4823110E899
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 21:48:32 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3087a70557bso298996a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 14:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748641712; x=1749246512; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGKyJa1MalBEyZnFInxjHvkgypFrubv4Oq1q9wQa/C4=;
 b=fDO6ACctgO7lFxE8F1gEu+KO0mbKb3r6CIyVZTq0IRs0v3dIh+tnECZYhnbhGQIJyg
 Wo/2f3Q4W5GjIkdbL5XnzAn3LuGhb2Hqim5Hmin6aYw/NS+aZWmAJKb0/DR587mmyzN6
 m8073fs9wpOZY/F6TcNWnY8V3PBGJJpzSQuLfK4CrHM6oPyt9aRAYfeVLk/ienq2Zlwb
 N/BPKLR0AlJ2GhSBiuiXSscutbA0ZgROhRdBTHH4R+867n3rtWoZrakkYEw+f1LU7TAm
 5OnA5wfbseupgrPNxm5gvlgpKtipGWuAwB98aFBqttW2cNvYxmRZ2rZ/+MHEaN84ZXxm
 Gzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748641712; x=1749246512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGKyJa1MalBEyZnFInxjHvkgypFrubv4Oq1q9wQa/C4=;
 b=AWu+yLbCJdPJEa3Dl3YfC1LbO4hwkLTxTMrCAXXkJgMmP+MHfifrMkIoWULW8J5jTB
 YlPfDl8HXFAJA87fEn/x2eC9jCyPtK1pV+IEHujlEXHlXoLFwdpddwKYQp9EyqrOdcm+
 k+Su2eMAMCDz7PCSklDgLZOfrkCbm7b8IVplPDjWkLYP45YuRzhxiYS+DNDwXxnccdQt
 ldmEPm9RLr81a4c+V8cwrKPTWHVbl59FJuTPiyVY7nd6n/H5Ntgke63tsUwyyc5NzNjl
 J5PsdHm50dJ48odBt+8VBQFk+1ErzUIf5eBAN4wJhLOsZmLnLD3QkEM46Y/C/EZCgIWm
 ZCkg==
X-Gm-Message-State: AOJu0YzCYxeSjrFTj9+QjFrjaIOTx+CTEbJvl7ngWdE2PNkyM/JFhxk0
 B6x4+T0OLDgDUcL6Gx0Ya2fzHn59FcvHYvQinsRQRs8crIwIoaSTqIXSki4rPxczNC2bopQiJm4
 ld5dD+LrI7/03y2iSXDXaQsqmFD5W5T/rAz8H
X-Gm-Gg: ASbGncvVrWbxsOHL+6cMAk9B9NNsALHBjAq8OXmOsYjx3MG/vxWgZNPojjKWwZhpR4l
 tbCBD4ZPDEmr8ZyvGCRyiQ0MjaYOzBt3HALsTBrNoYvoO4icU7ToMbHCh+tajiGwzYtnSHRDMpB
 idZGYKqiXInmUPZupe1qR4/QqsE7E4Egn54A==
X-Google-Smtp-Source: AGHT+IEAuzuQegUbjzCupNRGciRhn6cMKz+NoIejEdvwT9bisRFwJczKnKA75RwdEaiaWmpsEc2qefSipavokSoJYGE=
X-Received: by 2002:a17:90b:3d8c:b0:311:c1da:3858 with SMTP id
 98e67ed59e1d1-3124d07ed8amr2261972a91.0.1748641711665; Fri, 30 May 2025
 14:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-4-Prike.Liang@amd.com>
In-Reply-To: <20250530075505.882004-4-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 May 2025 17:48:20 -0400
X-Gm-Features: AX0GCFuxx5L9rXbslaXczRtlTpdIYIrnYZI-M3OZWMRq_8L9AKvsC2eSHT0UotU
Message-ID: <CADnq5_NbvDCoFa1DCtv+xfRTpQFA3Rv-AsZipcrEwu=z8UuKRQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm/amdgpu: validate userq buffer virtual address and
 size
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Lijo.Lazar@amd.com
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

On Fri, May 30, 2025 at 3:56=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> It needs to validate the userq object virtual address whether
> it is validated in vm mapping.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 56 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 25 +++++++++-
>  3 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index f45585bd5872..32e88064bdea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -44,6 +44,41 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
evice *adev)
>         return userq_ip_mask;
>  }
>
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +                        u64 expected_size)
> +{
> +       struct amdgpu_bo_va_mapping *mapping;
> +       u64 user_addr;
> +       u64 size;
> +       int r;
> +
> +       addr &=3D AMDGPU_GMC_HOLE_MASK;
> +       user_addr =3D ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);
> +       size =3D expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> +       if (r)
> +               return r;
> +
> +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +       if (!mapping)
> +               goto out_err;
> +
> +       if (user_addr !=3D mapping->start ||
> +           (size !=3D 0 && user_addr + size - 1 !=3D mapping->last)) {
> +               pr_debug("expected size 0x%llx not equal to mapping addr =
0x%llx size 0x%llx\n",
> +                       expected_size, mapping->start << AMDGPU_GPU_PAGE_=
SHIFT,
> +                       (mapping->last - mapping->start + 1) << AMDGPU_GP=
U_PAGE_SHIFT);
> +               goto out_err;
> +       }
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return 0;
> +
> +out_err:
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return -EINVAL;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -394,6 +429,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>                 r =3D -EINVAL;
>                 goto unlock;
>         }
> +       /* Validate the userq virtual address.
> +        * TODO: Need to firgure out why the queue_size(args->in.queue_si=
ze)) doesn't match
> +        * with mesa request size. As a workaround there fix the queue_si=
ze to the 0x200000.
> +        */

We just want to validate that the queue is fully within a valid
virtual address range for a single buffer.  It doesn't matter if the
queue address is at the start.  Mesa could allocate a single buffer
for all of its user queues and then suballocate ring buffers and other
metadata out of the memory.

Alex

> +       if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va,=
 0x200000) ||
> +                       amdgpu_userq_input_va_validate(&fpriv->vm, args->=
in.rptr_va, PAGE_SIZE) ||
> +                       amdgpu_userq_input_va_validate(&fpriv->vm, args->=
in.wptr_va, PAGE_SIZE)) {
> +               drm_file_err(uq_mgr->file, "Usermode queue input virt add=
ress is invalidated\n");
> +               r =3D -EINVAL;
> +               goto unlock;
> +       }
>
>         queue =3D kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNE=
L);
>         if (!queue) {
> @@ -504,11 +550,17 @@ static int amdgpu_userq_input_args_validate(struct =
drm_device *dev,
>                 }
>
>                 if (args->in.queue_va =3D=3D AMDGPU_BO_INVALID_OFFSET ||
> -                               args->in.queue_size =3D=3D 0) {
> +                               args->in.queue_size =3D=3D 0 ||
> +                               !access_ok(u64_to_user_ptr(args->in.queue=
_va & AMDGPU_GMC_HOLE_MASK),
> +                                       args->in.queue_size)) {
>                         drm_file_err(filp, "invalidate userq queue va or =
size\n");
>                         return -EINVAL;
>                 }
> -               if (!args->in.wptr_va || !args->in.rptr_va) {
> +               if (!args->in.wptr_va || !args->in.rptr_va ||
> +                       !access_ok(u64_to_user_ptr(args->in.wptr_va & AMD=
GPU_GMC_HOLE_MASK),
> +                                               sizeof(uint64_t)) ||
> +                       !access_ok(u64_to_user_ptr(args->in.rptr_va & AMD=
GPU_GMC_HOLE_MASK),
> +                                               sizeof(uint64_t))) {
>                         drm_file_err(filp, "invalidate userq queue rptr o=
r wptr\n");
>                         return -EINVAL;
>                 }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index ec040c2fd6c9..375fba639c94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -132,4 +132,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
uct amdgpu_device *adev,
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device =
*adev,
>                                                    u32 idx);
>
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +                                       u64 expected_size);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index b46e67b179fc..4ba064e6dda0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -28,6 +28,7 @@
>
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> +#define MQD_SHADOW_BASE_SIZE      73728
>
>  static int
>  mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
> @@ -246,6 +247,19 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                         r =3D -ENOMEM;
>                         goto free_mqd;
>                 }
> +               /*
> +                * EOP VA size =3D MEC_HPD_SIZE * adev->gfx.num_compute_r=
ings.
> +                * Since the userq support newer than gfx10, so the keep =
MEC_HPD_SIZE as 2048.
> +                * TODO: It requires figuring out why the EOP VA not matc=
h with MEC_HPD_SIZE *
> +                * adev->gfx.num_compute_rings.
> +                */

The EOP size is MEC_HPD_SIZE.  We only multiply it by
adev->gfx.num_compute_rings for kernel queues because we use one
allocation for the EOP buffer for all of the kernel queues.

> +               if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd=
->eop_va,
> +                                               /*ALIGN(2048 * adev->gfx.=
num_compute_rings, PAGE_SIZE)*/
> +                                               0x200000)) {
> +                       drm_file_err(uq_mgr->file, "EOP VA is invalidated=
\n");
> +                       r =3D -EINVAL;
> +                       goto free_mqd;
> +               }
>
>                 userq_props->eop_gpu_addr =3D compute_mqd->eop_va;
>                 userq_props->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_N=
ORMAL;
> @@ -274,6 +288,15 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                 userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
> +
> +               /* TODO: Need to check the shadow WA size doesn't match w=
ith mesa request.*/
> +               if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11=
->shadow_va,
> +                                       0x200000)) {

The shadow size should >=3D the shadow size defined in struct
amdgpu_gfx_shadow_info and returned by
adev->gfx.funcs->get_gfx_shadow_info().

> +                       drm_file_err(uq_mgr->file, "shadow VA is invalida=
ted\n");
> +                       r =3D -EINVAL;
> +                       goto free_mqd;
> +               }
> +
>                 kfree(mqd_gfx_v11);
>         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {
>                 struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
> @@ -290,7 +313,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>                         r =3D -ENOMEM;
>                         goto free_mqd;
>                 }
> -
> +               /* TODO: validate the csa and check the va size as well.*=
/

See adev->gfx.funcs->get_gfx_shadow_info() here as well.

Alex

>                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
>                 kfree(mqd_sdma_v11);
>         }
> --
> 2.34.1
>
