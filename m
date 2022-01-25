Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAADC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 15:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4919310E294;
	Tue, 25 Jan 2022 15:58:08 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA7010E294
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 15:58:07 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id y23so13512799oia.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 07:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7di1w576uHnbbbpoM68XAv5EaJQgyH2OozJZqQg6Idw=;
 b=gs3vPgzsboNellDheyHmM/60fZy5CQjumdLhvLU9+cdHaOln242cqq0YeQvvQEcwcI
 sR+x2iHnPPfdGjwXyDIFcFXNkrqbr84n4vWcpg9xGTALBJQceIdcb+KxUkk6hDtwfOp1
 /XRIkEfKIEQhDAMixXtEtBeFvkmnAcYF7I5SHUXUWw18+/iMIvsZ5tgcx0g7TUtFjJhw
 XdMW2XlJ5XyyWQEy6utBlUfULGX+Z+ZXH5atJVkqx8vWmqpjPaXcidu86m74rhI94eDo
 Xa3fC3SIKL2YxXRxob9gYRm39yyfKWKlzE2+uOnhxAxw43FBrXwbx2dLqNzm6ALxotsT
 AHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7di1w576uHnbbbpoM68XAv5EaJQgyH2OozJZqQg6Idw=;
 b=XMgUxLATtLl4oN9nHZJ0iWSsyie/TN2/mYIeoWCWbMUEu0UdlAUBkKCoj0z0uJkM0s
 rxV/O5T8vzE8wZEadzbYgkkWHz5cHieFZ77XgnPM2qZMs/alcCmnURHo/ABorf5UpHHh
 5T0Ug6wGyImYSUFXyGJHDIJoKlWOYeYQU0GkvdU1ArVewaNYXTJwbXSaZlAbuyjGkVY/
 t20vhI8Cjaf3zFgLsGiObftSbCmK1NcmNye+5MKwY+ngzFlmY/SaCQjGdsTKkSZjqbp3
 gIRuD4lRyurhy4lL4okRZ1d7g6xCTpWNo6YewpgetQRIyTh/urZfh3FdcURTV+ZpdWnC
 uxEA==
X-Gm-Message-State: AOAM530KrHm/iXMs8N63BYmKU+0AA9jDyheYJePYliLTdH3q8If5X0Qu
 pYXeZ0Zw8ONq0LdP3lfpxXJSiUXDdRxY0ou0406LsOk/
X-Google-Smtp-Source: ABdhPJzqKUUg3ktxvbEQZE77CMo1UJIrC4Rki/HbzSIjh9X44MbOe3jZtdr/GVwmNMXeNGgDz7Nt4ayyGhIvXGCCbT8=
X-Received: by 2002:a05:6808:2189:: with SMTP id
 be9mr1059413oib.93.1643126286513; 
 Tue, 25 Jan 2022 07:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20220125090013.102080-1-evan.quan@amd.com>
 <20220125090013.102080-2-evan.quan@amd.com>
In-Reply-To: <20220125090013.102080-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jan 2022 10:57:55 -0500
Message-ID: <CADnq5_O42g3RQ-44ds1v7gF0_5CY-VoC9JQ0myAaDUPJiHa=YA@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] drm/amd/pm: unify the interface for retrieving
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

