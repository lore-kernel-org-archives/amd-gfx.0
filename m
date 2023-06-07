Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9046AC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 15:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB7F10E1A4;
	Wed,  7 Jun 2023 15:59:33 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5D110E1A4
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 15:59:31 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3909756b8b1so2970352b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Jun 2023 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686153570; x=1688745570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31Iv/Eys9075DRtvuaFcper8WxNVfprSD4DZoxGqUOg=;
 b=UoXJmTkuuQad5n7mXnVXqvsVZJINXpZW8Sq8sMGgFGXu5lpc1ssJm874J84AuxL5bt
 iL4Iz9+9bzh0mI7ErEt/qKv3pVwVQslUFHylKVzCd4w/1YOE+vjw53PFzgNGrmFh9/dO
 k+x9q8va1O2SSU5+uFVgg6FrlaKKwh4kZbsF7ANnY6N9ejYF9T6qmSGHJYWcJPHsrwiw
 oUq27wLpYRhCMUsGJPSTpHlB+gJdmCcsLf2NkrG9Qh0ZJV292tDtZ/ba6DqnPJu6Sg4r
 TQS5c2kJTHfJFcwg6sAyvKf+gAyN5b19grTrQ75VFcJrnPFaKKQ6Dmzgdii8FxYeZDJZ
 YsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686153570; x=1688745570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31Iv/Eys9075DRtvuaFcper8WxNVfprSD4DZoxGqUOg=;
 b=gY+3WZNhXPdgRZKWfHP4xfUMNghBO1drkiM6MEF/bl4OFFF9ZOjDrymEhvXleAZifS
 rRYSqWbGllmhQ3RwHhqFUnr8lF6Th1M0h6/+rF3NqBqGKpQNJycWKKXsoScsTleRt5WA
 TW7fwehcGZcHfyKJApheh9zs+0Vj8f8ciCQLtbp4cslUxkppc7gMredTQU/Blw8NAHbD
 dw8MEW5ScDLN8YDYKsXTZjm5k86F8GIDEVW7IjsyY207eu2ThFpLuV5/NthW/2CKrsKN
 i57USMgqNvFngF6Z/3TI6lxmhOg6mU+KqypBhQTeSYfOQKaQ7PGr7eQJgGFekJSOGLwE
 XHbw==
X-Gm-Message-State: AC+VfDzxyxYwM4CNplLh0C4sPXDu4lCGTujVJJkA8Jk0Y1mozXkElDvn
 MzMXHxIP1h1rchPFvxUNoIPvswYZfa5/JaX0WTsdF/Pi
X-Google-Smtp-Source: ACHHUZ7va/1HYtdi8pDHB+AdT3rcEDr7wBOaGXB1/W66CknPTZl14snC1QwBkL1KVfHZijjA1KWKWSpPewmavTQbXoI=
X-Received: by 2002:aca:1908:0:b0:395:eed6:5193 with SMTP id
 l8-20020aca1908000000b00395eed65193mr2251197oii.10.1686153570435; Wed, 07 Jun
 2023 08:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230607110747.1769721-1-shikai.guo@amd.com>
In-Reply-To: <20230607110747.1769721-1-shikai.guo@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Jun 2023 11:59:19 -0400
Message-ID: <CADnq5_Mi_E3Oj5_cbEhM4OU6YG2Upk39R1pyv1VHKtO=fpCt+w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: enable more Pstates profile levels for
 yellow_carp
To: shikaguo <shikai.guo@amd.com>
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
Cc: tim.huang@amd.com, prike.liang@amd.com, aaron.liu@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jun 7, 2023 at 7:09=E2=80=AFAM shikaguo <shikai.guo@amd.com> wrote:
>
> This patch enables following UMD stable Pstates profile levels for power_=
dpm_force_performance_level interface.
>
> - profile_peak
> - profile_min_mclk
> - profile_min_sclk
> - profile_standard
>
> Signed-off-by: shikaguo <shikai.guo@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 94 ++++++++++++++++++-
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |  8 +-
>  2 files changed, 98 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index a92da336ecec..5c968ab2ea8d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -957,6 +957,9 @@ static int yellow_carp_set_soft_freq_limited_range(st=
ruct smu_context *smu,
>                                                         uint32_t max)
>  {
>         enum smu_message_type msg_set_min, msg_set_max;
> +       uint32_t min_clk =3D min;
> +       uint32_t max_clk =3D max;
> +
>         int ret =3D 0;
>
>         if (!yellow_carp_clk_dpm_is_enabled(smu, clk_type))
> @@ -985,11 +988,17 @@ static int yellow_carp_set_soft_freq_limited_range(=
struct smu_context *smu,
>                 return -EINVAL;
>         }
>
> -       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NU=
LL);
> +       if (clk_type =3D=3D SMU_VCLK) {
> +               min_clk =3D min << SMU_13_VCLK_SHIFT;
> +               max_clk =3D max << SMU_13_VCLK_SHIFT;
> +       }
> +
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min_clk=
, NULL);
> +
>         if (ret)
>                 goto out;
>
> -       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NU=
LL);
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max_clk=
, NULL);
>         if (ret)
>                 goto out;
>
> @@ -1107,6 +1116,50 @@ static int yellow_carp_force_clk_levels(struct smu=
_context *smu,
>         return ret;
>  }
>
> +static int yellow_carp_get_dpm_profile_freq(struct smu_context *smu,
> +                                       enum amd_dpm_forced_level level,
> +                                       enum smu_clk_type clk_type,
> +                                       uint32_t *min_clk,
> +                                       uint32_t *max_clk)
> +{
> +       int ret =3D 0;
> +       uint32_t clk_limit =3D 0;
> +
> +       switch (clk_type) {
> +       case SMU_GFXCLK:
> +       case SMU_SCLK:
> +               clk_limit =3D YELLOW_CARP_UMD_PSTATE_GFXCLK;
> +               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, =
NULL, &clk_limit);
> +               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SC=
LK)
> +                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, =
&clk_limit, NULL);
> +               break;
> +       case SMU_SOCCLK:
> +               clk_limit =3D YELLOW_CARP_UMD_PSTATE_SOCCLK;
> +               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK=
, NULL, &clk_limit);
> +               break;
> +       case SMU_FCLK:
> +               clk_limit =3D YELLOW_CARP_UMD_PSTATE_FCLK;
> +               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, =
NULL, &clk_limit);
> +               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MC=
LK)
> +                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, =
&clk_limit, NULL);
> +               break;
> +       case SMU_VCLK:
> +               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &c=
lk_limit);
> +               break;
> +       case SMU_DCLK:
> +               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &c=
lk_limit);
> +               break;
> +       default:
> +               ret =3D -EINVAL;
> +               break;
> +       }
> +       *min_clk =3D *max_clk =3D clk_limit;
> +       return ret;
> +}
> +
>  static int yellow_carp_set_performance_level(struct smu_context *smu,
>                                                 enum amd_dpm_forced_level=
 level)
