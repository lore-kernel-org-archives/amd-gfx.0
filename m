Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64876EE3683
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 14:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB70A10E755;
	Thu, 12 Feb 2026 14:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g+qzBR5z";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098AE10E265
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 14:00:51 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2b867142b07so417569eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 06:00:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770904850; cv=none;
 d=google.com; s=arc-20240605;
 b=lkFOJ1J2awChEFFTGA/ALBO23fYZ6Z0NzqPksi5d5dgLCUKmQ4K1tDk9wgfbV8Tk2X
 z8iIdzkNG9+YT9X3aDJ/5H8kHPukRpviUH7dazq4EqbjhNWh0JTZIwehgnWP+idEp3Pw
 VBPro+FmVYjNXn1L+qm5ZqbUrL/74bQPRsE8zlr2yyTY5IkX6m/u3YvfI0DHcb727+4G
 gaKOXeI1Mz+UdvRG2rpv9cQofQmioouhawSb3WGui13QSSlwpLIRLCxhRhvq7GCeOPeh
 t6KPCHSJrzGbGPjI+Grm6S6t7Boodf4UXiHzRFGHW5FE7CEhRGE/MpY46VngsOSkJJ1d
 RxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fRD8b3Y4XGRJDt9CHD6XWFMWas6viZy2+SITWIUk/LI=;
 fh=xW0goFURhPNh7XoxTlKZk0Z9esJZrJevxmhZ98Dan/A=;
 b=M1aNsGscj3i5TfF+KxDZeDHNVshcp82LDfRj9RtxFhJ4OULKGfKd+0bqPAYzSXFer6
 nC7jxoHu+8XWEOPiEFEwjG5+UTJYJcVaufDf22yQQPAclB08E73aBZEmnGi9cj+DMpHa
 H7Ck7g5sDvCoAPbdLdpDocfBADmAvPn4ieEkvj9iQ7u7L9xByQ0EIM1G5FIg1z1FnAVS
 HBmS6yghKMIQxzdp7Kur8chbjDes0wnr2eW8Pou6hRJBkzzH4e2lTcTtpG2iqTmF6VG6
 +0hUYnozzUHtGvcGEaqNRCt4FiyyXatNrOAWlxeM7QZLoch103sptI8pvsjKv6+o9Aev
 e2NA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770904850; x=1771509650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRD8b3Y4XGRJDt9CHD6XWFMWas6viZy2+SITWIUk/LI=;
 b=g+qzBR5zQZm+drNAuPo6POGXhLDGG5LnwHSZF91mk2JrQdFxZI9xQHb0lApBBgOeRC
 CftFjQQ9Vtay/fPh0RF6S1KTGWHLqlbt8ezWcAMUyhV3HD6QQwo6UouVNJnX6+9GUDsf
 819vyg8eFpqdClUGG+LgERBneWmXGa10G+IRYrT+Bp8myBpwNOCEzlU2thxnBSqm4swO
 Oe3qHBewqr9xe+sE1KpEkfc+weBUD5KDQCXP9CwhAFCI0eQtqomKmCjwsbGWi+SBfABN
 d86AW1h0Yd0GpyGHC9YCAa0A17MEVjf3AWP6rM+NuMEyVQ3NJYMN0CUcR1SPxvntJCPf
 KXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770904850; x=1771509650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fRD8b3Y4XGRJDt9CHD6XWFMWas6viZy2+SITWIUk/LI=;
 b=BPnzXAQBHReaGNsSlRfd7Qc5gntOR5UjKsK3MgFrAF1b0rCMFQl+riYHbDzL6p9g/r
 zxyojv5H6DYJ3BgAXS6cZcZJbiyxfoQSKZ+MRoG1/HksyNzpeHwDatkvVQJn/8nx0wBV
 yRP2XcPBBgr37zugtEuUiAGlEH+o+7X4XbY55T6qBR9xKNeAbntSn+gjsz7faqKD9VPP
 3MJMyHlA1WZ33wdyD0RxbF2D2tO/h2t9hXfbRJy1qdZYbjI7wEm4Mx4C05gvP4R2oEvw
 gyXOl+TFTPAGRk1ybKSm2IqQ/AxhDYYXjpnfxRjVPvNMp6BZ55y7q5sSPB04G/mWA+wb
 C/wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkidleTWc6tBCe4KrEsKcxXYiqKelimCGfIX8u7N6aG6YNZwqM7RZ/Y5rfKGuaIqjRRWIXFXv+@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8xfoAgZ2s8vKFTrbNTK57MzW+UeW69CL0f28Mgjc4OxAo4HSf
 0NE5HZAe6X9sWvEuroVLzJPtP08B0T7huj9NgHnbla9PUBNNobsbPQvrz0tAUOK8/qcysIahHOu
 H/6IhNciW+ynHYh2gmk7s++Za74Qw9BY=
