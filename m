Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58138C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 16:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE7A1130BD;
	Thu,  2 Jun 2022 16:40:56 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3761130BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 16:40:55 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-f2e0a41009so7416980fac.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jun 2022 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZxpEdJOYtMK0inapIOVant4E0EttsmEOZelWajqhOtw=;
 b=Lq0mUUu4jpA4WF/IGa3h7MaBp/8g5+FvfYCtAXB5GprRvL//SlooWDBRM7TZZhOriw
 HggTtGXd+Aa8bVT1vFS6EMb0l8O0Tk++cRRo55fN//yXD00yxBxfs31H4ZUF6/DeGWvH
 QbWU/TEKqbBrkUuGvGFix1O81GGDgoi3/sqauikHfAM5MkU08QvUC5o1ChMOmlFloIyU
 szKydF5SjauC7hgnk9UK9aU5npvn1HvX9bFVBWE/xVkl0vkv+jYiw//B6Ve6TubdEAkw
 8I3SEE7SbTgkH4d+3KN0h0+1M+dIyjD3NpTE6ASwTAKf3EkfKhXpLh0g8FLsXtmAkFpi
 KtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZxpEdJOYtMK0inapIOVant4E0EttsmEOZelWajqhOtw=;
 b=B+4yJ9ZkK04r7VSFqd923BBVQoK81t/ezGNx94G1sBm3Dxzm9eJf+3q7cDeOq64aFC
 ee/fVOcmc3lPstnsKr95o+7QQhRoK9lnFYkzaZqCB4+m+3D3XMHzkaKI25OF5IrGRr/P
 GJr96fdbXC1iEohe4iWxlhrwKrXWyL+mn+iSm3Rla0H6N7YtorE2U+N5257b2sLWxanM
 +tKUmBGjTpgDP7IfPxXe57E5QqtZa/aceQy70JCmMhFz2nFylxF+z4ZTjogSyjLv+9iY
 SvdVJ9kZVswKG76cJpkeeW2qK+rWQy1r3B7/H3FdtS0OioHsv1mXlIAxl4XksI6V6qwt
 u+tw==
X-Gm-Message-State: AOAM5330fNh5UHh5bhLq05EV06n67VS9MS2CQhUUQ03oV0nN+hOhu2Wo
 jSrB72Adj5e6KqwBne4E8YkT32eJvNQtDbtvqqOn2jib
X-Google-Smtp-Source: ABdhPJw9svu9g10hzPWusfAM9mePlDK55vydFJftJzcUgwCJyUyXln4QxtVLMwZzFmvYi8NyCA1962us/1QPluRlZ2o=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr3303637oap.253.1654188055237; Thu, 02
 Jun 2022 09:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220520150912.762831-1-alexander.deucher@amd.com>
In-Reply-To: <20220520150912.762831-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Jun 2022 12:40:43 -0400
Message-ID: <CADnq5_OZ5e1hfA_6O1q=evs0RbVsH1xf8xybcarTMztZhdvEsg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size (v3)
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

@Christian Koenig
Any objections to this?  I realize that fixing the OOM killer is
ultimately the right approach, but I don't really see how this makes
things worse.  The current scheme is biased towards dGPUs as they have
lots of on board memory so on dGPUs we can end up setting gtt size to
3/4 of system memory already in a lot of cases since there is often as
much vram as system memory.  Due to the limits in ttm, we can't use
more than half at the moment anway, so this shouldn't make things
worse on dGPUs and would help a lot of APUs.  Once could make the
argument that with more vram there is less need for gtt so less chance
for OOM, but I think it is more of a scale issue.  E.g., on dGPUs
you'll generally be running higher resolutions and texture quality,
etc. so the overall memory footprint is just scaled up.

Alex

On Fri, May 20, 2022 at 11:09 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Certain GL unit tests for large textures can cause problems
> with the OOM killer since there is no way to link this memory
> to a process.  This was originally mitigated (but not necessarily
> eliminated) by limiting the GTT size.  The problem is this limit
> is often too low for many modern games so just make the limit 1/2
> of system memory. The OOM accounting needs to be addressed, but
> we shouldn't prevent common 3D applications from being usable
> just to potentially mitigate that corner case.
>
> Set default GTT size to max(3G, 1/2 of system ram) by default.
>
> v2: drop previous logic and default to 3/4 of ram
> v3: default to half of ram to align with ttm
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index d2b5cccb45c3..7195ed77c85a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1798,18 +1798,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>         DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>                  (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
>
> -       /* Compute GTT size, either bsaed on 3/4th the size of RAM size
> +       /* Compute GTT size, either bsaed on 1/2 the size of RAM size
>          * or whatever the user passed on module init */
>         if (amdgpu_gtt_size == -1) {
>                 struct sysinfo si;
>
>                 si_meminfo(&si);
> -               gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> -                              adev->gmc.mc_vram_size),
> -                              ((uint64_t)si.totalram * si.mem_unit * 3/4));
> -       }
> -       else
> +               /* Certain GL unit tests for large textures can cause problems
> +                * with the OOM killer since there is no way to link this memory
> +                * to a process.  This was originally mitigated (but not necessarily
> +                * eliminated) by limiting the GTT size.  The problem is this limit
> +                * is often too low for many modern games so just make the limit 1/2
> +                * of system memory which aligns with TTM. The OOM accounting needs
> +                * to be addressed, but we shouldn't prevent common 3D applications
> +                * from being usable just to potentially mitigate that corner case.
> +                */
> +               gtt_size = max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> +                              (u64)si.totalram * si.mem_unit / 2);
> +       } else {
>                 gtt_size = (uint64_t)amdgpu_gtt_size << 20;
> +       }
>
>         /* Initialize GTT memory pool */
>         r = amdgpu_gtt_mgr_init(adev, gtt_size);
> --
> 2.35.3
>
