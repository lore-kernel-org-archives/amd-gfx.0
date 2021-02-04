Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04E4C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 03:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2E464DD9
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 03:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2E464DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD99F6EC6E;
	Thu,  4 Feb 2021 03:51:17 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C297A6EC6E
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 03:51:16 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id k25so21204otb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Feb 2021 19:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v2jieLoNVzcOdy1z4U+atOlq+kl6GcXlHO65NHE3Oqo=;
 b=KyPfLHysK00xeJg6HUhCB1aKg3tiSbHycpfpNP/MNNIBTeg1vI73Pvc8onBkcJS3z+
 x/rzjQ+iqUm1qS9VJQbDBc3F/A6VNT1pWfonYta3Roc5ke08T9iUivEvYkEffafWqg4X
 HAd0uPW8j6t+2TCPgqFvlGjEUd3dYZbTg7z3PRAdScOsKcbdcHf9377adX0uTBHerFck
 Q20Zv8jn4sW5zGyKi5ezpU3+0PwcLJi9sbX08gIy6klMH5Kdix343AFDGd17r/n+0oYJ
 ygdrFBvgL+JGYnmZo7CXSBUdXux2BXry42cWiADFTOPbUC9qoHiiV5c+JHBOdy5sZmUu
 Fp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v2jieLoNVzcOdy1z4U+atOlq+kl6GcXlHO65NHE3Oqo=;
 b=h2D/FF3iSdPpps2xPTYK7VNTS9qgpDJjOMujDhm6LCTOhmIcdGufffZc2tWC69Vkg9
 N7W5f7/LOrOJvdWgWesvVoyzh0KDME7wbHe2QYMjuv2YdcvSFdhaqe91wFvr0OBwWmom
 7Mw3/WDkY4j0wZil/2yD+5wW5Jq+iujtbjH38a7VIcMGRSsRFygFCLVTozWddNvTKur7
 LlR1kllLjFgOIdTh0JBgry9eKf0N6QINi3w2dybd68w41aWObc3a7MBvJlC7RPoS/3er
 UOoTcrP1VmMrBADzSCfd6viey1O5KmEkeWqPuRPRBjZhwdZzCMEoUKloyd/hpI35Fbkg
 BCtQ==
X-Gm-Message-State: AOAM532PjCULUFanStAk9/uotNUeBEsrM9oO6PKwoYDw+7+j/2ui8UBu
 XgKhMu88yqOdOmSirYSrDM0o2Zvm0Y6/yv5+fHo=
X-Google-Smtp-Source: ABdhPJzDkKRszrqoI6X3RHVLRkFDefVFcSypCl0RrsEWUnYhApA4hV4ZUR8+p9Q/PMAtLGSMrAIppK6nFqqapvW+UfU=
X-Received: by 2002:a9d:784a:: with SMTP id c10mr4543356otm.132.1612410676103; 
 Wed, 03 Feb 2021 19:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20210204033242.3205-1-kenneth.feng@amd.com>
In-Reply-To: <20210204033242.3205-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Feb 2021 22:51:05 -0500
Message-ID: <CADnq5_OqdZGn=T=1NmsHd=FV_qea8TrnB3b012FwT604oz3c_g@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/pm: enable DCS
To: Kenneth Feng <kenneth.feng@amd.com>
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

On Wed, Feb 3, 2021 at 10:32 PM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> Enable DCS
>
> V1: Enable Async DCS.
> V2: Add the ppfeaturemask bit to enable from the modprobe parameter.
> V3:
> 1. add the flag to skip APU support.
> 2. remove the hunk for workload selection since
> it doesn't impact the function.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                 | 8 ++++++--
>  drivers/gpu/drm/amd/include/amd_shared.h                | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 5 +++++
>  3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2fd3a80bb034..ca3dce6d463e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -131,8 +131,12 @@ uint amdgpu_pg_mask = 0xffffffff;
>  uint amdgpu_sdma_phase_quantum = 32;
>  char *amdgpu_disable_cu = NULL;
>  char *amdgpu_virtual_display = NULL;
> -/* OverDrive(bit 14) disabled by default*/
> -uint amdgpu_pp_feature_mask = 0xffffbfff;
> +
> +/*
> + * OverDrive(bit 14) disabled by default
> + * GFX DCS(bit 19) disabled by default
> + */
> +uint amdgpu_pp_feature_mask = 0xfff7bfff;
>  uint amdgpu_force_long_training;
>  int amdgpu_job_hang_limit;
>  int amdgpu_lbpw = -1;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 9676016a37ce..43ed6291b2b8 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -213,6 +213,7 @@ enum PP_FEATURE_MASK {
>         PP_ACG_MASK = 0x10000,
>         PP_STUTTER_MODE = 0x20000,
>         PP_AVFS_MASK = 0x40000,
> +       PP_GFX_DCS_MASK = 0x80000,
>  };
>
>  enum DC_FEATURE_MASK {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index cf59f2218b7e..fd090d057d26 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -261,6 +261,11 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
>         }
>
> +       if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) &&
> +           (adev->asic_type > CHIP_SIENNA_CICHLID) &&
> +           !(adev->flags & AMD_IS_APU))
> +               *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
> +
>         if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
>                                         | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
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
