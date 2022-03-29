Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F449C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 15:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F4510F0C4;
	Tue, 29 Mar 2022 15:28:18 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF0B10F0C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 15:28:18 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 d15-20020a9d72cf000000b005cda54187c3so12995642otk.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UIib3CB0g8G7eK1r0/uK8MVzhjwx8+wjCghkGXZHRWM=;
 b=SPNpZqzlIImTnU+3eNFyReWCd2JSOluB5jOjkUDI94DjYsgIdDoaXcq3yZnSm0+MNF
 9x96ruvLdiGomTMw77XXmETG0iiiSQnqGAxinHqtddmEANyLSg6AcZ0YZkHOnw4xbyyn
 9sGLeWzEwDqxVgvauhuQ2iagkVHDJeBgjVgmEu7sy35/XJpkVRGVOyGTpqzZwFtGCLgq
 He+3iMYkwI8L7nzRlsUXEfmWwS4p/Vgt3vzDl3nwzAYKDzPMB8IiU2aCq59MazQ6ZXiU
 0fkSKDYFN+hLqgBjV7KvalUHR3ZppHZHv8aTZhyPlpCAjsb2JoOOuqnLc/4jVbe3ehnQ
 bBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UIib3CB0g8G7eK1r0/uK8MVzhjwx8+wjCghkGXZHRWM=;
 b=4caNnGGAgq3ZHiC+7gmRFSe7G/8n9zYFOPFbzM3j1l7exkzdRbYNHs1Cq8M4eaqaRj
 g+xcSx6py/TmXFfFzHEjgxbaRYyaWQ2jcXdUmUCrxXqPOe+zfgvK4DXAfgLcSV6pAmm7
 6GC1EGR7f9KnBLLFl5dJGnfOlJjVo6d0MwEo4v5IhimGR7P40C3jKFnLQfFM1UiE47g6
 WEcY+1HyiAD8ZIsPhoLmJejUc0Vcr3MAv5ZibixGxWQYebeXOch4g6Z9uSiJGDbAyger
 8AVWjBG24BJBKP/Hi0AczorIZ3V3wIFUbmRxJuUwlPTCOphEWZ4u3G3CoiLhT+m9UsUq
 c7ZA==
X-Gm-Message-State: AOAM5318VdHH4MM2q6VR5zCPv8FvHemHx3C2tx5V3nFZOwxP8esaLAWL
 zZBGcAFW6XvDqt3c8V+MuU+NgXzg/GqqMan2uxM=
X-Google-Smtp-Source: ABdhPJw+D8nUSHVIj36QsXEMjcZa4xvN0hVVp1LGbIg0i5QP9SsnPZDmqbV3HBYqKUCN+O4zOeUakVqWze59VQ340EI=
X-Received: by 2002:a05:6830:1552:b0:5cd:bc6e:62b1 with SMTP id
 l18-20020a056830155200b005cdbc6e62b1mr1323995otp.357.1648567697294; Tue, 29
 Mar 2022 08:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220329150951.1311452-1-kent.russell@amd.com>
 <20220329150951.1311452-4-kent.russell@amd.com>
In-Reply-To: <20220329150951.1311452-4-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Mar 2022 11:28:06 -0400
Message-ID: <CADnq5_NLZLk6+ujDs7ergPkFN0OtiYAKXFts_XixzsGG-gODTQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: Add unique_id support for sienna cichlid
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

On Tue, Mar 29, 2022 at 11:10 AM Kent Russell <kent.russell@amd.com> wrote:
>
> This is being added to SMU Metrics, so add the required tie-ins in the
> kernel. Also create the corresponding unique_id sysfs file.
>
> v2: Add FW version check, remove SMU mutex
> v3: Fix style warning
> v4: Add MP1 IP_VERSION check to FW version check
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
>  .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 13 ++++++--
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 33 +++++++++++++++++++
>  3 files changed, 45 insertions(+), 2 deletions(-)
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
> index 3e4a314ef925..5831145646e6 100644
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
> @@ -1535,6 +1541,9 @@ typedef struct {
>    uint8_t  PcieWidth;
>    uint16_t AverageGfxclkFrequencyTarget;
>
> +  uint32_t PublicSerialNumLower32;
> +  uint32_t PublicSerialNumUpper32;
> +
>  } SmuMetrics_V3_t;
>

Was this really added to all three versions of the metrics table?  If
it's a new addition, presumably it's only in v3?  Other than that, the
series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>  typedef struct {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 38f04836c82f..b2f3d80e5945 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -715,6 +715,16 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>                 *value = use_metrics_v3 ? metrics_v3->CurrFanSpeed :
>                         use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrFanSpeed;
>                 break;
> +       case METRICS_UNIQUE_ID_UPPER32:
> +               *value = use_metrics_v3 ? metrics_v3->PublicSerialNumUpper32 :
> +                       use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
> +                       metrics->PublicSerialNumUpper32;
> +               break;
> +       case METRICS_UNIQUE_ID_LOWER32:
> +               *value = use_metrics_v3 ? metrics_v3->PublicSerialNumLower32 :
> +                       use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
> +                       metrics->PublicSerialNumLower32;
> +               break;
>         default:
>                 *value = UINT_MAX;
>                 break;
> @@ -1773,6 +1783,28 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
>         return ret;
>  }
>
> +static void sienna_cichlid_get_unique_id(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       uint32_t upper32 = 0, lower32 = 0;
> +
> +       /* Only supported as of version 0.58.83.0 and only on Sienna Cichlid */
> +       if (smu->smc_fw_version < 0x3A5300 ||
> +           smu->adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7))
> +               return;
> +
> +       if (sienna_cichlid_get_smu_metrics_data(smu, METRICS_UNIQUE_ID_UPPER32, &upper32))
> +               goto out;
> +       if (sienna_cichlid_get_smu_metrics_data(smu, METRICS_UNIQUE_ID_LOWER32, &lower32))
> +               goto out;
> +
> +out:
> +
> +       adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
> +       if (adev->serial[0] == '\0')
> +               sprintf(adev->serial, "%016llx", adev->unique_id);
> +}
> +
>  static int sienna_cichlid_get_uclk_dpm_states(struct smu_context *smu, uint32_t *clocks_in_khz, uint32_t *num_states)
>  {
>         uint32_t num_discrete_levels = 0;
> @@ -4182,6 +4214,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
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
