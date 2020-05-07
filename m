Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D2BC38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 20:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAE124959
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 20:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egGhEW4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAE124959
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D1A898E4;
	Thu,  7 May 2020 20:21:28 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7D689826
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 20:21:26 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id y4so7937639wrm.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2020 13:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7I5CaCx0ZEtU+pqkHWtCfgVHlDPDL/IkSaXxguDwReE=;
 b=egGhEW4wC5OMN7NTobDOTm4nrSrx/g59/6a7I8Eqdr4cyssAWAdn83jRFB5PGF4ygf
 2Tm7Sq9tO4yLZpM6fQnouUFmFVG0Y1U+j1Q6QRrEY/cfuB86Z4o0gRc8eZDo1Bvq/YDG
 p3z8oiQNWVcXM57JhjJMX+v5AO0Le5ykdmaDtuIoUomCCfeI7/X4BOXdkk0HaCvgB70f
 4J42+MqNoYarUUspkF0E8VBmxCi/Ojxi+qr5uujX3Zo8fkwzw8cjRHABAoTa2G3BvWdr
 SCICncJd0M1+4RzeaFDzHMuFmK4bOGBDOZIbVHlu1B6yFECRoOLPo6LKRJeXyCfLyF/3
 49BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7I5CaCx0ZEtU+pqkHWtCfgVHlDPDL/IkSaXxguDwReE=;
 b=ADgsPMvzvLMHRPSMEB+jqL7y6sb6FZe/1NvnqUWtmtZvrD2elLBxck0Un9MvvAjlpn
 MpqsritKaqoYOlSGvJ9z25JD/zcAHUFuE57ht/Z88GUIlvhPHMTWsRonYEbxQ1gK2YqW
 QiHGRAagslR0cqCTV/lioGGOp7krmPN/3a5dEeNWrcdqx5gHPEQRK5f+RQwS40NJpS4+
 nt4RzuWbHOkK6X4IKD8tmQamcUyeGnhae8cehhhjXeRJLmXo3+PDmWSqnGWJlggYY5mX
 UBqmRCjO59qUsjIkg8XP9eQZey7z2y1KtUDH5pMZSMDTi4Hdd811kzlwUq8lWCwS/qh/
 6IWg==
X-Gm-Message-State: AGi0PuZz3+iy/V5hh/BIDl8gZ9MdBDnnVAn16JHUDfzkds8U8FPzsQR6
 KcJMVZ12CPEhGwW7owfJ6/kjYVS1qt1qNompoQU=
X-Google-Smtp-Source: APiQypKXxra8p+rQ84NEPWDAybgrkK1Ii8zM8Ozz2Li5DbeGXe5rRs4yl+RPfsexB7B4OIfrl60HEOcCHI+qb11B/JU=
X-Received: by 2002:adf:9264:: with SMTP id 91mr17050633wrj.362.1588882885249; 
 Thu, 07 May 2020 13:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200507201449.4453-1-nirmoy.das@amd.com>
In-Reply-To: <20200507201449.4453-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 May 2020 16:21:14 -0400
Message-ID: <CADnq5_OcPP96BxCFqAo9kXYomONXgZU1t6pHXvTGDTLs7beWOA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: cleanup sysfs file handling
To: Nirmoy Das <nirmoy.das@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 7, 2020 at 4:15 PM Nirmoy Das <nirmoy.das@amd.com> wrote:
>
> Create sysfs file using attributes when possible.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  36 +++----

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
for the amdgpu_device.c changes.  For amdgpu_pm.c, I think Kevin has a
patch set out to clean this up as well that also fixes up the VF
handling.  May want to check with him on the pm changes.

Alex

