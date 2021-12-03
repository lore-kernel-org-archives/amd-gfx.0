Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD4EC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 16:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2AF36E948;
	Fri,  3 Dec 2021 16:08:25 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459986E948
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 16:08:25 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 a11-20020a4ad1cb000000b002c2657270a0so2171101oos.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Dec 2021 08:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q+5RLTh5Fc9HPacHn+sPiuuz+0Skx0QvozaYJi51USY=;
 b=MoN9vqySrt7DMVdE705eH5zxpjjfu8L2Khk00x0Gvw64ZGbeyW5hMIDTBHgTUQRa4F
 /tx9pybYAsn9IY3WXk0OvqRMEvU9wXrcc6dTW/dAEeqmqYOlPGw51q2sgw2C1OqS7DAh
 sTmvjV84GjvNCRiKNZoMugjzB3SKdRbkGPuYqckLbllzlmp6v9xgSPAisbDazle4mZ5u
 zYVG4aFuX/3MP87U1u1ItDVeYSahiSdqR97po/j8viiO///vMVYz81TedvQXS8/sr4Jt
 zhgLdpTDtLazYnksAwjp24jhd/2U3YuLO3im3J+ltCswpOLRSqASIOGE9QvFlUYROemh
 I8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q+5RLTh5Fc9HPacHn+sPiuuz+0Skx0QvozaYJi51USY=;
 b=xEOleBMtZThSi64FRiRQhSP+m2XTzHfSIy4zGtz2n8D1i3F7j1+gbHP0W+4+VWWsTM
 IlazMiTHTgBGsbZisUFwSOuPzh8pWAawRj2GLO5Z2JTHoYRq6tn9PFNXZH5bOLPexcAx
 AAIoevuiz2kHA/LjNt0OJsQ3dxEC7RMrm/UpIhA4Ly0WfAvZEDNGFaRCV97jjwliMWQB
 T7TXXBmA0v1JB4Fks4Sl+AG2vvodpkq+uwtFXrO2XY7T/Q0Ic/qRMdYkuTrZqjFU5MqZ
 bTPpFXQ9j+I+RA1trT6vDLqpkfspIJfRwBzhQ0OS43EWCJlJHnZBHC8Y1/8jUM2JSMk5
 WVIw==
X-Gm-Message-State: AOAM532FsGEzPqEv6+kZDPcMqT6HuZccKnrnNL+pJsxEAg1Cx5jPQwRk
 TIug4gcjc8Exkgjw3+GDdRWqlODWyaWc83GPGJs=
X-Google-Smtp-Source: ABdhPJy/zs+29Wi/GQdxFlTlhm1ySx9pofkDi82yg2f0eQFsZ2pgo6CbXtsInQel88SnSVwkKRIoZpImeihcwsY5CAs=
X-Received: by 2002:a4a:8701:: with SMTP id z1mr13535384ooh.68.1638547704378; 
 Fri, 03 Dec 2021 08:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20211202191912.6148-1-alexander.deucher@amd.com>
 <14cb3f8e-7e73-f596-ca3e-d8af7c053d5a@amd.com>
