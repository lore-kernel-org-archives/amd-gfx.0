Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4805C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 13:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A05910FECF;
	Mon, 29 Apr 2024 13:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WZR4sEI9";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8970E10FECF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 13:45:54 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ae913878b0so3340357a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714398354; x=1715003154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXGu5F0VicVFjB2SGdGRetnrOmer+09Fhq5Gpw+1rSU=;
 b=WZR4sEI9HYWlHeiW0mdxVYp1m/6rLFmzP3mMVPgWgok17J8v+3JKqFzMbzeOVMUEGt
 B1QnQkZ9fUhHD7wxxbYNhPLZWIWwrBzUJfutH7aHnb84rYXwPRRkYNb3arkQ12mw452Y
 65vI7nH3F3p5HE+OU7e4xMBKEX6wEJxt9qCwkeLT/zM5vtPkxTEXtXzEyy22pffEC93D
 uZ6Okrj3tuWJ2JVTVaQcHNyTQ76L/zlqwbuedFfUb/7rdWId9F8yGp+Ullfj8Fv8Yi+O
 0p8aSPvoH9W54MqLmc7XLQd3rnUy7NutYVlLdrK78iQlSJnW0BXl7jamjRZGD5jhwSew
 b8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714398354; x=1715003154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXGu5F0VicVFjB2SGdGRetnrOmer+09Fhq5Gpw+1rSU=;
 b=NwU4kg+WW6FlDP64KfEiJLXjQk8lcq6josmNgmmYAnCgK/bu77LI06XiphrxPy0lOx
 qw3Cofc42Kj9SSsGcF4sP582BlvwkLKzlUnRq24pm+3LNtzNHD7MesCUpS4fnbO9zqjm
 O0W+agf96ilIpy7ZVyK9SiqRCElxpgGIJp9H6XcPUN/RJsZq15t5eT+74ZUgTodlo+2N
 iytBPX9DXpGTQ2ERehnox7WKwCUxTWgrQAVs2ljp5Ldm1xVqfhN/o/7JpbS72Jt3xc72
 rPdh1WAkzvKLQsa9YMsA4/mSUDGzxMtxa4oiClwY0t+f3m3Fk8+eWMk9REZij9FPl0u7
 HKcA==
X-Gm-Message-State: AOJu0Yxr4wyF+9+0TkcT5AKPx5o65Ecb7fMbZUGhVvqmpduNZ0A1K/PK
 3gUjIVAq5RyS0QRHT1PBBZ651blj7jjoCra/jiAr5pnEOzsEOT5wsmGfQ0rVkOfY8JVAbTXHo1m
 dN7/4WfCBYBaLq7tWi7fxAa5ae9A=
X-Google-Smtp-Source: AGHT+IHWuLQzr5tRMEl1GcgpBuZ1vPO/REwRjxA7qjq5lvPSZZ9g8s/nzklwut43cR5MXksmwyxZ2ci+oPy2uvWLJQM=
X-Received: by 2002:a17:90b:1d02:b0:2b2:142d:5bba with SMTP id
 on2-20020a17090b1d0200b002b2142d5bbamr1234673pjb.17.1714398353433; Mon, 29
 Apr 2024 06:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240429074136.1704135-1-Tim.Huang@amd.com>
