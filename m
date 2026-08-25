Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ADBC61DBE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 13:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D52489F31;
	Tue, 25 Aug 2026 13:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="icnbJUfD";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A30FC89F31
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 13:46:14 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38dd1cc8dc8so601687a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 06:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787665574; cv=none;
 d=google.com; s=arc-20260327;
 b=kBPdB1Rw2b+NEDcRuFpcPchGZU7FTqUSZAMyZREd3WjLWxx6RDmbsGxbjyxXEAKPzh
 6LyT1KjT0GqisFSgFGHfA861jO+rPAdkFY7P4qONxtwtWqHyQ6RCqJHMIl5hHuk0By3j
 O4jTRqEAyKO+BjnA6vvg8/CsTUGLy0iPhGhitMnZ65H4AmQ5Kd2WU7KF4Os16gOOYb79
 LyuGRE+LfvJF3f5g4ogiODqNb3V4YO6d4fgfCizc66O6IG4nes6Cukhm96G6pzjK5Qtm
 ycxTSqj7fVyfSDtjAROEz/BI/jSY6CEyYS1v+SSfPoP5KYSwIhiatgy0wLwhWy1aQzp0
 2c1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nQSDDy0eYBi2A4pPg0osBymkD50N2H6aMFQNTmOEWYw=;
 fh=Ft5D2gkfOPpiPd/4/zmkZGHLyWq7cCpAWBCCS8sIZEM=;
 b=MmllqzUpDWgq5AvfoXguQvn5ylMctkcCaSYLkXWXN2fAbruGDz/Unfodv3HLV9284w
 uzQ6/iKSzh5C0lkJQQJGOEtHTmmIPLZv5ZvqELHD8ArO6aL2nZYOYfUPx/7F9bMOVfuD
 JmMUZB3LgQdfVhBngaDIOsQcicMJRzXKDOQ0lX8xJRYPNMt21+xdHVcD5VMzKE6ZEUKM
 NWfdBil0V+Y/PBantYTm9XP1jmCeS00ke85EkoR5YCP+hMFJMcdyT6x955M2ZebysbXR
 CkuVNjtllfzQ8LJbjJV5IrDwpbul1gspjsrsdaTLokAa/p6yqJMhCJSC9rvc6AvbEFq5
 ltVw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787665574; x=1788270374; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nQSDDy0eYBi2A4pPg0osBymkD50N2H6aMFQNTmOEWYw=;
 b=icnbJUfDQT+ujGVdvTDjnXCSZrO99JpBNWPGHWE2wqQK1+mYI61uFb2f63qOfzTHa9
 L9uOsIg2+1RQunHNf0Hv1UVlVlysq6eOhJXMT+KLPa98KoyqrMZGp1DvJobm35i7HSyL
 QvgAiBv51AC9vDxLlrZrLpUNzckHeyk8bbQoyAdXlYPWPT4EaqsAs+M3Uh48IGriSPiJ
 FNFQCrNKPC2uHVX5YBq3yU+yZGSdHi3MrxG2ax2t3FLd0oqbaFh/of4ZmyQBolGTQeth
 Ddm7Wb2PpDsjv7Gj/Q9CGr5GOGIRmXgmlouvDBoADDIJRBwalsVpYBG0dTRMA1v7qA90
 tq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787665574; x=1788270374;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nQSDDy0eYBi2A4pPg0osBymkD50N2H6aMFQNTmOEWYw=;
 b=XN98inPvTSfiBDlduHKpciauaGs6nNTHCftlO2jga4nITP2LXSnLPV39V51/p3vfHy
 aEzKczFbQkynxckOuy4866FqElkM0tnweFmCk3fPLyfgX+9QUhNhD2Jct+7iPIou6GY3
 MqQvw32ZQAruDs1H0EEmP5SETyt1/eR8AIrHtxgQqBQyRRha7Z4TgtqWdvWAIGl/Rojf
 iynHewgvJ2Nn8jnvxqonZgkV33AO5QIdQmgGTlPkSsGOfu4LFgK9a9DCpxKBIRd13Cvx
 +lUVJWA8Y0onUgeW68rOwQupLkEt+GDcj/uNwZwUPgas3ozGWIw/ij5Aq6Vhv/18y13j
 iLBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQSBJh+Ik7ZYAwrq0E9OMm3n/IDnFLucgeyoDTlldwwpKJC3T+legZ6v2MvbV3/NcXVDlkIZ55@lists.freedesktop.org
X-Gm-Message-State: AFuF++kv+ZcqQflfwgWu3h8h8xCa9YxW/SZ0hZewIOHXz0PsHufU1WwH
 58TmobUkEDzvHXtbwYJ48Qs+yEYMuRwmUMd+lgcVoWBFNJ1ZqnN6upB8SD5nR/KjioV1FkHHDdG
 Xu/ARaEBnzeM8jAVyChg1zTgFQ8tnWnQ=
X-Gm-Gg: AR+sD13dbd4tYj0hIPyw/ygxN2lHFaKEBAWjl9ySPUj6Cgzn8lag3Qr0eW0ySkgn4yo
 +NviPWkrnDCWv+a6P8uyYaU4pbAeh3aGFkPCerFL6ZOC6ck4OQwbAVB/Yx2Uaw4sT7SOXHY0qzK
 VK+szfZEIsAsXCvMqc4pd9B8looe1T2NeXfTWGkSHLpQ0PYltXdyov5dKA67CIA+KEtQ4V1CqFi
 ntLI6ZmDh5nVrivf746tipu/rzV7L4m1bvwZGSWjIaQm+thQEcMisZRekwh7j9RWZLZJyWj6qj3
 W0gu0EQYIwdhMEpSiSnEmFNEiTdl03t5VYJrosPO0RP5PXFyY6TCFbFUEW7OyX2tr9zZwS2hNYl
 DiChyHju8JlwKkSe/XVpMFpDNuTMZcJ4=
X-Received: by 2002:a17:90b:2648:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-39647bfad3emr5520931a91.3.1787665573474; Tue, 25 Aug 2026
 06:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260824185055.3975572-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260824185055.3975572-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Aug 2026 09:46:01 -0400
