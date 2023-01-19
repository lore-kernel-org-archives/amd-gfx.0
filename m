Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A576FC004D4
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 14:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3037110E963;
	Thu, 19 Jan 2023 14:45:58 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5352510E963
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 14:45:56 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 n24-20020a0568301e9800b006865671a9d5so1319316otr.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 06:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F3+w5d+ftCThhFkJ82oBPI0g3fUzjsjquOnT18rFSFA=;
 b=nIvjgsk6/sbXqg+30qpUuqT+4Hc+aiF40g+Th9YkEmA8wTSE166tABQJYb+2ihThBm
 aojOPVeOwDsXdd+PwJ1L3xqSNjmi16eqoL3EwH5EcHzcJfqfSyvZ7Yybv1BZI5TB2yEV
 LqI1SuTEA88/QP1BTAmcBu8aSCRno81F2ypQ9e9IiKhIq2M7O+LgEKk95ezxJPardGOO
 uPO7wD5FTtoejNxOTJqQ1Zp4gYKuEzZ/2wIl/2PNeN2/PpssjTvTyhnFaaqMRmk41uyc
 d58zkn+zyZGjI/78p0YR3tHwpHZ+c+FsPgUmRTdoZ5BnCgzCaEdUmdNIDBFlRYRW4ecL
 VnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F3+w5d+ftCThhFkJ82oBPI0g3fUzjsjquOnT18rFSFA=;
 b=AUesxfZjQ2GMXwU05SjBs/io3y7QVkYMRHQ0VhOZi85z58bqvHIrTnWw2NBOmtbukR
 G8xkJm7QwHCbptbluScdqdtL1AWJvNH+2klzp3BwIoKoXuEOTIq2r6mVAU7ZlXWC+77V
 s814FUYIkT55BsvGme6/L49qXa+qvb7c+QmuQZel+OvHjcCd0HsGa9IwuW7KyMKkgMa4
 kM5Nl6Otu2QPbnjreSrfsqH6WvOs3MM9TaHVLoWLSPucGeJ53SbNs1JfkuBCw/lh3Ffx
 eq+lIGCaM46yfn1SjLkKqBtUTryOonX0JTfbSsTMEGPyIOzD4O6foF/IC2u5dchRcu0z
 V6Ow==
X-Gm-Message-State: AFqh2kohpoLnTQ2m8WOF0DUusqV7mW9KcYGdyhcKP/lYFfORJTOpDceX
 JUyhaiao8U5Ww9JOLLZUsEveGqq+9OuMTd3rZCY=
X-Google-Smtp-Source: AMrXdXse8yh0tozoLyt95iaayRttNWXW8eYwAebi/C/3zu39Im0MSXBEuknenNZltfNlnU5xVq0UI2cd6lrqEwj6Fms=
X-Received: by 2002:a05:6830:449:b0:684:bedc:4f54 with SMTP id
 d9-20020a056830044900b00684bedc4f54mr598802otc.233.1674139555555; Thu, 19 Jan
 2023 06:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20230119131602.1247923-1-lijo.lazar@amd.com>
In-Reply-To: <20230119131602.1247923-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Jan 2023 09:45:44 -0500
Message-ID: <CADnq5_NufJo3c1M-kPwpCBLxsBV6qWOABJDQCvSOP9X5PHYqhA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Allocate dummy table only if needed
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 19, 2023 at 8:16 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>
> Only Navi1x requires dummy read workaround. Allocate the table in VRAM
> only for Navi1x.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 5 ++---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 6 ++++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ec52830dde24..612f62529575 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -904,9 +904,8 @@ static int smu_alloc_dummy_read_table(struct smu_context *smu)
>         struct amdgpu_device *adev = smu->adev;
>         int ret = 0;
>
> -       dummy_read_1_table->size = 0x40000;
> -       dummy_read_1_table->align = PAGE_SIZE;
> -       dummy_read_1_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
> +       if (!dummy_read_1_table->size)
> +               return 0;
>
>         ret = amdgpu_bo_create_kernel(adev,
>                                       dummy_read_1_table->size,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 0bcd4fe0ef17..95da6dd1cc65 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -494,6 +494,8 @@ static int navi10_tables_init(struct smu_context *smu)
>  {
>         struct smu_table_context *smu_table = &smu->smu_table;
>         struct smu_table *tables = smu_table->tables;
> +       struct smu_table *dummy_read_1_table =
> +                       &smu_table->dummy_read_1_table;
>
>         SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
>                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> @@ -513,6 +515,10 @@ static int navi10_tables_init(struct smu_context *smu)
>         SMU_TABLE_INIT(tables, SMU_TABLE_DRIVER_SMU_CONFIG, sizeof(DriverSmuConfig_t),
>                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>
> +       dummy_read_1_table->size = 0x40000;
> +       dummy_read_1_table->align = PAGE_SIZE;
> +       dummy_read_1_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
> +
>         smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_NV1X_t),
>                                            GFP_KERNEL);
>         if (!smu_table->metrics_table)
> --
> 2.25.1
>
