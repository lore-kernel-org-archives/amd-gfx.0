Return-Path: <SRS0=Ppqo=2W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB73C2D0DC
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2020 14:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCFD2072C
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2020 14:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfjhYT/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCFD2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EAB489B05;
	Wed,  1 Jan 2020 14:20:26 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5338589B05
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jan 2020 14:20:25 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p17so3647901wmb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jan 2020 06:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S5Tn5ghQzl2/TW2f2u4mS1gtQvZr+f5N7n8GbD0dKvo=;
 b=MfjhYT/FP34UQljDdQ3X67hmglQnT+JGdkZniyUc/3J++UEWusYuIDZQBBV5Ci2+Gk
 9yx4CWGMmCy6fe/aL8apK6GqAoEw4RQ+QRn8bsajlVatUUfYBk738f4DOAzjzG84761G
 lutK9Dqeurj40/nGd/jrZdTpNtHzRKN8YmIVs4zE6fwEgTf3c9cs3kGt8GjVQK7trYSt
 qMBymxCHAWhNZ28e2+t41EbUCE7vaRgXfqDbHaxhIMWy+mPX4+IqurMBQeRflWFsrcZw
 +U1P7ivZdkOKnej63ir+SCLnoKL3woulJfGXviqG+Fx2/sg2xs4lbQfXKkFEQVR4w/A9
 UjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S5Tn5ghQzl2/TW2f2u4mS1gtQvZr+f5N7n8GbD0dKvo=;
 b=dOwCVTyx9haBtB/sAK9rdjxwbDHaXyBab6ZPoUD7GXQh86TLKUpzLiehi1QptxyEka
 2HrktALjKal8h8OjROS7BROPqikpeZbF18fv5AMtidO6H+Ld5h3zeN2t0hrnJrrazdLI
 ojGhfLjeVg3RKNbeoION0oI6mps5jjtiPMdiDW9dr/cDLs6uEeJ36k3W+nxo3bUfIImm
 O1rfCexX1720VpFRdFWwYbLndb81Cplk3CKLIPStBL6tjq6BL4DGMtO8+pOjGWR2VJ6z
 LvbXyz+Qiw8LnU/qRCPB8aDS9VbflpwVbYN2CJejyZ6tK7COFQHd+8A34Qnx0VoKIqg3
 YgUA==
X-Gm-Message-State: APjAAAXl3xY5ch51HcI2QSrCtTYTDl44zDkGrXt1VlUek4kgrD/PL40J
 oP2fP+0wCMWDYKYERPgiKtbSkeXoIBrleXYSkdMf5g==
X-Google-Smtp-Source: APXvYqwaG0JdrWf8m+uG5KXzOokL60Q3+lRNLZ2A94Woh1UBmwZWFL/75l9RIMqyVxf2e29ExIyAKHpFYovqr6NHfq8=
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr9573511wmq.65.1577888423924; 
 Wed, 01 Jan 2020 06:20:23 -0800 (PST)
MIME-Version: 1.0
References: <20191231024856.3557-1-evan.quan@amd.com>
In-Reply-To: <20191231024856.3557-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jan 2020 09:20:12 -0500
Message-ID: <CADnq5_OkN9_PCeNe34mv5eJmzFtB+vuv6soKpEKfhJ9YtJxJWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: cache the watermark settings on
 system memory
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
> So that we do not need to allocate a piece of VRAM for it. This
> is a preparation for coming change which unifies the VRAM address
> for all driver tables interaction with SMU.
>
> Change-Id: I967f960a10a19957ea7301aa40a8ced0c036ad68
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 21 +++++++++----------
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  4 ++++
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  4 ++++
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  2 ++
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  4 ++++
>  6 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index f9bf69cd72a5..09e16183a769 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1899,26 +1899,25 @@ int smu_set_df_cstate(struct smu_context *smu,
>
>  int smu_write_watermarks_table(struct smu_context *smu)
>  {
> -       int ret = 0;
> -       struct smu_table_context *smu_table = &smu->smu_table;
> -       struct smu_table *table = NULL;
> -
> -       table = &smu_table->tables[SMU_TABLE_WATERMARKS];
> +       void *watermarks_table = smu->smu_table.watermarks_table;
>
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
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 541cfde289ea..30da8328d1bc 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -254,6 +254,7 @@ struct smu_table_context
>         unsigned long                   metrics_time;
>         void                            *metrics_table;
>         void                            *clocks_table;
> +       void                            *watermarks_table;
>
>         void                            *max_sustainable_clocks;
>         struct smu_bios_boot_up_values  boot_values;
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index e7ab8caee222..3387f3243a01 100644
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
> index e73644beffd9..506cc6bf4bc0 100644
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
> index a85826471d82..6fb93eb6ab39 100644
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
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 534c46bc0146..27bdcdeb08d9 100644
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