>  {
> @@ -1114,6 +1167,9 @@ static int yellow_carp_set_performance_level(struct=
 smu_context *smu,
>         uint32_t sclk_min =3D 0, sclk_max =3D 0;
>         uint32_t fclk_min =3D 0, fclk_max =3D 0;
>         uint32_t socclk_min =3D 0, socclk_max =3D 0;
> +       uint32_t vclk_min =3D 0, vclk_max =3D 0;
> +       uint32_t dclk_min =3D 0, dclk_max =3D 0;
> +
>         int ret =3D 0;
>
>         switch (level) {
> @@ -1121,28 +1177,42 @@ static int yellow_carp_set_performance_level(stru=
ct smu_context *smu,
>                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &s=
clk_max);
>                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &f=
clk_max);
>                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, =
&socclk_max);
> +               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &v=
clk_max);
> +               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &d=
clk_max);
>                 sclk_min =3D sclk_max;
>                 fclk_min =3D fclk_max;
>                 socclk_min =3D socclk_max;
> +               vclk_min =3D vclk_max;
> +               dclk_min =3D dclk_max;
>                 break;
>         case AMD_DPM_FORCED_LEVEL_LOW:
>                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_mi=
n, NULL);
>                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_mi=
n, NULL);
>                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &soccl=
k_min, NULL);
> +               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_mi=
n, NULL);
> +               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_mi=
n, NULL);
>                 sclk_max =3D sclk_min;
>                 fclk_max =3D fclk_min;
>                 socclk_max =3D socclk_min;
> +               vclk_max =3D vclk_min;
> +               dclk_max =3D dclk_min;
>                 break;
>         case AMD_DPM_FORCED_LEVEL_AUTO:
>                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_mi=
n, &sclk_max);
>                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_mi=
n, &fclk_max);
>                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &soccl=
k_min, &socclk_max);
> +               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_mi=
n, &vclk_max);
> +               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_mi=
n, &dclk_max);
>                 break;
>         case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
>         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
>         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
>         case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> -               /* Temporarily do nothing since the optimal clocks haven'=
t been provided yet */
> +               yellow_carp_get_dpm_profile_freq(smu, level, SMU_SCLK, &s=
clk_min, &sclk_max);
> +               yellow_carp_get_dpm_profile_freq(smu, level, SMU_FCLK, &f=
clk_min, &fclk_max);
> +               yellow_carp_get_dpm_profile_freq(smu, level, SMU_SOCCLK, =
&socclk_min, &socclk_max);
> +               yellow_carp_get_dpm_profile_freq(smu, level, SMU_VCLK, &v=
clk_min, &vclk_max);
> +               yellow_carp_get_dpm_profile_freq(smu, level, SMU_DCLK, &d=
clk_min, &dclk_max);
>                 break;
>         case AMD_DPM_FORCED_LEVEL_MANUAL:
>         case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> @@ -1182,6 +1252,24 @@ static int yellow_carp_set_performance_level(struc=
t smu_context *smu,
>                         return ret;
>         }
>
> +       if (vclk_min && vclk_max) {
> +               ret =3D yellow_carp_set_soft_freq_limited_range(smu,
> +                                                             SMU_VCLK,
> +                                                             vclk_min,
> +                                                             vclk_max);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (dclk_min && dclk_max) {
> +               ret =3D yellow_carp_set_soft_freq_limited_range(smu,
> +                                                             SMU_DCLK,
> +                                                             dclk_min,
> +                                                             dclk_max);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
> index a9205a8ea3ad..59257bbd66e0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
> @@ -24,6 +24,12 @@
>  #define __YELLOW_CARP_PPT_H__
>
>  extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);
> -#define YELLOW_CARP_UMD_PSTATE_GFXCLK       1100
> +
> +#define SMU_13_VCLK_SHIFT              16
> +
> +//UMD PState Rembrandt Msg Parameters in MHz
> +#define YELLOW_CARP_UMD_PSTATE_GFXCLK       700
> +#define YELLOW_CARP_UMD_PSTATE_SOCCLK          678
> +#define YELLOW_CARP_UMD_PSTATE_FCLK                    800
>
>  #endif
> --
> 2.25.1
>