X-Gm-Features: AcwNN1WOTRelwdmWhzJpPvxG4mjLSD_zBsmXIpWP8VBreD4cEsbJRXFA8rijsYY
Message-ID: <CADnq5_O68sKVR+EBfGCoLdSE3dtyOiObPHw_XaD5L5fssjFg_w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Rename amdgpu_cwsr to amdgpu_trap
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Aug 24, 2026 at 3:31=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> CWSR (Compute Wave Save Restore) is only the context save/restore
> feature. The level 1 trap handler manages CWSR as well as the
> second-level userspace trap handler added for render-node user queues.
> Keeping the file and ioctl named after CWSR is misleading now that the
> code manages both levels of trap handling.
>
> Rename files and ioctl to reflect the broader trap handler scope so
> future trap handler features have a natural home without further naming
> confusion.
>
>   amdgpu_cwsr.c         =E2=86=92 amdgpu_trap.c
>   amdgpu_cwsr.h         =E2=86=92 amdgpu_trap.h
>   AMDGPU_CWSR ioctl     =E2=86=92 AMDGPU_TRAP ioctl
>   amdgpu_cwsr_* symbols =E2=86=92 amdgpu_trap_* symbols
>
> The cwsr_enable module parameter and cwsr_trap_handler.h ISA binaries
> are not renamed =E2=80=94 they are specific to the CWSR context save feat=
ure.
>
> v2 (Alex):
> - Group the CWSR save area size fields into a nested 'cwsr' struct
>   inside amdgpu_trap_info. This keeps CWSR-specific data visually
>   separated from the broader trap handler infrastructure and makes
>   it clear which fields belong to CWSR vs future trap features.
> - Keep the local variable name 'cwsr_info' in amdgpu_kms.c since
>   that code only deals with CWSR save area sizes. Renaming it
>   'trap_info' was misleading as it has nothing to do with trap
>   handlers in general.
> - Rename cwsr_params to trap_params and rename the function
>   amdgpu_userq_input_cwsr_params_validate() to
>   amdgpu_userq_input_trap_params_validate(). The parameter type was
>   already renamed to amdgpu_trap_params but the variable name was
>   still cwsr_params, causing a mismatch.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  16 +-
>  .../amdgpu/{amdgpu_cwsr.c =3D> amdgpu_trap.c}   | 265 +++++++++---------
>  .../amdgpu/{amdgpu_cwsr.h =3D> amdgpu_trap.h}   |  52 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   7 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  23 +-
>  include/uapi/drm/amdgpu_drm.h                 |  14 +-
>  11 files changed, 204 insertions(+), 206 deletions(-)
>  rename drivers/gpu/drm/amd/amdgpu/{amdgpu_cwsr.c =3D> amdgpu_trap.c} (63=
%)
>  rename drivers/gpu/drm/amd/amdgpu/{amdgpu_cwsr.h =3D> amdgpu_trap.h} (63=
%)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 6fb0a913e33b..ec199715ee76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -72,7 +72,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_reg_access.o amdgp=
u_doorbell_mgr.o amdgpu_kms
>         amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgp=
u_lockdep.o \
>         amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump=
.o \
>         amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu=
_ip.o \
> -       amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
> +       amdgpu_wb.o amdgpu_trap.o amdgpu_events.o
>
>  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 8eff6b9ebe81..e3763c197138 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -327,8 +327,8 @@ struct amdgpu_reset_context;
>  struct amdgpu_reset_control;
>  struct amdgpu_coredump_info;
>  struct amdgpu_video_codecs;
> -struct amdgpu_cwsr_isa;
> -struct amdgpu_cwsr_trap_obj;
> +struct amdgpu_trap_isa;
> +struct amdgpu_trap_obj;
>
>  enum amdgpu_cp_irq {
>         AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP =3D 0,
> @@ -417,7 +417,7 @@ struct amdgpu_fpriv {
>         struct xarray           bo_list_handles;
>         struct amdgpu_ctx_mgr   ctx_mgr;
>         struct amdgpu_userq_mgr userq_mgr;
> -       struct amdgpu_cwsr_trap_obj *cwsr_trap;
> +       struct amdgpu_trap_obj *trap_obj;
>
>         /* Eviction fence infra */
>         struct amdgpu_eviction_fence_mgr evf_mgr;
> @@ -965,7 +965,7 @@ struct amdgpu_device {
>          */
>         struct amdgpu_kfd_dev           kfd;
>
> -       struct amdgpu_cwsr_info *cwsr_info;
> +       struct amdgpu_trap_info *trap_info;
>  };
>
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index c924a55fd16f..380989f4c965 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -81,7 +81,7 @@
>  #include "amdgpu_events.h"
>  #include "amdgpu_virt.h"
>  #include "amdgpu_dev_coredump.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> @@ -2395,7 +2395,7 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
>         r =3D amdgpu_cper_init(adev);
>
>         if (!r) {
> -               r =3D amdgpu_cwsr_init(adev);
> +               r =3D amdgpu_trap_init(adev);
>                 if (r =3D=3D -EOPNOTSUPP)
>                         r =3D 0;
>         }
> @@ -2797,7 +2797,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_devi=
ce *adev)
>  {
>         int i, r;
>
> -       amdgpu_cwsr_fini(adev);
> +       amdgpu_trap_fini(adev);
>         amdgpu_cper_fini(adev);
>
>         if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 7c473f60bd28..a93ee106ab92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -52,7 +52,7 @@
>  #include "amdgpu_sched.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_userq.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>  #include "amdgpu_userq_fence.h"
>  #include "../amdxcp/amdgpu_xcp_drv.h"
>
> @@ -3079,7 +3079,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D=
 {
>         DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
>         DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|=
DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_hand=
le_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -       DRM_IOCTL_DEF_DRV(AMDGPU_CWSR, amdgpu_cwsr_ioctl, DRM_AUTH|DRM_RE=
NDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_=
RENDER_ALLOW),
>         /* KMS */
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUT=
H|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioct=
l, DRM_AUTH|DRM_RENDER_ALLOW),
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index f8a30e52e2a0..b89ee6d907d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -48,7 +48,7 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_video_codecs.h"
>  #include "amdgpu_vm.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -1499,15 +1499,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *filp)
>                 int num_xcc, r;
>
>                 fpriv =3D (struct amdgpu_fpriv *)filp->driver_priv;
> -               if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
> +               if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>                         return -EOPNOTSUPP;
>                 num_xcc =3D amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->=
xcp_id);
>                 cwsr_info.ctl_stack_size =3D
> -                       adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> +                       adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>                 cwsr_info.dbg_mem_size =3D
> -                       adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
> +                       adev->trap_info->cwsr.xcc_dbg_mem_sz * num_xcc;
>                 cwsr_info.min_save_area_size =3D
> -                       amdgpu_cwsr_size_needed(adev, num_xcc);
> +                       amdgpu_trap_size_needed(adev, num_xcc);
>                 r =3D copy_to_user(out, &cwsr_info,
>                                  min((size_t)size, sizeof(cwsr_info))) ?
>                             -EFAULT :
> @@ -1641,8 +1641,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, =
struct drm_file *file_priv)
>
>         amdgpu_evf_mgr_init(&fpriv->evf_mgr);
>
> -       if (amdgpu_cwsr_is_enabled(adev)) {
> -               r =3D amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_tr=
ap);
> +       if (amdgpu_trap_is_enabled(adev)) {
> +               r =3D amdgpu_trap_alloc(adev, &fpriv->vm, &fpriv->trap_ob=
j);
>                 if (r)
>                         dev_dbg(adev->dev, "cwsr trap not enabled");
>         }
> @@ -1716,7 +1716,7 @@ void amdgpu_driver_postclose_kms(struct drm_device =
*dev,
>         }
>
>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> -       amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
> +       amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
>
>         if (pasid)
>                 amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_trap.c
> similarity index 63%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 7e5a08b0a1c8..27075d33cbc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -23,13 +23,13 @@
>
>  #include "amdgpu.h"
>  #include "cwsr_trap_handler.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>
>  extern int cwsr_enable;
>
> -#define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> -#define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> -#define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
> +#define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_TRAP_TMA_OFFSET (AMDGPU_TRAP_TBA_MAX_SIZE)
>
>  #define SGPR_SIZE_PER_CU 0x4000
>  #define LDS_SIZE_PER_CU 0x10000
> @@ -38,12 +38,12 @@ extern int cwsr_enable;
>  #define DEBUGGER_BYTES_PER_WAVE 32
>  #define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
>
> -enum amdgpu_cwsr_region {
> -       AMDGPU_CWSR_TBA,
> -       AMDGPU_CWSR_TMA,
> +enum amdgpu_trap_region {
> +       AMDGPU_TRAP_TBA,
> +       AMDGPU_TRAP_TMA,
>  };
>
> -static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
> +static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
>  {
>         uint64_t addr =3D AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
>
> @@ -52,7 +52,7 @@ static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amd=
gpu_device *adev)
>         return addr;
>  }
>
> -static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
> +static inline bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
>  {
>         uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
>
> @@ -63,80 +63,80 @@ static inline bool amdgpu_cwsr_is_supported(struct am=
dgpu_device *adev)
>         return true;
>  }
>
> -uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc=
)
> +uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc=
)
>  {
> -       if (!amdgpu_cwsr_is_enabled(adev))
> +       if (!amdgpu_trap_is_enabled(adev))
>                 return 0;
>
>         return num_xcc *
> -              (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_m=
em_sz);
> +              (adev->trap_info->cwsr.xcc_cwsr_sz + adev->trap_info->cwsr=
.xcc_dbg_mem_sz);
>  }
>
> -static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
> -                                        struct amdgpu_cwsr_info *cwsr_in=
fo)
> +static void amdgpu_trap_init_isa_details(struct amdgpu_device *adev,
> +                                        struct amdgpu_trap_info *trap_in=
fo)
>  {
>         uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
>
>         if (gc_ver < IP_VERSION(9, 0, 1)) {
>                 BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
> -                            AMDGPU_CWSR_TBA_MAX_SIZE);
> -               cwsr_info->isa_buf =3D cwsr_trap_gfx8_hex;
> -               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx8_hex);
> +                            AMDGPU_TRAP_TBA_MAX_SIZE);
> +               trap_info->isa_buf =3D cwsr_trap_gfx8_hex;
> +               trap_info->isa_sz =3D sizeof(cwsr_trap_gfx8_hex);
>         } else if (gc_ver =3D=3D IP_VERSION(9, 4, 1)) {
>                 BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
> -                            AMDGPU_CWSR_TBA_MAX_SIZE);
> -               cwsr_info->isa_buf =3D cwsr_trap_arcturus_hex;
> -               cwsr_info->isa_sz =3D sizeof(cwsr_trap_arcturus_hex);
> +                            AMDGPU_TRAP_TBA_MAX_SIZE);
> +               trap_info->isa_buf =3D cwsr_trap_arcturus_hex;
> +               trap_info->isa_sz =3D sizeof(cwsr_trap_arcturus_hex);
>         } else if (gc_ver =3D=3D IP_VERSION(9, 4, 2)) {
>                 BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
> -                            AMDGPU_CWSR_TBA_MAX_SIZE);
> -               cwsr_info->isa_buf =3D cwsr_trap_aldebaran_hex;
> -               cwsr_info->isa_sz =3D sizeof(cwsr_trap_aldebaran_hex);
> +                            AMDGPU_TRAP_TBA_MAX_SIZE);
> +               trap_info->isa_buf =3D cwsr_trap_aldebaran_hex;
> +               trap_info->isa_sz =3D sizeof(cwsr_trap_aldebaran_hex);
>         } else if (gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
>                    gc_ver =3D=3D IP_VERSION(9, 4, 4)) {
>                 BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
> -                            AMDGPU_CWSR_TBA_MAX_SIZE);
> -               cwsr_info->isa_buf =3D cwsr_trap_gfx9_4_3_hex;
> -               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx9_4_3_hex);
> +                            AMDGPU_TRAP_TBA_MAX_SIZE);
> +               trap_info->isa_buf =3D cwsr_trap_gfx9_4_3_hex;
> +               trap_info->isa_sz =3D sizeof(cwsr_trap_gfx9_4_3_hex);
>         } else if (gc_ver =3D=3D IP_VERSION(9, 5, 0)) {
>                 BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
> -               cwsr_info->isa_buf =3D cwsr_trap_gfx9_5_0_hex;
> -               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx9_5_0_hex);
> +               trap_info->isa_buf =3D cwsr_trap_gfx9_5_0_hex;
> +               trap_info->isa_sz =3D sizeof(cwsr_trap_gfx9_5_0_hex);
>         } else if (gc_ver < IP_VERSION(10, 1, 1)) {
>                 BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
> -                            AMDGPU_CWSR_TBA_MAX_SIZE);
> -               cwsr_info->isa_buf =3D cwsr_trap_gfx9_hex;
> -               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx9_hex);
> +                            AMDGPU_TRAP_TBA_MAX_SIZE);
> +               trap_info->isa_buf =3D cwsr_trap_gfx9_hex;
> +               trap_info->isa_sz =3D sizeof(cwsr_trap_gfx9_hex);
>         } else if (gc_ver < IP_VERSION(10, 3, 0)) {
>                 BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
> -                            AMDGPU_CWSR_TBA_MAX_SIZE);
> -               cwsr_info->isa_buf =3D cwsr_trap_nv1x_hex;
> -               cwsr_info->isa_sz =3D sizeof(cwsr_trap_nv1x_hex);
> +                            AMDGPU_TRAP_TBA_MAX_SIZE);
> +               trap_info->isa_buf =3D cwsr_trap_nv1x_hex;
> +               trap_info->isa_sz =3D sizeof(cwsr_trap_nv1x_hex);
>         } else if (gc_ver < IP_VERSION(11, 0, 0)) {
>                 BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
> -                            AMDGPU_CWSR_TBA_MAX_SIZE);
> -               cwsr_info->isa_buf =3D cwsr_trap_gfx10_hex;
> -               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx10_hex);
> +                            AMDGPU_TRAP_TBA_MAX_SIZE);
> +               trap_info->isa_buf =3D cwsr_trap_gfx10_hex;
> +               trap_info->isa_sz =3D sizeof(cwsr_trap_gfx10_hex);
>         } else if (gc_ver < IP_VERSION(12, 0, 0)) {
>                 /* The gfx11 cwsr trap handler must fit inside a single
>                            page. */
>                 BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
> -               cwsr_info->isa_buf =3D cwsr_trap_gfx11_hex;
> -               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx11_hex);
> +               trap_info->isa_buf =3D cwsr_trap_gfx11_hex;
> +               trap_info->isa_sz =3D sizeof(cwsr_trap_gfx11_hex);
>         } else if (gc_ver < IP_VERSION(12, 1, 0)) {
>                 BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
> -                            AMDGPU_CWSR_TBA_MAX_SIZE);
> -               cwsr_info->isa_buf =3D cwsr_trap_gfx12_hex;
> -               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx12_hex);
> +                            AMDGPU_TRAP_TBA_MAX_SIZE);
> +               trap_info->isa_buf =3D cwsr_trap_gfx12_hex;
> +               trap_info->isa_sz =3D sizeof(cwsr_trap_gfx12_hex);
>         } else {
>                 BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex) >
> -                            AMDGPU_CWSR_TBA_MAX_SIZE);
> -               cwsr_info->isa_buf =3D cwsr_trap_gfx12_1_0_hex;
> -               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx12_1_0_hex);
> +                            AMDGPU_TRAP_TBA_MAX_SIZE);
> +               trap_info->isa_buf =3D cwsr_trap_gfx12_1_0_hex;
> +               trap_info->isa_sz =3D sizeof(cwsr_trap_gfx12_1_0_hex);
>         }
>  }
>
> -static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *a=
dev)
> +static uint32_t amdgpu_trap_get_vgpr_size_per_cu(struct amdgpu_device *a=
dev)

