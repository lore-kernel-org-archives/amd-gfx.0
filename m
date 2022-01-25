Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD81C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 16:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1AB10E3BE;
	Tue, 25 Jan 2022 16:00:07 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C62110E3AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 16:00:05 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id m9so17373939oia.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 08:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ufp4iyZ9iEArSsbsMTtT73xqNbVILw4VlYhDw3aehmA=;
 b=pLi3f1+62nmdPt1m4jTOKkJFWRQmXRdwh3HNH+tzgkZ4YCZ4kIRRfF1dNAhbfb//Wh
 iSuM5fxpTh9ND3VsEXSagm11wjeRNveUSnmNoqzMkbnka51a5xALKHhx/+rhWv2Q2IXE
 Lc7qUAQCfLkg8J2eqZhX9PxZGV3Z6Zj4CtvXQrMAvf9Ct1Fd6rrLBbw6r/wyWiscF1bH
 Um+JmIf/yGULNvgv3PR4b13jCsy7ZVawMnKdT6pK2W1lzrRi404LFUdvzJprTWxt7p1n
 D5kdn5Iv2kHdO/5A/LfDwg9tE3f2kk1LRrXgQ4+L6+qdIttv5B5tCMppK+vKwr25l71f
 JQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ufp4iyZ9iEArSsbsMTtT73xqNbVILw4VlYhDw3aehmA=;
 b=kf2HeXoyp+G1+dcLBFwb9vLNCLRKKG9OJP59Js6XVHBbQiAGpjtigsZp+frftQRpsA
 UShnWqF3hO1nmE9yP95HtkevpJV5Do/1zc13O7hu/ztiWIp/5BPLBAL6cpY7gtlY7lon
 Zw9FeZXMpaImqjAa91cmNRYJH7PqEmBENdW/EaAPn5xceTgjFfy7ce4PKYVNUkqnN4GR
 2Coi9eeJ64/FI+k97ujk/gFdpvwnJ2dyC+whrrsTYU5wNRuBVilR3HIcKSzWwP67qhOy
 g5YeG4yKFWuyAJNfUqGFelUpbSXP3+TlRo31yipaoSAwMe3m8iIXgYWZI2gMM6qCR3Iv
 SV1A==
X-Gm-Message-State: AOAM5311WB0znRGg/6x+tFv5ZTLK1/TqDypkADozAq1ml+uJjmghoRlA
 70SLg0r2NU119qjFstRpHLSSQ7pUssqLMt166u0=
X-Google-Smtp-Source: ABdhPJx5biP+eoGRM9VM9G47BlYbXeSMLib+rl8wBqgFgqI1b4iMjfBGVWf7/bkvkZEEE/UqkN+dJXLQU7hw30cQuq0=
X-Received: by 2002:a05:6808:2011:: with SMTP id
 q17mr1018393oiw.199.1643126404166; 
 Tue, 25 Jan 2022 08:00:04 -0800 (PST)
MIME-Version: 1.0
References: <20220125090013.102080-1-evan.quan@amd.com>
 <20220125090013.102080-3-evan.quan@amd.com>
