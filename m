Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3706C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 20:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E69810E046;
	Wed, 19 Mar 2025 20:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gfpLMHoG";
	dkim-atps=neutral
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5BE10E046
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 20:19:35 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-86d3ac0fec0so13729241.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742415572; x=1743020372; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7mj/O85FgZuyjBtXp4zq7/3BYaASIhBl4N9XmOQwo0s=;
 b=gfpLMHoGGTMdgbrGxLyk2z23NIdrHIrfvi78nseiK6VJVTEoU/wdeKR4HRcpwEL8u/
 t40pmlLhC2HHSJHnR1J2EmtIGniT3IA2rEyP4LRpHgCEmOiE/bkptsWX33Ca4U+vMt66
 uEKaFwajHDJtchHIahTIG6tmsspd+QD5zJi3/huyvvrfKzLS5f1LsKABfaBAYNeGepLC
 l6WdcN6M97km8zrEB6pne1/l/J0dlKOE5OI67OUiIaBrKzuomozk/nHxa7v4h1Cc+far
 TIcF+fFLlmFFa9MGwLFZSY2w3qrcWX2RH8463JJedXGmOT4uhZQkOxFML1EnSGSVvjvb
 GJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742415572; x=1743020372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7mj/O85FgZuyjBtXp4zq7/3BYaASIhBl4N9XmOQwo0s=;
 b=rf2m/6mdQAXEpxMB1tOEUYV/8h6CXHPCYejFPl+SMMP501VnqLNy6FMS4ASJ5gZMmP
 euMlkTp/elH2Ut3vpLauBwaQyaLwIInq4R8OMANi+Gy7ECLPm41cao1vlAqY1jhnsQnM
 1uOl5pY4pVz1EgozRSKrgPQxoNFbmqfnzpTaA39+1YW2VlkIpcUlcZQA287ieEGarunt
 q7v2wgyj3CeZC7evBtVQUQjCI4Ol56Sz0+zK25rSEvv0NAWltV11qqmcR2hcaIQqsBTg
 1ynskuVNaRbu5xxnEEg7E4+7+iXHE1mWgPtpAyD6jzfeovIHKqJTuQOg4N9BBOj9EoNJ
 UUIg==
X-Gm-Message-State: AOJu0YwNF/Q1KxpJqwCKE/pqL/2641sVhGOjfAAK68ejLyntVhu8R0m5
 tZ1M857qg76/abYN2VtkDgvhmvtK/X5fgwFIm5TEC5H1eQIOLXge4oasL0lzFUgMPJrdYRWtvpo
 gYnonjmivLgx9Ng/Sq6H17qV+A8MRMA==
X-Gm-Gg: ASbGncs+YspbvbiAy//e4B5M2fjW11rewlU+34RM7i6nfswYDBC68XLs6PCSJZoozdc
 gj6J95vFObRqMvsb2gnbWXSqBw/+PO1QfFOnT9FWmjI+7iHDF3iZ7w4L3WL+bbR2hMuX8OuZk7e
 wM0mVXTmOWOPNx6YfgtEcaXGPU3qObft77zwZY
X-Google-Smtp-Source: AGHT+IGXfpQ7G3Aq525QLEDkHyvM+Am12BuyFA4Q6z2X7VvdgzFY+grHYjjURs5KjrCIhvYwLFEZ8G2wc3nlPKdMcko=
X-Received: by 2002:a05:6102:6d1:b0:4c1:9288:906c with SMTP id
 ada2fe7eead31-4c4fcd64ademr719213137.9.1742415572152; Wed, 19 Mar 2025
 13:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
 <20250317060702.5297-12-alexandre.f.demers@gmail.com>
 <CADnq5_P9JLxj+iCDuRGZy_vKf43CswYEeqccdN5WQEpcoPi8EA@mail.gmail.com>
In-Reply-To: <CADnq5_P9JLxj+iCDuRGZy_vKf43CswYEeqccdN5WQEpcoPi8EA@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Wed, 19 Mar 2025 16:19:21 -0400
X-Gm-Features: AQ5f1Jp0jeWuc7qxZQP1Jzhro5H14yrv34ldf0uG1mgNaUYx4BY7ZFrzjSiL9C0
Message-ID: <CAPEhTTEjKNPZ32-u=pPfRO0sNYumJCy6BvM41s1thhST6nJRTA@mail.gmail.com>
Subject: Re: [PATCH 11/18] drm/pm/legacy-dpm: move SI away from sid.h and
 si_enums.h
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000003abc9c0630b7bd90"
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

--0000000000003abc9c0630b7bd90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 11:04=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Mon, Mar 17, 2025 at 2:38=E2=80=AFAM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 338 +++++++++++----------
> >  drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c |  36 +--
> >  2 files changed, 190 insertions(+), 184 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > index 975912f285d7..0f34aaf773b7 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > @@ -2209,7 +2209,7 @@ static u32 si_calculate_cac_wintime(struct
amdgpu_device *adev)
> >         if (xclk =3D=3D 0)
> >                 return 0;
> >
> > -       cac_window =3D RREG32(CG_CAC_CTRL) & CAC_WINDOW_MASK;
> > +       cac_window =3D RREG32(ixCG_CAC_CTRL) &
CG_CAC_CTRL__CAC_WINDOW_MASK;
>
> This looks wrong.  The ix prefix means the register offset is an index
> rather than an offset and not directly accessible.  If you are using
> the ix registers they should be using an indirect register accessor.
> Same comment on the other cases below.
>
> Alex

Hmmm, I misunderstood the meaning and I wrongly renamed the defines. I'll
fix it

