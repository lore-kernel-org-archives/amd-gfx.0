Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05A4C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 22:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A805C22DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 22:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A805C22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C0C6E0E8;
	Tue,  5 Jan 2021 22:10:51 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4A36E0E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 22:10:50 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id q205so1245335oig.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Jan 2021 14:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rP2J5unAMggGFWigwXQl+Oxr01QJnBASJRWyQxWFags=;
 b=Fmzh5HJweh9Lur8ZXUvzB3iuSVQpiCkXqZLnocBdKzs9r17HK/Qvg8Qmfm2zEMMG6z
 jgio2d4KV3M59q28fuz2Y5zW0ZH762bTWQLPaneWrQyAwtZ0HGoj36XK8bKntMnEixw6
 NfwjDxJrCQRQMmr6kV/LP9Cx73FFymmxvxu0j2aeCi567XZmuyZhS3KV8tcoqD3uJ9z8
 9UJ5TveMGKfw/sy923kb8wh3DFbXpnvT1BLqrpdSRxazaah2/hOEEtsLqa5fZC3jSnKj
 qxGzwGERikhaZ0xg0mzANFrlCK/41HOYulEgIWp+DZd/aVSn1OXlHc1TtG7wHaFpEGLI
 1hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rP2J5unAMggGFWigwXQl+Oxr01QJnBASJRWyQxWFags=;
 b=phPeH4MTwG6Zg9gZ7eUc3EOLcNkosmu0jvauG+Wt7h1TfBbBq4EnmfrymsNDjiZkx8
 DNHCY7T8H6YVwlKvtGipUHen4HmzrRYZ6rUDWpEle99MumWdBGmD3kP4of5MA1v45y1Z
 QyGoairqtHuyiLqB9jyA4+hMSKeZ5ogQxdaJcisKciMv7bPSV3YzTo48QGVsxb0z+n8R
 nZUP8g/AVkiMkyy22yujoSDvR9icOn7NG6XxSr2E4WLpXZahhLd5CojSnby1kbd+brso
 d2Fb28LLbFuE8MirOuBkePw+h12K4H62fFZVv+nJU/0aKeHj6sfLB/2GB3ERFCFjTbzZ
 w7Dw==
X-Gm-Message-State: AOAM533rU2RA34YqibjIiXdzMehbXueCVSvZ/CZpqGk2qlpDsOG5mZbG
 7puPS0BLlNKcI3jQzrSEhWRMi1N7cs7VKIn+8pg=
X-Google-Smtp-Source: ABdhPJw6c86PgpP0MnNJVn4V2cd9TZAKDiNRIZ45QWxx+ftywxVRJ8AtCmZLcWwogLPIKtu8NQqOsStR4eTP4r34rOE=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr1237723oib.123.1609884649728; 
 Tue, 05 Jan 2021 14:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20210105220359.1392555-1-joshua@froggi.es>
In-Reply-To: <20210105220359.1392555-1-joshua@froggi.es>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Jan 2021 17:10:38 -0500
Message-ID: <CADnq5_NcKG9H-dK0Kh2ksF8et+fnFkMdsejkg_RWrNeJ1JS4ng@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't limit gtt size on apus
To: Joshua Ashton <joshua@froggi.es>
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
Cc: Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 5, 2021 at 5:05 PM Joshua Ashton <joshua@froggi.es> wrote:
>
> Since commit 24562523688b ("Revert "drm/amd/amdgpu: set gtt size
> according to system memory size only""), the GTT size was limited by
> 3GiB or VRAM size.

The commit in question was to fix a hang with certain tests on APUs.
That should be tested again before we re-enable this.  If it is fixed,
we should just revert the revert rather than special case dGPUs.

Alex


>
> This is problematic on APUs, especially with a small carveout
> which can be as low as a fixed 128MiB, as there would be very a limited
> 3GiB available for video memory.
> This obviously does not meet the demands of modern applications.
>
> This patch makes it so the GTT size heuristic always uses 3/4ths of
> the system memory size on APUs (limiting the size by 3GiB/VRAM size
> only on devices with dedicated video memory).
>
> Fixes: 24562523688b ("Revert drm/amd/amdgpu: set gtt size according to
> system memory size only")
>
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++++---
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 72efd579ec5e..a5a41e9272d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -192,8 +192,9 @@ module_param_named(gartsize, amdgpu_gart_size, uint, 0600);
>
>  /**
>   * DOC: gttsize (int)
> - * Restrict the size of GTT domain in MiB for testing. The default is -1 (It's VRAM size if 3GB < VRAM < 3/4 RAM,
> - * otherwise 3/4 RAM size).
> + * Restrict the size of GTT domain in MiB for testing. The default is -1 (On APUs this is 3/4th
> + * of the system memory; on dGPUs this is 3GiB or VRAM sized, whichever is bigger,
> + * with an upper bound of 3/4th of system memory.
>   */
>  MODULE_PARM_DESC(gttsize, "Size of the GTT domain in megabytes (-1 = auto)");
>  module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4d8f19ab1014..294f26f4f310 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1865,9 +1865,15 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                 struct sysinfo si;
>
>                 si_meminfo(&si);
> -               gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> -                              adev->gmc.mc_vram_size),
> -                              ((uint64_t)si.totalram * si.mem_unit * 3/4));
> +               gtt_size = (uint64_t)si.totalram * si.mem_unit * 3/4;
> +               /* If we have dedicated memory, limit our GTT size to
> +                * 3GiB or VRAM size, whichever is bigger
> +                */
> +               if (!(adev->flags & AMD_IS_APU)) {
> +                       gtt_size = min(max(AMDGPU_DEFAULT_GTT_SIZE_MB << 20,
> +                               adev->gmc.mc_vram_size),
> +                               gtt_size);
> +               }
>         }
>         else
>                 gtt_size = (uint64_t)amdgpu_gtt_size << 20;
> --
> 2.30.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