In-Reply-To: <20220125090013.102080-3-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jan 2022 10:59:53 -0500
Message-ID: <CADnq5_OyN+1_C-c1UyuW1w1=1gTTBNBJZq4pcp_O2OHJVQXTbg@mail.gmail.com>
Subject: Re: [PATCH V2 3/7] drm/amd/pm: update the data type for retrieving
 enabled ppfeatures
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jan 25, 2022 at 4:00 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Use uint64_t instead of an array of uint32_t. This can avoid
> some non-necessary intermediate uint32_t -> uint64_t conversions.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I4e217357203a23440f058d7e25f55eaebd15c5ef
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++--
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  5 +---
>  .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  6 +---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  5 +---
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +---
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  4 +--
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 10 ++-----
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  7 ++---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  4 +--
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  9 ++----
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 29 +++++++------------
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 +-
>  14 files changed, 32 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 264eb09ccfd5..95929cede585 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2310,7 +2310,7 @@ static int smu_read_sensor(void *handle,
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
> -               ret = smu_feature_get_enabled_mask(smu, (uint32_t *)data, 2);
> +               ret = smu_feature_get_enabled_mask(smu, (uint64_t *)data);
>                 *size = 8;
>                 break;
>         case AMDGPU_PP_SENSOR_UVD_POWER:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 18f24db7d202..3fc130fbdc33 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -975,10 +975,9 @@ struct pptable_funcs {
>         /**
>          * @get_enabled_mask: Get a mask of features that are currently enabled
>          *                    on the SMU.
> -        * &feature_mask: Array representing enabled feature mask.
> -        * &num: Elements in &feature_mask.
> +        * &feature_mask: Enabled feature mask.
>          */
> -       int (*get_enabled_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
> +       int (*get_enabled_mask)(struct smu_context *smu, uint64_t *feature_mask);
>
>         /**
>          * @feature_is_enabled: Test if a feature is enabled.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 2c78d04d5611..dda36942cfb6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2022,15 +2022,12 @@ static void arcturus_dump_pptable(struct smu_context *smu)
>  static bool arcturus_is_dpm_running(struct smu_context *smu)
>  {
>         int ret = 0;
> -       uint32_t feature_mask[2];
>         uint64_t feature_enabled;
>
> -       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
>         if (ret)
>                 return false;
>
> -       feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
> -
>         return !!(feature_enabled & SMC_DPM_FEATURE);
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index cc080a0075ee..2b38a9154dd4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -350,20 +350,16 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
>         int ret = 0;
> -       uint32_t feature_mask[2];
>         uint64_t feature_enabled;
>
>         /* we need to re-init after suspend so return false */
>         if (adev->in_suspend)
>                 return false;
>
> -       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
>         if (ret)
>                 return false;
>
> -       feature_enabled = (uint64_t)feature_mask[0] |
> -                               ((uint64_t)feature_mask[1] << 32);
> -
>         /*
>          * cyan_skillfish specific, query default sclk inseted of hard code.
>          */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 84834c24a7e9..b68bce921453 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1640,15 +1640,12 @@ static int navi10_display_config_changed(struct smu_context *smu)
>  static bool navi10_is_dpm_running(struct smu_context *smu)
>  {
>         int ret = 0;
> -       uint32_t feature_mask[2];
>         uint64_t feature_enabled;
>
> -       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
>         if (ret)
>                 return false;
>
> -       feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
> -
>         return !!(feature_enabled & SMC_DPM_FEATURE);
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index dcd35c68e59b..98ea283f2a78 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1298,15 +1298,12 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
>  static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
>  {
>         int ret = 0;
> -       uint32_t feature_mask[2];
>         uint64_t feature_enabled;
>
> -       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
>         if (ret)
>                 return false;
>
> -       feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
> -
>         return !!(feature_enabled & SMC_DPM_FEATURE);
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index b58a4c2823c2..b34d3a416939 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -799,7 +799,7 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
>                                              bool en)
>  {
>         struct smu_feature *feature = &smu->smu_feature;
> -       uint32_t feature_mask[2];
> +       uint64_t feature_mask;
>         int ret = 0;
>
>         ret = smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
> @@ -811,7 +811,7 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
>         bitmap_zero(feature->supported, feature->feature_num);
>
>         if (en) {
> -               ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +               ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
>                 if (ret)
>                         return ret;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index b4a3c9b8b54e..65f30cdafc8f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -500,21 +500,17 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
>         int ret = 0;
> -       uint32_t feature_mask[2];
>         uint64_t feature_enabled;
>
>         /* we need to re-init after suspend so return false */
>         if (adev->in_suspend)
>                 return false;
>
> -       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
>
>         if (ret)
>                 return false;
>
> -       feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
> -                               ((uint64_t)feature_mask[1] << 32));
> -
>         return !!(feature_enabled & SMC_DPM_FEATURE);
>  }
>
> @@ -1952,7 +1948,7 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
>  {
>         struct amdgpu_device *adev = smu->adev;
>         struct smu_feature *feature = &smu->smu_feature;
> -       uint32_t feature_mask[2];
> +       uint64_t feature_mask;
>         int ret = 0;
>
>         if (adev->pm.fw_version >= 0x43f1700 && !en)
> @@ -1965,7 +1961,7 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
>         if (!en)
>                 return ret;
>
> -       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 8c02adbf446a..97762e997644 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1451,14 +1451,11 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
>  static bool aldebaran_is_dpm_running(struct smu_context *smu)
>  {
>         int ret;
> -       uint32_t feature_mask[2];
> -       unsigned long feature_enabled;
> +       uint64_t feature_enabled;
>
> -       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
>         if (ret)
>                 return false;
> -       feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
> -                                         ((uint64_t)feature_mask[1] << 32));
>         return !!(feature_enabled & SMC_DPM_FEATURE);
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 1754a3720179..6b77fc4b4698 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -765,7 +765,7 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
>                                       bool en)
>  {
>         struct smu_feature *feature = &smu->smu_feature;
> -       uint32_t feature_mask[2];
> +       uint64_t feature_mask;
>         int ret = 0;
>
>         ret = smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
> @@ -777,7 +777,7 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
>         bitmap_zero(feature->supported, feature->feature_num);
>
>         if (en) {
> -               ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +               ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
>                 if (ret)
>                         return ret;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index f425827e2361..a7aabb8079ed 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -197,7 +197,7 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
>  {
>         struct smu_feature *feature = &smu->smu_feature;
>         struct amdgpu_device *adev = smu->adev;
> -       uint32_t feature_mask[2];
> +       uint64_t feature_mask;
>         int ret = 0;
>
>         if (!en && !adev->in_s0ix)
> @@ -209,7 +209,7 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
>         if (!en)
>                 return ret;
>
> -       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
>         if (ret)
>                 return ret;
>
> @@ -255,16 +255,13 @@ static int yellow_carp_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
>  static bool yellow_carp_is_dpm_running(struct smu_context *smu)
>  {
>         int ret = 0;
> -       uint32_t feature_mask[2];
>         uint64_t feature_enabled;
>
> -       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
>
>         if (ret)
>                 return false;
>
> -       feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
> -
>         return !!(feature_enabled & SMC_DPM_FEATURE);
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 50164ebed1cd..834a27590991 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -542,8 +542,7 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
>  }
>
>  int smu_cmn_get_enabled_mask(struct smu_context *smu,
> -                            uint32_t *feature_mask,
> -                            uint32_t num)
> +                            uint64_t *feature_mask)
>  {
>         struct smu_feature *feature = &smu->smu_feature;
>         struct amdgpu_device *adev = smu->adev;
> @@ -551,7 +550,7 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
>         uint32_t *feature_mask_low;
>         int ret = 0;
>
> -       if (!feature_mask || num < 2)
> +       if (!feature_mask)
>                 return -EINVAL;
>
>         if (!bitmap_empty(feature->enabled, feature->feature_num)) {
> @@ -561,8 +560,8 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
>                 return 0;
>         }
>
> -       feature_mask_low = &feature_mask[0];
> -       feature_mask_high = &feature_mask[1];
> +       feature_mask_low = &((uint32_t *)feature_mask)[0];
> +       feature_mask_high = &((uint32_t *)feature_mask)[1];
>
>         switch (adev->asic_type) {
>         case CHIP_CYAN_SKILLFISH:
> @@ -693,7 +692,7 @@ static const char *smu_get_feature_name(struct smu_context *smu,
>  size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
>                                    char *buf)
>  {
> -       uint32_t feature_mask[2] = { 0 };
> +       uint64_t feature_mask;
>         int feature_index = 0;
>         uint32_t count = 0;
>         int8_t sort_feature[SMU_FEATURE_COUNT];
> @@ -701,13 +700,12 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
>         int ret = 0, i;
>
>         ret = smu_cmn_get_enabled_mask(smu,
> -                                      feature_mask,
> -                                      2);
> +                                      &feature_mask);
>         if (ret)
>                 return 0;
>
>         size =  sysfs_emit_at(buf, size, "features high: 0x%08x low: 0x%08x\n",
> -                       feature_mask[1], feature_mask[0]);
> +                       upper_32_bits(feature_mask), lower_32_bits(feature_mask));
>
>         memset(sort_feature, -1, sizeof(sort_feature));
>
> @@ -743,22 +741,17 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
>                                 uint64_t new_mask)
>  {
>         int ret = 0;
> -       uint32_t feature_mask[2] = { 0 };
> +       uint64_t feature_mask;
>         uint64_t feature_2_enabled = 0;
>         uint64_t feature_2_disabled = 0;
> -       uint64_t feature_enables = 0;
>
>         ret = smu_cmn_get_enabled_mask(smu,
> -                                      feature_mask,
> -                                      2);
> +                                      &feature_mask);
>         if (ret)
>                 return ret;
>
> -       feature_enables = ((uint64_t)feature_mask[1] << 32 |
> -                          (uint64_t)feature_mask[0]);
> -
> -       feature_2_enabled  = ~feature_enables & new_mask;
> -       feature_2_disabled = feature_enables & ~new_mask;
> +       feature_2_enabled  = ~feature_mask & new_mask;
> +       feature_2_disabled = feature_mask & ~new_mask;
>
>         if (feature_2_enabled) {
>                 ret = smu_cmn_feature_update_enable_state(smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 4e34c18c6063..bfe3430829c7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -58,8 +58,7 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
>                                 enum smu_clk_type clk_type);
>
>  int smu_cmn_get_enabled_mask(struct smu_context *smu,
> -                            uint32_t *feature_mask,
> -                            uint32_t num);
> +                            uint64_t *feature_mask);
>
>  uint64_t smu_cmn_get_indep_throttler_status(
>                                         const unsigned long dep_status,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> index 59f9cfff3d61..2f9aff89f667 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -55,7 +55,7 @@
>  #define smu_send_smc_msg(smu, msg, read_arg)                           smu_ppt_funcs(send_smc_msg, 0, smu, msg, read_arg)
>  #define smu_init_display_count(smu, count)                             smu_ppt_funcs(init_display_count, 0, smu, count)
>  #define smu_feature_set_allowed_mask(smu)                              smu_ppt_funcs(set_allowed_mask, 0, smu)
> -#define smu_feature_get_enabled_mask(smu, mask, num)                   smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
> +#define smu_feature_get_enabled_mask(smu, mask)                                smu_ppt_funcs(get_enabled_mask, 0, smu, mask)
>  #define smu_feature_is_enabled(smu, mask)                              smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
>  #define smu_disable_all_features_with_exception(smu, no_hw_disablement, mask)          smu_ppt_funcs(disable_all_features_with_exception, 0, smu, no_hw_disablement, mask)
>  #define smu_is_dpm_running(smu)                                                smu_ppt_funcs(is_dpm_running, 0 , smu)
> --
> 2.29.0
>
