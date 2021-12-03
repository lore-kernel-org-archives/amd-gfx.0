Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EC1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 16:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C186E824;
	Fri,  3 Dec 2021 16:13:31 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF966E94F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 16:13:30 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id q25so6850286oiw.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Dec 2021 08:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bekIFSE+X7JqRl18wp3jrA+tORMcrtSirGttycTAOuI=;
 b=Lb72arm0nroSJF1SqkDrGssTAY2WjN/Mp8tv3wiT9zGHD3fjl1j1EukfZHfhgxqkQk
 0ZjA0UkR6WK4lKrwTcWmFy4AMAMLtJpZqIe+Qap09YKDw8IWTf/sPLE/oW4stT5SVUcU
 g+9FePzeRwN6hGCYvrL0WdJYGWn9wE4s0mgjQmpxbIzHo4R5tUVcubYWDhvypN9KJY1K
 bYddFFOoY6hIKbm1scViNzvVIokhHTHTLevEkRtLLAvI9YTr18y9qVggsnRkFiFt5TGG
 NTMpXmxJsVyE8zp3ynPCbyQIyUNTaqWyJ87MWw+5J65jmbX8nRl8UF/A1WmTqWJ4fnMA
 Zapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bekIFSE+X7JqRl18wp3jrA+tORMcrtSirGttycTAOuI=;
 b=JRgon2Hk8uukmZusS7YqkkrRyAFEa6+s3DkLTNR1T4JQPs6PihHMm9PBMvxYaL5Vrx
 DtxR9o7JtgLybbkxAGtt/EraLtyBfbsYoezgVTVQQpQd91EQG4soWrILvjSNDIr7yzy/
 yXTJw+MW9fErKaCsXqMv272W+KnYPBadAP2s2ElGhaIwbHiK7rlwi+SLRtbe/Aa+Pzq2
 HahTjWwHimxPWeIWl2JXfihAMxxJqkPuwWTkZ8qj44pA73TfdFD0J/6U51AIFT30nmBv
 2cpGiBIoRrm6PHQz754bqXRfIfuwd34AZRq0SSHbwCUzt6+EkeWbQ7eBckzEgJlrvTSQ
 /B3A==
X-Gm-Message-State: AOAM533C2sgHQMlyAqOgLLlQV+pbCXTYG2giuqmHefX9HdW4oUld/u6B
 jxFkbQBd9sDXqlSUfJGpZRckdO58tpuoDONE42U=
X-Google-Smtp-Source: ABdhPJy61rjqSv7N1wGKFQeJsMvzeuXShPxIcVorNhHNQ3qvLVnOwjR144+5ZWVDGTrY9U4W2QKnwkl0WC2qcYnE9Io=
X-Received: by 2002:a05:6808:68f:: with SMTP id
 k15mr10302094oig.5.1638548009619; 
 Fri, 03 Dec 2021 08:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20211202191912.6148-1-alexander.deucher@amd.com>
 <b05f1327-b26d-ac47-4bac-f94979bd3741@gmail.com>
In-Reply-To: <b05f1327-b26d-ac47-4bac-f94979bd3741@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Dec 2021 11:13:18 -0500
Message-ID: <CADnq5_OgW3vfG5kjV-67KYc4RxavJeZOWvNEo5vm9siHj2B0HA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000000fa86c05d24030d6"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000000fa86c05d24030d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 3, 2021 at 7:15 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 02.12.21 um 20:19 schrieb Alex Deucher:
> > This adds a new IOCTL currently used to implement querying
> > and setting the stable power state for GPU profiling.  The
> > stable pstates use fixed clocks and disable certain power
> > features in order to get accurate pipeline profiling.
> >
> > Currently this is handled via sysfs, and that is still
> > available, but this makes it easier for applications
> > to utilize.  Note that the power state is global so
> > setting it will affect all applications.  There are currently
> > no checks in place to prevent multiple applications from
> > using this interface, but it doesn't make sense to do
> > profiling while you have multiple applications running in the
> > first place, so it's up to the user to ensure this in order
> > to get good results.
> >
> > This patch add an interface to query what profiling mode is
> > currently active and to set enable a profiling mode.
>
> First of all I wouldn't call this profiling mode. Profiling is the use
> case, but performance and power management are what is controlled here.
>