In-Reply-To: <20240429074136.1704135-1-Tim.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Apr 2024 09:45:41 -0400
Message-ID: <CADnq5_NEksAyKr=+KoSrPe962fZ1WE9+FeW8j3ydF+_1J8fwgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix uninitialized variable warning for smu_v13
To: Tim Huang <Tim.Huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 29, 2024 at 3:52=E2=80=AFAM Tim Huang <Tim.Huang@amd.com> wrote=
:
>
> Clear warning that using uninitialized variable when the dpm is
> not enabled and reuse the code for SMU13 to get the boot frequency.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  4 ++
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 55 +++++++++++++------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 28 +---------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 28 +---------
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 28 +---------
>  5 files changed, 51 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_v13_0.h
> index d9700a3f28d2..e58220a7ee2f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -298,5 +298,9 @@ int smu_v13_0_enable_uclk_shadow(struct smu_context *=
smu, bool enable);
>
>  int smu_v13_0_set_wbrf_exclusion_ranges(struct smu_context *smu,
>                                                  struct freq_band_range *=
exclusion_ranges);
> +
> +int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
> +                                    enum smu_clk_type clk_type,
> +                                    uint32_t *value);
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index a8d34adc7d3f..ed5a7a83c9e2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1559,22 +1559,9 @@ int smu_v13_0_get_dpm_ultimate_freq(struct smu_con=
text *smu, enum smu_clk_type c
>         uint32_t clock_limit;
>
>         if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type)) {
> -               switch (clk_type) {
> -               case SMU_MCLK:
> -               case SMU_UCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.uclk;
> -                       break;
> -               case SMU_GFXCLK:
> -               case SMU_SCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.gfxclk=
;
> -                       break;
> -               case SMU_SOCCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.socclk=
;
> -                       break;
> -               default:
> -                       clock_limit =3D 0;
> -                       break;
> -               }
> +               ret =3D smu_v13_0_get_boot_freq_by_index(smu, clk_type, &=
clock_limit);
> +               if (ret)
> +                       return ret;
>
>                 /* clock in Mhz unit */
>                 if (min)
> @@ -1894,6 +1881,40 @@ int smu_v13_0_set_power_source(struct smu_context =
*smu,
>                                                NULL);
>  }
>
> +int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
> +                                    enum smu_clk_type clk_type,
> +                                    uint32_t *value)
> +{
> +       int ret =3D 0;
> +
> +       switch (clk_type) {
> +       case SMU_MCLK:
> +       case SMU_UCLK:
> +               *value =3D smu->smu_table.boot_values.uclk;
> +               break;
> +       case SMU_FCLK:
> +               *value =3D smu->smu_table.boot_values.fclk;
> +               break;
> +       case SMU_GFXCLK:
> +       case SMU_SCLK:
> +               *value =3D smu->smu_table.boot_values.gfxclk;
> +               break;
> +       case SMU_SOCCLK:
> +               *value =3D smu->smu_table.boot_values.socclk;
> +               break;
> +       case SMU_VCLK:
> +               *value =3D smu->smu_table.boot_values.vclk;
> +               break;
> +       case SMU_DCLK:
> +               *value =3D smu->smu_table.boot_values.dclk;
> +               break;
> +       default:
> +               ret =3D -EINVAL;
> +               break;
> +       }
> +       return ret;
> +}
> +
>  int smu_v13_0_get_dpm_freq_by_index(struct smu_context *smu,
>                                     enum smu_clk_type clk_type, uint16_t =
level,
>                                     uint32_t *value)
> @@ -1905,7 +1926,7 @@ int smu_v13_0_get_dpm_freq_by_index(struct smu_cont=
ext *smu,
>                 return -EINVAL;
>
>         if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
> -               return 0;
> +               return smu_v13_0_get_boot_freq_by_index(smu, clk_type, va=
lue);
>
>         clk_id =3D smu_cmn_to_asic_specific_index(smu,
>                                                 CMN2ASIC_MAPPING_CLK,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> index 88f1a0d878f3..e283b282ec27 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> @@ -756,31 +756,9 @@ static int smu_v13_0_4_get_dpm_ultimate_freq(struct =
smu_context *smu,
>         int ret =3D 0;
>
>         if (!smu_v13_0_4_clk_dpm_is_enabled(smu, clk_type)) {
> -               switch (clk_type) {
> -               case SMU_MCLK:
> -               case SMU_UCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.uclk;
> -                       break;
> -               case SMU_FCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.fclk;
> -                       break;
> -               case SMU_GFXCLK:
> -               case SMU_SCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.gfxclk=
;
> -                       break;
> -               case SMU_SOCCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.socclk=
;
> -                       break;
> -               case SMU_VCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.vclk;
> -                       break;
> -               case SMU_DCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.dclk;
> -                       break;
> -               default:
> -                       clock_limit =3D 0;
> -                       break;
> -               }
> +               ret =3D smu_v13_0_get_boot_freq_by_index(smu, clk_type, &=
clock_limit);
> +               if (ret)
> +                       return ret;
>
>                 /* clock in Mhz unit */
>                 if (min)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> index 218f209c3775..59854465d711 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> @@ -733,31 +733,9 @@ static int smu_v13_0_5_get_dpm_ultimate_freq(struct =
smu_context *smu,
>         int ret =3D 0;
>
>         if (!smu_v13_0_5_clk_dpm_is_enabled(smu, clk_type)) {
> -               switch (clk_type) {
> -               case SMU_MCLK:
> -               case SMU_UCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.uclk;
> -                       break;
> -               case SMU_FCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.fclk;
> -                       break;
> -               case SMU_GFXCLK:
> -               case SMU_SCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.gfxclk=
;
> -                       break;
> -               case SMU_SOCCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.socclk=
;
> -                       break;
> -               case SMU_VCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.vclk;
> -                       break;
> -               case SMU_DCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.dclk;
> -                       break;
> -               default:
> -                       clock_limit =3D 0;
> -                       break;
> -               }
> +               ret =3D smu_v13_0_get_boot_freq_by_index(smu, clk_type, &=
clock_limit);
> +               if (ret)
> +                       return ret;
>
>                 /* clock in Mhz unit */
>                 if (min)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index d8bcf765a803..5917c88cc87d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -867,31 +867,9 @@ static int yellow_carp_get_dpm_ultimate_freq(struct =
smu_context *smu,
>         int ret =3D 0;
>
>         if (!yellow_carp_clk_dpm_is_enabled(smu, clk_type)) {
> -               switch (clk_type) {
> -               case SMU_MCLK:
> -               case SMU_UCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.uclk;
> -                       break;
> -               case SMU_FCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.fclk;
> -                       break;
> -               case SMU_GFXCLK:
> -               case SMU_SCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.gfxclk=
;
> -                       break;
> -               case SMU_SOCCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.socclk=
;
> -                       break;
> -               case SMU_VCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.vclk;
> -                       break;
> -               case SMU_DCLK:
> -                       clock_limit =3D smu->smu_table.boot_values.dclk;
> -                       break;
> -               default:
> -                       clock_limit =3D 0;
> -                       break;
> -               }
> +               ret =3D smu_v13_0_get_boot_freq_by_index(smu, clk_type, &=
clock_limit);
> +               if (ret)
> +                       return ret;
>
>                 /* clock in Mhz unit */
>                 if (min)
> --
> 2.39.2
>
