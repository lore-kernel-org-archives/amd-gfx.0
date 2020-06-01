Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAC3C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 17:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185EB2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 17:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTfV0MI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185EB2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C376689F31;
	Mon,  1 Jun 2020 17:34:54 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62DCD89F31
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 17:34:54 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id q25so367223wmj.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sckcmfIRWuf6yImEzulj78MisLKaLT1K4KEM3VVydB4=;
 b=qTfV0MI+Myw3SX1oRnC0LCDa+2HttiPi0a5ib9GSwz1p4ucFWuiH0ngSlQks2o8+2B
 oKRzPoxqPimIUb6PTf/tEo4jrZ8an4xQRdGAXAHg5AinIJNYFrueARex/fjPNSer7nOG
 QGaOyEDapi2W4/y+qEcAy5pdxhQAgMTjgA51XQ7b59STVqzTeqV0TfsM0wJR8at3L9cY
 ixISLLfrC9kYrX5Ojqcw236xY4uNvnHd/YYkDM/Eu9n1FqS8dCTrIjlDvLMiriP8vWG9
 vHiwZGQfLm5Y3CMnijkegI/YPhywU/jcre0TYTs2SyCodKjQgMS7LytkVAASwfuY3Nzt
 YZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sckcmfIRWuf6yImEzulj78MisLKaLT1K4KEM3VVydB4=;
 b=c/YGXs71ErMf6tUtKzO0KlC7n9pDbnzU8xCBHRa+LXFJNP/iHNeVXMuahpYIx2Bqps
 8eUTyiQ0Gx2KHYJaUqQO9ebmuUGkARIxhyz53y5k0PftwzmRBFBRuWQA76AJg+cOfWuq
 BlSbbQG+OPh+0OIJYNm+0kat/w0qaRldg0IubYGML3MGbsVWam/UV5bKiYC5G3sK4Onc
 qRnVc9qssqkLpM9A171Czu2kg1mbj/xG7M3Wnr9n6bz2MK1ox7Euqv+M4ySKdRyqi7iG
 I66j62JlbF181UtQtzUnXeUF5Q1sEE+WX98iRThBJXlKtyPdMDzi3fzWq7B9V0qvWsXf
 5zTg==
X-Gm-Message-State: AOAM530qIeYsKg5jvg441nW6gpqSm8WrSV9b3nJHuChkufK6+CrRP89+
 87Om8a/hSkdNWzE9q5dfapTlbunfTzswJIAzKvE3CA==
X-Google-Smtp-Source: ABdhPJxe2FEwPXR/zGWEBT1/Li4SFdmJuIsgOO+lg3AK5gUJLIrjvm0LLfKTuagRSkh9DIpq4G0D+8fdldG40YuWjGM=
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr350535wmp.73.1591032892937; 
 Mon, 01 Jun 2020 10:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200601172818.5560-1-kent.russell@amd.com>
 <20200601172818.5560-2-kent.russell@amd.com>
In-Reply-To: <20200601172818.5560-2-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Jun 2020 13:34:41 -0400
Message-ID: <CADnq5_Nz-yYJtWbcGXmnq7Bw541qiq+rPwkNaKXCwLMzoogzKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id and serial_number for
 Arcturus
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

On Mon, Jun 1, 2020 at 1:28 PM Kent Russell <kent.russell@amd.com> wrote:
>
> Add support for unique_id and serial_number, as these are now
> the same value, and will be for future ASICs as well.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Change-Id: I3b036a38b19cd84025399b0706b2dad9b7aff713
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  2 +-
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  2 ++
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 32 +++++++++++++++++++
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 ++
>  5 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index b0dff9ecfb88..9136d9022c51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -1940,7 +1940,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>                 if (adev->flags & AMD_IS_APU)
>                         *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(unique_id)) {
> -               if (!adev->unique_id)
> +               if (asic_type < CHIP_VEGA10)

Will this work properly on navi and APUs as well?

>                         *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_features)) {
>                 if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 5294aa7cdde1..7946fd8444a3 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -793,6 +793,8 @@ static int smu_late_init(void *handle)
>         if (!smu->pm_enabled)
>                 return 0;
>
> +       smu_set_unique_id(smu);
> +
>         smu_handle_task(&adev->smu,
>                         smu->smu_dpm.dpm_level,
>                         AMD_PP_TASK_COMPLETE_INIT,
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index d66ac7457574..855e609650d9 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2262,6 +2262,37 @@ static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
>         i2c_del_adapter(control);
>  }
>
> +static void arcturus_set_unique_id(struct smu_context *smu)
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
> +       .set_unique_id = arcturus_set_unique_id,
>         .init_microcode = smu_v11_0_init_microcode,
>         .load_microcode = smu_v11_0_load_microcode,
>         .init_smc_tables = smu_v11_0_init_smc_tables,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 5bb1ac821aeb..bfa5211de079 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -495,6 +495,7 @@ struct pptable_funcs {
>         int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
>         int (*i2c_eeprom_init)(struct i2c_adapter *control);
>         void (*i2c_eeprom_fini)(struct i2c_adapter *control);
> +       void (*set_unique_id)(struct smu_context *smu);
>         int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_clocks *clock_table);
>         int (*init_microcode)(struct smu_context *smu);
>         int (*load_microcode)(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 6c59eeef2590..125d976215a6 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -218,6 +218,8 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
>                 ((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((control)) : 0)
>  #define smu_i2c_eeprom_fini(smu, control) \
>                 ((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((control)) : 0)
> +#define smu_set_unique_id(smu) \
> +               ((smu)->ppt_funcs->set_unique_id ? (smu)->ppt_funcs->set_unique_id((smu)) : 0)
>

I would call this get_unique_id() since it's fetching the id from the
hw rather than setting it.  Same comment for the device specific
functions above.

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
