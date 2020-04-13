Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E35C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 04:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D18206A1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 04:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+q8PHcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D18206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 380216E157;
	Mon, 13 Apr 2020 04:00:29 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 623366E157
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 04:00:28 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id 65so8955094wrl.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Apr 2020 21:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MnOUmK/vJN2aC91hopTs4L0VRNL9bJsShHV5iLuHxkc=;
 b=M+q8PHcKz4z6tNrNm4mlaqL+01uByZh3LLMkrKSJcuyUl4SAfo227p98em9RJdmCLN
 olkR7TN3IgMaecbiF7S8ZC8Pvvpm//oRl65qBlGYRXGakjiEhyYXN9RVixwjU1kN7tVZ
 MI3GTWgAXh+Af9RgfvvyI8RiI7daMtAgNF2PerBDOU4PTvCi5K6p5aHSyQiRayPfhIWC
 dwpRGhfcwlB7FIEpSZYEAjLydbb/D9Bd5mGkXENoioFRZyU+qGQ18nfICGA2tQvK2qEp
 SxOll9Zik3tNyjDl13UTej5ZAOAVB8VT/7xQ3CXRKdVEyTQTwInD8yZNi+bSR9fxpi1D
 XSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MnOUmK/vJN2aC91hopTs4L0VRNL9bJsShHV5iLuHxkc=;
 b=C8NBO32DffE0TUa2Sw6r37z/jUGKURHCyBBw+hZIXvXGCX8Lw9oYOpjIJojDpkOqSy
 obDrvInbdK7ckTViWlGc3BH1mb7qxCvWZ0Cb2h5ZOt0Vgm16eXztS1KsP48Xfr+a4ua/
 XSlb1xyfPvOYPyobQxDy7wEMNaI3EK9/CAYdszB2AKYHVVGWnua1Iyk22EYvuumpjP4N
 SLFQPPAvv5cIuLlsSKFTnJi31zDKW9Q//3uMzEuFQCbzY4zqSZT/NorTfcm52E3hOgeP
 HOQt+R6d9eqH/hgAuIvn6w0VM0iLDExlNPSnjfTI0cxEulnAXeIZl7e5sbQ0FEj1d63I
 8wcg==
X-Gm-Message-State: AGi0PuaPr+Hsdr+VQbwwCJVd95LoNUMz0/v20e4szd9rZaWFYFkm0Wkg
 ym+oGzwIIYaY+tEZcSpWOqxwPxHB2sTrtmGuhn0=
X-Google-Smtp-Source: APiQypI+5tzxZ5SJwydZLJbArTVwFBBb/xOzqgCHqyIsj5HJXqP21QmseKYaauZQpDr4kMRk9usC4mjNb6IFpkuajSI=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr8472361wrs.124.1586750426914; 
 Sun, 12 Apr 2020 21:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200413030823.3506-1-evan.quan@amd.com>
In-Reply-To: <20200413030823.3506-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2020 00:00:15 -0400
Message-ID: <CADnq5_PAtEHdwUokuRgOP-qeX=oaS3er0EYMQTB1240yDeVLRQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix wrong vram lost counter increment V2
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Apr 12, 2020 at 11:08 PM Evan Quan <evan.quan@amd.com> wrote:
>
> Vram lost counter is wrongly increased by two during baco reset.
>
> V2: assumed vram lost for mode1 reset on all ASICs
>
> Change-Id: I8b9959a5d1632abc774ba07d56cf295bdd8288eb
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/cik.c           |  2 --
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  4 ----
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 ----
>  drivers/gpu/drm/amd/amdgpu/vi.c            |  2 --
>  5 files changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a2a4e4b28d00..8f479a918f0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2087,8 +2087,24 @@ static void amdgpu_device_fill_reset_magic(struct amdgpu_device *adev)
>   */
>  static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
>  {
> -       return !!memcmp(adev->gart.ptr, adev->reset_magic,
> -                       AMDGPU_RESET_MAGIC_NUM);
> +       if (memcmp(adev->gart.ptr, adev->reset_magic,
> +                       AMDGPU_RESET_MAGIC_NUM))
> +               return true;
> +
> +       if (!adev->in_gpu_reset)
> +               return false;
> +
> +       /*
> +        * For all ASICs with baco/mode1 reset, the VRAM is
> +        * always assumed to be lost.
> +        */
> +       switch (amdgpu_asic_reset_method(adev)) {
> +       case AMD_RESET_METHOD_BACO:
> +       case AMD_RESET_METHOD_MODE1:
> +               return true;
> +       default:
> +               return false;
> +       }
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index db68ffa27984..fe306d0f73f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1358,8 +1358,6 @@ static int cik_asic_reset(struct amdgpu_device *adev)
>         int r;
>
>         if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
> -               if (!adev->in_suspend)
> -                       amdgpu_inc_vram_lost(adev);
>                 r = amdgpu_dpm_baco_reset(adev);
>         } else {
>                 r = cik_asic_pci_config_reset(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 7768880fcccf..995bdec9fa7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -351,8 +351,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
>         struct smu_context *smu = &adev->smu;
>
>         if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
> -               if (!adev->in_suspend)
> -                       amdgpu_inc_vram_lost(adev);
>                 ret = smu_baco_enter(smu);
>                 if (ret)
>                         return ret;
> @@ -360,8 +358,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
>                 if (ret)
>                         return ret;
>         } else {
> -               if (!adev->in_suspend)
> -                       amdgpu_inc_vram_lost(adev);
>                 ret = nv_asic_mode1_reset(adev);
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index a597ad22b675..58a440a15525 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -569,14 +569,10 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
>
>         switch (soc15_asic_reset_method(adev)) {
>                 case AMD_RESET_METHOD_BACO:
> -                       if (!adev->in_suspend)
> -                               amdgpu_inc_vram_lost(adev);
>                         return soc15_asic_baco_reset(adev);
>                 case AMD_RESET_METHOD_MODE2:
>                         return amdgpu_dpm_mode2_reset(adev);
>                 default:
> -                       if (!adev->in_suspend)
> -                               amdgpu_inc_vram_lost(adev);
>                         return soc15_asic_mode1_reset(adev);
>         }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 0a90c296409b..af8986a55354 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -744,8 +744,6 @@ static int vi_asic_reset(struct amdgpu_device *adev)
>         int r;
>
>         if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
> -               if (!adev->in_suspend)
> -                       amdgpu_inc_vram_lost(adev);
>                 r = amdgpu_dpm_baco_reset(adev);
>         } else {
>                 r = vi_asic_pci_config_reset(adev);
> --
> 2.26.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