How about amdgpu_trap_cwsr_get_vgpr_size_per_cu() since this is related to =
cwsr.

>  {
>         uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
>         uint32_t vgpr_size;
> @@ -164,7 +164,7 @@ static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(stru=
ct amdgpu_device *adev)
>         return vgpr_size;
>  }
>
> -static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device=
 *adev)
> +static uint32_t amdgpu_trap_get_wg_ctxt_size_per_cu(struct amdgpu_device=
 *adev)
>  {
>         uint32_t lds_sz_per_cu;
>
> @@ -173,11 +173,11 @@ static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu=
(struct amdgpu_device *adev)
>                         (adev->gfx.cu_info.lds_size << 10) :
>                         LDS_SIZE_PER_CU;
>
> -       return amdgpu_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU =
+
> +       return amdgpu_trap_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU =
+
>                lds_sz_per_cu + HWREG_SIZE_PER_CU;
>  }
>
> -static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_devic=
e *adev)
> +static uint32_t amdgpu_trap_ctl_stack_bytes_per_wave(struct amdgpu_devic=
e *adev)

Same comment as above.  This is related to cwsr.

>  {
>         uint32_t sz;
>
> @@ -188,8 +188,8 @@ static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(=
struct amdgpu_device *adev)
>         return sz;
>  }
>
> -static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
> -                                           struct amdgpu_cwsr_info *cwsr=
_info)
> +static void amdgpu_trap_init_save_area_info(struct amdgpu_device *adev,
> +                                           struct amdgpu_trap_info *trap=
_info)

