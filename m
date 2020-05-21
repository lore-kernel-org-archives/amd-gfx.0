Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2D2C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 21:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E194F204EA
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 21:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elNZ9Ndq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E194F204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D5B76E960;
	Thu, 21 May 2020 21:31:05 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1716E960
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 21:31:04 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f134so6839637wmf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mtj8mlkYoUy07YAaXasdlIXzPG6vykuPqV+CeYkWwLQ=;
 b=elNZ9NdqT4Xdy9xvMFuVZMMmjBm3iJLLkV6n8P4C8o5QVzOdz1RS/pDmhGN5aMQIJ7
 YZ6DUicliZhni1/F0krvz88SblRCvju7rOnV4hdeJG/GOS0Knloh19LTYprDsRB9hzP1
 8pxLSYf53ZsARlSZzmI+KRhsVjEZEbyi6r1A/Vnh91LoLevdzjaGIXtClEaiy+VC5tBv
 bMtl3pgfpegZfgcxw/O3lDKHbA5HQKQ7p8W4ErZhuJ5zwYvhV4m3bK/NV7iW3EMTTOlP
 DRLhRWd3lXgstBbeqckm0Ar1QbnKrBJqXrVsscmOO+kaWSIt5D6T7iM3xVbOKQreavWF
 8YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mtj8mlkYoUy07YAaXasdlIXzPG6vykuPqV+CeYkWwLQ=;
 b=Ql6yGg9CTtWhaZMHisFoQh02nGswbG+wvnWVuJP56a/RwSUPpgS8T2iJQas6V9TW0l
 upV0lJM4UmDLFXl6gWD/XP8PKth3kUU2j26Fc+i9b7nvBlHoe67FiE6sG5dffZuMRQOe
 Zv/Lx8bjvLHEJhxumhcFBahdD6Jnf+HPkGVgAl+g6sfz5zIK/z3JRcrlEXgoPdvOz6xe
 a8BXzkTMnhpc828QkQVD6ZZfjfbIf6CMCCkrYBGRha12GMyc3qOtDRVNn27fUKVXa4cX
 bM7cu1Cv3VpfgNssQK7YKOtqkpS9NLG5KfX08HBaQPAbZosv5ZdkICif+RfOsif+FEMM
 vwCg==
X-Gm-Message-State: AOAM5332/mMzpRq+P7BfivVNEDdqa3ODZRL/DvqXv49FKMk3TVatugP5
 PSbyCA0ujCu/H8WmMDQ+Vb9jYf6oneCgGBrI7g/kbw==
X-Google-Smtp-Source: ABdhPJyvcqSdVOtCN79KlVHTHKC5KIKwm/RzQ2998PElxp7hS/aEm3UfOp+GZpozXpUmu5zM8lQuQPIIJ6p8ZR5ePnk=
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr10443318wmp.73.1590096662821; 
 Thu, 21 May 2020 14:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200521202931.15726-1-reiver@improbability.net>
In-Reply-To: <20200521202931.15726-1-reiver@improbability.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 May 2020 17:30:51 -0400
Message-ID: <CADnq5_PWMxJaVW-EDNaLyYM8wXKyT1TV0Mwz0sEs3uR_7HpkpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: resize VRAM BAR for CPU access on gfx10
To: Alan Swanson <reiver@improbability.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 21, 2020 at 4:48 PM Alan Swanson <reiver@improbability.net> wrote:
>
> Try to resize BAR0 to let CPU access all of VRAM on Navi. Syncs
> code with previous gfx generations from commit d6895ad39f3b39
> ("drm/amdgpu: resize VRAM BAR for CPU access v6").
>
> Signed-off-by: Alan Swanson <reiver@improbability.net>

Tested and applied.  Thanks!

Alex

> ---
> Unfortunately cannot test this with my RX5700 on my AMD X470
> motherboard as its BIOS "Above 4G decoding" option does not
> remap the PCI root bus. Trying "pci=nocrs" also unsuccessful.
> However, I assume it's just absent due to missed commit
> overlap during gfx10 bring up and should work.
>
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index edaa50d85..ba2b7ac0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -686,17 +686,23 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
>   */
>  static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>  {
> -       /* Could aper size report 0 ? */
> -       adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -       adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +       int r;
>
>         /* size in MB on si */
>         adev->gmc.mc_vram_size =
>                 adev->nbio.funcs->get_memsize(adev) * 1024ULL * 1024ULL;
>         adev->gmc.real_vram_size = adev->gmc.mc_vram_size;
> -       adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +
> +       if (!(adev->flags & AMD_IS_APU)) {
> +               r = amdgpu_device_resize_fb_bar(adev);
> +               if (r)
> +                       return r;
> +       }
> +       adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> +       adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
>
>         /* In case the PCI BAR is larger than the actual amount of vram */
> +       adev->gmc.visible_vram_size = adev->gmc.aper_size;
>         if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>                 adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
