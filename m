Return-Path: <SRS0=2dg2=2U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A37CC2D0C2
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 15:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499E320663
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 15:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q15+lwJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499E320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D032489A83;
	Mon, 30 Dec 2019 15:22:15 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC15D89A83
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2019 15:22:13 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id q6so32884609wro.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2019 07:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lU70Mwc8mcpM1Ckl/XKkLBV7q0FdRhqg/u0rpKbjqhg=;
 b=Q15+lwJr+Bx4qaI01nTh/31UefYjx67FylzzmTVXXZ3uQnCeCt174/q3V6AY8OLubl
 IqP/ah8/j2p1+5YbayRfeBinIATA69oDpLx262ppvbHjUS7URVnDhzxdj23WyqOw8FPm
 WQ92M4BDf+doZxAMjKNnxbJWBYtkvD+JZpDi4DuLElmMZ1OVy4VcEp/ppLHA5a+iDFMR
 HmEGpsBwZcmsdFWiedSI/GwTaG7z7wj0oaX4+5IMyZeGt7l86XvRDb2YgX2/6byw1eqN
 I0vMIHnCpUZQzHEf0LZcIYpXoNZTYrYh01PB9sXNmxR/URosa69i1MxxX08YnyBFUU1f
 H23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lU70Mwc8mcpM1Ckl/XKkLBV7q0FdRhqg/u0rpKbjqhg=;
 b=Lom4vp1a7bddxUStbbVSzKfUyumIblZW84nJU8qrABuNX6UkkXFi4QjDIFHffUaIOv
 TWoNbFaJctKQ+3r1gwDO0vWacB7AHwDeTV2EuoW/42x+GyVfzCUjprbqLmX8kmn4PiZ2
 IMo17CO95jl+mJ2wwFcAko3CQkSwY6Pqwcc3rfgSxwAN0evbknfsQ7ZcGvZZap/kOZOa
 sh1RytAXp7IRDllyuNenAmCzaT+CbS3jTfkqAPGx5VEh/vJxK6kOq+4CF59e/HtXs+pv
 EALZTBjCV0/CMxeL7nAhPOpvHGw+kM99WRu7X67r1RS4xV9WPHjlkMaT+sk78X8SIMAI
 qe+Q==
X-Gm-Message-State: APjAAAVpxj9Bx3ygUdqRhhQAzQeRFmasb1dflBFjl3rbuexwbRhDwOq0
 iORNmWIQTCXBHxScCtlhr1BRERRnlJRLf2a/IYPSbg==
X-Google-Smtp-Source: APXvYqxYEgvigG4mxSM3QGb38mc1Dc2Lg6UlC46dTPzsQ8NHMVraddsJiT4nDEKzYTpXKhiSIXrbtRi6NJVqABscVg8=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr54989781wru.154.1577719332170; 
 Mon, 30 Dec 2019 07:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20191230104931.28260-1-evan.quan@amd.com>
 <20191230104931.28260-2-evan.quan@amd.com>
