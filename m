Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0F3E9E311
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 15:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 444C810E614;
	Wed, 11 Feb 2026 15:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lvgem+yc";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD23C10E614
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 15:26:58 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1233ad1b4cdso504382c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 07:26:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770823618; cv=none;
 d=google.com; s=arc-20240605;
 b=CmcVHimUu2wDdkhjz3If5EiqqIPv5C00QHTuhgsd8LStaFmtVIxquOrGBowkVRp90F
 HzNqO7V7eLUAPYFuMT9nSj/ybmtGLRbfQCxwJmCaclXp5DnkGK1fuCkPVK7/pGKULASO
 UtQJ0/ShkkBnkUadP4jMD0oGYjoRm6RMmuvVlEwf1Qme49CcSIM+sM1Suf8dlsWrMWOU
 SvlSHk0yVlWKLWdcQeEfGC7NrYI9TIN21npxcTYcPBUlTjevrTpkINK3QrmpwK5rSai+
 XesTNqVSAgZ0A59gxAEfXIlNZElmpnyJR9UtJcOBDXRKQrvaZ7IKehANQMGgrniovY71
 OG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wBvlxhw/cRV2WEmrvCaWygcLKmvIEbgu7f/HiFhXyHk=;
 fh=2pyjsHEWtmyAh8JyrZteyRJerEYxaXXaIORqZUu5Zgc=;
 b=O4neAbfrg9AQO+iChzn/ESj5s8epkWWMujR7bR+gNzQCtpko6+4phEE050ku8rFji5
 oTLPA2rPw3CG2psunlDeiy5+vTLf6qHe7La+QFuKjjTLQQ3kSGs+QZhYqmx96mBqZU9m
 lRqoQV5dHbUZ88ZzSqb6HHFIZTMqgn78HXo1VeHdm6PYmI8ZgrjoXDiNlGcFcQGfkQRl
 HQfRPbIHiyuQu+XMvOyqxT2h6B33CBIuEJyzK92lr/99WK3ShoWB/eEsCrOFLrO7mBqR
 zTKFoTfUN56eCAAogXDsZbRz9R6yEHKUyMBxW71ffYP0xMy/szhptHPeHtN3gjJxU+hZ
 cQSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770823618; x=1771428418; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBvlxhw/cRV2WEmrvCaWygcLKmvIEbgu7f/HiFhXyHk=;
 b=Lvgem+ycNeBxHJx+iJkk8reMgqWwAGEOGLfW707MywYQl0w49FUFahj22+OmGXAnKT
 XIre2W9sSqnJ3BD4yYIHy5YwTW3rISNgKHhubsP1WzoooCwURZXXRv3n7VYL1ZxHAYfO
 mR4xrAwoOd+LxbLrusoTK5vhypag3RY2GkPVjEM2DlocIuQWZsXZDW0zrGw4ncf9TJZX
 NfLmcBNE+TkhH4osMiFOn7tm3aPb0Y360cwGdvVLUSyAs6CpfXXP3jnZLv7I+UdhBuhr
 SqLhbD7F55uZyHzzzxL4b+ULODQJJhYxMCcXKDZ+8HueGHKgAttiCxSEqKX5Eug8VbrE
 MjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770823618; x=1771428418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wBvlxhw/cRV2WEmrvCaWygcLKmvIEbgu7f/HiFhXyHk=;
 b=pDEiQmlrqiuRI6i/1N1dtXzo4GY2AIHkHzXrogquV+PZYwN3int9yAiL4LgaHslAu7
 PxS9a4JAPgvIXIWS6VvvCPI74BdqZjxj/JGbXdu24BOjmY7hv4tQHNKjl6e7X/B4mqMO
 9VnkHe1g9ruu6IbCFwf77+GR3s0OcmHOZPPIbQbG6MU4ZQzls1cmQmFuB5SACvDxSrQ7
 fzAvtBp9Ezkk+NDGd8gEJIWuvnG+VwGflSAHm9nXKL7Cx5Y5UD6/jdNlEy2clBoYQno4
 lvmTox4DRe/8nNhVHsacgtY+n3OW/GcCxHhsUbw/UPvLOJVVXqsk5dXX3z94HNylvw61
 IJMg==
X-Gm-Message-State: AOJu0Yyp4jdR4J75yvFakRnVpTO//tiXhAkyb2Z60Bp/EmG+qgEbwlFc
 O513hVY/CYIFusac+OIydM+aDV81lVzwlACqxtITqCu6pZ39LC1NzKI1ClVpiyLbUcVpgTXkkpU
 G6B8XT5OEjS9Tn2tpylrceZtDYIVMjN0=
X-Gm-Gg: AZuq6aI6KLnDIUn/5YTvfgajpAkyHjTzUGsLr+mTsb6q9xmTS3nJginsMt9HCumLBoL
 EQhdLbEus7gDZD6kK/EN8dNntTemmcVkOWnRZS6OEb+0x1QPFPKBDLTO9jCUtaAVCh12jg6W0P7
 FG5EcL+Hw+COeuznRYm0gMtG1Q3fFnncjizh0pukgNJklpcf8pKimWPgNJ8V6gVp/gHusr8Q14O
 SUYdgxqge0hJsTzU6Aw5MCSHtnXHzHpzzuT2pmEvMGMNWdozDGM1HDZt/DWx/0sI5M1j94rQvZy
 FZnuGtjg
