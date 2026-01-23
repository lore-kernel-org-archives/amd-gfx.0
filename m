Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344E0D778AF
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 20:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29D310EBE1;
	Fri, 23 Jan 2026 20:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Spye1Ufz";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1725310EBDB
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 20:52:38 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1233bc11279so198492c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 12:52:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769201557; cv=none;
 d=google.com; s=arc-20240605;
 b=VbFoQI+9odpFwCFMtNQhIZTQXDXksahqf2Gd0HRKPIE/YrOlEyKY/PIifeLDGz2zfy
 TXh2cg6eCnPQ75JwCTVaZGaqP1bF8GSafy2OstAr0paCT0dGC49zpJhF6Jkhaxf6hpe9
 Oq73iAqubNDF+6FTgyfnrg4jwBkNvcDI5wNipAoh+E68oL0AsCq9jQOefFVb+S49bgmJ
 YZqbfeTlbZucMSdjrGO2XBmyskX4YEbXfYR5FGncMvOmrZGvioCcfMI7o2Iiy6x9Vs4d
 5kE+UUGBJBlIZlxDXkF+c9EdNB0nLlUM7qgTu00H8L7tSTT5GTHYjIAM1oyA5TMQe12Q
 XJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fdrcmx2ndUalJ1SaHYd28RXoNb4OgEdPq8v5RcuVaJE=;
 fh=hY26Edfw5zSfQ7k5ViI2NrfnfaMcpj1z2TiRTG9Zwhg=;
 b=DtNkTFpeVq14M9MnAbhZLgmbJ/tP6fzlQcU/LXqdvipD4UKAETZtQnkpYBGALuAkX2
 aRUrZdA/Ts7NQQ94mPYbMlu+VXTeGsy+OmdV/C+np2VeaMIqc4kO1JjZ5OYgt3BCIlgV
 tev1eHXPeP0qg6Wy5M8eGhocMoW6lvFWhSrGmCnnXztQf5+LTtZFmsSLt+xGe0bv8TrX
 bYLTa1OF0LFrRLRpzZuS9LvceU3gIeSaeYcK8L2ox2qN28/ypOXLrUlS1eKpT29fTn4T
 i69chB78Na5Illxah7V1OKYLfDR0Rt7ZVp9odX74MOWooYDyH48Dtu67gMLYID0goPJw
 C/BQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769201557; x=1769806357; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdrcmx2ndUalJ1SaHYd28RXoNb4OgEdPq8v5RcuVaJE=;
 b=Spye1UfzPqbXBkImckUs2ft8c2CcQ2BV5laKQFY+cm7JO+fOA6k0aqY5u9m1NKTSm6
 U5AK/U+zdhXqcQBIsVj/3BIJ6k3LSI49fGQuj9YQaQm0VAEH0xw3t4V7ZPxARovom2B7
 c5AL/iqVfvh2peC6mULZ0P33S6WshShxSRbSXw7qskGud04Fm8CblK7rXY0mQB0F65ve
 DMH57p5L1Z1ttpQE+EovIVabC7md06GXsroWDyhp14PYCSdUa74+1pnhfpLw4pIQ2Nrn
 YkjZCgOqmlc3wit1ZIeXDuH+yWObY0B3hdWFD0kYAsziiAYSxH/R7/onjCxrmwhNbIYK
 29Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769201557; x=1769806357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fdrcmx2ndUalJ1SaHYd28RXoNb4OgEdPq8v5RcuVaJE=;
 b=IzgbTzfXmtMAJPbvPMLkHJjok8FB5NlQtlaowpQN/PgFz1oVQdn91aQcn+tof09XiT
 VcPujXqlL4iCi8MItM067sv0CjaKLLztgmckc1ncd2vj/+UfcHChc0fKjw3mIbigmEYJ
 IYDnrYTM9giXfNkBSce/Ogqb2hInRfhjoZL1He+l7gYBe+ApXXAA8vFvqTasOShbxuZR
 FdyhdQflEQpUQGFFr/KVJENPWTHQgQRv+DaSXbe4NKujAka9RomsJgpkuaujPubn++1p
 heNN5vJfOlxGWea9E9rDxL+JteW/S+i4MMC9k9EhHpUodcz88P4RAO1UK8w72QaB0Dcc
 f4XQ==
