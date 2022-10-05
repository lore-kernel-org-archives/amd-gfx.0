Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5729FC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Oct 2022 21:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C9B10E78D;
	Wed,  5 Oct 2022 21:16:38 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1524C10E78D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Oct 2022 21:16:36 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 x6-20020a4ac586000000b0047f8cc6dbe4so154105oop.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Oct 2022 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=l5ZVnam5aFaB5DYOy9GAx5Biczbe2q2ejyCSU0dpVck=;
 b=kjlenRPH/ngDd8RdNSbzaYO3oBRIv9GEJwhyKxa9a6s2S7QvwXap8qmth+vxDl+xCo
 IjMm0ktetl9YshRCSaz8SyykbGc6XwtC6uVGYjj3CJ70TTFZsVMUOyt5zYvarLOA25xB
 Mj1g78RPUFVeUi+m8LycbkbgmM4F112aB6CWyVakqM1+qvcCJZJH4eXRQvVMJOZBONUG
 Gz+naWKYi7KnBgeBOXOd2Rm4N8dKUkSWyWSvXEID6huQXPfUEEFtYKJFZBcaum+M5Uhn
 /LAdWP3XoycwypeIE/FLhbMXEksxJZjO8+1N1sC2+SEBZ+GwEKqKnZf201UH77sY94zv
 9pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=l5ZVnam5aFaB5DYOy9GAx5Biczbe2q2ejyCSU0dpVck=;
 b=uJZlUdtCo+XoCt6oiVNV6lUxj2gyqWzoUrRg0v9q00VRbJOGJj/n1BMMNNSsS056Qf
 7jPCRDEkBOAqX8iG8NHL8u1qDKLadQRyDpJDfODVcyTetwwNt6J2vCAPaGoC4XcKmQ61
 DJtWfhHy78fIpeDFf4gTUhUrcVTTtF3vm0CoASp1CINRH3m237RLZZ0Yh4FLWnZyzISt
 vLi2Fo9kiOp/TCkyVk5Wuzd1oUBCkBeYSCukov3jYAqhqVvbCMOPfqf5d8djW3wa5R8q
 EDabp9ioNYWyaFjAOJ2TOrK6nw3gdCHDfe/OKVHZ4g7UHXykEPssCg9LBhoHvUfFNoC9
 hFCw==
X-Gm-Message-State: ACrzQf2nK3lz+i1vbyjLfCQmdx9a56SBgc7OISZ4s/ta1mRW53y62jo8
 +7ymWT5b6eAdH10gx1Nxos+N9dERkF2Z6XknqL0=
X-Google-Smtp-Source: AMsMyM4vDrfzt3XK2z+ATtOFiZpwdJaeruEy4HVERmFc52Pihb5k6dMxPzni82k1uCrHZRpyUjiQ88frZ5Krx+K6JkE=
X-Received: by 2002:a9d:6215:0:b0:660:f41e:513a with SMTP id
 g21-20020a9d6215000000b00660f41e513amr125614otj.123.1665004595282; Wed, 05
 Oct 2022 14:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221005154719.57566-1-hamza.mahfooz@amd.com>
In-Reply-To: <20221005154719.57566-1-hamza.mahfooz@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Oct 2022 17:16:23 -0400
Message-ID: <CADnq5_PvcvkwJr582bUBVYzBse8csTVhs_Q4vifjnLaNzsVFAQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: use dirty framebuffer helper"
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Oct 5, 2022 at 11:47 AM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>
> This reverts commit 10b6e91bd1ee9cd237ffbc244ad9c25b5fd3e167.
>
> Unfortunately, this commit causes performance regressions on non-PSR
> setups. So, just revert it until FB_DAMAGE_CLIPS support can be added.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2189
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 23998f727c7f..1a06b8d724f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -38,8 +38,6 @@
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <drm/drm_crtc_helper.h>
> -#include <drm/drm_damage_helper.h>
> -#include <drm/drm_drv.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_fb_helper.h>
> @@ -500,12 +498,6 @@ static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
>         .create_handle = drm_gem_fb_create_handle,
>  };
>
> -static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic = {
> -       .destroy = drm_gem_fb_destroy,
> -       .create_handle = drm_gem_fb_create_handle,
> -       .dirty = drm_atomic_helper_dirtyfb,
> -};
> -
>  uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>                                           uint64_t bo_flags)
>  {
> @@ -1108,10 +1100,8 @@ static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
>         if (ret)
>                 goto err;
>
> -       if (drm_drv_uses_atomic_modeset(dev))
> -               ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs_atomic);
> -       else
> -               ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
> +       ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
> +
>         if (ret)
>                 goto err;
>
> --
> 2.37.3
>
