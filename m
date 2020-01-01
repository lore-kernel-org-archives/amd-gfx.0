Return-Path: <SRS0=Ppqo=2W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B02C2D0DC
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2020 14:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF2B2072C
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2020 14:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBda2kLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF2B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE1189B5F;
	Wed,  1 Jan 2020 14:19:33 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BED689B5F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jan 2020 14:19:31 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c14so37041454wrn.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jan 2020 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wll9cixay9xR2ad6+zngfEMlJFIqPlzC9f6DUMirpP8=;
 b=IBda2kLAeAyMR3mjNBJpRtW43LWfVnFAdOGbVWmVgjiS395HUMoFXDXJ2VVBX04Ni1
 kSKzICsOXypLh1vckmH64yPDyfzzGO/4srRWg7VGMTbzgxxb87f7xa/q5DFzk/G5E//G
 rsBQA/A1+RctMwrsj+Ah6Sng7l9AhRfUNxQrZ7uC6Gr5KRMhLEknxaecuCIj3mjeHbT1
 wolrO0BhtLW3LXUetfpKzDVszFts62LhADFvziUROPPq7GzJXJhO9AX8pUO3ydy3LURd
 LWDp+f0ReZyB+NEAXeK/NrCJLuYbPvls0Z9NEwRQzXH0tB2Rs6rZXx824xn5U8IPba5t
 2HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wll9cixay9xR2ad6+zngfEMlJFIqPlzC9f6DUMirpP8=;
 b=W4KdKn1ls4b4bRkEiLMiae5kyCenYFfCfbB1QE+yg8E0fmcc8QwS/zMRT7eSCMeWPI
 02T+M8himSI3fdbd9r782D67jCnHvfLWdovKSFjCm8FwoLFgaOWrTYZYEkgv0Q2O2+Zg
 EAupVTVCTNJxmVBzN/pXJCDyrACEH0s5gM/T46zgK87/YI42RdbKwny8mae4Qrce3xWx
 pQ5tL1yztuBwyxngzrti0YTZY5M8j4I6iXO+BNNrWRvzKm024BOSfc5jS18mi4WrNAwb
 fvtPkHjIBPwHT3lck/8Rz0Ze3xPwwgCXUGGUpnzYUnFltHO9h0L+2IyX7Zw3bXrNHHl6
 bYdQ==
X-Gm-Message-State: APjAAAUuB2JabzxDrC7UrKWRASMzC2e+OXtKTujEZb7zbpNZLxUfzBax
 D0zoBMhN0Fkv/J4jwImZMZMNfxp9HqMTjD2V1DY=
X-Google-Smtp-Source: APXvYqwOWZf/q4/NlJV1+fxjuL+K0V+p2WjbzG/69AyZqwZfMDFTSs6/mN7+X0VjQmD4LvOTLldztrmyF1QT7/Rv+wI=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr78685474wrn.50.1577888369581; 
 Wed, 01 Jan 2020 06:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20191231024856.3557-1-evan.quan@amd.com>
 <20191231024856.3557-2-evan.quan@amd.com>
In-Reply-To: <20191231024856.3557-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jan 2020 09:19:18 -0500
Message-ID: <CADnq5_MGp7Lj_W0=VMJ-Mz5J=aLTHVhWRdgrYmaW87f-RQmpUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: unified VRAM address for driver
 table interaction with SMU