X-Gm-Message-State: AOJu0YwzzbL3vj6WBpC5LWyx2dcH8di2WqmItDQMS8Q/y9Zwkwu2d3HS
 heQMlY2aU6YfmE0QPaSkSgT02JcsMEM13n+/4LiKONSjT/ewKwHxOl+0trT9xhuoP0C/gwcVaLQ
 podmrWOkCq1A501Y9QPfjmDnqLApc1FQ=
X-Gm-Gg: AZuq6aK4C9dJAdXJSTs53Vv8tTk8mXt7M7BLhFPHn/rKcwqhEfSe0of0w8Z3Mg/6iTC
 OHmMKnQwH3zpNJJlNc6OeW57dbYrwBusvYB4iYTN/skDzynrfYAeG9sL1u/cxyHGSaktMAp8bii
 kIPh1JYgRQ2lO+DefLE3E3Uu8fScNRjm4ZAWLBpdB6sV+1rFb/pJPkKD3dSD/mQ7rnimr6Og8NK
 7IOG5rukyJ2bbGMPbONiDZGNq5L9sP5Unfv4aO2R3Lj6X+/ssh2a4qzrouvb37JcLC2KF6a
X-Received: by 2002:a05:7022:1589:b0:11e:3e9:3e9c with SMTP id
 a92af1059eb24-124856d2a60mr160190c88.7.1769201557315; Fri, 23 Jan 2026
 12:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-11-lijo.lazar@amd.com>
In-Reply-To: <20260122104118.1682154-11-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 15:52:23 -0500
X-Gm-Features: AZwV_Qg7Hme5hRrBz83ax0_6pXvhn2wsTsObJ_qOpFaf0qVqR26eeGsjlVCodaU
Message-ID: <CADnq5_PMLVg-nXuO6ZN2R9nERiiP3KMRdBXrqAT=YKv5rM=-3w@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] drm/amdgpu: Add ioctl to set level2 handler
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

On Thu, Jan 22, 2026 at 6:02=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add ioctl to set tba/tma of level2 trap handler
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

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
> index 26b757c95579..c3dfd84c2962 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1575,7 +1575,6 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc)=
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
> index 32d9398cd1d1..70f444afece0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -510,3 +510,108 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, s=
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
> +               tba.addr =3D cwsr->in.l2trap.tba_va;
> +               tba.size =3D cwsr->in.l2trap.tba_sz;
> +               tma.addr =3D cwsr->in.l2trap.tma_va;
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
> index b54240d40a6c..c9f61e393fde 100644
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
> @@ -85,4 +90,8 @@ static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu=
_device *adev)
>
>         return gc_ver >=3D IP_VERSION(11, 0, 0) && gc_ver <=3D IP_VERSION=
(11, 0, 3);
>  }
> +
> +int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
> +                     struct drm_file *filp);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 771c89c84608..7fbd106fff8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -53,6 +53,7 @@
>  #include "amdgpu_sched.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_cwsr.h"
>  #include "amdgpu_userq_fence.h"
>  #include "../amdxcp/amdgpu_xcp_drv.h"
>
> @@ -3074,6 +3075,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D=
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
> index b7a858365174..a36e3e2e679c 100644
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
> @@ -1680,6 +1683,27 @@ struct drm_amdgpu_info_cwsr {
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
> +               __u64 tba_va;
> +               /* Level 2 trap handler buffer size (in bytes) */
> +               __u32 tba_sz;
> +               /* Level 2 trap memory buffer address */
> +               __u64 tma_va;
> +               /* Level 2 trap memory buffer size (in bytes) */
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
