Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882C2D609CE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 16:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 286B810E06B;
	Tue, 16 Dec 2025 16:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PR7IrQWt";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EF310E81C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 16:27:11 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7b8c7a4f214so324929b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 08:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765902430; x=1766507230; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jy0WiVhQqq/YV/7NwKwUuK3/ZIOhTp/sD3EnCujGsIQ=;
 b=PR7IrQWt7QnqxNijOE8R2nt7/yKZKStgIff8DvlLEHvIbF34k4hUhWnzYVFIMuxiLB
 P0rANxAgwA01+mgoJFslRavN1xQ33cYF2UX6X4AuuUKW+iGkXpzw4LfKW04dfIx2zpGk
 jr3Pq2dygNbZ9uNonRinu2RnlFdseAAgZJwSYx79Gj05+8UfK+43RIogQJrnWA1amFt4
 YKDQT5jF2ky5bG0Wa1YJKN5/g3T5lQphKtIh5u/guhbYinzZ80sJMCC602WAUYjn0uN5
 1CS3rrcBjdjg6o84JvjdkjEjxhgPccb8rTHCKKPySTqC7v5P9nOuWigxtCWStsonKNa0
 oC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765902430; x=1766507230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jy0WiVhQqq/YV/7NwKwUuK3/ZIOhTp/sD3EnCujGsIQ=;
 b=iYYHyqg5yLGAA/O3cFm8HpLpsGpVMgwSGvkdqy3xw5NkVTZG4wWrwGLgER7cxMb3KM
 32un22kmWZfR9AHDPq8wPmV/xrnsGXdn3c3zRCZZRGOWUPELpEaeMSfZjZaYcO6apZdk
 68LklPvZwAn8MevTpPEKTNQjyelh2WATuN5Is2cx2kRGR2jyGd0EqqcJXCFzvOFk7w5a
 fzS7BPcHWxW/2jMekrIiVHgfwdsB+FGP/sfWqeeA9eNyihf4sk1NnZlswLU8Tje6zVoa
 bJ0XIS2byrxsmXMg5uZa/BdPpI5if/K5h1KDiHp2PBg5GQkxhawxiLXlpr+a2B3v868e
 WOIw==
X-Gm-Message-State: AOJu0Yw30GaY9RDcEk2bbPOxm/F9PjAuB/i/rZg5j8usBz8jPjV1mwdW
 IxPchDAKirplM292hOsv+l9zLd8LCcSV/pNH17oLWknAwwlYfypLXSE5r0PpJvFafmsPTXdhCw9
 AoxTvSs8Kx8YuM/53T9SitM6kmMBE7Mo=
X-Gm-Gg: AY/fxX7I0hAyoJI6imVUl9j0p84ikrt0xpZi7rKhJsOKz5+QJmm/XEEnDqYmmP3i8yH
 OR1Ny9JlzLmnhztbmmB+hYAWkZ6rTdA37KILRSId/Ydm9wTL58ldxmgRL4YwV60wby6+nmq0pEb
 Gcm+yg882BBTMUU8u774V98a30kMIssqEkYD/Zf9Xj9R1jsHgCyf9O3Sttjk8XwG3Smok15+gIx
 GjiYWiAP0I6BphkqNVKo0k/gtanPAdqvFkyFM8BdYawVU1jqs5fB4lDMrMcJ+MPUiRsqk/C
X-Google-Smtp-Source: AGHT+IGhYrfkDXDBgl8btiohNHCm4r7KZBWYraZJ1zqtxBnKVJaQLZwCESjj8yItVWrPjjU6EANj2GI4oHf9UYr/PBc=
X-Received: by 2002:a05:7023:885:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-11f34c51e76mr5355918c88.6.1765902430259; Tue, 16 Dec 2025
 08:27:10 -0800 (PST)
