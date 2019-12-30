Return-Path: <SRS0=2dg2=2U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4FC2D0C2
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 15:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E14206DB
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 15:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkFJTxKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E14206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22993899DE;
	Mon, 30 Dec 2019 15:17:13 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95245899DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2019 15:17:11 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id d16so32921700wre.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2019 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fHofl0jtcFHP+Zaok8c8oB8S86NB0kL5gYNemiD8UZ8=;
 b=jkFJTxKaXbZViAc93ofFS3qUlbIwnfigNnhGl22q07xh2QS83LrBCpsTx/eVFSCnP8
 DX/gnER00zB67RaM3nIN7EbZecn4KqHow4LAESySRpMZpu+pBMpmBG7rQz9VVBqWEdhS
 S+XZxsWG1uTicfLgxdxPAMmn4Vd7CeaIzl+YJFT7q+YpqGzQZb410TyMWNobq4Y/iM8t
 UwwvZuizCM22g/ysh9uDqk2bNC4/Ht/rbPsAnqIHzR08T+MXU1Zb0OsZ/5BhDfN73ynD
 qD0F5S6OjNyzd3PP9QMObGJCPIEvvL03Y1O4jYPVD9RQfRGMgrGEnQXcep01p6Bc4HIR
 MGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fHofl0jtcFHP+Zaok8c8oB8S86NB0kL5gYNemiD8UZ8=;
 b=fzRkxk+huMZdjAzOShktTz+BG9BWOfswp9Uh1j5YBfugx5sYeQmOOOY6yGKPFZFbmh
 egJPPAlf4PUOEYZgD9U0mJStZcg2A4nV0w3yCCuES0d/EF6QNH3kHPaOmR/cpm71b5ej
 7fWZrtMpOWT9cfXvCIaHi+DeCNZjrwvxoCgnWXvDOBVyxGWce6NRf8+YOXKphVKXHLKj
 iJ27n6eynRgwj77T2R2/aZkmetTMhGbbuU1m5s9BaMcIqjSECIPeb0F261tKuVkhK1F4
 67BS4Zm6hsIsqhR+3veP647hfbqNpCHbZqAVheqmwhEh79mI7cePt0y8DRVFw278Ya05
 b1eA==
X-Gm-Message-State: APjAAAWBMNfCs3N4fKkZGa3mVg0Krk3gNAZxhnMFv5bdB4VXcGbePHys
 jzsJpw2xd/dwnM7K3SbhrCosXLF4O2gm0GUEctfgoQ==
X-Google-Smtp-Source: APXvYqwi58a1HmdUn6SgODliuUUQSTG0ss83OdfAPR3+rIEq99MnoQmXVtATs7TkL0MAjYN0Nwh9Nd7Fk+cpe7d4/30=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr67339698wru.40.1577719030075; 
 Mon, 30 Dec 2019 07:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20191230104931.28260-1-evan.quan@amd.com>
In-Reply-To: <20191230104931.28260-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Dec 2019 10:16:58 -0500
Message-ID: <CADnq5_MVjy7Nfbeu1M=GN-8b3Mdn73j8Rvk6GGYFHoub-C_OHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: using fixed vram address for table
 transferring
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 30, 2019 at 5:50 AM Evan Quan <evan.quan@amd.com> wrote:
>
> By this, we can avoid to pass in the vram address on every table
> transferring.
>
> Change-Id: Ia8a3dbe923bc562286ab102a5830392a95dcf28c
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 42 ++++++++++++-------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 +
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +
>  drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  1 +
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  1 +
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 +
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 18 ++++++++
>  drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 18 ++++++++
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  1 +
>  11 files changed, 76 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 4a7fb6b15635..c3cb1b8f43b5 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -490,26 +490,19 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
>  {
>         struct smu_table_context *smu_table = &smu->smu_table;
>         struct amdgpu_device *adev = smu->adev;
> -       struct smu_table *table = NULL;
> -       int ret = 0;
> +       struct smu_table *table = smu_table->driver_table;
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
> @@ -948,7 +941,9 @@ static int smu_init_fb_allocations(struct smu_context *smu)
>         struct amdgpu_device *adev = smu->adev;
>         struct smu_table_context *smu_table = &smu->smu_table;
>         struct smu_table *tables = smu_table->tables;
> -       int ret, i;
> +       struct smu_table **driver_table = &(smu_table->driver_table);
> +       uint32_t max_table_size = 0;
> +       int ret, i, index = 0;
>
>         for (i = 0; i < SMU_TABLE_COUNT; i++) {
>                 if (tables[i].size == 0)
> @@ -964,6 +959,21 @@ static int smu_init_fb_allocations(struct smu_context *smu)
>                         goto failed;
>         }
>
> +       for (i = 0; i < SMU_TABLE_COUNT; i++) {
> +               if (tables[i].size == 0)
> +                       continue;
> +
> +               if (i == SMU_TABLE_PMSTATUSLOG)
> +                       continue;
> +
> +               if (max_table_size < tables[i].size) {
> +                       max_table_size = tables[i].size;
> +                       index = i;
> +               }
> +       }
> +
> +       *driver_table = &tables[index];
> +

Will this work?  I don't think we have any guarantee that the memory
for each table is contiguous.

>         return 0;
>  failed:
>         while (--i >= 0) {
> @@ -1063,6 +1073,10 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
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

Fix this comment to match the code changes.

> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 50b317f4b1e6..e89965e5fdcb 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2261,6 +2261,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
>         .set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
> +       .set_driver_table_location = smu_v11_0_set_driver_table_location,
>         .set_tool_table_location = smu_v11_0_set_tool_table_location,
>         .notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>         .system_features_control = smu_v11_0_system_features_control,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 541cfde289ea..ed193adc881c 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -259,6 +259,7 @@ struct smu_table_context
>         struct smu_bios_boot_up_values  boot_values;
>         void                            *driver_pptable;
>         struct smu_table                *tables;
> +       struct smu_table                *driver_table;
>         struct smu_table                memory_pool;
>         uint8_t                         thermal_controller_type;
>
> @@ -497,6 +498,7 @@ struct pptable_funcs {
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
> index e7ab8caee222..ed147dd51325 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2116,6 +2116,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
>         .set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
> +       .set_driver_table_location = smu_v11_0_set_driver_table_location,
>         .set_tool_table_location = smu_v11_0_set_tool_table_location,
>         .notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>         .system_features_control = smu_v11_0_system_features_control,
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index e73644beffd9..c4b5984c86d9 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -916,6 +916,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
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
> index 73935cf7ff39..79a63edcd7ba 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -774,6 +774,24 @@ int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu)
>         return smu_v11_0_set_deep_sleep_dcefclk(smu, table_context->boot_values.dcefclk / 100);
>  }
>
> +int smu_v11_0_set_driver_table_location(struct smu_context *smu)
> +{
> +       struct smu_table *driver_table = smu->smu_table.driver_table;
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
> index 2ac7f2f231b6..cd2be9fb2513 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> @@ -514,3 +514,21 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
>
>         return ret;
>  }
> +
> +int smu_v12_0_set_driver_table_location(struct smu_context *smu)
> +{
> +       struct smu_table *driver_table = smu->smu_table.driver_table;
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
> index 534c46bc0146..12f97956058b 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -3232,6 +3232,7 @@ static const struct pptable_funcs vega20_ppt_funcs = {
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
