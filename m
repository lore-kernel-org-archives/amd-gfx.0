Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BE7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 13:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43BA10EFD6;
	Tue, 10 May 2022 13:48:12 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1047310EFD6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 13:48:12 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-ee1e7362caso14208736fac.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eYBhS8UoaBCw8Jwia3GAxGifsXgfxWJFfdBJVHXCIPY=;
 b=nRLjR/jjrNcciXSagfFfKIMWKOOYjJWgUgtebb4i1+gnzLOphFipyWYZHouNOsVnIq
 M5XHmSwKjqQLUI/K+FS7cu21nwG6vFxdXqJ2PK1jDf2dY2aY2nVT1KpOaIxOzfGSF4zv
 UYjjozPsNbAyAf+VD9hUczrRA5X/Nza09wchxh3iWHM15WJe5OEteITuWsVYhvJgfhbk
 laDK7db5SA+xLiZFyJzkj5WZBgDdAI54IJSQlXfASmn41Cz0A1S90GQv/gwjfZdMZaZA
 J6kcO1j+Jy9CktT4asu1OosWNApOGMmEErBDLhmkGx8aS8p2LufU+WDBPfmX2ndya6B4
 FTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eYBhS8UoaBCw8Jwia3GAxGifsXgfxWJFfdBJVHXCIPY=;
 b=yqsipYJtYHbV9LgJuPt2gEWionMdAs6XfPgHOZz1i3XuC86SPNdrSCT7bGmhKmnhAI
 DGs0kQk1QPq9OwvuBT2aPrEftqG6uo7VV9PdmgdTgA63rr2SSsLmqd3v9dKtyGBX9cx/
 LxWjP2MHmKwZoqrtvDM3ygAc0lhQM/GhtIJKxTM36PYZGg54RSXMh51mN4H08J1ZO1GF
 bPdcFAmfGshdUA+vIfyNUrWKs7ozEPqAAgyEsgKTgBLGOIYUJ4/YYP3xBMoZKyVlS/3n
 R3An6OqTl+sidDXP36hh7Sls2zbVUQReCsVsMn2V7E660e07segQ8LK3dERlSLgmi0GL
 4h8w==
X-Gm-Message-State: AOAM530Nzj0vDh8zIPu7oJgEWmrma0nk5EuK6TkGgEw20W+aO7iK78hP
 uRWiGkEZokVduHA6h2kAnzlZywJOMA4FAJsbimU=
X-Google-Smtp-Source: ABdhPJzpCQjQPw+BKJ7L0bJV0kvd1CtjJ5ftGQ3aqPuQcGO+seGHTN2Y4WO9GdwAcy/YAp49Sb73DbPQIlq0GqfIlpo=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr57238oap.253.1652190491380; Tue, 10 May
 2022 06:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220509170732.791710-1-yongqiang.sun@amd.com>
 <c354ffaf-ffcb-363e-12b1-3a9909087c35@molgen.mpg.de>
In-Reply-To: <c354ffaf-ffcb-363e-12b1-3a9909087c35@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 May 2022 09:48:00 -0400
Message-ID: <CADnq5_NC-W+rxFxWFi5+6bhcjc8itzbWWKYPwaOOBX7WPMpB1A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Check kernel version for 'hypervisor_is_type'
To: Paul Menzel <pmenzel@molgen.mpg.de>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 10, 2022 at 3:12 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Yongqiang,
>
>
> Thank you for your patch.
>
> Am 09.05.22 um 19:07 schrieb Yongqiang Sun:
> > hypervisor_is_type is added since kernel 4.15, dkms package failed to
>
> Also mention the commit hash and summary of the commit adding that.
>
> > install on older kernel e.g. 3.10.
> >
> > Use marcro check kernel version to determine whether the function is
>
> macro (found by my spell checker)
>
> > used.
>
> Please reflow for 75 characters per line.
>
> The Signed-off-by line is missing.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 4 +++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 +++-
> >   2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > index 88b852b3a2cb..963b2e68205e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -28,7 +28,7 @@
> >   #ifdef CONFIG_X86
> >   #include <asm/hypervisor.h>
> >   #endif
> > -
> > +#include <linux/version.h>
> >   #include "amdgpu.h"
> >   #include "amdgpu_gmc.h"
> >   #include "amdgpu_ras.h"
> > @@ -653,10 +653,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
> >                * VEGA10 SRIOV VF with MS_HYPERV host needs some firmware reserved area.
> >                */
> >   #ifdef CONFIG_X86
> > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
> >               if (amdgpu_sriov_vf(adev) && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
> >                       adev->mman.stolen_reserved_offset = 0x500000;
> >                       adev->mman.stolen_reserved_size = 0x200000;
> >               }
> > +#endif
>
> `scripts/checkpatch.pl` warns about using `LINUX_VERSION_CODE`.
>
> >   #endif
> >               break;
> >       case CHIP_RAVEN:
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > index 02b161a1287b..5a50122a1161 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -26,7 +26,7 @@
> >   #ifdef CONFIG_X86
> >   #include <asm/hypervisor.h>
> >   #endif
> > -
> > +#include <linux/version.h>
> >   #include <drm/drm_drv.h>
> >   #include <xen/xen.h>
> >
> > @@ -728,8 +728,10 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
> >               case CHIP_VEGA10:
> >                       soc15_set_virt_ops(adev);
> >   #ifdef CONFIG_X86
> > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
> >                       /* not send GPU_INIT_DATA with MS_HYPERV*/
> >                       if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
> > +#endif
> >   #endif
> >                               /* send a dummy GPU_INIT_DATA request to host on vega10 */
> >                               amdgpu_virt_request_init_data(adev);
>
> Is this patch for inclusion to the Linux kernel or just for people
> building the newer code as module for older Linux kernel versions?

This was meant for our dkms branches for building against enterprise
distro kernels not for upstream.

Alex

>
>
> Kind regards,
>
> Paul
