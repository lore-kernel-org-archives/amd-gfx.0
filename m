Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E50C35FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 15:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9882F10E428;
	Mon, 17 Mar 2025 15:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NMerF5qm";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EA210E426
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 15:04:59 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ff73032ac0so473644a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742223898; x=1742828698; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LqPgor3/uB5PnP3v6CC4NRGE2ybRBwX3GrQiDYKuVwI=;
 b=NMerF5qmZV6mqin3hJfXiBHrAiizFPGYgEImdGTknyR/IiwUByWn3cvfXI2B767htb
 qEBEZjoMkhY6yhZv3Ejmus8FTDxHPjBl+ZdyaE8DcYwU8xO+FoZKjWXKeXCe6ujPy1JV
 ivCEQPYtuj+j1j07nIYxpSHDD80OAD6u1bfEC1qGXOvl8+JHY6buBA5NTloQlJaQQvYC
 /9N7Sm9/quXC5zJDOL2WltrTmYlAOCAnWuav8YRk0dW/3R4PNq7BjVqwpH0rV1QukmSA
 bFrY0fwh2HJ+yGMIyKhYupp/gS49YaVnAxHCFh4ogGCrgapn7Y9XLWY6aTYTu4y7hAQK
 z6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742223898; x=1742828698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqPgor3/uB5PnP3v6CC4NRGE2ybRBwX3GrQiDYKuVwI=;
 b=DkRE75c7eivNsUTDfDBDC4e+8KIYlAKTXeUjYV5SBiqBDhgCazaB8Hz23o66kpN7rz
 zhWlv40QPyAn2D/qd0U2aWHvdmYgOoJYjoDZCp69Rj7ozypy6fLhGsyi2z1W40ikaCt0
 dNMH3V/YNy1Oyf8zo7kXWwq14xF9nV455pu4wTS2qng+2RotpRtvkfbn2O7vc8boRVBc
 IgtHz0FXb/wPrlECXlcaKuz++81hY61vqeHUufSF5vcDG7by3fWzbUW3LwtCVFX29VXX
 FB+j4Zu0SLyuED0wRA8OjcNP4r82birdGVnZs9PzEwZ+VAiiBlaNF8sbz+J6jyetIYEP
 CX7Q==
X-Gm-Message-State: AOJu0YyHszbgOOYju1WPI9p6ondyhILv3DqTRtlh5kEOEErxVxJt4w/I
 NglSvoLQcHBDiBgxyo61IDJWH+iqxaumyc6V82ycjnD6cfX3EOhlQc2A8CN1tr1N7bcvCXhvjD0
 UMBkwDHHoCjV0CDNnkf5ZGaQeC7o=
X-Gm-Gg: ASbGnctZLyFqL/vrLFwwLvQ04xvT6i+4tKv1gYMVXV8oqj8qoBje8llsw/iW90U1MAm
 Jj4OxymwjmqXEUXexS5jEn+Ma+W5L/XtQWBrD2kFn+oCj1Eodey05JMoLChV/nhEGzI40iUWVR+
 1VmA4CFxHGAmZUqejkLd7ezkzJeg==
X-Google-Smtp-Source: AGHT+IG12NuuHbKzqhBqoOBToYZHmgQ7lWq5qZPhwsgjP8RjR8jmcrwnBEY/dUPca3yCvvvXuYnP05Eg3UJzM2pIX3A=
X-Received: by 2002:a17:90b:164f:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-30151d56e87mr6025524a91.3.1742223897945; Mon, 17 Mar 2025
 08:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
 <20250317060702.5297-12-alexandre.f.demers@gmail.com>
In-Reply-To: <20250317060702.5297-12-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Mar 2025 11:04:46 -0400
X-Gm-Features: AQ5f1JoB0T9oSQXV5AL9k76b3AYIJuiPN8RXhkP4NWE2SkllZbGhJ6FhkdSjQOU
Message-ID: <CADnq5_P9JLxj+iCDuRGZy_vKf43CswYEeqccdN5WQEpcoPi8EA@mail.gmail.com>
Subject: Re: [PATCH 11/18] drm/pm/legacy-dpm: move SI away from sid.h and
 si_enums.h
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Mar 17, 2025 at 2:38=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 338 +++++++++++----------
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c |  36 +--
>  2 files changed, 190 insertions(+), 184 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index 975912f285d7..0f34aaf773b7 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -2209,7 +2209,7 @@ static u32 si_calculate_cac_wintime(struct amdgpu_d=
evice *adev)
>         if (xclk =3D=3D 0)
>                 return 0;
>
> -       cac_window =3D RREG32(CG_CAC_CTRL) & CAC_WINDOW_MASK;
> +       cac_window =3D RREG32(ixCG_CAC_CTRL) & CG_CAC_CTRL__CAC_WINDOW_MA=
SK;

This looks wrong.  The ix prefix means the register offset is an index
rather than an offset and not directly accessible.  If you are using
the ix registers they should be using an indirect register accessor.
Same comment on the other cases below.

Alex

>         cac_window_size =3D ((cac_window & 0xFFFF0000) >> 16) * (cac_wind=
ow & 0x0000FFFF);
>
>         wintime =3D (cac_window_size * 100) / xclk;
> @@ -2505,19 +2505,19 @@ static int si_populate_sq_ramping_values(struct a=
mdgpu_device *adev,
>         if (adev->pm.dpm.sq_ramping_threshold =3D=3D 0)
>                 return -EINVAL;
>
> -       if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER > (MAX_POWER_MASK >> MAX_POWE=
R_SHIFT))
> +       if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER > (SQ_POWER_THROTTLE__MAX_POW=
ER_MASK >> SQ_POWER_THROTTLE__MAX_POWER__SHIFT))
>                 enable_sq_ramping =3D false;
>
> -       if (SISLANDS_DPM2_SQ_RAMP_MIN_POWER > (MIN_POWER_MASK >> MIN_POWE=
R_SHIFT))
> +       if (SISLANDS_DPM2_SQ_RAMP_MIN_POWER > (SQ_POWER_THROTTLE__MIN_POW=
ER_MASK >> SQ_POWER_THROTTLE__MIN_POWER__SHIFT))
>                 enable_sq_ramping =3D false;
>
> -       if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER_DELTA > (MAX_POWER_DELTA_MASK=
 >> MAX_POWER_DELTA_SHIFT))
