Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C075C5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 15:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A631E10E13F;
	Mon, 24 Aug 2026 15:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j4Afor+N";
	dkim-atps=neutral
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA3D10E13F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 15:06:42 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-45ef92f7cdeso223881fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 08:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787584001; cv=none;
 d=google.com; s=arc-20260327;
 b=dD1roQrbzKvv24nphyNWD3Nw2RR+87G9O4Rabfz+OmRmxE9vVKLev7p7bzgzFOP67d
 qYgbpT+uYhuBNRj/94wjSUXP8L+rs6gN1+gU+zqiOiM37NmNmOd+QisIf9+PVn5bmkZI
 s7A5/9HvWjKWPSTC6xqlXD0t8y4cXFqhCSDyP1m/Tl3NZAixnkD3F5UZpAjPGRdjAn//
 AA7lyDEGqjrP7C0UzRFm6tRlKXYuFQ1XutmmMTEtIEXN+UTL+BJ/++to7hqeWkH2gmML
 J3AazgTLtP/1yRVhc7uTJ5E0JHl6Iz7qmlyJTaTQz2OL909CICurmUk+aDFWI5cWRFjJ
 n24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uiIYk6NnZSEJJWXmN3NjncRUNRSw3hRYTGhn0B5QR2c=;
 fh=NwB9vAJJiX8ue2acVTqCVF7V5rcZnd01Rh4BmvTtNYA=;
 b=AvWaIs+DA2maHCmPnVus35nGI7Bwdz2jwxVaTliNET/n1yfIBFR5J4K/pZuWgKBa0N
 azVAgitoZa4c7WOQW3RKMW0aLjOHGEokL5EMJG8Mo2MH0JSVChTAwE0np81xMnk28e0K
 i5W1OYWIIv6HUyIZHtHBZfW6hqZgRloXRLUmEG2tbk0QFyFFvRIVEcUlQ07RWcI9vGBp
 LUx91BlK8RXtfbsnLSnZowK5KrUC/hlY37pTwR07Uvz5iD9pcuFbM4IzKbNUnzZWSYoP
 XzmY2vsJqUTD7cyaexJhXd2Ir3Gd+ns691m9umzVhkJjkWpBb/cT+IMOtvdzedsGHOXm
 bL5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787584001; x=1788188801; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uiIYk6NnZSEJJWXmN3NjncRUNRSw3hRYTGhn0B5QR2c=;
 b=j4Afor+N+hhusIQudeC5ERGmLfrIxCbDSQoA98VSHv3JsWow7Wl/32u71fJbBVgTsq
 1w8aHHeU3OiJ9YvRrX4hI5sw7WZI606iXG1qD2lkf/4JivXSu3U6djYAIqZfMwwRlBEp
 f8caCxGXEU9jpgzq0/cWRZsZJ8veZ/DbXP2VN2uGmOW2KfVda0ND1dG3KthUOaL/ET1e
 yWgalK3Gpyy51cNNnCO0FSXLZTj/pBpy4lwlVKLbEmj25mJqJJK6YRByQqfCXTRMZd56
 N3+atHPlPDpgqObavzF/pU7rChX6BvfPXoR5CjenPgB6ntJdeJN+yqmmV5cSpOF4MRYR
 aftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584001; x=1788188801;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uiIYk6NnZSEJJWXmN3NjncRUNRSw3hRYTGhn0B5QR2c=;
 b=N/e0RhxT5dnEKiXnaR9THlEG9weK5AWCJCFNKDKbX3Uzk0XwaygakEA4ePi9yfVX3D
 hC1UFWdMIZ+JjWeD/rcPUxXleUKqs91L8IGopJajPAPqPI5WC3kxTA5QV+wRbXPSGbGk
 b/Ce/iT0c1v6eSvgoVeA9TKkWfb/kLuLSeWYSBVEG4eM2ia9D57i29P2pwDUMoZmarKm
 v4qflPzsBqpp8vVmh2OQ/oXXfEx7LrO6xzy70OnKzggr4V5RD6jeqspXPwd6A7fIcp56
 6gEhbTlE3m6JVp0HRUyxsqzvyZpTWaXGeccCtzX2BZq4poO8cd4NLXyTktUJRvanJosb
 omhA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1+bg0SEnOPBYeg/Y6perVB33s9xSIxfDSa5VeexHzvNBiOTe9F1MXCe9IMM82BwYeNttah7o3@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8psPJE7gl9pBNhepx+uIAReDU+wTIlkmBki3vUcjZD+QXw5sj
 5Uc+VJfKuwCmf5Svg5onNk+/dftKr9VFygSAradRXJP0BVoI2peCdT27hwepllON4nHnUKs26wD
 FkGuXw/Q+PeeYV6mDvficBxqIga6MGQ8=
