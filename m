Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2875CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 15:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3931610EA3D;
	Fri, 19 Sep 2025 15:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ew/ByMXI";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A746910EA3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 15:24:10 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b5235737aedso198607a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758295450; x=1758900250; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9V0gvadl/KzXFcUUvAvurMTGmVEJiY1IcA5/CBzgz0=;
 b=ew/ByMXIiPOLhqlIu0Titn4aZq7airg2SuCjWX8q4U1ZCiPz66NOeYvbR01pdz3RW2
 8tKrhkTHxQxSlahtXFAPdBiRBfgWNbwKCIZxoSwpswNoHPFwOTl9mBS+gXI5ML2SRJ8e
 Yzoa57gCQqC41y1WncMb5eV5ys5fCBkKOIxtnlAj3qU2hamyPok2EgephNe/vP8nv5mA
 Ay3G7YPqA5Q6/h+aGs+ZE6eYuiVY/VE+Vjk96b8huXjV21PNgtEaHTdwyMvteSOKf/OZ
 mj6dyFESi7UADSEXTOseUYplmU0BuTkfBjtunRPD04FRZUiHwmJQ+id8duTdReiEEpLx
 NV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758295450; x=1758900250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9V0gvadl/KzXFcUUvAvurMTGmVEJiY1IcA5/CBzgz0=;
 b=aJMuTd/0/wOWa2qDJLySQEBDjo4Q0oVaP5PrNzsbPup3pmB7bfWzwe7VdKK81GWoj1
 QWbkMWFlbgmYYK/p2mel6a/DpRBB5Tl9gqx8YOVOX+nlRzsiQSgGWK0glLaHXO0fsJ/9
 ADkobrpsbdzsx6gsdIAQrgFwUoqvI8mRbn7hNNpGu4Km0YTvFojB43Ev4Nw163vCg1+g
 rc42qa937fjLSMZEtki45dPueaaBKr19ic2se6GgXtDpk4BBW8PTaNlcouIPOKyhpz23
 5q5aG5wSo+R7EmNZdjY/jCjigCUF+PVp0tpBI6kvreLmcXy7GXkPWOYc22cB16ywHSHT
 LRLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVznsHsYqeU/5+vZph+uLU8FCUIVwS8ANfYvyEChdqXqIE4rHK9qSFwrqbhuEkyWATsFpbn7q+/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5B5C7RYaQ0A1+l4jynmqLgkDWwsVVK8BzZH3yAMi2f+2LBAZQ
 2CYsNcKxb2zCKUvUvzUHykVN3Ylej27a56Lt84EMMwwuw89E7qyWG6cgFcyVmQTb+DZza+nAmGT
 eqJoBuwLu4YCBKFRUJqTQWaPmeH4YQ+A=
X-Gm-Gg: ASbGncvCL5c0G2YEWMMu2HCRrwbU8XFwXUXTOfG3nvW/xQAYpiFAaTO01YS+uCQlXMq
 FKEaYIPq/k+y4egergFBjFE1R0d49Ljy0N8ND90yObtyld9FXJ1OMuaNBrObyW6adSaU6m41Gxp
 vslrum3c7aaeKpBlSwJSUuV6n4YZ0OjwpXCKVnhg7nBIL8OQ6vxsgeufvH6vSqMxJpoVVxhZYwg
 g42bNI=
X-Google-Smtp-Source: AGHT+IFOBt/38SHTtZfyXcj7zNFb936/GoCI9dj+5gQWbjt43+esMby2oLz8fjIUMSGVi4sfZ7sUdH3Stxqlu+IaUmU=
X-Received: by 2002:a17:90b:3ec9:b0:32e:74b6:4ef9 with SMTP id
 98e67ed59e1d1-33097c32ecfmr2647355a91.0.1758295449976; Fri, 19 Sep 2025
 08:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250919122147.2538-1-christian.koenig@amd.com>
 <20250919122147.2538-2-christian.koenig@amd.com>
