Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650DDC71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 15:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3F810E727;
	Tue, 17 Jun 2025 15:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eHrvyrso";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 121AE10E727
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 15:25:18 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-313fab41fd5so692781a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750173917; x=1750778717; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnUuBoua5ETiR0n2WBsLjRNpllOt9J7ST7N9YxSN/uw=;
 b=eHrvyrsoxzsUZhQnKCPxSU4iYRtm1QLRw+MUiTVi8MvJ5rztSmccJpnVlSzQZMHuV6
 bZREsRuwOGdp0x4QEvVSPoCgLI0N6eVKatyeylyVm0oi0IptyvSzjvJi6eOzip6XUcBw
 /QS0qVduyETqvdcewTj+sFQLhZhMHsgMdM/8lUfrFG4O2/gAdLwL3IVGlErWdrhsyB1y
 KjYVeJBeGUQuBbNrSk4/RCNNpqKVrPdDV5Dj3sLrOdaah5+WwaSjK4ZlS8bU/Ui4ell4
 ahAxYfAwTNllfiZsjgdfBwu1RRsBZdREjIN3dZ8RGQjWzuR+/J6ZarFNzXy54UyzjVcU
 Bvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750173917; x=1750778717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnUuBoua5ETiR0n2WBsLjRNpllOt9J7ST7N9YxSN/uw=;
 b=THsKulX7H4M8mQZCR9SENa2/Ati3Arg56KSxrvgrvMe5Ibk7stBdRiANTCLYHbW5B4
 xXCvYHHNYfYQWMUMAS1mW5PwjkWnoDQDJE8f+qWn229UjPQhwwxbpVvi0Q5pc8PWmjoM
 43zrep99a3ZkSBKmU/4ISxP5iHOrYmi0O9gPFbBhGRFxKGspX1SoLIzxgr9z4PswjR94
 AwCITPsS+2HHh4cQ14u+nWePDonb4Eibm59Pgpvw/bs/3CmSudNLpnKdWT8xCsshU94G
 tdwB/DsndRtYOvvART4OJk4kY65zAbEJJ5AR910YKim25coSzxznoZp3zx/bzmYj9kLh
 5QNA==
X-Gm-Message-State: AOJu0Ywtc4O5RUA2+W5zqKG3ZR0l5rsxCeVHcsYEWSaNb7NeVoDkFWFs
 rUqac3o3NWYJ6psSp31Cs8c5Ae5NqyocObdNFXso3DjgcBLwbeDrhTUvISkNCUIb4aPWRaiJMuI
 TS6uJI9eR09gWp5Tu92FBfqhShbiJAmiCR8VO
X-Gm-Gg: ASbGncv7ZbQAZWjCMq65mFD4iD22w5a5zvMTY5kbZvzFikzgPY9FhJO7pDyQpjktvTf
 HJuBxYdrX519rFw7vJwv0Dpr7mzqxclZQ8M2wzfeFEmbjYTl9TfUVKyKgNCouue7ZiIMKItRvKY
 sY7isxeWStWBrGsfX/jmPPCMNKRNBiilH1DFeYrJ8PaoWv
X-Google-Smtp-Source: AGHT+IFF3HYpvGfcCQaZZzK8/N2zZvpCXqKcYMFCHaHu+GTS7COBEuRuRJLKPJtCT9Ec3HvXw91am4KgovWPGjzMB3o=
X-Received: by 2002:a17:90b:1fcd:b0:311:e8cc:4250 with SMTP id
 98e67ed59e1d1-313f1d533d2mr7741902a91.3.1750173917385; Tue, 17 Jun 2025
 08:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
 <20250617080151.1093481-4-Prike.Liang@amd.com>
In-Reply-To: <20250617080151.1093481-4-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 11:25:05 -0400
X-Gm-Features: AX0GCFsm8fioqI7Ddp48aCCJ9nFlcusxa6AVVCWs8ldJU95AIYHwmcsz35LW8Xo
Message-ID: <CADnq5_Nc-mC-4XAN4QzKuVZJ--oRuN_HE2Xg-ds2dgaoK1eBXA@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] drm/amdgpu: validate userq buffer virtual
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