X-Gm-Gg: AR+sD11XMMds7dYBWEl/Mig3YA7c8ZZ9vPkMUEc1Bm42qmwPmUGG2HrpCKVbNOIo28d
 ZnUNZafn/Icp7OS3zXlZko73KuU4ymTBFwPBwJUcnAkOCWZEdqYkYs8iulv5JdzIezC1T6DYYoX
 d86JzsYOaECpEw7boinwgG4qifxSISfvgP5RprIgwvT3ssXaOQr2CUndJCXbPgX5k8zVm/leo7q
 J+XJuq5e4gRfUC0cmbGqNuYnDJU/9DMLWlE7sSXfYTxEyqeWCXZH/Nuetdn4pIr/eWeysbscJhG
 tQhZYtfz85AtXJM8c1ECt1OrO9lQEsAzOOlLIHIMKBpUr/74RSIJOJe77V1AJI4GWs0J7/EVHU7
 p5uPwqqevOXnA0UfFaVmmQ/ahMCr/dGs=
X-Received: by 2002:a05:6820:2f10:b0:6a3:6bb0:e58d with SMTP id
 006d021491bc7-6b158fc1100mr10477354eaf.0.1787584000381; Mon, 24 Aug 2026
 08:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260820073209.3939864-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260820073209.3939864-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Aug 2026 11:06:27 -0400
X-Gm-Features: AcwNN1WqLANQZgZ9EM4FoP3h0Cygi49OS31V45aJi6391VpTRUJcQcsU_XfFt80
Message-ID: <CADnq5_O0g9KhkZhY1jVfjYq+QA6GUHmNqv4Wn4C1XPQrP0ZSOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Rename amdgpu_cwsr to amdgpu_trap
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

On Thu, Aug 20, 2026 at 4:10=E2=80=AFAM Srinivasan Shanmugam
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
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  28 +-
>  .../amdgpu/{amdgpu_cwsr.c =3D> amdgpu_trap.c}   | 257 +++++++++---------
>  .../amdgpu/{amdgpu_cwsr.h =3D> amdgpu_trap.h}   |  44 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  16 +-
>  include/uapi/drm/amdgpu_drm.h                 |  14 +-
>  11 files changed, 195 insertions(+), 196 deletions(-)
>  rename drivers/gpu/drm/amd/amdgpu/{amdgpu_cwsr.c =3D> amdgpu_trap.c} (64=
%)
>  rename drivers/gpu/drm/amd/amdgpu/{amdgpu_cwsr.h =3D> amdgpu_trap.h} (66=
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
> index f8a30e52e2a0..610a1ffc5fb2 100644
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
> @@ -1495,21 +1495,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *filp)
>                 }
>         }
>         case AMDGPU_INFO_CWSR: {
> -               struct drm_amdgpu_info_cwsr cwsr_info;
> +               struct drm_amdgpu_info_cwsr trap_info;
>                 int num_xcc, r;
>
>                 fpriv =3D (struct amdgpu_fpriv *)filp->driver_priv;
> -               if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
> +               if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>                         return -EOPNOTSUPP;
>                 num_xcc =3D amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->=
xcp_id);
> -               cwsr_info.ctl_stack_size =3D
> -                       adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> -               cwsr_info.dbg_mem_size =3D
> -                       adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
> -               cwsr_info.min_save_area_size =3D
> -                       amdgpu_cwsr_size_needed(adev, num_xcc);
> -               r =3D copy_to_user(out, &cwsr_info,
> -                                min((size_t)size, sizeof(cwsr_info))) ?
> +               trap_info.ctl_stack_size =3D
> +                       adev->trap_info->xcc_ctl_stack_sz * num_xcc;
> +               trap_info.dbg_mem_size =3D
> +                       adev->trap_info->xcc_dbg_mem_sz * num_xcc;
> +               trap_info.min_save_area_size =3D
> +                       amdgpu_trap_size_needed(adev, num_xcc);
> +               r =3D copy_to_user(out, &trap_info,
> +                                min((size_t)size, sizeof(trap_info))) ?

This is actually cwsr related stuff so it should retain the cwsr
naming.  This stuff is related to the save areas used for CWSR.  To
make things clearer, add a cwsr info structure to the trap info
structure so we can keep the data cleanly separated.

