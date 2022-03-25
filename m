Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8A3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 13:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409E210E92A;
	Fri, 25 Mar 2022 13:26:30 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4940310EC22
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 13:26:29 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-d4164acd34so8107080fac.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B3W+l0TLNdHj9WXDx8u1b4xRgYDkHtSTl66VaiLjOHo=;
 b=NxlI/pKVlszS6r1jZhKOw1B0SvzSr5I/hvDxP1VQITbzrIwmd3UIFv9gxJAzGckqj3
 gXl+JP/q/tb5Z87XibxEZXRy+9yGWJxTw/MrF5ptOhZsJrwZ6Yf/dwZfjkf0qNfRsDEg
 IUheLR8mxLPeeCcpDWlfGPsOdDmFyn3VXEx//dVWDsSLTcSvLkHX7IHSd8iUhlHL4h/r
 bu5PWGGQSU3xRNg9hxYeSNtDFYQ8mXacrJ1ZEv47CxJM/J/SgH579BMEgD1Y4P8cxIGt
 bymMLUjIDlqaArO5TCde4Ymcw+X1SZH4Sm61K5sH47K2flqCIcCA5DX9n7ynqbh13TtF
 8yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B3W+l0TLNdHj9WXDx8u1b4xRgYDkHtSTl66VaiLjOHo=;
 b=0eqwtJROimA9J+Dxy2/Y8AkMgq7eHucPniztcLsdWfe+7qD2yxICmLOSzRGD4hqLlK
 LRlaWbo8ArV2WkpGEYZuWEcO+mj5vIIWuuK2MwKRNbEfly1Ypujo7CFOwe7QytJIMgtb
 +C6Y7HN2aAxGR5+8gzYLxy7i5yysAyw47T/d/zKxazVkAjG/bvLZcvQNC1eVh3DOv4Vn
 LTumjnnz/wVXaIA+GNFBNJ64+vqUAGGZVj0yLNZTBrXP024MPe8IUg5BwxotT19JwZi2
 SGf4D7RkbM+gijN7FutNsnVb+YO6T7f0H0NgEAI7MPKOigzcpf+RjxYiIANR8X9Y1T8h
 I2Sw==
X-Gm-Message-State: AOAM5334wd9+hizj1yihhq+ZPp7fB3oHuGcYj8p/2CNnnAPf4+F33zR0
 OQUZ+0EFm1ob34rR8DhH4TwcyKGpvCtQxZwckP+iDh9a
X-Google-Smtp-Source: ABdhPJwBRpAAitDdXHCQWmPvtluTWYWxODVjbS5iBCA9Ly9MN8a72FY52tdgJAhovWHiWaRYrN9tKK8B4vcSGLGoiHA=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr2831887oaa.200.1648214788482; Fri, 25
 Mar 2022 06:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220325130510.1122010-1-kent.russell@amd.com>
In-Reply-To: <20220325130510.1122010-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Mar 2022 09:26:17 -0400
Message-ID: <CADnq5_PQ2MXNAj8bPkJLENVN5C2SD7gCj=6HONGYD+KXVdd6-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add unique_id support for sienna cichlid
To: Kent Russell <kent.russell@amd.com>
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

On Fri, Mar 25, 2022 at 9:05 AM Kent Russell <kent.russell@amd.com> wrote:
>
> This is being added to SMU Metrics, so add the required tie-ins in the
> kernel. Also create the corresponding unique_id sysfs file.
>
> v2: Add FW version check, remove SMU mutex
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
>  .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 12 +++++--
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 35 +++++++++++++++++++
>  3 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 5cd67ddf8495..1ed13bf77cbc 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1990,7 +1990,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>                 if (asic_type != CHIP_VEGA10 &&
>                     asic_type != CHIP_VEGA20 &&
>                     asic_type != CHIP_ARCTURUS &&
> -                   asic_type != CHIP_ALDEBARAN)
> +                   asic_type != CHIP_ALDEBARAN &&
> +                   asic_type != CHIP_SIENNA_CICHLID)

As a follow on or precursor patch, we should convert this to IP
version checks.  Also, you may want to switch the logic here and mark
the attr as supported only if it matches one of the chips that
supports it.

Alex


>                         *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_features)) {
>                 if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> index 3e4a314ef925..58f977320d06 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> @@ -1419,8 +1419,12 @@ typedef struct {
>    uint8_t  PcieRate               ;
>    uint8_t  PcieWidth              ;
>    uint16_t AverageGfxclkFrequencyTarget;
> -  uint16_t Padding16_2;
>
> +  //PMFW-8711
> +  uint32_t PublicSerialNumLower32;
> +  uint32_t PublicSerialNumUpper32;
> +
> +  uint16_t Padding16_2;
>  } SmuMetrics_t;
>
>  typedef struct {
> @@ -1476,8 +1480,12 @@ typedef struct {
>    uint8_t  PcieRate               ;
>    uint8_t  PcieWidth              ;
>    uint16_t AverageGfxclkFrequencyTarget;
> -  uint16_t Padding16_2;
>
> +  //PMFW-8711
> +  uint32_t PublicSerialNumLower32;
> +  uint32_t PublicSerialNumUpper32;
> +
> +  uint16_t Padding16_2;
>  } SmuMetrics_V2_t;
>
>  typedef struct {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 38f04836c82f..39d12bc6daaa 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -481,6 +481,40 @@ static int sienna_cichlid_setup_pptable(struct smu_context *smu)
>         return sienna_cichlid_patch_pptable_quirk(smu);
>  }
>
> +static void sienna_cichlid_get_unique_id(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       struct smu_table_context *smu_table = &smu->smu_table;
> +       SmuMetrics_t *metrics =
> +               &(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
> +       SmuMetrics_V2_t *metrics_v2 =
> +               &(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V2);
> +       uint32_t upper32 = 0, lower32 = 0;
> +       int ret;
> +
> +       /* Only supported as of version 0.58.83.0 */
> +       if (smu->smc_fw_version < 0x3A5300)
> +               return;
> +
> +       ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
> +       if (ret)
> +               goto out_unlock;
> +
> +       bool use_metrics_v2 = ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
> +               (smu->smc_fw_version >= 0x3A4300)) ? true : false;
> +
> +       upper32 = use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
> +                                  metrics->PublicSerialNumUpper32;
> +       lower32 = use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
> +                                  metrics->PublicSerialNumLower32;
> +
> +out_unlock:
> +
> +       adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
> +       if (adev->serial[0] == '\0')
> +               sprintf(adev->serial, "%016llx", adev->unique_id);
> +}
> +
>  static int sienna_cichlid_tables_init(struct smu_context *smu)
>  {
>         struct smu_table_context *smu_table = &smu->smu_table;
> @@ -4182,6 +4216,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .get_ecc_info = sienna_cichlid_get_ecc_info,
>         .get_default_config_table_settings = sienna_cichlid_get_default_config_table_settings,
>         .set_config_table = sienna_cichlid_set_config_table,
> +       .get_unique_id = sienna_cichlid_get_unique_id,
>  };
>
>  void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
> --
> 2.25.1
>