On Tue, Jun 17, 2025 at 4:27=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> It needs to validate the userq object virtual address whether
> it is validated in vm mapping.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 50 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 24 +++++++++++
>  3 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index dca0f76c9fce..db47e90b8c83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -31,6 +31,8 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
>
> +#define amdgpu_userq_va_align(va) (va & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_=
GPU_PAGE_SHIFT
> +
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
>         int i;
> @@ -44,6 +46,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
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
> +       int r;
> +
> +       user_addr =3D amdgpu_userq_va_align(addr);
> +       size =3D expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> +       if (r)
> +               return r;
> +
> +       va_map =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +       if (!va_map)
> +               goto out_err;
> +       /* Only validate the userq whether residen in the VM mapping rang=
e */

resident

> +       if (user_addr >=3D  va_map->start &&
> +                       (size !=3D 0 && user_addr + size - 1 <=3D va_map-=
>last)) {

indentation here looks off.

> +               amdgpu_bo_unreserve(vm->root.bo);
> +               return 0;
> +       }
> +
> +out_err:
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return -EINVAL;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -391,6 +423,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>                 r =3D -EINVAL;
>                 goto unlock;
>         }
> +       /* Validate the userq virtual address.*/
> +       if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va,=
 args->in.queue_size) ||
> +                       amdgpu_userq_input_va_validate(&fpriv->vm, args->=
in.rptr_va, PAGE_SIZE) ||
> +                       amdgpu_userq_input_va_validate(&fpriv->vm, args->=
in.wptr_va, PAGE_SIZE)) {

indentation here looks off.

> +               drm_file_err(uq_mgr->file, "Usermode queue input virt add=
ress is invalid\n");
> +               r =3D -EINVAL;
> +               goto unlock;
> +       }
>
>         queue =3D kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNE=
L);
>         if (!queue) {
> @@ -501,11 +541,17 @@ static int amdgpu_userq_input_args_validate(struct =
drm_device *dev,
>                 }
>
>                 if (args->in.queue_va =3D=3D AMDGPU_BO_INVALID_OFFSET ||
> -                               args->in.queue_size =3D=3D 0) {
> +                               args->in.queue_size =3D=3D 0 ||
> +                               !access_ok(u64_to_user_ptr(args->in.queue=
_va & AMDGPU_GMC_HOLE_MASK),
> +                                       args->in.queue_size)) {

indentation here looks off.

Also, the VAs are GPU virtual addresses not user virtual addresses so
I don't think this check is valid.

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

Same comment here.

>                         drm_file_err(filp, "invalidate userq queue rptr o=
r wptr\n");
>                         return -EINVAL;
>                 }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index ec040c2fd6c9..704935ca0c36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -132,4 +132,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
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
> index c6f7b613e684..6ba051bd3682 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -28,6 +28,8 @@
>
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> +#define MQD_SHADOW_BASE_SIZE      73728
> +#define MQD_FWWORKAREA_SIZE       484

These might be different across IP versions.  Might be better to query
these from gfx?  there is get_gfx_shadow_info in struct
amdgpu_gfx_funcs.

Alex

>
>  static int
>  mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
> @@ -254,6 +256,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                         goto free_mqd;
>                 }
>
> +               if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd=
->eop_va,
> +                                       max_t(u32, PAGE_SIZE, AMDGPU_GPU_=
PAGE_SIZE))) {
> +                       drm_file_err(uq_mgr->file, "EOP VA is invalid\n")=
;
> +                       r =3D -EINVAL;
> +                       goto free_mqd;
> +               }
> +
>                 userq_props->eop_gpu_addr =3D compute_mqd->eop_va;
>                 userq_props->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_N=
ORMAL;
>                 userq_props->hqd_queue_priority =3D AMDGPU_GFX_QUEUE_PRIO=
RITY_MINIMUM;
> @@ -281,6 +290,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                 userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
> +
> +               if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11=
->shadow_va,
> +                                       MQD_SHADOW_BASE_SIZE)) {
> +                       drm_file_err(uq_mgr->file, "shadow VA is invalid\=
n");
> +                       r =3D -EINVAL;
> +                       goto free_mqd;
> +               }
> +
>                 kfree(mqd_gfx_v11);
>         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {
>                 struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
> @@ -298,6 +315,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                         goto free_mqd;
>                 }
>
> +               if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v1=
1->csa_va,
> +                                       MQD_FWWORKAREA_SIZE)) {
> +                       drm_file_err(uq_mgr->file, "CSA VA is invalid\n")=
;
> +                       r =3D -EINVAL;
> +                       goto free_mqd;
> +               }
> +
>                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
>                 kfree(mqd_sdma_v11);
>         }
> --
> 2.34.1
>
