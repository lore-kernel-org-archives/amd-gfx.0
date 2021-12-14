Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7EAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 14:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2224310E11D;
	Tue, 14 Dec 2021 14:53:52 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671AA10E547
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 14:53:51 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id t19so27488681oij.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 06:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GcazLdfqSZ+zmcwX6eDIxkOedbR4ZKd1nNHvpOgVRGg=;
 b=MNtzfnGyijJF7kqh8kzkovMZn86mJypSFjNTVkep7xtxZsJKPUgnmrCC6bEqOkPE8K
 pLDZSaiK9518ikBXB/0qTZJL5GxLLzcXSsu1cf5/PV5H7BQ/Iz9ogI8uQbVWcZ7jHCTS
 szudA/yyImbK/kB2OCCvVHmNie3mJ1UjrSkwk2fdFOgbLTVBtgod1sCtpqjS+NbVrncA
 8NU3AN4xxM5y4jEyd9tN6bP53BIvUju7zRhLpCDcK05iOpD+0/ZVQ1A4vPrmhKAhi6u/
 nkccgvosWcgaoXd1Plj9ZwUA5LjyQp102wIvARwS1nALUDiyTCCgZJzQgJ7A2TMPCETz
 nVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GcazLdfqSZ+zmcwX6eDIxkOedbR4ZKd1nNHvpOgVRGg=;
 b=cUQGMdkgFMMuX87XyCSZ0clDwvod5Na9p9/2HZLxM0kpnHNB6YlGqa/NeuIzt8ZzwX
 e2oAOnX29MhYIAxKlqVrt7BPJX81wwI1f4SHd+VBOVWV6NxaSJOi8ZfGZ7GiTAHirfsN
 mw+Bpk+VbHnTmoLCEdOhJTCzUtsX9G97bToJEoAIkHef5hQ+Z7XA72fyrko8jpoHAwaP
 m2l37C0ypxOqxW9DqocfN378oYZdwl/MYzgXQJwza/ydo/53Bha2LCTsg/p/2dkDow/r
 9cWJ7n8dTrCz6tWNCkCxjDQbxtRG36pQeooVso9SW1k4zy1E4JySdoUy5Pqh9Ovgb9Qp
 ptDw==
X-Gm-Message-State: AOAM533DOz8uKOfIN3rbEBmbx7POxBFeM1SmrfznlPYH99yyfYixo2Pl
 6HuaPRAdcZc3f7Ae/wr9jYAn0hGBM1YTOcOWfsU=
X-Google-Smtp-Source: ABdhPJxP9ONUOVp2pLd8A2mDppQzUui5fAFWk003hiFZqPMX1zpeVHB2oIOiv6SVlqj8S31DKiIfx9bigQSuK9wwl9U=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr4615655oib.120.1639493630246; 
 Tue, 14 Dec 2021 06:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20211202191912.6148-1-alexander.deucher@amd.com>
 <b05f1327-b26d-ac47-4bac-f94979bd3741@gmail.com>
 <CADnq5_OgW3vfG5kjV-67KYc4RxavJeZOWvNEo5vm9siHj2B0HA@mail.gmail.com>
 <79ab8197-890a-494d-6687-de0f3d467360@gmail.com>
