Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57074C54EAA
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 23:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E4B10E07B;
	Thu, 26 Jan 2023 23:16:04 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD16E10E07B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 23:16:02 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id p185so2857153oif.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 15:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w4yrqvAyLEzVCIkPQtga/n6ajF8s2rgTwQkRqKthp0E=;
 b=AominE0aVvEE81nfyPk/MQOVkUoU/G/eDCxLVbD4ILIilaQkGhO5ab0wtO6D2G2Z9q
 IYiTwcTiBfDDiv+UQjTOvfFE7+Pt9NvyAMcPLdUyAxXT1T3nicElMg0rpvizGatsgMze
 uk1U9t8t5fjBFQNYCJyCMa7I1QhCBg8IcFHVybjr0q1WYa1rJP6tdMhgoj88pqQTUnKW
 Ss8qff91atP6g4q69X88mRSZ3HyY/Zw+wn81FZxcxVMjhZOUOLGE3VbZq2iUfGVr20rR
 YAc3hA2M5telRe1UXUMStC7Y6JR+Ixp06xvgCOKAcW7jgaompBMPAcl1OOu/TNvXuOfb
 hKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w4yrqvAyLEzVCIkPQtga/n6ajF8s2rgTwQkRqKthp0E=;
 b=VmkBGXPOB0LIE6187zuNNcO0j2Qcmn7HUSdn+mSEQdstLCuE2ArsK3BAxfzmwMi9ED
 bMF4djRouY4cmgV1iwIZlMVS1UYhhhjAel7Tv8CEDjw+jOBrxBxST4JQkYOGAZQsB8OC
 vwKk1CxDMwGoy3flYWLfVfxi/zWZUq73Qlm5dzvD04MgBUabqF/e2fAxmPPtmEZVYhLt
 ma3Fc9Qu0onXBi418AL/dKsRv5N0f2/9L3E7dRDfxMj8XMjvim1AE/6N+UA6mKR0Cg+f
 4ObQmbNz4NMItqqwjMPueA6RrF5Htq5yrEvLa2hSttQQLctMlrU+VzSBxh4TW/EvOM3H
 EMGw==
X-Gm-Message-State: AFqh2kp7SQHxpyeSwgAjpGbnO+nvThyMqrwNSUNujHM6oqJdXPgYGNaG
 2xM/HN82PA8+qFjiECJ9x73oFFFYm2dnlOr/6Q8=
X-Google-Smtp-Source: AMrXdXtoql+hLxvU626xa5rIZmPs1/3GUm3hD8AoZtQqa0T/QlPP98Ak106LPA9/8w9KcGvH0in1uv33qda9L+zUKxg=
X-Received: by 2002:aca:2807:0:b0:35b:f5f7:3ed0 with SMTP id
 7-20020aca2807000000b0035bf5f73ed0mr2658786oix.46.1674774961765; Thu, 26 Jan
 2023 15:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20230124151318.605240-1-alexander.deucher@amd.com>
In-Reply-To: <20230124151318.605240-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Jan 2023 18:15:50 -0500
Message-ID: <CADnq5_NzyN0bDH4CWsdpE5jz-eecnc_EQW97oJCMRy7avpTeaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add force_sg_display module parameter
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ignore this patch.  It has a typo.  I have a fixed version.

Alex

On Tue, Jan 24, 2023 at 10:13 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Add a module parameter to force sg (scatter/gather) display
> on APUs.  Normally we allow displays in both VRAM and GTT,
> but this option forces displays into GTT so we can explicitly
> test more scenarios with GTT.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 12 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 ++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 872450a3a164..73d0a0807138 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -244,6 +244,8 @@ extern int amdgpu_num_kcq;
>  #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
>  extern int amdgpu_vcnfw_log;
>
> +extern int amdgpu_force_sg_display;
> +
>  #define AMDGPU_VM_MAX_NUM_CTX                  4096
>  #define AMDGPU_SG_THRESHOLD                    (256*1024*1024)
>  #define AMDGPU_DEFAULT_GTT_SIZE_MB             3072ULL /* 3GB by default */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index a75dba2caeca..bc0eaf2330f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -942,6 +942,18 @@ MODULE_PARM_DESC(smu_pptable_id,
>         "specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
>  module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
>
> +/**
> + * DOC: force_sg_display (int)
> + * Force display buffers into GTT (scatter/gather) memory for APUs.
> + * This is used to force GTT only for displays rather than displaying from
> + * either VRAM (carve out) or GTT.
> + *
> + * Defaults to 0, or disabled.
> + */
> +int amdgpu_force_sg_display;
> +MODULE_PARM_DESC(force_sg_display, "Force S/G display (0 = off (default), 1 = force display to use GTT) ");
> +module_param_named(force_sg_display, amdgpu_force_sg_display, int, 0444);
> +
>  /* These devices are not supported by amdgpu.
>   * They are supported by the mach64, r128, radeon drivers
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 2d237f3d3a2e..78dc5d63a6dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1515,6 +1515,10 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>                 if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
>                         domain = AMDGPU_GEM_DOMAIN_GTT;
>         }
> +       if (amdgpu_force_sg_display &&
> +           (adev->asic_type >= CHIP_CARRIZO) &&
> +           (adev->flags & AMD_IS_APU))
> +               domain = AMDGPU_GEM_DOMAIN_GTT;
>         return domain;
>  }
>
> --
> 2.39.0
>