In-Reply-To: <20191230104931.28260-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Dec 2019 10:22:00 -0500
Message-ID: <CADnq5_McMMHEShBoKoe+msb0Nj0rdCaeX5F3EO7iUXEomJ2m1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: allocate one piece of VRAM for all
 tables transferring
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
> Simplify the table transferring between driver and SMU and use less
> VRAM.
>
> Change-Id: I3f9b54fd9b8c0bcaeb533fc1a07bb06050fefbd8
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 101 ++++++++++--------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |   2 +-
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   3 +-
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |   4 +
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |   4 +
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |   4 +-
>  drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |  10 +-
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |   4 +
>  8 files changed, 73 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index c3cb1b8f43b5..bd3dbd1a0ad3 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -490,7 +490,7 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
>  {
>         struct smu_table_context *smu_table = &smu->smu_table;
>         struct amdgpu_device *adev = smu->adev;
> -       struct smu_table *table = smu_table->driver_table;
> +       struct smu_table *table = &smu_table->driver_table;
>         int table_id = smu_table_get_index(smu, table_index);
>         uint32_t table_size;
>         int ret = 0;
> @@ -941,24 +941,26 @@ static int smu_init_fb_allocations(struct smu_context *smu)
>         struct amdgpu_device *adev = smu->adev;
>         struct smu_table_context *smu_table = &smu->smu_table;
>         struct smu_table *tables = smu_table->tables;
> -       struct smu_table **driver_table = &(smu_table->driver_table);
> +       struct smu_table *driver_table = &(smu_table->driver_table);
>         uint32_t max_table_size = 0;
> -       int ret, i, index = 0;
> +       int ret, i;
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
> +       /* VRAM allocation for driver table */
>         for (i = 0; i < SMU_TABLE_COUNT; i++) {
>                 if (tables[i].size == 0)
>                         continue;
> @@ -966,24 +968,29 @@ static int smu_init_fb_allocations(struct smu_context *smu)
>                 if (i == SMU_TABLE_PMSTATUSLOG)
>                         continue;
>
> -               if (max_table_size < tables[i].size) {
> +               if (max_table_size < tables[i].size)
>                         max_table_size = tables[i].size;
> -                       index = i;
> -               }
>         }
>
> -       *driver_table = &tables[index];
> -
> -       return 0;
> -failed:
> -       while (--i >= 0) {
> -               if (tables[i].size == 0)
> -                       continue;
> -               amdgpu_bo_free_kernel(&tables[i].bo,
> -                                     &tables[i].mc_address,
> -                                     &tables[i].cpu_addr);
> -
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

Shouldn't this change be merged into the previous patch?  Otherwise,
we'll break I think.

>  }
>
> @@ -991,18 +998,19 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
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
> @@ -1913,26 +1921,25 @@ int smu_set_df_cstate(struct smu_context *smu,
>
>  int smu_write_watermarks_table(struct smu_context *smu)
>  {
> -       int ret = 0;
> -       struct smu_table_context *smu_table = &smu->smu_table;
> -       struct smu_table *table = NULL;
> +       void *watermarks_table = smu->smu_table.watermarks_table;
>
> -       table = &smu_table->tables[SMU_TABLE_WATERMARKS];
> -
> -       if (!table->cpu_addr)
> +       if (!watermarks_table)
>                 return -EINVAL;
>
> -       ret = smu_update_table(smu, SMU_TABLE_WATERMARKS, 0, table->cpu_addr,
> +       return smu_update_table(smu,
> +                               SMU_TABLE_WATERMARKS,
> +                               0,
> +                               watermarks_table,
>                                 true);
> -
> -       return ret;
>  }
>
>  int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
>                 struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
>  {
> -       struct smu_table *watermarks = &smu->smu_table.tables[SMU_TABLE_WATERMARKS];
> -       void *table = watermarks->cpu_addr;
> +       void *table = smu->smu_table.watermarks_table;
> +
> +       if (!table)
> +               return -EINVAL;
>
>         mutex_lock(&smu->mutex);
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index e89965e5fdcb..064b5201a8a7 100644
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
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index ed193adc881c..121bf81eced5 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -254,12 +254,13 @@ struct smu_table_context
>         unsigned long                   metrics_time;
>         void                            *metrics_table;
>         void                            *clocks_table;
> +       void                            *watermarks_table;

Can you split out the watermarks change as a separate patch or at
least explain why you are changing how it's handled?

Alex

>
>         void                            *max_sustainable_clocks;
>         struct smu_bios_boot_up_values  boot_values;
>         void                            *driver_pptable;
>         struct smu_table                *tables;
> -       struct smu_table                *driver_table;
> +       struct smu_table                driver_table;
>         struct smu_table                memory_pool;
>         uint8_t                         thermal_controller_type;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index ed147dd51325..aa206bde619b 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -555,6 +555,10 @@ static int navi10_tables_init(struct smu_context *smu, struct smu_table *tables)
>                 return -ENOMEM;
>         smu_table->metrics_time = 0;
>
> +       smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
> +       if (!smu_table->watermarks_table)
> +               return -ENOMEM;
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index c4b5984c86d9..861e6410363b 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -209,6 +209,10 @@ static int renoir_tables_init(struct smu_context *smu, struct smu_table *tables)
>                 return -ENOMEM;
>         smu_table->metrics_time = 0;
>
> +       smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
> +       if (!smu_table->watermarks_table)
> +               return -ENOMEM;
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 79a63edcd7ba..962e97860fe8 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -450,8 +450,10 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
>
>         kfree(smu_table->tables);
>         kfree(smu_table->metrics_table);
> +       kfree(smu_table->watermarks_table);
>         smu_table->tables = NULL;
>         smu_table->metrics_table = NULL;
> +       smu_table->watermarks_table = NULL;
>         smu_table->metrics_time = 0;
>
>         ret = smu_v11_0_fini_dpm_context(smu);
> @@ -776,7 +778,7 @@ int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu)
>
>  int smu_v11_0_set_driver_table_location(struct smu_context *smu)
>  {
> -       struct smu_table *driver_table = smu->smu_table.driver_table;
> +       struct smu_table *driver_table = &smu->smu_table.driver_table;
>         int ret = 0;
>
>         if (driver_table->mc_address) {
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> index cd2be9fb2513..2b1ef9eb0db6 100644
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
> @@ -517,7 +509,7 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
>
>  int smu_v12_0_set_driver_table_location(struct smu_context *smu)
>  {
> -       struct smu_table *driver_table = smu->smu_table.driver_table;
> +       struct smu_table *driver_table = &smu->smu_table.driver_table;
>         int ret = 0;
>
>         if (driver_table->mc_address) {
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 12f97956058b..38febd5ca4da 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -338,6 +338,10 @@ static int vega20_tables_init(struct smu_context *smu, struct smu_table *tables)
>                 return -ENOMEM;
>         smu_table->metrics_time = 0;
>
> +       smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
> +       if (!smu_table->watermarks_table)
> +               return -ENOMEM;
> +
>         return 0;
>  }
>
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