>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c     | 114 +++++++--------------
>  2 files changed, 48 insertions(+), 102 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bf302c799832..cc41e8f5ad14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2918,6 +2918,14 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>         return ret;
>  }
>
> +static const struct attribute *amdgpu_dev_attributes[] = {
> +       &dev_attr_product_name.attr,
> +       &dev_attr_product_number.attr,
> +       &dev_attr_serial_number.attr,
> +       &dev_attr_pcie_replay_count.attr,
> +       NULL
> +};
> +
>  /**
>   * amdgpu_device_init - initialize the driver
>   *
> @@ -3267,27 +3275,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         queue_delayed_work(system_wq, &adev->delayed_init_work,
>                            msecs_to_jiffies(AMDGPU_RESUME_MS));
>
> -       r = device_create_file(adev->dev, &dev_attr_pcie_replay_count);
> -       if (r) {
> -               dev_err(adev->dev, "Could not create pcie_replay_count");
> -               return r;
> -       }
> -
> -       r = device_create_file(adev->dev, &dev_attr_product_name);
> +       r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
>         if (r) {
> -               dev_err(adev->dev, "Could not create product_name");
> -               return r;
> -       }
> -
> -       r = device_create_file(adev->dev, &dev_attr_product_number);
> -       if (r) {
> -               dev_err(adev->dev, "Could not create product_number");
> -               return r;
> -       }
> -
> -       r = device_create_file(adev->dev, &dev_attr_serial_number);
> -       if (r) {
> -               dev_err(adev->dev, "Could not create serial_number");
> +               dev_err(adev->dev, "Could not create amdgpu device attr\n");
>                 return r;
>         }
>
> @@ -3370,12 +3360,10 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         adev->rmmio = NULL;
>         amdgpu_device_doorbell_fini(adev);
>
> -       device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
>         if (adev->ucode_sysfs_en)
>                 amdgpu_ucode_sysfs_fini(adev);
> -       device_remove_file(adev->dev, &dev_attr_product_name);
> -       device_remove_file(adev->dev, &dev_attr_product_number);
> -       device_remove_file(adev->dev, &dev_attr_serial_number);
> +
> +       sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>         if (IS_ENABLED(CONFIG_PERF_EVENTS))
>                 amdgpu_pmu_fini(adev);
>         if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index c762deb5abc7..f375bc341acc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -3239,6 +3239,27 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
>         return 0;
>  }
>
> +static const struct attribute *amdgpu_pm_attributes[] = {
> +       &dev_attr_power_dpm_state.attr,
> +       &dev_attr_power_dpm_force_performance_level.attr,
> +       &dev_attr_pp_dpm_sclk.attr,
> +       &dev_attr_pp_dpm_mclk.attr,
> +
> +       &dev_attr_pp_sclk_od.attr,
> +       &dev_attr_pp_mclk_od.attr,
> +       &dev_attr_pp_power_profile_mode.attr,
> +       &dev_attr_gpu_busy_percent.attr,
> +       NULL
> +};
> +
> +static const struct attribute *amdgpu_pm_non_vf_attributes[] = {
> +       &dev_attr_pp_num_states.attr,
> +       &dev_attr_pp_cur_state.attr,
> +       &dev_attr_pp_force_state.attr,
> +       &dev_attr_pp_table.attr,
> +       NULL
> +};
> +
>  int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>  {
>         struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> @@ -3260,45 +3281,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>                 return ret;
>         }
>
> -       ret = device_create_file(adev->dev, &dev_attr_power_dpm_state);
> -       if (ret) {
> -               DRM_ERROR("failed to create device file for dpm state\n");
> -               return ret;
> -       }
> -       ret = device_create_file(adev->dev, &dev_attr_power_dpm_force_performance_level);
> -       if (ret) {
> -               DRM_ERROR("failed to create device file for dpm state\n");
> -               return ret;
> -       }
> -
> -       if (!amdgpu_sriov_vf(adev)) {
> -               ret = device_create_file(adev->dev, &dev_attr_pp_num_states);
> -               if (ret) {
> -                       DRM_ERROR("failed to create device file pp_num_states\n");
> -                       return ret;
> -               }
> -               ret = device_create_file(adev->dev, &dev_attr_pp_cur_state);
> -               if (ret) {
> -                       DRM_ERROR("failed to create device file pp_cur_state\n");
> -                       return ret;
> -               }
> -               ret = device_create_file(adev->dev, &dev_attr_pp_force_state);
> -               if (ret) {
> -                       DRM_ERROR("failed to create device file pp_force_state\n");
> -                       return ret;
> -               }
> -               ret = device_create_file(adev->dev, &dev_attr_pp_table);
> -               if (ret) {
> -                       DRM_ERROR("failed to create device file pp_table\n");
> -                       return ret;
> -               }
> -       }
> -
> -       ret = device_create_file(adev->dev, &dev_attr_pp_dpm_sclk);
> -       if (ret) {
> -               DRM_ERROR("failed to create device file pp_dpm_sclk\n");
> -               return ret;
> -       }
>
>         /* Arcturus does not support standalone mclk/socclk/fclk level setting */
>         if (adev->asic_type == CHIP_ARCTURUS) {
> @@ -3312,11 +3294,20 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>                 dev_attr_pp_dpm_fclk.store = NULL;
>         }
>
> -       ret = device_create_file(adev->dev, &dev_attr_pp_dpm_mclk);
> +       ret = sysfs_create_files(&adev->dev->kobj, amdgpu_pm_attributes);
>         if (ret) {
> -               DRM_ERROR("failed to create device file pp_dpm_mclk\n");
> +               DRM_ERROR("failed to create pm sysfs files\n");
>                 return ret;
>         }
> +
> +       if (!amdgpu_sriov_vf(adev)) {
> +               ret = sysfs_create_files(&adev->dev->kobj, amdgpu_pm_non_vf_attributes);
> +               if (ret) {
> +                       DRM_ERROR("failed to create pm sysfs files\n");
> +                       return ret;
> +               }
> +       }
> +
>         if (adev->asic_type >= CHIP_VEGA10) {
>                 ret = device_create_file(adev->dev, &dev_attr_pp_dpm_socclk);
>                 if (ret) {
> @@ -3352,23 +3343,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>                         return ret;
>                 }
>         }
> -       ret = device_create_file(adev->dev, &dev_attr_pp_sclk_od);
> -       if (ret) {
> -               DRM_ERROR("failed to create device file pp_sclk_od\n");
> -               return ret;
> -       }
> -       ret = device_create_file(adev->dev, &dev_attr_pp_mclk_od);
> -       if (ret) {
> -               DRM_ERROR("failed to create device file pp_mclk_od\n");
> -               return ret;
> -       }
> -       ret = device_create_file(adev->dev,
> -                       &dev_attr_pp_power_profile_mode);
> -       if (ret) {
> -               DRM_ERROR("failed to create device file "
> -                               "pp_power_profile_mode\n");
> -               return ret;
> -       }
> +
>         if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
>             (!is_support_sw_smu(adev) && hwmgr->od_enabled)) {
>                 ret = device_create_file(adev->dev,
> @@ -3379,13 +3354,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>                         return ret;
>                 }
>         }
> -       ret = device_create_file(adev->dev,
> -                       &dev_attr_gpu_busy_percent);
> -       if (ret) {
> -               DRM_ERROR("failed to create device file "
> -                               "gpu_busy_level\n");
> -               return ret;
> -       }
>         /* APU does not have its own dedicated memory */
>         if (!(adev->flags & AMD_IS_APU) &&
>              (adev->asic_type != CHIP_VEGA10)) {
> @@ -3437,16 +3405,11 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>
>         if (adev->pm.int_hwmon_dev)
>                 hwmon_device_unregister(adev->pm.int_hwmon_dev);
> -       device_remove_file(adev->dev, &dev_attr_power_dpm_state);
> -       device_remove_file(adev->dev, &dev_attr_power_dpm_force_performance_level);
>
> -       device_remove_file(adev->dev, &dev_attr_pp_num_states);
> -       device_remove_file(adev->dev, &dev_attr_pp_cur_state);
> -       device_remove_file(adev->dev, &dev_attr_pp_force_state);
> -       device_remove_file(adev->dev, &dev_attr_pp_table);
> +       sysfs_remove_files(&adev->dev->kobj, amdgpu_pm_attributes);
> +       if (!amdgpu_sriov_vf(adev))
> +               sysfs_remove_files(&adev->dev->kobj, amdgpu_pm_non_vf_attributes);
>
> -       device_remove_file(adev->dev, &dev_attr_pp_dpm_sclk);
> -       device_remove_file(adev->dev, &dev_attr_pp_dpm_mclk);
>         if (adev->asic_type >= CHIP_VEGA10) {
>                 device_remove_file(adev->dev, &dev_attr_pp_dpm_socclk);
>                 if (adev->asic_type != CHIP_ARCTURUS)
> @@ -3456,15 +3419,10 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>                 device_remove_file(adev->dev, &dev_attr_pp_dpm_pcie);
>         if (adev->asic_type >= CHIP_VEGA20)
>                 device_remove_file(adev->dev, &dev_attr_pp_dpm_fclk);
> -       device_remove_file(adev->dev, &dev_attr_pp_sclk_od);
> -       device_remove_file(adev->dev, &dev_attr_pp_mclk_od);
> -       device_remove_file(adev->dev,
> -                       &dev_attr_pp_power_profile_mode);
>         if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
>             (!is_support_sw_smu(adev) && hwmgr->od_enabled))
>                 device_remove_file(adev->dev,
>                                 &dev_attr_pp_od_clk_voltage);
> -       device_remove_file(adev->dev, &dev_attr_gpu_busy_percent);
>         if (!(adev->flags & AMD_IS_APU) &&
>              (adev->asic_type != CHIP_VEGA10))
>                 device_remove_file(adev->dev, &dev_attr_mem_busy_percent);
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
