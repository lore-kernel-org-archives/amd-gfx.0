Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F8C33CAC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 18:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9CB20659
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 18:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKUEb6Z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9CB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EABC6FB03;
	Thu,  6 Feb 2020 18:28:51 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E456FB03
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 18:28:50 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id s10so1060692wmh.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2020 10:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OWSKmu3+9p/NaIIquFVjkusTQRG0csne7domOslw7KE=;
 b=UKUEb6Z+B75fgFOKJM9IFLyMNpo0Tnzn3AYGZ8tie+3ae1scHhew4sL40HxK0c6Mtk
 oRZD01CFuJsS3oqdS/SDkrRCv3Fk/Pmg5axZAzXGQNOm5tcBbfr5Qc+A0+7Gf35zoK8L
 kHeKrImjYTeqJaIG6gU6QvrzZTOg9K3qeMO1ns06KfBvYQpogPlHDLALvNeTnv/VmPhu
 tP1Ri+5ImBAxcNYT5uAkg5NPgsJICbdVgzrG2d0PT3Vo4c44WHCcd+pt/G6vocdiePnu
 Aiy9/7/KaSurW3GkYvpP/iHfMlSeo33xk8ltwUGv8Cj7zHwlLP7F6+kMhV/M5x2Dy7M4
 G5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OWSKmu3+9p/NaIIquFVjkusTQRG0csne7domOslw7KE=;
 b=TSzUwuY8iLMyjVho17xOFMwXfxRjZVIyEWLEUxgGlVRQASM6lBzKVouvSV2AOdXKRY
 AfdcMyKBzAftcEYdOD68+nXheZi5upnMNFBNpOFb9EntlP87MNxEvlcbl40mCLlKAIS2
 A4Jwohdj6dqpTvGn1wm/EvR1Hv6/2TS2lRz8exyowR/aER7HTXiRtkGya699CJXL+BuL
 wR6HrOrXz5rpKephYmKoedfVGbTxiiInUvG3H4ZmopcmP9OH+C5ZcNIDR3E8zWdYQzzm
 0wVwT/4NfnqGYtv6cr9M1tuWzNlXPmIV+88lIwvFLLCAPUVI+ZZoc/bX1PKOFCN1XEv6
 xjrQ==
X-Gm-Message-State: APjAAAWMMBs25+ml2c1XKfju7fps+aXgV89V86SC5kmtQ49QOzRCowVY
 b4xaBff9eqkrN56LUskxtflazIEFMBZwdFD9PFE=
X-Google-Smtp-Source: APXvYqyJwQhSxD+jopqRqHyzmS8vGsfEYsLUyK6ZfDTt5N9+gz3w4BVVrWF8qxE3baUt/HP8L1DijTQEFbHowV3SrvU=
X-Received: by 2002:a05:600c:2c53:: with SMTP id
 r19mr5964865wmg.39.1581013728937; 
 Thu, 06 Feb 2020 10:28:48 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR12MB33724602207E1D3B7839A4EF81020@DM6PR12MB3372.namprd12.prod.outlook.com>
 <CADnq5_Pb904Z_=4zcVkQHBpBghV-zevorL9q_zwHgL5JP57ypw@mail.gmail.com>
 <DM6PR12MB3372AC10F1C908918A672AAC811D0@DM6PR12MB3372.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3372AC10F1C908918A672AAC811D0@DM6PR12MB3372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Feb 2020 13:28:37 -0500
Message-ID: <CADnq5_Oi_buf_1HCp7PLOKq--EML7aN+-c7JieUjpdeX7mTtZg@mail.gmail.com>
Subject: Re: [Dali] Raven 2 detection Patch
To: "Tawfik, Aly" <Aly.Tawfik@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Michael" <Michael.Chiu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 6, 2020 at 1:00 PM Tawfik, Aly <Aly.Tawfik@amd.com> wrote:
>
>
> ***Reattached patch with corrections***
>
> From b828a2b3df3057461dfceb4d1394fe858ced9d03 Mon Sep 17 00:00:00 2001
> From: Ali-Tawfik <altawfik@amd.com>
> Date: Thu, 6 Feb 2020 12:53:02 -0500
> Subject: [PATCH] drm/amdgpu: [DALI] Dali Variant Detection
>
> Problem Description:
>
> Currently we are checking internal fused rev id with pci rev id. However, fused internal rev id is the same on all raven2 parts (in which Dali was based on too), thus Dali detection fails
>
> Fix:
>
> To detect this chip we need to use pci rev id but it is not defined in the
> scope of DC. To workaround this issue alter the fused
> rev id using pcie id for all dali chips before DC init,
> then use the internal fused id for chip detection in DC.
>
> Signed-off-by: Ali-Tawfik <altawfik@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Once it's reviewed, feel free to commit it.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c                | 9 ++++++++-
>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 4 ++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 317803f6a561..f85c27fbe64c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1094,8 +1094,15 @@ static int soc15_common_early_init(void *handle)
>                 break;
>         case CHIP_RAVEN:
>                 adev->asic_funcs = &soc15_asic_funcs;
> -               if (adev->rev_id >= 0x8)
> +               if (adev->rev_id >= 0x8) {
> +                       if ((adev->pdev->device == 0x15d8) &&
> +                                ((adev->pdev->revision == 0xCF) ||
> +                                (adev->pdev->revision == 0xE3)||
> +                                (adev->pdev->revision == 0xE4))) {
> +                               adev->rev_id = 0x10;
> +                       }
>                         adev->external_rev_id = adev->rev_id + 0x79;
> +               }
>                 else if (adev->pdev->device == 0x15d8)
>                         adev->external_rev_id = adev->rev_id + 0x41;
>                 else if (adev->rev_id == 1)
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index a2903985b9e8..0329f26bfacd 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -143,6 +143,7 @@
>  #define RAVEN2_15D8_REV_EB 0xEB
>  #define RAVEN1_F0 0xF0
>  #define RAVEN_UNKNOWN 0xFF
> +#define RAVEN2_15D8_B0_LW 0x89
>  #ifndef ASICREV_IS_RAVEN
>  #define ASICREV_IS_RAVEN(eChipRev) ((eChipRev >= RAVEN_A0) && eChipRev < RAVEN_UNKNOWN)
>  #endif
> @@ -152,8 +153,7 @@
>  #define ASICREV_IS_RAVEN2(eChipRev) ((eChipRev >= RAVEN2_A0) && (eChipRev < RAVEN1_F0))
>  #endif
>  #define ASICREV_IS_RV1_F0(eChipRev) ((eChipRev >= RAVEN1_F0) && (eChipRev < RAVEN_UNKNOWN))
> -#define ASICREV_IS_DALI(eChipRev) ((eChipRev == RAVEN2_15D8_REV_E3) \
> -               || (eChipRev == RAVEN2_15D8_REV_E4))
> +#define ASICREV_IS_DALI(eChipRev) ((eChipRev == RAVEN2_15D8_B0_LW))
>  #define ASICREV_IS_POLLOCK(eChipRev) (eChipRev == RAVEN2_15D8_REV_94 \
>                 || eChipRev == RAVEN2_15D8_REV_95 \
>                         || eChipRev == RAVEN2_15D8_REV_E9 \
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
