Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11551C43217
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Apr 2022 16:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E5EF10EB88;
	Thu,  7 Apr 2022 16:21:51 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F61110EB74
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Apr 2022 16:21:50 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-d6e29fb3d7so6872451fac.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Apr 2022 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=scCMTYirdIN16BpRpTl1wCjr8NBPs9DgH4X2XBWlK+Q=;
 b=c8JZ2fy1llaMC+6V+gWkGZAGBzgizpeO5E6ZCd8l0rrDtCLdilx96rWIGYXQaKaULk
 Vuq2f11oG5b+XMoOc1EioUQD905AZfSVCaIBoBDv0RLmpF9ML2fWyhsze6YPLMgeNyZ8
 ao2QAfQ62VMedJYX5qgTQW1f/9MfIX7pm8QyezsGzMgZAmCXx1LIuOhaLpiNltUhKbZA
 A9shCZziJJ+Qit4Youk/qD/t9g0NJek2B5+1Yi7GEtANNasbu+0iUquN1HrkCw5CMDn1
 BpgVq0oKcxH/9tE3rlenOOI2QTwlFAB1S8NlpP8BX3+EnqLU/ZUqF5u5xxaEa8JTNX+i
 P63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=scCMTYirdIN16BpRpTl1wCjr8NBPs9DgH4X2XBWlK+Q=;
 b=u6oRUmYUcIgiC4jmwJuhx9dTUPrYaDc2DRS39VsN7Xkm5o0XTKsm7puF/GVbrfFR2X
 nI4PwZPCvy4DVTj5Fv+/seJLA4nprHBtwB9+kteaSU3Wx1Uv1JCZT9/rESw0MKGiyW7v
 N+IxR8G+xw7j8NeB53cxi9GMEN0yQUzMOFVd+jktb/9InoY5JcB7oIWowBhYTWpbJmOG
 07adhxpVOzZqFE43OfrgxKzrQ/K2JryaZfbsNsw8IY9klmzf4oJZWbNJH7RV7HNzQYsA
 hILZW4G7ljFiPMKgc5YlBNIVyglQvktIc0MCo/FBPHWN3HqQQj61QncgSFefEFUpRK0N
 R4hA==
X-Gm-Message-State: AOAM531Ub3QWa1T5MWCzrJg/UBFKTPlvzMcfHt+ZkopiRxDky6yrU6D1
 gHgayF8LgqjpB0ifKZ6s7Edn4rptB0GnxoL5STo=
X-Google-Smtp-Source: ABdhPJy1//J3DA++mkdjZHFINfLjHLJN9VHcbHk2irVrGLVhq+1dR+kJXZWr9mOXxVg3z6TGyTk4Sqk0lIGDGjRN5vc=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr6236621oaa.200.1649348509299; Thu, 07
 Apr 2022 09:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220406140320.547463-1-yongqiang.sun@amd.com>
In-Reply-To: <20220406140320.547463-1-yongqiang.sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Apr 2022 12:21:38 -0400
Message-ID: <CADnq5_OvjvaBSwJxp-zV6fvDchBKsjAncL=VnWVZXGbWiakW0A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Only reserve vram for firmware with
 vega10 Hyper-V host.
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

On Wed, Apr 6, 2022 at 10:03 AM Yongqiang Sun <yongqiang.sun@amd.com> wrote:
>
> driver loading failed on VEGA10 SRIOV VF with linux host due to a wide
> range of stolen reserved vram.
> Since VEGA10 SRIOV VF need to reserve vram for firmware with windows
> Hyper_V host specifically, check high part of FB address
> to only reserve memory for it, and the range of the reserved vram
> can be limited to between 5M-7M area.

I'm not super familiar with how we set up things on the hypervisor
side, but I'll take your word for it that this would only affect
hyperv.  Please add:
Fixes: 8011a76ad370 ("drm/amdgpu: Add stolen reserved memory for MI25 SRIOV.")
With that:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 3 +++
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index a66a0881a934..324b43c1bc4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -647,11 +647,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
>         case CHIP_VEGA10:
>                 adev->mman.keep_stolen_vga_memory = true;
>                 /*
> -                * VEGA10 SRIOV VF needs some firmware reserved area.
> +                * VEGA10 SRIOV VF with hyper-v host needs some firmware reserved area.
>                  */
> -               if (amdgpu_sriov_vf(adev)) {
> -                       adev->mman.stolen_reserved_offset = 0x100000;
> -                       adev->mman.stolen_reserved_size = 0x600000;
> +               if (amdgpu_sriov_vf(adev) &&
> +                   (adev->gmc.vram_start & AMDGPU_GMC_HYPERV_FB_BASE_MASK)) {
> +                       adev->mman.stolen_reserved_offset = 0x500000;
> +                       adev->mman.stolen_reserved_size = 0x200000;
>                 }
>                 break;
>         case CHIP_RAVEN:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 032b0313f277..906ec15e8dac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -61,6 +61,9 @@
>   */
>  #define AMDGPU_GMC_FAULT_TIMEOUT       5000ULL
>
> +/* High part (33 - 47bit) FB address for VEGA10 HYPERV Host*/
> +#define AMDGPU_GMC_HYPERV_FB_BASE_MASK 0xF400000000ULL
> +
>  struct firmware;
>
>  /*
> --
> 2.25.1
>