And here.  With these changes, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>  {
>         struct amdgpu_gfx_config *gfx_info =3D &adev->gfx.config;
>         uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
> @@ -209,10 +209,10 @@ static void amdgpu_cwsr_init_save_area_info(struct =
amdgpu_device *adev,
>                                array_count / gfx_info->max_sh_per_se * 51=
2) :
>                            cu_num * 32;
>
> -       wg_data_size =3D ALIGN(cu_num * amdgpu_cwsr_get_wg_ctxt_size_per_=
cu(adev),
> +       wg_data_size =3D ALIGN(cu_num * amdgpu_trap_get_wg_ctxt_size_per_=
cu(adev),
>                              PAGE_SIZE);
>         ctl_stack_size =3D
> -               wave_num * amdgpu_cwsr_ctl_stack_bytes_per_wave(adev) + 8=
;
> +               wave_num * amdgpu_trap_ctl_stack_bytes_per_wave(adev) + 8=
;
>         ctl_stack_size =3D
>                 ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stac=
k_size,
>                       PAGE_SIZE);
> @@ -226,62 +226,62 @@ static void amdgpu_cwsr_init_save_area_info(struct =
amdgpu_device *adev,
>         if (IP_VERSION_MAJ(gc_ver) =3D=3D 10)
>                 ctl_stack_size =3D min(ctl_stack_size, 0x7000);
>
> -       cwsr_info->xcc_ctl_stack_sz =3D ctl_stack_size;
> -       cwsr_info->xcc_cwsr_sz =3D ctl_stack_size + wg_data_size;
> -       cwsr_info->xcc_dbg_mem_sz =3D dbg_mem_size;
> +       trap_info->cwsr.xcc_ctl_stack_sz =3D ctl_stack_size;
> +       trap_info->cwsr.xcc_cwsr_sz =3D ctl_stack_size + wg_data_size;
> +       trap_info->cwsr.xcc_dbg_mem_sz =3D dbg_mem_size;
>  }
>
> -int amdgpu_cwsr_init(struct amdgpu_device *adev)
> +int amdgpu_trap_init(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_cwsr_info *cwsr_info __free(kfree) =3D
> -               kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
> +       struct amdgpu_trap_info *trap_info __free(kfree) =3D
> +               kzalloc(sizeof(*trap_info), GFP_KERNEL);
>         void *ptr;
>         int r;
>
> -       if (!amdgpu_cwsr_is_supported(adev))
> +       if (!amdgpu_trap_is_supported(adev))
>                 return -EOPNOTSUPP;
>
> -       if (!cwsr_info)
> +       if (!trap_info)
>                 return -ENOMEM;
> -       amdgpu_cwsr_init_isa_details(adev, cwsr_info);
> +       amdgpu_trap_init_isa_details(adev, trap_info);
>
> -       if (!cwsr_info->isa_sz)
> +       if (!trap_info->isa_sz)
>                 return -EOPNOTSUPP;
>
> -       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TBA_MAX_SIZE, PAG=
E_SIZE,
> -                                   AMDGPU_GEM_DOMAIN_GTT, &cwsr_info->is=
a_bo,
> +       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TBA_MAX_SIZE, PAG=
E_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_GTT, &trap_info->is=
a_bo,
>                                     NULL, &ptr);
>         if (r)
>                 return r;
>
> -       memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
> +       memcpy(ptr, trap_info->isa_buf, trap_info->isa_sz);
>
> -       amdgpu_cwsr_init_save_area_info(adev, cwsr_info);
> -       adev->cwsr_info =3D no_free_ptr(cwsr_info);
> +       amdgpu_trap_init_save_area_info(adev, trap_info);
> +       adev->trap_info =3D no_free_ptr(trap_info);
>
>         return 0;
>  }
>
> -void amdgpu_cwsr_fini(struct amdgpu_device *adev)
> +void amdgpu_trap_fini(struct amdgpu_device *adev)
>  {
> -       if (!amdgpu_cwsr_is_enabled(adev))
> +       if (!amdgpu_trap_is_enabled(adev))
>                 return;
>
> -       amdgpu_bo_free_kernel(&adev->cwsr_info->isa_bo, NULL, NULL);
> -       kfree(adev->cwsr_info);
> -       adev->cwsr_info =3D NULL;
> +       amdgpu_bo_free_kernel(&adev->trap_info->isa_bo, NULL, NULL);
> +       kfree(adev->trap_info);
> +       adev->trap_info =3D NULL;
>  }
>
>  /*
>   * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
> - * it maps virtual address amdgpu_cwsr_trap_handler_vaddr() to this VM, =
and each
> + * it maps virtual address amdgpu_trap_tba_vaddr() to this VM, and each
>   * compute queue can use this virtual address for wave save/restore
>   * operations to support compute preemption.
>   */
> -static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
> +static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>                                   struct amdgpu_vm *vm,
> -                                 struct amdgpu_cwsr_trap_obj *cwsr,
> -                                 enum amdgpu_cwsr_region region)
> +                                 struct amdgpu_trap_obj *cwsr,
> +                                 enum amdgpu_trap_region region)
>  {
>         uint64_t cwsr_addr, va_flags, va;
>         struct amdgpu_bo_va **bo_va;
> @@ -292,20 +292,20 @@ static int amdgpu_cwsr_map_region(struct amdgpu_dev=
ice *adev,
>         if (!cwsr || !vm)
>                 return -EINVAL;
>
> -       cwsr_addr =3D amdgpu_cwsr_tba_vaddr(adev);
> +       cwsr_addr =3D amdgpu_trap_tba_vaddr(adev);
>
> -       if (region =3D=3D AMDGPU_CWSR_TBA) {
> -               size =3D AMDGPU_CWSR_TBA_MAX_SIZE;
> +       if (region =3D=3D AMDGPU_TRAP_TBA) {
> +               size =3D AMDGPU_TRAP_TBA_MAX_SIZE;
>                 bo_va =3D &cwsr->tba_va;
> -               bo =3D adev->cwsr_info->isa_bo;
> +               bo =3D adev->trap_info->isa_bo;
>                 va =3D cwsr_addr;
>                 va_flags =3D (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WR=
ITEABLE |
>                             AMDGPU_VM_PAGE_EXECUTABLE);
>         } else {
> -               size =3D AMDGPU_CWSR_TMA_MAX_SIZE;
> +               size =3D AMDGPU_TRAP_TMA_MAX_SIZE;
>                 bo_va =3D &cwsr->tma_va;
>                 bo =3D cwsr->tma_bo;
> -               va =3D cwsr_addr + AMDGPU_CWSR_TMA_OFFSET;
> +               va =3D cwsr_addr + AMDGPU_TRAP_TMA_OFFSET;
>                 va_flags =3D (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WR=
ITEABLE);
>         }
>
> @@ -317,7 +317,7 @@ static int amdgpu_cwsr_map_region(struct amdgpu_devic=
e *adev,
>         r =3D amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
>         if (r) {
>                 dev_err(adev->dev, "failed to do bo map of %s region, err=
=3D%d\n",
> -                       (region =3D=3D AMDGPU_CWSR_TBA ? "tba" : "tma"), =
r);
> +                       (region =3D=3D AMDGPU_TRAP_TBA ? "tba" : "tma"), =
r);
>                 amdgpu_vm_bo_del(adev, *bo_va);
>                 *bo_va =3D NULL;
>                 return r;
> @@ -327,13 +327,13 @@ static int amdgpu_cwsr_map_region(struct amdgpu_dev=
ice *adev,
>         if (r) {
>                 dev_err(adev->dev,
>                         "failed to do page table update of %s region, err=
=3D%d\n",
> -                       (region =3D=3D AMDGPU_CWSR_TBA ? "tba" : "tma"), =
r);
> +                       (region =3D=3D AMDGPU_TRAP_TBA ? "tba" : "tma"), =
r);
>                 amdgpu_vm_bo_del(adev, *bo_va);
>                 *bo_va =3D NULL;
>                 return r;
>         }
>
> -       if (region =3D=3D AMDGPU_CWSR_TBA)
> +       if (region =3D=3D AMDGPU_TRAP_TBA)
>                 cwsr->tba_gpu_va_addr =3D va;
>         else
>                 cwsr->tma_gpu_va_addr =3D va;
> @@ -341,9 +341,9 @@ static int amdgpu_cwsr_map_region(struct amdgpu_devic=
e *adev,
>         return 0;
>  }
>
> -static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
> -                                   struct amdgpu_cwsr_trap_obj *cwsr,
> -                                   enum amdgpu_cwsr_region region)
> +static int amdgpu_trap_unmap_region(struct amdgpu_device *adev,
> +                                   struct amdgpu_trap_obj *cwsr,
> +                                   enum amdgpu_trap_region region)
>  {
>         struct amdgpu_bo_va **bo_va;
>         uint64_t va;
> @@ -352,7 +352,7 @@ static int amdgpu_cwsr_unmap_region(struct amdgpu_dev=
ice *adev,
>         if (!cwsr)
>                 return -EINVAL;
>
> -       if (region =3D=3D AMDGPU_CWSR_TBA) {
> +       if (region =3D=3D AMDGPU_TRAP_TBA) {
>                 bo_va =3D &cwsr->tba_va;
>                 va =3D cwsr->tba_gpu_va_addr;
>         } else {
> @@ -374,15 +374,15 @@ static int amdgpu_cwsr_unmap_region(struct amdgpu_d=
evice *adev,
>         return r;
>  }
>
> -int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -                     struct amdgpu_cwsr_trap_obj **trap_obj)
> +int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                     struct amdgpu_trap_obj **trap_obj)
>  {
> -       struct amdgpu_cwsr_trap_obj *cwsr;
> +       struct amdgpu_trap_obj *cwsr;
>         struct amdgpu_bo *bo;
>         struct drm_exec exec;
>         int r;
>
> -       if (!amdgpu_cwsr_is_enabled(adev))
> +       if (!amdgpu_trap_is_enabled(adev))
>                 return -EOPNOTSUPP;
>         if (!vm || !trap_obj)
>                 return -EINVAL;
> @@ -390,7 +390,7 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>         if (!cwsr)
>                 return -ENOMEM;
>
> -       bo =3D adev->cwsr_info->isa_bo;
> +       bo =3D adev->trap_info->isa_bo;
>         drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>         drm_exec_until_all_locked(&exec) {
>                 r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
> @@ -405,18 +405,18 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
>                 }
>         }
>
> -       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TMA_MAX_SIZE, PAG=
E_SIZE,
> +       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAG=
E_SIZE,
>                                     AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo,=
 NULL,
>                                     &cwsr->tma_cpu_addr);
>         if (r)
>                 goto err;
>
> -       r =3D amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
> +       r =3D amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
>         if (r)
>                 goto err;
> -       r =3D amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TBA);
> +       r =3D amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
>         if (r) {
> -               amdgpu_cwsr_unmap_region(adev, cwsr, AMDGPU_CWSR_TMA);
> +               amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
>                 goto err;
>         }
>
> @@ -433,38 +433,38 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
>         return r;
>  }
>
> -int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> -                               struct amdgpu_cwsr_params *cwsr_params,
> +int amdgpu_trap_validate_params(struct amdgpu_device *adev,
> +                               struct amdgpu_trap_params *trap_params,
>                                 int num_xcc)
>  {
>         uint32_t min_size, max_size;
>
> -       if (!amdgpu_cwsr_is_enabled(adev))
> +       if (!amdgpu_trap_is_enabled(adev))
>                 return -EOPNOTSUPP;
>
> -       if (!cwsr_params)
> +       if (!trap_params)
>                 return -EINVAL;
>
> -       min_size =3D amdgpu_cwsr_size_needed(adev, num_xcc);
> +       min_size =3D amdgpu_trap_size_needed(adev, num_xcc);
>         max_size =3D 2 * min_size;
>         /*
>          * Only save area size details checked. Address validation needs =
to be
>          * carried out separately. User is expected to pass a cwsr buffer=
 area
>          * with size >=3D ctl stack size + wg data size + debug memory si=
ze
>          */
> -       if (cwsr_params->cwsr_sz < min_size ||
> -           cwsr_params->cwsr_sz > max_size) {
> +       if (trap_params->cwsr_sz < min_size ||
> +           trap_params->cwsr_sz > max_size) {
>                 dev_dbg(adev->dev,
>                         "queue cwsr size 0x%x should be within min %u : m=
ax %u\n",
> -                       cwsr_params->cwsr_sz, min_size, max_size);
> +                       trap_params->cwsr_sz, min_size, max_size);
>                 return -EINVAL;
>         }
>
>         return 0;
>  }
>
> -void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -                     struct amdgpu_cwsr_trap_obj **trap_obj)
> +void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                     struct amdgpu_trap_obj **trap_obj)
>  {
>         struct amdgpu_bo *tba_bo;
>         struct amdgpu_bo *tma_bo;
> @@ -473,7 +473,7 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>
>         if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
>                 return;
> -       tba_bo =3D adev->cwsr_info->isa_bo;
> +       tba_bo =3D adev->trap_info->isa_bo;
>         tma_bo =3D (*trap_obj)->tma_bo;
>
>         if (!tba_bo || !tma_bo)
> @@ -496,8 +496,8 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>                 }
>         }
>
> -       amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
> -       amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
> +       amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TBA);
> +       amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TMA);
>  err:
>         drm_exec_fini(&exec);
>         amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
> @@ -505,9 +505,9 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>         *trap_obj =3D NULL;
>  }
>
> -static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
> +static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
>                                           struct amdgpu_vm *vm,
> -                                         struct amdgpu_cwsr_usr_addr *us=
r_addr)
> +                                         struct amdgpu_trap_usr_addr *us=
r_addr)
>  {
>         struct amdgpu_bo_va_mapping *va_map;
>         uint64_t addr;
> @@ -539,23 +539,23 @@ static int amdgpu_cwsr_validate_user_addr(struct am=
dgpu_device *adev,
>         return r;
>  }
>
> -static int amdgpu_cwsr_set_l2_trap_handler(
> -       struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -       struct amdgpu_cwsr_trap_obj *cwsr_obj, struct amdgpu_cwsr_usr_add=
r *tma,
> -       struct amdgpu_cwsr_usr_addr *tba)
> +static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
> +                                          struct amdgpu_trap_obj *cwsr_o=
bj,
> +                                          struct amdgpu_trap_usr_addr *t=
ma,
> +                                          struct amdgpu_trap_usr_addr *t=
ba)
>  {
>         uint64_t *l1tma;
>         int r;
>
> -       if (!amdgpu_cwsr_is_enabled(adev))
> +       if (!amdgpu_trap_is_enabled(adev))
>                 return -EOPNOTSUPP;
>
>         if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
>                 return -EINVAL;
> -       r =3D amdgpu_cwsr_validate_user_addr(adev, vm, tma);
> +       r =3D amdgpu_trap_validate_user_addr(adev, vm, tma);
>         if (r)
>                 return r;
> -       r =3D amdgpu_cwsr_validate_user_addr(adev, vm, tba);
> +       r =3D amdgpu_trap_validate_user_addr(adev, vm, tba);
>         if (r)
>                 return r;
>
> @@ -570,7 +570,7 @@ static int amdgpu_cwsr_set_l2_trap_handler(
>   * Userspace cwsr related ioctl
>   */
>  /**
> - * amdgpu_cwsr_ioctl - Handle cwsr specific requests.
> + * amdgpu_trap_ioctl - Handle trap handler specific requests.
>   *
>   * @dev: drm device pointer
>   * @data: request object
> @@ -579,29 +579,28 @@ static int amdgpu_cwsr_set_l2_trap_handler(
>   * This function is used to perform cwsr and trap handler related operat=
ions
>   * Returns 0 on success, error code on failure.
>   */
> -int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_fil=
e *filp)
> +int amdgpu_trap_ioctl(struct drm_device *dev, void *data, struct drm_fil=
e *filp)
>  {
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
> -       union drm_amdgpu_cwsr *cwsr =3D data;
> +       union drm_amdgpu_trap *cwsr =3D data;
>         struct amdgpu_fpriv *fpriv;
>         int r;
>
>         fpriv =3D (struct amdgpu_fpriv *)filp->driver_priv;
>
> -       if (!fpriv->cwsr_trap)
> +       if (!fpriv->trap_obj)
>                 return -EOPNOTSUPP;
>
>         switch (cwsr->in.op) {
> -       case AMDGPU_CWSR_OP_SET_L2_TRAP: {
> -               struct amdgpu_cwsr_usr_addr tba;
> -               struct amdgpu_cwsr_usr_addr tma;
> +       case AMDGPU_TRAP_OP_SET_L2_TRAP: {
> +               struct amdgpu_trap_usr_addr tba;
> +               struct amdgpu_trap_usr_addr tma;
>
>                 tba.addr =3D cwsr->in.l2trap.tba_va;
>                 tba.size =3D cwsr->in.l2trap.tba_sz;
>                 tma.addr =3D cwsr->in.l2trap.tma_va;
>                 tma.size =3D cwsr->in.l2trap.tma_sz;
> -               r =3D amdgpu_cwsr_set_l2_trap_handler(
> -                       adev, &fpriv->vm, fpriv->cwsr_trap, &tma, &tba);
> +               r =3D amdgpu_trap_set_l2_trap_handler(adev, &fpriv->vm, f=
priv->trap_obj, &tma, &tba);
>         } break;
>         default:
>                 return -EINVAL;
> @@ -610,13 +609,13 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>         return r;
>  }
>
> -int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
> -                                   struct amdgpu_cwsr_trap_obj *cwsr_obj=
,
> +int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
> +                                   struct amdgpu_trap_obj *cwsr_obj,
>                                     bool enabled)
>  {
>         uint64_t *l1tma;
>
> -       if (!amdgpu_cwsr_is_enabled(adev))
> +       if (!amdgpu_trap_is_enabled(adev))
>                 return -EOPNOTSUPP;
>
>         if (!cwsr_obj)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_trap.h
> similarity index 63%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> index 06036954627e..6d4664469bad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -20,8 +20,8 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
>
> -#ifndef AMDGPU_CWSR_H
> -#define AMDGPU_CWSR_H
> +#ifndef AMDGPU_TRAP_H
> +#define AMDGPU_TRAP_H
>
>  #include <linux/types.h>
>
> @@ -31,11 +31,11 @@ struct amdgpu_device;
>  struct amdgpu_vm;
>
>  /**
> - * struct amdgpu_cwsr_trap_obj - CWSR (Compute Wave Save Restore) buffer=
 tracking
> + * struct amdgpu_trap_obj - CWSR (Compute Wave Save Restore) buffer trac=
king
>   * @bo: Buffer object for CWSR area
>   * @bo_va: Buffer object virtual address mapping
>   */
> -struct amdgpu_cwsr_trap_obj {
> +struct amdgpu_trap_obj {
>         uint64_t tma_gpu_va_addr;
>         uint64_t tba_gpu_va_addr;
>
> @@ -45,55 +45,57 @@ struct amdgpu_cwsr_trap_obj {
>         void *tma_cpu_addr;
>  };
>
> -struct amdgpu_cwsr_info {
> +struct amdgpu_trap_info {
>         /* cwsr isa */
>         struct amdgpu_bo *isa_bo;
>         const void *isa_buf;
>         uint32_t isa_sz;
>         /* cwsr size info per XCC*/
> -       uint32_t xcc_ctl_stack_sz;
> -       uint32_t xcc_dbg_mem_sz;
> -       uint32_t xcc_cwsr_sz;
> +       struct {
> +               u32 xcc_ctl_stack_sz;
> +               u32 xcc_dbg_mem_sz;
> +               u32 xcc_cwsr_sz;
> +       } cwsr;
>  };
>
> -struct amdgpu_cwsr_params {
> +struct amdgpu_trap_params {
>         uint64_t ctx_save_area_address;
>         /* cwsr size info */
>         uint32_t cwsr_sz;
>  };
>
> -struct amdgpu_cwsr_usr_addr {
> +struct amdgpu_trap_usr_addr {
>         uint64_t addr;
>         uint32_t size;
>  };
>
> -int amdgpu_cwsr_init(struct amdgpu_device *adev);
> -void amdgpu_cwsr_fini(struct amdgpu_device *adev);
> +int amdgpu_trap_init(struct amdgpu_device *adev);
> +void amdgpu_trap_fini(struct amdgpu_device *adev);
>
> -int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -                     struct amdgpu_cwsr_trap_obj **cwsr_obj);
> -void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -                     struct amdgpu_cwsr_trap_obj **cwsr_obj);
> -static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
> +int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                     struct amdgpu_trap_obj **trap_obj);
> +void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                     struct amdgpu_trap_obj **trap_obj);
> +static inline bool amdgpu_trap_is_enabled(struct amdgpu_device *adev)
>  {
> -       return adev->cwsr_info !=3D NULL;
> +       return adev->trap_info;
>  }
>
> -uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc=
);
> -int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> -                               struct amdgpu_cwsr_params *cwsr_params,
> +uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc=
);
> +int amdgpu_trap_validate_params(struct amdgpu_device *adev,
> +                               struct amdgpu_trap_params *trap_params,
>                                 int num_xcc);
> -static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
> +static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
>  {
>         uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
>
>         return gc_ver >=3D IP_VERSION(11, 0, 0) && gc_ver <=3D IP_VERSION=
(11, 0, 3);
>  }
>
> -int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
> +int amdgpu_trap_ioctl(struct drm_device *dev, void *data,
>                       struct drm_file *filp);
> -int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
> -                                   struct amdgpu_cwsr_trap_obj *cwsr_obj=
,
> +int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
> +                                   struct amdgpu_trap_obj *cwsr_obj,
>                                     bool enabled);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index feffebb210ea..db09e879b85e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -34,7 +34,7 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>  #include "amdgpu_trace.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
> @@ -249,9 +249,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_devi=
ce *adev,
>         return -EINVAL;
>  }
>
> -int amdgpu_userq_input_cwsr_params_validate(
> -       struct amdgpu_usermode_queue *queue,
> -       struct amdgpu_cwsr_params *cwsr_params)
> +int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue=
 *queue,
