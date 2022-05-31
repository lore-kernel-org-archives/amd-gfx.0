Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DADC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 21:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A39510E17F;
	Tue, 31 May 2022 21:14:51 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DD910E17F
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 21:14:50 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id k11so44201oia.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kbGxwiLrWeQp/3ZKIIm9pBSjkZjiixOWSfpyYDZVThs=;
 b=kJJfbnF7O4LR3puM948II/eC8+f6sM1vC8PNPgqFXXYEgJy6CUkItumrEZC8fOkf6r
 n1u4xekQcsB+OEoTYX72cVAn0qRPZN/sbsNa6jItOQHZ2afouTTwWWSt9Bx+aSMb7r99
 nZdBDjRnwA5OOBGuOnz36Cq3RkX282aaZRLuDinIfbL+uAa0JAQnwjt1qmhXhRra+y/K
 Hcf1MEpzeYvNNpwokwDxh7vQDUJ4Udj1rHiZouRofiojYABX7GAG+yCHvVdojYJtBae1
 Qg6e4VUMcNPyEPBnug3nAUGv81DvPTVMLq299qvg0UraOUcFSCQA1uHoouEExXzjvRnL
 lNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kbGxwiLrWeQp/3ZKIIm9pBSjkZjiixOWSfpyYDZVThs=;
 b=K8X2K28lsAgOE7lVFVPcRXCtoKxRcN441Tb5OBDVx3Crhb0E2ai8Dl/xMuatXZBHZK
 CKvPhoZeYzYDJ97ddrpBEHcu7XLDXYgfHII52vjUaV62BeodZDWa36y3zoVOuhswvWl0
 9JJ1g+ZuaIhmekAiMK/W+01MR3avjeq2M5bXkLJxu9r6clYH5+ENBCFNFBg/Cvc0q1OF
 Jeq7zFVNDi0Znb6pY6Sm5QAcIaBBl4pnQw8VMLBvbYciR60vuPGyLkvHDsu3uG2z2RYY
 UfgvakUaYLtgWiTt9+ECdIP2FFucLNw1QrMOQJ4R/YNjxpMlxnJmm+Zye9dxflqKdAZD
 N8Xw==
X-Gm-Message-State: AOAM530aI/0x0U866HyI8ZlNP8iX1ipUI+IqE41HjWKGwN/v9J9yyz0I
 PJLeiuDVSt1aFJFF0dPPvNtPRqfVYyg7tQISef8=
X-Google-Smtp-Source: ABdhPJw7IxMrzk7h/spfmgtiLXauoPXShctTa6D/7/NP+Dk70Gs9IU7wRgOtEJtMSayOIueQNsB6Te0AWUPTAbRzawM=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr12730754oiu.200.1654031689462; Tue, 31
 May 2022 14:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220526175835.3044451-1-alexander.deucher@amd.com>
 <20220526175835.3044451-2-alexander.deucher@amd.com>
In-Reply-To: <20220526175835.3044451-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 May 2022 17:14:38 -0400
Message-ID: <CADnq5_MN=wOJOc+X0o0j=H2hQW0QRfZgG+oghg6LB+_hBcmnBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gmc11: enable AGP aperture
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Thu, May 26, 2022 at 1:58 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Enable the AGP aperture on chips with GMC v11.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c  | 7 ++++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    | 1 +
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 6 +++---
>  4 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index 5eccaa2c7ca0..f99d7641bb21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -154,10 +154,11 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>  {
>         uint64_t value;
>
> -       /* Disable AGP. */
> +       /* Program the AGP BAR */
>         WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> -       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
> -       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, 0x00FFFFFF);
> +       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> +       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
> +
>
>         /* Program the system aperture low logical page number. */
>         WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index b6daa4146dd3..635103c7e2a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -654,6 +654,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
>
>         amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>         amdgpu_gmc_gart_location(adev, mc);
> +       amdgpu_gmc_agp_location(adev, mc);
>
>         /* base offset of vram pages */
>         adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> index bc11b2de37ae..4926fa82c1c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> @@ -169,10 +169,10 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>         uint64_t value;
>         uint32_t tmp;
>
> -       /* Disable AGP. */
> +       /* Program the AGP BAR */
>         WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
> -       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
> -       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
>
>         if (!amdgpu_sriov_vf(adev)) {
>                 /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> index 770be0a8f7ce..5e5b884d8357 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> @@ -162,10 +162,10 @@ static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
>         uint64_t value;
>         uint32_t tmp;
>
> -       /* Disable AGP. */
> +       /* Program the AGP BAR */
>         WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
> -       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
> -       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
>
>         if (!amdgpu_sriov_vf(adev)) {
>                 /*
> --
> 2.35.3
>
