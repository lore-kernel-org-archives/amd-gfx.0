Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C6CC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jan 2022 21:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FAB310E129;
	Sat,  8 Jan 2022 21:12:53 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F2B10E129
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jan 2022 21:12:52 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 s21-20020a05683004d500b0058f585672efso10848259otd.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Jan 2022 13:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zi58bo3z1uYFH0+sfWOohYm8aeZbFjKsCp9TftSMKQM=;
 b=PB1AgbaFFmBvMijYaYFe59Ltxq57flBwRFpKcFblmCvMWUzavwW7CiLmE/xrGwqUXv
 vTT0zyxCN4OjAE4iIfG4eg+pvty1DJJzzbWXz0zj8ENe3odfzN6UOhfmHnvud5U1CLdA
 nRS5iVeFbEy9pCHgE8z4ff3mTCc0l1SkgPd+ZGlyDFX4gJfCtMz57fLTjiiaqHFxbzZ0
 xC6hbHP/lOVT/5meBEN9R576+0efllLBkoNczFBzkQs60zLbHyiELZ+EX7v8yadKmfCS
 axbVqYKOzkFG+MzrZ4Zbjm6DAsPAkM9iXHC6x/+cRIeeqoX1K9XmY7ONB/kumixjGD1U
 zd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zi58bo3z1uYFH0+sfWOohYm8aeZbFjKsCp9TftSMKQM=;
 b=SN3mTXJ0qC0J/ysczAQsVssUBeK1c2QRTyJIkSYcaPZsEQoMMB2ZOZouFGh3SFaQgN
 3VLPs22q8mxQPNRSnZBntEEUelyLiPAp/BWwI9DSb2TuZknLvYURKmfXiQX1L+ghIqBt
 EcrF5fq89O87Xv+N82va2Z49tbUbFHPVdrnyU6Z9RWAmeQtZ6pwkxk4XWOD6GXeRcjsV
 Mn20byN0sU078DOPUX44VePiKdxgD0GpwOlIqAqRVNzn6hRZy3o8r7inOZkkakZKs7T+
 xbRDtFHqMFhuS4KiJD68iJnvv7AVAwiJUsBESvJuO7LLBU+WS1yYVW8LcqG7xlAMGcAh
 B2dA==
X-Gm-Message-State: AOAM532LHHeGAvHk7humxsQnLykIGkgYmd7sGnc9LE+IxHhB35dy8d4w
 +O1YvSmifr2vlLSZR9OQjM2k0y01l1tKZq2jY6w=
X-Google-Smtp-Source: ABdhPJxMeMM9CO9lUBSjOpSWRLXcoSwB3oQf8OcCZtZU8nxz6+ykDFOqRecuTj3udNOzpXl6iE6Drjrspn61sj0jMlQ=
X-Received: by 2002:a9d:6390:: with SMTP id w16mr51307119otk.200.1641676371673; 
 Sat, 08 Jan 2022 13:12:51 -0800 (PST)
MIME-Version: 1.0
References: <20220107120740.1041489-1-tom.stdenis@amd.com>
In-Reply-To: <20220107120740.1041489-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 8 Jan 2022 16:12:40 -0500
Message-ID: <CADnq5_Puzsx67iFTxzitLCQ0EOBUm0Db-dn2Yj-N8XTNVWbGeg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add pcie indirect support to
 amdgpu_mm_wreg_mmio_rlc()
To: Tom St Denis <tom.stdenis@amd.com>
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

On Fri, Jan 7, 2022 at 7:07 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> The function amdgpu_mm_wreg_mmio_rlc() is used by debugfs to write to
> MMIO registers.  It didn't support registers beyond the BAR mapped MMIO
> space.  This adds pcie indirect write support.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c38e0e87090b..53a04095a6db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -552,7 +552,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
>  }
>
>  /**
> - * amdgpu_mm_wreg_mmio_rlc -  write register either with mmio or with RLC path if in range
> + * amdgpu_mm_wreg_mmio_rlc -  write register either with direct/indirect mmio or with RLC path if in range
>   *
>   * this function is invoked only the debugfs register access
>   */
> @@ -567,6 +567,8 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>             adev->gfx.rlc.funcs->is_rlcg_access_range) {
>                 if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
>                         return adev->gfx.rlc.funcs->sriov_wreg(adev, reg, v, 0, 0);
> +       } else if ((reg * 4) >= adev->rmmio_size) {
> +               adev->pcie_wreg(adev, reg * 4, v);

Actually, for older asics, we shouldn't we be using mmINDEX/mmDATA
rather than the pcie indirect registers?  Or is that handled already
somehow?

Alex

>         } else {
>                 writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>         }
> --
> 2.32.0
>