X-Gm-Gg: AZuq6aLQlK5PegnKXz2X2zBDNSlWqjeE8CbeQ4domNWfq5oe/KkIU9JVGtvKV69BxAK
 8M9HmDmbqkkpmsDOQsuDlqIKqFxORmdZm8alVp4OSx5BMuXZteNEb0RfH5Cd8XqU2F1V9rhLv18
 xAEoksLuwS4c0Psqi9tHvwn5Cze94hiaAf+kv0gQlrD7yzpKsXXcgmMtAlJkL3FEAjZmxmhdsVn
 GTrQ4xjVlsiUd1rPcz23Ar/EYDAyJCUshTLu4ZbikseaatdKthQxtzqioObJpteAjPeGRvmtJiw
 2649UWrG
X-Received: by 2002:a05:7022:4397:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-1272f77680fmr608119c88.4.1770904849917; Thu, 12 Feb 2026
 06:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20260122151110.3072843-1-James.Zhu@amd.com>
 <CADnq5_P1DcMS7qPfUOSAvdZKBtSoojk-n_H6QO7NenZzht6=gA@mail.gmail.com>
 <1e830669-0647-4508-bcab-a407eb46aeda@amd.com>
In-Reply-To: <1e830669-0647-4508-bcab-a407eb46aeda@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Feb 2026 09:00:38 -0500
X-Gm-Features: AZwV_Qiapmxqb6V5vj6uT40hGEsrV0hTe2eguBkdhWQGXyl8TlOCUsy5GKcKSRk
Message-ID: <CADnq5_NtbthAuWjb5aK1AgybxnrSg_xbcJbxPF1BwtiCD3mqyg@mail.gmail.com>
Subject: Re: [PATCH v2] amdgpu: Add amdgpu profiler IOCTL functions
To: James Zhu <jamesz@amd.com>
Cc: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, david.belanger@amd.com, chris.freehill@amd.com, 
 harish.kasiviswanathan@amd.com
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

