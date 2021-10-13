Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA9C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5976F61152
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5976F61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85696E09C;
	Wed, 13 Oct 2021 15:34:19 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61FC6E09C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 15:34:18 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 w12-20020a056830410c00b0054e7ceecd88so4226141ott.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ddRq97pfQEd8j1Nc7oqD7mFAr3NAPWLL8Eo5VWEu9Ew=;
 b=YgLpMK45VbTpk8brxyyFyDkyo4OLsJIrKkhiprESmMDopKm3LDq9g61XL+fAOsIQCS
 XshDV+oKeoQXD+aYr0TMexXLfYezBbflX6dWE4cRmTSIDXZZiE5NkJr5KTvPPN1dginM
 gy2wjpkJmWdffq3uPumvmrJ1sAv6U1ZEa3vXSZphyxIYcD63ZlbhTxtop3GjIlSq2/Mb
 MMYHA0RLpADvV5dn0QjotJLKVNZ2igZyJYI8Na8LF/ef4t5dGM3YSO+nXNwuOsknS5uc
 MOEqAiBy8ohpT6EEXkoLbMJH6dUbjii849Rsy60DPbcixQOJ31f6VPd6zJWTXOioLVtx
 XBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ddRq97pfQEd8j1Nc7oqD7mFAr3NAPWLL8Eo5VWEu9Ew=;
 b=qlLNlOAzZdIGJA+B7hXRH9nQTLQDMRJ+NpKUcew9zvoBnCGh71M5jq9GddsWEkJZzR
 Kk+1dGKoCFW4kgcA14T9YpZ79Fo8dz5pKLijG5sriSQaTgZdGDsN8yP/yl6SjR+jkAto
 UJwq1Spng/56ZItscSZsaJI1lxFKffhXqSPfF4KKUNLx5jMqsJFX3DZyFcLVK5uAsH1F
 4q6B8lDUYsc3nclf6sszK5A3D8QwZYQVAGWGNV8lUpPsJ69Zn2ZbWYvQkGlzvw06lgLa
 cBu0xLLNGkHj44vsY49+74Tx+zG1ZHeD7BvvWDD/efcQueolb+yvsEPanJX05OcQt72k
 H+iQ==
X-Gm-Message-State: AOAM531bVA5Yq1LXPsAuoxRlyf03bqZf0ZCU2GrTNfpAL8iTHH10mHdi
 aGWWenBXnNaNS3bOsZQBBi9m4mO5k7k+CLeoB/b2g9gIRXg=
X-Google-Smtp-Source: ABdhPJwV7N5qv9grST5Z/XgVek68ORqakv1r4pmo1ykBWAxE4XR16jFM+nnSF0ZgFPIDjjt/s+uwZDH4Yn+CW/K5eaw=
X-Received: by 2002:a9d:718e:: with SMTP id o14mr6378311otj.299.1634139258199; 
 Wed, 13 Oct 2021 08:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211013150607.1580288-1-alexander.deucher@amd.com>
In-Reply-To: <20211013150607.1580288-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Oct 2021 11:34:07 -0400
Message-ID: <CADnq5_Njc6yAXX0G0S-Dwq0U+QM87AOGaX7He+gg+gJ24=oaOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/nbio2.3: use original HDP_FLUSH bits for navi1x
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 13, 2021 at 11:06 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> The extended bits were not available for use on navi1x, but
> navi2x only have 2 sdma instances so we won't conflict with

This should say navi1x.  Fixed locally.

Alex

> firmware anyway.
>
> Fixes: 468e994c41ecb3 ("drm/amdgpu/nbio2.3: don't use GPU_HDP_FLUSH bit 12")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c        | 15 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h        |  1 +
>  3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 4228c7964175..9645b95b9c42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1133,12 +1133,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>         case IP_VERSION(2, 3, 0):
>         case IP_VERSION(2, 3, 1):
>         case IP_VERSION(2, 3, 2):
> +               adev->nbio.funcs = &nbio_v2_3_funcs;
> +               adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
> +               break;
>         case IP_VERSION(3, 3, 0):
>         case IP_VERSION(3, 3, 1):
>         case IP_VERSION(3, 3, 2):
>         case IP_VERSION(3, 3, 3):
>                 adev->nbio.funcs = &nbio_v2_3_funcs;
> -               adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
> +               adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg_sc;
>                 break;
>         default:
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index 79bf6b381862..4ecd2b5808ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -314,6 +314,21 @@ static u32 nbio_v2_3_get_pcie_data_offset(struct amdgpu_device *adev)
>  }
>
>  const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg = {
> +       .ref_and_mask_cp0 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP0_MASK,
> +       .ref_and_mask_cp1 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP1_MASK,
> +       .ref_and_mask_cp2 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP2_MASK,
> +       .ref_and_mask_cp3 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP3_MASK,
> +       .ref_and_mask_cp4 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP4_MASK,
> +       .ref_and_mask_cp5 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP5_MASK,
> +       .ref_and_mask_cp6 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP6_MASK,
> +       .ref_and_mask_cp7 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP7_MASK,
> +       .ref_and_mask_cp8 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP8_MASK,
> +       .ref_and_mask_cp9 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP9_MASK,
> +       .ref_and_mask_sdma0 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__SDMA0_MASK,
> +       .ref_and_mask_sdma1 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
> +};
> +
> +const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg_sc = {
>         .ref_and_mask_cp0 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP0_MASK,
>         .ref_and_mask_cp1 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP1_MASK,
>         .ref_and_mask_cp2 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP2_MASK,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
> index a43b60acf7f6..6074dd3a1ed8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
> @@ -27,6 +27,7 @@
>  #include "soc15_common.h"
>
>  extern const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg;
> +extern const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg_sc;
>  extern const struct amdgpu_nbio_funcs nbio_v2_3_funcs;
>
>  #endif
> --
> 2.31.1
>
