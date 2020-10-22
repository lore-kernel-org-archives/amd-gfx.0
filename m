Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C7AC388F2
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 05:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A582225F
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 05:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSaEt2AG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A582225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BAF86F3AE;
	Thu, 22 Oct 2020 05:31:31 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A1E6F3CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 05:31:29 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 13so526062wmf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xo67VrnVGgIm9+lQKcl/7oEGUSbP4BvMZPidqVA2cJY=;
 b=lSaEt2AG+2B/e+ofpnjU0I84FVq67lzrCxa5/TnJ6F81XXKCpzcXdVbdrv/67o+pBM
 mUiLLEsWd9Ju545gbZQK9oZhucZV6kUhXPPBJQJ6N4M9Bf8gfDgAjYkxZe3At8r4CoZy
 icGNlCWbfp4LaBWtzZ7vwfEQPfQDYW1dapdr9k6KJNYbEdFsE28f0ii51smkL+/D+2fr
 gpMqs4zM1AjBLS4J2P+nLHwvTRZ122qX1ryPLczUSBQfUi060G7B/QgeIGvqrcjsOInY
 Qv/7oYjTb69kdqReac2TwYUOjgdCSWfpG7EWm6ej1ugsrN7nydnKAjNe8MbKiXRe5SOc
 Ei1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xo67VrnVGgIm9+lQKcl/7oEGUSbP4BvMZPidqVA2cJY=;
 b=uRRtVIdMLHSUshyQvXiXT3zIxUu3lUkQzHd84WCsLBdh/Gdn2bxn12o8zl53+q4bRD
 XIx9qJS/kMe+GEk2ThEygYowWlEpYjAjZwDhRQc7ahR5+82Y5kvB6MBBh3R+R5bFu/ZF
 1R7uOS5mpOqbVSrd6vviI9/irqCaanJ5wi9PI5+QDOD2odT+W7JPxRx7llClxvvwL6mQ
 pJ6sj86NiGj3snisNqn16LWyuZtB7Ku6BSlmmoR/7tMu/XOtY1oFnUdO2Gn4A2P+6C82
 FnYgHfyN7LeMYiIKnJzQO8CSlEp6jqpTnk/i4OqDnxRGjf/eZZXb+22Cf5cuBuSupzG9
 lTrg==
X-Gm-Message-State: AOAM5300l5i/gEpcw8ujhYTsRT2xN4iPkLNFUAzuicegXxaAJldUB4Th
 kDJPqylLdeZ5dpQ0pR2pa91Fux8KeI7JjRrn/3LmbQt0
X-Google-Smtp-Source: ABdhPJxmd73HeH5b+gMrexAYYN/RHehpubacYVKkOfgA6NOUOM2+P2FWzKWOotKIrFjhyO+L7ziYCo1UcrtMXLYLsA4=
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr762517wma.70.1603344687730; 
 Wed, 21 Oct 2020 22:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
In-Reply-To: <20201016165004.1218352-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2020 01:31:16 -0400
Message-ID: <CADnq5_M99PBm-GS55m3Q4aFY5U8xgb86zUTf4dX-1nhRoK7-fA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu/display: remove DRM_AMD_DC_GREEN_SARDINE
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series?

Alex

On Fri, Oct 16, 2020 at 12:50 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> No need for a separate config option at this point.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/Kconfig               | 8 --------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ------
>  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 2 --
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 --
>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 --
>  5 files changed, 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 93cdcd1ee9ff..cf87133f88e6 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -17,14 +17,6 @@ config DRM_AMD_DC_DCN
>         help
>           Raven, Navi and Renoir family support for display engine
>
> -config DRM_AMD_DC_GREEN_SARDINE
> -       bool "Green Sardine support"
> -       default y
> -       depends on DRM_AMD_DC_DCN
> -        help
> -            Choose this option if you want to have
> -            Green Sardine support for display engine
> -
>  config DRM_AMD_DC_DCN3_0
>          bool "DCN 3.0 family"
>          depends on DRM_AMD_DC && X86
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8a90063ac08a..2aa810d3554b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -100,10 +100,8 @@ MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
>  #define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
>  MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
>  #endif
> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>  #define FIRMWARE_GREEN_SARDINE_DMUB "amdgpu/green_sardine_dmcub.bin"
>  MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE_DMUB);
> -#endif
>  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
>  #define FIRMWARE_VANGOGH_DMUB "amdgpu/vangogh_dmcub.bin"
>  MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
> @@ -985,10 +983,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>         case CHIP_RAVEN:
>         case CHIP_RENOIR:
>                 init_data.flags.gpu_vm_support = true;
> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>                         init_data.flags.disable_dmcu = true;
> -#endif
>                 break;
>         default:
>                 break;
> @@ -1289,10 +1285,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>         case CHIP_RENOIR:
>                 dmub_asic = DMUB_ASIC_DCN21;
>                 fw_name_dmub = FIRMWARE_RENOIR_DMUB;
> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>                         fw_name_dmub = FIRMWARE_GREEN_SARDINE_DMUB;
> -#endif
>                 break;
>  #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
>         case CHIP_SIENNA_CICHLID:
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index b361dc6c3489..19d97ed6beb8 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -170,12 +170,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
>                         break;
>                 }
>
> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev)) {
>                         rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
>                         break;
>                 }
> -#endif
>                 if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev)) {
>                         rv2_clk_mgr_construct(ctx, clk_mgr, pp_smu);
>                         break;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index ab105f26b511..419c0df08602 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -126,10 +126,8 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>                         dc_version = DCN_VERSION_1_01;
>                 if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev))
>                         dc_version = DCN_VERSION_2_1;
> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev))
>                         dc_version = DCN_VERSION_2_1;
> -#endif
>                 break;
>  #endif
>
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index b4c3838322af..2bf60ac2974f 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -209,12 +209,10 @@ enum {
>  #if defined(CONFIG_DRM_AMD_DC_DCN3_02)
>  #define ASICREV_IS_DIMGREY_CAVEFISH_P(eChipRev)        ((eChipRev >= NV_DIMGREY_CAVEFISH_P_A0) && (eChipRev < NV_UNKNOWN))
>  #endif
> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>  #define GREEN_SARDINE_A0 0xA1
>  #ifndef ASICREV_IS_GREEN_SARDINE
>  #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
>  #endif
> -#endif
>  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
>  #define FAMILY_VGH 144
>  #define DEVICE_ID_VGH_163F 0x163F
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