In-Reply-To: <20250919122147.2538-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Sep 2025 11:23:58 -0400
X-Gm-Features: AS18NWAABbh07JhqlJubypiLp3YLPX8-RGw-LttuYXBOXeHmQ1U8UdTGqXpkQqY
Message-ID: <CADnq5_P8K27d3pG7vdtfmrf5dbKfA+sxZQyUvntoAUjvwekgfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: revert "rework reserved VMID handling"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alexander.Deucher@amd.com, James.Zhu@amd.com, srinivasan.shanmugam@amd.com,
 amd-gfx@lists.freedesktop.org
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

On Fri, Sep 19, 2025 at 8:29=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> This reverts commit e44a0fe630c58b0a87d8281f5c1077a3479e5fce.
>
> Initially we used VMID reservation to enforce isolation between
> processes. That has now been replaced by proper fence handling.
>
> Both OpenGL, RADV and ROCm developers requested a way to reserve a VMID
> for SPM, so restore that approach by reverting back to only allowing a
> single process to use the reserved VMID.
>
> Only compile tested for now.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 61 ++++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 11 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 17 ++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 +-
>  4 files changed, 50 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.c
> index cbdf108612d2..e35f7525fbff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -275,13 +275,12 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_=
vm *vm,
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         unsigned vmhub =3D ring->vm_hub;
> -       struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub=
];
>         uint64_t fence_context =3D adev->fence_context + ring->idx;
>         bool needs_flush =3D vm->use_cpu_for_update;
>         uint64_t updates =3D amdgpu_vm_tlb_seq(vm);
>         int r;
>
> -       *id =3D id_mgr->reserved;
> +       *id =3D vm->reserved_vmid[vmhub];
>         if ((*id)->owner !=3D vm->immediate.fence_context ||
>             !amdgpu_vmid_compatible(*id, job) ||
>             (*id)->flushed_updates < updates ||
> @@ -474,40 +473,61 @@ bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm=
, unsigned int vmhub)
>         return vm->reserved_vmid[vmhub];
>  }
>
> -int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
> +/*
> + * amdgpu_vmid_alloc_reserved - reserve a specific VMID for this vm
> + * @adev: amdgpu device structure
> + * @vm: the VM to reserve an ID for
> + * @vmhub: the VMHUB which should be used
> + *
> + * Mostly used to have a reserved VMID for debugging and SPM.
> + *
> + * Returns: 0 for success, -EINVAL if an ID is already reserved.

I think -ENOENT or -ENOMEM make more sense.  Other than that, looks good to=
 me.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> + */