X-Received: by 2002:a05:7022:221c:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-1272a7da9acmr483714c88.7.1770823617904; Wed, 11 Feb 2026
 07:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20260122151110.3072843-1-James.Zhu@amd.com>
In-Reply-To: <20260122151110.3072843-1-James.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Feb 2026 10:26:46 -0500
X-Gm-Features: AZwV_Qg4J_P4k_gclyySOEEqaMnyECuQwYgYIkUYoDdW6fkOGjfjaCdl12gzKr0
Message-ID: <CADnq5_P1DcMS7qPfUOSAvdZKBtSoojk-n_H6QO7NenZzht6=gA@mail.gmail.com>
Subject: Re: [PATCH v2] amdgpu: Add amdgpu profiler IOCTL functions
To: James Zhu <James.Zhu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 david.belanger@amd.com, chris.freehill@amd.com, 
 harish.kasiviswanathan@amd.com, jamesz@amd.com
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

On Thu, Jan 22, 2026 at 10:22=E2=80=AFAM James Zhu <James.Zhu@amd.com> wrot=
e:
>
> to support PMC, PCSampling, SPM etc.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  amdgpu/amdgpu.h          |  8 +++++++
>  amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++++
>  amdgpu/meson.build       |  2 +-
>  include/drm/amdgpu_drm.h | 19 +++++++++++++++++
>  4 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 amdgpu/amdgpu_profiler.c
>
> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
> index 39b61539..87eec030 100644
> --- a/amdgpu/amdgpu.h
> +++ b/amdgpu/amdgpu.h
> @@ -2072,6 +2072,14 @@ int amdgpu_userq_signal(amdgpu_device_handle dev,
>  int amdgpu_userq_wait(amdgpu_device_handle dev,
>                       struct drm_amdgpu_userq_wait *wait_data);
>
> +/**
> + * Acquire profiler version
> + * \param   dev               - \c [in]     device handle
> + *
> + * \return  0 on success otherwise POSIX Error code
> + */
> +int amdgpu_profiler_version(amdgpu_device_handle dev);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c
> new file mode 100644
> index 00000000..8d4dffe4
> --- /dev/null
> +++ b/amdgpu/amdgpu_profiler.c
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <string.h>
> +#include <errno.h>
> +#include "xf86drm.h"
> +#include "amdgpu_drm.h"
> +#include "amdgpu_internal.h"
> +
> +drm_public int
> +amdgpu_profiler_version(amdgpu_device_handle dev)
> +{
> +       int ret;
> +       struct drm_amdgpu_profiler_args user_arg;
> +
> +       if (!dev)
> +               return -EINVAL;
> +
> +       memset(&user_arg, 0, sizeof(user_arg));
> +       user_arg.op =3D AMDGPU_PROFILER_VERSION;
> +
> +       ret =3D drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
> +                                 &user_arg, sizeof(user_arg));
> +
> +       return ret;
> +}
> diff --git a/amdgpu/meson.build b/amdgpu/meson.build
> index 3962d32c..d781f2e9 100644
> --- a/amdgpu/meson.build
> +++ b/amdgpu/meson.build
> @@ -27,7 +27,7 @@ libdrm_amdgpu =3D library(
>      files(
>        'amdgpu_asic_id.c', 'amdgpu_bo.c', 'amdgpu_cs.c', 'amdgpu_device.c=
',
>        'amdgpu_gpu_info.c', 'amdgpu_vamgr.c', 'amdgpu_vm.c', 'handle_tabl=
e.c',
> -      'amdgpu_userq.c',
> +      'amdgpu_userq.c', 'amdgpu_profiler.c',
>      ),
>      config_file,
>    ],
> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
> index 947bf261..107d2b69 100644
> --- a/include/drm/amdgpu_drm.h
> +++ b/include/drm/amdgpu_drm.h
> @@ -57,6 +57,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ               0x16
>  #define DRM_AMDGPU_USERQ_SIGNAL                0x17
>  #define DRM_AMDGPU_USERQ_WAIT          0x18
> +#define DRM_AMDGPU_PROFILER                    0x20
>
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -77,6 +78,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ         DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ, union drm_amdgpu_userq)
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> +#define DRM_IOCTL_AMDGPU_PROFILER      DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>
>  /**
>   * DOC: memory domains
> @@ -1616,6 +1618,23 @@ struct drm_amdgpu_info_gpuvm_fault {
>  #define AMDGPU_FAMILY_GC_11_5_0                        150 /* GC 11.5.0 =
*/
>  #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 =
*/
>
> +/*
> + * Supported Profiler Operations
> + */
> +enum drm_amdgpu_profiler_ops {
> +       AMDGPU_PROFILER_VERSION =3D 0,
> +};
> +
> +struct drm_amdgpu_profiler_args {
> +       __u32 op;                        /* amdgpu_profiler_op */
> +       union {
> +           __u32 version;               /* AMDGPU_PROFILER_VERSION_NUM
> +                                         * lower 16 bit: minor
> +                                         * higher 16 bit: major
> +                                         */
> +       };
> +};

I think this seems fine.  I think we'd need to see what the other
opcodes would look like.  What is the version query used for?  Can you
provide an example of how the profiler would use this interface for
actually profiling a job?

Alex

> +
>  #if defined(__cplusplus)
>  }
>  #endif
> --
> 2.34.1
>
