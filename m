Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A511C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Apr 2022 19:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB5AA10E75B;
	Thu,  7 Apr 2022 19:30:45 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A954210E75B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Apr 2022 19:30:44 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-df02f7e2c9so7458244fac.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Apr 2022 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R/5KGpjDBPLGg4yx4RLbW8+0Tw6HHStB9Z7imSK2jY8=;
 b=W1aSagfKI0n17hyYqanWRPUth8wGCKvrfXMH7aALsSOflNee7ScyCDG+suyLS19n7Q
 mw0ifUWQHo11m0oSGPJLA/dbf+ljOmonlIRa35MNSLgz/uvmYAmduTxeHcrmfIwvFKMT
 kn3Jqtla1Gj/lgH1Ul/378ZRX+QTTBmCYRekLWZVnMgjrx0Rz3hTnTG5UFly9iI05171
 bG0kqzgLjxlu02Xvt/jh8kjxY8R+q/rpvXAt/GTz7bPYTyc4BawmQBWNkgCX3jtPWAgW
 YIQhJCy4C1BzwFJn7OjxPQtNntlee5hIw7T8DMpFxINq0kBKRlxngfESLip9/m7qshrF
 JmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R/5KGpjDBPLGg4yx4RLbW8+0Tw6HHStB9Z7imSK2jY8=;
 b=NM0MEEZA8jF2h0jWVH+R82AjWIyLwbu1CvBlZs1xSqH74rIUAkjKNxwnBmK4n/gXXU
 KpxufL+IGND79LdkrZK60sNhCOj0yQX6qIu7+t1hFuzNG2LXKiJeaTBAx+dBXLrd4/dn
 V5Z85bDN9U9Ni+hIIECRcs+SIG85Bv/dDTm+xE5DGmGE9p6u3/GHVAQ53427TXWelICF
 E3AP7AYXixcyCrcWYJW/xyoXgcoCtoh4ETPqgNweh1Hkk+HiIge8KQRvV5rDlZ5tKUUP
 pPptwfrRlE9c1xStDBc1b6v0ycDLJxk7Ueh9wMFa/81NlQk1IqlbCms3y8Gac7MCkMyz
 qmYA==
X-Gm-Message-State: AOAM533l+OPZOJ9rsvv683Cr0f6IgcXCbzyAD0AX8zpoM6NbdBZ8zwaw
 oCeDxacyTrZYn4QDpX8IbnBiFp9DIkcCc60vG/HWJhR2
X-Google-Smtp-Source: ABdhPJycaLfoJ23+GyRpw6Wf1kroXI/lBveK1MkDlgMoTPjffVrk14GemPKMedLQj1nFnKwDNxKPkjQNoH6pXV+s9TQ=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr7296549oap.253.1649359843912; Thu, 07
 Apr 2022 12:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220407183451.21223-1-yongqiang.sun@amd.com>
In-Reply-To: <20220407183451.21223-1-yongqiang.sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Apr 2022 15:30:32 -0400
Message-ID: <CADnq5_Nw6Q7CFQ4i6coEaMeCcARzHksZcUODzOODUbyidhFBKw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Only reserve vram for firmware with
 vega10 MS_HYPERV host.
To: Yongqiang Sun <yongqiang.sun@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 7, 2022 at 2:35 PM Yongqiang Sun <yongqiang.sun@amd.com> wrote:
>
> Fixes: 8011a76ad370
> ("drm/amdgpu: Add stolen reserved memory for MI25 SRIOV.")

Please put this line between the commit message and your signed-off-by.

>
> driver loading failed on VEGA10 SRIOV VF with linux host due to a wide
> range of stolen reserved vram.
> Since VEGA10 SRIOV VF need to reserve vram for firmware with windows
> Hyper_V host specifically, check hypervisor type to only reserve
> memory for it, and the range of the reserved vram can be limited
> to between 5M-7M area.
>
> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index a66a0881a934..3e9582c245bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -25,6 +25,7 @@
>   */
>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <asm/hypervisor.h>
>
>  #include "amdgpu.h"
>  #include "amdgpu_gmc.h"
> @@ -647,11 +648,11 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
>         case CHIP_VEGA10:
>                 adev->mman.keep_stolen_vga_memory = true;
>                 /*
> -                * VEGA10 SRIOV VF needs some firmware reserved area.
> +                * VEGA10 SRIOV VF with MS_HYPERV host needs some firmware reserved area.
>                  */
> -               if (amdgpu_sriov_vf(adev)) {
> -                       adev->mman.stolen_reserved_offset = 0x100000;
> -                       adev->mman.stolen_reserved_size = 0x600000;
> +               if (amdgpu_sriov_vf(adev) && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
> +                       adev->mman.stolen_reserved_offset = 0x500000;
> +                       adev->mman.stolen_reserved_size = 0x200000;
>                 }
>                 break;
>         case CHIP_RAVEN:
> --
> 2.25.1
>
