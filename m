Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C15C369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 13:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FDB810E25A;
	Mon, 21 Apr 2025 13:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SP68Fqg7";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503E410E25A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 13:36:10 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2ff6b9a7f91so482500a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745242570; x=1745847370; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vhBdLmr8lMgsthreUTJBDoyk8cJxyziPkPXkloF31I=;
 b=SP68Fqg7+IyaJoXeKgT0VJfF5tHD6D/puGB3md0unY4xO0a/gZQ71DkKTca5znDnh1
 z1fUJ5ZgvGbrnsCugWPWTcRcwoebn4k/xPRzkVpYz8lmTH2KurQDUkPXhn2hkfFByNtY
 OJTIMx3lpGjeky0w9ZZ5DMcRZw8DMX4xLeitjeef7XCzMh0sMNTl6DoM7yz/dJeS0G6z
 u4eTALZMUmldY31wYqzduYvi+VFIf3zTelhdmwyJPDSr5G7fZcZAr96zfWnbe3AlxduB
 nGSy0QORevm1rRj3urThzmaV3nHIjvTNejtjiAdBY2D5eeKoQg9TODbPxfklvgn8ljL4
 cNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745242570; x=1745847370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vhBdLmr8lMgsthreUTJBDoyk8cJxyziPkPXkloF31I=;
 b=pxLLMaWUavO6ArxTFjyOu+sqr3aDdH/qh7GViI3yyXbuAE4Lt9RieNVNW3M51WrnS6
 8BqKEs9AuxJvk+vpS6n1qe6gI+vVYOqVvmqCcurOthp6pu9ArqwjNm6c9tEqM4l5biN7
 6VVncsEVYdVzK8MJ7S4dRuSk5EhIq7FSSMtL02ATgbZGOptAOzB95BmAsJwmuH+5x0t7
 MEKZBwHWakuj219VdezRs6zG6AF9sesuQt0PQtSbnIHYK70B1G+TfDEHXgsvBbRR2JCr
 +h5dJNI0yzHOEddVN+XhLBrJL0ZRKveo9m/ZRES+dSjlIo87aFlkLJ75yrN5bwXG+t6h
 RBfg==
X-Gm-Message-State: AOJu0YxDEO2z5z00dmLxJSGODofnx0DShVAl45iew+8s+BW8WG0kliYc
 LMxvVOpfEDGy8sErY+mHJLw5G1eTgYpuNPtYB++g7wRmDa+X6unHaGwqKeXy7k2ZYm3sVpUdsQR
 k7huBMlvJvf3JieEIQ20gLuiXGbMq0A==
X-Gm-Gg: ASbGnctno5BZfCzdecf4F5zqMp+2wuborNo3Hk8Nf+/pkfSsj0KwSe+Wl33hg20kBRy
 QHRpyXE+/HnmbOPDDyc1TeEfMXnOnr0FXmZL1MSBycQSQcqhpKxTFw0CQ6qkcEuTr/SnUu4QB1k
 eedNgIuSDPd5jn4pZ10gq43tetXoSnzbOL
X-Google-Smtp-Source: AGHT+IF+MUcdzQNLKp1gDSKdlfIj2g5abK7Po0clH3vbTGUVf33+hxA1B5a4igQ6ZDnqUWpC1bIO9L5x9cbS/c2B6/U=
X-Received: by 2002:a17:90b:1a8d:b0:305:5f2c:c580 with SMTP id
 98e67ed59e1d1-3087bb400c1mr6818321a91.2.1745242570119; Mon, 21 Apr 2025
 06:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250421120149.889243-1-lijo.lazar@amd.com>
In-Reply-To: <20250421120149.889243-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Apr 2025 09:35:58 -0400
X-Gm-Features: ATxdqUF7pRs55LgaMnutKulqIVholDxP7gEk3m3r2J6aHyY6q7ObaDaNkXRmEXg
Message-ID: <CADnq5_Nd7aYocqH9=dF_5iX1C2rbaXEwBsC_RUaK8QZseBGirQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Reset SMU v13.0.x custom settings
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com
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