Alexandre
>
> >         cac_window_size =3D ((cac_window & 0xFFFF0000) >> 16) *
(cac_window & 0x0000FFFF);
> >
> >         wintime =3D (cac_window_size * 100) / xclk;
> > @@ -2505,19 +2505,19 @@ static int si_populate_sq_ramping_values(struct
amdgpu_device *adev,
> >         if (adev->pm.dpm.sq_ramping_threshold =3D=3D 0)
> >                 return -EINVAL;
> >
> > -       if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER > (MAX_POWER_MASK >>
MAX_POWER_SHIFT))
> > +       if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER >
(SQ_POWER_THROTTLE__MAX_POWER_MASK >> SQ_POWER_THROTTLE__MAX_POWER__SHIFT))
> >                 enable_sq_ramping =3D false;
> >
> > -       if (SISLANDS_DPM2_SQ_RAMP_MIN_POWER > (MIN_POWER_MASK >>
MIN_POWER_SHIFT))
> > +       if (SISLANDS_DPM2_SQ_RAMP_MIN_POWER >
(SQ_POWER_THROTTLE__MIN_POWER_MASK >> SQ_POWER_THROTTLE__MIN_POWER__SHIFT))
> >                 enable_sq_ramping =3D false;
> >
> > -       if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER_DELTA >
(MAX_POWER_DELTA_MASK >> MAX_POWER_DELTA_SHIFT))
> > +       if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER_DELTA >
(SQ_POWER_THROTTLE2__MAX_POWER_DELTA_MASK >>
SQ_POWER_THROTTLE2__MAX_POWER_DELTA__SHIFT))
> >                 enable_sq_ramping =3D false;
> >
> > -       if (SISLANDS_DPM2_SQ_RAMP_STI_SIZE > (STI_SIZE_MASK >>
STI_SIZE_SHIFT))
> > +       if (SISLANDS_DPM2_SQ_RAMP_STI_SIZE >
(SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE_MASK >>
SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE__SHIFT))
> >                 enable_sq_ramping =3D false;
> >
> > -       if (SISLANDS_DPM2_SQ_RAMP_LTI_RATIO > (LTI_RATIO_MASK >>
LTI_RATIO_SHIFT))
> > +       if (SISLANDS_DPM2_SQ_RAMP_LTI_RATIO >
(SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO_MASK >>
SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO__SHIFT))
> >                 enable_sq_ramping =3D false;
> >
> >         for (i =3D 0; i < state->performance_level_count; i++) {
> > @@ -2526,14 +2526,17 @@ static int si_populate_sq_ramping_values(struct
amdgpu_device *adev,
> >
> >                 if ((state->performance_levels[i].sclk >=3D
adev->pm.dpm.sq_ramping_threshold) &&
> >                     enable_sq_ramping) {
> > -                       sq_power_throttle |=3D
MAX_POWER(SISLANDS_DPM2_SQ_RAMP_MAX_POWER);
> > -                       sq_power_throttle |=3D
MIN_POWER(SISLANDS_DPM2_SQ_RAMP_MIN_POWER);
> > -                       sq_power_throttle2 |=3D
MAX_POWER_DELTA(SISLANDS_DPM2_SQ_RAMP_MAX_POWER_DELTA);
> > -                       sq_power_throttle2 |=3D
STI_SIZE(SISLANDS_DPM2_SQ_RAMP_STI_SIZE);
> > -                       sq_power_throttle2 |=3D
LTI_RATIO(SISLANDS_DPM2_SQ_RAMP_LTI_RATIO);
> > +                       sq_power_throttle |=3D
SISLANDS_DPM2_SQ_RAMP_MAX_POWER << SQ_POWER_THROTTLE__MAX_POWER__SHIFT;
> > +                       sq_power_throttle |=3D
SISLANDS_DPM2_SQ_RAMP_MIN_POWER << SQ_POWER_THROTTLE__MIN_POWER__SHIFT;
> > +                       sq_power_throttle2 |=3D
SISLANDS_DPM2_SQ_RAMP_MAX_POWER_DELTA <<
SQ_POWER_THROTTLE2__MAX_POWER_DELTA__SHIFT;
> > +                       sq_power_throttle2 |=3D
SISLANDS_DPM2_SQ_RAMP_STI_SIZE <<
SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE__SHIFT;
> > +                       sq_power_throttle2 |=3D
SISLANDS_DPM2_SQ_RAMP_LTI_RATIO <<
SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO__SHIFT;
> >                 } else {
> > -                       sq_power_throttle |=3D MAX_POWER_MASK |
MIN_POWER_MASK;
> > -                       sq_power_throttle2 |=3D MAX_POWER_DELTA_MASK |
STI_SIZE_MASK | LTI_RATIO_MASK;
> > +                       sq_power_throttle |=3D
SQ_POWER_THROTTLE__MAX_POWER_MASK |
> > +
 SQ_POWER_THROTTLE__MIN_POWER_MASK;
> > +                       sq_power_throttle2 |=3D
SQ_POWER_THROTTLE2__MAX_POWER_DELTA_MASK |
> > +
 SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE_MASK |
> > +
 SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO_MASK;
> >                 }
> >
> >                 smc_state->levels[i].SQPowerThrottle =3D
cpu_to_be32(sq_power_throttle);
> > @@ -2777,9 +2780,9 @@ static int si_initialize_smc_cac_tables(struct
amdgpu_device *adev)
> >         if (!cac_tables)
> >                 return -ENOMEM;
> >
> > -       reg =3D RREG32(CG_CAC_CTRL) & ~CAC_WINDOW_MASK;
> > -       reg |=3D CAC_WINDOW(si_pi->powertune_data->cac_window);
> > -       WREG32(CG_CAC_CTRL, reg);
> > +       reg =3D RREG32(ixCG_CAC_CTRL) & ~CG_CAC_CTRL__CAC_WINDOW_MASK;
> > +       reg |=3D (si_pi->powertune_data->cac_window <<
CG_CAC_CTRL__CAC_WINDOW__SHIFT);
> > +       WREG32(ixCG_CAC_CTRL, reg);
> >
> >         si_pi->dyn_powertune_data.cac_leakage =3D
adev->pm.dpm.cac_leakage;
> >         si_pi->dyn_powertune_data.dc_pwr_value =3D
> > @@ -2978,10 +2981,10 @@ static int si_init_smc_spll_table(struct
amdgpu_device *adev)
> >                 ret =3D si_calculate_sclk_params(adev, sclk,
&sclk_params);
> >                 if (ret)
> >                         break;
> > -               p_div =3D (sclk_params.vCG_SPLL_FUNC_CNTL &
SPLL_PDIV_A_MASK) >> SPLL_PDIV_A_SHIFT;
> > -               fb_div =3D (sclk_params.vCG_SPLL_FUNC_CNTL_3 &
SPLL_FB_DIV_MASK) >> SPLL_FB_DIV_SHIFT;
> > -               clk_s =3D (sclk_params.vCG_SPLL_SPREAD_SPECTRUM &
CLK_S_MASK) >> CLK_S_SHIFT;
> > -               clk_v =3D (sclk_params.vCG_SPLL_SPREAD_SPECTRUM_2 &
CLK_V_MASK) >> CLK_V_SHIFT;
> > +               p_div =3D (sclk_params.vCG_SPLL_FUNC_CNTL &
CG_SPLL_FUNC_CNTL__SPLL_PDIV_A_MASK) >>
CG_SPLL_FUNC_CNTL__SPLL_PDIV_A__SHIFT;
> > +               fb_div =3D (sclk_params.vCG_SPLL_FUNC_CNTL_3 &
CG_SPLL_FUNC_CNTL_3__SPLL_FB_DIV_MASK) >>
CG_SPLL_FUNC_CNTL_3__SPLL_FB_DIV__SHIFT;
> > +               clk_s =3D (sclk_params.vCG_SPLL_SPREAD_SPECTRUM &
CG_SPLL_SPREAD_SPECTRUM__CLK_S_MASK) >>
CG_SPLL_SPREAD_SPECTRUM__CLK_S__SHIFT;
> > +               clk_v =3D (sclk_params.vCG_SPLL_SPREAD_SPECTRUM_2 &
CG_SPLL_SPREAD_SPECTRUM_2__CLK_V_MASK) >>
CG_SPLL_SPREAD_SPECTRUM_2__CLK_V__SHIFT;
> >
> >                 fb_div &=3D ~0x00001FFF;
> >                 fb_div >>=3D 1;
> > @@ -3685,10 +3688,10 @@ static bool si_is_special_1gb_platform(struct
amdgpu_device *adev)
> >         WREG32(MC_SEQ_IO_DEBUG_INDEX, 0xb);
> >         width =3D ((RREG32(MC_SEQ_IO_DEBUG_DATA) >> 1) & 1) ? 16 : 32;
> >
> > -       tmp =3D RREG32(MC_ARB_RAMCFG);
> > -       row =3D ((tmp & NOOFROWS_MASK) >> NOOFROWS_SHIFT) + 10;
> > -       column =3D ((tmp & NOOFCOLS_MASK) >> NOOFCOLS_SHIFT) + 8;
> > -       bank =3D ((tmp & NOOFBANK_MASK) >> NOOFBANK_SHIFT) + 2;
> > +       tmp =3D RREG32(mmMC_ARB_RAMCFG);
> > +       row =3D ((tmp & MC_ARB_RAMCFG__NOOFROWS_MASK) >>
MC_ARB_RAMCFG__NOOFROWS__SHIFT) + 10;
> > +       column =3D ((tmp & MC_ARB_RAMCFG__NOOFCOLS_MASK) >>
MC_ARB_RAMCFG__NOOFCOLS__SHIFT) + 8;
> > +       bank =3D ((tmp & MC_ARB_RAMCFG__NOOFBANK_MASK) >>
MC_ARB_RAMCFG__NOOFBANK__SHIFT) + 2;
> >
> >         density =3D (1 << (row + column - 20 + bank)) * width;
> >
> > @@ -3772,11 +3775,11 @@ static void si_set_dpm_event_sources(struct
amdgpu_device *adev, u32 sources)
> >         }
> >
> >         if (want_thermal_protection) {
> > -               WREG32_P(CG_THERMAL_CTRL, DPM_EVENT_SRC(dpm_event_src),
~DPM_EVENT_SRC_MASK);
> > +               WREG32_P(ixCG_THERMAL_CTRL, dpm_event_src <<
CG_THERMAL_CTRL__DPM_EVENT_SRC__SHIFT,
~CG_THERMAL_CTRL__DPM_EVENT_SRC_MASK);
> >                 if (pi->thermal_protection)
> > -                       WREG32_P(GENERAL_PWRMGT, 0,
~THERMAL_PROTECTION_DIS);
> > +                       WREG32_P(ixGENERAL_PWRMGT, 0,
~GENERAL_PWRMGT__THERMAL_PROTECTION_DIS_MASK);
> >         } else {
> > -               WREG32_P(GENERAL_PWRMGT, THERMAL_PROTECTION_DIS,
~THERMAL_PROTECTION_DIS);
> > +               WREG32_P(ixGENERAL_PWRMGT,
GENERAL_PWRMGT__THERMAL_PROTECTION_DIS_MASK,
~GENERAL_PWRMGT__THERMAL_PROTECTION_DIS_MASK);
> >         }
> >  }
> >
> > @@ -3801,20 +3804,20 @@ static void
si_enable_auto_throttle_source(struct amdgpu_device *adev,
> >
> >  static void si_start_dpm(struct amdgpu_device *adev)
> >  {
> > -       WREG32_P(GENERAL_PWRMGT, GLOBAL_PWRMGT_EN, ~GLOBAL_PWRMGT_EN);
> > +       WREG32_P(ixGENERAL_PWRMGT,
GENERAL_PWRMGT__GLOBAL_PWRMGT_EN_MASK,
~GENERAL_PWRMGT__GLOBAL_PWRMGT_EN_MASK);
> >  }
> >
> >  static void si_stop_dpm(struct amdgpu_device *adev)
> >  {
> > -       WREG32_P(GENERAL_PWRMGT, 0, ~GLOBAL_PWRMGT_EN);
> > +       WREG32_P(ixGENERAL_PWRMGT, 0,
~GENERAL_PWRMGT__GLOBAL_PWRMGT_EN_MASK);
> >  }
> >
> >  static void si_enable_sclk_control(struct amdgpu_device *adev, bool
enable)
> >  {
> >         if (enable)
> > -               WREG32_P(SCLK_PWRMGT_CNTL, 0, ~SCLK_PWRMGT_OFF);
> > +               WREG32_P(ixSCLK_PWRMGT_CNTL, 0,
~SCLK_PWRMGT_CNTL__SCLK_PWRMGT_OFF_MASK);
> >         else
> > -               WREG32_P(SCLK_PWRMGT_CNTL, SCLK_PWRMGT_OFF,
~SCLK_PWRMGT_OFF);
> > +               WREG32_P(ixSCLK_PWRMGT_CNTL,
SCLK_PWRMGT_CNTL__SCLK_PWRMGT_OFF_MASK,
~SCLK_PWRMGT_CNTL__SCLK_PWRMGT_OFF_MASK);
> >
> >  }
> >
> > @@ -3854,7 +3857,7 @@ static int si_notify_hw_of_powersource(struct
amdgpu_device *adev, bool ac_power
> >  static PPSMC_Result si_send_msg_to_smc_with_parameter(struct
amdgpu_device *adev,
> >                                                       PPSMC_Msg msg,
u32 parameter)
> >  {
> > -       WREG32(SMC_SCRATCH0, parameter);
> > +       WREG32(ixSMC_SCRATCH0, parameter);
> >         return amdgpu_si_send_msg_to_smc(adev, msg);
> >  }
> >
> > @@ -4039,12 +4042,12 @@ static void si_read_clock_registers(struct
amdgpu_device *adev)
> >  {
> >         struct si_power_info *si_pi =3D si_get_pi(adev);
> >
> > -       si_pi->clock_registers.cg_spll_func_cntl =3D
RREG32(CG_SPLL_FUNC_CNTL);
> > -       si_pi->clock_registers.cg_spll_func_cntl_2 =3D
RREG32(CG_SPLL_FUNC_CNTL_2);
> > -       si_pi->clock_registers.cg_spll_func_cntl_3 =3D
RREG32(CG_SPLL_FUNC_CNTL_3);
> > -       si_pi->clock_registers.cg_spll_func_cntl_4 =3D
RREG32(CG_SPLL_FUNC_CNTL_4);
> > -       si_pi->clock_registers.cg_spll_spread_spectrum =3D
RREG32(CG_SPLL_SPREAD_SPECTRUM);
> > -       si_pi->clock_registers.cg_spll_spread_spectrum_2 =3D
RREG32(CG_SPLL_SPREAD_SPECTRUM_2);
> > +       si_pi->clock_registers.cg_spll_func_cntl =3D
RREG32(ixCG_SPLL_FUNC_CNTL);
> > +       si_pi->clock_registers.cg_spll_func_cntl_2 =3D
RREG32(ixCG_SPLL_FUNC_CNTL_2);
> > +       si_pi->clock_registers.cg_spll_func_cntl_3 =3D
RREG32(ixCG_SPLL_FUNC_CNTL_3);
> > +       si_pi->clock_registers.cg_spll_func_cntl_4 =3D
RREG32(ixCG_SPLL_FUNC_CNTL_4);
> > +       si_pi->clock_registers.cg_spll_spread_spectrum =3D
RREG32(ixCG_SPLL_SPREAD_SPECTRUM);
> > +       si_pi->clock_registers.cg_spll_spread_spectrum_2 =3D
RREG32(ixCG_SPLL_SPREAD_SPECTRUM_2);
> >         si_pi->clock_registers.dll_cntl =3D RREG32(DLL_CNTL);
> >         si_pi->clock_registers.mclk_pwrmgt_cntl =3D
RREG32(MCLK_PWRMGT_CNTL);
> >         si_pi->clock_registers.mpll_ad_func_cntl =3D
RREG32(MPLL_AD_FUNC_CNTL);
> > @@ -4060,14 +4063,14 @@ static void si_enable_thermal_protection(struct
amdgpu_device *adev,
> >                                           bool enable)
> >  {
> >         if (enable)
> > -               WREG32_P(GENERAL_PWRMGT, 0, ~THERMAL_PROTECTION_DIS);
> > +               WREG32_P(ixGENERAL_PWRMGT, 0,
~GENERAL_PWRMGT__THERMAL_PROTECTION_DIS_MASK);
> >         else
> > -               WREG32_P(GENERAL_PWRMGT, THERMAL_PROTECTION_DIS,
~THERMAL_PROTECTION_DIS);
> > +               WREG32_P(ixGENERAL_PWRMGT,
GENERAL_PWRMGT__THERMAL_PROTECTION_DIS_MASK,
~GENERAL_PWRMGT__THERMAL_PROTECTION_DIS_MASK);
> >  }
> >
> >  static void si_enable_acpi_power_management(struct amdgpu_device *adev=
)
> >  {
> > -       WREG32_P(GENERAL_PWRMGT, STATIC_PM_EN, ~STATIC_PM_EN);
> > +       WREG32_P(ixGENERAL_PWRMGT, GENERAL_PWRMGT__STATIC_PM_EN_MASK,
~GENERAL_PWRMGT__STATIC_PM_EN_MASK);
> >  }
> >
> >  #if 0
> > @@ -4148,9 +4151,9 @@ static void si_program_ds_registers(struct
amdgpu_device *adev)
> >                 tmp =3D 0x1;
> >
> >         if (eg_pi->sclk_deep_sleep) {
> > -               WREG32_P(MISC_CLK_CNTL, DEEP_SLEEP_CLK_SEL(tmp),
~DEEP_SLEEP_CLK_SEL_MASK);
> > -               WREG32_P(CG_SPLL_AUTOSCALE_CNTL, AUTOSCALE_ON_SS_CLEAR,
> > -                        ~AUTOSCALE_ON_SS_CLEAR);
> > +               WREG32_P(ixMISC_CLK_CNTL, (tmp <<
MISC_CLK_CNTL__DEEP_SLEEP_CLK_SEL__SHIFT),
~MISC_CLK_CNTL__DEEP_SLEEP_CLK_SEL_MASK);
> > +               WREG32_P(ixCG_SPLL_AUTOSCALE_CNTL,
CG_SPLL_AUTOSCALE_CNTL__AUTOSCALE_ON_SS_CLEAR_MASK,
> > +
~CG_SPLL_AUTOSCALE_CNTL__AUTOSCALE_ON_SS_CLEAR_MASK);
> >         }
> >  }
> >
> > @@ -4159,18 +4162,18 @@ static void si_program_display_gap(struct
amdgpu_device *adev)
> >         u32 tmp, pipe;
> >         int i;
> >
> > -       tmp =3D RREG32(CG_DISPLAY_GAP_CNTL) & ~(DISP1_GAP_MASK |
DISP2_GAP_MASK);
> > +       tmp =3D RREG32(ixCG_DISPLAY_GAP_CNTL) &
~(CG_DISPLAY_GAP_CNTL__DISP1_GAP_MASK |
CG_DISPLAY_GAP_CNTL__DISP2_GAP_MASK);
> >         if (adev->pm.dpm.new_active_crtc_count > 0)
> > -               tmp |=3D DISP1_GAP(R600_PM_DISPLAY_GAP_VBLANK_OR_WM);
> > +               tmp |=3D R600_PM_DISPLAY_GAP_VBLANK_OR_WM <<
CG_DISPLAY_GAP_CNTL__DISP1_GAP__SHIFT;
> >         else
> > -               tmp |=3D DISP1_GAP(R600_PM_DISPLAY_GAP_IGNORE);
> > +               tmp |=3D R600_PM_DISPLAY_GAP_IGNORE <<
CG_DISPLAY_GAP_CNTL__DISP1_GAP__SHIFT;
> >
> >         if (adev->pm.dpm.new_active_crtc_count > 1)
> > -               tmp |=3D DISP2_GAP(R600_PM_DISPLAY_GAP_VBLANK_OR_WM);
> > +               tmp |=3D R600_PM_DISPLAY_GAP_VBLANK_OR_WM <<
CG_DISPLAY_GAP_CNTL__DISP2_GAP__SHIFT;
> >         else
> > -               tmp |=3D DISP2_GAP(R600_PM_DISPLAY_GAP_IGNORE);
> > +               tmp |=3D R600_PM_DISPLAY_GAP_IGNORE <<
CG_DISPLAY_GAP_CNTL__DISP2_GAP__SHIFT;
> >
> > -       WREG32(CG_DISPLAY_GAP_CNTL, tmp);
> > +       WREG32(ixCG_DISPLAY_GAP_CNTL, tmp);
> >
> >         tmp =3D RREG32(DCCG_DISP_SLOW_SELECT_REG);
> >         pipe =3D (tmp & DCCG_DISP1_SLOW_SELECT_MASK) >>
DCCG_DISP1_SLOW_SELECT_SHIFT;
> > @@ -4205,10 +4208,10 @@ static void si_enable_spread_spectrum(struct
amdgpu_device *adev, bool enable)
> >
> >         if (enable) {
> >                 if (pi->sclk_ss)
> > -                       WREG32_P(GENERAL_PWRMGT,
DYN_SPREAD_SPECTRUM_EN, ~DYN_SPREAD_SPECTRUM_EN);
> > +                       WREG32_P(ixGENERAL_PWRMGT,
GENERAL_PWRMGT__DYN_SPREAD_SPECTRUM_EN_MASK,
~GENERAL_PWRMGT__DYN_SPREAD_SPECTRUM_EN_MASK);
> >         } else {
> > -               WREG32_P(CG_SPLL_SPREAD_SPECTRUM, 0, ~SSEN);
> > -               WREG32_P(GENERAL_PWRMGT, 0, ~DYN_SPREAD_SPECTRUM_EN);
> > +               WREG32_P(ixCG_SPLL_SPREAD_SPECTRUM, 0,
~CG_SPLL_SPREAD_SPECTRUM__SSEN_MASK);
> > +               WREG32_P(ixGENERAL_PWRMGT, 0,
~GENERAL_PWRMGT__DYN_SPREAD_SPECTRUM_EN_MASK);
> >         }
> >  }
> >
> > @@ -4230,15 +4233,15 @@ static void si_setup_bsp(struct amdgpu_device
*adev)
> >                                &pi->pbsu);
> >
> >
> > -        pi->dsp =3D BSP(pi->bsp) | BSU(pi->bsu);
> > -       pi->psp =3D BSP(pi->pbsp) | BSU(pi->pbsu);
> > +        pi->dsp =3D (pi->bsp << CG_BSP__BSP__SHIFT) | (pi->bsu <<
CG_BSP__BSU__SHIFT);
> > +       pi->psp =3D (pi->pbsp << CG_BSP__BSP__SHIFT) | (pi->pbsu <<
CG_BSP__BSU__SHIFT);
> >
> > -       WREG32(CG_BSP, pi->dsp);
> > +       WREG32(ixCG_BSP, pi->dsp);
> >  }
> >
> >  static void si_program_git(struct amdgpu_device *adev)
> >  {
> > -       WREG32_P(CG_GIT, CG_GICST(R600_GICST_DFLT), ~CG_GICST_MASK);
> > +       WREG32_P(ixCG_GIT, R600_GICST_DFLT << CG_GIT__CG_GICST__SHIFT,
~CG_GIT__CG_GICST_MASK);
> >  }
> >
> >  static void si_program_tp(struct amdgpu_device *adev)
> > @@ -4247,54 +4250,54 @@ static void si_program_tp(struct amdgpu_device
*adev)
> >         enum r600_td td =3D R600_TD_DFLT;
> >
> >         for (i =3D 0; i < R600_PM_NUMBER_OF_TC; i++)
> > -               WREG32(CG_FFCT_0 + i, (UTC_0(r600_utc[i]) |
DTC_0(r600_dtc[i])));
> > +               WREG32(ixCG_FFCT_0 + i, (r600_utc[i] <<
CG_FFCT_0__UTC_0__SHIFT | r600_dtc[i] << CG_FFCT_0__DTC_0__SHIFT));
> >
> >         if (td =3D=3D R600_TD_AUTO)
> > -               WREG32_P(SCLK_PWRMGT_CNTL, 0, ~FIR_FORCE_TREND_SEL);
> > +               WREG32_P(ixSCLK_PWRMGT_CNTL, 0,
~SCLK_PWRMGT_CNTL__FIR_FORCE_TREND_SEL_MASK);
> >         else
> > -               WREG32_P(SCLK_PWRMGT_CNTL, FIR_FORCE_TREND_SEL,
~FIR_FORCE_TREND_SEL);
> > +               WREG32_P(ixSCLK_PWRMGT_CNTL,
SCLK_PWRMGT_CNTL__FIR_FORCE_TREND_SEL_MASK,
~SCLK_PWRMGT_CNTL__FIR_FORCE_TREND_SEL_MASK);
> >
> >         if (td =3D=3D R600_TD_UP)
> > -               WREG32_P(SCLK_PWRMGT_CNTL, 0, ~FIR_TREND_MODE);
> > +               WREG32_P(ixSCLK_PWRMGT_CNTL, 0,
~SCLK_PWRMGT_CNTL__FIR_TREND_MODE_MASK);
> >
> >         if (td =3D=3D R600_TD_DOWN)
> > -               WREG32_P(SCLK_PWRMGT_CNTL, FIR_TREND_MODE,
~FIR_TREND_MODE);
> > +               WREG32_P(ixSCLK_PWRMGT_CNTL,
SCLK_PWRMGT_CNTL__FIR_TREND_MODE_MASK,
~SCLK_PWRMGT_CNTL__FIR_TREND_MODE_MASK);
> >  }
> >
> >  static void si_program_tpp(struct amdgpu_device *adev)
> >  {
> > -       WREG32(CG_TPC, R600_TPC_DFLT);
> > +       WREG32(ixCG_TPC, R600_TPC_DFLT);
> >  }
> >
> >  static void si_program_sstp(struct amdgpu_device *adev)
> >  {
> > -       WREG32(CG_SSP, (SSTU(R600_SSTU_DFLT) | SST(R600_SST_DFLT)));
> > +       WREG32(ixCG_SSP, (R600_SSTU_DFLT << CG_SSP__SSTU__SHIFT|
R600_SST_DFLT << CG_SSP__SST__SHIFT));
> >  }
> >
> >  static void si_enable_display_gap(struct amdgpu_device *adev)
> >  {
> > -       u32 tmp =3D RREG32(CG_DISPLAY_GAP_CNTL);
> > +       u32 tmp =3D RREG32(ixCG_DISPLAY_GAP_CNTL);
> >
> > -       tmp &=3D ~(DISP1_GAP_MASK | DISP2_GAP_MASK);
> > -       tmp |=3D (DISP1_GAP(R600_PM_DISPLAY_GAP_IGNORE) |
> > -               DISP2_GAP(R600_PM_DISPLAY_GAP_IGNORE));
> > +       tmp &=3D ~(CG_DISPLAY_GAP_CNTL__DISP1_GAP_MASK |
CG_DISPLAY_GAP_CNTL__DISP2_GAP_MASK);
> > +       tmp |=3D (R600_PM_DISPLAY_GAP_IGNORE <<
CG_DISPLAY_GAP_CNTL__DISP1_GAP__SHIFT |
> > +               R600_PM_DISPLAY_GAP_IGNORE <<
CG_DISPLAY_GAP_CNTL__DISP2_GAP__SHIFT);
> >
> > -       tmp &=3D ~(DISP1_GAP_MCHG_MASK | DISP2_GAP_MCHG_MASK);
> > -       tmp |=3D (DISP1_GAP_MCHG(R600_PM_DISPLAY_GAP_VBLANK) |
> > -               DISP2_GAP_MCHG(R600_PM_DISPLAY_GAP_IGNORE));
> > -       WREG32(CG_DISPLAY_GAP_CNTL, tmp);
> > +       tmp &=3D ~(CG_DISPLAY_GAP_CNTL__DISP1_GAP_MCHG_MASK |
CG_DISPLAY_GAP_CNTL__DISP2_GAP_MCHG_MASK);
> > +       tmp |=3D (R600_PM_DISPLAY_GAP_VBLANK <<
CG_DISPLAY_GAP_CNTL__DISP1_GAP_MCHG__SHIFT |
> > +               R600_PM_DISPLAY_GAP_IGNORE <<
CG_DISPLAY_GAP_CNTL__DISP2_GAP_MCHG__SHIFT);
> > +       WREG32(ixCG_DISPLAY_GAP_CNTL, tmp);
> >  }
> >
> >  static void si_program_vc(struct amdgpu_device *adev)
> >  {
> >         struct rv7xx_power_info *pi =3D rv770_get_pi(adev);
> >
> > -       WREG32(CG_FTV, pi->vrc);
> > +       WREG32(ixCG_FTV, pi->vrc);
> >  }
> >
> >  static void si_clear_vc(struct amdgpu_device *adev)
> >  {
> > -       WREG32(CG_FTV, 0);
> > +       WREG32(ixCG_FTV, 0);
> >  }
> >
> >  static u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_clock)
> > @@ -4751,7 +4754,7 @@ static u32
si_calculate_memory_refresh_rate(struct amdgpu_device *adev,
> >         u32 dram_rows;
> >         u32 dram_refresh_rate;
> >         u32 mc_arb_rfsh_rate;
> > -       u32 tmp =3D (RREG32(MC_ARB_RAMCFG) & NOOFROWS_MASK) >>
NOOFROWS_SHIFT;
> > +       u32 tmp =3D (RREG32(mmMC_ARB_RAMCFG) &
MC_ARB_RAMCFG__NOOFROWS_MASK) >> MC_ARB_RAMCFG__NOOFROWS__SHIFT;
> >
> >         if (tmp >=3D 4)
> >                 dram_rows =3D 16384;
> > @@ -4925,7 +4928,7 @@ static int si_populate_smc_initial_state(struct
amdgpu_device *adev,
> >
> >         si_populate_initial_mvdd_value(adev,
&table->initialState.level.mvdd);
> >
> > -       reg =3D CG_R(0xffff) | CG_L(0);
> > +       reg =3D 0xffff << CG_AT__CG_R__SHIFT | 0 << CG_AT__CG_L__SHIFT;
> >         table->initialState.level.aT =3D cpu_to_be32(reg);
> >         table->initialState.level.bSP =3D cpu_to_be32(pi->dsp);
> >         table->initialState.level.gen2PCIE =3D (u8)si_pi->boot_pcie_gen=
;
> > @@ -4951,10 +4954,13 @@ static int si_populate_smc_initial_state(struct
amdgpu_device *adev,
> >         table->initialState.level.dpm2.BelowSafeInc =3D 0;
> >         table->initialState.level.dpm2.PwrEfficiencyRatio =3D 0;
> >
> > -       reg =3D MIN_POWER_MASK | MAX_POWER_MASK;
> > +       reg =3D SQ_POWER_THROTTLE__MIN_POWER_MASK |
> > +               SQ_POWER_THROTTLE__MAX_POWER_MASK;
> >         table->initialState.level.SQPowerThrottle =3D cpu_to_be32(reg);
> >
> > -       reg =3D MAX_POWER_DELTA_MASK | STI_SIZE_MASK | LTI_RATIO_MASK;
> > +       reg =3D SQ_POWER_THROTTLE2__MAX_POWER_DELTA_MASK |
> > +               SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE_MASK |
> > +               SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO_MASK;
> >         table->initialState.level.SQPowerThrottle_2 =3D cpu_to_be32(reg=
);
> >
> >         return 0;
> > @@ -5073,8 +5079,8 @@ static int si_populate_smc_acpi_state(struct
amdgpu_device *adev,
> >
> >         dll_cntl &=3D ~(MRDCK0_BYPASS | MRDCK1_BYPASS);
> >
> > -       spll_func_cntl_2 &=3D ~SCLK_MUX_SEL_MASK;
> > -       spll_func_cntl_2 |=3D SCLK_MUX_SEL(4);
> > +       spll_func_cntl_2 &=3D ~CG_SPLL_FUNC_CNTL_2__SCLK_MUX_SEL_MASK;
> > +       spll_func_cntl_2 |=3D 4 <<
CG_SPLL_FUNC_CNTL_2__SCLK_MUX_SEL__SHIFT;
> >
> >         table->ACPIState.level.mclk.vDLL_CNTL =3D
> >                 cpu_to_be32(dll_cntl);
> > @@ -5118,10 +5124,10 @@ static int si_populate_smc_acpi_state(struct
amdgpu_device *adev,
> >         table->ACPIState.level.dpm2.BelowSafeInc =3D 0;
> >         table->ACPIState.level.dpm2.PwrEfficiencyRatio =3D 0;
> >
> > -       reg =3D MIN_POWER_MASK | MAX_POWER_MASK;
> > +       reg =3D SQ_POWER_THROTTLE__MIN_POWER_MASK |
SQ_POWER_THROTTLE__MAX_POWER_MASK;
> >         table->ACPIState.level.SQPowerThrottle =3D cpu_to_be32(reg);
> >
> > -       reg =3D MAX_POWER_DELTA_MASK | STI_SIZE_MASK | LTI_RATIO_MASK;
> > +       reg =3D SQ_POWER_THROTTLE2__MAX_POWER_DELTA_MASK |
SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE_MASK |
SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO_MASK;
> >         table->ACPIState.level.SQPowerThrottle_2 =3D cpu_to_be32(reg);
> >
> >         return 0;
> > @@ -5266,8 +5272,8 @@ static int si_init_smc_table(struct amdgpu_device
*adev)
> >                 if (ret)
> >                         return ret;
> >
> > -               WREG32(CG_ULV_CONTROL, ulv->cg_ulv_control);
> > -               WREG32(CG_ULV_PARAMETER, ulv->cg_ulv_parameter);
> > +               WREG32(ixCG_ULV_CONTROL, ulv->cg_ulv_control);
> > +               WREG32(ixCG_ULV_PARAMETER, ulv->cg_ulv_parameter);
> >
> >                 lane_width =3D amdgpu_get_pcie_lanes(adev);
> >                 si_write_smc_soft_register(adev,
SI_SMC_SOFT_REGISTER_non_ulv_pcie_link_width, lane_width);
> > @@ -5310,16 +5316,16 @@ static int si_calculate_sclk_params(struct
amdgpu_device *adev,
> >         do_div(tmp, reference_clock);
> >         fbdiv =3D (u32) tmp;
> >
> > -       spll_func_cntl &=3D ~(SPLL_PDIV_A_MASK | SPLL_REF_DIV_MASK);
> > -       spll_func_cntl |=3D SPLL_REF_DIV(dividers.ref_div);
> > -       spll_func_cntl |=3D SPLL_PDIV_A(dividers.post_div);
> > +       spll_func_cntl &=3D ~(CG_SPLL_FUNC_CNTL__SPLL_PDIV_A_MASK |
CG_SPLL_FUNC_CNTL__SPLL_REF_DIV_MASK);
> > +       spll_func_cntl |=3D dividers.ref_div <<
CG_SPLL_FUNC_CNTL__SPLL_REF_DIV__SHIFT;
> > +       spll_func_cntl |=3D dividers.post_div <<
CG_SPLL_FUNC_CNTL__SPLL_PDIV_A__SHIFT;
> >
> > -       spll_func_cntl_2 &=3D ~SCLK_MUX_SEL_MASK;
> > -       spll_func_cntl_2 |=3D SCLK_MUX_SEL(2);
> > +       spll_func_cntl_2 &=3D ~CG_SPLL_FUNC_CNTL_2__SCLK_MUX_SEL_MASK;
> > +       spll_func_cntl_2 |=3D 2 <<
CG_SPLL_FUNC_CNTL_2__SCLK_MUX_SEL__SHIFT;
> >
> > -       spll_func_cntl_3 &=3D ~SPLL_FB_DIV_MASK;
> > -       spll_func_cntl_3 |=3D SPLL_FB_DIV(fbdiv);
> > -       spll_func_cntl_3 |=3D SPLL_DITHEN;
> > +       spll_func_cntl_3 &=3D ~CG_SPLL_FUNC_CNTL_3__SPLL_FB_DIV_MASK;
> > +       spll_func_cntl_3 |=3D fbdiv <<
CG_SPLL_FUNC_CNTL_3__SPLL_FB_DIV__SHIFT;
> > +       spll_func_cntl_3 |=3D CG_SPLL_FUNC_CNTL_3__SPLL_DITHEN_MASK;
> >
> >         if (pi->sclk_ss) {
> >                 struct amdgpu_atom_ss ss;
> > @@ -5330,12 +5336,12 @@ static int si_calculate_sclk_params(struct
amdgpu_device *adev,
> >                         u32 clk_s =3D reference_clock * 5 /
(reference_divider * ss.rate);
> >                         u32 clk_v =3D 4 * ss.percentage * fbdiv / (clk_=
s
* 10000);
> >
> > -                       cg_spll_spread_spectrum &=3D ~CLK_S_MASK;
> > -                       cg_spll_spread_spectrum |=3D CLK_S(clk_s);
> > -                       cg_spll_spread_spectrum |=3D SSEN;
> > +                       cg_spll_spread_spectrum &=3D
~CG_SPLL_SPREAD_SPECTRUM__CLK_S_MASK;
> > +                       cg_spll_spread_spectrum |=3D clk_s <<
CG_SPLL_SPREAD_SPECTRUM__CLK_S__SHIFT;
> > +                       cg_spll_spread_spectrum |=3D
CG_SPLL_SPREAD_SPECTRUM__SSEN_MASK;
> >
> > -                       cg_spll_spread_spectrum_2 &=3D ~CLK_V_MASK;
> > -                       cg_spll_spread_spectrum_2 |=3D CLK_V(clk_v);
> > +                       cg_spll_spread_spectrum_2 &=3D
~CG_SPLL_SPREAD_SPECTRUM_2__CLK_V_MASK;
> > +                       cg_spll_spread_spectrum_2 |=3D clk_v <<
CG_SPLL_SPREAD_SPECTRUM_2__CLK_V__SHIFT;
> >                 }
> >         }
> >
> > @@ -5501,7 +5507,7 @@ static int si_convert_power_level_to_smc(struct
amdgpu_device *adev,
> >         if (pi->mclk_stutter_mode_threshold &&
> >             (pl->mclk <=3D pi->mclk_stutter_mode_threshold) &&
> >             !eg_pi->uvd_enabled &&
> > -           (RREG32(DPG_PIPE_STUTTER_CONTROL) & STUTTER_ENABLE) &&
> > +           (RREG32(mmDPG_PIPE_STUTTER_CONTROL) &
DPG_PIPE_STUTTER_CONTROL__STUTTER_ENABLE_MASK) &&
> >             (adev->pm.dpm.new_active_crtc_count <=3D 2)) {
> >                 level->mcFlags |=3D SISLANDS_SMC_MC_STUTTER_EN;
> >         }
> > @@ -5595,7 +5601,7 @@ static int si_populate_smc_t(struct amdgpu_device
*adev,
> >                 return -EINVAL;
> >
> >         if (state->performance_level_count < 2) {
> > -               a_t =3D CG_R(0xffff) | CG_L(0);
> > +               a_t =3D 0xffff << CG_AT__CG_R__SHIFT | 0 <<
CG_AT__CG_L__SHIFT;
> >                 smc_state->levels[0].aT =3D cpu_to_be32(a_t);
> >                 return 0;
> >         }
> > @@ -5616,13 +5622,13 @@ static int si_populate_smc_t(struct
amdgpu_device *adev,
> >                         t_l =3D (i + 1) * 1000 + 50 * R600_AH_DFLT;
> >                 }
> >
> > -               a_t =3D be32_to_cpu(smc_state->levels[i].aT) & ~CG_R_MA=
SK;
> > -               a_t |=3D CG_R(t_l * pi->bsp / 20000);
> > +               a_t =3D be32_to_cpu(smc_state->levels[i].aT) &
~CG_AT__CG_R_MASK;
> > +               a_t |=3D (t_l * pi->bsp / 20000) << CG_AT__CG_R__SHIFT;
> >                 smc_state->levels[i].aT =3D cpu_to_be32(a_t);
> >
> >                 high_bsp =3D (i =3D=3D state->performance_level_count -=
 2) ?
> >                         pi->pbsp : pi->bsp;
> > -               a_t =3D CG_R(0xffff) | CG_L(t_h * high_bsp / 20000);
> > +               a_t =3D (0xffff) << CG_AT__CG_R__SHIFT | (t_h * high_bs=
p
/ 20000) << CG_AT__CG_L__SHIFT;
> >                 smc_state->levels[i + 1].aT =3D cpu_to_be32(a_t);
> >         }
> >
> > @@ -6196,9 +6202,9 @@ static int si_upload_mc_reg_table(struct
amdgpu_device *adev,
> >  static void si_enable_voltage_control(struct amdgpu_device *adev, bool
enable)
> >  {
> >         if (enable)
> > -               WREG32_P(GENERAL_PWRMGT, VOLT_PWRMGT_EN,
~VOLT_PWRMGT_EN);
> > +               WREG32_P(ixGENERAL_PWRMGT,
GENERAL_PWRMGT__VOLT_PWRMGT_EN_MASK, ~GENERAL_PWRMGT__VOLT_PWRMGT_EN_MASK);
> >         else
> > -               WREG32_P(GENERAL_PWRMGT, 0, ~VOLT_PWRMGT_EN);
> > +               WREG32_P(ixGENERAL_PWRMGT, 0,
~GENERAL_PWRMGT__VOLT_PWRMGT_EN_MASK);
> >  }
> >
> >  static enum si_pcie_gen si_get_maximum_link_speed(struct amdgpu_device
*adev,
> > @@ -6220,8 +6226,8 @@ static u16 si_get_current_pcie_speed(struct
amdgpu_device *adev)
> >  {
> >         u32 speed_cntl;
> >
> > -       speed_cntl =3D RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL) &
LC_CURRENT_DATA_RATE_MASK;
> > -       speed_cntl >>=3D LC_CURRENT_DATA_RATE_SHIFT;
> > +       speed_cntl =3D RREG32_PCIE_PORT(ixPCIE_LC_SPEED_CNTL) &
PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK;
> > +       speed_cntl >>=3D PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIF=
T;
> >
> >         return (u16)speed_cntl;
> >  }
> > @@ -6428,21 +6434,21 @@ static void si_dpm_setup_asic(struct
amdgpu_device *adev)
> >  static int si_thermal_enable_alert(struct amdgpu_device *adev,
> >                                    bool enable)
> >  {
> > -       u32 thermal_int =3D RREG32(CG_THERMAL_INT);
> > +       u32 thermal_int =3D RREG32(ixCG_THERMAL_INT);
> >
> >         if (enable) {
> >                 PPSMC_Result result;
> >
> > -               thermal_int &=3D ~(THERM_INT_MASK_HIGH |
THERM_INT_MASK_LOW);
> > -               WREG32(CG_THERMAL_INT, thermal_int);
> > +               thermal_int &=3D
~(CG_THERMAL_INT__THERM_INT_MASK_HIGH_MASK |
CG_THERMAL_INT__THERM_INT_MASK_LOW_MASK);
> > +               WREG32(ixCG_THERMAL_INT, thermal_int);
> >                 result =3D amdgpu_si_send_msg_to_smc(adev,
PPSMC_MSG_EnableThermalInterrupt);
> >                 if (result !=3D PPSMC_Result_OK) {
> >                         DRM_DEBUG_KMS("Could not enable thermal
interrupts.\n");
> >                         return -EINVAL;
> >                 }
> >         } else {
> > -               thermal_int |=3D THERM_INT_MASK_HIGH | THERM_INT_MASK_L=
OW;
> > -               WREG32(CG_THERMAL_INT, thermal_int);
> > +               thermal_int |=3D CG_THERMAL_INT__THERM_INT_MASK_HIGH_MA=
SK
| CG_THERMAL_INT__THERM_INT_MASK_LOW_MASK;
> > +               WREG32(ixCG_THERMAL_INT, thermal_int);
> >         }
> >
> >         return 0;
> > @@ -6463,9 +6469,9 @@ static int
si_thermal_set_temperature_range(struct amdgpu_device *adev,
> >                 return -EINVAL;
> >         }
> >
> > -       WREG32_P(CG_THERMAL_INT, DIG_THERM_INTH(high_temp / 1000),
~DIG_THERM_INTH_MASK);
> > -       WREG32_P(CG_THERMAL_INT, DIG_THERM_INTL(low_temp / 1000),
~DIG_THERM_INTL_MASK);
> > -       WREG32_P(CG_THERMAL_CTRL, DIG_THERM_DPM(high_temp / 1000),
~DIG_THERM_DPM_MASK);
> > +       WREG32_P(ixCG_THERMAL_INT, (high_temp / 1000) <<
CG_THERMAL_INT__DIG_THERM_INTH__SHIFT,
~CG_THERMAL_INT__DIG_THERM_INTH_MASK);
> > +       WREG32_P(ixCG_THERMAL_INT, (low_temp / 1000) <<
CG_THERMAL_INT__DIG_THERM_INTL__SHIFT,
~CG_THERMAL_INT__DIG_THERM_INTL_MASK);
> > +       WREG32_P(ixCG_THERMAL_CTRL, (high_temp / 1000) <<
CG_THERMAL_CTRL__DIG_THERM_DPM__SHIFT,
~CG_THERMAL_CTRL__DIG_THERM_DPM_MASK);
> >
> >         adev->pm.dpm.thermal.min_temp =3D low_temp;
> >         adev->pm.dpm.thermal.max_temp =3D high_temp;
> > @@ -6479,20 +6485,20 @@ static void si_fan_ctrl_set_static_mode(struct
amdgpu_device *adev, u32 mode)
> >         u32 tmp;
> >
> >         if (si_pi->fan_ctrl_is_in_default_mode) {
> > -               tmp =3D (RREG32(CG_FDO_CTRL2) & FDO_PWM_MODE_MASK) >>
FDO_PWM_MODE_SHIFT;
> > +               tmp =3D (RREG32(ixCG_FDO_CTRL2) &
CG_FDO_CTRL2__FDO_PWM_MODE_MASK) >> CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT;
> >                 si_pi->fan_ctrl_default_mode =3D tmp;
> > -               tmp =3D (RREG32(CG_FDO_CTRL2) & TMIN_MASK) >> TMIN_SHIF=
T;
> > +               tmp =3D (RREG32(ixCG_FDO_CTRL2) &
CG_FDO_CTRL2__TMIN_MASK) >> CG_FDO_CTRL2__TMIN__SHIFT;
> >                 si_pi->t_min =3D tmp;
> >                 si_pi->fan_ctrl_is_in_default_mode =3D false;
> >         }
> >
> > -       tmp =3D RREG32(CG_FDO_CTRL2) & ~TMIN_MASK;
> > -       tmp |=3D TMIN(0);
> > -       WREG32(CG_FDO_CTRL2, tmp);
> > +       tmp =3D RREG32(ixCG_FDO_CTRL2) & ~CG_FDO_CTRL2__TMIN_MASK;
> > +       tmp |=3D 0 << CG_FDO_CTRL2__TMIN__SHIFT;
> > +       WREG32(ixCG_FDO_CTRL2, tmp);
> >
> > -       tmp =3D RREG32(CG_FDO_CTRL2) & ~FDO_PWM_MODE_MASK;
> > -       tmp |=3D FDO_PWM_MODE(mode);
> > -       WREG32(CG_FDO_CTRL2, tmp);
> > +       tmp =3D RREG32(ixCG_FDO_CTRL2) & ~CG_FDO_CTRL2__FDO_PWM_MODE_MA=
SK;
> > +       tmp |=3D mode << CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT;
> > +       WREG32(ixCG_FDO_CTRL2, tmp);
> >  }
> >
> >  static int si_thermal_setup_fan_table(struct amdgpu_device *adev)
> > @@ -6511,7 +6517,7 @@ static int si_thermal_setup_fan_table(struct
amdgpu_device *adev)
> >                 return 0;
> >         }
> >
> > -       duty100 =3D (RREG32(CG_FDO_CTRL1) & FMAX_DUTY100_MASK) >>
FMAX_DUTY100_SHIFT;
> > +       duty100 =3D (RREG32(ixCG_FDO_CTRL1) &
CG_FDO_CTRL1__FMAX_DUTY100_MASK) >> CG_FDO_CTRL1__FMAX_DUTY100__SHIFT;
> >
> >         if (duty100 =3D=3D 0) {
> >                 adev->pm.dpm.fan.ucode_fan_control =3D false;
> > @@ -6547,7 +6553,7 @@ static int si_thermal_setup_fan_table(struct
amdgpu_device *adev)
> >                                                 reference_clock) /
1600);
> >         fan_table.fdo_max =3D cpu_to_be16((u16)duty100);
> >
> > -       tmp =3D (RREG32(CG_MULT_THERMAL_CTRL) & TEMP_SEL_MASK) >>
TEMP_SEL_SHIFT;
> > +       tmp =3D (RREG32(ixCG_MULT_THERMAL_CTRL) &
CG_MULT_THERMAL_CTRL__TEMP_SEL_MASK) >>
CG_MULT_THERMAL_CTRL__TEMP_SEL__SHIFT;
> >         fan_table.temp_src =3D (uint8_t)tmp;
> >
> >         ret =3D amdgpu_si_copy_bytes_to_smc(adev,
> > @@ -6606,8 +6612,8 @@ static int si_dpm_get_fan_speed_pwm(void *handle,
> >         if (adev->pm.no_fan)
> >                 return -ENOENT;
> >
> > -       duty100 =3D (RREG32(CG_FDO_CTRL1) & FMAX_DUTY100_MASK) >>
FMAX_DUTY100_SHIFT;
> > -       duty =3D (RREG32(CG_THERMAL_STATUS) & FDO_PWM_DUTY_MASK) >>
FDO_PWM_DUTY_SHIFT;
> > +       duty100 =3D (RREG32(ixCG_FDO_CTRL1) &
CG_FDO_CTRL1__FMAX_DUTY100_MASK) >> CG_FDO_CTRL1__FMAX_DUTY100__SHIFT;
> > +       duty =3D (RREG32(ixCG_THERMAL_STATUS) &
CG_THERMAL_STATUS__FDO_PWM_DUTY_MASK) >>
CG_THERMAL_STATUS__FDO_PWM_DUTY__SHIFT;
> >
> >         if (duty100 =3D=3D 0)
> >                 return -EINVAL;
> > @@ -6637,7 +6643,7 @@ static int si_dpm_set_fan_speed_pwm(void *handle,
> >         if (speed > 255)
> >                 return -EINVAL;
> >
> > -       duty100 =3D (RREG32(CG_FDO_CTRL1) & FMAX_DUTY100_MASK) >>
FMAX_DUTY100_SHIFT;
> > +       duty100 =3D (RREG32(ixCG_FDO_CTRL1) &
CG_FDO_CTRL1__FMAX_DUTY100_MASK) >> CG_FDO_CTRL1__FMAX_DUTY100__SHIFT;
> >
> >         if (duty100 =3D=3D 0)
> >                 return -EINVAL;
> > @@ -6646,9 +6652,9 @@ static int si_dpm_set_fan_speed_pwm(void *handle,
> >         do_div(tmp64, 255);
> >         duty =3D (u32)tmp64;
> >
> > -       tmp =3D RREG32(CG_FDO_CTRL0) & ~FDO_STATIC_DUTY_MASK;
> > -       tmp |=3D FDO_STATIC_DUTY(duty);
> > -       WREG32(CG_FDO_CTRL0, tmp);
> > +       tmp =3D RREG32(ixCG_FDO_CTRL0) &
~CG_FDO_CTRL0__FDO_STATIC_DUTY_MASK;
> > +       tmp |=3D duty << CG_FDO_CTRL0__FDO_STATIC_DUTY__SHIFT;
> > +       WREG32(ixCG_FDO_CTRL0, tmp);
> >
> >         return 0;
> >  }
> > @@ -6688,8 +6694,8 @@ static int si_dpm_get_fan_control_mode(void
*handle, u32 *fan_mode)
> >         if (si_pi->fan_is_controlled_by_smc)
> >                 return 0;
> >
> > -       tmp =3D RREG32(CG_FDO_CTRL2) & FDO_PWM_MODE_MASK;
> > -       *fan_mode =3D (tmp >> FDO_PWM_MODE_SHIFT);
> > +       tmp =3D RREG32(ixCG_FDO_CTRL2) & CG_FDO_CTRL2__FDO_PWM_MODE_MAS=
K;
> > +       *fan_mode =3D (tmp >> CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT);
> >
> >         return 0;
> >  }
> > @@ -6707,7 +6713,7 @@ static int si_fan_ctrl_get_fan_speed_rpm(struct
amdgpu_device *adev,
> >         if (adev->pm.fan_pulses_per_revolution =3D=3D 0)
> >                 return -ENOENT;
> >
> > -       tach_period =3D (RREG32(CG_TACH_STATUS) & TACH_PERIOD_MASK) >>
TACH_PERIOD_SHIFT;
> > +       tach_period =3D (RREG32(ixCG_TACH_STATUS) &
CG_TACH_STATUS__TACH_PERIOD_MASK) >> CG_TACH_STATUS__TACH_PERIOD__SHIFT;
> >         if (tach_period =3D=3D 0)
> >                 return -ENOENT;
> >
> > @@ -6736,9 +6742,9 @@ static int si_fan_ctrl_set_fan_speed_rpm(struct
amdgpu_device *adev,
> >                 si_fan_ctrl_stop_smc_fan_control(adev);
> >
> >         tach_period =3D 60 * xclk * 10000 / (8 * speed);
> > -       tmp =3D RREG32(CG_TACH_CTRL) & ~TARGET_PERIOD_MASK;
> > -       tmp |=3D TARGET_PERIOD(tach_period);
> > -       WREG32(CG_TACH_CTRL, tmp);
> > +       tmp =3D RREG32(ixCG_TACH_CTRL) &
~CG_TACH_CTRL__TARGET_PERIOD_MASK;
> > +       tmp |=3D tach_period << CG_TACH_CTRL__TARGET_PERIOD__SHIFT;
> > +       WREG32(ixCG_TACH_CTRL, tmp);
> >
> >         si_fan_ctrl_set_static_mode(adev, FDO_PWM_MODE_STATIC_RPM);
> >
> > @@ -6752,13 +6758,13 @@ static void si_fan_ctrl_set_default_mode(struct
amdgpu_device *adev)
> >         u32 tmp;
> >
> >         if (!si_pi->fan_ctrl_is_in_default_mode) {
> > -               tmp =3D RREG32(CG_FDO_CTRL2) & ~FDO_PWM_MODE_MASK;
> > -               tmp |=3D FDO_PWM_MODE(si_pi->fan_ctrl_default_mode);
> > -               WREG32(CG_FDO_CTRL2, tmp);
> > +               tmp =3D RREG32(ixCG_FDO_CTRL2) &
~CG_FDO_CTRL2__FDO_PWM_MODE_MASK;
> > +               tmp |=3D si_pi->fan_ctrl_default_mode <<
CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT;
> > +               WREG32(ixCG_FDO_CTRL2, tmp);
> >
> > -               tmp =3D RREG32(CG_FDO_CTRL2) & ~TMIN_MASK;
> > -               tmp |=3D TMIN(si_pi->t_min);
> > -               WREG32(CG_FDO_CTRL2, tmp);
> > +               tmp =3D RREG32(ixCG_FDO_CTRL2) & ~CG_FDO_CTRL2__TMIN_MA=
SK;
> > +               tmp |=3D si_pi->t_min << CG_FDO_CTRL2__TMIN__SHIFT;
> > +               WREG32(ixCG_FDO_CTRL2, tmp);
> >                 si_pi->fan_ctrl_is_in_default_mode =3D true;
> >         }
> >  }
> > @@ -6776,14 +6782,14 @@ static void si_thermal_initialize(struct
amdgpu_device *adev)
> >         u32 tmp;
> >
> >         if (adev->pm.fan_pulses_per_revolution) {
> > -               tmp =3D RREG32(CG_TACH_CTRL) & ~EDGE_PER_REV_MASK;
> > -               tmp |=3D EDGE_PER_REV(adev->pm.fan_pulses_per_revolutio=
n
-1);
> > -               WREG32(CG_TACH_CTRL, tmp);
> > +               tmp =3D RREG32(ixCG_TACH_CTRL) &
~CG_TACH_CTRL__EDGE_PER_REV_MASK;
> > +               tmp |=3D (adev->pm.fan_pulses_per_revolution -1) <<
CG_TACH_CTRL__EDGE_PER_REV__SHIFT;
> > +               WREG32(ixCG_TACH_CTRL, tmp);
> >         }
> >
> > -       tmp =3D RREG32(CG_FDO_CTRL2) & ~TACH_PWM_RESP_RATE_MASK;
> > -       tmp |=3D TACH_PWM_RESP_RATE(0x28);
> > -       WREG32(CG_FDO_CTRL2, tmp);
> > +       tmp =3D RREG32(ixCG_FDO_CTRL2) &
~CG_FDO_CTRL2__TACH_PWM_RESP_RATE_MASK;
> > +       tmp |=3D 0x28 << CG_FDO_CTRL2__TACH_PWM_RESP_RATE__SHIFT;
> > +       WREG32(ixCG_FDO_CTRL2, tmp);
> >  }
> >
> >  static int si_thermal_start_thermal_controller(struct amdgpu_device
*adev)
> > @@ -7546,8 +7552,8 @@ static void
si_dpm_debugfs_print_current_performance_level(void *handle,
> >         struct  si_ps *ps =3D si_get_ps(rps);
> >         struct rv7xx_pl *pl;
> >         u32 current_index =3D
> > -               (RREG32(TARGET_AND_CURRENT_PROFILE_INDEX) &
CURRENT_STATE_INDEX_MASK) >>
> > -               CURRENT_STATE_INDEX_SHIFT;
> > +               (RREG32(ixTARGET_AND_CURRENT_PROFILE_INDEX) &
TARGET_AND_CURRENT_PROFILE_INDEX__CURRENT_STATE_INDEX_MASK) >>
> > +
 TARGET_AND_CURRENT_PROFILE_INDEX__CURRENT_STATE_INDEX__SHIFT;
> >
> >         if (current_index >=3D ps->performance_level_count) {
> >                 seq_printf(m, "invalid dpm profile %d\n",
current_index);
> > @@ -7570,14 +7576,14 @@ static int si_dpm_set_interrupt_state(struct
amdgpu_device *adev,
> >         case AMDGPU_THERMAL_IRQ_LOW_TO_HIGH:
> >                 switch (state) {
> >                 case AMDGPU_IRQ_STATE_DISABLE:
> > -                       cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);
> > -                       cg_thermal_int |=3D THERM_INT_MASK_HIGH;
> > -                       WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);
> > +                       cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT)=
;
> > +                       cg_thermal_int |=3D
CG_THERMAL_INT__THERM_INT_MASK_HIGH_MASK;
> > +                       WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);
> >                         break;
> >                 case AMDGPU_IRQ_STATE_ENABLE:
> > -                       cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);
> > -                       cg_thermal_int &=3D ~THERM_INT_MASK_HIGH;
> > -                       WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);
> > +                       cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT)=
;
> > +                       cg_thermal_int &=3D
~CG_THERMAL_INT__THERM_INT_MASK_HIGH_MASK;
> > +                       WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);
> >                         break;
> >                 default:
> >                         break;
> > @@ -7587,14 +7593,14 @@ static int si_dpm_set_interrupt_state(struct
amdgpu_device *adev,
> >         case AMDGPU_THERMAL_IRQ_HIGH_TO_LOW:
> >                 switch (state) {
> >                 case AMDGPU_IRQ_STATE_DISABLE:
> > -                       cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);
> > -                       cg_thermal_int |=3D THERM_INT_MASK_LOW;
> > -                       WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);
> > +                       cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT)=
;
> > +                       cg_thermal_int |=3D
CG_THERMAL_INT__THERM_INT_MASK_LOW_MASK;
> > +                       WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);
> >                         break;
> >                 case AMDGPU_IRQ_STATE_ENABLE:
> > -                       cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);
> > -                       cg_thermal_int &=3D ~THERM_INT_MASK_LOW;
> > -                       WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);
> > +                       cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT)=
;
> > +                       cg_thermal_int &=3D
~CG_THERMAL_INT__THERM_INT_MASK_LOW_MASK;
> > +                       WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);
> >                         break;
> >                 default:
> >                         break;
> > @@ -7884,8 +7890,8 @@ static int si_dpm_get_temp(void *handle)
> >         int actual_temp =3D 0;
> >         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -       temp =3D (RREG32(CG_MULT_THERMAL_STATUS) & CTF_TEMP_MASK) >>
> > -               CTF_TEMP_SHIFT;
> > +       temp =3D (RREG32(ixCG_MULT_THERMAL_STATUS) &
CG_MULT_THERMAL_STATUS__CTF_TEMP_MASK) >>
> > +               CG_MULT_THERMAL_STATUS__CTF_TEMP__SHIFT;
> >
> >         if (temp & 0x200)
> >                 actual_temp =3D 255;
> > @@ -8015,8 +8021,8 @@ static int si_dpm_read_sensor(void *handle, int
idx,
> >         struct  si_ps *ps =3D si_get_ps(rps);
> >         uint32_t sclk, mclk;
> >         u32 pl_index =3D
> > -               (RREG32(TARGET_AND_CURRENT_PROFILE_INDEX) &
CURRENT_STATE_INDEX_MASK) >>
> > -               CURRENT_STATE_INDEX_SHIFT;
> > +               (RREG32(ixTARGET_AND_CURRENT_PROFILE_INDEX) &
TARGET_AND_CURRENT_PROFILE_INDEX__CURRENT_STATE_INDEX_MASK) >>
> > +
 TARGET_AND_CURRENT_PROFILE_INDEX__CURRENT_STATE_INDEX__SHIFT;
> >
> >         /* size must be at least 4 bytes for all sensors */
> >         if (*size < 4)
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
> > index c712899c44ca..4e65ab9e931c 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
> > @@ -44,8 +44,8 @@ static int si_set_smc_sram_address(struct
amdgpu_device *adev,
> >         if ((smc_address + 3) > limit)
> >                 return -EINVAL;
> >
> > -       WREG32(SMC_IND_INDEX_0, smc_address);
> > -       WREG32_P(SMC_IND_ACCESS_CNTL, 0, ~AUTO_INCREMENT_IND_0);
> > +       WREG32(mmSMC_IND_INDEX_0, smc_address);
> > +       WREG32_P(mmSMC_IND_ACCESS_CNTL, 0,
~SMC_IND_ACCESS_CNTL__AUTO_INCREMENT_IND_0_MASK);
> >
> >         return 0;
> >  }
> > @@ -74,7 +74,7 @@ int amdgpu_si_copy_bytes_to_smc(struct amdgpu_device
*adev,
> >                 if (ret)
> >                         goto done;
> >
> > -               WREG32(SMC_IND_DATA_0, data);
> > +               WREG32(mmSMC_IND_DATA_0, data);
> >
> >                 src +=3D 4;
> >                 byte_count -=3D 4;
> > @@ -89,7 +89,7 @@ int amdgpu_si_copy_bytes_to_smc(struct amdgpu_device
*adev,
> >                 if (ret)
> >                         goto done;
> >
> > -               original_data =3D RREG32(SMC_IND_DATA_0);
> > +               original_data =3D RREG32(mmSMC_IND_DATA_0);
> >                 extra_shift =3D 8 * (4 - byte_count);
> >
> >                 while (byte_count > 0) {
> > @@ -105,7 +105,7 @@ int amdgpu_si_copy_bytes_to_smc(struct
amdgpu_device *adev,
> >                 if (ret)
> >                         goto done;
> >
> > -               WREG32(SMC_IND_DATA_0, data);
> > +               WREG32(mmSMC_IND_DATA_0, data);
> >         }
> >
> >  done:
> > @@ -127,10 +127,10 @@ void amdgpu_si_reset_smc(struct amdgpu_device
*adev)
> >  {
> >         u32 tmp;
> >
> > -       RREG32(CB_CGTT_SCLK_CTRL);
> > -       RREG32(CB_CGTT_SCLK_CTRL);
> > -       RREG32(CB_CGTT_SCLK_CTRL);
> > -       RREG32(CB_CGTT_SCLK_CTRL);
> > +       RREG32(mmCB_CGTT_SCLK_CTRL);
> > +       RREG32(mmCB_CGTT_SCLK_CTRL);
> > +       RREG32(mmCB_CGTT_SCLK_CTRL);
> > +       RREG32(mmCB_CGTT_SCLK_CTRL);
> >
> >         tmp =3D RREG32_SMC(SMC_SYSCON_RESET_CNTL) |
> >               RST_REG;
> > @@ -176,16 +176,16 @@ PPSMC_Result amdgpu_si_send_msg_to_smc(struct
amdgpu_device *adev,
> >         if (!amdgpu_si_is_smc_running(adev))
> >                 return PPSMC_Result_Failed;
> >
> > -       WREG32(SMC_MESSAGE_0, msg);
> > +       WREG32(mmSMC_MESSAGE_0, msg);
> >
> >         for (i =3D 0; i < adev->usec_timeout; i++) {
> > -               tmp =3D RREG32(SMC_RESP_0);
> > +               tmp =3D RREG32(mmSMC_RESP_0);
> >                 if (tmp !=3D 0)
> >                         break;
> >                 udelay(1);
> >         }
> >
> > -       return (PPSMC_Result)RREG32(SMC_RESP_0);
> > +       return (PPSMC_Result)RREG32(mmSMC_RESP_0);
> >  }
> >
> >  PPSMC_Result amdgpu_si_wait_for_smc_inactive(struct amdgpu_device
*adev)
> > @@ -231,18 +231,18 @@ int amdgpu_si_load_smc_ucode(struct amdgpu_device
*adev, u32 limit)
> >                 return -EINVAL;
> >
> >         spin_lock_irqsave(&adev->smc_idx_lock, flags);
> > -       WREG32(SMC_IND_INDEX_0, ucode_start_address);
> > -       WREG32_P(SMC_IND_ACCESS_CNTL, AUTO_INCREMENT_IND_0,
~AUTO_INCREMENT_IND_0);
> > +       WREG32(mmSMC_IND_INDEX_0, ucode_start_address);
> > +       WREG32_P(mmSMC_IND_ACCESS_CNTL,
SMC_IND_ACCESS_CNTL__AUTO_INCREMENT_IND_0_MASK,
~SMC_IND_ACCESS_CNTL__AUTO_INCREMENT_IND_0_MASK);
> >         while (ucode_size >=3D 4) {
> >                 /* SMC address space is BE */
> >                 data =3D (src[0] << 24) | (src[1] << 16) | (src[2] << 8=
)
| src[3];
> >
> > -               WREG32(SMC_IND_DATA_0, data);
> > +               WREG32(mmSMC_IND_DATA_0, data);
> >
> >                 src +=3D 4;
> >                 ucode_size -=3D 4;
> >         }
> > -       WREG32_P(SMC_IND_ACCESS_CNTL, 0, ~AUTO_INCREMENT_IND_0);
> > +       WREG32_P(mmSMC_IND_ACCESS_CNTL, 0,
~SMC_IND_ACCESS_CNTL__AUTO_INCREMENT_IND_0_MASK);
> >         spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> >
> >         return 0;
> > @@ -257,7 +257,7 @@ int amdgpu_si_read_smc_sram_dword(struct
amdgpu_device *adev, u32 smc_address,
> >         spin_lock_irqsave(&adev->smc_idx_lock, flags);
> >         ret =3D si_set_smc_sram_address(adev, smc_address, limit);
> >         if (ret =3D=3D 0)
> > -               *value =3D RREG32(SMC_IND_DATA_0);
> > +               *value =3D RREG32(mmSMC_IND_DATA_0);
> >         spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> >
> >         return ret;
> > @@ -272,7 +272,7 @@ int amdgpu_si_write_smc_sram_dword(struct
amdgpu_device *adev, u32 smc_address,
> >         spin_lock_irqsave(&adev->smc_idx_lock, flags);
> >         ret =3D si_set_smc_sram_address(adev, smc_address, limit);
> >         if (ret =3D=3D 0)
> > -               WREG32(SMC_IND_DATA_0, value);
> > +               WREG32(mmSMC_IND_DATA_0, value);
> >         spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> >
> >         return ret;
> > --
> > 2.48.1
> >

--0000000000003abc9c0630b7bd90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">On Mon, Mar 17, 2025 at 11:04=E2=80=AFAM Alex Deucher &lt=
;<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank" rel=3D"noreferr=
er">alexdeucher@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Mar 17, 2025 at 2:38=E2=80=AFAM Alexandre Demers<br>
&gt; &lt;<a href=3D"mailto:alexandre.f.demers@gmail.com" target=3D"_blank" =
rel=3D"noreferrer">alexandre.f.demers@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Alexandre Demers &lt;<a href=3D"mailto:alexandre.f=
.demers@gmail.com" target=3D"_blank" rel=3D"noreferrer">alexandre.f.demers@=
gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 338 ++++++++++=
+----------<br>
&gt; &gt;=C2=A0 drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c |=C2=A0 36 +--<b=
r>
&gt; &gt;=C2=A0 2 files changed, 190 insertions(+), 184 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers=
/gpu/drm/amd/pm/legacy-dpm/si_dpm.c<br>
&gt; &gt; index 975912f285d7..0f34aaf773b7 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c<br>
&gt; &gt; @@ -2209,7 +2209,7 @@ static u32 si_calculate_cac_wintime(struct =
amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (xclk =3D=3D 0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn 0;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0cac_window =3D RREG32(CG_CAC_CTRL) &a=
mp; CAC_WINDOW_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0cac_window =3D RREG32(ixCG_CAC_CTRL) =
&amp; CG_CAC_CTRL__CAC_WINDOW_MASK;<br>
&gt;<br>
&gt; This looks wrong.=C2=A0 The ix prefix means the register offset is an =
index<br>
&gt; rather than an offset and not directly accessible.=C2=A0 If you are us=
ing<br>
&gt; the ix registers they should be using an indirect register accessor.<b=
r>
&gt; Same comment on the other cases below.<br>
&gt;<br>
&gt; Alex<br>
<br>
Hmmm, I misunderstood the meaning and I wrongly renamed the defines. I&#39;=
ll fix it<div dir=3D"auto"><br></div><div dir=3D"auto">Alexandre=C2=A0<br>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cac_window_size =3D ((cac_window=
 &amp; 0xFFFF0000) &gt;&gt; 16) * (cac_window &amp; 0x0000FFFF);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wintime =3D (cac_window_size * 1=
00) / xclk;<br>
&gt; &gt; @@ -2505,19 +2505,19 @@ static int si_populate_sq_ramping_values(=
struct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;pm.dpm.sq_ramping_t=
hreshold =3D=3D 0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -EINVAL;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER &=
gt; (MAX_POWER_MASK &gt;&gt; MAX_POWER_SHIFT))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER &=
gt; (SQ_POWER_THROTTLE__MAX_POWER_MASK &gt;&gt; SQ_POWER_THROTTLE__MAX_POWE=
R__SHIFT))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enab=
le_sq_ramping =3D false;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (SISLANDS_DPM2_SQ_RAMP_MIN_POWER &=
gt; (MIN_POWER_MASK &gt;&gt; MIN_POWER_SHIFT))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (SISLANDS_DPM2_SQ_RAMP_MIN_POWER &=
gt; (SQ_POWER_THROTTLE__MIN_POWER_MASK &gt;&gt; SQ_POWER_THROTTLE__MIN_POWE=
R__SHIFT))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enab=
le_sq_ramping =3D false;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER_D=
ELTA &gt; (MAX_POWER_DELTA_MASK &gt;&gt; MAX_POWER_DELTA_SHIFT))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (SISLANDS_DPM2_SQ_RAMP_MAX_POWER_D=
ELTA &gt; (SQ_POWER_THROTTLE2__MAX_POWER_DELTA_MASK &gt;&gt; SQ_POWER_THROT=
TLE2__MAX_POWER_DELTA__SHIFT))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enab=
le_sq_ramping =3D false;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (SISLANDS_DPM2_SQ_RAMP_STI_SIZE &g=
t; (STI_SIZE_MASK &gt;&gt; STI_SIZE_SHIFT))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (SISLANDS_DPM2_SQ_RAMP_STI_SIZE &g=
t; (SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE_MASK &gt;&gt; SQ_POWER_THR=
OTTLE2__SHORT_TERM_INTERVAL_SIZE__SHIFT))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enab=
le_sq_ramping =3D false;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (SISLANDS_DPM2_SQ_RAMP_LTI_RATIO &=
gt; (LTI_RATIO_MASK &gt;&gt; LTI_RATIO_SHIFT))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (SISLANDS_DPM2_SQ_RAMP_LTI_RATIO &=
gt; (SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO_MASK &gt;&gt; SQ_POWER_TH=
ROTTLE2__LONG_TERM_INTERVAL_RATIO__SHIFT))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enab=
le_sq_ramping =3D false;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; state-&gt;p=
erformance_level_count; i++) {<br>
&gt; &gt; @@ -2526,14 +2526,17 @@ static int si_populate_sq_ramping_values(=
struct amdgpu_device *adev,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
(state-&gt;performance_levels[i].sclk &gt;=3D adev-&gt;pm.dpm.sq_ramping_th=
reshold) &amp;&amp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0enable_sq_ramping) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle |=3D MAX_POWER(SISLANDS_DPM2_SQ_RAMP_=
MAX_POWER);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle |=3D MIN_POWER(SISLANDS_DPM2_SQ_RAMP_=
MIN_POWER);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle2 |=3D MAX_POWER_DELTA(SISLANDS_DPM2_S=
Q_RAMP_MAX_POWER_DELTA);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle2 |=3D STI_SIZE(SISLANDS_DPM2_SQ_RAMP_=
STI_SIZE);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle2 |=3D LTI_RATIO(SISLANDS_DPM2_SQ_RAMP=
_LTI_RATIO);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle |=3D SISLANDS_DPM2_SQ_RAMP_MAX_POWER =
&lt;&lt; SQ_POWER_THROTTLE__MAX_POWER__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle |=3D SISLANDS_DPM2_SQ_RAMP_MIN_POWER =
&lt;&lt; SQ_POWER_THROTTLE__MIN_POWER__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle2 |=3D SISLANDS_DPM2_SQ_RAMP_MAX_POWER=
_DELTA &lt;&lt; SQ_POWER_THROTTLE2__MAX_POWER_DELTA__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle2 |=3D SISLANDS_DPM2_SQ_RAMP_STI_SIZE =
&lt;&lt; SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle2 |=3D SISLANDS_DPM2_SQ_RAMP_LTI_RATIO=
 &lt;&lt; SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO__SHIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} el=
se {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle |=3D MAX_POWER_MASK | MIN_POWER_MASK;=
<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle2 |=3D MAX_POWER_DELTA_MASK | STI_SIZE=
_MASK | LTI_RATIO_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle |=3D SQ_POWER_THROTTLE__MAX_POWER_MAS=
K |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0SQ_POWER_THROTTLE__MIN_POWER_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sq_power_throttle2 |=3D SQ_POWER_THROTTLE2__MAX_POWER_D=
ELTA_MASK |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE_MASK |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0SQ_POWER_THROTTLE2__LONG_TERM_INTERVAL_RATIO_MASK;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smc_=
state-&gt;levels[i].SQPowerThrottle =3D cpu_to_be32(sq_power_throttle);<br>
&gt; &gt; @@ -2777,9 +2780,9 @@ static int si_initialize_smc_cac_tables(str=
uct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cac_tables)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -ENOMEM;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D RREG32(CG_CAC_CTRL) &amp; ~CA=
C_WINDOW_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0reg |=3D CAC_WINDOW(si_pi-&gt;powertu=
ne_data-&gt;cac_window);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_CAC_CTRL, reg);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D RREG32(ixCG_CAC_CTRL) &amp; ~=
CG_CAC_CTRL__CAC_WINDOW_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg |=3D (si_pi-&gt;powertune_data-&g=
t;cac_window &lt;&lt; CG_CAC_CTRL__CAC_WINDOW__SHIFT);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_CAC_CTRL, reg);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;dyn_powertune_data.cac=
_leakage =3D adev-&gt;pm.dpm.cac_leakage;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;dyn_powertune_data.dc_=
pwr_value =3D<br>
&gt; &gt; @@ -2978,10 +2981,10 @@ static int si_init_smc_spll_table(struct =
amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =
=3D si_calculate_sclk_params(adev, sclk, &amp;sclk_params);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
ret)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p_div =3D=
 (sclk_params.vCG_SPLL_FUNC_CNTL &amp; SPLL_PDIV_A_MASK) &gt;&gt; SPLL_PDIV=
_A_SHIFT;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_div =
=3D (sclk_params.vCG_SPLL_FUNC_CNTL_3 &amp; SPLL_FB_DIV_MASK) &gt;&gt; SPLL=
_FB_DIV_SHIFT;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_s =3D=
 (sclk_params.vCG_SPLL_SPREAD_SPECTRUM &amp; CLK_S_MASK) &gt;&gt; CLK_S_SHI=
FT;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_v =3D=
 (sclk_params.vCG_SPLL_SPREAD_SPECTRUM_2 &amp; CLK_V_MASK) &gt;&gt; CLK_V_S=
HIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p_div =3D=
 (sclk_params.vCG_SPLL_FUNC_CNTL &amp; CG_SPLL_FUNC_CNTL__SPLL_PDIV_A_MASK)=
 &gt;&gt; CG_SPLL_FUNC_CNTL__SPLL_PDIV_A__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_div =
=3D (sclk_params.vCG_SPLL_FUNC_CNTL_3 &amp; CG_SPLL_FUNC_CNTL_3__SPLL_FB_DI=
V_MASK) &gt;&gt; CG_SPLL_FUNC_CNTL_3__SPLL_FB_DIV__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_s =3D=
 (sclk_params.vCG_SPLL_SPREAD_SPECTRUM &amp; CG_SPLL_SPREAD_SPECTRUM__CLK_S=
_MASK) &gt;&gt; CG_SPLL_SPREAD_SPECTRUM__CLK_S__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_v =3D=
 (sclk_params.vCG_SPLL_SPREAD_SPECTRUM_2 &amp; CG_SPLL_SPREAD_SPECTRUM_2__C=
LK_V_MASK) &gt;&gt; CG_SPLL_SPREAD_SPECTRUM_2__CLK_V__SHIFT;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_d=
iv &amp;=3D ~0x00001FFF;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_d=
iv &gt;&gt;=3D 1;<br>
&gt; &gt; @@ -3685,10 +3688,10 @@ static bool si_is_special_1gb_platform(st=
ruct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(MC_SEQ_IO_DEBUG_INDEX, 0x=
b);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0width =3D ((RREG32(MC_SEQ_IO_DEB=
UG_DATA) &gt;&gt; 1) &amp; 1) ? 16 : 32;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(MC_ARB_RAMCFG);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0row =3D ((tmp &amp; NOOFROWS_MASK) &g=
t;&gt; NOOFROWS_SHIFT) + 10;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0column =3D ((tmp &amp; NOOFCOLS_MASK)=
 &gt;&gt; NOOFCOLS_SHIFT) + 8;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0bank =3D ((tmp &amp; NOOFBANK_MASK) &=
gt;&gt; NOOFBANK_SHIFT) + 2;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(mmMC_ARB_RAMCFG);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0row =3D ((tmp &amp; MC_ARB_RAMCFG__NO=
OFROWS_MASK) &gt;&gt; MC_ARB_RAMCFG__NOOFROWS__SHIFT) + 10;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0column =3D ((tmp &amp; MC_ARB_RAMCFG_=
_NOOFCOLS_MASK) &gt;&gt; MC_ARB_RAMCFG__NOOFCOLS__SHIFT) + 8;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bank =3D ((tmp &amp; MC_ARB_RAMCFG__N=
OOFBANK_MASK) &gt;&gt; MC_ARB_RAMCFG__NOOFBANK__SHIFT) + 2;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0density =3D (1 &lt;&lt; (row + c=
olumn - 20 + bank)) * width;<br>
&gt; &gt;<br>
&gt; &gt; @@ -3772,11 +3775,11 @@ static void si_set_dpm_event_sources(stru=
ct amdgpu_device *adev, u32 sources)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (want_thermal_protection) {<b=
r>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
CG_THERMAL_CTRL, DPM_EVENT_SRC(dpm_event_src), ~DPM_EVENT_SRC_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixCG_THERMAL_CTRL, dpm_event_src &lt;&lt; CG_THERMAL_CTRL__DPM_EVENT_SRC__S=
HIFT, ~CG_THERMAL_CTRL__DPM_EVENT_SRC_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
pi-&gt;thermal_protection)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_P(GENERAL_PWRMGT, 0, ~THERMAL_PROTECTION_DIS);<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_P(ixGENERAL_PWRMGT, 0, ~GENERAL_PWRMGT__THERMAL_=
PROTECTION_DIS_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
GENERAL_PWRMGT, THERMAL_PROTECTION_DIS, ~THERMAL_PROTECTION_DIS);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixGENERAL_PWRMGT, GENERAL_PWRMGT__THERMAL_PROTECTION_DIS_MASK, ~GENERAL_PWR=
MGT__THERMAL_PROTECTION_DIS_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; @@ -3801,20 +3804,20 @@ static void si_enable_auto_throttle_sourc=
e(struct amdgpu_device *adev,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void si_start_dpm(struct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(GENERAL_PWRMGT, GLOBAL_PWRMG=
T_EN, ~GLOBAL_PWRMGT_EN);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(ixGENERAL_PWRMGT, GENERAL_PW=
RMGT__GLOBAL_PWRMGT_EN_MASK, ~GENERAL_PWRMGT__GLOBAL_PWRMGT_EN_MASK);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void si_stop_dpm(struct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(GENERAL_PWRMGT, 0, ~GLOBAL_P=
WRMGT_EN);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(ixGENERAL_PWRMGT, 0, ~GENERA=
L_PWRMGT__GLOBAL_PWRMGT_EN_MASK);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void si_enable_sclk_control(struct amdgpu_device *ad=
ev, bool enable)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
SCLK_PWRMGT_CNTL, 0, ~SCLK_PWRMGT_OFF);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixSCLK_PWRMGT_CNTL, 0, ~SCLK_PWRMGT_CNTL__SCLK_PWRMGT_OFF_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
SCLK_PWRMGT_CNTL, SCLK_PWRMGT_OFF, ~SCLK_PWRMGT_OFF);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixSCLK_PWRMGT_CNTL, SCLK_PWRMGT_CNTL__SCLK_PWRMGT_OFF_MASK, ~SCLK_PWRMGT_CN=
TL__SCLK_PWRMGT_OFF_MASK);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; @@ -3854,7 +3857,7 @@ static int si_notify_hw_of_powersource(stru=
ct amdgpu_device *adev, bool ac_power<br>
&gt; &gt;=C2=A0 static PPSMC_Result si_send_msg_to_smc_with_parameter(struc=
t amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PPSMC_Msg msg, u32 p=
arameter)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(SMC_SCRATCH0, parameter);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixSMC_SCRATCH0, parameter);<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return amdgpu_si_send_msg_to_smc=
(adev, msg);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; @@ -4039,12 +4042,12 @@ static void si_read_clock_registers(struc=
t amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct si_power_info *si_pi =3D =
si_get_pi(adev);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_fun=
c_cntl =3D RREG32(CG_SPLL_FUNC_CNTL);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_fun=
c_cntl_2 =3D RREG32(CG_SPLL_FUNC_CNTL_2);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_fun=
c_cntl_3 =3D RREG32(CG_SPLL_FUNC_CNTL_3);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_fun=
c_cntl_4 =3D RREG32(CG_SPLL_FUNC_CNTL_4);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_spr=
ead_spectrum =3D RREG32(CG_SPLL_SPREAD_SPECTRUM);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_spr=
ead_spectrum_2 =3D RREG32(CG_SPLL_SPREAD_SPECTRUM_2);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_fun=
c_cntl =3D RREG32(ixCG_SPLL_FUNC_CNTL);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_fun=
c_cntl_2 =3D RREG32(ixCG_SPLL_FUNC_CNTL_2);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_fun=
c_cntl_3 =3D RREG32(ixCG_SPLL_FUNC_CNTL_3);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_fun=
c_cntl_4 =3D RREG32(ixCG_SPLL_FUNC_CNTL_4);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_spr=
ead_spectrum =3D RREG32(ixCG_SPLL_SPREAD_SPECTRUM);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.cg_spll_spr=
ead_spectrum_2 =3D RREG32(ixCG_SPLL_SPREAD_SPECTRUM_2);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.dll_cn=
tl =3D RREG32(DLL_CNTL);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.mclk_p=
wrmgt_cntl =3D RREG32(MCLK_PWRMGT_CNTL);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_pi-&gt;clock_registers.mpll_a=
d_func_cntl =3D RREG32(MPLL_AD_FUNC_CNTL);<br>
&gt; &gt; @@ -4060,14 +4063,14 @@ static void si_enable_thermal_protection(=
struct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bool enable)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
GENERAL_PWRMGT, 0, ~THERMAL_PROTECTION_DIS);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixGENERAL_PWRMGT, 0, ~GENERAL_PWRMGT__THERMAL_PROTECTION_DIS_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
GENERAL_PWRMGT, THERMAL_PROTECTION_DIS, ~THERMAL_PROTECTION_DIS);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixGENERAL_PWRMGT, GENERAL_PWRMGT__THERMAL_PROTECTION_DIS_MASK, ~GENERAL_PWR=
MGT__THERMAL_PROTECTION_DIS_MASK);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void si_enable_acpi_power_management(struct amdgpu_d=
evice *adev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(GENERAL_PWRMGT, STATIC_PM_EN=
, ~STATIC_PM_EN);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(ixGENERAL_PWRMGT, GENERAL_PW=
RMGT__STATIC_PM_EN_MASK, ~GENERAL_PWRMGT__STATIC_PM_EN_MASK);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 #if 0<br>
&gt; &gt; @@ -4148,9 +4151,9 @@ static void si_program_ds_registers(struct =
amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =
=3D 0x1;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (eg_pi-&gt;sclk_deep_sleep) {=
<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
MISC_CLK_CNTL, DEEP_SLEEP_CLK_SEL(tmp), ~DEEP_SLEEP_CLK_SEL_MASK);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
CG_SPLL_AUTOSCALE_CNTL, AUTOSCALE_ON_SS_CLEAR,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ~AUTOSCALE_ON_SS_CLEAR);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixMISC_CLK_CNTL, (tmp &lt;&lt; MISC_CLK_CNTL__DEEP_SLEEP_CLK_SEL__SHIFT), ~=
MISC_CLK_CNTL__DEEP_SLEEP_CLK_SEL_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixCG_SPLL_AUTOSCALE_CNTL, CG_SPLL_AUTOSCALE_CNTL__AUTOSCALE_ON_SS_CLEAR_MAS=
K,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ~CG_SPLL_AUTOSCALE_CNTL__AUTOSCALE_ON_SS_CLEAR_MASK);<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; @@ -4159,18 +4162,18 @@ static void si_program_display_gap(struct=
 amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tmp, pipe;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(CG_DISPLAY_GAP_CNTL) &=
amp; ~(DISP1_GAP_MASK | DISP2_GAP_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(ixCG_DISPLAY_GAP_CNTL)=
 &amp; ~(CG_DISPLAY_GAP_CNTL__DISP1_GAP_MASK | CG_DISPLAY_GAP_CNTL__DISP2_G=
AP_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;pm.dpm.new_active_c=
rtc_count &gt; 0)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
DISP1_GAP(R600_PM_DISPLAY_GAP_VBLANK_OR_WM);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
R600_PM_DISPLAY_GAP_VBLANK_OR_WM &lt;&lt; CG_DISPLAY_GAP_CNTL__DISP1_GAP__S=
HIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
DISP1_GAP(R600_PM_DISPLAY_GAP_IGNORE);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
R600_PM_DISPLAY_GAP_IGNORE &lt;&lt; CG_DISPLAY_GAP_CNTL__DISP1_GAP__SHIFT;<=
br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;pm.dpm.new_active_c=
rtc_count &gt; 1)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
DISP2_GAP(R600_PM_DISPLAY_GAP_VBLANK_OR_WM);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
R600_PM_DISPLAY_GAP_VBLANK_OR_WM &lt;&lt; CG_DISPLAY_GAP_CNTL__DISP2_GAP__S=
HIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
DISP2_GAP(R600_PM_DISPLAY_GAP_IGNORE);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
R600_PM_DISPLAY_GAP_IGNORE &lt;&lt; CG_DISPLAY_GAP_CNTL__DISP2_GAP__SHIFT;<=
br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_DISPLAY_GAP_CNTL, tmp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_DISPLAY_GAP_CNTL, tmp);<b=
r>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(DCCG_DISP_SLOW_SE=
LECT_REG);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pipe =3D (tmp &amp; DCCG_DISP1_S=
LOW_SELECT_MASK) &gt;&gt; DCCG_DISP1_SLOW_SELECT_SHIFT;<br>
&gt; &gt; @@ -4205,10 +4208,10 @@ static void si_enable_spread_spectrum(str=
uct amdgpu_device *adev, bool enable)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
pi-&gt;sclk_ss)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_P(GENERAL_PWRMGT, DYN_SPREAD_SPECTRUM_EN, ~DYN_S=
PREAD_SPECTRUM_EN);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_P(ixGENERAL_PWRMGT, GENERAL_PWRMGT__DYN_SPREAD_S=
PECTRUM_EN_MASK, ~GENERAL_PWRMGT__DYN_SPREAD_SPECTRUM_EN_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
CG_SPLL_SPREAD_SPECTRUM, 0, ~SSEN);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
GENERAL_PWRMGT, 0, ~DYN_SPREAD_SPECTRUM_EN);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixCG_SPLL_SPREAD_SPECTRUM, 0, ~CG_SPLL_SPREAD_SPECTRUM__SSEN_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixGENERAL_PWRMGT, 0, ~GENERAL_PWRMGT__DYN_SPREAD_SPECTRUM_EN_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; @@ -4230,15 +4233,15 @@ static void si_setup_bsp(struct amdgpu_de=
vice *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;pi-&gt;pbsu);<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pi-&gt;dsp =3D BSP(pi-&gt;bsp) | BSU=
(pi-&gt;bsu);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0pi-&gt;psp =3D BSP(pi-&gt;pbsp) | BSU=
(pi-&gt;pbsu);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pi-&gt;dsp =3D (pi-&gt;bsp &lt;&lt; =
CG_BSP__BSP__SHIFT) | (pi-&gt;bsu &lt;&lt; CG_BSP__BSU__SHIFT);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pi-&gt;psp =3D (pi-&gt;pbsp &lt;&lt; =
CG_BSP__BSP__SHIFT) | (pi-&gt;pbsu &lt;&lt; CG_BSP__BSU__SHIFT);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_BSP, pi-&gt;dsp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_BSP, pi-&gt;dsp);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void si_program_git(struct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(CG_GIT, CG_GICST(R600_GICST_=
DFLT), ~CG_GICST_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(ixCG_GIT, R600_GICST_DFLT &l=
t;&lt; CG_GIT__CG_GICST__SHIFT, ~CG_GIT__CG_GICST_MASK);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void si_program_tp(struct amdgpu_device *adev)<br>
&gt; &gt; @@ -4247,54 +4250,54 @@ static void si_program_tp(struct amdgpu_d=
evice *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum r600_td td =3D R600_TD_DFLT=
;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; R600_PM_NUM=
BER_OF_TC; i++)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG=
_FFCT_0 + i, (UTC_0(r600_utc[i]) | DTC_0(r600_dtc[i])));<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ix=
CG_FFCT_0 + i, (r600_utc[i] &lt;&lt; CG_FFCT_0__UTC_0__SHIFT | r600_dtc[i] =
&lt;&lt; CG_FFCT_0__DTC_0__SHIFT));<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (td =3D=3D R600_TD_AUTO)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
SCLK_PWRMGT_CNTL, 0, ~FIR_FORCE_TREND_SEL);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixSCLK_PWRMGT_CNTL, 0, ~SCLK_PWRMGT_CNTL__FIR_FORCE_TREND_SEL_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
SCLK_PWRMGT_CNTL, FIR_FORCE_TREND_SEL, ~FIR_FORCE_TREND_SEL);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixSCLK_PWRMGT_CNTL, SCLK_PWRMGT_CNTL__FIR_FORCE_TREND_SEL_MASK, ~SCLK_PWRMG=
T_CNTL__FIR_FORCE_TREND_SEL_MASK);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (td =3D=3D R600_TD_UP)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
SCLK_PWRMGT_CNTL, 0, ~FIR_TREND_MODE);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixSCLK_PWRMGT_CNTL, 0, ~SCLK_PWRMGT_CNTL__FIR_TREND_MODE_MASK);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (td =3D=3D R600_TD_DOWN)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
SCLK_PWRMGT_CNTL, FIR_TREND_MODE, ~FIR_TREND_MODE);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixSCLK_PWRMGT_CNTL, SCLK_PWRMGT_CNTL__FIR_TREND_MODE_MASK, ~SCLK_PWRMGT_CNT=
L__FIR_TREND_MODE_MASK);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void si_program_tpp(struct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_TPC, R600_TPC_DFLT);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_TPC, R600_TPC_DFLT);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void si_program_sstp(struct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_SSP, (SSTU(R600_SSTU_DFLT) =
| SST(R600_SST_DFLT)));<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_SSP, (R600_SSTU_DFLT &lt;=
&lt; CG_SSP__SSTU__SHIFT| R600_SST_DFLT &lt;&lt; CG_SSP__SST__SHIFT));<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void si_enable_display_gap(struct amdgpu_device *ade=
v)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tmp =3D RREG32(CG_DISPLAY_GAP_CNT=
L);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tmp =3D RREG32(ixCG_DISPLAY_GAP_C=
NTL);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp &amp;=3D ~(DISP1_GAP_MASK | DISP2=
_GAP_MASK);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D (DISP1_GAP(R600_PM_DISPLAY_G=
AP_IGNORE) |<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DISP2_GAP=
(R600_PM_DISPLAY_GAP_IGNORE));<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp &amp;=3D ~(CG_DISPLAY_GAP_CNTL__D=
ISP1_GAP_MASK | CG_DISPLAY_GAP_CNTL__DISP2_GAP_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D (R600_PM_DISPLAY_GAP_IGNORE =
&lt;&lt; CG_DISPLAY_GAP_CNTL__DISP1_GAP__SHIFT |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0R600_PM_D=
ISPLAY_GAP_IGNORE &lt;&lt; CG_DISPLAY_GAP_CNTL__DISP2_GAP__SHIFT);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp &amp;=3D ~(DISP1_GAP_MCHG_MASK | =
DISP2_GAP_MCHG_MASK);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D (DISP1_GAP_MCHG(R600_PM_DISP=
LAY_GAP_VBLANK) |<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DISP2_GAP=
_MCHG(R600_PM_DISPLAY_GAP_IGNORE));<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_DISPLAY_GAP_CNTL, tmp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp &amp;=3D ~(CG_DISPLAY_GAP_CNTL__D=
ISP1_GAP_MCHG_MASK | CG_DISPLAY_GAP_CNTL__DISP2_GAP_MCHG_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D (R600_PM_DISPLAY_GAP_VBLANK =
&lt;&lt; CG_DISPLAY_GAP_CNTL__DISP1_GAP_MCHG__SHIFT |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0R600_PM_D=
ISPLAY_GAP_IGNORE &lt;&lt; CG_DISPLAY_GAP_CNTL__DISP2_GAP_MCHG__SHIFT);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_DISPLAY_GAP_CNTL, tmp);<b=
r>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void si_program_vc(struct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rv7xx_power_info *pi =3D =
rv770_get_pi(adev);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_FTV, pi-&gt;vrc);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_FTV, pi-&gt;vrc);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void si_clear_vc(struct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_FTV, 0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_FTV, 0);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_clock=
)<br>
&gt; &gt; @@ -4751,7 +4754,7 @@ static u32 si_calculate_memory_refresh_rate=
(struct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dram_rows;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dram_refresh_rate;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 mc_arb_rfsh_rate;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tmp =3D (RREG32(MC_ARB_RAMCFG) &a=
mp; NOOFROWS_MASK) &gt;&gt; NOOFROWS_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tmp =3D (RREG32(mmMC_ARB_RAMCFG) =
&amp; MC_ARB_RAMCFG__NOOFROWS_MASK) &gt;&gt; MC_ARB_RAMCFG__NOOFROWS__SHIFT=
;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tmp &gt;=3D 4)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dram=
_rows =3D 16384;<br>
&gt; &gt; @@ -4925,7 +4928,7 @@ static int si_populate_smc_initial_state(st=
ruct amdgpu_device *adev,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_populate_initial_mvdd_value(a=
dev, &amp;table-&gt;initialState.level.mvdd);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D CG_R(0xffff) | CG_L(0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D 0xffff &lt;&lt; CG_AT__CG_R__=
SHIFT | 0 &lt;&lt; CG_AT__CG_L__SHIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;<a href=3D"http://init=
ialState.level.aT" rel=3D"noreferrer noreferrer" target=3D"_blank">initialS=
tate.level.aT</a> =3D cpu_to_be32(reg);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;initialState.level.bSP=
 =3D cpu_to_be32(pi-&gt;dsp);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;initialState.level.gen=
2PCIE =3D (u8)si_pi-&gt;boot_pcie_gen;<br>
&gt; &gt; @@ -4951,10 +4954,13 @@ static int si_populate_smc_initial_state(=
struct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;initialState.level.dpm=
2.BelowSafeInc =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;initialState.level.dpm=
2.PwrEfficiencyRatio =3D 0;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D MIN_POWER_MASK | MAX_POWER_MA=
SK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D SQ_POWER_THROTTLE__MIN_POWER_=
MASK |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SQ_POWER_=
THROTTLE__MAX_POWER_MASK;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;initialState.level.SQP=
owerThrottle =3D cpu_to_be32(reg);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D MAX_POWER_DELTA_MASK | STI_SI=
ZE_MASK | LTI_RATIO_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D SQ_POWER_THROTTLE2__MAX_POWER=
_DELTA_MASK |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SQ_POWER_=
THROTTLE2__SHORT_TERM_INTERVAL_SIZE_MASK |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SQ_POWER_=
THROTTLE2__LONG_TERM_INTERVAL_RATIO_MASK;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;initialState.level.SQP=
owerThrottle_2 =3D cpu_to_be32(reg);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; @@ -5073,8 +5079,8 @@ static int si_populate_smc_acpi_state(struc=
t amdgpu_device *adev,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dll_cntl &amp;=3D ~(MRDCK0_BYPAS=
S | MRDCK1_BYPASS);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_2 &amp;=3D ~SCLK_MUX_S=
EL_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_2 |=3D SCLK_MUX_SEL(4)=
;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_2 &amp;=3D ~CG_SPLL_FU=
NC_CNTL_2__SCLK_MUX_SEL_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_2 |=3D 4 &lt;&lt; CG_S=
PLL_FUNC_CNTL_2__SCLK_MUX_SEL__SHIFT;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;ACPIState.level.mclk.v=
DLL_CNTL =3D<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_=
to_be32(dll_cntl);<br>
&gt; &gt; @@ -5118,10 +5124,10 @@ static int si_populate_smc_acpi_state(str=
uct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;ACPIState.level.dpm2.B=
elowSafeInc =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;ACPIState.level.dpm2.P=
wrEfficiencyRatio =3D 0;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D MIN_POWER_MASK | MAX_POWER_MA=
SK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D SQ_POWER_THROTTLE__MIN_POWER_=
MASK | SQ_POWER_THROTTLE__MAX_POWER_MASK;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;ACPIState.level.SQPowe=
rThrottle =3D cpu_to_be32(reg);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D MAX_POWER_DELTA_MASK | STI_SI=
ZE_MASK | LTI_RATIO_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D SQ_POWER_THROTTLE2__MAX_POWER=
_DELTA_MASK | SQ_POWER_THROTTLE2__SHORT_TERM_INTERVAL_SIZE_MASK | SQ_POWER_=
THROTTLE2__LONG_TERM_INTERVAL_RATIO_MASK;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table-&gt;ACPIState.level.SQPowe=
rThrottle_2 =3D cpu_to_be32(reg);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; @@ -5266,8 +5272,8 @@ static int si_init_smc_table(struct amdgpu_=
device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
ret)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG=
_ULV_CONTROL, ulv-&gt;cg_ulv_control);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG=
_ULV_PARAMETER, ulv-&gt;cg_ulv_parameter);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ix=
CG_ULV_CONTROL, ulv-&gt;cg_ulv_control);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ix=
CG_ULV_PARAMETER, ulv-&gt;cg_ulv_parameter);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lane=
_width =3D amdgpu_get_pcie_lanes(adev);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_w=
rite_smc_soft_register(adev, SI_SMC_SOFT_REGISTER_non_ulv_pcie_link_width, =
lane_width);<br>
&gt; &gt; @@ -5310,16 +5316,16 @@ static int si_calculate_sclk_params(struc=
t amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp, reference_clock);<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fbdiv =3D (u32) tmp;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl &amp;=3D ~(SPLL_PDIV_A=
_MASK | SPLL_REF_DIV_MASK);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl |=3D SPLL_REF_DIV(divi=
ders.ref_div);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl |=3D SPLL_PDIV_A(divid=
ers.post_div);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl &amp;=3D ~(CG_SPLL_FUN=
C_CNTL__SPLL_PDIV_A_MASK | CG_SPLL_FUNC_CNTL__SPLL_REF_DIV_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl |=3D dividers.ref_div =
&lt;&lt; CG_SPLL_FUNC_CNTL__SPLL_REF_DIV__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl |=3D dividers.post_div=
 &lt;&lt; CG_SPLL_FUNC_CNTL__SPLL_PDIV_A__SHIFT;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_2 &amp;=3D ~SCLK_MUX_S=
EL_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_2 |=3D SCLK_MUX_SEL(2)=
;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_2 &amp;=3D ~CG_SPLL_FU=
NC_CNTL_2__SCLK_MUX_SEL_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_2 |=3D 2 &lt;&lt; CG_S=
PLL_FUNC_CNTL_2__SCLK_MUX_SEL__SHIFT;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_3 &amp;=3D ~SPLL_FB_DI=
V_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_3 |=3D SPLL_FB_DIV(fbd=
iv);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_3 |=3D SPLL_DITHEN;<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_3 &amp;=3D ~CG_SPLL_FU=
NC_CNTL_3__SPLL_FB_DIV_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_3 |=3D fbdiv &lt;&lt; =
CG_SPLL_FUNC_CNTL_3__SPLL_FB_DIV__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spll_func_cntl_3 |=3D CG_SPLL_FUNC_CN=
TL_3__SPLL_DITHEN_MASK;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pi-&gt;sclk_ss) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stru=
ct amdgpu_atom_ss ss;<br>
&gt; &gt; @@ -5330,12 +5336,12 @@ static int si_calculate_sclk_params(struc=
t amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0u32 clk_s =3D reference_clock * 5 / (reference_divi=
der * ss.rate);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0u32 clk_v =3D 4 * ss.percentage * fbdiv / (clk_s * =
10000);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_spll_spread_spectrum &amp;=3D ~CLK_S_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_spll_spread_spectrum |=3D CLK_S(clk_s);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_spll_spread_spectrum |=3D SSEN;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_spll_spread_spectrum &amp;=3D ~CG_SPLL_SPREAD_SPECTR=
UM__CLK_S_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_spll_spread_spectrum |=3D clk_s &lt;&lt; CG_SPLL_SPR=
EAD_SPECTRUM__CLK_S__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_spll_spread_spectrum |=3D CG_SPLL_SPREAD_SPECTRUM__S=
SEN_MASK;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_spll_spread_spectrum_2 &amp;=3D ~CLK_V_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_spll_spread_spectrum_2 |=3D CLK_V(clk_v);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_spll_spread_spectrum_2 &amp;=3D ~CG_SPLL_SPREAD_SPEC=
TRUM_2__CLK_V_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_spll_spread_spectrum_2 |=3D clk_v &lt;&lt; CG_SPLL_S=
PREAD_SPECTRUM_2__CLK_V__SHIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; @@ -5501,7 +5507,7 @@ static int si_convert_power_level_to_smc(st=
ruct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pi-&gt;mclk_stutter_mode_thr=
eshold &amp;&amp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(pl-&gt;mclk &lt;=
=3D pi-&gt;mclk_stutter_mode_threshold) &amp;&amp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!eg_pi-&gt;uvd_ena=
bled &amp;&amp;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(RREG32(DPG_PIPE_STUTTE=
R_CONTROL) &amp; STUTTER_ENABLE) &amp;&amp;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(RREG32(mmDPG_PIPE_STUT=
TER_CONTROL) &amp; DPG_PIPE_STUTTER_CONTROL__STUTTER_ENABLE_MASK) &amp;&amp=
;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(adev-&gt;pm.dpm.n=
ew_active_crtc_count &lt;=3D 2)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0leve=
l-&gt;mcFlags |=3D SISLANDS_SMC_MC_STUTTER_EN;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; @@ -5595,7 +5601,7 @@ static int si_populate_smc_t(struct amdgpu_=
device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -EINVAL;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (state-&gt;performance_level_=
count &lt; 2) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a_t =3D C=
G_R(0xffff) | CG_L(0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a_t =3D 0=
xffff &lt;&lt; CG_AT__CG_R__SHIFT | 0 &lt;&lt; CG_AT__CG_L__SHIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smc_=
state-&gt;levels[0].aT =3D cpu_to_be32(a_t);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; @@ -5616,13 +5622,13 @@ static int si_populate_smc_t(struct amdgp=
u_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0t_l =3D (i + 1) * 1000 + 50 * R600_AH_DFLT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a_t =3D b=
e32_to_cpu(smc_state-&gt;levels[i].aT) &amp; ~CG_R_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a_t |=3D =
CG_R(t_l * pi-&gt;bsp / 20000);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a_t =3D b=
e32_to_cpu(smc_state-&gt;levels[i].aT) &amp; ~CG_AT__CG_R_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a_t |=3D =
(t_l * pi-&gt;bsp / 20000) &lt;&lt; CG_AT__CG_R__SHIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smc_=
state-&gt;levels[i].aT =3D cpu_to_be32(a_t);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0high=
_bsp =3D (i =3D=3D state-&gt;performance_level_count - 2) ?<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0pi-&gt;pbsp : pi-&gt;bsp;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a_t =3D C=
G_R(0xffff) | CG_L(t_h * high_bsp / 20000);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a_t =3D (=
0xffff) &lt;&lt; CG_AT__CG_R__SHIFT | (t_h * high_bsp / 20000) &lt;&lt; CG_=
AT__CG_L__SHIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smc_=
state-&gt;levels[i + 1].aT =3D cpu_to_be32(a_t);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; @@ -6196,9 +6202,9 @@ static int si_upload_mc_reg_table(struct am=
dgpu_device *adev,<br>
&gt; &gt;=C2=A0 static void si_enable_voltage_control(struct amdgpu_device =
*adev, bool enable)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
GENERAL_PWRMGT, VOLT_PWRMGT_EN, ~VOLT_PWRMGT_EN);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixGENERAL_PWRMGT, GENERAL_PWRMGT__VOLT_PWRMGT_EN_MASK, ~GENERAL_PWRMGT__VOL=
T_PWRMGT_EN_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
GENERAL_PWRMGT, 0, ~VOLT_PWRMGT_EN);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(=
ixGENERAL_PWRMGT, 0, ~GENERAL_PWRMGT__VOLT_PWRMGT_EN_MASK);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static enum si_pcie_gen si_get_maximum_link_speed(struct am=
dgpu_device *adev,<br>
&gt; &gt; @@ -6220,8 +6226,8 @@ static u16 si_get_current_pcie_speed(struct=
 amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 speed_cntl;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0speed_cntl =3D RREG32_PCIE_PORT(PCIE_=
LC_SPEED_CNTL) &amp; LC_CURRENT_DATA_RATE_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0speed_cntl &gt;&gt;=3D LC_CURRENT_DAT=
A_RATE_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0speed_cntl =3D RREG32_PCIE_PORT(ixPCI=
E_LC_SPEED_CNTL) &amp; PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0speed_cntl &gt;&gt;=3D PCIE_LC_SPEED_=
CNTL__LC_CURRENT_DATA_RATE__SHIFT;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (u16)speed_cntl;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; @@ -6428,21 +6434,21 @@ static void si_dpm_setup_asic(struct amdg=
pu_device *adev)<br>
&gt; &gt;=C2=A0 static int si_thermal_enable_alert(struct amdgpu_device *ad=
ev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool enable)<br=
>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 thermal_int =3D RREG32(CG_THERMAL=
_INT);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 thermal_int =3D RREG32(ixCG_THERM=
AL_INT);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PPSM=
C_Result result;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thermal_i=
nt &amp;=3D ~(THERM_INT_MASK_HIGH | THERM_INT_MASK_LOW);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG=
_THERMAL_INT, thermal_int);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thermal_i=
nt &amp;=3D ~(CG_THERMAL_INT__THERM_INT_MASK_HIGH_MASK | CG_THERMAL_INT__TH=
ERM_INT_MASK_LOW_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ix=
CG_THERMAL_INT, thermal_int);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resu=
lt =3D amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_EnableThermalInterrupt);<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
result !=3D PPSMC_Result_OK) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG_KMS(&quot;Could not enable thermal interr=
upts.\n&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thermal_i=
nt |=3D THERM_INT_MASK_HIGH | THERM_INT_MASK_LOW;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG=
_THERMAL_INT, thermal_int);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thermal_i=
nt |=3D CG_THERMAL_INT__THERM_INT_MASK_HIGH_MASK | CG_THERMAL_INT__THERM_IN=
T_MASK_LOW_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ix=
CG_THERMAL_INT, thermal_int);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; @@ -6463,9 +6469,9 @@ static int si_thermal_set_temperature_range=
(struct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -EINVAL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(CG_THERMAL_INT, DIG_THERM_IN=
TH(high_temp / 1000), ~DIG_THERM_INTH_MASK);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(CG_THERMAL_INT, DIG_THERM_IN=
TL(low_temp / 1000), ~DIG_THERM_INTL_MASK);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(CG_THERMAL_CTRL, DIG_THERM_D=
PM(high_temp / 1000), ~DIG_THERM_DPM_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(ixCG_THERMAL_INT, (high_temp=
 / 1000) &lt;&lt; CG_THERMAL_INT__DIG_THERM_INTH__SHIFT, ~CG_THERMAL_INT__D=
IG_THERM_INTH_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(ixCG_THERMAL_INT, (low_temp =
/ 1000) &lt;&lt; CG_THERMAL_INT__DIG_THERM_INTL__SHIFT, ~CG_THERMAL_INT__DI=
G_THERM_INTL_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(ixCG_THERMAL_CTRL, (high_tem=
p / 1000) &lt;&lt; CG_THERMAL_CTRL__DIG_THERM_DPM__SHIFT, ~CG_THERMAL_CTRL_=
_DIG_THERM_DPM_MASK);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;pm.dpm.thermal.min_temp=
 =3D low_temp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;pm.dpm.thermal.max_temp=
 =3D high_temp;<br>
&gt; &gt; @@ -6479,20 +6485,20 @@ static void si_fan_ctrl_set_static_mode(s=
truct amdgpu_device *adev, u32 mode)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tmp;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (si_pi-&gt;fan_ctrl_is_in_def=
ault_mode) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D (=
RREG32(CG_FDO_CTRL2) &amp; FDO_PWM_MODE_MASK) &gt;&gt; FDO_PWM_MODE_SHIFT;<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D (=
RREG32(ixCG_FDO_CTRL2) &amp; CG_FDO_CTRL2__FDO_PWM_MODE_MASK) &gt;&gt; CG_F=
DO_CTRL2__FDO_PWM_MODE__SHIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_p=
i-&gt;fan_ctrl_default_mode =3D tmp;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D (=
RREG32(CG_FDO_CTRL2) &amp; TMIN_MASK) &gt;&gt; TMIN_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D (=
RREG32(ixCG_FDO_CTRL2) &amp; CG_FDO_CTRL2__TMIN_MASK) &gt;&gt; CG_FDO_CTRL2=
__TMIN__SHIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_p=
i-&gt;t_min =3D tmp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_p=
i-&gt;fan_ctrl_is_in_default_mode =3D false;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(CG_FDO_CTRL2) &amp; ~T=
MIN_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D TMIN(0);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_FDO_CTRL2, tmp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(ixCG_FDO_CTRL2) &amp; =
~CG_FDO_CTRL2__TMIN_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D 0 &lt;&lt; CG_FDO_CTRL2__TMI=
N__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_FDO_CTRL2, tmp);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(CG_FDO_CTRL2) &amp; ~F=
DO_PWM_MODE_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D FDO_PWM_MODE(mode);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_FDO_CTRL2, tmp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(ixCG_FDO_CTRL2) &amp; =
~CG_FDO_CTRL2__FDO_PWM_MODE_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D mode &lt;&lt; CG_FDO_CTRL2__=
FDO_PWM_MODE__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_FDO_CTRL2, tmp);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static int si_thermal_setup_fan_table(struct amdgpu_device =
*adev)<br>
&gt; &gt; @@ -6511,7 +6517,7 @@ static int si_thermal_setup_fan_table(struc=
t amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0duty100 =3D (RREG32(CG_FDO_CTRL1) &am=
p; FMAX_DUTY100_MASK) &gt;&gt; FMAX_DUTY100_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0duty100 =3D (RREG32(ixCG_FDO_CTRL1) &=
amp; CG_FDO_CTRL1__FMAX_DUTY100_MASK) &gt;&gt; CG_FDO_CTRL1__FMAX_DUTY100__=
SHIFT;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (duty100 =3D=3D 0) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev=
-&gt;pm.dpm.fan.ucode_fan_control =3D false;<br>
&gt; &gt; @@ -6547,7 +6553,7 @@ static int si_thermal_setup_fan_table(struc=
t amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reference_clock) / 1600);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fan_table.fdo_max =3D cpu_to_be1=
6((u16)duty100);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D (RREG32(CG_MULT_THERMAL_CTRL)=
 &amp; TEMP_SEL_MASK) &gt;&gt; TEMP_SEL_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D (RREG32(ixCG_MULT_THERMAL_CTR=
L) &amp; CG_MULT_THERMAL_CTRL__TEMP_SEL_MASK) &gt;&gt; CG_MULT_THERMAL_CTRL=
__TEMP_SEL__SHIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fan_table.temp_src =3D (uint8_t)=
tmp;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D amdgpu_si_copy_bytes_to_=
smc(adev,<br>
&gt; &gt; @@ -6606,8 +6612,8 @@ static int si_dpm_get_fan_speed_pwm(void *h=
andle,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;pm.no_fan)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -ENOENT;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0duty100 =3D (RREG32(CG_FDO_CTRL1) &am=
p; FMAX_DUTY100_MASK) &gt;&gt; FMAX_DUTY100_SHIFT;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0duty =3D (RREG32(CG_THERMAL_STATUS) &=
amp; FDO_PWM_DUTY_MASK) &gt;&gt; FDO_PWM_DUTY_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0duty100 =3D (RREG32(ixCG_FDO_CTRL1) &=
amp; CG_FDO_CTRL1__FMAX_DUTY100_MASK) &gt;&gt; CG_FDO_CTRL1__FMAX_DUTY100__=
SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0duty =3D (RREG32(ixCG_THERMAL_STATUS)=
 &amp; CG_THERMAL_STATUS__FDO_PWM_DUTY_MASK) &gt;&gt; CG_THERMAL_STATUS__FD=
O_PWM_DUTY__SHIFT;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (duty100 =3D=3D 0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -EINVAL;<br>
&gt; &gt; @@ -6637,7 +6643,7 @@ static int si_dpm_set_fan_speed_pwm(void *h=
andle,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 255)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -EINVAL;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0duty100 =3D (RREG32(CG_FDO_CTRL1) &am=
p; FMAX_DUTY100_MASK) &gt;&gt; FMAX_DUTY100_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0duty100 =3D (RREG32(ixCG_FDO_CTRL1) &=
amp; CG_FDO_CTRL1__FMAX_DUTY100_MASK) &gt;&gt; CG_FDO_CTRL1__FMAX_DUTY100__=
SHIFT;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (duty100 =3D=3D 0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -EINVAL;<br>
&gt; &gt; @@ -6646,9 +6652,9 @@ static int si_dpm_set_fan_speed_pwm(void *h=
andle,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, 255);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0duty =3D (u32)tmp64;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(CG_FDO_CTRL0) &amp; ~F=
DO_STATIC_DUTY_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D FDO_STATIC_DUTY(duty);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_FDO_CTRL0, tmp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(ixCG_FDO_CTRL0) &amp; =
~CG_FDO_CTRL0__FDO_STATIC_DUTY_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D duty &lt;&lt; CG_FDO_CTRL0__=
FDO_STATIC_DUTY__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_FDO_CTRL0, tmp);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; @@ -6688,8 +6694,8 @@ static int si_dpm_get_fan_control_mode(void=
 *handle, u32 *fan_mode)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (si_pi-&gt;fan_is_controlled_=
by_smc)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn 0;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(CG_FDO_CTRL2) &amp; FD=
O_PWM_MODE_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0*fan_mode =3D (tmp &gt;&gt; FDO_PWM_M=
ODE_SHIFT);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(ixCG_FDO_CTRL2) &amp; =
CG_FDO_CTRL2__FDO_PWM_MODE_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0*fan_mode =3D (tmp &gt;&gt; CG_FDO_CT=
RL2__FDO_PWM_MODE__SHIFT);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; @@ -6707,7 +6713,7 @@ static int si_fan_ctrl_get_fan_speed_rpm(st=
ruct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;pm.fan_pulses_per_r=
evolution =3D=3D 0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -ENOENT;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tach_period =3D (RREG32(CG_TACH_STATU=
S) &amp; TACH_PERIOD_MASK) &gt;&gt; TACH_PERIOD_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tach_period =3D (RREG32(ixCG_TACH_STA=
TUS) &amp; CG_TACH_STATUS__TACH_PERIOD_MASK) &gt;&gt; CG_TACH_STATUS__TACH_=
PERIOD__SHIFT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tach_period =3D=3D 0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -ENOENT;<br>
&gt; &gt;<br>
&gt; &gt; @@ -6736,9 +6742,9 @@ static int si_fan_ctrl_set_fan_speed_rpm(st=
ruct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_f=
an_ctrl_stop_smc_fan_control(adev);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tach_period =3D 60 * xclk * 1000=
0 / (8 * speed);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(CG_TACH_CTRL) &amp; ~T=
ARGET_PERIOD_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D TARGET_PERIOD(tach_period);<=
br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_TACH_CTRL, tmp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(ixCG_TACH_CTRL) &amp; =
~CG_TACH_CTRL__TARGET_PERIOD_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D tach_period &lt;&lt; CG_TACH=
_CTRL__TARGET_PERIOD__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_TACH_CTRL, tmp);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_fan_ctrl_set_static_mode(adev=
, FDO_PWM_MODE_STATIC_RPM);<br>
&gt; &gt;<br>
&gt; &gt; @@ -6752,13 +6758,13 @@ static void si_fan_ctrl_set_default_mode(=
struct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tmp;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!si_pi-&gt;fan_ctrl_is_in_de=
fault_mode) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D R=
REG32(CG_FDO_CTRL2) &amp; ~FDO_PWM_MODE_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
FDO_PWM_MODE(si_pi-&gt;fan_ctrl_default_mode);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG=
_FDO_CTRL2, tmp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D R=
REG32(ixCG_FDO_CTRL2) &amp; ~CG_FDO_CTRL2__FDO_PWM_MODE_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
si_pi-&gt;fan_ctrl_default_mode &lt;&lt; CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT;=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ix=
CG_FDO_CTRL2, tmp);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D R=
REG32(CG_FDO_CTRL2) &amp; ~TMIN_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
TMIN(si_pi-&gt;t_min);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG=
_FDO_CTRL2, tmp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D R=
REG32(ixCG_FDO_CTRL2) &amp; ~CG_FDO_CTRL2__TMIN_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
si_pi-&gt;t_min &lt;&lt; CG_FDO_CTRL2__TMIN__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ix=
CG_FDO_CTRL2, tmp);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_p=
i-&gt;fan_ctrl_is_in_default_mode =3D true;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; @@ -6776,14 +6782,14 @@ static void si_thermal_initialize(struct =
amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tmp;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;pm.fan_pulses_per_r=
evolution) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D R=
REG32(CG_TACH_CTRL) &amp; ~EDGE_PER_REV_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
EDGE_PER_REV(adev-&gt;pm.fan_pulses_per_revolution -1);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG=
_TACH_CTRL, tmp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D R=
REG32(ixCG_TACH_CTRL) &amp; ~CG_TACH_CTRL__EDGE_PER_REV_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D =
(adev-&gt;pm.fan_pulses_per_revolution -1) &lt;&lt; CG_TACH_CTRL__EDGE_PER_=
REV__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ix=
CG_TACH_CTRL, tmp);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(CG_FDO_CTRL2) &amp; ~T=
ACH_PWM_RESP_RATE_MASK;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D TACH_PWM_RESP_RATE(0x28);<br=
>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(CG_FDO_CTRL2, tmp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32(ixCG_FDO_CTRL2) &amp; =
~CG_FDO_CTRL2__TACH_PWM_RESP_RATE_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D 0x28 &lt;&lt; CG_FDO_CTRL2__=
TACH_PWM_RESP_RATE__SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(ixCG_FDO_CTRL2, tmp);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static int si_thermal_start_thermal_controller(struct amdgp=
u_device *adev)<br>
&gt; &gt; @@ -7546,8 +7552,8 @@ static void si_dpm_debugfs_print_current_pe=
rformance_level(void *handle,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=C2=A0 si_ps *ps =3D si_ge=
t_ps(rps);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rv7xx_pl *pl;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 current_index =3D<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(RREG32(T=
ARGET_AND_CURRENT_PROFILE_INDEX) &amp; CURRENT_STATE_INDEX_MASK) &gt;&gt;<b=
r>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CURRENT_S=
TATE_INDEX_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(RREG32(i=
xTARGET_AND_CURRENT_PROFILE_INDEX) &amp; TARGET_AND_CURRENT_PROFILE_INDEX__=
CURRENT_STATE_INDEX_MASK) &gt;&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0TARGET_AND_CURRENT_PROFILE_INDEX__CURRENT_STATE_INDEX__=
SHIFT;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (current_index &gt;=3D ps-&gt=
;performance_level_count) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0seq_=
printf(m, &quot;invalid dpm profile %d\n&quot;, current_index);<br>
&gt; &gt; @@ -7570,14 +7576,14 @@ static int si_dpm_set_interrupt_state(str=
uct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_THERMAL_IRQ_LOW_TO_H=
IGH:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0swit=
ch (state) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case=
 AMDGPU_IRQ_STATE_DISABLE:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int |=3D THERM_INT_MASK_HIGH;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int |=3D CG_THERMAL_INT__THERM_INT_MASK_HIGH=
_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case=
 AMDGPU_IRQ_STATE_ENABLE:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int &amp;=3D ~THERM_INT_MASK_HIGH;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int &amp;=3D ~CG_THERMAL_INT__THERM_INT_MASK=
_HIGH_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0defa=
ult:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; @@ -7587,14 +7593,14 @@ static int si_dpm_set_interrupt_state(str=
uct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_THERMAL_IRQ_HIGH_TO_=
LOW:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0swit=
ch (state) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case=
 AMDGPU_IRQ_STATE_DISABLE:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int |=3D THERM_INT_MASK_LOW;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int |=3D CG_THERMAL_INT__THERM_INT_MASK_LOW_=
MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case=
 AMDGPU_IRQ_STATE_ENABLE:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int =3D RREG32_SMC(CG_THERMAL_INT);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int &amp;=3D ~THERM_INT_MASK_LOW;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_SMC(CG_THERMAL_INT, cg_thermal_int);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int =3D RREG32_SMC(ixCG_THERMAL_INT);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cg_thermal_int &amp;=3D ~CG_THERMAL_INT__THERM_INT_MASK=
_LOW_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0WREG32_SMC(ixCG_THERMAL_INT, cg_thermal_int);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0defa=
ult:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; @@ -7884,8 +7890,8 @@ static int si_dpm_get_temp(void *handle)<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int actual_temp =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D (=
struct amdgpu_device *)handle;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D (RREG32(CG_MULT_THERMAL_STAT=
US) &amp; CTF_TEMP_MASK) &gt;&gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CTF_TEMP_=
SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D (RREG32(ixCG_MULT_THERMAL_ST=
ATUS) &amp; CG_MULT_THERMAL_STATUS__CTF_TEMP_MASK) &gt;&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CG_MULT_T=
HERMAL_STATUS__CTF_TEMP__SHIFT;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (temp &amp; 0x200)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actu=
al_temp =3D 255;<br>
&gt; &gt; @@ -8015,8 +8021,8 @@ static int si_dpm_read_sensor(void *handle,=
 int idx,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=C2=A0 si_ps *ps =3D si_ge=
t_ps(rps);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t sclk, mclk;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 pl_index =3D<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(RREG32(T=
ARGET_AND_CURRENT_PROFILE_INDEX) &amp; CURRENT_STATE_INDEX_MASK) &gt;&gt;<b=
r>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CURRENT_S=
TATE_INDEX_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(RREG32(i=
xTARGET_AND_CURRENT_PROFILE_INDEX) &amp; TARGET_AND_CURRENT_PROFILE_INDEX__=
CURRENT_STATE_INDEX_MASK) &gt;&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_AN=
D_CURRENT_PROFILE_INDEX__CURRENT_STATE_INDEX__SHIFT;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* size must be at least 4 bytes=
 for all sensors */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*size &lt; 4)<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c b/drivers=
/gpu/drm/amd/pm/legacy-dpm/si_smc.c<br>
&gt; &gt; index c712899c44ca..4e65ab9e931c 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c<br>
&gt; &gt; @@ -44,8 +44,8 @@ static int si_set_smc_sram_address(struct amdgp=
u_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((smc_address + 3) &gt; limit=
)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -EINVAL;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(SMC_IND_INDEX_0, smc_address);=
<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(SMC_IND_ACCESS_CNTL, 0, ~AUT=
O_INCREMENT_IND_0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(mmSMC_IND_INDEX_0, smc_address=
);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(mmSMC_IND_ACCESS_CNTL, 0, ~S=
MC_IND_ACCESS_CNTL__AUTO_INCREMENT_IND_0_MASK);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; @@ -74,7 +74,7 @@ int amdgpu_si_copy_bytes_to_smc(struct amdgpu_d=
evice *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
ret)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(SM=
C_IND_DATA_0, data);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(mm=
SMC_IND_DATA_0, data);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src =
+=3D 4;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0byte=
_count -=3D 4;<br>
&gt; &gt; @@ -89,7 +89,7 @@ int amdgpu_si_copy_bytes_to_smc(struct amdgpu_d=
evice *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
ret)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0original_=
data =3D RREG32(SMC_IND_DATA_0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0original_=
data =3D RREG32(mmSMC_IND_DATA_0);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0extr=
a_shift =3D 8 * (4 - byte_count);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0whil=
e (byte_count &gt; 0) {<br>
&gt; &gt; @@ -105,7 +105,7 @@ int amdgpu_si_copy_bytes_to_smc(struct amdgpu=
_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
ret)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(SM=
C_IND_DATA_0, data);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(mm=
SMC_IND_DATA_0, data);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 done:<br>
&gt; &gt; @@ -127,10 +127,10 @@ void amdgpu_si_reset_smc(struct amdgpu_devi=
ce *adev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tmp;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0RREG32(CB_CGTT_SCLK_CTRL);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0RREG32(CB_CGTT_SCLK_CTRL);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0RREG32(CB_CGTT_SCLK_CTRL);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0RREG32(CB_CGTT_SCLK_CTRL);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0RREG32(mmCB_CGTT_SCLK_CTRL);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0RREG32(mmCB_CGTT_SCLK_CTRL);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0RREG32(mmCB_CGTT_SCLK_CTRL);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0RREG32(mmCB_CGTT_SCLK_CTRL);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RREG32_SMC(SMC_SYSCON_RE=
SET_CNTL) |<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RST_REG;<br=
>
&gt; &gt; @@ -176,16 +176,16 @@ PPSMC_Result amdgpu_si_send_msg_to_smc(stru=
ct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!amdgpu_si_is_smc_running(ad=
ev))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn PPSMC_Result_Failed;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(SMC_MESSAGE_0, msg);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(mmSMC_MESSAGE_0, msg);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; adev-&gt;us=
ec_timeout; i++) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D R=
REG32(SMC_RESP_0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D R=
REG32(mmSMC_RESP_0);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
tmp !=3D 0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0udel=
ay(1);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return (PPSMC_Result)RREG32(SMC_RESP_=
0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return (PPSMC_Result)RREG32(mmSMC_RES=
P_0);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 PPSMC_Result amdgpu_si_wait_for_smc_inactive(struct amdgpu_=
device *adev)<br>
&gt; &gt; @@ -231,18 +231,18 @@ int amdgpu_si_load_smc_ucode(struct amdgpu_=
device *adev, u32 limit)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -EINVAL;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;adev-&gt;=
smc_idx_lock, flags);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(SMC_IND_INDEX_0, ucode_start_a=
ddress);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(SMC_IND_ACCESS_CNTL, AUTO_IN=
CREMENT_IND_0, ~AUTO_INCREMENT_IND_0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(mmSMC_IND_INDEX_0, ucode_start=
_address);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(mmSMC_IND_ACCESS_CNTL, SMC_I=
ND_ACCESS_CNTL__AUTO_INCREMENT_IND_0_MASK, ~SMC_IND_ACCESS_CNTL__AUTO_INCRE=
MENT_IND_0_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (ucode_size &gt;=3D 4) {<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* S=
MC address space is BE */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data=
 =3D (src[0] &lt;&lt; 24) | (src[1] &lt;&lt; 16) | (src[2] &lt;&lt; 8) | sr=
c[3];<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(SM=
C_IND_DATA_0, data);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(mm=
SMC_IND_DATA_0, data);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src =
+=3D 4;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ucod=
e_size -=3D 4;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(SMC_IND_ACCESS_CNTL, 0, ~AUT=
O_INCREMENT_IND_0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_P(mmSMC_IND_ACCESS_CNTL, 0, ~S=
MC_IND_ACCESS_CNTL__AUTO_INCREMENT_IND_0_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;adev=
-&gt;smc_idx_lock, flags);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; @@ -257,7 +257,7 @@ int amdgpu_si_read_smc_sram_dword(struct amdg=
pu_device *adev, u32 smc_address,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;adev-&gt;=
smc_idx_lock, flags);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D si_set_smc_sram_address(=
adev, smc_address, limit);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*value =
=3D RREG32(SMC_IND_DATA_0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*value =
=3D RREG32(mmSMC_IND_DATA_0);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;adev=
-&gt;smc_idx_lock, flags);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt; @@ -272,7 +272,7 @@ int amdgpu_si_write_smc_sram_dword(struct amd=
gpu_device *adev, u32 smc_address,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;adev-&gt;=
smc_idx_lock, flags);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D si_set_smc_sram_address(=
adev, smc_address, limit);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(SM=
C_IND_DATA_0, value);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(mm=
SMC_IND_DATA_0, value);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;adev=
-&gt;smc_idx_lock, flags);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt; --<br>
&gt; &gt; 2.48.1<br>
&gt; &gt;<br></div></div>

--0000000000003abc9c0630b7bd90--
