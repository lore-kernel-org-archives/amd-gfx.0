Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A82C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 18:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA70D2072F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 18:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcrGRXX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA70D2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4FE89B7D;
	Tue,  2 Jun 2020 18:38:02 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C4D89B38
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 18:38:01 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id j198so2835799wmj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AfV58sipO+iKCloygrMs8Ub+k/v480JJO3IhM2hX6o4=;
 b=FcrGRXX9NrTVOTvdubc4kvytOtkjdq7Sy+CjBMLZnjHealxHxnIzK292EpBt1/HDEO
 ykTEXW/5OE8qQsVJqfvDlUbCpxZfFkeVLx2hnFImLE282+zcAdILiMVcTLXYNWL8+h/5
 Ro510raZzkGTqThXY6rCuUdrAVEJQLMgLdQxqy1F+D3SLbUCfWSR9bH5E6Hvb+Cqgdbi
 RTYVx2cIr/k04tA5obTOfqtkBqJgG75Ef8dIybWtqgRSNQ+BUbkyxuEpU2jKj0A6+8FL
 fD01pt96fxuOwv76mF7Lmu7XLsCcZBS1tBOJaZSw3KOAfhVJ7CWRvR4Ck6GY5roS0AGk
 qNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AfV58sipO+iKCloygrMs8Ub+k/v480JJO3IhM2hX6o4=;
 b=H003RQLK+vLqzHY7OqDZSCIP/ps8BCr/BvyKJBfh2vyQRzqLeaFd4TIdFNfPApoF56
 wBT2r/NWCiigA1+VTXQLbpyoZ6AjEmIQ2lSUs3+2zU/Q8HwI2xN5ARmdWsAXIgx9UfDG
 yfwhsbX/K9ajPj3FwqXQQbEHThSwE7BHUHxVuj9/bfBYKUTLdpN1nFwSaKs6oc7FQgbh
 2EPcJcezl9Z3I5Nh1B4q3yVBCit1OPq1D1QfBcKtJmrQaSXtYZNfSyQc87GZ/2R0KcmU
 hJTS+o33XVWG6PouA9uI/HmAJBzf17QCs6uUn/7dEfpvNiDp7G7rIGGGG/U5aHTwhX6R
 AW6g==
X-Gm-Message-State: AOAM532aBzW63OlGYfXJrMFjSQEnT27rbP+NmWkaCu72EZJ/Uz8mgpRM
 CPTWXKLq6Zdi8BYPGEV2zXxhZnTdqiIO3jn57T4=
X-Google-Smtp-Source: ABdhPJw4ld5/9K64R36uTG38YZR16BJm5u5cWdB+8lB4UsS0KFWg25JjNtw2VdZxV0FN+1DINy0ZEQkFjzLJD7a0Oe8=
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr5211936wml.70.1591123079978; 
 Tue, 02 Jun 2020 11:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200602162148.21624-1-kent.russell@amd.com>
 <20200602162148.21624-2-kent.russell@amd.com>
In-Reply-To: <20200602162148.21624-2-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 14:37:48 -0400
Message-ID: <CADnq5_Mng=EfWRuqnJBCcVn00rWjiFRRU5-JZj5+WZe0Y0OzCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id and serial_number for
 Arcturus v3
To: Kent Russell <kent.russell@amd.com>
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

On Tue, Jun 2, 2020 at 12:22 PM Kent Russell <kent.russell@amd.com> wrote:
>
> Add support for unique_id and serial_number, as these are now
> the same value, and will be for future ASICs as well.
>
> v2: Explicitly create unique_id only for VG10/20/ARC
> v3: Change set_unique_id to get_unique_id for clarity
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Change-Id: I3b036a38b19cd84025399b0706b2dad9b7aff713

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  4 ++-
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  2 ++
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 32 +++++++++++++++++++
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 ++
>  5 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index b0dff9ecfb88..b2cdc8a1268f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -1940,7 +1940,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>                 if (adev->flags & AMD_IS_APU)
>                         *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(unique_id)) {
> -               if (!adev->unique_id)
> +               if (asic_type != CHIP_VEGA10 &&
> +                   asic_type != CHIP_VEGA20 &&
> +                   asic_type != CHIP_ARCTURUS)
>                         *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_features)) {
>                 if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 5294aa7cdde1..847502faca90 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -793,6 +793,8 @@ static int smu_late_init(void *handle)
>         if (!smu->pm_enabled)
>                 return 0;
>
> +       smu_get_unique_id(smu);
> +
>         smu_handle_task(&adev->smu,
>                         smu->smu_dpm.dpm_level,
>                         AMD_PP_TASK_COMPLETE_INIT,
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index d66ac7457574..df7b408319f7 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2262,6 +2262,37 @@ static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
>         i2c_del_adapter(control);
>  }
>
> +static void arcturus_get_unique_id(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       uint32_t top32, bottom32, smu_version, size;
> +       char sn[16];
> +       uint64_t id;
> +
> +       if (smu_get_smc_version(smu, NULL, &smu_version)) {
> +               pr_warn("Failed to get smu version, cannot get unique_id or serial_number\n");
> +               return;
> +       }
> +
> +       /* PPSMC_MSG_ReadSerial* is supported by 54.23.0 and onwards */
> +       if (smu_version < 0x361700) {
> +               pr_warn("ReadSerial is only supported by PMFW 54.23.0 and onwards\n");
> +               return;
> +       }
> +
> +       /* Get the SN to turn into a Unique ID */
> +       smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32, &top32);
> +       smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32, &bottom32);
> +
> +       id = ((uint64_t)bottom32 << 32) | top32;
> +       adev->unique_id = id;
> +       /* For Arcturus-and-later, unique_id == serial_number, so convert it to a
> +        * 16-digit HEX string for convenience and backwards-compatibility
> +        */
> +       size = sprintf(sn, "%llx", id);
> +       memcpy(adev->serial, &sn, size);
> +}
> +
>  static bool arcturus_is_baco_supported(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
> @@ -2416,6 +2447,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .dpm_set_uvd_enable = arcturus_dpm_set_uvd_enable,
>         .i2c_eeprom_init = arcturus_i2c_eeprom_control_init,
>         .i2c_eeprom_fini = arcturus_i2c_eeprom_control_fini,
> +       .get_unique_id = arcturus_get_unique_id,
>         .init_microcode = smu_v11_0_init_microcode,
>         .load_microcode = smu_v11_0_load_microcode,
>         .init_smc_tables = smu_v11_0_init_smc_tables,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 5bb1ac821aeb..13fc5773ba45 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -495,6 +495,7 @@ struct pptable_funcs {
>         int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
>         int (*i2c_eeprom_init)(struct i2c_adapter *control);
>         void (*i2c_eeprom_fini)(struct i2c_adapter *control);
> +       void (*get_unique_id)(struct smu_context *smu);
>         int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_clocks *clock_table);
>         int (*init_microcode)(struct smu_context *smu);
>         int (*load_microcode)(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 6c59eeef2590..c9440c978402 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -218,6 +218,8 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
>                 ((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((control)) : 0)
>  #define smu_i2c_eeprom_fini(smu, control) \
>                 ((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((control)) : 0)
> +#define smu_get_unique_id(smu) \
> +               ((smu)->ppt_funcs->get_unique_id ? (smu)->ppt_funcs->get_unique_id((smu)) : 0)
>
>  #define smu_log_thermal_throttling(smu) \
>                 ((smu)->ppt_funcs->log_thermal_throttling_event ? (smu)->ppt_funcs->log_thermal_throttling_event((smu)) : 0)
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
