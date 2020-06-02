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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E3C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D158320757
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWMSIp9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D158320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE276E408;
	Tue,  2 Jun 2020 15:00:32 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B11F6E408
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 15:00:31 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id h5so3735248wrc.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FinIVepfNoqBS1OCQSkR7jyCGR7BWYvNCOerCIP/Vgo=;
 b=LWMSIp9Jik1qeBSH9czEgLkdAJJF0lEGuqwBnnrRbe7loYMIxrAlp+orCHg3QQhVj8
 ljfi5LdHTigZt0chRp0FHFRjIZWKopjzZJm9QwHigHCjoj5fFdaGufI4aukcTiaWZlAe
 GDKd/D7T1YbRSo5P9e/Ukp4elz31DGlWXpw0FB9kEDcbTnccl1vleGDIXN8xgStzMdrT
 XmpTsCzeka4eQITSphhUz/HNXusBPdts9ns6I3bzUwm0DSALGu3WJhCIucP6JqHuMUoP
 W6GyUaVyWLM9Gda4/VZ2+6NH/rp3p0RMIwOwACuBiEXNXvz4/ODJJUpUcWnCtMwWVWaO
 n0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FinIVepfNoqBS1OCQSkR7jyCGR7BWYvNCOerCIP/Vgo=;
 b=TUeV29aQXKkNSJtRfvV86iY50tdIEpxlbFbglkpyGtGpNp6LYLcU14mOmE6OmfWG89
 iDxs/5pETgne9AhkOKMBpG69nVCo3MrBtJpNvyTFp29/v1ANRu2FdqQJAPfufPsP3BcI
 2SFey3PhbtTHhcgUtNrI1dLgQWUX8T591vrrrvLRdfZfpsY64Bh34jnigWQBaxOq6cqe
 A6iNx3+G5flg2fpjGOwboPfGNNaB1culZ9Ffhd7YLjcbGDw9568Aad6+XfC+mNYJ8lVG
 pUq8kn3j1grlpVlCMbBTGKfiQEW8dy2UwWBztKptKrBMPe0HioQj5VGEllE5z3sSAyR5
 M6wA==
X-Gm-Message-State: AOAM531fGPY0bjN4f+xPgPeawKxjajh0W/nlMWpaRz/dUhp3uAxhZlJo
 ffJ6F8DDQSEYK0gcAqQ7XO01RJ9eApoFjnQW+eW1pg==
X-Google-Smtp-Source: ABdhPJxUn4yRl3NVPL22nu7yzs4u7Q48Qprpu9EpN1xZGJtuSI9MabR6jG3nqxkO9YYs5KPNJuye9t6LuI5oIAG2Ksg=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr28532296wru.124.1591110029509; 
 Tue, 02 Jun 2020 08:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200601073003.13044-1-evan.quan@amd.com>
 <20200601073003.13044-3-evan.quan@amd.com>
In-Reply-To: <20200601073003.13044-3-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 11:00:18 -0400
Message-ID: <CADnq5_Ow1CtJx_B-g9caUJPmPV5cEQc=2E01KU2V8kSymQ9OGA@mail.gmail.com>
Subject: Re: [PATCH 3/9] drm/amd/powerplay: centralize all buffer allocation
 in sw_init phase
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