In-Reply-To: <79ab8197-890a-494d-6687-de0f3d467360@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Dec 2021 09:53:39 -0500
Message-ID: <CADnq5_MX7C83XHo7Ft-eC4wqfYzgVaSM_inkk-QCOz1DonFUag@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Dec 5, 2021 at 4:23 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 03.12.21 um 17:13 schrieb Alex Deucher:
> > On Fri, Dec 3, 2021 at 7:15 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> Am 02.12.21 um 20:19 schrieb Alex Deucher:
> >>> This adds a new IOCTL currently used to implement querying
> >>> and setting the stable power state for GPU profiling.  The
> >>> stable pstates use fixed clocks and disable certain power
> >>> features in order to get accurate pipeline profiling.
> >>>
> >>> Currently this is handled via sysfs, and that is still
> >>> available, but this makes it easier for applications
> >>> to utilize.  Note that the power state is global so
> >>> setting it will affect all applications.  There are currently
> >>> no checks in place to prevent multiple applications from
> >>> using this interface, but it doesn't make sense to do
> >>> profiling while you have multiple applications running in the
> >>> first place, so it's up to the user to ensure this in order
> >>> to get good results.
> >>>
> >>> This patch add an interface to query what profiling mode is
> >>> currently active and to set enable a profiling mode.
> >> First of all I wouldn't call this profiling mode. Profiling is the use
> >> case, but performance and power management are what is controlled here=
.
> >>
> > Ok.
> >
> >> Then we already have functionality for process and context priority
> >> override for the SW scheduler in amdgpu_sched.c. I think we should add
> >> this functionality there.
> > I'm not sure I follow.  Do you mean to integrate this with the
> > rendering context?  That was what my original patch did (attached).
> > Or were you thinking it would be better to make this part of the sched
> > ioctl?
>
> The later,
>
> The scheduler IOCTLs are all about adjusting the default priority of a
> process (and optionally a context as well).
>
> Putting the hardware power management control alongside that kind of
> makes sense I think.
>
> Something like AMDGPU_SCHED_OP_POWER.

The problem is that the sched ioctl is currently DRM_MASTER only.
That kind of defeats the purpose of putting this in a user ioctl in
the first place.

Alex