>                             -EFAULT :
>                             0;
>                 return r;
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
> similarity index 64%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 7e5a08b0a1c8..c58b84b39d73 100644
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
> +              (adev->trap_info->xcc_cwsr_sz + adev->trap_info->xcc_dbg_m=
em_sz);
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
> +       trap_info->xcc_ctl_stack_sz =3D ctl_stack_size;
> +       trap_info->xcc_cwsr_sz =3D ctl_stack_size + wg_data_size;
> +       trap_info->xcc_dbg_mem_sz =3D dbg_mem_size;
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
> + * it maps virtual address amdgpu_trap_trap_handler_vaddr() to this VM, =
and each
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
> @@ -433,19 +433,19 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
>         return r;
>  }
>
> -int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> -                               struct amdgpu_cwsr_params *cwsr_params,
> +int amdgpu_trap_validate_params(struct amdgpu_device *adev,
> +                               struct amdgpu_trap_params *cwsr_params,
>                                 int num_xcc)
>  {
>         uint32_t min_size, max_size;
>
> -       if (!amdgpu_cwsr_is_enabled(adev))
> +       if (!amdgpu_trap_is_enabled(adev))
>                 return -EOPNOTSUPP;
>
>         if (!cwsr_params)
>                 return -EINVAL;
>
> -       min_size =3D amdgpu_cwsr_size_needed(adev, num_xcc);
> +       min_size =3D amdgpu_trap_size_needed(adev, num_xcc);
>         max_size =3D 2 * min_size;
>         /*
>          * Only save area size details checked. Address validation needs =
to be
> @@ -463,8 +463,8 @@ int amdgpu_cwsr_validate_params(struct amdgpu_device =
*adev,
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
> +       struct amdgpu_trap_usr_addr *tba)
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
> similarity index 66%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> index 06036954627e..c35ae6a11cfe 100644
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
> @@ -45,7 +45,7 @@ struct amdgpu_cwsr_trap_obj {
>         void *tma_cpu_addr;
>  };
>
> -struct amdgpu_cwsr_info {
> +struct amdgpu_trap_info {
>         /* cwsr isa */
>         struct amdgpu_bo *isa_bo;
>         const void *isa_buf;
> @@ -56,44 +56,44 @@ struct amdgpu_cwsr_info {
>         uint32_t xcc_cwsr_sz;
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
> +                     struct amdgpu_trap_obj **cwsr_obj);
> +void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                     struct amdgpu_trap_obj **cwsr_obj);
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
> +                               struct amdgpu_trap_params *cwsr_params,
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
> index feffebb210ea..fcc01e98569d 100644
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
> @@ -251,7 +251,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_devi=
ce *adev,
>
>  int amdgpu_userq_input_cwsr_params_validate(
>         struct amdgpu_usermode_queue *queue,
> -       struct amdgpu_cwsr_params *cwsr_params)
> +       struct amdgpu_trap_params *cwsr_params)

Here and below, rename cwsr_params to trap_params.

>  {
>         struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(queue->userq_mgr);
>         struct amdgpu_device *adev =3D queue->userq_mgr->adev;
> @@ -260,11 +260,11 @@ int amdgpu_userq_input_cwsr_params_validate(

rename amdgpu_userq_input_cwsr_params_validate() to
amdgpu_userq_input_trap_params_validate()

Alex

>         int r;
>
>         num_xcc =3D amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> -       r =3D amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_pa=
rams,
> +       r =3D amdgpu_trap_validate_params(queue->userq_mgr->adev, cwsr_pa=
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 26f7fef3048c..a6a8c50d1ae0 100644
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
> @@ -202,6 +202,6 @@ void amdgpu_userq_gem_va_unmap_validate(struct amdgpu=
_device *adev,
>                                         struct amdgpu_bo_va_mapping *mapp=
ing);
>  int amdgpu_userq_input_cwsr_params_validate(
>         struct amdgpu_usermode_queue *queue,
> -       struct amdgpu_cwsr_params *cwsr_params);
> +       struct amdgpu_trap_params *cwsr_params);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 3fad95199e0c..1704300622b2 100644
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
> +               struct amdgpu_trap_params cwsr_params;
>
>                 if (mqd_user->mqd_size !=3D sizeof(*compute_mqd)) {
>                         DRM_ERROR("Invalid compute IP MQD size\n");
> @@ -497,7 +497,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermod=
e_queue *queue,
>                         mqd_user->flags &
>                         AMDGPU_USERQ_CREATE_FLAGS_QUEUE_AQL_COMPUTE;
>
> -               if (amdgpu_cwsr_is_enabled(adev)) {
> +               if (amdgpu_trap_is_enabled(adev)) {
>                         struct amdgpu_fpriv *fpriv =3D
>                                 uq_mgr_to_fpriv(queue->userq_mgr);
>                         int num_xcc;
> @@ -518,7 +518,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermod=
e_queue *queue,
>                         userq_props->ctx_save_area_size =3D
>                                 compute_mqd->ctx_save_area_size;
>                         userq_props->ctl_stack_size =3D
> -                               adev->cwsr_info->xcc_ctl_stack_sz * num_x=
cc;
> +                               adev->trap_info->xcc_ctl_stack_sz * num_x=
cc;
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