> +       if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER_DELTA > (SQ_POWER_THROTTLE2__=
MAX_POWER_DELTA_MASK >> SQ_POWER_THROTTLE2__MAX_POWER_DELTA__SHIFT))
>                 enable_sq_ramping =3D false;
>
> -       if (SISLANDS_DPM2_SQ_RAMP_STI_SIZE > (STI_SIZE_MASK >> STI_SIZE_S=
HIFT))
> +       if (SISLANDS_DPM2_SQ_RAMP_STI_SIZE > (SQ_POWER_THROTTLE2__SHORT_T=
ERM_INTERVAL_SIZE_MASK >> SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE__SHI=
FT))
>                 enable_sq_ramping =3D false;
>
> -       if (SISLANDS_DPM2_SQ_RAMP_LTI_RATIO > (LTI_RATIO_MASK >> LTI_RATI=
O_SHIFT))
> +       if (SISLANDS_DPM2_SQ_RAMP_LTI_RATIO > (SQ_POWER_THROTTLE2__LONG_T=
ERM_INTERVAL_RATIO_MASK >> SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO__SH=
IFT))
>                 enable_sq_ramping =3D false;
>
>         for (i =3D 0; i < state->performance_level_count; i++) {
> @@ -2526,14 +2526,17 @@ static int si_populate_sq_ramping_values(struct a=
mdgpu_device *adev,
>
>                 if ((state->performance_levels[i].sclk >=3D adev->pm.dpm.=
sq_ramping_threshold) &&
>                     enable_sq_ramping) {
> -                       sq_power_throttle |=3D MAX_POWER(SISLANDS_DPM2_SQ=
_RAMP_MAX_POWER);
> -                       sq_power_throttle |=3D MIN_POWER(SISLANDS_DPM2_SQ=
_RAMP_MIN_POWER);
> -                       sq_power_throttle2 |=3D MAX_POWER_DELTA(SISLANDS_=
DPM2_SQ_RAMP_MAX_POWER_DELTA);
> -                       sq_power_throttle2 |=3D STI_SIZE(SISLANDS_DPM2_SQ=
_RAMP_STI_SIZE);
> -                       sq_power_throttle2 |=3D LTI_RATIO(SISLANDS_DPM2_S=
Q_RAMP_LTI_RATIO);
> +                       sq_power_throttle |=3D SISLANDS_DPM2_SQ_RAMP_MAX_=
POWER << SQ_POWER_THROTTLE__MAX_POWER__SHIFT;
> +                       sq_power_throttle |=3D SISLANDS_DPM2_SQ_RAMP_MIN_=
POWER << SQ_POWER_THROTTLE__MIN_POWER__SHIFT;
> +                       sq_power_throttle2 |=3D SISLANDS_DPM2_SQ_RAMP_MAX=
_POWER_DELTA << SQ_POWER_THROTTLE2__MAX_POWER_DELTA__SHIFT;
> +                       sq_power_throttle2 |=3D SISLANDS_DPM2_SQ_RAMP_STI=
_SIZE << SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE__SHIFT;
> +                       sq_power_throttle2 |=3D SISLANDS_DPM2_SQ_RAMP_LTI=
_RATIO << SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO__SHIFT;
>                 } else {
> -                       sq_power_throttle |=3D MAX_POWER_MASK | MIN_POWER=
_MASK;
> -                       sq_power_throttle2 |=3D MAX_POWER_DELTA_MASK | ST=
I_SIZE_MASK | LTI_RATIO_MASK;
> +                       sq_power_throttle |=3D SQ_POWER_THROTTLE__MAX_POW=
ER_MASK |
> +                                                               SQ_POWER_=
THROTTLE__MIN_POWER_MASK;
> +                       sq_power_throttle2 |=3D SQ_POWER_THROTTLE2__MAX_P=
OWER_DELTA_MASK |
> +                                                               SQ_POWER_=
THROTTLE2__SHORT_TERM_INTERVAL_SIZE_MASK |
> +                                                               SQ_POWER_=
THROTTLE2__LONG_TERM_INTERVAL_RATIO_MASK;
>                 }
>
>                 smc_state->levels[i].SQPowerThrottle =3D cpu_to_be32(sq_p=
ower_throttle);
> @@ -2777,9 +2780,9 @@ static int si_initialize_smc_cac_tables(struct amdg=
pu_device *adev)
>         if (!cac_tables)
>                 return -ENOMEM;
>
> -       reg =3D RREG32(CG_CAC_CTRL) & ~CAC_WINDOW_MASK;
> -       reg |=3D CAC_WINDOW(si_pi->powertune_data->cac_window);
> -       WREG32(CG_CAC_CTRL, reg);
> +       reg =3D RREG32(ixCG_CAC_CTRL) & ~CG_CAC_CTRL__CAC_WINDOW_MASK;
> +       reg |=3D (si_pi->powertune_data->cac_window << CG_CAC_CTRL__CAC_W=
INDOW__SHIFT);
> +       WREG32(ixCG_CAC_CTRL, reg);
>
>         si_pi->dyn_powertune_data.cac_leakage =3D adev->pm.dpm.cac_leakag=
e;
>         si_pi->dyn_powertune_data.dc_pwr_value =3D
> @@ -2978,10 +2981,10 @@ static int si_init_smc_spll_table(struct amdgpu_d=
evice *adev)
>                 ret =3D si_calculate_sclk_params(adev, sclk, &sclk_params=
);
>                 if (ret)
>                         break;
> -               p_div =3D (sclk_params.vCG_SPLL_FUNC_CNTL & SPLL_PDIV_A_M=
ASK) >> SPLL_PDIV_A_SHIFT;
> -               fb_div =3D (sclk_params.vCG_SPLL_FUNC_CNTL_3 & SPLL_FB_DI=
V_MASK) >> SPLL_FB_DIV_SHIFT;
> -               clk_s =3D (sclk_params.vCG_SPLL_SPREAD_SPECTRUM & CLK_S_M=
ASK) >> CLK_S_SHIFT;
> -               clk_v =3D (sclk_params.vCG_SPLL_SPREAD_SPECTRUM_2 & CLK_V=
_MASK) >> CLK_V_SHIFT;
> +               p_div =3D (sclk_params.vCG_SPLL_FUNC_CNTL & CG_SPLL_FUNC_=
CNTL__SPLL_PDIV_A_MASK) >> CG_SPLL_FUNC_CNTL__SPLL_PDIV_A__SHIFT;
> +               fb_div =3D (sclk_params.vCG_SPLL_FUNC_CNTL_3 & CG_SPLL_FU=
NC_CNTL_3__SPLL_FB_DIV_MASK) >> CG_SPLL_FUNC_CNTL_3__SPLL_FB_DIV__SHIFT;
> +               clk_s =3D (sclk_params.vCG_SPLL_SPREAD_SPECTRUM & CG_SPLL=
_SPREAD_SPECTRUM__CLK_S_MASK) >> CG_SPLL_SPREAD_SPECTRUM__CLK_S__SHIFT;
> +               clk_v =3D (sclk_params.vCG_SPLL_SPREAD_SPECTRUM_2 & CG_SP=
LL_SPREAD_SPECTRUM_2__CLK_V_MASK) >> CG_SPLL_SPREAD_SPECTRUM_2__CLK_V__SHIF=
T;
>
>                 fb_div &=3D ~0x00001FFF;
>                 fb_div >>=3D 1;
> @@ -3685,10 +3688,10 @@ static bool si_is_special_1gb_platform(struct amd=
gpu_device *adev)
>         WREG32(MC_SEQ_IO_DEBUG_INDEX, 0xb);
>         width =3D ((RREG32(MC_SEQ_IO_DEBUG_DATA) >> 1) & 1) ? 16 : 32;
>
> -       tmp =3D RREG32(MC_ARB_RAMCFG);
> -       row =3D ((tmp & NOOFROWS_MASK) >> NOOFROWS_SHIFT) + 10;
> -       column =3D ((tmp & NOOFCOLS_MASK) >> NOOFCOLS_SHIFT) + 8;
> -       bank =3D ((tmp & NOOFBANK_MASK) >> NOOFBANK_SHIFT) + 2;
> +       tmp =3D RREG32(mmMC_ARB_RAMCFG);
> +       row =3D ((tmp & MC_ARB_RAMCFG__NOOFROWS_MASK) >> MC_ARB_RAMCFG__N=
OOFROWS__SHIFT) + 10;
> +       column =3D ((tmp & MC_ARB_RAMCFG__NOOFCOLS_MASK) >> MC_ARB_RAMCFG=
__NOOFCOLS__SHIFT) + 8;
> +       bank =3D ((tmp & MC_ARB_RAMCFG__NOOFBANK_MASK) >> MC_ARB_RAMCFG__=
NOOFBANK__SHIFT) + 2;
>
>         density =3D (1 << (row + column - 20 + bank)) * width;
>
> @@ -3772,11 +3775,11 @@ static void si_set_dpm_event_sources(struct amdgp=
u_device *adev, u32 sources)
>         }
>
>         if (want_thermal_protection) {
> -               WREG32_P(CG_THERMAL_CTRL, DPM_EVENT_SRC(dpm_event_src), ~=
DPM_EVENT_SRC_MASK);
> +               WREG32_P(ixCG_THERMAL_CTRL, dpm_event_src << CG_THERMAL_C=
TRL__DPM_EVENT_SRC__SHIFT, ~CG_THERMAL_CTRL__DPM_EVENT_SRC_MASK);
>                 if (pi->thermal_protection)
> -                       WREG32_P(GENERAL_PWRMGT, 0, ~THERMAL_PROTECTION_D=
IS);
> +                       WREG32_P(ixGENERAL_PWRMGT, 0, ~GENERAL_PWRMGT__TH=
ERMAL_PROTECTION_DIS_MASK);
>         } else {
> -               WREG32_P(GENERAL_PWRMGT, THERMAL_PROTECTION_DIS, ~THERMAL=
_PROTECTION_DIS);
> +               WREG32_P(ixGENERAL_PWRMGT, GENERAL_PWRMGT__THERMAL_PROTEC=
TION_DIS_MASK, ~GENERAL_PWRMGT__THERMAL_PROTECTION_DIS_MASK);
>         }
>  }
>
> @@ -3801,20 +3804,20 @@ static void si_enable_auto_throttle_source(struct=
 amdgpu_device *adev,
>
>  static void si_start_dpm(struct amdgpu_device *adev)
>  {
> -       WREG32_P(GENERAL_PWRMGT, GLOBAL_PWRMGT_EN, ~GLOBAL_PWRMGT_EN);
> +       WREG32_P(ixGENERAL_PWRMGT, GENERAL_PWRMGT__GLOBAL_PWRMGT_EN_MASK,=
 ~GENERAL_PWRMGT__GLOBAL_PWRMGT_EN_MASK);
>  }
>
>  static void si_stop_dpm(struct amdgpu_device *adev)
>  {
> -       WREG32_P(GENERAL_PWRMGT, 0, ~GLOBAL_PWRMGT_EN);
> +       WREG32_P(ixGENERAL_PWRMGT, 0, ~GENERAL_PWRMGT__GLOBAL_PWRMGT_EN_M=
ASK);
>  }
>
>  static void si_enable_sclk_control(struct amdgpu_device *adev, bool enab=
le)
>  {
>         if (enable)
> -               WREG32_P(SCLK_PWRMGT_CNTL, 0, ~SCLK_PWRMGT_OFF);
> +               WREG32_P(ixSCLK_PWRMGT_CNTL, 0, ~SCLK_PWRMGT_CNTL__SCLK_P=
WRMGT_OFF_MASK);
>         else
> -               WREG32_P(SCLK_PWRMGT_CNTL, SCLK_PWRMGT_OFF, ~SCLK_PWRMGT_=
OFF);
> +               WREG32_P(ixSCLK_PWRMGT_CNTL, SCLK_PWRMGT_CNTL__SCLK_PWRMG=
T_OFF_MASK, ~SCLK_PWRMGT_CNTL__SCLK_PWRMGT_OFF_MASK);
>
>  }
>
> @@ -3854,7 +3857,7 @@ static int si_notify_hw_of_powersource(struct amdgp=
u_device *adev, bool ac_power
>  static PPSMC_Result si_send_msg_to_smc_with_parameter(struct amdgpu_devi=
ce *adev,
>                                                       PPSMC_Msg msg, u32 =
parameter)
>  {
> -       WREG32(SMC_SCRATCH0, parameter);
> +       WREG32(ixSMC_SCRATCH0, parameter);
>         return amdgpu_si_send_msg_to_smc(adev, msg);
>  }
>
> @@ -4039,12 +4042,12 @@ static void si_read_clock_registers(struct amdgpu=
_device *adev)
>  {
>         struct si_power_info *si_pi =3D si_get_pi(adev);
>
> -       si_pi->clock_registers.cg_spll_func_cntl =3D RREG32(CG_SPLL_FUNC_=
CNTL);
> -       si_pi->clock_registers.cg_spll_func_cntl_2 =3D RREG32(CG_SPLL_FUN=
C_CNTL_2);
> -       si_pi->clock_registers.cg_spll_func_cntl_3 =3D RREG32(CG_SPLL_FUN=
C_CNTL_3);
> -       si_pi->clock_registers.cg_spll_func_cntl_4 =3D RREG32(CG_SPLL_FUN=
C_CNTL_4);
> -       si_pi->clock_registers.cg_spll_spread_spectrum =3D RREG32(CG_SPLL=
_SPREAD_SPECTRUM);
> -       si_pi->clock_registers.cg_spll_spread_spectrum_2 =3D RREG32(CG_SP=
LL_SPREAD_SPECTRUM_2);
> +       si_pi->clock_registers.cg_spll_func_cntl =3D RREG32(ixCG_SPLL_FUN=
C_CNTL);
> +       si_pi->clock_registers.cg_spll_func_cntl_2 =3D RREG32(ixCG_SPLL_F=
UNC_CNTL_2);
> +       si_pi->clock_registers.cg_spll_func_cntl_3 =3D RREG32(ixCG_SPLL_F=
UNC_CNTL_3);
> +       si_pi->clock_registers.cg_spll_func_cntl_4 =3D RREG32(ixCG_SPLL_F=
UNC_CNTL_4);
> +       si_pi->clock_registers.cg_spll_spread_spectrum =3D RREG32(ixCG_SP=
LL_SPREAD_SPECTRUM);
> +       si_pi->clock_registers.cg_spll_spread_spectrum_2 =3D RREG32(ixCG_=
SPLL_SPREAD_SPECTRUM_2);
>         si_pi->clock_registers.dll_cntl =3D RREG32(DLL_CNTL);
>         si_pi->clock_registers.mclk_pwrmgt_cntl =3D RREG32(MCLK_PWRMGT_CN=
TL);
>         si_pi->clock_registers.mpll_ad_func_cntl =3D RREG32(MPLL_AD_FUNC_=
CNTL);
> @@ -4060,14 +4063,14 @@ static void si_enable_thermal_protection(struct a=
mdgpu_device *adev,
>                                           bool enable)
>  {
>         if (enable)
> -               WREG32_P(GENERAL_PWRMGT, 0, ~THERMAL_PROTECTION_DIS);
> +               WREG32_P(ixGENERAL_PWRMGT, 0, ~GENERAL_PWRMGT__THERMAL_PR=
OTECTION_DIS_MASK);
>         else
> -               WREG32_P(GENERAL_PWRMGT, THERMAL_PROTECTION_DIS, ~THERMAL=
_PROTECTION_DIS);
> +               WREG32_P(ixGENERAL_PWRMGT, GENERAL_PWRMGT__THERMAL_PROTEC=
TION_DIS_MASK, ~GENERAL_PWRMGT__THERMAL_PROTECTION_DIS_MASK);
>  }
>
>  static void si_enable_acpi_power_management(struct amdgpu_device *adev)
>  {
> -       WREG32_P(GENERAL_PWRMGT, STATIC_PM_EN, ~STATIC_PM_EN);
> +       WREG32_P(ixGENERAL_PWRMGT, GENERAL_PWRMGT__STATIC_PM_EN_MASK, ~GE=
NERAL_PWRMGT__STATIC_PM_EN_MASK);
>  }
>
>  #if 0
> @@ -4148,9 +4151,9 @@ static void si_program_ds_registers(struct amdgpu_d=
evice *adev)
>                 tmp =3D 0x1;
>
>         if (eg_pi->sclk_deep_sleep) {
> -               WREG32_P(MISC_CLK_CNTL, DEEP_SLEEP_CLK_SEL(tmp), ~DEEP_SL=
EEP_CLK_SEL_MASK);
> -               WREG32_P(CG_SPLL_AUTOSCALE_CNTL, AUTOSCALE_ON_SS_CLEAR,
> -                        ~AUTOSCALE_ON_SS_CLEAR);
> +               WREG32_P(ixMISC_CLK_CNTL, (tmp << MISC_CLK_CNTL__DEEP_SLE=
EP_CLK_SEL__SHIFT), ~MISC_CLK_CNTL__DEEP_SLEEP_CLK_SEL_MASK);
> +               WREG32_P(ixCG_SPLL_AUTOSCALE_CNTL, CG_SPLL_AUTOSCALE_CNTL=
__AUTOSCALE_ON_SS_CLEAR_MASK,
> +                        ~CG_SPLL_AUTOSCALE_CNTL__AUTOSCALE_ON_SS_CLEAR_M=
ASK);
>         }
>  }
>
> @@ -4159,18 +4162,18 @@ static void si_program_display_gap(struct amdgpu_=
device *adev)
>         u32 tmp, pipe;
>         int i;
>
> -       tmp =3D RREG32(CG_DISPLAY_GAP_CNTL) & ~(DISP1_GAP_MASK | DISP2_GA=
P_MASK);
> +       tmp =3D RREG32(ixCG_DISPLAY_GAP_CNTL) & ~(CG_DISPLAY_GAP_CNTL__DI=
SP1_GAP_MASK | CG_DISPLAY_GAP_CNTL__DISP2_GAP_MASK);
>         if (adev->pm.dpm.new_active_crtc_count > 0)
> -               tmp |=3D DISP1_GAP(R600_PM_DISPLAY_GAP_VBLANK_OR_WM);
> +               tmp |=3D R600_PM_DISPLAY_GAP_VBLANK_OR_WM << CG_DISPLAY_G=
AP_CNTL__DISP1_GAP__SHIFT;
>         else
> -               tmp |=3D DISP1_GAP(R600_PM_DISPLAY_GAP_IGNORE);
> +               tmp |=3D R600_PM_DISPLAY_GAP_IGNORE << CG_DISPLAY_GAP_CNT=
L__DISP1_GAP__SHIFT;
>
>         if (adev->pm.dpm.new_active_crtc_count > 1)
> -               tmp |=3D DISP2_GAP(R600_PM_DISPLAY_GAP_VBLANK_OR_WM);
> +               tmp |=3D R600_PM_DISPLAY_GAP_VBLANK_OR_WM << CG_DISPLAY_G=
AP_CNTL__DISP2_GAP__SHIFT;
>         else
> -               tmp |=3D DISP2_GAP(R600_PM_DISPLAY_GAP_IGNORE);
> +               tmp |=3D R600_PM_DISPLAY_GAP_IGNORE << CG_DISPLAY_GAP_CNT=
L__DISP2_GAP__SHIFT;
>
> -       WREG32(CG_DISPLAY_GAP_CNTL, tmp);
> +       WREG32(ixCG_DISPLAY_GAP_CNTL, tmp);
>
>         tmp =3D RREG32(DCCG_DISP_SLOW_SELECT_REG);
>         pipe =3D (tmp & DCCG_DISP1_SLOW_SELECT_MASK) >> DCCG_DISP1_SLOW_S=
ELECT_SHIFT;
> @@ -4205,10 +4208,10 @@ static void si_enable_spread_spectrum(struct amdg=
pu_device *adev, bool enable)
>
>         if (enable) {
>                 if (pi->sclk_ss)
> -                       WREG32_P(GENERAL_PWRMGT, DYN_SPREAD_SPECTRUM_EN, =
~DYN_SPREAD_SPECTRUM_EN);
> +                       WREG32_P(ixGENERAL_PWRMGT, GENERAL_PWRMGT__DYN_SP=
READ_SPECTRUM_EN_MASK, ~GENERAL_PWRMGT__DYN_SPREAD_SPECTRUM_EN_MASK);
>         } else {
> -               WREG32_P(CG_SPLL_SPREAD_SPECTRUM, 0, ~SSEN);
> -               WREG32_P(GENERAL_PWRMGT, 0, ~DYN_SPREAD_SPECTRUM_EN);
> +               WREG32_P(ixCG_SPLL_SPREAD_SPECTRUM, 0, ~CG_SPLL_SPREAD_SP=
ECTRUM__SSEN_MASK);
> +               WREG32_P(ixGENERAL_PWRMGT, 0, ~GENERAL_PWRMGT__DYN_SPREAD=
_SPECTRUM_EN_MASK);
>         }
>  }
>
> @@ -4230,15 +4233,15 @@ static void si_setup_bsp(struct amdgpu_device *ad=
ev)
>                                &pi->pbsu);
>
>
> -        pi->dsp =3D BSP(pi->bsp) | BSU(pi->bsu);
> -       pi->psp =3D BSP(pi->pbsp) | BSU(pi->pbsu);
> +        pi->dsp =3D (pi->bsp << CG_BSP__BSP__SHIFT) | (pi->bsu << CG_BSP=
__BSU__SHIFT);
> +       pi->psp =3D (pi->pbsp << CG_BSP__BSP__SHIFT) | (pi->pbsu << CG_BS=
P__BSU__SHIFT);
>
> -       WREG32(CG_BSP, pi->dsp);
> +       WREG32(ixCG_BSP, pi->dsp);
>  }
>
>  static void si_program_git(struct amdgpu_device *adev)
>  {
> -       WREG32_P(CG_GIT, CG_GICST(R600_GICST_DFLT), ~CG_GICST_MASK);
> +       WREG32_P(ixCG_GIT, R600_GICST_DFLT << CG_GIT__CG_GICST__SHIFT, ~C=
G_GIT__CG_GICST_MASK);
>  }
>
>  static void si_program_tp(struct amdgpu_device *adev)
> @@ -4247,54 +4250,54 @@ static void si_program_tp(struct amdgpu_device *a=
dev)
>         enum r600_td td =3D R600_TD_DFLT;
>
>         for (i =3D 0; i < R600_PM_NUMBER_OF_TC; i++)
> -               WREG32(CG_FFCT_0 + i, (UTC_0(r600_utc[i]) | DTC_0(r600_dt=
c[i])));
> +               WREG32(ixCG_FFCT_0 + i, (r600_utc[i] << CG_FFCT_0__UTC_0_=
_SHIFT | r600_dtc[i] << CG_FFCT_0__DTC_0__SHIFT));
>
>         if (td =3D=3D R600_TD_AUTO)
> -               WREG32_P(SCLK_PWRMGT_CNTL, 0, ~FIR_FORCE_TREND_SEL);
> +               WREG32_P(ixSCLK_PWRMGT_CNTL, 0, ~SCLK_PWRMGT_CNTL__FIR_FO=
RCE_TREND_SEL_MASK);
>         else
> -               WREG32_P(SCLK_PWRMGT_CNTL, FIR_FORCE_TREND_SEL, ~FIR_FORC=
E_TREND_SEL);
> +               WREG32_P(ixSCLK_PWRMGT_CNTL, SCLK_PWRMGT_CNTL__FIR_FORCE_=
TREND_SEL_MASK, ~SCLK_PWRMGT_CNTL__FIR_FORCE_TREND_SEL_MASK);
>
>         if (td =3D=3D R600_TD_UP)
> -               WREG32_P(SCLK_PWRMGT_CNTL, 0, ~FIR_TREND_MODE);
> +               WREG32_P(ixSCLK_PWRMGT_CNTL, 0, ~SCLK_PWRMGT_CNTL__FIR_TR=
END_MODE_MASK);
>
>         if (td =3D=3D R600_TD_DOWN)
> -               WREG32_P(SCLK_PWRMGT_CNTL, FIR_TREND_MODE, ~FIR_TREND_MOD=
E);
> +               WREG32_P(ixSCLK_PWRMGT_CNTL, SCLK_PWRMGT_CNTL__FIR_TREND_=
MODE_MASK, ~SCLK_PWRMGT_CNTL__FIR_TREND_MODE_MASK);
>  }
>
>  static void si_program_tpp(struct amdgpu_device *adev)
>  {
> -       WREG32(CG_TPC, R600_TPC_DFLT);
> +       WREG32(ixCG_TPC, R600_TPC_DFLT);
>  }
>
>  static void si_program_sstp(struct amdgpu_device *adev)
>  {
> -       WREG32(CG_SSP, (SSTU(R600_SSTU_DFLT) | SST(R600_SST_DFLT)));
> +       WREG32(ixCG_SSP, (R600_SSTU_DFLT << CG_SSP__SSTU__SHIFT| R600_SST=
_DFLT << CG_SSP__SST__SHIFT));
>  }
>
>  static void si_enable_display_gap(struct amdgpu_device *adev)
>  {
> -       u32 tmp =3D RREG32(CG_DISPLAY_GAP_CNTL);
> +       u32 tmp =3D RREG32(ixCG_DISPLAY_GAP_CNTL);
>
> -       tmp &=3D ~(DISP1_GAP_MASK | DISP2_GAP_MASK);
> -       tmp |=3D (DISP1_GAP(R600_PM_DISPLAY_GAP_IGNORE) |
> -               DISP2_GAP(R600_PM_DISPLAY_GAP_IGNORE));
> +       tmp &=3D ~(CG_DISPLAY_GAP_CNTL__DISP1_GAP_MASK | CG_DISPLAY_GAP_C=
NTL__DISP2_GAP_MASK);
> +       tmp |=3D (R600_PM_DISPLAY_GAP_IGNORE << CG_DISPLAY_GAP_CNTL__DISP=
1_GAP__SHIFT |
> +               R600_PM_DISPLAY_GAP_IGNORE << CG_DISPLAY_GAP_CNTL__DISP2_=
GAP__SHIFT);
>
> -       tmp &=3D ~(DISP1_GAP_MCHG_MASK | DISP2_GAP_MCHG_MASK);
> -       tmp |=3D (DISP1_GAP_MCHG(R600_PM_DISPLAY_GAP_VBLANK) |
> -               DISP2_GAP_MCHG(R600_PM_DISPLAY_GAP_IGNORE));
> -       WREG32(CG_DISPLAY_GAP_CNTL, tmp);
> +       tmp &=3D ~(CG_DISPLAY_GAP_CNTL__DISP1_GAP_MCHG_MASK | CG_DISPLAY_=
GAP_CNTL__DISP2_GAP_MCHG_MASK);
> +       tmp |=3D (R600_PM_DISPLAY_GAP_VBLANK << CG_DISPLAY_GAP_CNTL__DISP=
1_GAP_MCHG__SHIFT |
> +               R600_PM_DISPLAY_GAP_IGNORE << CG_DISPLAY_GAP_CNTL__DISP2_=
GAP_MCHG__SHIFT);
> +       WREG32(ixCG_DISPLAY_GAP_CNTL, tmp);
>  }
>
>  static void si_program_vc(struct amdgpu_device *adev)
>  {
>         struct rv7xx_power_info *pi =3D rv770_get_pi(adev);
>
> -       WREG32(CG_FTV, pi->vrc);
> +       WREG32(ixCG_FTV, pi->vrc);
>  }
>
>  static void si_clear_vc(struct amdgpu_device *adev)
>  {
> -       WREG32(CG_FTV, 0);
> +       WREG32(ixCG_FTV, 0);
>  }
>
>  static u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_clock)
> @@ -4751,7 +4754,7 @@ static u32 si_calculate_memory_refresh_rate(struct =
amdgpu_device *adev,
>         u32 dram_rows;
>         u32 dram_refresh_rate;
>         u32 mc_arb_rfsh_rate;
> -       u32 tmp =3D (RREG32(MC_ARB_RAMCFG) & NOOFROWS_MASK) >> NOOFROWS_S=
HIFT;
> +       u32 tmp =3D (RREG32(mmMC_ARB_RAMCFG) & MC_ARB_RAMCFG__NOOFROWS_MA=
SK) >> MC_ARB_RAMCFG__NOOFROWS__SHIFT;
>
>         if (tmp >=3D 4)
>                 dram_rows =3D 16384;
> @@ -4925,7 +4928,7 @@ static int si_populate_smc_initial_state(struct amd=
gpu_device *adev,
>
>         si_populate_initial_mvdd_value(adev, &table->initialState.level.m=
vdd);
>
> -       reg =3D CG_R(0xffff) | CG_L(0);
> +       reg =3D 0xffff << CG_AT__CG_R__SHIFT | 0 << CG_AT__CG_L__SHIFT;
>         table->initialState.level.aT =3D cpu_to_be32(reg);
>         table->initialState.level.bSP =3D cpu_to_be32(pi->dsp);
>         table->initialState.level.gen2PCIE =3D (u8)si_pi->boot_pcie_gen;
> @@ -4951,10 +4954,13 @@ static int si_populate_smc_initial_state(struct a=
mdgpu_device *adev,
>         table->initialState.level.dpm2.BelowSafeInc =3D 0;
>         table->initialState.level.dpm2.PwrEfficiencyRatio =3D 0;
>
> -       reg =3D MIN_POWER_MASK | MAX_POWER_MASK;
> +       reg =3D SQ_POWER_THROTTLE__MIN_POWER_MASK |
> +               SQ_POWER_THROTTLE__MAX_POWER_MASK;
>         table->initialState.level.SQPowerThrottle =3D cpu_to_be32(reg);
>
> -       reg =3D MAX_POWER_DELTA_MASK | STI_SIZE_MASK | LTI_RATIO_MASK;
> +       reg =3D SQ_POWER_THROTTLE2__MAX_POWER_DELTA_MASK |
> +               SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE_MASK |
> +               SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO_MASK;
>         table->initialState.level.SQPowerThrottle_2 =3D cpu_to_be32(reg);
>
>         return 0;
> @@ -5073,8 +5079,8 @@ static int si_populate_smc_acpi_state(struct amdgpu=
_device *adev,
>
>         dll_cntl &=3D ~(MRDCK0_BYPASS | MRDCK1_BYPASS);
>
> -       spll_func_cntl_2 &=3D ~SCLK_MUX_SEL_MASK;
> -       spll_func_cntl_2 |=3D SCLK_MUX_SEL(4);
> +       spll_func_cntl_2 &=3D ~CG_SPLL_FUNC_CNTL_2__SCLK_MUX_SEL_MASK;
> +       spll_func_cntl_2 |=3D 4 << CG_SPLL_FUNC_CNTL_2__SCLK_MUX_SEL__SHI=
FT;
>
>         table->ACPIState.level.mclk.vDLL_CNTL =3D
>                 cpu_to_be32(dll_cntl);
> @@ -5118,10 +5124,10 @@ static int si_populate_smc_acpi_state(struct amdg=
pu_device *adev,
>         table->ACPIState.level.dpm2.BelowSafeInc =3D 0;
>         table->ACPIState.level.dpm2.PwrEfficiencyRatio =3D 0;
>
> -       reg =3D MIN_POWER_MASK | MAX_POWER_MASK;
> +       reg =3D SQ_POWER_THROTTLE__MIN_POWER_MASK | SQ_POWER_THROTTLE__MA=
X_POWER_MASK;
>         table->ACPIState.level.SQPowerThrottle =3D cpu_to_be32(reg);
>
> -       reg =3D MAX_POWER_DELTA_MASK | STI_SIZE_MASK | LTI_RATIO_MASK;
> +       reg =3D SQ_POWER_THROTTLE2__MAX_POWER_DELTA_MASK | SQ_POWER_THROT=
TLE2__SHORT_TERM_INTERVAL_SIZE_MASK | SQ_POWER_THROTTLE2__LONG_TERM_INTERVA=
L_RATIO_MASK;
>         table->ACPIState.level.SQPowerThrottle_2 =3D cpu_to_be32(reg);
>
>         return 0;
> @@ -5266,8 +5272,8 @@ static int si_init_smc_table(struct amdgpu_device *=
adev)
>                 if (ret)
>                         return ret;
>
> -               WREG32(CG_ULV_CONTROL, ulv->cg_ulv_control);
> -               WREG32(CG_ULV_PARAMETER, ulv->cg_ulv_parameter);
> +               WREG32(ixCG_ULV_CONTROL, ulv->cg_ulv_control);
> +               WREG32(ixCG_ULV_PARAMETER, ulv->cg_ulv_parameter);
>
>                 lane_width =3D amdgpu_get_pcie_lanes(adev);
>                 si_write_smc_soft_register(adev, SI_SMC_SOFT_REGISTER_non=
_ulv_pcie_link_width, lane_width);
> @@ -5310,16 +5316,16 @@ static int si_calculate_sclk_params(struct amdgpu=
_device *adev,
>         do_div(tmp, reference_clock);
>         fbdiv =3D (u32) tmp;
>
> -       spll_func_cntl &=3D ~(SPLL_PDIV_A_MASK | SPLL_REF_DIV_MASK);
> -       spll_func_cntl |=3D SPLL_REF_DIV(dividers.ref_div);
> -       spll_func_cntl |=3D SPLL_PDIV_A(dividers.post_div);
> +       spll_func_cntl &=3D ~(CG_SPLL_FUNC_CNTL__SPLL_PDIV_A_MASK | CG_SP=
LL_FUNC_CNTL__SPLL_REF_DIV_MASK);
> +       spll_func_cntl |=3D dividers.ref_div << CG_SPLL_FUNC_CNTL__SPLL_R=
EF_DIV__SHIFT;
> +       spll_func_cntl |=3D dividers.post_div << CG_SPLL_FUNC_CNTL__SPLL_=
PDIV_A__SHIFT;
>
> -       spll_func_cntl_2 &=3D ~SCLK_MUX_SEL_MASK;
> -       spll_func_cntl_2 |=3D SCLK_MUX_SEL(2);
> +       spll_func_cntl_2 &=3D ~CG_SPLL_FUNC_CNTL_2__SCLK_MUX_SEL_MASK;
> +       spll_func_cntl_2 |=3D 2 << CG_SPLL_FUNC_CNTL_2__SCLK_MUX_SEL__SHI=
FT;
>
> -       spll_func_cntl_3 &=3D ~SPLL_FB_DIV_MASK;
> -       spll_func_cntl_3 |=3D SPLL_FB_DIV(fbdiv);
> -       spll_func_cntl_3 |=3D SPLL_DITHEN;
> +       spll_func_cntl_3 &=3D ~CG_SPLL_FUNC_CNTL_3__SPLL_FB_DIV_MASK;
> +       spll_func_cntl_3 |=3D fbdiv << CG_SPLL_FUNC_CNTL_3__SPLL_FB_DIV__=
SHIFT;
> +       spll_func_cntl_3 |=3D CG_SPLL_FUNC_CNTL_3__SPLL_DITHEN_MASK;
>
>         if (pi->sclk_ss) {
>                 struct amdgpu_atom_ss ss;
> @@ -5330,12 +5336,12 @@ static int si_calculate_sclk_params(struct amdgpu=
_device *adev,
>                         u32 clk_s =3D reference_clock * 5 / (reference_di=
vider * ss.rate);
>                         u32 clk_v =3D 4 * ss.percentage * fbdiv / (clk_s =
* 10000);
>
> -                       cg_spll_spread_spectrum &=3D ~CLK_S_MASK;
> -                       cg_spll_spread_spectrum |=3D CLK_S(clk_s);
> -                       cg_spll_spread_spectrum |=3D SSEN;
> +                       cg_spll_spread_spectrum &=3D ~CG_SPLL_SPREAD_SPEC=
TRUM__CLK_S_MASK;
> +                       cg_spll_spread_spectrum |=3D clk_s << CG_SPLL_SPR=
EAD_SPECTRUM__CLK_S__SHIFT;
> +                       cg_spll_spread_spectrum |=3D CG_SPLL_SPREAD_SPECT=
RUM__SSEN_MASK;
>
> -                       cg_spll_spread_spectrum_2 &=3D ~CLK_V_MASK;
> -                       cg_spll_spread_spectrum_2 |=3D CLK_V(clk_v);
> +                       cg_spll_spread_spectrum_2 &=3D ~CG_SPLL_SPREAD_SP=
ECTRUM_2__CLK_V_MASK;
> +                       cg_spll_spread_spectrum_2 |=3D clk_v << CG_SPLL_S=
PREAD_SPECTRUM_2__CLK_V__SHIFT;
>                 }
>         }
>
> @@ -5501,7 +5507,7 @@ static int si_convert_power_level_to_smc(struct amd=
gpu_device *adev,
>         if (pi->mclk_stutter_mode_threshold &&
>             (pl->mclk <=3D pi->mclk_stutter_mode_threshold) &&
>             !eg_pi->uvd_enabled &&
> -           (RREG32(DPG_PIPE_STUTTER_CONTROL) & STUTTER_ENABLE) &&
> +           (RREG32(mmDPG_PIPE_STUTTER_CONTROL) & DPG_PIPE_STUTTER_CONTRO=
L__STUTTER_ENABLE_MASK) &&
>             (adev->pm.dpm.new_active_crtc_count <=3D 2)) {
>                 level->mcFlags |=3D SISLANDS_SMC_MC_STUTTER_EN;
>         }
> @@ -5595,7 +5601,7 @@ static int si_populate_smc_t(struct amdgpu_device *=
adev,
>                 return -EINVAL;
>
>         if (state->performance_level_count < 2) {
> -               a_t =3D CG_R(0xffff) | CG_L(0);
> +               a_t =3D 0xffff << CG_AT__CG_R__SHIFT | 0 << CG_AT__CG_L__=
SHIFT;
>                 smc_state->levels[0].aT =3D cpu_to_be32(a_t);
>                 return 0;
>         }
> @@ -5616,13 +5622,13 @@ static int si_populate_smc_t(struct amdgpu_device=
 *adev,
>                         t_l =3D (i + 1) * 1000 + 50 * R600_AH_DFLT;
>                 }
>
> -               a_t =3D be32_to_cpu(smc_state->levels[i].aT) & ~CG_R_MASK=
;
> -               a_t |=3D CG_R(t_l * pi->bsp / 20000);
> +               a_t =3D be32_to_cpu(smc_state->levels[i].aT) & ~CG_AT__CG=
_R_MASK;
> +               a_t |=3D (t_l * pi->bsp / 20000) << CG_AT__CG_R__SHIFT;
>                 smc_state->levels[i].aT =3D cpu_to_be32(a_t);
>
>                 high_bsp =3D (i =3D=3D state->performance_level_count - 2=
) ?
>                         pi->pbsp : pi->bsp;
> -               a_t =3D CG_R(0xffff) | CG_L(t_h * high_bsp / 20000);
> +               a_t =3D (0xffff) << CG_AT__CG_R__SHIFT | (t_h * high_bsp =
/ 20000) << CG_AT__CG_L__SHIFT;
>                 smc_state->levels[i + 1].aT =3D cpu_to_be32(a_t);
>         }
>
> @@ -6196,9 +6202,9 @@ static int si_upload_mc_reg_table(struct amdgpu_dev=
ice *adev,
>  static void si_enable_voltage_control(struct amdgpu_device *adev, bool e=
nable)
>  {
>         if (enable)
> -               WREG32_P(GENERAL_PWRMGT, VOLT_PWRMGT_EN, ~VOLT_PWRMGT_EN)=
;
> +               WREG32_P(ixGENERAL_PWRMGT, GENERAL_PWRMGT__VOLT_PWRMGT_EN=
_MASK, ~GENERAL_PWRMGT__VOLT_PWRMGT_EN_MASK);
>         else
> -               WREG32_P(GENERAL_PWRMGT, 0, ~VOLT_PWRMGT_EN);
> +               WREG32_P(ixGENERAL_PWRMGT, 0, ~GENERAL_PWRMGT__VOLT_PWRMG=
T_EN_MASK);
>  }
>
>  static enum si_pcie_gen si_get_maximum_link_speed(struct amdgpu_device *=
adev,
> @@ -6220,8 +6226,8 @@ static u16 si_get_current_pcie_speed(struct amdgpu_=
device *adev)
>  {
>         u32 speed_cntl;
>
> -       speed_cntl =3D RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL) & LC_CURRENT_=
DATA_RATE_MASK;
> -       speed_cntl >>=3D LC_CURRENT_DATA_RATE_SHIFT;
> +       speed_cntl =3D RREG32_PCIE_PORT(ixPCIE_LC_SPEED_CNTL) & PCIE_LC_S=
PEED_CNTL__LC_CURRENT_DATA_RATE_MASK;
> +       speed_cntl >>=3D PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
>
>         return (u16)speed_cntl;
>  }
> @@ -6428,21 +6434,21 @@ static void si_dpm_setup_asic(struct amdgpu_devic=
e *adev)
>  static int si_thermal_enable_alert(struct amdgpu_device *adev,
>                                    bool enable)
>  {
> -       u32 thermal_int =3D RREG32(CG_THERMAL_INT);
> +       u32 thermal_int =3D RREG32(ixCG_THERMAL_INT);
>
>         if (enable) {
>                 PPSMC_Result result;
>
> -               thermal_int &=3D ~(THERM_INT_MASK_HIGH | THERM_INT_MASK_L=
OW);
> -               WREG32(CG_THERMAL_INT, thermal_int);
> +               thermal_int &=3D ~(CG_THERMAL_INT__THERM_INT_MASK_HIGH_MA=
SK | CG_THERMAL_INT__THERM_INT_MASK_LOW_MASK);
> +               WREG32(ixCG_THERMAL_INT, thermal_int);
>                 result =3D amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_Enab=
leThermalInterrupt);
>                 if (result !=3D PPSMC_Result_OK) {
>                         DRM_DEBUG_KMS("Could not enable thermal interrupt=
s.\n");
>                         return -EINVAL;
>                 }
>         } else {
> -               thermal_int |=3D THERM_INT_MASK_HIGH | THERM_INT_MASK_LOW=
;
> -               WREG32(CG_THERMAL_INT, thermal_int);
> +               thermal_int |=3D CG_THERMAL_INT__THERM_INT_MASK_HIGH_MASK=
 | CG_THERMAL_INT__THERM_INT_MASK_LOW_MASK;
> +               WREG32(ixCG_THERMAL_INT, thermal_int);
>         }
>
>         return 0;
> @@ -6463,9 +6469,9 @@ static int si_thermal_set_temperature_range(struct =
amdgpu_device *adev,
>                 return -EINVAL;
>         }
>
> -       WREG32_P(CG_THERMAL_INT, DIG_THERM_INTH(high_temp / 1000), ~DIG_T=
HERM_INTH_MASK);
> -       WREG32_P(CG_THERMAL_INT, DIG_THERM_INTL(low_temp / 1000), ~DIG_TH=
ERM_INTL_MASK);
> -       WREG32_P(CG_THERMAL_CTRL, DIG_THERM_DPM(high_temp / 1000), ~DIG_T=
HERM_DPM_MASK);
> +       WREG32_P(ixCG_THERMAL_INT, (high_temp / 1000) << CG_THERMAL_INT__=
DIG_THERM_INTH__SHIFT, ~CG_THERMAL_INT__DIG_THERM_INTH_MASK);
> +       WREG32_P(ixCG_THERMAL_INT, (low_temp / 1000) << CG_THERMAL_INT__D=
IG_THERM_INTL__SHIFT, ~CG_THERMAL_INT__DIG_THERM_INTL_MASK);
> +       WREG32_P(ixCG_THERMAL_CTRL, (high_temp / 1000) << CG_THERMAL_CTRL=
__DIG_THERM_DPM__SHIFT, ~CG_THERMAL_CTRL__DIG_THERM_DPM_MASK);
>
>         adev->pm.dpm.thermal.min_temp =3D low_temp;
>         adev->pm.dpm.thermal.max_temp =3D high_temp;
> @@ -6479,20 +6485,20 @@ static void si_fan_ctrl_set_static_mode(struct am=
dgpu_device *adev, u32 mode)
>         u32 tmp;
>
>         if (si_pi->fan_ctrl_is_in_default_mode) {
> -               tmp =3D (RREG32(CG_FDO_CTRL2) & FDO_PWM_MODE_MASK) >> FDO=
_PWM_MODE_SHIFT;
> +               tmp =3D (RREG32(ixCG_FDO_CTRL2) & CG_FDO_CTRL2__FDO_PWM_M=
ODE_MASK) >> CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT;
>                 si_pi->fan_ctrl_default_mode =3D tmp;
> -               tmp =3D (RREG32(CG_FDO_CTRL2) & TMIN_MASK) >> TMIN_SHIFT;
> +               tmp =3D (RREG32(ixCG_FDO_CTRL2) & CG_FDO_CTRL2__TMIN_MASK=
) >> CG_FDO_CTRL2__TMIN__SHIFT;
>                 si_pi->t_min =3D tmp;
>                 si_pi->fan_ctrl_is_in_default_mode =3D false;
>         }
>
> -       tmp =3D RREG32(CG_FDO_CTRL2) & ~TMIN_MASK;
> -       tmp |=3D TMIN(0);
> -       WREG32(CG_FDO_CTRL2, tmp);
> +       tmp =3D RREG32(ixCG_FDO_CTRL2) & ~CG_FDO_CTRL2__TMIN_MASK;
> +       tmp |=3D 0 << CG_FDO_CTRL2__TMIN__SHIFT;
> +       WREG32(ixCG_FDO_CTRL2, tmp);
>
> -       tmp =3D RREG32(CG_FDO_CTRL2) & ~FDO_PWM_MODE_MASK;
> -       tmp |=3D FDO_PWM_MODE(mode);
> -       WREG32(CG_FDO_CTRL2, tmp);
> +       tmp =3D RREG32(ixCG_FDO_CTRL2) & ~CG_FDO_CTRL2__FDO_PWM_MODE_MASK=
;
> +       tmp |=3D mode << CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT;
> +       WREG32(ixCG_FDO_CTRL2, tmp);
>  }
>
>  static int si_thermal_setup_fan_table(struct amdgpu_device *adev)
> @@ -6511,7 +6517,7 @@ static int si_thermal_setup_fan_table(struct amdgpu=
_device *adev)
>                 return 0;
>         }
>
> -       duty100 =3D (RREG32(CG_FDO_CTRL1) & FMAX_DUTY100_MASK) >> FMAX_DU=
TY100_SHIFT;
> +       duty100 =3D (RREG32(ixCG_FDO_CTRL1) & CG_FDO_CTRL1__FMAX_DUTY100_=
MASK) >> CG_FDO_CTRL1__FMAX_DUTY100__SHIFT;
>
>         if (duty100 =3D=3D 0) {
>                 adev->pm.dpm.fan.ucode_fan_control =3D false;
> @@ -6547,7 +6553,7 @@ static int si_thermal_setup_fan_table(struct amdgpu=
_device *adev)
>                                                 reference_clock) / 1600);
>         fan_table.fdo_max =3D cpu_to_be16((u16)duty100);
>
> -       tmp =3D (RREG32(CG_MULT_THERMAL_CTRL) & TEMP_SEL_MASK) >> TEMP_SE=
L_SHIFT;
> +       tmp =3D (RREG32(ixCG_MULT_THERMAL_CTRL) & CG_MULT_THERMAL_CTRL__T=
EMP_SEL_MASK) >> CG_MULT_THERMAL_CTRL__TEMP_SEL__SHIFT;
>         fan_table.temp_src =3D (uint8_t)tmp;
>
>         ret =3D amdgpu_si_copy_bytes_to_smc(adev,
> @@ -6606,8 +6612,8 @@ static int si_dpm_get_fan_speed_pwm(void *handle,
>         if (adev->pm.no_fan)
>                 return -ENOENT;
>
> -       duty100 =3D (RREG32(CG_FDO_CTRL1) & FMAX_DUTY100_MASK) >> FMAX_DU=
TY100_SHIFT;
> -       duty =3D (RREG32(CG_THERMAL_STATUS) & FDO_PWM_DUTY_MASK) >> FDO_P=
WM_DUTY_SHIFT;
> +       duty100 =3D (RREG32(ixCG_FDO_CTRL1) & CG_FDO_CTRL1__FMAX_DUTY100_=
MASK) >> CG_FDO_CTRL1__FMAX_DUTY100__SHIFT;
> +       duty =3D (RREG32(ixCG_THERMAL_STATUS) & CG_THERMAL_STATUS__FDO_PW=
M_DUTY_MASK) >> CG_THERMAL_STATUS__FDO_PWM_DUTY__SHIFT;
>
>         if (duty100 =3D=3D 0)
>                 return -EINVAL;
> @@ -6637,7 +6643,7 @@ static int si_dpm_set_fan_speed_pwm(void *handle,
>         if (speed > 255)
>                 return -EINVAL;
>
> -       duty100 =3D (RREG32(CG_FDO_CTRL1) & FMAX_DUTY100_MASK) >> FMAX_DU=
TY100_SHIFT;
> +       duty100 =3D (RREG32(ixCG_FDO_CTRL1) & CG_FDO_CTRL1__FMAX_DUTY100_=
MASK) >> CG_FDO_CTRL1__FMAX_DUTY100__SHIFT;
>
>         if (duty100 =3D=3D 0)
>                 return -EINVAL;
> @@ -6646,9 +6652,9 @@ static int si_dpm_set_fan_speed_pwm(void *handle,
>         do_div(tmp64, 255);
>         duty =3D (u32)tmp64;
>
> -       tmp =3D RREG32(CG_FDO_CTRL0) & ~FDO_STATIC_DUTY_MASK;
> -       tmp |=3D FDO_STATIC_DUTY(duty);
> -       WREG32(CG_FDO_CTRL0, tmp);
> +       tmp =3D RREG32(ixCG_FDO_CTRL0) & ~CG_FDO_CTRL0__FDO_STATIC_DUTY_M=
ASK;
> +       tmp |=3D duty << CG_FDO_CTRL0__FDO_STATIC_DUTY__SHIFT;
> +       WREG32(ixCG_FDO_CTRL0, tmp);
>
>         return 0;
>  }
> @@ -6688,8 +6694,8 @@ static int si_dpm_get_fan_control_mode(void *handle=
, u32 *fan_mode)
>         if (si_pi->fan_is_controlled_by_smc)
>                 return 0;
>
> -       tmp =3D RREG32(CG_FDO_CTRL2) & FDO_PWM_MODE_MASK;
> -       *fan_mode =3D (tmp >> FDO_PWM_MODE_SHIFT);
> +       tmp =3D RREG32(ixCG_FDO_CTRL2) & CG_FDO_CTRL2__FDO_PWM_MODE_MASK;
> +       *fan_mode =3D (tmp >> CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT);
>
>         return 0;
>  }
> @@ -6707,7 +6713,7 @@ static int si_fan_ctrl_get_fan_speed_rpm(struct amd=
gpu_device *adev,
>         if (adev->pm.fan_pulses_per_revolution =3D=3D 0)
>                 return -ENOENT;
>
> -       tach_period =3D (RREG32(CG_TACH_STATUS) & TACH_PERIOD_MASK) >> TA=
CH_PERIOD_SHIFT;
> +       tach_period =3D (RREG32(ixCG_TACH_STATUS) & CG_TACH_STATUS__TACH_=
PERIOD_MASK) >> CG_TACH_STATUS__TACH_PERIOD__SHIFT;
>         if (tach_period =3D=3D 0)
>                 return -ENOENT;
>
> @@ -6736,9 +6742,9 @@ static int si_fan_ctrl_set_fan_speed_rpm(struct amd=
gpu_device *adev,
>                 si_fan_ctrl_stop_smc_fan_control(adev);
>
>         tach_period =3D 60 * xclk * 10000 / (8 * speed);
> -       tmp =3D RREG32(CG_TACH_CTRL) & ~TARGET_PERIOD_MASK;
> -       tmp |=3D TARGET_PERIOD(tach_period);
> -       WREG32(CG_TACH_CTRL, tmp);
> +       tmp =3D RREG32(ixCG_TACH_CTRL) & ~CG_TACH_CTRL__TARGET_PERIOD_MAS=
K;
> +       tmp |=3D tach_period << CG_TACH_CTRL__TARGET_PERIOD__SHIFT;
> +       WREG32(ixCG_TACH_CTRL, tmp);
>
>         si_fan_ctrl_set_static_mode(adev, FDO_PWM_MODE_STATIC_RPM);
>
> @@ -6752,13 +6758,13 @@ static void si_fan_ctrl_set_default_mode(struct a=
mdgpu_device *adev)
>         u32 tmp;
>
>         if (!si_pi->fan_ctrl_is_in_default_mode) {
> -               tmp =3D RREG32(CG_FDO_CTRL2) & ~FDO_PWM_MODE_MASK;
> -               tmp |=3D FDO_PWM_MODE(si_pi->fan_ctrl_default_mode);
> -               WREG32(CG_FDO_CTRL2, tmp);
> +               tmp =3D RREG32(ixCG_FDO_CTRL2) & ~CG_FDO_CTRL2__FDO_PWM_M=
ODE_MASK;
> +               tmp |=3D si_pi->fan_ctrl_default_mode << CG_FDO_CTRL2__FD=
O_PWM_MODE__SHIFT;
> +               WREG32(ixCG_FDO_CTRL2, tmp);
>
> -               tmp =3D RREG32(CG_FDO_CTRL2) & ~TMIN_MASK;
> -               tmp |=3D TMIN(si_pi->t_min);
> -               WREG32(CG_FDO_CTRL2, tmp);
> +               tmp =3D RREG32(ixCG_FDO_CTRL2) & ~CG_FDO_CTRL2__TMIN_MASK=
;
> +               tmp |=3D si_pi->t_min << CG_FDO_CTRL2__TMIN__SHIFT;
> +               WREG32(ixCG_FDO_CTRL2, tmp);
>                 si_pi->fan_ctrl_is_in_default_mode =3D true;
>         }
>  }
> @@ -6776,14 +6782,14 @@ static void si_thermal_initialize(struct amdgpu_d=
evice *adev)
>         u32 tmp;
>
>         if (adev->pm.fan_pulses_per_revolution) {
> -               tmp =3D RREG32(CG_TACH_CTRL) & ~EDGE_PER_REV_MASK;
> -               tmp |=3D EDGE_PER_REV(adev->pm.fan_pulses_per_revolution =
-1);
> -               WREG32(CG_TACH_CTRL, tmp);
> +               tmp =3D RREG32(ixCG_TACH_CTRL) & ~CG_TACH_CTRL__EDGE_PER_=
REV_MASK;
> +               tmp |=3D (adev->pm.fan_pulses_per_revolution -1) << CG_TA=
CH_CTRL__EDGE_PER_REV__SHIFT;
> +               WREG32(ixCG_TACH_CTRL, tmp);
>         }
>
> -       tmp =3D RREG32(CG_FDO_CTRL2) & ~TACH_PWM_RESP_RATE_MASK;
> -       tmp |=3D TACH_PWM_RESP_RATE(0x28);
> -       WREG32(CG_FDO_CTRL2, tmp);
> +       tmp =3D RREG32(ixCG_FDO_CTRL2) & ~CG_FDO_CTRL2__TACH_PWM_RESP_RAT=
E_MASK;
> +       tmp |=3D 0x28 << CG_FDO_CTRL2__TACH_PWM_RESP_RATE__SHIFT;
> +       WREG32(ixCG_FDO_CTRL2, tmp);
>  }
>
>  static int si_thermal_start_thermal_controller(struct amdgpu_device *ade=
v)
> @@ -7546,8 +7552,8 @@ static void si_dpm_debugfs_print_current_performanc=
e_level(void *handle,
>         struct  si_ps *ps =3D si_get_ps(rps);
>         struct rv7xx_pl *pl;
>         u32 current_index =3D
> -               (RREG32(TARGET_AND_CURRENT_PROFILE_INDEX) & CURRENT_STATE=
_INDEX_MASK) >>
> -               CURRENT_STATE_INDEX_SHIFT;
> +               (RREG32(ixTARGET_AND_CURRENT_PROFILE_INDEX) & TARGET_AND_=
CURRENT_PROFILE_INDEX__CURRENT_STATE_INDEX_MASK) >>
> +                       TARGET_AND_CURRENT_PROFILE_INDEX__CURRENT_STATE_I=
NDEX__SHIFT;
>
>         if (current_index >=3D ps->performance_level_count) {
>                 seq_printf(m, "invalid dpm profile %d\n", current_index);
> @@ -7570,14 +7576,14 @@ static int si_dpm_set_interrupt_state(struct amdg=
pu_device *adev,
>         case AMDGPU_THERMAL_IRQ_LOW_TO_HIGH:
>                 switch (state) {
>                 case AMDGPU_IRQ_STATE_DISABLE:
> -                       cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);
> -                       cg_thermal_int |=3D THERM_INT_MASK_HIGH;
> -                       WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);
> +                       cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT);
> +                       cg_thermal_int |=3D CG_THERMAL_INT__THERM_INT_MAS=
K_HIGH_MASK;
> +                       WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);
>                         break;
>                 case AMDGPU_IRQ_STATE_ENABLE:
> -                       cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);
> -                       cg_thermal_int &=3D ~THERM_INT_MASK_HIGH;
> -                       WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);
> +                       cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT);
> +                       cg_thermal_int &=3D ~CG_THERMAL_INT__THERM_INT_MA=
SK_HIGH_MASK;
> +                       WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);
>                         break;
>                 default:
>                         break;
> @@ -7587,14 +7593,14 @@ static int si_dpm_set_interrupt_state(struct amdg=
pu_device *adev,
>         case AMDGPU_THERMAL_IRQ_HIGH_TO_LOW:
>                 switch (state) {
>                 case AMDGPU_IRQ_STATE_DISABLE:
> -                       cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);
> -                       cg_thermal_int |=3D THERM_INT_MASK_LOW;
> -                       WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);
> +                       cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT);
> +                       cg_thermal_int |=3D CG_THERMAL_INT__THERM_INT_MAS=
K_LOW_MASK;
> +                       WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);
>                         break;
>                 case AMDGPU_IRQ_STATE_ENABLE:
> -                       cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);
> -                       cg_thermal_int &=3D ~THERM_INT_MASK_LOW;
> -                       WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);
> +                       cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT);
> +                       cg_thermal_int &=3D ~CG_THERMAL_INT__THERM_INT_MA=
SK_LOW_MASK;
> +                       WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);
>                         break;
>                 default:
>                         break;
> @@ -7884,8 +7890,8 @@ static int si_dpm_get_temp(void *handle)
>         int actual_temp =3D 0;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> -       temp =3D (RREG32(CG_MULT_THERMAL_STATUS) & CTF_TEMP_MASK) >>
> -               CTF_TEMP_SHIFT;
> +       temp =3D (RREG32(ixCG_MULT_THERMAL_STATUS) & CG_MULT_THERMAL_STAT=
US__CTF_TEMP_MASK) >>
> +               CG_MULT_THERMAL_STATUS__CTF_TEMP__SHIFT;
>
>         if (temp & 0x200)
>                 actual_temp =3D 255;
> @@ -8015,8 +8021,8 @@ static int si_dpm_read_sensor(void *handle, int idx=
,
>         struct  si_ps *ps =3D si_get_ps(rps);
>         uint32_t sclk, mclk;
>         u32 pl_index =3D
> -               (RREG32(TARGET_AND_CURRENT_PROFILE_INDEX) & CURRENT_STATE=
_INDEX_MASK) >>
> -               CURRENT_STATE_INDEX_SHIFT;
> +               (RREG32(ixTARGET_AND_CURRENT_PROFILE_INDEX) & TARGET_AND_=
CURRENT_PROFILE_INDEX__CURRENT_STATE_INDEX_MASK) >>
> +               TARGET_AND_CURRENT_PROFILE_INDEX__CURRENT_STATE_INDEX__SH=
IFT;
>
>         /* size must be at least 4 bytes for all sensors */
>         if (*size < 4)
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_smc.c
> index c712899c44ca..4e65ab9e931c 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
> @@ -44,8 +44,8 @@ static int si_set_smc_sram_address(struct amdgpu_device=
 *adev,
>         if ((smc_address + 3) > limit)
>                 return -EINVAL;
>
> -       WREG32(SMC_IND_INDEX_0, smc_address);
> -       WREG32_P(SMC_IND_ACCESS_CNTL, 0, ~AUTO_INCREMENT_IND_0);
> +       WREG32(mmSMC_IND_INDEX_0, smc_address);
> +       WREG32_P(mmSMC_IND_ACCESS_CNTL, 0, ~SMC_IND_ACCESS_CNTL__AUTO_INC=
REMENT_IND_0_MASK);
>
>         return 0;
>  }
> @@ -74,7 +74,7 @@ int amdgpu_si_copy_bytes_to_smc(struct amdgpu_device *a=
dev,
>                 if (ret)
>                         goto done;
>
> -               WREG32(SMC_IND_DATA_0, data);
> +               WREG32(mmSMC_IND_DATA_0, data);
>
>                 src +=3D 4;
>                 byte_count -=3D 4;
> @@ -89,7 +89,7 @@ int amdgpu_si_copy_bytes_to_smc(struct amdgpu_device *a=
dev,
>                 if (ret)
>                         goto done;
>
> -               original_data =3D RREG32(SMC_IND_DATA_0);
> +               original_data =3D RREG32(mmSMC_IND_DATA_0);
>                 extra_shift =3D 8 * (4 - byte_count);
>
>                 while (byte_count > 0) {
> @@ -105,7 +105,7 @@ int amdgpu_si_copy_bytes_to_smc(struct amdgpu_device =
*adev,
>                 if (ret)
>                         goto done;
>
> -               WREG32(SMC_IND_DATA_0, data);
> +               WREG32(mmSMC_IND_DATA_0, data);
>         }
>
>  done:
> @@ -127,10 +127,10 @@ void amdgpu_si_reset_smc(struct amdgpu_device *adev=
)
>  {
>         u32 tmp;
>
> -       RREG32(CB_CGTT_SCLK_CTRL);
> -       RREG32(CB_CGTT_SCLK_CTRL);
> -       RREG32(CB_CGTT_SCLK_CTRL);
> -       RREG32(CB_CGTT_SCLK_CTRL);
> +       RREG32(mmCB_CGTT_SCLK_CTRL);
> +       RREG32(mmCB_CGTT_SCLK_CTRL);
> +       RREG32(mmCB_CGTT_SCLK_CTRL);
> +       RREG32(mmCB_CGTT_SCLK_CTRL);
>
>         tmp =3D RREG32_SMC(SMC_SYSCON_RESET_CNTL) |
>               RST_REG;
> @@ -176,16 +176,16 @@ PPSMC_Result amdgpu_si_send_msg_to_smc(struct amdgp=
u_device *adev,
>         if (!amdgpu_si_is_smc_running(adev))
>                 return PPSMC_Result_Failed;
>
> -       WREG32(SMC_MESSAGE_0, msg);
> +       WREG32(mmSMC_MESSAGE_0, msg);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               tmp =3D RREG32(SMC_RESP_0);
> +               tmp =3D RREG32(mmSMC_RESP_0);
>                 if (tmp !=3D 0)
>                         break;
>                 udelay(1);
>         }
>
> -       return (PPSMC_Result)RREG32(SMC_RESP_0);
> +       return (PPSMC_Result)RREG32(mmSMC_RESP_0);
>  }
>
>  PPSMC_Result amdgpu_si_wait_for_smc_inactive(struct amdgpu_device *adev)
> @@ -231,18 +231,18 @@ int amdgpu_si_load_smc_ucode(struct amdgpu_device *=
adev, u32 limit)
>                 return -EINVAL;
>
>         spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -       WREG32(SMC_IND_INDEX_0, ucode_start_address);
> -       WREG32_P(SMC_IND_ACCESS_CNTL, AUTO_INCREMENT_IND_0, ~AUTO_INCREME=
NT_IND_0);
> +       WREG32(mmSMC_IND_INDEX_0, ucode_start_address);
> +       WREG32_P(mmSMC_IND_ACCESS_CNTL, SMC_IND_ACCESS_CNTL__AUTO_INCREME=
NT_IND_0_MASK, ~SMC_IND_ACCESS_CNTL__AUTO_INCREMENT_IND_0_MASK);
>         while (ucode_size >=3D 4) {
>                 /* SMC address space is BE */
>                 data =3D (src[0] << 24) | (src[1] << 16) | (src[2] << 8) =
| src[3];
>
> -               WREG32(SMC_IND_DATA_0, data);
> +               WREG32(mmSMC_IND_DATA_0, data);
>
>                 src +=3D 4;
>                 ucode_size -=3D 4;
>         }
> -       WREG32_P(SMC_IND_ACCESS_CNTL, 0, ~AUTO_INCREMENT_IND_0);
> +       WREG32_P(mmSMC_IND_ACCESS_CNTL, 0, ~SMC_IND_ACCESS_CNTL__AUTO_INC=
REMENT_IND_0_MASK);
>         spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
>
>         return 0;
> @@ -257,7 +257,7 @@ int amdgpu_si_read_smc_sram_dword(struct amdgpu_devic=
e *adev, u32 smc_address,
>         spin_lock_irqsave(&adev->smc_idx_lock, flags);
>         ret =3D si_set_smc_sram_address(adev, smc_address, limit);
>         if (ret =3D=3D 0)
> -               *value =3D RREG32(SMC_IND_DATA_0);
> +               *value =3D RREG32(mmSMC_IND_DATA_0);
>         spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
>
>         return ret;
> @@ -272,7 +272,7 @@ int amdgpu_si_write_smc_sram_dword(struct amdgpu_devi=
ce *adev, u32 smc_address,
>         spin_lock_irqsave(&adev->smc_idx_lock, flags);
>         ret =3D si_set_smc_sram_address(adev, smc_address, limit);
>         if (ret =3D=3D 0)
> -               WREG32(SMC_IND_DATA_0, value);
> +               WREG32(mmSMC_IND_DATA_0, value);
>         spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
>
>         return ret;
> --
> 2.48.1
>
