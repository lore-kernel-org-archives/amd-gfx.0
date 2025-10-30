Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69D9CCF9FC
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 13:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D4A10E26E;
	Thu, 30 Oct 2025 13:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K23x5rVv";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22EA810E26E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 13:32:08 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-29498a10972so1988465ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761831128; x=1762435928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agrWbPdkjQEmyZm01q7NKhWCxE6rtZqmyZxVBWPX+IU=;
 b=K23x5rVvSzbHOGgeJIA6fd58M8GgLFaZqdvXVxsmQTVWwvU54cSrzExYI1zl476xfT
 4UOpubIVBXYi6MxZOExZkn3LdvhArEpT6P5VwisKs53Bh2WwWHmKg/EHZRnVIBdI66rb
 0x9T7SoTc4dYorR7zIHJtzcHyFTQFbJwT2zV8ER1IvUaPZdvQbcieX7+uPKfrQyHo9o9
 9f34pBXlEUctKo9CMfA6Nsr2dlWtYvEMQfOJlL6sAaYlKUr3PZvSeTmueIT11boHLwg2
 o3pxD//i6vLBZ8V9g2dZ4N9IyGoLpwRA+2fbQVLrI2+dqPUAnZie5UAGdHRVo9IFmiyP
 Pr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761831128; x=1762435928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agrWbPdkjQEmyZm01q7NKhWCxE6rtZqmyZxVBWPX+IU=;
 b=B0EuKmZuS8TFVdjqBPaEk+vQvZgGf9ZUVRhLMLTZ5dHsYXbXMQBPMW+JMXKKRxmPyS
 9CzPhrt2XA17Fgy5xGEDa2AaIBTkP5QO71SelEnx0T2uT0/NLDX1dlL7o2eU2rJt/BIS
 adwKNC7dNGX2Fb+ezoGsytUwzU4y/FD0QyXIqnmxLBlwD8fOwum5Ac1JPG63F3DCuvoC
 me+eMr7BKIy9rnj1yyuQbdiPJzyIkOc/UqX1d3xAGl/bwP7/CB5ePUPvAdaqfRGKIeaw
 yqR7N/M/dvCEBYX0RXzpSjX7MdHr27vMAu402trS7NiF+oZBxLdubg8UutBu9MfY0ufB
 g9ww==
X-Gm-Message-State: AOJu0YyilYbPStCHV8cq+VJUJvG3NgiuwuLzjczUb3f0PsCV8c7SsKhX
 Bo9lnmixADK9mmyyi2M8Vcpl4bPJ4ISRKkY5fdDyx/JoJ6BemYcoUul202pD/v72SrTyS5Jf8Bq
 CED4tplNi5jOSLleDy8LHSxF69GCCsKQ=
X-Gm-Gg: ASbGnct+z5xh/7t16VoR6UvjIM8FtH6ZcHQ5PEyMqsrZfZO78ZZC3RfiUL++tP/YhBp
 gAcIjwmw59FhbI0+QH7pTPDMqXgHVsVSkADYyrfx8AuoOn1tNhwMat0+GNCgrJy0B486lhaB7py
 VUxWL9GvHQHphz0RIZZ90HJVDGmgRVIO9SOuPyfHgRSRrKYjr+DTEVwEsRBBbSRTKvV43dGL3Ro
 igA1Wcv3EPM1MczroRU48abEPbqsJ+BMYqPrZTHTDCMwnIR7rcc6WCYX3mWTc4cdubilL8=
X-Google-Smtp-Source: AGHT+IHhXiHGLxvb6OWZSiyyrUZwPeui/VQ1S6Wx1QsWV8gdYNOxiQQ6iyI8A6gw31HcAUZIO4cP/kNBc3GelkKpg/E=
X-Received: by 2002:a17:902:f392:b0:294:fbe5:89e8 with SMTP id
 d9443c01a7336-294fbe5963amr9926855ad.8.1761831127301; Thu, 30 Oct 2025
 06:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251030091556.68417-1-timur.kristof@gmail.com>
In-Reply-To: <20251030091556.68417-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Oct 2025 09:31:54 -0400
X-Gm-Features: AWmQ_bmX0EbemnVufFbgFVOfaqyjD4WAXgkqOk0MyknmDy1Pu3ADBUxTy3Td1ZY
Message-ID: <CADnq5_MvsWqB7_Vj-Y9ZSE5w1gGQZEZzBiiBqRHANgu=UQAn6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm/si: Delete unused structs and fields
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

Applied.  Thanks!

Alex