On Tue, Jan 25, 2022 at 4:00 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Instead of having two which do the same thing.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I6302c9b5abdb999c4b7c83a0d1852181208b1c1f
> ---
>  .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  2 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  6 +-
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  6 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 93 ++++++++-----------
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  4 -
>  5 files changed, 44 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 2f57333e6071..cc080a0075ee 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -357,7 +357,7 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
>         if (adev->in_suspend)
>                 return false;
>
> -       ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
>         if (ret)
>                 return false;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 721027917f81..b4a3c9b8b54e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -507,7 +507,7 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
>         if (adev->in_suspend)
>                 return false;
>
> -       ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
>
>         if (ret)
>                 return false;
> @@ -1965,7 +1965,7 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
>         if (!en)
>                 return ret;
>
> -       ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
>         if (ret)
>                 return ret;
>
> @@ -2182,7 +2182,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>         .dpm_set_jpeg_enable = vangogh_dpm_set_jpeg_enable,
>         .is_dpm_running = vangogh_is_dpm_running,
>         .read_sensor = vangogh_read_sensor,
> -       .get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
> +       .get_enabled_mask = smu_cmn_get_enabled_mask,
>         .get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>         .set_watermarks_table = vangogh_set_watermarks_table,
>         .set_driver_table_location = smu_v11_0_set_driver_table_location,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index bd24a2632214..f425827e2361 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -209,7 +209,7 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
>         if (!en)
>                 return ret;
>
> -       ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
>         if (ret)
>                 return ret;
>
> @@ -258,7 +258,7 @@ static bool yellow_carp_is_dpm_running(struct smu_context *smu)
>         uint32_t feature_mask[2];
>         uint64_t feature_enabled;
>
> -       ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
> +       ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
>
>         if (ret)
>                 return false;
> @@ -1174,7 +1174,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
>         .is_dpm_running = yellow_carp_is_dpm_running,
>         .set_watermarks_table = yellow_carp_set_watermarks_table,
>         .get_gpu_metrics = yellow_carp_get_gpu_metrics,
> -       .get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
> +       .get_enabled_mask = smu_cmn_get_enabled_mask,
>         .get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>         .set_driver_table_location = smu_v13_0_set_driver_table_location,
>         .gfx_off_control = smu_v13_0_gfx_off_control,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index c3c679bf9d9f..50164ebed1cd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -545,67 +545,57 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
>                              uint32_t *feature_mask,
>                              uint32_t num)
>  {
> -       uint32_t feature_mask_high = 0, feature_mask_low = 0;
>         struct smu_feature *feature = &smu->smu_feature;
> +       struct amdgpu_device *adev = smu->adev;
> +       uint32_t *feature_mask_high;
> +       uint32_t *feature_mask_low;
>         int ret = 0;
>
>         if (!feature_mask || num < 2)
>                 return -EINVAL;
>
> -       if (bitmap_empty(feature->enabled, feature->feature_num)) {
> -               ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh, &feature_mask_high);
> -               if (ret)
> -                       return ret;
> -
> -               ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow, &feature_mask_low);
> -               if (ret)
> -                       return ret;
> -
> -               feature_mask[0] = feature_mask_low;
> -               feature_mask[1] = feature_mask_high;
> -       } else {
> -               bitmap_copy((unsigned long *)feature_mask, feature->enabled,
> +       if (!bitmap_empty(feature->enabled, feature->feature_num)) {
> +               bitmap_copy((unsigned long *)feature_mask,
> +                            feature->enabled,
>                              feature->feature_num);
> +               return 0;
>         }
>
> -       return ret;
> -}
> -
> -int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
> -                                       uint32_t *feature_mask,
> -                                       uint32_t num)
> -{
> -       uint32_t feature_mask_en_low = 0;
> -       uint32_t feature_mask_en_high = 0;
> -       struct smu_feature *feature = &smu->smu_feature;
> -       int ret = 0;
> -
> -       if (!feature_mask || num < 2)
> -               return -EINVAL;
> -
> -       if (bitmap_empty(feature->enabled, feature->feature_num)) {
> -               ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetEnabledSmuFeatures, 0,
> -                                                                                &feature_mask_en_low);
> +       feature_mask_low = &feature_mask[0];
> +       feature_mask_high = &feature_mask[1];
>
> +       switch (adev->asic_type) {
> +       case CHIP_CYAN_SKILLFISH:
> +       case CHIP_VANGOGH:
> +       case CHIP_YELLOW_CARP:

Can you convert this to an SMU IP version check rather than an asic type check?

> +               ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                     SMU_MSG_GetEnabledSmuFeatures,
> +                                                     0,
> +                                                     feature_mask_low);
>                 if (ret)
>                         return ret;
>
> -               ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetEnabledSmuFeatures, 1,
> -                                                                                &feature_mask_en_high);
> -
> +               ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                     SMU_MSG_GetEnabledSmuFeatures,
> +                                                     1,
> +                                                     feature_mask_high);
> +               break;
> +       case CHIP_RENOIR:
> +       /* other dGPU ASICs */
> +       default:
> +               ret = smu_cmn_send_smc_msg(smu,
> +                                          SMU_MSG_GetEnabledSmuFeaturesHigh,
> +                                          feature_mask_high);
>                 if (ret)
>                         return ret;
>
> -               feature_mask[0] = feature_mask_en_low;
> -               feature_mask[1] = feature_mask_en_high;
> -
> -       } else {
> -               bitmap_copy((unsigned long *)feature_mask, feature->enabled,
> -                                feature->feature_num);
> +               ret = smu_cmn_send_smc_msg(smu,
> +                                          SMU_MSG_GetEnabledSmuFeaturesLow,
> +                                          feature_mask_low);
> +               break;
>         }
>
>         return ret;
> -
>  }
>
>  uint64_t smu_cmn_get_indep_throttler_status(
> @@ -710,20 +700,11 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
>         size_t size = 0;
>         int ret = 0, i;
>
> -       if (!smu->is_apu ||
> -           (smu->adev->asic_type == CHIP_RENOIR)) {
> -               ret = smu_cmn_get_enabled_mask(smu,
> -                                               feature_mask,
> -                                               2);
> -               if (ret)
> -                       return 0;
> -       } else {
> -               ret = smu_cmn_get_enabled_32_bits_mask(smu,
> -                                       feature_mask,
> -                                       2);
> -               if (ret)
> -                       return 0;
> -       }
> +       ret = smu_cmn_get_enabled_mask(smu,
> +                                      feature_mask,
> +                                      2);
> +       if (ret)
> +               return 0;
>
>         size =  sysfs_emit_at(buf, size, "features high: 0x%08x low: 0x%08x\n",
>                         feature_mask[1], feature_mask[0]);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index f0b4fb2a0960..4e34c18c6063 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -61,10 +61,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
>                              uint32_t *feature_mask,
>                              uint32_t num);
>
> -int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
> -                                       uint32_t *feature_mask,
> -                                       uint32_t num);
> -
>  uint64_t smu_cmn_get_indep_throttler_status(
>                                         const unsigned long dep_status,
>                                         const uint8_t *throttler_map);
> --
> 2.29.0
>