> +int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu=
_vm *vm,
>                                unsigned vmhub)
>  {
>         struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub=
];
> +       struct amdgpu_vmid *id;
> +       int r =3D 0;
>
>         mutex_lock(&id_mgr->lock);
> -
> -       ++id_mgr->reserved_use_count;
> -       if (!id_mgr->reserved) {
> -               struct amdgpu_vmid *id;
> -
> -               id =3D list_first_entry(&id_mgr->ids_lru, struct amdgpu_v=
mid,
> -                                     list);
> -               /* Remove from normal round robin handling */
> -               list_del_init(&id->list);
> -               id_mgr->reserved =3D id;
> +       if (vm->reserved_vmid[vmhub])
> +               goto unlock;
> +       if (id_mgr->reserved_vmid) {
> +               r =3D -EINVAL;
> +               goto unlock;
>         }
> -
> +       /* Remove from normal round robin handling */
> +       id =3D list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid, lis=
t);
> +       list_del_init(&id->list);
> +       vm->reserved_vmid[vmhub] =3D id;
> +       id_mgr->reserved_vmid =3D true;
>         mutex_unlock(&id_mgr->lock);
> +
>         return 0;
> +unlock:
> +       mutex_unlock(&id_mgr->lock);
> +       return r;
>  }
>
> -void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
> +/*
> + * amdgpu_vmid_free_reserved - free up a reserved VMID again
> + * @adev: amdgpu device structure
> + * @vm: the VM with the reserved ID
> + * @vmhub: the VMHUB which should be used
> + */
> +void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu=
_vm *vm,
>                                unsigned vmhub)
>  {
>         struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub=
];
>
>         mutex_lock(&id_mgr->lock);
> -       if (!--id_mgr->reserved_use_count) {
> -               /* give the reserved ID back to normal round robin */
> -               list_add(&id_mgr->reserved->list, &id_mgr->ids_lru);
> -               id_mgr->reserved =3D NULL;
> +       if (vm->reserved_vmid[vmhub]) {
> +               list_add(&vm->reserved_vmid[vmhub]->list,
> +                       &id_mgr->ids_lru);
> +               vm->reserved_vmid[vmhub] =3D NULL;
> +               id_mgr->reserved_vmid =3D false;
>         }
> -
>         mutex_unlock(&id_mgr->lock);
>  }
>
> @@ -574,7 +594,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>
>                 mutex_init(&id_mgr->lock);
>                 INIT_LIST_HEAD(&id_mgr->ids_lru);
> -               id_mgr->reserved_use_count =3D 0;
>
>                 /* for GC <10, SDMA uses MMHUB so use first_kfd_vmid for =
both GC and MM */
>                 if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, =
0, 0))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.h
> index 240fa6751260..b3649cd3af56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -67,8 +67,7 @@ struct amdgpu_vmid_mgr {
>         unsigned                num_ids;
>         struct list_head        ids_lru;
>         struct amdgpu_vmid      ids[AMDGPU_NUM_VMID];
> -       struct amdgpu_vmid      *reserved;
> -       unsigned int            reserved_use_count;
> +       bool                    reserved_vmid;
>  };
>
>  int amdgpu_pasid_alloc(unsigned int bits);
> @@ -79,10 +78,10 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>  bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>                                struct amdgpu_vmid *id);
>  bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)=
;
> -int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
> -                               unsigned vmhub);
> -void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
> -                               unsigned vmhub);
> +int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu=
_vm *vm,
> +                              unsigned vmhub);
> +void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu=
_vm *vm,
> +                              unsigned vmhub);
>  int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>                      struct amdgpu_job *job, struct dma_fence **fence);
>  void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 1f8b43253eea..108d2a838ef0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2788,10 +2788,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm)
>         dma_fence_put(vm->last_update);
>
>         for (i =3D 0; i < AMDGPU_MAX_VMHUBS; i++) {
> -               if (vm->reserved_vmid[i]) {
> -                       amdgpu_vmid_free_reserved(adev, i);
> -                       vm->reserved_vmid[i] =3D false;
> -               }
> +               amdgpu_vmid_free_reserved(adev, vm, i);
>         }
>
>         ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
> @@ -2887,6 +2884,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>         union drm_amdgpu_vm *args =3D data;
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
>         struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +       struct amdgpu_vm *vm =3D &fpriv->vm;
>
>         /* No valid flags defined yet */
>         if (args->in.flags)
> @@ -2895,17 +2893,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>         switch (args->in.op) {
>         case AMDGPU_VM_OP_RESERVE_VMID:
>                 /* We only have requirement to reserve vmid from gfxhub *=
/
> -               if (!fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
> -                       amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(0)=
);
> -                       fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)] =3D tru=
e;
> -               }
> -
> +               amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
>                 break;
>         case AMDGPU_VM_OP_UNRESERVE_VMID:
> -               if (fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
> -                       amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(0))=
;
> -                       fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)] =3D fal=
se;
> -               }
> +               amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
>                 break;
>         default:
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 829b400cb8c0..3b9d583358b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -415,7 +415,7 @@ struct amdgpu_vm {
>         struct dma_fence        *last_unlocked;
>
>         unsigned int            pasid;
> -       bool                    reserved_vmid[AMDGPU_MAX_VMHUBS];
> +       struct amdgpu_vmid      *reserved_vmid[AMDGPU_MAX_VMHUBS];
>
>         /* Flag to indicate if VM tables are updated by CPU or GPU (SDMA)=
 */
>         bool                                    use_cpu_for_update;
> --
> 2.43.0
>