On Thu, Oct 30, 2025 at 5:31=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> The contents of si_dpm.h seem to have been copied from the
> old radeon driver, including a lot of structs and fields which
> were only relevant to GPU generations even older than SI.
>
> A lot of these can be deleted without causing much churn to the
> actual SI DPM code. Let's delete them to make the code easier
> to understand.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c |  10 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h | 557 ---------------------
>  2 files changed, 1 insertion(+), 566 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index bf7ab93b265d..1f539cc65f41 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -2558,18 +2558,13 @@ static int si_enable_power_containment(struct amd=
gpu_device *adev,
>                 if (enable) {
>                         if (!si_should_disable_uvd_powertune(adev, amdgpu=
_new_state)) {
>                                 smc_result =3D amdgpu_si_send_msg_to_smc(=
adev, PPSMC_TDPClampingActive);
> -                               if (smc_result !=3D PPSMC_Result_OK) {
> +                               if (smc_result !=3D PPSMC_Result_OK)
>                                         ret =3D -EINVAL;
> -                                       ni_pi->pc_enabled =3D false;
> -                               } else {
> -                                       ni_pi->pc_enabled =3D true;
> -                               }
>                         }
>                 } else {
>                         smc_result =3D amdgpu_si_send_msg_to_smc(adev, PP=
SMC_TDPClampingInactive);
>                         if (smc_result !=3D PPSMC_Result_OK)
>                                 ret =3D -EINVAL;
> -                       ni_pi->pc_enabled =3D false;
>                 }
>         }
>
> @@ -7516,8 +7511,6 @@ static int si_dpm_init(struct amdgpu_device *adev)
>         pi->pasi =3D CYPRESS_HASI_DFLT;
>         pi->vrc =3D SISLANDS_VRC_DFLT;
>
> -       pi->gfx_clock_gating =3D true;
> -
>         eg_pi->sclk_deep_sleep =3D true;
>         si_pi->sclk_deep_sleep_above_low =3D false;
>
> @@ -7528,7 +7521,6 @@ static int si_dpm_init(struct amdgpu_device *adev)
>
>         eg_pi->dynamic_ac_timing =3D true;
>
> -       eg_pi->light_sleep =3D true;
>  #if defined(CONFIG_ACPI)
>         eg_pi->pcie_performance_request =3D
>                 amdgpu_acpi_is_pcie_performance_request_supported(adev);
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.h
> index 11cb7874a6bb..3aed75fbf913 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
> @@ -38,11 +38,7 @@
>  #define        MC_ARB_DRAM_TIMING2_2                           0xa00
>  #define        MC_ARB_DRAM_TIMING2_3                           0xa01
>
> -#define MAX_NO_OF_MVDD_VALUES 2
> -#define MAX_NO_VREG_STEPS 32
>  #define NISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE 16
> -#define SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE 32
> -#define SMC_NISLANDS_MC_REGISTER_ARRAY_SET_COUNT 20
>  #define RV770_ASI_DFLT                                1000
>  #define CYPRESS_HASI_DFLT                               400000
>  #define PCIE_PERF_REQ_PECI_GEN1         2
> @@ -51,11 +47,6 @@
>  #define RV770_DEFAULT_VCLK_FREQ  53300 /* 10 khz */
>  #define RV770_DEFAULT_DCLK_FREQ  40000 /* 10 khz */
>
> -#define SMC_EVERGREEN_MC_REGISTER_ARRAY_SIZE 16
> -
> -#define RV770_SMC_TABLE_ADDRESS 0xB000
> -#define RV770_SMC_PERFORMANCE_LEVELS_PER_SWSTATE    3
> -
>  #define SMC_STROBE_RATIO    0x0F
>  #define SMC_STROBE_ENABLE   0x10
>
> @@ -64,27 +55,6 @@
>  #define SMC_MC_RTT_ENABLE   0x04
>  #define SMC_MC_STUTTER_EN   0x08
>
> -#define RV770_SMC_VOLTAGEMASK_VDDC 0
> -#define RV770_SMC_VOLTAGEMASK_MVDD 1
> -#define RV770_SMC_VOLTAGEMASK_VDDCI 2
> -#define RV770_SMC_VOLTAGEMASK_MAX  4
> -
> -#define NISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE 16
> -#define NISLANDS_SMC_STROBE_RATIO    0x0F
> -#define NISLANDS_SMC_STROBE_ENABLE   0x10
> -
> -#define NISLANDS_SMC_MC_EDC_RD_FLAG  0x01
> -#define NISLANDS_SMC_MC_EDC_WR_FLAG  0x02
> -#define NISLANDS_SMC_MC_RTT_ENABLE   0x04
> -#define NISLANDS_SMC_MC_STUTTER_EN   0x08
> -
> -#define MAX_NO_VREG_STEPS 32
> -
> -#define NISLANDS_SMC_VOLTAGEMASK_VDDC  0
> -#define NISLANDS_SMC_VOLTAGEMASK_MVDD  1
> -#define NISLANDS_SMC_VOLTAGEMASK_VDDCI 2
> -#define NISLANDS_SMC_VOLTAGEMASK_MAX   4
> -
>  #define SISLANDS_MCREGISTERTABLE_INITIAL_SLOT               0
>  #define SISLANDS_MCREGISTERTABLE_ACPI_SLOT                  1
>  #define SISLANDS_MCREGISTERTABLE_ULV_SLOT                   2
> @@ -219,32 +189,6 @@ enum si_cac_config_reg_type
>         SISLANDS_CACCONFIG_MAX
>  };
>
> -enum si_power_level {
> -       SI_POWER_LEVEL_LOW =3D 0,
> -       SI_POWER_LEVEL_MEDIUM =3D 1,
> -       SI_POWER_LEVEL_HIGH =3D 2,
> -       SI_POWER_LEVEL_CTXSW =3D 3,
> -};
> -
> -enum si_td {
> -       SI_TD_AUTO,
> -       SI_TD_UP,
> -       SI_TD_DOWN,
> -};
> -
> -enum si_display_watermark {
> -       SI_DISPLAY_WATERMARK_LOW =3D 0,
> -       SI_DISPLAY_WATERMARK_HIGH =3D 1,
> -};
> -
> -enum si_display_gap
> -{
> -    SI_PM_DISPLAY_GAP_VBLANK_OR_WM =3D 0,
> -    SI_PM_DISPLAY_GAP_VBLANK       =3D 1,
> -    SI_PM_DISPLAY_GAP_WATERMARK    =3D 2,
> -    SI_PM_DISPLAY_GAP_IGNORE       =3D 3,
> -};
> -
>  extern const struct amdgpu_ip_block_version si_smu_ip_block;
>
>  struct ni_leakage_coeffients
> @@ -258,56 +202,6 @@ struct ni_leakage_coeffients
>         u32 t_ref;
>  };
>
> -struct SMC_Evergreen_MCRegisterAddress
> -{
> -    uint16_t s0;
> -    uint16_t s1;
> -};
> -
> -typedef struct SMC_Evergreen_MCRegisterAddress SMC_Evergreen_MCRegisterA=
ddress;
> -
> -struct evergreen_mc_reg_entry {
> -       u32 mclk_max;
> -       u32 mc_data[SMC_EVERGREEN_MC_REGISTER_ARRAY_SIZE];
> -};
> -
> -struct evergreen_mc_reg_table {
> -       u8 last;
> -       u8 num_entries;
> -       u16 valid_flag;
> -       struct evergreen_mc_reg_entry mc_reg_table_entry[MAX_AC_TIMING_EN=
TRIES];
> -       SMC_Evergreen_MCRegisterAddress mc_reg_address[SMC_EVERGREEN_MC_R=
EGISTER_ARRAY_SIZE];
> -};
> -
> -struct SMC_Evergreen_MCRegisterSet
> -{
> -    uint32_t value[SMC_EVERGREEN_MC_REGISTER_ARRAY_SIZE];
> -};
> -
> -typedef struct SMC_Evergreen_MCRegisterSet SMC_Evergreen_MCRegisterSet;
> -
> -struct SMC_Evergreen_MCRegisters
> -{
> -    uint8_t                             last;
> -    uint8_t                             reserved[3];
> -    SMC_Evergreen_MCRegisterAddress     address[SMC_EVERGREEN_MC_REGISTE=
R_ARRAY_SIZE];
> -    SMC_Evergreen_MCRegisterSet         data[5];
> -};
> -
> -typedef struct SMC_Evergreen_MCRegisters SMC_Evergreen_MCRegisters;
> -
> -struct SMC_NIslands_MCRegisterSet
> -{
> -    uint32_t value[SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE];
> -};
> -
> -typedef struct SMC_NIslands_MCRegisterSet SMC_NIslands_MCRegisterSet;
> -
> -struct ni_mc_reg_entry {
> -       u32 mclk_max;
> -       u32 mc_data[SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE];
> -};
> -
>  struct SMC_NIslands_MCRegisterAddress
>  {
>      uint16_t s0;
> @@ -316,257 +210,20 @@ struct SMC_NIslands_MCRegisterAddress
>
>  typedef struct SMC_NIslands_MCRegisterAddress SMC_NIslands_MCRegisterAdd=
ress;
>
> -struct SMC_NIslands_MCRegisters
> -{
> -    uint8_t                             last;
> -    uint8_t                             reserved[3];
> -    SMC_NIslands_MCRegisterAddress      address[SMC_NISLANDS_MC_REGISTER=
_ARRAY_SIZE];
> -    SMC_NIslands_MCRegisterSet          data[SMC_NISLANDS_MC_REGISTER_AR=
RAY_SET_COUNT];
> -};
> -
> -typedef struct SMC_NIslands_MCRegisters SMC_NIslands_MCRegisters;
> -
> -struct evergreen_ulv_param {
> -       bool supported;
> -       struct rv7xx_pl *pl;
> -};
> -
> -struct evergreen_arb_registers {
> -       u32 mc_arb_dram_timing;
> -       u32 mc_arb_dram_timing2;
> -       u32 mc_arb_rfsh_rate;
> -       u32 mc_arb_burst_time;
> -};
> -
> -struct at {
> -       u32 rlp;
> -       u32 rmp;
> -       u32 lhp;
> -       u32 lmp;
> -};
> -
> -struct ni_clock_registers {
> -       u32 cg_spll_func_cntl;
> -       u32 cg_spll_func_cntl_2;
> -       u32 cg_spll_func_cntl_3;
> -       u32 cg_spll_func_cntl_4;
> -       u32 cg_spll_spread_spectrum;
> -       u32 cg_spll_spread_spectrum_2;
> -       u32 mclk_pwrmgt_cntl;
> -       u32 dll_cntl;
> -       u32 mpll_ad_func_cntl;
> -       u32 mpll_ad_func_cntl_2;
> -       u32 mpll_dq_func_cntl;
> -       u32 mpll_dq_func_cntl_2;
> -       u32 mpll_ss1;
> -       u32 mpll_ss2;
> -};
> -
> -struct RV770_SMC_SCLK_VALUE
> -{
> -    uint32_t        vCG_SPLL_FUNC_CNTL;
> -    uint32_t        vCG_SPLL_FUNC_CNTL_2;
> -    uint32_t        vCG_SPLL_FUNC_CNTL_3;
> -    uint32_t        vCG_SPLL_SPREAD_SPECTRUM;
> -    uint32_t        vCG_SPLL_SPREAD_SPECTRUM_2;
> -    uint32_t        sclk_value;
> -};
> -
> -typedef struct RV770_SMC_SCLK_VALUE RV770_SMC_SCLK_VALUE;
> -
> -struct RV770_SMC_MCLK_VALUE
> -{
> -    uint32_t        vMPLL_AD_FUNC_CNTL;
> -    uint32_t        vMPLL_AD_FUNC_CNTL_2;
> -    uint32_t        vMPLL_DQ_FUNC_CNTL;
> -    uint32_t        vMPLL_DQ_FUNC_CNTL_2;
> -    uint32_t        vMCLK_PWRMGT_CNTL;
> -    uint32_t        vDLL_CNTL;
> -    uint32_t        vMPLL_SS;
> -    uint32_t        vMPLL_SS2;
> -    uint32_t        mclk_value;
> -};
> -
> -typedef struct RV770_SMC_MCLK_VALUE RV770_SMC_MCLK_VALUE;
> -
> -
> -struct RV730_SMC_MCLK_VALUE
> -{
> -    uint32_t        vMCLK_PWRMGT_CNTL;
> -    uint32_t        vDLL_CNTL;
> -    uint32_t        vMPLL_FUNC_CNTL;
> -    uint32_t        vMPLL_FUNC_CNTL2;
> -    uint32_t        vMPLL_FUNC_CNTL3;
> -    uint32_t        vMPLL_SS;
> -    uint32_t        vMPLL_SS2;
> -    uint32_t        mclk_value;
> -};
> -
> -typedef struct RV730_SMC_MCLK_VALUE RV730_SMC_MCLK_VALUE;
> -
> -struct RV770_SMC_VOLTAGE_VALUE
> -{
> -    uint16_t             value;
> -    uint8_t              index;
> -    uint8_t              padding;
> -};
> -
> -typedef struct RV770_SMC_VOLTAGE_VALUE RV770_SMC_VOLTAGE_VALUE;
> -
> -union RV7XX_SMC_MCLK_VALUE
> -{
> -    RV770_SMC_MCLK_VALUE    mclk770;
> -    RV730_SMC_MCLK_VALUE    mclk730;
> -};
> -
> -typedef union RV7XX_SMC_MCLK_VALUE RV7XX_SMC_MCLK_VALUE, *LPRV7XX_SMC_MC=
LK_VALUE;
> -
> -struct RV770_SMC_HW_PERFORMANCE_LEVEL
> -{
> -    uint8_t                 arbValue;
> -    union{
> -        uint8_t             seqValue;
> -        uint8_t             ACIndex;
> -    };
> -    uint8_t                 displayWatermark;
> -    uint8_t                 gen2PCIE;
> -    uint8_t                 gen2XSP;
> -    uint8_t                 backbias;
> -    uint8_t                 strobeMode;
> -    uint8_t                 mcFlags;
> -    uint32_t                aT;
> -    uint32_t                bSP;
> -    RV770_SMC_SCLK_VALUE    sclk;
> -    RV7XX_SMC_MCLK_VALUE    mclk;
> -    RV770_SMC_VOLTAGE_VALUE vddc;
> -    RV770_SMC_VOLTAGE_VALUE mvdd;
> -    RV770_SMC_VOLTAGE_VALUE vddci;
> -    uint8_t                 reserved1;
> -    uint8_t                 reserved2;
> -    uint8_t                 stateFlags;
> -    uint8_t                 padding;
> -};
> -
> -typedef struct RV770_SMC_HW_PERFORMANCE_LEVEL RV770_SMC_HW_PERFORMANCE_L=
EVEL;
> -
> -struct RV770_SMC_SWSTATE
> -{
> -    uint8_t           flags;
> -    uint8_t           padding1;
> -    uint8_t           padding2;
> -    uint8_t           padding3;
> -    RV770_SMC_HW_PERFORMANCE_LEVEL levels[RV770_SMC_PERFORMANCE_LEVELS_P=
ER_SWSTATE];
> -};
> -
> -typedef struct RV770_SMC_SWSTATE RV770_SMC_SWSTATE;
> -
> -struct RV770_SMC_VOLTAGEMASKTABLE
> -{
> -    uint8_t  highMask[RV770_SMC_VOLTAGEMASK_MAX];
> -    uint32_t lowMask[RV770_SMC_VOLTAGEMASK_MAX];
> -};
> -
> -typedef struct RV770_SMC_VOLTAGEMASKTABLE RV770_SMC_VOLTAGEMASKTABLE;
> -
> -struct RV770_SMC_STATETABLE
> -{
> -    uint8_t             thermalProtectType;
> -    uint8_t             systemFlags;
> -    uint8_t             maxVDDCIndexInPPTable;
> -    uint8_t             extraFlags;
> -    uint8_t             highSMIO[MAX_NO_VREG_STEPS];
> -    uint32_t            lowSMIO[MAX_NO_VREG_STEPS];
> -    RV770_SMC_VOLTAGEMASKTABLE voltageMaskTable;
> -    RV770_SMC_SWSTATE   initialState;
> -    RV770_SMC_SWSTATE   ACPIState;
> -    RV770_SMC_SWSTATE   driverState;
> -    RV770_SMC_SWSTATE   ULVState;
> -};
> -
> -typedef struct RV770_SMC_STATETABLE RV770_SMC_STATETABLE;
> -
> -struct vddc_table_entry {
> -       u16 vddc;
> -       u8 vddc_index;
> -       u8 high_smio;
> -       u32 low_smio;
> -};
> -
> -struct rv770_clock_registers {
> -       u32 cg_spll_func_cntl;
> -       u32 cg_spll_func_cntl_2;
> -       u32 cg_spll_func_cntl_3;
> -       u32 cg_spll_spread_spectrum;
> -       u32 cg_spll_spread_spectrum_2;
> -       u32 mpll_ad_func_cntl;
> -       u32 mpll_ad_func_cntl_2;
> -       u32 mpll_dq_func_cntl;
> -       u32 mpll_dq_func_cntl_2;
> -       u32 mclk_pwrmgt_cntl;
> -       u32 dll_cntl;
> -       u32 mpll_ss1;
> -       u32 mpll_ss2;
> -};
> -
> -struct rv730_clock_registers {
> -       u32 cg_spll_func_cntl;
> -       u32 cg_spll_func_cntl_2;
> -       u32 cg_spll_func_cntl_3;
> -       u32 cg_spll_spread_spectrum;
> -       u32 cg_spll_spread_spectrum_2;
> -       u32 mclk_pwrmgt_cntl;
> -       u32 dll_cntl;
> -       u32 mpll_func_cntl;
> -       u32 mpll_func_cntl2;
> -       u32 mpll_func_cntl3;
> -       u32 mpll_ss;
> -       u32 mpll_ss2;
> -};
> -
> -union r7xx_clock_registers {
> -       struct rv770_clock_registers rv770;
> -       struct rv730_clock_registers rv730;
> -};
> -
>  struct rv7xx_power_info {
>         /* flags */
> -       bool mem_gddr5;
> -       bool pcie_gen2;
> -       bool dynamic_pcie_gen2;
> -       bool acpi_pcie_gen2;
> -       bool boot_in_gen2;
>         bool voltage_control; /* vddc */
>         bool mvdd_control;
>         bool sclk_ss;
>         bool mclk_ss;
>         bool dynamic_ss;
> -       bool gfx_clock_gating;
> -       bool mg_clock_gating;
> -       bool mgcgtssm;
> -       bool power_gating;
>         bool thermal_protection;
> -       bool display_gap;
> -       bool dcodt;
> -       bool ulps;
> -       /* registers */
> -       union r7xx_clock_registers clk_regs;
> -       u32 s0_vid_lower_smio_cntl;
>         /* voltage */
> -       u32 vddc_mask_low;
> -       u32 mvdd_mask_low;
>         u32 mvdd_split_frequency;
> -       u32 mvdd_low_smio[MAX_NO_OF_MVDD_VALUES];
>         u16 max_vddc;
>         u16 max_vddc_in_table;
>         u16 min_vddc_in_table;
> -       struct vddc_table_entry vddc_table[MAX_NO_VREG_STEPS];
> -       u8 valid_vddc_entries;
> -       /* dc odt */
> -       u32 mclk_odt_threshold;
> -       u8 odt_value_0[2];
> -       u8 odt_value_1[2];
>         /* stored values */
> -       u32 boot_sclk;
>         u16 acpi_vddc;
>         u32 ref_div;
>         u32 active_auto_throttle_sources;
> @@ -582,17 +239,6 @@ struct rv7xx_power_info {
>         u32 asi;
>         u32 pasi;
>         u32 vrc;
> -       u32 restricted_levels;
> -       u32 rlp;
> -       u32 rmp;
> -       u32 lhp;
> -       u32 lmp;
> -       /* smc offsets */
> -       u16 state_table_start;
> -       u16 soft_regs_start;
> -       u16 sram_end;
> -       /* scratch structs */
> -       RV770_SMC_STATETABLE smc_statetable;
>  };
>
>  enum si_pcie_gen {
> @@ -611,44 +257,12 @@ struct rv7xx_pl {
>         enum si_pcie_gen pcie_gen; /* si+ only */
>  };
>
> -struct rv7xx_ps {
> -       struct rv7xx_pl high;
> -       struct rv7xx_pl medium;
> -       struct rv7xx_pl low;
> -       bool dc_compatible;
> -};
> -
>  struct si_ps {
>         u16 performance_level_count;
>         bool dc_compatible;
>         struct rv7xx_pl performance_levels[NISLANDS_MAX_SMC_PERFORMANCE_L=
EVELS_PER_SWSTATE];
>  };
>
> -struct ni_mc_reg_table {
> -       u8 last;
> -       u8 num_entries;
> -       u16 valid_flag;
> -       struct ni_mc_reg_entry mc_reg_table_entry[MAX_AC_TIMING_ENTRIES];
> -       SMC_NIslands_MCRegisterAddress mc_reg_address[SMC_NISLANDS_MC_REG=
ISTER_ARRAY_SIZE];
> -};
> -
> -struct ni_cac_data
> -{
> -       struct ni_leakage_coeffients leakage_coefficients;
> -       u32 i_leakage;
> -       s32 leakage_minimum_temperature;
> -       u32 pwr_const;
> -       u32 dc_cac_value;
> -       u32 bif_cac_value;
> -       u32 lkge_pwr;
> -       u8 mc_wr_weight;
> -       u8 mc_rd_weight;
> -       u8 allow_ovrflw;
> -       u8 num_win_tdp;
> -       u8 l2num_win_tdp;
> -       u8 lts_truncate_n;
> -};
> -
>  struct evergreen_power_info {
>         /* must be first! */
>         struct rv7xx_power_info rv7xx;
> @@ -657,203 +271,33 @@ struct evergreen_power_info {
>         bool dynamic_ac_timing;
>         bool abm;
>         bool mcls;
> -       bool light_sleep;
> -       bool memory_transition;
>         bool pcie_performance_request;
> -       bool pcie_performance_request_registered;
>         bool sclk_deep_sleep;
> -       bool dll_default_on;
> -       bool ls_clock_gating;
>         bool smu_uvd_hs;
>         bool uvd_enabled;
>         /* stored values */
>         u16 acpi_vddci;
> -       u8 mvdd_high_index;
> -       u8 mvdd_low_index;
>         u32 mclk_edc_wr_enable_threshold;
> -       struct evergreen_mc_reg_table mc_reg_table;
>         struct atom_voltage_table vddc_voltage_table;
>         struct atom_voltage_table vddci_voltage_table;
> -       struct evergreen_arb_registers bootup_arb_registers;
> -       struct evergreen_ulv_param ulv;
> -       struct at ats[2];
> -       /* smc offsets */
> -       u16 mc_reg_table_start;
>         struct amdgpu_ps current_rps;
> -       struct rv7xx_ps current_ps;
>         struct amdgpu_ps requested_rps;
> -       struct rv7xx_ps requested_ps;
> -};
> -
> -struct PP_NIslands_Dpm2PerfLevel
> -{
> -    uint8_t     MaxPS;
> -    uint8_t     TgtAct;
> -    uint8_t     MaxPS_StepInc;
> -    uint8_t     MaxPS_StepDec;
> -    uint8_t     PSST;
> -    uint8_t     NearTDPDec;
> -    uint8_t     AboveSafeInc;
> -    uint8_t     BelowSafeInc;
> -    uint8_t     PSDeltaLimit;
> -    uint8_t     PSDeltaWin;
> -    uint8_t     Reserved[6];
> -};
> -
> -typedef struct PP_NIslands_Dpm2PerfLevel PP_NIslands_Dpm2PerfLevel;
> -
> -struct PP_NIslands_DPM2Parameters
> -{
> -    uint32_t    TDPLimit;
> -    uint32_t    NearTDPLimit;
> -    uint32_t    SafePowerLimit;
> -    uint32_t    PowerBoostLimit;
> -};
> -typedef struct PP_NIslands_DPM2Parameters PP_NIslands_DPM2Parameters;
> -
> -struct NISLANDS_SMC_SCLK_VALUE
> -{
> -    uint32_t        vCG_SPLL_FUNC_CNTL;
> -    uint32_t        vCG_SPLL_FUNC_CNTL_2;
> -    uint32_t        vCG_SPLL_FUNC_CNTL_3;
> -    uint32_t        vCG_SPLL_FUNC_CNTL_4;
> -    uint32_t        vCG_SPLL_SPREAD_SPECTRUM;
> -    uint32_t        vCG_SPLL_SPREAD_SPECTRUM_2;
> -    uint32_t        sclk_value;
> -};
> -
> -typedef struct NISLANDS_SMC_SCLK_VALUE NISLANDS_SMC_SCLK_VALUE;
> -
> -struct NISLANDS_SMC_MCLK_VALUE
> -{
> -    uint32_t        vMPLL_FUNC_CNTL;
> -    uint32_t        vMPLL_FUNC_CNTL_1;
> -    uint32_t        vMPLL_FUNC_CNTL_2;
> -    uint32_t        vMPLL_AD_FUNC_CNTL;
> -    uint32_t        vMPLL_AD_FUNC_CNTL_2;
> -    uint32_t        vMPLL_DQ_FUNC_CNTL;
> -    uint32_t        vMPLL_DQ_FUNC_CNTL_2;
> -    uint32_t        vMCLK_PWRMGT_CNTL;
> -    uint32_t        vDLL_CNTL;
> -    uint32_t        vMPLL_SS;
> -    uint32_t        vMPLL_SS2;
> -    uint32_t        mclk_value;
> -};
> -
> -typedef struct NISLANDS_SMC_MCLK_VALUE NISLANDS_SMC_MCLK_VALUE;
> -
> -struct NISLANDS_SMC_VOLTAGE_VALUE
> -{
> -    uint16_t             value;
> -    uint8_t              index;
> -    uint8_t              padding;
> -};
> -
> -typedef struct NISLANDS_SMC_VOLTAGE_VALUE NISLANDS_SMC_VOLTAGE_VALUE;
> -
> -struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL
> -{
> -    uint8_t                     arbValue;
> -    uint8_t                     ACIndex;
> -    uint8_t                     displayWatermark;
> -    uint8_t                     gen2PCIE;
> -    uint8_t                     reserved1;
> -    uint8_t                     reserved2;
> -    uint8_t                     strobeMode;
> -    uint8_t                     mcFlags;
> -    uint32_t                    aT;
> -    uint32_t                    bSP;
> -    NISLANDS_SMC_SCLK_VALUE     sclk;
> -    NISLANDS_SMC_MCLK_VALUE     mclk;
> -    NISLANDS_SMC_VOLTAGE_VALUE  vddc;
> -    NISLANDS_SMC_VOLTAGE_VALUE  mvdd;
> -    NISLANDS_SMC_VOLTAGE_VALUE  vddci;
> -    NISLANDS_SMC_VOLTAGE_VALUE  std_vddc;
> -    uint32_t                    powergate_en;
> -    uint8_t                     hUp;
> -    uint8_t                     hDown;
> -    uint8_t                     stateFlags;
> -    uint8_t                     arbRefreshState;
> -    uint32_t                    SQPowerThrottle;
> -    uint32_t                    SQPowerThrottle_2;
> -    uint32_t                    reserved[2];
> -    PP_NIslands_Dpm2PerfLevel   dpm2;
> -};
> -
> -typedef struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL NISLANDS_SMC_HW_PERFORM=
ANCE_LEVEL;
> -
> -struct NISLANDS_SMC_SWSTATE
> -{
> -    uint8_t                             flags;
> -    uint8_t                             levelCount;
> -    uint8_t                             padding2;
> -    uint8_t                             padding3;
> -    NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
> -};
> -
> -typedef struct NISLANDS_SMC_SWSTATE NISLANDS_SMC_SWSTATE;
> -
> -struct NISLANDS_SMC_VOLTAGEMASKTABLE
> -{
> -    uint8_t  highMask[NISLANDS_SMC_VOLTAGEMASK_MAX];
> -    uint32_t lowMask[NISLANDS_SMC_VOLTAGEMASK_MAX];
> -};
> -
> -typedef struct NISLANDS_SMC_VOLTAGEMASKTABLE NISLANDS_SMC_VOLTAGEMASKTAB=
LE;
> -
> -#define NISLANDS_MAX_NO_VREG_STEPS 32
> -
> -struct NISLANDS_SMC_STATETABLE
> -{
> -    uint8_t                             thermalProtectType;
> -    uint8_t                             systemFlags;
> -    uint8_t                             maxVDDCIndexInPPTable;
> -    uint8_t                             extraFlags;
> -    uint8_t                             highSMIO[NISLANDS_MAX_NO_VREG_ST=
EPS];
> -    uint32_t                            lowSMIO[NISLANDS_MAX_NO_VREG_STE=
PS];
> -    NISLANDS_SMC_VOLTAGEMASKTABLE       voltageMaskTable;
> -    PP_NIslands_DPM2Parameters          dpm2Params;
> -    NISLANDS_SMC_SWSTATE                initialState;
> -    NISLANDS_SMC_SWSTATE                ACPIState;
> -    NISLANDS_SMC_SWSTATE                ULVState;
> -    NISLANDS_SMC_SWSTATE                driverState;
> -    NISLANDS_SMC_HW_PERFORMANCE_LEVEL   dpmLevels[NISLANDS_MAX_SMC_PERFO=
RMANCE_LEVELS_PER_SWSTATE - 1];
>  };
>
> -typedef struct NISLANDS_SMC_STATETABLE NISLANDS_SMC_STATETABLE;
> -
>  struct ni_power_info {
>         /* must be first! */
>         struct evergreen_power_info eg;
> -       struct ni_clock_registers clock_registers;
> -       struct ni_mc_reg_table mc_reg_table;
>         u32 mclk_rtt_mode_threshold;
>         /* flags */
> -       bool use_power_boost_limit;
>         bool support_cac_long_term_average;
>         bool cac_enabled;
>         bool cac_configuration_required;
>         bool driver_calculate_cac_leakage;
> -       bool pc_enabled;
>         bool enable_power_containment;
>         bool enable_cac;
>         bool enable_sq_ramping;
> -       /* smc offsets */
> -       u16 arb_table_start;
> -       u16 fan_table_start;
> -       u16 cac_table_start;
> -       u16 spll_table_start;
> -       /* CAC stuff */
> -       struct ni_cac_data cac_data;
> -       u32 dc_cac_table[NISLANDS_DCCAC_MAX_LEVELS];
> -       const struct ni_cac_weights *cac_weights;
> -       u8 lta_window_size;
> -       u8 lts_truncate;
>         struct si_ps current_ps;
>         struct si_ps requested_ps;
> -       /* scratch structs */
> -       SMC_NIslands_MCRegisters smc_mc_reg_table;
> -       NISLANDS_SMC_STATETABLE smc_statetable;
>  };
>
>  struct si_cac_config_reg
> @@ -952,7 +396,6 @@ struct si_leakage_voltage
>         struct si_leakage_voltage_entry entries[SISLANDS_MAX_LEAKAGE_COUN=
T];
>  };
>
> -
>  struct si_ulv_param {
>         bool supported;
>         u32 cg_ulv_control;
> --
> 2.51.0
>
