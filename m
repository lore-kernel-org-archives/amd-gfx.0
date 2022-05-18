Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566F3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 17:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD8A1113EB2;
	Wed, 18 May 2022 17:58:41 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B362113EF7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 17:58:40 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-d6e29fb3d7so3711920fac.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6ELERMRaIpmuhHySx2YSWo9zl1auoeO0zCJspkCGUb8=;
 b=WztX6FXpVxtEwvPsejPooMiIoLzU5fwON21vwGO/t9GQ5IX6M+jUyx5uffisTEX1Pq
 dQYSiuFVdV10a8Sse1XFrWfWumnpbgYj67B66TlXz80YMGEKLNwgnfGa6qnaHPMeN977
 U11G1Qs9KGZqvSpcG+J8OrT4Ir2WMLItMpYG/Aobv/KjAZkdMzUpRne36BGJOvACMfbh
 f81OqNzW/bbewiK7OfmnWoafIglQyVU2EUh+6Yjv9890N62kgPYDjYt7VuuTohpsrTyJ
 J2T3YLrR/IQ+u6YbJM84I3IC2KHhdj64ULmp5LPruE+iwJ7OrB5ehHuekkZlDIrQz6Xg
 X3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ELERMRaIpmuhHySx2YSWo9zl1auoeO0zCJspkCGUb8=;
 b=Y/WYl0ohA3FLANI06+opKlmV+kfAIwIV9Np7eq/RyE6NE1qTSCuii7aKiVlACLxSYP
 Pqx4sNeHMlySuGO+S+9r7BM59WjyqErM7WO+nq5gnXk/ETDuFRpWLsG2gpIWNyYhAxGK
 QguiWu6oHA7stej62vq+2xePAokUz00BbSwqjKKBYIrzMJ8HmmXqwWtNufSHU1IxYtt+
 6Hwhw2dQAYFogqxIF0ZztyWQuU0D+0eaEoLjd5owReJs8cMwmuzNzUtAi80MIZ/Bzp53
 +ENgllLMLbQDbto6DdFzNUivZM8vlKEd16JdYLoce/erXh3KAyyUu/7j9YII9yzZVWoE
 Zdyg==
X-Gm-Message-State: AOAM531i+z8hnVdi/Dv39eqwYRgImHLRBVNwNdIVmR5A7qLDoN29lW4R
 BQiqo5vJctSICg2ERn6sOVIEwDadNqF88S+eAHQ=
X-Google-Smtp-Source: ABdhPJwLIMGVcH8SUnqAp+plnUhiQH/D9DfJg9ao0cuQSwu7T8lNFtFU+MFNDxfWDF4oY0zwWaBjr83L75Ph9eL2dNc=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr402709oap.253.1652896719840; Wed, 18 May
 2022 10:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <YoUvHGsEaMtloBXN@kili>
In-Reply-To: <YoUvHGsEaMtloBXN@kili>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 May 2022 13:58:28 -0400
Message-ID: <CADnq5_OhtcD71Ne9uqXRNSe+_Eui=DNg8tcQeL40Ymf9C_EsMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: smu_v13_0_4: delete duplicate condition
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: Tim Huang <tim.huang@amd.com>, David Airlie <airlied@linux.ie>,
 Huang Rui <ray.huang@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, Aaron Liu <aaron.liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, May 18, 2022 at 1:39 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> There is no need to check if "clock_ranges' is non-NULL.  It is checked
> already on the line before.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 62 +++++++++----------
>  1 file changed, 30 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> index 7d6ff141b43f..5a17b51aa0f9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> @@ -644,42 +644,40 @@ static int smu_v13_0_4_set_watermarks_table(struct smu_context *smu,
>         if (!table || !clock_ranges)
>                 return -EINVAL;
>
> -       if (clock_ranges) {
> -               if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
> -                       clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
> -                       return -EINVAL;
> -
> -               for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
> -                       table->WatermarkRow[WM_DCFCLK][i].MinClock =
> -                               clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
> -                       table->WatermarkRow[WM_DCFCLK][i].MaxClock =
> -                               clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
> -                       table->WatermarkRow[WM_DCFCLK][i].MinMclk =
> -                               clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
> -                       table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
> -                               clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
> -
> -                       table->WatermarkRow[WM_DCFCLK][i].WmSetting =
> -                               clock_ranges->reader_wm_sets[i].wm_inst;
> -               }
> +       if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
> +               clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
> +               return -EINVAL;
>
> -               for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
> -                       table->WatermarkRow[WM_SOCCLK][i].MinClock =
> -                               clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
> -                       table->WatermarkRow[WM_SOCCLK][i].MaxClock =
> -                               clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
> -                       table->WatermarkRow[WM_SOCCLK][i].MinMclk =
> -                               clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
> -                       table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
> -                               clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
> -
> -                       table->WatermarkRow[WM_SOCCLK][i].WmSetting =
> -                               clock_ranges->writer_wm_sets[i].wm_inst;
> -               }
> +       for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
> +               table->WatermarkRow[WM_DCFCLK][i].MinClock =
> +                       clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
> +               table->WatermarkRow[WM_DCFCLK][i].MaxClock =
> +                       clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
> +               table->WatermarkRow[WM_DCFCLK][i].MinMclk =
> +                       clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
> +               table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
> +                       clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
> +
> +               table->WatermarkRow[WM_DCFCLK][i].WmSetting =
> +                       clock_ranges->reader_wm_sets[i].wm_inst;
> +       }
>
> -               smu->watermarks_bitmap |= WATERMARKS_EXIST;
> +       for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
> +               table->WatermarkRow[WM_SOCCLK][i].MinClock =
> +                       clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
> +               table->WatermarkRow[WM_SOCCLK][i].MaxClock =
> +                       clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
> +               table->WatermarkRow[WM_SOCCLK][i].MinMclk =
> +                       clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
> +               table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
> +                       clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
> +
> +               table->WatermarkRow[WM_SOCCLK][i].WmSetting =
> +                       clock_ranges->writer_wm_sets[i].wm_inst;
>         }
>
> +       smu->watermarks_bitmap |= WATERMARKS_EXIST;
> +
>         /* pass data to smu controller */
>         if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
>              !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
> --
> 2.35.1
>