Ok.

> Then we already have functionality for process and context priority
> override for the SW scheduler in amdgpu_sched.c. I think we should add
> this functionality there.

I'm not sure I follow.  Do you mean to integrate this with the
rendering context?  That was what my original patch did (attached).
Or were you thinking it would be better to make this part of the sched
ioctl?

Alex


>
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c | 112 +++++++++++++++++++=
+
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h |  30 ++++++
> >   include/uapi/drm/amdgpu_drm.h               |  28 +++++
> >   5 files changed, 173 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/=
amdgpu/Makefile
> > index 7fedbb725e17..4cf5bf637a9e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > @@ -58,7 +58,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
> >       amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nb=
io.o \
> >       amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
> >       amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
> > -     amdgpu_eeprom.o amdgpu_mca.o
> > +     amdgpu_eeprom.o amdgpu_mca.o amdgpu_profile.o
> >
> >   amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index bc1355c6248d..0e27f9673f8f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -46,6 +46,7 @@
> >   #include "amdgpu_sched.h"
> >   #include "amdgpu_fdinfo.h"
> >   #include "amdgpu_amdkfd.h"
> > +#include "amdgpu_profile.h"
> >
> >   #include "amdgpu_ras.h"
> >   #include "amdgpu_xgmi.h"
> > @@ -2467,6 +2468,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =
=3D {
> >       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DR=
M_RENDER_ALLOW),
> >       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DR=
M_RENDER_ALLOW),
> >       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, D=
RM_AUTH|DRM_RENDER_ALLOW),
> > +     DRM_IOCTL_DEF_DRV(AMDGPU_PROFILE, amdgpu_profile_ioctl, DRM_AUTH|=
DRM_RENDER_ALLOW),
> >   };
> >
> >   static const struct drm_driver amdgpu_kms_driver =3D {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_profile.c
> > new file mode 100644
> > index 000000000000..94fe408e810f
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> > @@ -0,0 +1,112 @@
> > +/*
> > + * Copyright 2021 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> > + * copy of this software and associated documentation files (the "Soft=
ware"),
> > + * to deal in the Software without restriction, including without limi=
tation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> > + * and/or sell copies of the Software, and to permit persons to whom t=
he
> > + * Software is furnished to do so, subject to the following conditions=
:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + */
> > +
> > +#include <drm/amdgpu_drm.h>
> > +#include "amdgpu.h"
> > +
> > +/**
> > + * amdgpu_profile_ioctl - Manages settings for profiling.
> > + *
> > + * @dev: drm device pointer
> > + * @data: drm_amdgpu_vm
> > + * @filp: drm file pointer
> > + *
> > + * Returns:
> > + * 0 for success, -errno for errors.
> > + */
> > +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
> > +                      struct drm_file *filp)
> > +{
> > +     union drm_amdgpu_profile *args =3D data;
> > +     struct amdgpu_device *adev =3D drm_to_adev(dev);
> > +     const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> > +     enum amd_dpm_forced_level current_level, requested_level;
> > +     int r;
> > +
> > +     if (pp_funcs->get_performance_level)
> > +             current_level =3D amdgpu_dpm_get_performance_level(adev);
> > +     else
> > +             current_level =3D adev->pm.dpm.forced_level;
> > +
> > +     switch (args->in.op) {
> > +     case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
> > +             if (args->in.flags)
> > +                     return -EINVAL;
> > +             switch (current_level) {
> > +             case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> > +                     args->out.flags =3D AMDGPU_PROFILE_FLAGS_STABLE_P=
STATE_STANDARD;
> > +                     break;
> > +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> > +                     args->out.flags =3D AMDGPU_PROFILE_FLAGS_STABLE_P=
STATE_MIN_SCLK;
> > +                     break;
> > +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> > +                     args->out.flags =3D AMDGPU_PROFILE_FLAGS_STABLE_P=
STATE_MIN_MCLK;
> > +                     break;
> > +             case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> > +                     args->out.flags =3D AMDGPU_PROFILE_FLAGS_STABLE_P=
STATE_PEAK;
> > +                     break;
> > +             default:
> > +                     args->out.flags =3D AMDGPU_PROFILE_FLAGS_STABLE_P=
STATE_NONE;
> > +                     break;
> > +             }
> > +             break;
> > +     case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
> > +             if (args->in.flags & ~AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_=
MASK)
> > +                     return -EINVAL;
> > +             switch (args->in.flags & AMDGPU_PROFILE_FLAGS_STABLE_PSTA=
TE_MASK) {
> > +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
> > +                     requested_level =3D AMD_DPM_FORCED_LEVEL_PROFILE_=
STANDARD;
> > +                     break;
> > +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
> > +                     requested_level =3D AMD_DPM_FORCED_LEVEL_PROFILE_=
MIN_SCLK;
> > +                     break;
> > +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
> > +                     requested_level =3D AMD_DPM_FORCED_LEVEL_PROFILE_=
MIN_MCLK;
> > +                     break;
> > +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
> > +                     requested_level =3D AMD_DPM_FORCED_LEVEL_PROFILE_=
PEAK;
> > +                     break;
> > +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
> > +                     requested_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if ((current_level !=3D requested_level) && pp_funcs->for=
ce_performance_level) {
> > +                     mutex_lock(&adev->pm.mutex);
> > +                     r =3D amdgpu_dpm_force_performance_level(adev, re=
quested_level);
> > +                     if (!r)
> > +                             adev->pm.dpm.forced_level =3D requested_l=
evel;
> > +                     mutex_unlock(&adev->pm.mutex);
> > +                     if (r)
> > +                             return r;
> > +             }
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_profile.h
> > new file mode 100644
> > index 000000000000..cd1c597bae11
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> > @@ -0,0 +1,30 @@
> > +/*
> > + * Copyright 2021 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> > + * copy of this software and associated documentation files (the "Soft=
ware"),
> > + * to deal in the Software without restriction, including without limi=
tation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> > + * and/or sell copies of the Software, and to permit persons to whom t=
he
> > + * Software is furnished to do so, subject to the following conditions=
:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + */
> > +
> > +#ifndef __AMDGPU_PROFILE_H__
> > +#define __AMDGPU_PROFILE_H__
> > +
> > +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
> > +                      struct drm_file *filp);
> > +
> > +#endif
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index 26e45fc5eb1a..b6edf4a826f9 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -54,6 +54,7 @@ extern "C" {
> >   #define DRM_AMDGPU_VM                       0x13
> >   #define DRM_AMDGPU_FENCE_TO_HANDLE  0x14
> >   #define DRM_AMDGPU_SCHED            0x15
> > +#define DRM_AMDGPU_PROFILE           0x16
> >
> >   #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >   #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> > @@ -71,6 +72,7 @@ extern "C" {
> >   #define DRM_IOCTL_AMDGPU_VM         DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_VM, union drm_amdgpu_vm)
> >   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + =
DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> >   #define DRM_IOCTL_AMDGPU_SCHED              DRM_IOW(DRM_COMMAND_BASE =
+ DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> > +#define DRM_IOCTL_AMDGPU_PROFILE     DRM_IOW(DRM_COMMAND_BASE + DRM_AM=
DGPU_PROFILE, union drm_amdgpu_profile)
> >
> >   /**
> >    * DOC: memory domains
> > @@ -1120,6 +1122,32 @@ struct drm_amdgpu_info_video_caps {
> >       struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VI=
DEO_CAPS_CODEC_IDX_COUNT];
> >   };
> >
> > +/* profile ioctl */
> > +#define AMDGPU_PROFILE_OP_GET_STABLE_PSTATE  1
> > +#define AMDGPU_PROFILE_OP_SET_STABLE_PSTATE  2
> > +
> > +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK      0xf
> > +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE      0
> > +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD  1
> > +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK  2
> > +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK  3
> > +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK      4
> > +
> > +struct drm_amdgpu_profile_in {
> > +     /** AMDGPU_PROFILE_OP_* */
> > +     __u32   op;
> > +     __u32   flags;
> > +};
> > +
> > +struct drm_amdgpu_profile_out {
> > +     __u64   flags;
> > +};
> > +
> > +union drm_amdgpu_profile {
> > +     struct drm_amdgpu_profile_in in;
> > +     struct drm_amdgpu_profile_out out;
> > +};
> > +
> >   /*
> >    * Supported GPU families
> >    */
>

--0000000000000fa86c05d24030d6
Content-Type: text/x-patch; charset="US-ASCII"; name="original.patch"
Content-Disposition: attachment; filename="original.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kwql1y330>
X-Attachment-Id: f_kwql1y330

Y29tbWl0IDAzY2UzOGI0ZjVmYzlkNDM4MjBjNjY5Y2JhN2JkOGMwM2UzYmRjMDIKQXV0aG9yOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkRhdGU6ICAgV2VkIERlYyAx
IDE2OjE3OjEzIDIwMjEgLTA1MDAKCiAgICBkcm0vYW1kZ3B1L1VBUEk6IGFkZCBuZXcgQ1RYIE9Q
IGZvciBzZXR0aW5nIHByb2ZpbGUgbW9kZXMKICAgIAogICAgQWRkIGEgbmV3IENUWCBpb2N0bCBv
cGVyYXRpb24gdG8gc2V0IHByb2ZpbGUgbW9kZXMuICBXaGVuCiAgICBjcmVhdGluZyB0cmFjZXMg
Zm9yIHRvb2xzIGxpa2UgUkdQIG9yIHVzaW5nIFNQTSBvciBkb2luZwogICAgcGVyZm9ybWFuY2Ug
cHJvZmlsaW5nLCBpdCdzIHJlcXVpcmVkIHRvIGVuYWJsZSBhIHNwZWNpYWwKICAgIHN0YWJsZSBw
cm9maWxpbmcgcG93ZXIgc3RhdGUgb24gdGhlIEdQVS4gIFRoZXNlIHByb2ZpbGluZwogICAgc3Rh
dGVzIHNldCBmaXhlZCBjbG9ja3MgYW5kIGRpc2FibGUgY2VydGFpbiBvdGhlciBwb3dlcgogICAg
ZmVhdHVyZXMgbGlrZSBwb3dlcmdhdGluZyB3aGljaCBtYXkgaW1wYWN0IHRoZSByZXN1bHRzLgog
ICAgCiAgICBIaXN0b3JpY2FsbHksIHRoZXNlIHByb2ZpbGVzIHdlcmUgZW5hYmxlZCB2aWEgc3lz
ZnMsIGJ1dAogICAgdGhpcyBhZGRzIGFuIGludGVyZmFjZSB0byBlbmFibGUgaXQgdmlhIHRoZSBD
VFggaW9jdGwKICAgIGZyb20gdGhlIGFwcGxpY2F0aW9uLiAgU2luY2UgdGhlIHBvd2VyIHN0YXRl
IGlzIGdsb2JhbAogICAgb25seSBvbmUgYXBwbGljYXRpb24gY2FuIHNldCBpdCBhdCBhIHRpbWUs
IHNvIGlmIG11bHRpcGxlCiAgICBhcHBsaWNhdGlvbnMgdHJ5IGFuZCB1c2UgaXQgb25seSB0aGUg
Zmlyc3Qgd2lsbCBnZXQgaXQsCiAgICB0aGUgaW9jdGwgd2lsbCByZXR1cm4gLUVCVVNZIGZvciBv
dGhlcnMuCiAgICAKICAgIFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCmluZGV4IGM1Y2Zl
MjkyNmNhMS4uOTViODkwOGJkMmU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHUuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaApA
QCAtMTA5Nyw2ICsxMDk3LDkgQEAgc3RydWN0IGFtZGdwdV9kZXZpY2UgewogCiAJc3RydWN0IGFt
ZGdwdV9yZXNldF9jb250cm9sICAgICAqcmVzZXRfY250bDsKIAl1aW50MzJfdCAgICAgICAgICAg
ICAgICAgICAgICAgIGlwX3ZlcnNpb25zW01BWF9IV0lQXVtIV0lQX01BWF9JTlNUQU5DRV07CisK
KwlzdHJ1Y3QgbXV0ZXggICAgICAgICAgICAgICAgICAgIHBzdGF0ZV9wcm9maWxlX2N0eF9sb2Nr
OworCXN0cnVjdCBhbWRncHVfY3R4ICAgICAgICAgICAgICAgKnBzdGF0ZV9wcm9maWxlX2N0eDsK
IH07CiAKIHN0YXRpYyBpbmxpbmUgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmRybV90b19hZGV2KHN0
cnVjdCBkcm1fZGV2aWNlICpkZGV2KQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0
eC5jCmluZGV4IDQ2ODAwMzU4M2IyYS4uYmY4YTU5MzllNDQ0IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2N0eC5jCkBAIC0yMzcsNiArMjM3LDcgQEAgc3RhdGljIGludCBhbWRn
cHVfY3R4X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJY3R4LT52cmFtX2xvc3Rf
Y291bnRlciA9IGF0b21pY19yZWFkKCZhZGV2LT52cmFtX2xvc3RfY291bnRlcik7CiAJY3R4LT5p
bml0X3ByaW9yaXR5ID0gcHJpb3JpdHk7CiAJY3R4LT5vdmVycmlkZV9wcmlvcml0eSA9IEFNREdQ
VV9DVFhfUFJJT1JJVFlfVU5TRVQ7CisJY3R4LT5wc3RhdGVfcHJvZmlsZSA9IEFNREdQVV9DVFhf
UFNUQVRFX1BST0ZJTEVfTk9ORTsKIAogCXJldHVybiAwOwogfQpAQCAtMjU1LDYgKzI1Niw2NyBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfY3R4X2ZpbmlfZW50aXR5KHN0cnVjdCBhbWRncHVfY3R4X2Vu
dGl0eSAqZW50aXR5KQogCWtmcmVlKGVudGl0eSk7CiB9CiAKK3N0YXRpYyBpbnQgYW1kZ3B1X2N0
eF9kb19zZXRfcHN0YXRlX3Byb2ZpbGUoc3RydWN0IGFtZGdwdV9jdHggKmN0eCwKKwkJCQkJICAg
IHUzMiBwc3RhdGVfcHJvZmlsZSkKK3sKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGN0
eC0+YWRldjsKKwljb25zdCBzdHJ1Y3QgYW1kX3BtX2Z1bmNzICpwcF9mdW5jcyA9IGFkZXYtPnBv
d2VycGxheS5wcF9mdW5jczsKKwllbnVtIGFtZF9kcG1fZm9yY2VkX2xldmVsIGxldmVsLCBjdXJy
ZW50X2xldmVsOworCWludCByID0gMDsKKworCWlmICghY3R4KQorCQlyZXR1cm4gLUVJTlZBTDsK
KworCW11dGV4X2xvY2soJmFkZXYtPnBzdGF0ZV9wcm9maWxlX2N0eF9sb2NrKTsKKwlpZiAoYWRl
di0+cHN0YXRlX3Byb2ZpbGVfY3R4ICYmIGFkZXYtPnBzdGF0ZV9wcm9maWxlX2N0eCAhPSBjdHgp
IHsKKwkJciA9IC1FQlVTWTsKKwkJZ290byBkb25lOworCX0KKworCXN3aXRjaCAocHN0YXRlX3By
b2ZpbGUpIHsKKwljYXNlIEFNREdQVV9DVFhfUFNUQVRFX1BST0ZJTEVfTk9ORToKKwkJbGV2ZWwg
PSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9BVVRPOworCQlicmVhazsKKwljYXNlIEFNREdQVV9DVFhf
UFNUQVRFX1BST0ZJTEVfU1RBTkRBUkQ6CisJCWxldmVsID0gQU1EX0RQTV9GT1JDRURfTEVWRUxf
UFJPRklMRV9TVEFOREFSRDsKKwkJYnJlYWs7CisJY2FzZSBBTURHUFVfQ1RYX1BTVEFURV9QUk9G
SUxFX01JTl9TQ0xLOgorCQlsZXZlbCA9IEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVfTUlO
X1NDTEs7CisJCWJyZWFrOworCWNhc2UgQU1ER1BVX0NUWF9QU1RBVEVfUFJPRklMRV9NSU5fTUNM
SzoKKwkJbGV2ZWwgPSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9QUk9GSUxFX01JTl9NQ0xLOworCQli
cmVhazsKKwljYXNlIEFNREdQVV9DVFhfUFNUQVRFX1BST0ZJTEVfUEVBSzoKKwkJbGV2ZWwgPSBB
TURfRFBNX0ZPUkNFRF9MRVZFTF9QUk9GSUxFX1BFQUs7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJ
CXIgPSAtRUlOVkFMOworCQlnb3RvIGRvbmU7CisJfQorCisJaWYgKHBwX2Z1bmNzLT5nZXRfcGVy
Zm9ybWFuY2VfbGV2ZWwpCisJCWN1cnJlbnRfbGV2ZWwgPSBhbWRncHVfZHBtX2dldF9wZXJmb3Jt
YW5jZV9sZXZlbChhZGV2KTsKKwllbHNlCisJCWN1cnJlbnRfbGV2ZWwgPSBhZGV2LT5wbS5kcG0u
Zm9yY2VkX2xldmVsOworCisJaWYgKChjdXJyZW50X2xldmVsICE9IGxldmVsKSAmJiBwcF9mdW5j
cy0+Zm9yY2VfcGVyZm9ybWFuY2VfbGV2ZWwpIHsKKwkJbXV0ZXhfbG9jaygmYWRldi0+cG0ubXV0
ZXgpOworCQlyID0gYW1kZ3B1X2RwbV9mb3JjZV9wZXJmb3JtYW5jZV9sZXZlbChhZGV2LCBsZXZl
bCk7CisJCWlmICghcikKKwkJCWFkZXYtPnBtLmRwbS5mb3JjZWRfbGV2ZWwgPSBsZXZlbDsKKwkJ
bXV0ZXhfdW5sb2NrKCZhZGV2LT5wbS5tdXRleCk7CisJfQorCisJaWYgKGxldmVsID09IEFNRF9E
UE1fRk9SQ0VEX0xFVkVMX0FVVE8pCisJCWFkZXYtPnBzdGF0ZV9wcm9maWxlX2N0eCA9IE5VTEw7
CisJZWxzZQorCQlhZGV2LT5wc3RhdGVfcHJvZmlsZV9jdHggPSBjdHg7Citkb25lOgorCW11dGV4
X3VubG9jaygmYWRldi0+cHN0YXRlX3Byb2ZpbGVfY3R4X2xvY2spOworCisJcmV0dXJuIHI7Cit9
CisKIHN0YXRpYyB2b2lkIGFtZGdwdV9jdHhfZmluaShzdHJ1Y3Qga3JlZiAqcmVmKQogewogCXN0
cnVjdCBhbWRncHVfY3R4ICpjdHggPSBjb250YWluZXJfb2YocmVmLCBzdHJ1Y3QgYW1kZ3B1X2N0
eCwgcmVmY291bnQpOwpAQCAtMjcwLDcgKzMzMiw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9jdHhf
ZmluaShzdHJ1Y3Qga3JlZiAqcmVmKQogCQkJY3R4LT5lbnRpdGllc1tpXVtqXSA9IE5VTEw7CiAJ
CX0KIAl9Ci0KKwlhbWRncHVfY3R4X2RvX3NldF9wc3RhdGVfcHJvZmlsZShjdHgsIEFNREdQVV9D
VFhfUFNUQVRFX1BST0ZJTEVfTk9ORSk7CiAJbXV0ZXhfZGVzdHJveSgmY3R4LT5sb2NrKTsKIAlr
ZnJlZShjdHgpOwogfQpAQCAtNDY3LDExICs1MjksMzggQEAgc3RhdGljIGludCBhbWRncHVfY3R4
X3F1ZXJ5MihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlyZXR1cm4gMDsKIH0KIAorCisK
K3N0YXRpYyBpbnQgYW1kZ3B1X2N0eF9zZXRfcHN0YXRlX3Byb2ZpbGUoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCisJCQkJCSBzdHJ1Y3QgYW1kZ3B1X2Zwcml2ICpmcHJpdiwgdWludDMyX3Qg
aWQsCisJCQkJCSB1MzIgcHN0YXRlX3Byb2ZpbGUpCit7CisJc3RydWN0IGFtZGdwdV9jdHggKmN0
eDsKKwlzdHJ1Y3QgYW1kZ3B1X2N0eF9tZ3IgKm1ncjsKKwlpbnQgcjsKKworCWlmICghZnByaXYp
CisJCXJldHVybiAtRUlOVkFMOworCisJbWdyID0gJmZwcml2LT5jdHhfbWdyOworCW11dGV4X2xv
Y2soJm1nci0+bG9jayk7CisJY3R4ID0gaWRyX2ZpbmQoJm1nci0+Y3R4X2hhbmRsZXMsIGlkKTsK
KwlpZiAoIWN0eCkgeworCQltdXRleF91bmxvY2soJm1nci0+bG9jayk7CisJCXJldHVybiAtRUlO
VkFMOworCX0KKworCXIgPSBhbWRncHVfY3R4X2RvX3NldF9wc3RhdGVfcHJvZmlsZShjdHgsIHBz
dGF0ZV9wcm9maWxlKTsKKworCW11dGV4X3VubG9jaygmbWdyLT5sb2NrKTsKKwlyZXR1cm4gcjsK
K30KKwogaW50IGFtZGdwdV9jdHhfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAq
ZGF0YSwKIAkJICAgICBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHApCiB7CiAJaW50IHI7Ci0JdWludDMy
X3QgaWQ7CisJdWludDMyX3QgaWQsIHBzdGF0ZV9wcm9maWxlOwogCWludDMyX3QgcHJpb3JpdHk7
CiAKIAl1bmlvbiBkcm1fYW1kZ3B1X2N0eCAqYXJncyA9IGRhdGE7CkBAIC01MDAsNiArNTg5LDE0
IEBAIGludCBhbWRncHVfY3R4X2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRh
dGEsCiAJY2FzZSBBTURHUFVfQ1RYX09QX1FVRVJZX1NUQVRFMjoKIAkJciA9IGFtZGdwdV9jdHhf
cXVlcnkyKGFkZXYsIGZwcml2LCBpZCwgJmFyZ3MtPm91dCk7CiAJCWJyZWFrOworCWNhc2UgQU1E
R1BVX0NUWF9PUF9TRVRfUFNUQVRFX1BST0ZJTEU6CisJCWlmIChhcmdzLT5pbi5mbGFncyAmIH5B
TURHUFVfQ1RYX1BTVEFURV9QUk9GSUxFX0ZMQUdTX01BU0spCisJCQlyZXR1cm4gLUVJTlZBTDsK
KwkJcHN0YXRlX3Byb2ZpbGUgPSBhcmdzLT5pbi5mbGFncyAmIEFNREdQVV9DVFhfUFNUQVRFX1BS
T0ZJTEVfRkxBR1NfTUFTSzsKKwkJaWYgKHBzdGF0ZV9wcm9maWxlID4gQU1ER1BVX0NUWF9QU1RB
VEVfUFJPRklMRV9QRUFLKQorCQkJcmV0dXJuIC1FSU5WQUw7CisJCXIgPSBhbWRncHVfY3R4X3Nl
dF9wc3RhdGVfcHJvZmlsZShhZGV2LCBmcHJpdiwgaWQsIHBzdGF0ZV9wcm9maWxlKTsKKwkJYnJl
YWs7CiAJZGVmYXVsdDoKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2N0eC5oCmluZGV4IGE0NGI4YjhlZDM5Yy4uNzAwN2VjOTQ1MGRkIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmgKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5oCkBAIC01Myw2ICs1Myw3IEBAIHN0
cnVjdCBhbWRncHVfY3R4IHsKIAlhdG9taWNfdAkJCWd1aWx0eTsKIAl1bnNpZ25lZCBsb25nCQkJ
cmFzX2NvdW50ZXJfY2U7CiAJdW5zaWduZWQgbG9uZwkJCXJhc19jb3VudGVyX3VlOworCXVpbnQz
Ml90CQkJcHN0YXRlX3Byb2ZpbGU7CiB9OwogCiBzdHJ1Y3QgYW1kZ3B1X2N0eF9tZ3IgewpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IGExYzE0NDY2ZjIz
ZC4uYzcyZTYxNTMyMzlhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jCkBAIC0zNDUyLDYgKzM0NTIsNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogCWluaXRfcndzZW0oJmFkZXYtPnJlc2V0X3NlbSk7CiAJ
bXV0ZXhfaW5pdCgmYWRldi0+cHNwLm11dGV4KTsKIAltdXRleF9pbml0KCZhZGV2LT5ub3RpZmll
cl9sb2NrKTsKKwltdXRleF9pbml0KCZhZGV2LT5wc3RhdGVfcHJvZmlsZV9jdHhfbG9jayk7CiAK
IAlyID0gYW1kZ3B1X2RldmljZV9pbml0X2FwdV9mbGFncyhhZGV2KTsKIAlpZiAocikKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oIGIvaW5jbHVkZS91YXBpL2RybS9h
bWRncHVfZHJtLmgKaW5kZXggYjlkNjgzMzkxMDNkLi5hNGMyZjdkYzJmNzcgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCisrKyBiL2luY2x1ZGUvdWFwaS9kcm0vYW1k
Z3B1X2RybS5oCkBAIC0yMDYsNiArMjA2LDcgQEAgdW5pb24gZHJtX2FtZGdwdV9ib19saXN0IHsK
ICNkZWZpbmUgQU1ER1BVX0NUWF9PUF9GUkVFX0NUWAkyCiAjZGVmaW5lIEFNREdQVV9DVFhfT1Bf
UVVFUllfU1RBVEUJMwogI2RlZmluZSBBTURHUFVfQ1RYX09QX1FVRVJZX1NUQVRFMgk0CisjZGVm
aW5lIEFNREdQVV9DVFhfT1BfU0VUX1BTVEFURV9QUk9GSUxFCTUKIAogLyogR1BVIHJlc2V0IHN0
YXR1cyAqLwogI2RlZmluZSBBTURHUFVfQ1RYX05PX1JFU0VUCQkwCkBAIC0yMzgsNiArMjM5LDE0
IEBAIHVuaW9uIGRybV9hbWRncHVfYm9fbGlzdCB7CiAjZGVmaW5lIEFNREdQVV9DVFhfUFJJT1JJ
VFlfSElHSCAgICAgICAgNTEyCiAjZGVmaW5lIEFNREdQVV9DVFhfUFJJT1JJVFlfVkVSWV9ISUdI
ICAgMTAyMwogCisvKiBzZWxlY3QgYSBwcm9maWxpbmcgcHN0YXRlIGZvciBwZXJmbW9uIHRvb2xz
ICovCisjZGVmaW5lIEFNREdQVV9DVFhfUFNUQVRFX1BST0ZJTEVfRkxBR1NfTUFTSyAgMHhmCisj
ZGVmaW5lIEFNREdQVV9DVFhfUFNUQVRFX1BST0ZJTEVfTk9ORSAgMAorI2RlZmluZSBBTURHUFVf
Q1RYX1BTVEFURV9QUk9GSUxFX1NUQU5EQVJEICAxCisjZGVmaW5lIEFNREdQVV9DVFhfUFNUQVRF
X1BST0ZJTEVfTUlOX1NDTEsgIDIKKyNkZWZpbmUgQU1ER1BVX0NUWF9QU1RBVEVfUFJPRklMRV9N
SU5fTUNMSyAgMworI2RlZmluZSBBTURHUFVfQ1RYX1BTVEFURV9QUk9GSUxFX1BFQUsgIDQKKwog
c3RydWN0IGRybV9hbWRncHVfY3R4X2luIHsKIAkvKiogQU1ER1BVX0NUWF9PUF8qICovCiAJX191
MzIJb3A7Cg==
--0000000000000fa86c05d24030d6--
