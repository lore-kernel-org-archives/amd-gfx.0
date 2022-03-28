Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C6BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 17:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF3F10E6DF;
	Mon, 28 Mar 2022 17:01:49 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743B910E6DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 17:01:48 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 o20-20020a9d7194000000b005cb20cf4f1bso11085739otj.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GSK0bF8iTD0xsW1DUQCyRsTpl5MgAu2/JFlo5tfFzYY=;
 b=RWBPYWsMZWfoSferINPDkVO0Wykub4ls0Jdirr7qbdmRK2oDd1om7Y0isBMPqPIBA6
 fb0030WHG7sqMorWItjgku6BHp1iur/RVepOzXHqFECBlsC1HdpvKgI3d31aGcJbwqRp
 oTTdJlm8mXF9dtqfjTm0Zh03Yk9G6zVZkxwQT3djbtvChTV0aaJmoDAH+pvC+FC/l8mN
 kVo06HdttTrm6B0NLh0mmeHlXU+WcBqH+8wWrAYKUYAI4bwTo0lLxGTC4urX/SMGvAkV
 3NZjy2q9bK4ZM6ZsQCH9Jlu7SYzaK4YpBqArYHSPhB52xjCZOtNtHSOun52mHK8ijUHI
 p90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GSK0bF8iTD0xsW1DUQCyRsTpl5MgAu2/JFlo5tfFzYY=;
 b=KXTIIfAGypEnRnxof6Xe4wWOKEMPVdEUrttk7iVnGJ9c77EdLk+wVhem+tPYOI4e85
 cbnu33n9ODcfWqm2QtAR9I7Lm8/JreYLJZOQ8GT6JJC6hC43VMWpnGFyCEB5upPLYdrD
 ef4kYJJfVGeWX1Eq7QSoq2LRpROPXXllujbnX7lbMz1V3viCFRP6bJYwckLvogU8DqvI
 lNOVfprJh7k3YNneO8wiarXagahFLGu6+604U+18puhCEU3muczPns0x58CLRk1gx8dL
 wg2WjBRJGn7PWyC8YxSsFn4I+5ve8ntxFj6tY1QLvbuZR9AcW5UDBJ/U/dE/Ro3LAeJ6
 RC6A==
X-Gm-Message-State: AOAM53114SPmNMiyYrN1PSKg2BVBHq0yUkvcIctXj6LSYUMqqtepQJeQ
 GMum4CEdTOcIEVoY3bATsH84EZ4jHy2APgjgr+8yWsbt4w0=
X-Google-Smtp-Source: ABdhPJyQzRrizfQGUS5X9wdSwX5Tqbfq8PrrjkFD6QpVd9swgRAH94qQESVN2qTggQBZXmgDki/OQhwnxosgoYk0r1c=
X-Received: by 2002:a9d:4702:0:b0:5cd:481a:148a with SMTP id
 a2-20020a9d4702000000b005cd481a148amr1244187otf.200.1648486907645; Mon, 28
 Mar 2022 10:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220328165340.1262277-1-kent.russell@amd.com>
 <20220328165340.1262277-2-kent.russell@amd.com>
In-Reply-To: <20220328165340.1262277-2-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Mar 2022 13:01:36 -0400
Message-ID: <CADnq5_M0XAicY3pp4m9_SgO8vN301tf=zcq11aeLD_ZAXF30fg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 28, 2022 at 12:53 PM Kent Russell <kent.russell@amd.com> wrote:
>
> This is being added to SMU Metrics, so add the required tie-ins in the
> kernel. Also create the corresponding unique_id sysfs file.
>
> v2: Add FW version check, remove SMU mutex
> v3: Fix style warning
> v4: Add IP_VERSION check to FW version check
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
>  .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 10 ++++-
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 37 +++++++++++++++++++
>  3 files changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 4151db2678fb..4a9aabc16fbc 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1993,6 +1993,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>                 case IP_VERSION(9, 4, 0):
>                 case IP_VERSION(9, 4, 1):
>                 case IP_VERSION(9, 4, 2):
> +               case IP_VERSION(10, 3, 0):
>                         *states = ATTR_STATE_SUPPORTED;
>                         break;
>                 default:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> index 3e4a314ef925..037f38b0fa15 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> @@ -1419,8 +1419,11 @@ typedef struct {
>    uint8_t  PcieRate               ;
>    uint8_t  PcieWidth              ;
>    uint16_t AverageGfxclkFrequencyTarget;
> -  uint16_t Padding16_2;
>
> +  uint32_t PublicSerialNumLower32;
> +  uint32_t PublicSerialNumUpper32;
> +
> +  uint16_t Padding16_2;
>  } SmuMetrics_t;
>
>  typedef struct {
> @@ -1476,8 +1479,11 @@ typedef struct {
>    uint8_t  PcieRate               ;
>    uint8_t  PcieWidth              ;
>    uint16_t AverageGfxclkFrequencyTarget;
> -  uint16_t Padding16_2;
>
> +  uint32_t PublicSerialNumLower32;
> +  uint32_t PublicSerialNumUpper32;
> +
> +  uint16_t Padding16_2;
>  } SmuMetrics_V2_t;
>
>  typedef struct {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 38f04836c82f..9f0c353f9b42 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -481,6 +481,42 @@ static int sienna_cichlid_setup_pptable(struct smu_context *smu)
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
> +       bool use_metrics_v2;
> +       int ret;
> +
> +       /* Only supported as of version 0.58.83.0 and only on GC 10.3.0 */
> +       if (smu->smc_fw_version < 0x3A5300 ||
> +           smu->adev->ip_versions[GC_HWIP][0] != IP_VERSION(10, 3, 0))

Maybe replace the GC check with MP1 check for consistency?  E.g.,
smu->adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7)

Alex

> +               return;
> +
> +       ret = smu_cmn_get_metrics_table(smu, NULL, false);
> +       if (ret)
> +               goto out_unlock;
> +
> +       use_metrics_v2 = ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
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
> @@ -4182,6 +4218,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
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