>
> Christian.
>
> >
> > Alex
> >
> >
> >> Christian.
> >>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c | 112 ++++++++++++++++=
++++
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h |  30 ++++++
> >>>    include/uapi/drm/amdgpu_drm.h               |  28 +++++
> >>>    5 files changed, 173 insertions(+), 1 deletion(-)
> >>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> >>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/am=
d/amdgpu/Makefile
> >>> index 7fedbb725e17..4cf5bf637a9e 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> >>> @@ -58,7 +58,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
> >>>        amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu=
_nbio.o \
> >>>        amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o =
\
> >>>        amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
> >>> -     amdgpu_eeprom.o amdgpu_mca.o
> >>> +     amdgpu_eeprom.o amdgpu_mca.o amdgpu_profile.o
> >>>
> >>>    amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_drv.c
> >>> index bc1355c6248d..0e27f9673f8f 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> @@ -46,6 +46,7 @@
> >>>    #include "amdgpu_sched.h"
> >>>    #include "amdgpu_fdinfo.h"
> >>>    #include "amdgpu_amdkfd.h"
> >>> +#include "amdgpu_profile.h"
> >>>
> >>>    #include "amdgpu_ras.h"
> >>>    #include "amdgpu_xgmi.h"
> >>> @@ -2467,6 +2468,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[]=
 =3D {
> >>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH=
|DRM_RENDER_ALLOW),
> >>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH=
|DRM_RENDER_ALLOW),
> >>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl=
, DRM_AUTH|DRM_RENDER_ALLOW),
> >>> +     DRM_IOCTL_DEF_DRV(AMDGPU_PROFILE, amdgpu_profile_ioctl, DRM_AUT=
H|DRM_RENDER_ALLOW),
> >>>    };
> >>>
> >>>    static const struct drm_driver amdgpu_kms_driver =3D {
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_profile.c
> >>> new file mode 100644
> >>> index 000000000000..94fe408e810f
> >>> --- /dev/null
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> >>> @@ -0,0 +1,112 @@
> >>> +/*
> >>> + * Copyright 2021 Advanced Micro Devices, Inc.
> >>> + *
> >>> + * Permission is hereby granted, free of charge, to any person obtai=
ning a
> >>> + * copy of this software and associated documentation files (the "So=
ftware"),
> >>> + * to deal in the Software without restriction, including without li=
mitation
> >>> + * the rights to use, copy, modify, merge, publish, distribute, subl=
icense,
> >>> + * and/or sell copies of the Software, and to permit persons to whom=
 the
> >>> + * Software is furnished to do so, subject to the following conditio=
ns:
> >>> + *
> >>> + * The above copyright notice and this permission notice shall be in=
cluded in
> >>> + * all copies or substantial portions of the Software.
> >>> + *
> >>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, E=
XPRESS OR
> >>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTA=
BILITY,
> >>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVEN=
T SHALL
> >>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAM=
AGES OR
> >>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERW=
ISE,
> >>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE US=
E OR
> >>> + * OTHER DEALINGS IN THE SOFTWARE.
> >>> + *
> >>> + */
> >>> +
> >>> +#include <drm/amdgpu_drm.h>
> >>> +#include "amdgpu.h"
> >>> +
> >>> +/**
> >>> + * amdgpu_profile_ioctl - Manages settings for profiling.
> >>> + *
> >>> + * @dev: drm device pointer
> >>> + * @data: drm_amdgpu_vm
> >>> + * @filp: drm file pointer
> >>> + *
> >>> + * Returns:
> >>> + * 0 for success, -errno for errors.
> >>> + */
> >>> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
> >>> +                      struct drm_file *filp)
> >>> +{
> >>> +     union drm_amdgpu_profile *args =3D data;
> >>> +     struct amdgpu_device *adev =3D drm_to_adev(dev);
> >>> +     const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_func=
s;
> >>> +     enum amd_dpm_forced_level current_level, requested_level;
> >>> +     int r;
> >>> +
> >>> +     if (pp_funcs->get_performance_level)
> >>> +             current_level =3D amdgpu_dpm_get_performance_level(adev=
);
> >>> +     else
> >>> +             current_level =3D adev->pm.dpm.forced_level;
> >>> +
> >>> +     switch (args->in.op) {
> >>> +     case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
> >>> +             if (args->in.flags)
> >>> +                     return -EINVAL;
> >>> +             switch (current_level) {
> >>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> >>> +                     args->out.flags =3D AMDGPU_PROFILE_FLAGS_STABLE=
_PSTATE_STANDARD;
> >>> +                     break;
> >>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> >>> +                     args->out.flags =3D AMDGPU_PROFILE_FLAGS_STABLE=
_PSTATE_MIN_SCLK;
> >>> +                     break;
> >>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> >>> +                     args->out.flags =3D AMDGPU_PROFILE_FLAGS_STABLE=
_PSTATE_MIN_MCLK;
> >>> +                     break;
> >>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> >>> +                     args->out.flags =3D AMDGPU_PROFILE_FLAGS_STABLE=
_PSTATE_PEAK;
> >>> +                     break;
> >>> +             default:
> >>> +                     args->out.flags =3D AMDGPU_PROFILE_FLAGS_STABLE=
_PSTATE_NONE;
> >>> +                     break;
> >>> +             }
> >>> +             break;
> >>> +     case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
> >>> +             if (args->in.flags & ~AMDGPU_PROFILE_FLAGS_STABLE_PSTAT=
E_MASK)
> >>> +                     return -EINVAL;
> >>> +             switch (args->in.flags & AMDGPU_PROFILE_FLAGS_STABLE_PS=
TATE_MASK) {
> >>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
> >>> +                     requested_level =3D AMD_DPM_FORCED_LEVEL_PROFIL=
E_STANDARD;
> >>> +                     break;
> >>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
> >>> +                     requested_level =3D AMD_DPM_FORCED_LEVEL_PROFIL=
E_MIN_SCLK;
> >>> +                     break;
> >>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
> >>> +                     requested_level =3D AMD_DPM_FORCED_LEVEL_PROFIL=
E_MIN_MCLK;
> >>> +                     break;
> >>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
> >>> +                     requested_level =3D AMD_DPM_FORCED_LEVEL_PROFIL=
E_PEAK;
> >>> +                     break;
> >>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
> >>> +                     requested_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
> >>> +                     break;
> >>> +             default:
> >>> +                     return -EINVAL;
> >>> +             }
> >>> +
> >>> +             if ((current_level !=3D requested_level) && pp_funcs->f=
orce_performance_level) {
> >>> +                     mutex_lock(&adev->pm.mutex);
> >>> +                     r =3D amdgpu_dpm_force_performance_level(adev, =
requested_level);
> >>> +                     if (!r)
> >>> +                             adev->pm.dpm.forced_level =3D requested=
_level;
> >>> +                     mutex_unlock(&adev->pm.mutex);
> >>> +                     if (r)
> >>> +                             return r;
> >>> +             }
> >>> +             break;
> >>> +     default:
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_profile.h
> >>> new file mode 100644
> >>> index 000000000000..cd1c597bae11
> >>> --- /dev/null
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> >>> @@ -0,0 +1,30 @@
> >>> +/*
> >>> + * Copyright 2021 Advanced Micro Devices, Inc.
> >>> + *
> >>> + * Permission is hereby granted, free of charge, to any person obtai=
ning a
> >>> + * copy of this software and associated documentation files (the "So=
ftware"),
> >>> + * to deal in the Software without restriction, including without li=
mitation
> >>> + * the rights to use, copy, modify, merge, publish, distribute, subl=
icense,
> >>> + * and/or sell copies of the Software, and to permit persons to whom=
 the
> >>> + * Software is furnished to do so, subject to the following conditio=
ns:
> >>> + *
> >>> + * The above copyright notice and this permission notice shall be in=
cluded in
> >>> + * all copies or substantial portions of the Software.
> >>> + *
> >>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, E=
XPRESS OR
> >>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTA=
BILITY,
> >>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVEN=
T SHALL
> >>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAM=
AGES OR
> >>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERW=
ISE,
> >>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE US=
E OR
> >>> + * OTHER DEALINGS IN THE SOFTWARE.
> >>> + *
> >>> + */
> >>> +
> >>> +#ifndef __AMDGPU_PROFILE_H__
> >>> +#define __AMDGPU_PROFILE_H__
> >>> +
> >>> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
> >>> +                      struct drm_file *filp);
> >>> +
> >>> +#endif
> >>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_=
drm.h
> >>> index 26e45fc5eb1a..b6edf4a826f9 100644
> >>> --- a/include/uapi/drm/amdgpu_drm.h
> >>> +++ b/include/uapi/drm/amdgpu_drm.h
> >>> @@ -54,6 +54,7 @@ extern "C" {
> >>>    #define DRM_AMDGPU_VM                       0x13
> >>>    #define DRM_AMDGPU_FENCE_TO_HANDLE  0x14
> >>>    #define DRM_AMDGPU_SCHED            0x15
> >>> +#define DRM_AMDGPU_PROFILE           0x16
> >>>
> >>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DR=
M_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + DR=
M_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> >>> @@ -71,6 +72,7 @@ extern "C" {
> >>>    #define DRM_IOCTL_AMDGPU_VM         DRM_IOWR(DRM_COMMAND_BASE + DR=
M_AMDGPU_VM, union drm_amdgpu_vm)
> >>>    #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE=
 + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> >>>    #define DRM_IOCTL_AMDGPU_SCHED              DRM_IOW(DRM_COMMAND_BA=
SE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> >>> +#define DRM_IOCTL_AMDGPU_PROFILE     DRM_IOW(DRM_COMMAND_BASE + DRM_=
AMDGPU_PROFILE, union drm_amdgpu_profile)
> >>>
> >>>    /**
> >>>     * DOC: memory domains
> >>> @@ -1120,6 +1122,32 @@ struct drm_amdgpu_info_video_caps {
> >>>        struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO=
_VIDEO_CAPS_CODEC_IDX_COUNT];
> >>>    };
> >>>
> >>> +/* profile ioctl */
> >>> +#define AMDGPU_PROFILE_OP_GET_STABLE_PSTATE  1
> >>> +#define AMDGPU_PROFILE_OP_SET_STABLE_PSTATE  2
> >>> +
> >>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK      0xf
> >>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE      0
> >>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD  1
> >>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK  2
> >>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK  3
> >>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK      4
> >>> +
> >>> +struct drm_amdgpu_profile_in {
> >>> +     /** AMDGPU_PROFILE_OP_* */
> >>> +     __u32   op;
> >>> +     __u32   flags;
> >>> +};
> >>> +
> >>> +struct drm_amdgpu_profile_out {
> >>> +     __u64   flags;
> >>> +};
> >>> +
> >>> +union drm_amdgpu_profile {
> >>> +     struct drm_amdgpu_profile_in in;
> >>> +     struct drm_amdgpu_profile_out out;
> >>> +};
> >>> +
> >>>    /*
> >>>     * Supported GPU families
> >>>     */
>