On Wed, Feb 11, 2026 at 11:45=E2=80=AFAM James Zhu <jamesz@amd.com> wrote:
>
> Hi Alex,
>
> Thanks! Answer in line.
>
> Best Regards!
>
> James Zhu
>
> On 2026-02-11 10:26, Alex Deucher wrote:
> > On Thu, Jan 22, 2026 at 10:22=E2=80=AFAM James Zhu <James.Zhu@amd.com> =
wrote:
> >> to support PMC, PCSampling, SPM etc.
> >>
> >> Signed-off-by: James Zhu <James.Zhu@amd.com>
> >> ---
> >>   amdgpu/amdgpu.h          |  8 +++++++
> >>   amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++=
++
> >>   amdgpu/meson.build       |  2 +-
> >>   include/drm/amdgpu_drm.h | 19 +++++++++++++++++
> >>   4 files changed, 74 insertions(+), 1 deletion(-)
> >>   create mode 100644 amdgpu/amdgpu_profiler.c
> >>
> >> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
> >> index 39b61539..87eec030 100644
> >> --- a/amdgpu/amdgpu.h
> >> +++ b/amdgpu/amdgpu.h
> >> @@ -2072,6 +2072,14 @@ int amdgpu_userq_signal(amdgpu_device_handle de=
v,
> >>   int amdgpu_userq_wait(amdgpu_device_handle dev,
> >>                        struct drm_amdgpu_userq_wait *wait_data);
> >>
> >> +/**
> >> + * Acquire profiler version
> >> + * \param   dev               - \c [in]     device handle
> >> + *
> >> + * \return  0 on success otherwise POSIX Error code
> >> + */
> >> +int amdgpu_profiler_version(amdgpu_device_handle dev);
> >> +
> >>   #ifdef __cplusplus
> >>   }
> >>   #endif
> >> diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c
> >> new file mode 100644
> >> index 00000000..8d4dffe4
> >> --- /dev/null
> >> +++ b/amdgpu/amdgpu_profiler.c
> >> @@ -0,0 +1,46 @@
> >> +/*
> >> + * Copyright 2026 Advanced Micro Devices, Inc.
> >> + *
> >> + * Permission is hereby granted, free of charge, to any person obtain=
ing a
> >> + * copy of this software and associated documentation files (the "Sof=
tware"),
> >> + * to deal in the Software without restriction, including without lim=
itation
> >> + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,
> >> + * and/or sell copies of the Software, and to permit persons to whom =
the
> >> + * Software is furnished to do so, subject to the following condition=
s:
> >> + *
> >> + * The above copyright notice and this permission notice shall be inc=
luded in
> >> + * all copies or substantial portions of the Software.
> >> + *
> >> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EX=
PRESS OR
> >> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> >> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT=
 SHALL
> >> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR
> >> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,
> >> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR
> >> + * OTHER DEALINGS IN THE SOFTWARE.
> >> + *
> >> + */
> >> +
> >> +#include <string.h>
> >> +#include <errno.h>
> >> +#include "xf86drm.h"
> >> +#include "amdgpu_drm.h"
> >> +#include "amdgpu_internal.h"
> >> +
> >> +drm_public int
> >> +amdgpu_profiler_version(amdgpu_device_handle dev)
> >> +{
> >> +       int ret;
> >> +       struct drm_amdgpu_profiler_args user_arg;
> >> +
> >> +       if (!dev)
> >> +               return -EINVAL;
> >> +
> >> +       memset(&user_arg, 0, sizeof(user_arg));
> >> +       user_arg.op =3D AMDGPU_PROFILER_VERSION;
> >> +
> >> +       ret =3D drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
> >> +                                 &user_arg, sizeof(user_arg));
> >> +
> >> +       return ret;
> >> +}
> >> diff --git a/amdgpu/meson.build b/amdgpu/meson.build
> >> index 3962d32c..d781f2e9 100644
> >> --- a/amdgpu/meson.build
> >> +++ b/amdgpu/meson.build
> >> @@ -27,7 +27,7 @@ libdrm_amdgpu =3D library(
> >>       files(
> >>         'amdgpu_asic_id.c', 'amdgpu_bo.c', 'amdgpu_cs.c', 'amdgpu_devi=
ce.c',
> >>         'amdgpu_gpu_info.c', 'amdgpu_vamgr.c', 'amdgpu_vm.c', 'handle_=
table.c',
> >> -      'amdgpu_userq.c',
> >> +      'amdgpu_userq.c', 'amdgpu_profiler.c',
> >>       ),
> >>       config_file,
> >>     ],
> >> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
> >> index 947bf261..107d2b69 100644
> >> --- a/include/drm/amdgpu_drm.h
> >> +++ b/include/drm/amdgpu_drm.h
> >> @@ -57,6 +57,7 @@ extern "C" {
> >>   #define DRM_AMDGPU_USERQ               0x16
> >>   #define DRM_AMDGPU_USERQ_SIGNAL                0x17
> >>   #define DRM_AMDGPU_USERQ_WAIT          0x18
> >> +#define DRM_AMDGPU_PROFILER                    0x20
> >>
> >>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + D=
RM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + D=
RM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> >> @@ -77,6 +78,7 @@ extern "C" {
> >>   #define DRM_IOCTL_AMDGPU_USERQ         DRM_IOWR(DRM_COMMAND_BASE + D=
RM_AMDGPU_USERQ, union drm_amdgpu_userq)
> >>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + D=
RM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
> >>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + D=
RM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> >> +#define DRM_IOCTL_AMDGPU_PROFILER      DRM_IOWR(DRM_COMMAND_BASE + DR=
M_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
> >>
> >>   /**
> >>    * DOC: memory domains
> >> @@ -1616,6 +1618,23 @@ struct drm_amdgpu_info_gpuvm_fault {
> >>   #define AMDGPU_FAMILY_GC_11_5_0                        150 /* GC 11.=
5.0 */
> >>   #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.=
0.0 */
> >>
> >> +/*
> >> + * Supported Profiler Operations
> >> + */
> >> +enum drm_amdgpu_profiler_ops {
> >> +       AMDGPU_PROFILER_VERSION =3D 0,
> >> +};
> >> +
> >> +struct drm_amdgpu_profiler_args {
> >> +       __u32 op;                        /* amdgpu_profiler_op */
> >> +       union {
> >> +           __u32 version;               /* AMDGPU_PROFILER_VERSION_NU=
M
> >> +                                         * lower 16 bit: minor
> >> +                                         * higher 16 bit: major
> >> +                                         */
> >> +       };
> >> +};
> > I think this seems fine.  I think we'd need to see what the other
> > opcodes would look like.  What is the version query used for?  Can you
> > provide an example of how the profiler would use this interface for
> > actually profiling a job?
>
> [JZ] Profiler team requests this to track some profiler internal changes =
to
>
> conduct profiler version control.
>
> The op will include PMC, PC Sampling and SPM so far.

That makes sense, but I don't think there is much to review here until
we know what those interfaces will look like.  Also note that even if
the kernel driver supports a newer interface, it needs to continue to
support older interface versions for backwards compatibility.

Alex

>
> >
> > Alex
> >
> >> +
> >>   #if defined(__cplusplus)
> >>   }
> >>   #endif
> >> --
> >> 2.34.1
> >>