On Mon, Apr 21, 2025 at 8:13=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> On SMU v13.0.2 and SMU v13.0.6 variants user may choose custom min/max
> clocks in manual perf mode. Those custom min/max values need to be
> reset once user switches to auto or restores default settings.
> Otherwise, they may get used inadvertently during the next operation.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h        |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c  | 13 +++++++++++--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c      | 10 ++++++++++
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    |  4 ++--
>  4 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_v13_0.h
> index cd03caffe317..21589c4583e6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -310,6 +310,7 @@ int smu_v13_0_get_boot_freq_by_index(struct smu_conte=
xt *smu,
>                                      uint32_t *value);
>
>  void smu_v13_0_interrupt_work(struct smu_context *smu);
> +void smu_v13_0_reset_custom_level(struct smu_context *smu);
>  bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
>  int smu_v13_0_12_get_max_metrics_size(void);
>  int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 83163d7c7f00..5cb3b9bb6089 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1270,6 +1270,7 @@ static int aldebaran_set_performance_level(struct s=
mu_context *smu,
>         struct smu_13_0_dpm_table *gfx_table =3D
>                 &dpm_context->dpm_tables.gfx_table;
>         struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
> +       int r;
>
>         /* Disable determinism if switching to another mode */
>         if ((smu_dpm->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMIN=
ISM) &&
> @@ -1282,7 +1283,11 @@ static int aldebaran_set_performance_level(struct =
smu_context *smu,
>
>         case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
>                 return 0;
> -
> +       case AMD_DPM_FORCED_LEVEL_AUTO:
> +               r =3D smu_v13_0_set_performance_level(smu, level);
> +               if (!r)
> +                       smu_v13_0_reset_custom_level(smu);
> +               return r;
>         case AMD_DPM_FORCED_LEVEL_HIGH:
>         case AMD_DPM_FORCED_LEVEL_LOW:
>         case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> @@ -1423,7 +1428,11 @@ static int aldebaran_usr_edit_dpm_table(struct smu=
_context *smu, enum PP_OD_DPM_
>                         min_clk =3D dpm_context->dpm_tables.gfx_table.min=
;
>                         max_clk =3D dpm_context->dpm_tables.gfx_table.max=
;
>
> -                       return aldebaran_set_soft_freq_limited_range(smu,=
 SMU_GFXCLK, min_clk, max_clk, false);
> +                       ret =3D aldebaran_set_soft_freq_limited_range(
> +                               smu, SMU_GFXCLK, min_clk, max_clk, false)=
;
> +                       if (ret)
> +                               return ret;
> +                       smu_v13_0_reset_custom_level(smu);
>                 }
>                 break;
>         case PP_OD_COMMIT_DPM_TABLE:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index ba5a9012dbd5..075f381ad311 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2595,3 +2595,13 @@ int smu_v13_0_set_wbrf_exclusion_ranges(struct smu=
_context *smu,
>
>         return ret;
>  }
> +
> +void smu_v13_0_reset_custom_level(struct smu_context *smu)
> +{
> +       struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
> +
> +       pstate_table->uclk_pstate.custom.min =3D 0;
> +       pstate_table->uclk_pstate.custom.max =3D 0;
> +       pstate_table->gfxclk_pstate.custom.min =3D 0;
> +       pstate_table->gfxclk_pstate.custom.max =3D 0;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 05969b98e9f0..39a7fdf67d6b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1938,7 +1938,7 @@ static int smu_v13_0_6_set_performance_level(struct=
 smu_context *smu,
>                                 return ret;
>                         pstate_table->uclk_pstate.curr.max =3D uclk_table=
->max;
>                 }
> -               pstate_table->uclk_pstate.custom.max =3D 0;
> +               smu_v13_0_reset_custom_level(smu);
>
>                 return 0;
>         case AMD_DPM_FORCED_LEVEL_MANUAL:
> @@ -2151,7 +2151,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct sm=
u_context *smu,
>                                 smu, SMU_UCLK, min_clk, max_clk, false);
>                         if (ret)
>                                 return ret;
> -                       pstate_table->uclk_pstate.custom.max =3D 0;
> +                       smu_v13_0_reset_custom_level(smu);
>                 }
>                 break;
>         case PP_OD_COMMIT_DPM_TABLE:
> --
> 2.25.1
>