> +                                           struct amdgpu_trap_params *tr=
ap_params)
>  {
>         struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(queue->userq_mgr);
>         struct amdgpu_device *adev =3D queue->userq_mgr->adev;
> @@ -260,16 +259,16 @@ int amdgpu_userq_input_cwsr_params_validate(
>         int r;
>
>         num_xcc =3D amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> -       r =3D amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_pa=
rams,
> +       r =3D amdgpu_trap_validate_params(queue->userq_mgr->adev, trap_pa=
rams,
>                                         num_xcc);
>         if (r)
>                 return r;
> -       cwsr_size =3D amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num=
_xcc);
> +       cwsr_size =3D amdgpu_trap_size_needed(queue->userq_mgr->adev, num=
_xcc);
>         if (!cwsr_size)
>                 return -EOPNOTSUPP;
>
>         return amdgpu_userq_input_va_validate(
> -               adev, queue, cwsr_params->ctx_save_area_address, cwsr_siz=
e,
> +               adev, queue, trap_params->ctx_save_area_address, cwsr_siz=
e,
>                 &queue->userq_vas.va.cwsr);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 26f7fef3048c..3e19bc6103a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -44,7 +44,7 @@ enum amdgpu_userq_state {
>  };
>
>  struct amdgpu_mqd_prop;
> -struct amdgpu_cwsr_params;
> +struct amdgpu_trap_params;
>
>  struct amdgpu_userq_obj {
>         void             *cpu_ptr;
> @@ -200,8 +200,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_devi=
ce *adev,
>
>  void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>                                         struct amdgpu_bo_va_mapping *mapp=
ing);
> -int amdgpu_userq_input_cwsr_params_validate(
> -       struct amdgpu_usermode_queue *queue,
> -       struct amdgpu_cwsr_params *cwsr_params);
> +int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue=
 *queue,
> +                                           struct amdgpu_trap_params *tr=
ap_params);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 3fad95199e0c..6263f0f203af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -26,7 +26,7 @@
>  #include "amdgpu_gfx.h"
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> @@ -172,10 +172,10 @@ static int mes_userq_map(struct amdgpu_usermode_que=
ue *queue)
>                 queue_input.is_kfd_process =3D 1;
>                 queue_input.is_aql_queue =3D 1;
>         }
> -       if (fpriv->cwsr_trap) {
> -               queue_input.tba_addr =3D fpriv->cwsr_trap->tba_gpu_va_add=
r;
> -               queue_input.tma_addr =3D fpriv->cwsr_trap->tma_gpu_va_add=
r;
> -               queue_input.trap_en =3D !amdgpu_cwsr_has_dbg_wa(adev);
> +       if (fpriv->trap_obj) {
> +               queue_input.tba_addr =3D fpriv->trap_obj->tba_gpu_va_addr=
;
> +               queue_input.tma_addr =3D fpriv->trap_obj->tma_gpu_va_addr=
;
> +               queue_input.trap_en =3D !amdgpu_trap_has_dbg_wa(adev);
>         }
>
>         amdgpu_mes_lock(&adev->mes);
> @@ -455,7 +455,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermod=
e_queue *queue,
>
>         if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>                 struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> -               struct amdgpu_cwsr_params cwsr_params;
> +               struct amdgpu_trap_params trap_params;
>
>                 if (mqd_user->mqd_size !=3D sizeof(*compute_mqd)) {
>                         DRM_ERROR("Invalid compute IP MQD size\n");
> @@ -497,18 +497,17 @@ static int mes_userq_mqd_create(struct amdgpu_userm=
ode_queue *queue,
>                         mqd_user->flags &
>                         AMDGPU_USERQ_CREATE_FLAGS_QUEUE_AQL_COMPUTE;
>
> -               if (amdgpu_cwsr_is_enabled(adev)) {
> +               if (amdgpu_trap_is_enabled(adev)) {
>                         struct amdgpu_fpriv *fpriv =3D
>                                 uq_mgr_to_fpriv(queue->userq_mgr);
>                         int num_xcc;
>
>                         num_xcc =3D amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>                                                          fpriv->xcp_id);
> -                       cwsr_params.ctx_save_area_address =3D
> +                       trap_params.ctx_save_area_address =3D
>                                 compute_mqd->ctx_save_area_va;
> -                       cwsr_params.cwsr_sz =3D compute_mqd->ctx_save_are=
a_size;
> -                       r =3D amdgpu_userq_input_cwsr_params_validate(
> -                               queue, &cwsr_params);
> +                       trap_params.cwsr_sz =3D compute_mqd->ctx_save_are=
a_size;
> +                       r =3D amdgpu_userq_input_trap_params_validate(que=
ue, &trap_params);
>                         if (r) {
>                                 kfree(compute_mqd);
>                                 goto free_mqd;
> @@ -518,7 +517,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermod=
e_queue *queue,
>                         userq_props->ctx_save_area_size =3D
>                                 compute_mqd->ctx_save_area_size;
>                         userq_props->ctl_stack_size =3D
> -                               adev->cwsr_info->xcc_ctl_stack_sz * num_x=
cc;
> +                               adev->trap_info->cwsr.xcc_ctl_stack_sz * =
num_xcc;
>                 }
>
>                 kfree(compute_mqd);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 9222be9a6d2a..552cbf483543 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -59,7 +59,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_WAIT          0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>  #define DRM_AMDGPU_PROC_OPTIONS                0x1A
> -#define DRM_AMDGPU_CWSR                        0x1B
> +#define DRM_AMDGPU_TRAP                        0x1B
>
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -82,7 +82,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DR=
M_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  #define DRM_IOCTL_AMDGPU_PROC_OPTIONS  DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
> -#define DRM_IOCTL_AMDGPU_CWSR  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CW=
SR, union drm_amdgpu_cwsr)
> +#define DRM_IOCTL_AMDGPU_TRAP  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TR=
AP, union drm_amdgpu_trap)
>
>  /**
>   * DOC: memory domains
> @@ -1748,10 +1748,10 @@ struct drm_amdgpu_info_cwsr {
>  };
>
>  /* cwsr ioctl */
> -#define AMDGPU_CWSR_OP_SET_L2_TRAP 1
> +#define AMDGPU_TRAP_OP_SET_L2_TRAP 1
>
> -struct drm_amdgpu_cwsr_in {
> -       /* AMDGPU_CWSR_OP_* */
> +struct drm_amdgpu_trap_in {
> +       /* AMDGPU_TRAP_OP_* */
>         __u32 op;
>         struct {
>                 /* Level 2 trap handler base address */
> @@ -1765,8 +1765,8 @@ struct drm_amdgpu_cwsr_in {
>         } l2trap;
>  };
>
> -union drm_amdgpu_cwsr {
> -       struct drm_amdgpu_cwsr_in in;
> +union drm_amdgpu_trap {
> +       struct drm_amdgpu_trap_in in;
>  };
>  /*
>   * Supported GPU families
> --
> 2.34.1
>