MIME-Version: 1.0
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-11-lijo.lazar@amd.com>
In-Reply-To: <20251203130436.745633-11-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 11:26:58 -0500
X-Gm-Features: AQt7F2r_JtNLBfYTHrJD6xb46dMJr6BM1rpT3hwLLK1SuvUtag7BjdQN0asW39M
Message-ID: <CADnq5_N9J3aechATFtjrTGY0=Q58atnFk952DyjHKmuXf7nT8w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/10] drm/amdgpu: Add ioctl to set level2 handler
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Wed, Dec 3, 2025 at 8:44=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add ioctl to set tba/tma of level2 trap handler
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 105 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  11 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   2 +
>  include/uapi/drm/amdgpu_drm.h            |  24 ++++++
>  5 files changed, 141 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 1fb9539f8aca..ed50e4d6e308 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1663,7 +1663,6 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc)=
;
>  void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
>  int amdgpu_info_ioctl(struct drm_device *dev, void *data,
>                       struct drm_file *filp);
> -
>  /*
>   * functions used by amdgpu_encoder.c
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.c
> index 1b4483b5d5a7..531be17aab1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -491,3 +491,108 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
>         kfree(*trap_obj);
>         *trap_obj =3D NULL;
>  }
> +
> +static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
> +                                         struct amdgpu_vm *vm,
> +                                         struct amdgpu_cwsr_usr_addr *us=
r_addr)
> +{
> +       struct amdgpu_bo_va_mapping *va_map;
> +       uint64_t addr;
> +       uint32_t size;
> +       int r;
> +
> +       addr =3D (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PA=
GE_SHIFT;
> +       size =3D usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> +       if (r)
> +               return r;
> +
> +       va_map =3D amdgpu_vm_bo_lookup_mapping(vm, addr);
> +       if (!va_map) {
> +               r =3D -EINVAL;
> +               goto err;
> +       }
> +       /* validate whether resident in the VM mapping range */
> +       if (addr >=3D va_map->start && va_map->last - addr + 1 >=3D size)=
 {
> +               amdgpu_bo_unreserve(vm->root.bo);
> +               return 0;
> +       }
> +
> +       r =3D -EINVAL;
> +err:
> +       amdgpu_bo_unreserve(vm->root.bo);
> +
> +       return r;
> +}
> +
> +static int amdgpu_cwsr_set_l2_trap_handler(
> +       struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +       struct amdgpu_cwsr_trap_obj *cwsr_obj, struct amdgpu_cwsr_usr_add=
r *tma,
> +       struct amdgpu_cwsr_usr_addr *tba)
> +{
> +       uint64_t *l1tma;
> +       int r;
> +
> +       if (!amdgpu_cwsr_is_enabled(adev))
> +               return -EOPNOTSUPP;
> +
> +       if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
> +               return -EINVAL;
> +       r =3D amdgpu_cwsr_validate_user_addr(adev, vm, tma);
> +       if (r)
> +               return r;
> +       r =3D amdgpu_cwsr_validate_user_addr(adev, vm, tba);
> +       if (r)
> +               return r;
> +
> +       l1tma =3D (uint64_t *)(cwsr_obj->tma_cpu_addr);
> +       l1tma[0] =3D tma->addr;
> +       l1tma[1] =3D tba->addr;
> +
> +       return 0;
> +}
> +
> +/*
> + * Userspace cwsr related ioctl
> + */
> +/**
> + * amdgpu_cwsr_ioctl - Handle cwsr specific requests.
> + *
> + * @dev: drm device pointer
> + * @data: request object
> + * @filp: drm filp
> + *
> + * This function is used to perform cwsr and trap handler related operat=
ions
> + * Returns 0 on success, error code on failure.
> + */
> +int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_fil=
e *filp)
> +{
> +       struct amdgpu_device *adev =3D drm_to_adev(dev);
> +       union drm_amdgpu_cwsr *cwsr =3D data;
> +       struct amdgpu_fpriv *fpriv;
> +       int r;
> +
> +       fpriv =3D (struct amdgpu_fpriv *)filp->driver_priv;
> +
> +       if (!fpriv->cwsr_trap)
> +               return -EOPNOTSUPP;
> +
> +       switch (cwsr->in.op) {
> +       case AMDGPU_CWSR_OP_SET_L2_TRAP: {
> +               struct amdgpu_cwsr_usr_addr tba;
> +               struct amdgpu_cwsr_usr_addr tma;
> +
> +               tba.addr =3D cwsr->in.l2trap.tba;
> +               tba.size =3D cwsr->in.l2trap.tba_sz;
> +               tma.addr =3D cwsr->in.l2trap.tma;
> +               tma.size =3D cwsr->in.l2trap.tma_sz;
> +               r =3D amdgpu_cwsr_set_l2_trap_handler(
> +                       adev, &fpriv->vm, fpriv->cwsr_trap, &tma, &tba);
> +       } break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return r;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.h
> index 96b03a8ed99b..32f3f23abd79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -31,7 +31,7 @@ struct amdgpu_device;
>  struct amdgpu_vm;
>
>  /**
> - * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer trac=
king
> + * struct amdgpu_cwsr_trap_obj - CWSR (Compute Wave Save Restore) buffer=
 tracking
>   * @bo: Buffer object for CWSR area
>   * @bo_va: Buffer object virtual address mapping
>   */
> @@ -63,6 +63,11 @@ struct amdgpu_cwsr_params {
>         uint32_t cwsr_sz;
>  };
>
> +struct amdgpu_cwsr_usr_addr {
> +       uint64_t addr;
> +       uint32_t size;
> +};
> +
>  int amdgpu_cwsr_init(struct amdgpu_device *adev);
>  void amdgpu_cwsr_fini(struct amdgpu_device *adev);
>
> @@ -79,4 +84,8 @@ uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *=
adev, int num_xcc);
>  int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
>                                 struct amdgpu_cwsr_params *cwsr_params,
>                                 int num_xcc);
> +
> +int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
> +                     struct drm_file *filp);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 16adeba4d7e6..8f5fcbe48a28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -52,6 +52,7 @@
>  #include "amdgpu_sched.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_cwsr.h"
>  #include "amdgpu_userq_fence.h"
>  #include "../amdxcp/amdgpu_xcp_drv.h"
>
> @@ -3060,6 +3061,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D=
 {
>         DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
>         DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|=
DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_hand=
le_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_CWSR, amdgpu_cwsr_ioctl, DRM_AUTH|DRM_RE=
NDER_ALLOW),
>         /* KMS */
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUT=
H|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioct=
l, DRM_AUTH|DRM_RENDER_ALLOW),
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 1a27e218d4ea..f3b3c238d6d9 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -58,6 +58,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_SIGNAL                0x17
>  #define DRM_AMDGPU_USERQ_WAIT          0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
> +#define DRM_AMDGPU_CWSR 0x20
>
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -79,6 +80,8 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DR=
M_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_CWSR \
> +       DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cws=
r)
>
>  /**
>   * DOC: memory domains
> @@ -1668,6 +1671,27 @@ struct drm_amdgpu_info_cwsr {
>         __u32 min_save_area_size;
>  };
>
> +/* cwsr ioctl */
> +#define AMDGPU_CWSR_OP_SET_L2_TRAP 1
> +
> +struct drm_amdgpu_cwsr_in {
> +       /* AMDGPU_CWSR_OP_* */
> +       __u32 op;
> +       struct {
> +               /* Level 2 trap handler base address */
> +               __u64 tba;

Maybe add _va so it's clear this is a gpu virtual address.

> +               /* Level 2 trap handler buffer size */
> +               __u32 tba_sz;
> +               /* Level 2 trap memory buffer address */
> +               __u64 tma;

Same here.

Alex

> +               /* Level 2 trap memory buffer size */
> +               __u32 tma_sz;
> +       } l2trap;
> +};
> +
> +union drm_amdgpu_cwsr {
> +       struct drm_amdgpu_cwsr_in in;
> +};
>  /*
>   * Supported GPU families
>   */
> --
> 2.49.0
>