To: Evan Quan <evan.quan@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 30, 2019 at 9:49 PM Evan Quan <evan.quan@amd.com> wrote:
>
> By this, we can avoid to pass in the VRAM address on every table
> transferring. That puts extra unnecessary traffics on SMU on
> some cases(e.g. polling the amdgpu_pm_info sysfs interface).
>
> Change-Id: Ifb74d9cd89790b301e88d472b29cdb9b0365b65a
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 98 ++++++++++++-------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  3 +-
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +
>  drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  1 +
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  1 +
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 +
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 18 ++++
>  drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 26 +++--
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  1 +
>  11 files changed, 109 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 09e16183a769..290976f5f6c2 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -490,26 +490,19 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
>  {
>         struct smu_table_context *smu_table = &smu->smu_table;
>         struct amdgpu_device *adev = smu->adev;
> -       struct smu_table *table = NULL;
> -       int ret = 0;
> +       struct smu_table *table = &smu_table->driver_table;
>         int table_id = smu_table_get_index(smu, table_index);
> +       uint32_t table_size;
> +       int ret = 0;
>
>         if (!table_data || table_id >= SMU_TABLE_COUNT || table_id < 0)
>                 return -EINVAL;
>
> -       table = &smu_table->tables[table_index];
> +       table_size = smu_table->tables[table_index].size;
>
>         if (drv2smu)
> -               memcpy(table->cpu_addr, table_data, table->size);
> +               memcpy(table->cpu_addr, table_data, table_size);
>
> -       ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetDriverDramAddrHigh,
> -                                         upper_32_bits(table->mc_address));
> -       if (ret)
> -               return ret;
> -       ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetDriverDramAddrLow,
> -                                         lower_32_bits(table->mc_address));
> -       if (ret)
> -               return ret;
>         ret = smu_send_smc_msg_with_param(smu, drv2smu ?
>                                           SMU_MSG_TransferTableDram2Smu :
>                                           SMU_MSG_TransferTableSmu2Dram,
> @@ -521,7 +514,7 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
>         adev->nbio.funcs->hdp_flush(adev, NULL);
>
>         if (!drv2smu)
> -               memcpy(table_data, table->cpu_addr, table->size);
> +               memcpy(table_data, table->cpu_addr, table_size);
>
>         return ret;
>  }
> @@ -948,32 +941,56 @@ static int smu_init_fb_allocations(struct smu_context *smu)
>         struct amdgpu_device *adev = smu->adev;
>         struct smu_table_context *smu_table = &smu->smu_table;
>         struct smu_table *tables = smu_table->tables;
> +       struct smu_table *driver_table = &(smu_table->driver_table);
> +       uint32_t max_table_size = 0;
>         int ret, i;
>
> -       for (i = 0; i < SMU_TABLE_COUNT; i++) {
> -               if (tables[i].size == 0)
> -                       continue;
> +       /* VRAM allocation for tool table */
> +       if (tables[SMU_TABLE_PMSTATUSLOG].size) {
>                 ret = amdgpu_bo_create_kernel(adev,
> -                                             tables[i].size,
> -                                             tables[i].align,
> -                                             tables[i].domain,
> -                                             &tables[i].bo,
> -                                             &tables[i].mc_address,
> -                                             &tables[i].cpu_addr);
> -               if (ret)
> -                       goto failed;
> +                                             tables[SMU_TABLE_PMSTATUSLOG].size,
> +                                             tables[SMU_TABLE_PMSTATUSLOG].align,
> +                                             tables[SMU_TABLE_PMSTATUSLOG].domain,
> +                                             &tables[SMU_TABLE_PMSTATUSLOG].bo,
> +                                             &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
> +                                             &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
> +               if (ret) {
> +                       pr_err("VRAM allocation for tool table failed!\n");
> +                       return ret;
> +               }
>         }
>
> -       return 0;
> -failed:
> -       while (--i >= 0) {
> +       /* VRAM allocation for driver table */
> +       for (i = 0; i < SMU_TABLE_COUNT; i++) {
>                 if (tables[i].size == 0)
>                         continue;
> -               amdgpu_bo_free_kernel(&tables[i].bo,
> -                                     &tables[i].mc_address,
> -                                     &tables[i].cpu_addr);
>
> +               if (i == SMU_TABLE_PMSTATUSLOG)
> +                       continue;
> +
> +               if (max_table_size < tables[i].size)
> +                       max_table_size = tables[i].size;
> +       }

It would probably be good to document somewhere that the table bo
allocation is just a staging buffer for uploading and downloading
tables from the SMU.  The SMU actually stores the active tables in
SRAM.  That confused me at first when reviewing this patch.

> +
> +       driver_table->size = max_table_size;
> +       driver_table->align = PAGE_SIZE;
> +       driver_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
> +
> +       ret = amdgpu_bo_create_kernel(adev,
> +                                     driver_table->size,
> +                                     driver_table->align,
> +                                     driver_table->domain,
> +                                     &driver_table->bo,
> +                                     &driver_table->mc_address,
> +                                     &driver_table->cpu_addr);
> +       if (ret) {
> +               pr_err("VRAM allocation for driver table failed!\n");
> +               if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
> +                       amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
> +                                             &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
> +                                             &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
>         }
> +
>         return ret;
>  }
>
> @@ -981,18 +998,19 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
>  {
>         struct smu_table_context *smu_table = &smu->smu_table;
>         struct smu_table *tables = smu_table->tables;
> -       uint32_t i = 0;
> +       struct smu_table *driver_table = &(smu_table->driver_table);
>
>         if (!tables)
>                 return 0;
>
> -       for (i = 0; i < SMU_TABLE_COUNT; i++) {
> -               if (tables[i].size == 0)
> -                       continue;
> -               amdgpu_bo_free_kernel(&tables[i].bo,
> -                                     &tables[i].mc_address,
> -                                     &tables[i].cpu_addr);
> -       }
> +       if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
> +               amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
> +                                     &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
> +                                     &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
> +
> +       amdgpu_bo_free_kernel(&driver_table->bo,
> +                             &driver_table->mc_address,
> +                             &driver_table->cpu_addr);
>
>         return 0;
>  }
> @@ -1063,6 +1081,10 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>
>         /* smu_dump_pptable(smu); */
>
> +       ret = smu_set_driver_table_location(smu);
> +       if (ret)
> +               return ret;
> +
>         /*
>          * Copy pptable bo in the vram to smc with SMU MSGs such as
>          * SetDriverDramAddr and TransferTableDram2Smu.
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 50b317f4b1e6..064b5201a8a7 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2022,7 +2022,7 @@ static int arcturus_i2c_eeprom_read_data(struct i2c_adapter *control,
>         SwI2cRequest_t req;
>         struct amdgpu_device *adev = to_amdgpu_device(control);
>         struct smu_table_context *smu_table = &adev->smu.smu_table;
> -       struct smu_table *table = &smu_table->tables[SMU_TABLE_I2C_COMMANDS];
> +       struct smu_table *table = &smu_table->driver_table;
>
>         memset(&req, 0, sizeof(req));
>         arcturus_fill_eeprom_i2c_req(&req, false, address, numbytes, data);
> @@ -2261,6 +2261,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
>         .set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
> +       .set_driver_table_location = smu_v11_0_set_driver_table_location,
>         .set_tool_table_location = smu_v11_0_set_tool_table_location,
>         .notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>         .system_features_control = smu_v11_0_system_features_control,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 30da8328d1bc..121bf81eced5 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -260,6 +260,7 @@ struct smu_table_context
>         struct smu_bios_boot_up_values  boot_values;
>         void                            *driver_pptable;
>         struct smu_table                *tables;
> +       struct smu_table                driver_table;

This would be a good place to document that the driver table is just a
staging buffer for uploading/downloading content from the SMU.  Can
you check that we properly lock the staging buffer in all the call
paths that interact with SMU?  If we do that, I think we can clean up
and simplify a lot of the other locking we have already.

>         struct smu_table                memory_pool;
>         uint8_t                         thermal_controller_type;
>
> @@ -498,6 +499,7 @@ struct pptable_funcs {
>         int (*set_gfx_cgpg)(struct smu_context *smu, bool enable);
>         int (*write_pptable)(struct smu_context *smu);
>         int (*set_min_dcef_deep_sleep)(struct smu_context *smu);
> +       int (*set_driver_table_location)(struct smu_context *smu);
>         int (*set_tool_table_location)(struct smu_context *smu);
>         int (*notify_memory_pool_location)(struct smu_context *smu);
>         int (*set_last_dcef_min_deep_sleep_clk)(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index db3f78676aeb..662989296174 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -170,6 +170,8 @@ int smu_v11_0_write_pptable(struct smu_context *smu);
>
>  int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu);
>
> +int smu_v11_0_set_driver_table_location(struct smu_context *smu);
> +
>  int smu_v11_0_set_tool_table_location(struct smu_context *smu);
>
>  int smu_v11_0_notify_memory_pool_location(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> index 3f1cd06e273c..d79e54b5ebf6 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> @@ -90,4 +90,6 @@ int smu_v12_0_mode2_reset(struct smu_context *smu);
>  int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
>                             uint32_t min, uint32_t max);
>
> +int smu_v12_0_set_driver_table_location(struct smu_context *smu);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 3387f3243a01..aa206bde619b 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2120,6 +2120,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
>         .set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
> +       .set_driver_table_location = smu_v11_0_set_driver_table_location,
>         .set_tool_table_location = smu_v11_0_set_tool_table_location,
>         .notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>         .system_features_control = smu_v11_0_system_features_control,
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 506cc6bf4bc0..861e6410363b 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -920,6 +920,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>         .get_dpm_ultimate_freq = smu_v12_0_get_dpm_ultimate_freq,
>         .mode2_reset = smu_v12_0_mode2_reset,
>         .set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
> +       .set_driver_table_location = smu_v12_0_set_driver_table_location,
>  };
>
>  void renoir_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 77864e4236c4..783319ec8bf9 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -61,6 +61,8 @@
>         ((smu)->ppt_funcs->write_pptable ? (smu)->ppt_funcs->write_pptable((smu)) : 0)
>  #define smu_set_min_dcef_deep_sleep(smu) \
>         ((smu)->ppt_funcs->set_min_dcef_deep_sleep ? (smu)->ppt_funcs->set_min_dcef_deep_sleep((smu)) : 0)
> +#define smu_set_driver_table_location(smu) \
> +       ((smu)->ppt_funcs->set_driver_table_location ? (smu)->ppt_funcs->set_driver_table_location((smu)) : 0)
>  #define smu_set_tool_table_location(smu) \
>         ((smu)->ppt_funcs->set_tool_table_location ? (smu)->ppt_funcs->set_tool_table_location((smu)) : 0)
>  #define smu_notify_memory_pool_location(smu) \
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 6fb93eb6ab39..e804f9854027 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -776,6 +776,24 @@ int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu)
>         return smu_v11_0_set_deep_sleep_dcefclk(smu, table_context->boot_values.dcefclk / 100);
>  }
>
> +int smu_v11_0_set_driver_table_location(struct smu_context *smu)
> +{
> +       struct smu_table *driver_table = &smu->smu_table.driver_table;
> +       int ret = 0;
> +
> +       if (driver_table->mc_address) {
> +               ret = smu_send_smc_msg_with_param(smu,
> +                               SMU_MSG_SetDriverDramAddrHigh,
> +                               upper_32_bits(driver_table->mc_address));
> +               if (!ret)
> +                       ret = smu_send_smc_msg_with_param(smu,
> +                               SMU_MSG_SetDriverDramAddrLow,
> +                               lower_32_bits(driver_table->mc_address));
> +       }
> +
> +       return ret;
> +}
> +
>  int smu_v11_0_set_tool_table_location(struct smu_context *smu)
>  {
>         int ret = 0;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> index 2ac7f2f231b6..2b1ef9eb0db6 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> @@ -318,14 +318,6 @@ int smu_v12_0_fini_smc_tables(struct smu_context *smu)
>  int smu_v12_0_populate_smc_tables(struct smu_context *smu)
>  {
>         struct smu_table_context *smu_table = &smu->smu_table;
> -       struct smu_table *table = NULL;
> -
> -       table = &smu_table->tables[SMU_TABLE_DPMCLOCKS];
> -       if (!table)
> -               return -EINVAL;
> -
> -       if (!table->cpu_addr)
> -               return -EINVAL;
>
>         return smu_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
>  }
> @@ -514,3 +506,21 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
>
>         return ret;
>  }
> +
> +int smu_v12_0_set_driver_table_location(struct smu_context *smu)
> +{
> +       struct smu_table *driver_table = &smu->smu_table.driver_table;
> +       int ret = 0;
> +
> +       if (driver_table->mc_address) {
> +               ret = smu_send_smc_msg_with_param(smu,
> +                               SMU_MSG_SetDriverDramAddrHigh,
> +                               upper_32_bits(driver_table->mc_address));
> +               if (!ret)
> +                       ret = smu_send_smc_msg_with_param(smu,
> +                               SMU_MSG_SetDriverDramAddrLow,
> +                               lower_32_bits(driver_table->mc_address));
> +       }
> +
> +       return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 27bdcdeb08d9..38febd5ca4da 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -3236,6 +3236,7 @@ static const struct pptable_funcs vega20_ppt_funcs = {
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
>         .set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
> +       .set_driver_table_location = smu_v11_0_set_driver_table_location,
>         .set_tool_table_location = smu_v11_0_set_tool_table_location,
>         .notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>         .system_features_control = smu_v11_0_system_features_control,
> --
> 2.24.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