On Mon, Jun 1, 2020 at 3:30 AM Evan Quan <evan.quan@amd.com> wrote:
>
> To fit common design. And this can simplify the buffer deallocation.
>
> Change-Id: Iee682e76aadb5f34861d69d5794ced44f0a78789
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Took me a little while to sort out the functional changes from the
non-functional moves.  Might be clearer to split those up.  Either
way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 330 ++++++++++-----------
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 105 ++++---
>  2 files changed, 223 insertions(+), 212 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index b4f108cb52fa..70c7b3fdee79 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -817,6 +817,147 @@ int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
>         return 0;
>  }
>
> +static int smu_init_fb_allocations(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       struct smu_table_context *smu_table = &smu->smu_table;
> +       struct smu_table *tables = smu_table->tables;
> +       struct smu_table *driver_table = &(smu_table->driver_table);
> +       uint32_t max_table_size = 0;
> +       int ret, i;
> +
> +       /* VRAM allocation for tool table */
> +       if (tables[SMU_TABLE_PMSTATUSLOG].size) {
> +               ret = amdgpu_bo_create_kernel(adev,
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
> +       }
> +
> +       /* VRAM allocation for driver table */
> +       for (i = 0; i < SMU_TABLE_COUNT; i++) {
> +               if (tables[i].size == 0)
> +                       continue;
> +
> +               if (i == SMU_TABLE_PMSTATUSLOG)
> +                       continue;
> +
> +               if (max_table_size < tables[i].size)
> +                       max_table_size = tables[i].size;
> +       }
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
> +       }
> +
> +       return ret;
> +}
> +
> +static int smu_fini_fb_allocations(struct smu_context *smu)
> +{
> +       struct smu_table_context *smu_table = &smu->smu_table;
> +       struct smu_table *tables = smu_table->tables;
> +       struct smu_table *driver_table = &(smu_table->driver_table);
> +
> +       if (!tables)
> +               return 0;
> +
> +       if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
> +               amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
> +                                     &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
> +                                     &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
> +
> +       amdgpu_bo_free_kernel(&driver_table->bo,
> +                             &driver_table->mc_address,
> +                             &driver_table->cpu_addr);
> +
> +       return 0;
> +}
> +
> +/**
> + * smu_alloc_memory_pool - allocate memory pool in the system memory
> + *
> + * @smu: amdgpu_device pointer
> + *
> + * This memory pool will be used for SMC use and msg SetSystemVirtualDramAddr
> + * and DramLogSetDramAddr can notify it changed.
> + *
> + * Returns 0 on success, error on failure.
> + */
> +static int smu_alloc_memory_pool(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       struct smu_table_context *smu_table = &smu->smu_table;
> +       struct smu_table *memory_pool = &smu_table->memory_pool;
> +       uint64_t pool_size = smu->pool_size;
> +       int ret = 0;
> +
> +       if (pool_size == SMU_MEMORY_POOL_SIZE_ZERO)
> +               return ret;
> +
> +       memory_pool->size = pool_size;
> +       memory_pool->align = PAGE_SIZE;
> +       memory_pool->domain = AMDGPU_GEM_DOMAIN_GTT;
> +
> +       switch (pool_size) {
> +       case SMU_MEMORY_POOL_SIZE_256_MB:
> +       case SMU_MEMORY_POOL_SIZE_512_MB:
> +       case SMU_MEMORY_POOL_SIZE_1_GB:
> +       case SMU_MEMORY_POOL_SIZE_2_GB:
> +               ret = amdgpu_bo_create_kernel(adev,
> +                                             memory_pool->size,
> +                                             memory_pool->align,
> +                                             memory_pool->domain,
> +                                             &memory_pool->bo,
> +                                             &memory_pool->mc_address,
> +                                             &memory_pool->cpu_addr);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int smu_free_memory_pool(struct smu_context *smu)
> +{
> +       struct smu_table_context *smu_table = &smu->smu_table;
> +       struct smu_table *memory_pool = &smu_table->memory_pool;
> +
> +       if (memory_pool->size == SMU_MEMORY_POOL_SIZE_ZERO)
> +               return 0;
> +
> +       amdgpu_bo_free_kernel(&memory_pool->bo,
> +                             &memory_pool->mc_address,
> +                             &memory_pool->cpu_addr);
> +
> +       memset(memory_pool, 0, sizeof(struct smu_table));
> +
> +       return 0;
> +}
> +
>  static int smu_smc_table_sw_init(struct smu_context *smu)
>  {
>         int ret;
> @@ -841,6 +982,17 @@ static int smu_smc_table_sw_init(struct smu_context *smu)
>                 return ret;
>         }
>
> +       /*
> +        * allocate vram bos to store smc table contents.
> +        */
> +       ret = smu_init_fb_allocations(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_alloc_memory_pool(smu);
> +       if (ret)
> +               return ret;
> +
>         return 0;
>  }
>
> @@ -848,6 +1000,14 @@ static int smu_smc_table_sw_fini(struct smu_context *smu)
>  {
>         int ret;
>
> +       ret = smu_free_memory_pool(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_fini_fb_allocations(smu);
> +       if (ret)
> +               return ret;
> +
>         ret = smu_fini_power(smu);
>         if (ret) {
>                 pr_err("Failed to init smu_fini_power!\n");
> @@ -947,85 +1107,6 @@ static int smu_sw_fini(void *handle)
>         return 0;
>  }
>
> -static int smu_init_fb_allocations(struct smu_context *smu)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       struct smu_table_context *smu_table = &smu->smu_table;
> -       struct smu_table *tables = smu_table->tables;
> -       struct smu_table *driver_table = &(smu_table->driver_table);
> -       uint32_t max_table_size = 0;
> -       int ret, i;
> -
> -       /* VRAM allocation for tool table */
> -       if (tables[SMU_TABLE_PMSTATUSLOG].size) {
> -               ret = amdgpu_bo_create_kernel(adev,
> -                                             tables[SMU_TABLE_PMSTATUSLOG].size,
> -                                             tables[SMU_TABLE_PMSTATUSLOG].align,
> -                                             tables[SMU_TABLE_PMSTATUSLOG].domain,
> -                                             &tables[SMU_TABLE_PMSTATUSLOG].bo,
> -                                             &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
> -                                             &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
> -               if (ret) {
> -                       pr_err("VRAM allocation for tool table failed!\n");
> -                       return ret;
> -               }
> -       }
> -
> -       /* VRAM allocation for driver table */
> -       for (i = 0; i < SMU_TABLE_COUNT; i++) {
> -               if (tables[i].size == 0)
> -                       continue;
> -
> -               if (i == SMU_TABLE_PMSTATUSLOG)
> -                       continue;
> -
> -               if (max_table_size < tables[i].size)
> -                       max_table_size = tables[i].size;
> -       }
> -
> -       driver_table->size = max_table_size;
> -       driver_table->align = PAGE_SIZE;
> -       driver_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
> -
> -       ret = amdgpu_bo_create_kernel(adev,
> -                                     driver_table->size,
> -                                     driver_table->align,
> -                                     driver_table->domain,
> -                                     &driver_table->bo,
> -                                     &driver_table->mc_address,
> -                                     &driver_table->cpu_addr);
> -       if (ret) {
> -               pr_err("VRAM allocation for driver table failed!\n");
> -               if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
> -                       amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
> -                                             &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
> -                                             &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
> -       }
> -
> -       return ret;
> -}
> -
> -static int smu_fini_fb_allocations(struct smu_context *smu)
> -{
> -       struct smu_table_context *smu_table = &smu->smu_table;
> -       struct smu_table *tables = smu_table->tables;
> -       struct smu_table *driver_table = &(smu_table->driver_table);
> -
> -       if (!tables)
> -               return 0;
> -
> -       if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
> -               amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
> -                                     &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
> -                                     &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
> -
> -       amdgpu_bo_free_kernel(&driver_table->bo,
> -                             &driver_table->mc_address,
> -                             &driver_table->cpu_addr);
> -
> -       return 0;
> -}
> -
>  static int smu_smc_table_hw_init(struct smu_context *smu,
>                                  bool initialize)
>  {
> @@ -1063,13 +1144,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>                 if (ret)
>                         return ret;
>
> -               /*
> -                * allocate vram bos to store smc table contents.
> -                */
> -               ret = smu_init_fb_allocations(smu);
> -               if (ret)
> -                       return ret;
> -
>                 /*
>                  * Parse pptable format and fill PPTable_t smc_pptable to
>                  * smu_table_context structure. And read the smc_dpm_table from vbios,
> @@ -1187,68 +1261,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         return ret;
>  }
>
> -/**
> - * smu_alloc_memory_pool - allocate memory pool in the system memory
> - *
> - * @smu: amdgpu_device pointer
> - *
> - * This memory pool will be used for SMC use and msg SetSystemVirtualDramAddr
> - * and DramLogSetDramAddr can notify it changed.
> - *
> - * Returns 0 on success, error on failure.
> - */
> -static int smu_alloc_memory_pool(struct smu_context *smu)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       struct smu_table_context *smu_table = &smu->smu_table;
> -       struct smu_table *memory_pool = &smu_table->memory_pool;
> -       uint64_t pool_size = smu->pool_size;
> -       int ret = 0;
> -
> -       if (pool_size == SMU_MEMORY_POOL_SIZE_ZERO)
> -               return ret;
> -
> -       memory_pool->size = pool_size;
> -       memory_pool->align = PAGE_SIZE;
> -       memory_pool->domain = AMDGPU_GEM_DOMAIN_GTT;
> -
> -       switch (pool_size) {
> -       case SMU_MEMORY_POOL_SIZE_256_MB:
> -       case SMU_MEMORY_POOL_SIZE_512_MB:
> -       case SMU_MEMORY_POOL_SIZE_1_GB:
> -       case SMU_MEMORY_POOL_SIZE_2_GB:
> -               ret = amdgpu_bo_create_kernel(adev,
> -                                             memory_pool->size,
> -                                             memory_pool->align,
> -                                             memory_pool->domain,
> -                                             &memory_pool->bo,
> -                                             &memory_pool->mc_address,
> -                                             &memory_pool->cpu_addr);
> -               break;
> -       default:
> -               break;
> -       }
> -
> -       return ret;
> -}
> -
> -static int smu_free_memory_pool(struct smu_context *smu)
> -{
> -       struct smu_table_context *smu_table = &smu->smu_table;
> -       struct smu_table *memory_pool = &smu_table->memory_pool;
> -
> -       if (memory_pool->size == SMU_MEMORY_POOL_SIZE_ZERO)
> -               return 0;
> -
> -       amdgpu_bo_free_kernel(&memory_pool->bo,
> -                             &memory_pool->mc_address,
> -                             &memory_pool->cpu_addr);
> -
> -       memset(memory_pool, 0, sizeof(struct smu_table));
> -
> -       return 0;
> -}
> -
>  static int smu_start_smc_engine(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
> @@ -1306,10 +1318,6 @@ static int smu_hw_init(void *handle)
>         if (ret)
>                 goto failed;
>
> -       ret = smu_alloc_memory_pool(smu);
> -       if (ret)
> -               goto failed;
> -
>         /*
>          * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
>          * pool location.
> @@ -1401,7 +1409,6 @@ static int smu_hw_fini(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>         struct smu_context *smu = &adev->smu;
> -       struct smu_table_context *table_context = &smu->smu_table;
>         int ret = 0;
>
>         if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
> @@ -1432,23 +1439,6 @@ static int smu_hw_fini(void *handle)
>                 return ret;
>         }
>
> -       kfree(table_context->driver_pptable);
> -       table_context->driver_pptable = NULL;
> -
> -       kfree(table_context->max_sustainable_clocks);
> -       table_context->max_sustainable_clocks = NULL;
> -
> -       kfree(table_context->overdrive_table);
> -       table_context->overdrive_table = NULL;
> -
> -       ret = smu_fini_fb_allocations(smu);
> -       if (ret)
> -               return ret;
> -
> -       ret = smu_free_memory_pool(smu);
> -       if (ret)
> -               return ret;
> -
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index d6bdd2126f72..3b22f66e3fbc 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -432,25 +432,67 @@ int smu_v11_0_init_smc_tables(struct smu_context *smu)
>         struct smu_table *tables = NULL;
>         int ret = 0;
>
> -       if (smu_table->tables)
> -               return -EINVAL;
> -
>         tables = kcalloc(SMU_TABLE_COUNT, sizeof(struct smu_table),
>                          GFP_KERNEL);
> -       if (!tables)
> -               return -ENOMEM;
> -
> +       if (!tables) {
> +               ret = -ENOMEM;
> +               goto err0_out;
> +       }
>         smu_table->tables = tables;
>
>         ret = smu_tables_init(smu, tables);
>         if (ret)
> -               return ret;
> +               goto err1_out;
>
>         ret = smu_v11_0_init_dpm_context(smu);
>         if (ret)
> -               return ret;
> +               goto err1_out;
> +
> +       smu_table->driver_pptable =
> +               kzalloc(tables[SMU_TABLE_PPTABLE].size, GFP_KERNEL);
> +       if (!smu_table->driver_pptable) {
> +               ret = -ENOMEM;
> +               goto err2_out;
> +       }
> +
> +       smu_table->max_sustainable_clocks =
> +               kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks), GFP_KERNEL);
> +       if (!smu_table->max_sustainable_clocks) {
> +               ret = -ENOMEM;
> +               goto err3_out;
> +       }
> +
> +       /* Arcturus does not support OVERDRIVE */
> +       if (tables[SMU_TABLE_OVERDRIVE].size) {
> +               smu_table->overdrive_table =
> +                       kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
> +               if (!smu_table->overdrive_table) {
> +                       ret = -ENOMEM;
> +                       goto err4_out;
> +               }
> +
> +               smu_table->boot_overdrive_table =
> +                       kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
> +               if (!smu_table->boot_overdrive_table) {
> +                       ret = -ENOMEM;
> +                       goto err5_out;
> +               }
> +       }
>
>         return 0;
> +
> +err5_out:
> +       kfree(smu_table->overdrive_table);
> +err4_out:
> +       kfree(smu_table->max_sustainable_clocks);
> +err3_out:
> +       kfree(smu_table->driver_pptable);
> +err2_out:
> +       smu_v11_0_fini_dpm_context(smu);
> +err1_out:
> +       kfree(tables);
> +err0_out:
> +       return ret;
>  }
>
>  int smu_v11_0_fini_smc_tables(struct smu_context *smu)
> @@ -461,6 +503,17 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
>         if (!smu_table->tables)
>                 return -EINVAL;
>
> +       kfree(smu_table->boot_overdrive_table);
> +       kfree(smu_table->overdrive_table);
> +       kfree(smu_table->max_sustainable_clocks);
> +       kfree(smu_table->driver_pptable);
> +       smu_table->boot_overdrive_table = NULL;
> +       smu_table->overdrive_table = NULL;
> +       smu_table->max_sustainable_clocks = NULL;
> +       smu_table->driver_pptable = NULL;
> +       kfree(smu_table->hardcode_pptable);
> +       smu_table->hardcode_pptable = NULL;
> +
>         kfree(smu_table->tables);
>         kfree(smu_table->metrics_table);
>         kfree(smu_table->watermarks_table);
> @@ -723,18 +776,6 @@ int smu_v11_0_parse_pptable(struct smu_context *smu)
>  {
>         int ret;
>
> -       struct smu_table_context *table_context = &smu->smu_table;
> -       struct smu_table *table = &table_context->tables[SMU_TABLE_PPTABLE];
> -
> -       /* during TDR we need to free and alloc the pptable */
> -       if (table_context->driver_pptable)
> -               kfree(table_context->driver_pptable);
> -
> -       table_context->driver_pptable = kzalloc(table->size, GFP_KERNEL);
> -
> -       if (!table_context->driver_pptable)
> -               return -ENOMEM;
> -
>         ret = smu_store_powerplay_table(smu);
>         if (ret)
>                 return -EINVAL;
> @@ -975,17 +1016,10 @@ smu_v11_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
>
>  int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
>  {
> -       struct smu_11_0_max_sustainable_clocks *max_sustainable_clocks;
> +       struct smu_11_0_max_sustainable_clocks *max_sustainable_clocks =
> +                       smu->smu_table.max_sustainable_clocks;
>         int ret = 0;
>
> -       if (!smu->smu_table.max_sustainable_clocks)
> -               max_sustainable_clocks = kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks),
> -                                        GFP_KERNEL);
> -       else
> -               max_sustainable_clocks = smu->smu_table.max_sustainable_clocks;
> -
> -       smu->smu_table.max_sustainable_clocks = (void *)max_sustainable_clocks;
> -
>         max_sustainable_clocks->uclock = smu->smu_table.boot_values.uclk / 100;
>         max_sustainable_clocks->soc_clock = smu->smu_table.boot_values.socclk / 100;
>         max_sustainable_clocks->dcef_clock = smu->smu_table.boot_values.dcefclk / 100;
> @@ -1930,24 +1964,11 @@ int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize,
>         int ret = 0;
>
>         if (initialize) {
> -               if (table_context->overdrive_table) {
> -                       return -EINVAL;
> -               }
> -               table_context->overdrive_table = kzalloc(overdrive_table_size, GFP_KERNEL);
> -               if (!table_context->overdrive_table) {
> -                       return -ENOMEM;
> -               }
>                 ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
>                 if (ret) {
>                         pr_err("Failed to export overdrive table!\n");
>                         return ret;
>                 }
> -               if (!table_context->boot_overdrive_table) {
> -                       table_context->boot_overdrive_table = kmemdup(table_context->overdrive_table, overdrive_table_size, GFP_KERNEL);
> -                       if (!table_context->boot_overdrive_table) {
> -                               return -ENOMEM;
> -                       }
> -               }
>         }
>         ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, true);
>         if (ret) {
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