In-Reply-To: <14cb3f8e-7e73-f596-ca3e-d8af7c053d5a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Dec 2021 11:08:13 -0500
Message-ID: <CADnq5_O9KJsAmLcnw=mGUL6aE0XzrFSi=KvmFjtJKxX2cMeZGQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Dec 3, 2021 at 7:07 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 12/3/2021 12:49 AM, Alex Deucher wrote:
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
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c | 112 ++++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h |  30 ++++++
> >   include/uapi/drm/amdgpu_drm.h               |  28 +++++
> >   5 files changed, 173 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> > index 7fedbb725e17..4cf5bf637a9e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > @@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
> >       amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
> >       amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
> >       amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
> > -     amdgpu_eeprom.o amdgpu_mca.o
> > +     amdgpu_eeprom.o amdgpu_mca.o amdgpu_profile.o
> >
> >   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
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
> > @@ -2467,6 +2468,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
> >       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> >       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> >       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> > +     DRM_IOCTL_DEF_DRV(AMDGPU_PROFILE, amdgpu_profile_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> >   };
> >
> >   static const struct drm_driver amdgpu_kms_driver = {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> > new file mode 100644
> > index 000000000000..94fe408e810f
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> > @@ -0,0 +1,112 @@
> > +/*
> > + * Copyright 2021 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a
> > + * copy of this software and associated documentation files (the "Software"),
> > + * to deal in the Software without restriction, including without limitation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > + * and/or sell copies of the Software, and to permit persons to whom the
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
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
> > +     union drm_amdgpu_profile *args = data;
> > +     struct amdgpu_device *adev = drm_to_adev(dev);
> > +     const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> > +     enum amd_dpm_forced_level current_level, requested_level;
> > +     int r;
> > +
> > +     if (pp_funcs->get_performance_level)
> > +             current_level = amdgpu_dpm_get_performance_level(adev);
> > +     else
> > +             current_level = adev->pm.dpm.forced_level;
> > +
> > +     switch (args->in.op) {
> > +     case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
> > +             if (args->in.flags)
> > +                     return -EINVAL;
> > +             switch (current_level) {
> > +             case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> > +                     args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD;
> > +                     break;
> > +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> > +                     args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK;
> > +                     break;
> > +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> > +                     args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK;
> > +                     break;
> > +             case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> > +                     args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK;
> > +                     break;
> > +             default:
> > +                     args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE;
> > +                     break;
> > +             }
> > +             break;
> > +     case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
> > +             if (args->in.flags & ~AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK)
> > +                     return -EINVAL;
> > +             switch (args->in.flags & AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK) {
> > +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
> > +                     requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
> > +                     break;
> > +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
> > +                     requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
> > +                     break;
> > +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
> > +                     requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
> > +                     break;
> > +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
> > +                     requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
> > +                     break;
> > +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
> > +                     requested_level = AMD_DPM_FORCED_LEVEL_AUTO;
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +
>
> Not sure if the below code covers everything, but in general it's better
> for the sysfs handling in amdgpu_pm (after parsing the options) and this
> one to call a common API to handle this.

Yeah, I considered cleaning that up first, but then Evan's patches
already took care of that, so I figured that would get cleaned up once
those land.

Alex

>
> Thanks,
> Lijo
>
> > +             if ((current_level != requested_level) && pp_funcs->force_performance_level) {
> > +                     mutex_lock(&adev->pm.mutex);
> > +                     r = amdgpu_dpm_force_performance_level(adev, requested_level);
> > +                     if (!r)
> > +                             adev->pm.dpm.forced_level = requested_level;
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
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> > new file mode 100644
> > index 000000000000..cd1c597bae11
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> > @@ -0,0 +1,30 @@
> > +/*
> > + * Copyright 2021 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a
> > + * copy of this software and associated documentation files (the "Software"),
> > + * to deal in the Software without restriction, including without limitation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > + * and/or sell copies of the Software, and to permit persons to whom the
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
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
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> > index 26e45fc5eb1a..b6edf4a826f9 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -54,6 +54,7 @@ extern "C" {
> >   #define DRM_AMDGPU_VM                       0x13
> >   #define DRM_AMDGPU_FENCE_TO_HANDLE  0x14
> >   #define DRM_AMDGPU_SCHED            0x15
> > +#define DRM_AMDGPU_PROFILE           0x16
> >
> >   #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >   #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> > @@ -71,6 +72,7 @@ extern "C" {
> >   #define DRM_IOCTL_AMDGPU_VM         DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
> >   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> >   #define DRM_IOCTL_AMDGPU_SCHED              DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> > +#define DRM_IOCTL_AMDGPU_PROFILE     DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILE, union drm_amdgpu_profile)
> >
> >   /**
> >    * DOC: memory domains
> > @@ -1120,6 +1122,32 @@ struct drm_amdgpu_info_video_caps {
> >       struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
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
> >
