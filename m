Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FD1C02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 15:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659D310E9A5;
	Thu, 16 Jan 2025 15:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hB7L76xD";
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D364C10E9A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 15:07:17 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f615e14d0fso235312a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737040037; x=1737644837; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JErvk/ObJWQXCTn/l+bUOd5rMKF/iCZCH6v8t8HPBgo=;
 b=hB7L76xDUxDlxAsF7bSdyOXnrMoleAlaxbT82aBey3K/4yVASX+X7M+MKJ07TZyCko
 MSL4Vhj2DMMdzThzDvGQ1yHykS38dQkqhyy9YHzv0VhwlhT+JQ8i6vqb0TFEczRKl4Uu
 nR1VovnjE5kZi+ofZl78Aq9Ir1cLddwTrlvUbYhowxb92/ZX9QTewRVBPbFzE6rt/iFr
 5+KhQD4hxuJantwZ8iErQQRtDpwB/OevO2slFJTtqR01Nq54wSODh/BhMypt8qDAmYJ1
 FJ0Is8aKIX3kbS1OoQIp1rIdNKvXCK2CctQi08n51t/XVnyGdCxc4KcopM81cjcH0abd
 evCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737040037; x=1737644837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JErvk/ObJWQXCTn/l+bUOd5rMKF/iCZCH6v8t8HPBgo=;
 b=ZsC6WLhYT7soXAwiN8hoDfewQjfPMhj0pLvspWbQA4sb4reW1hrjzo9uomg7xZYbh4
 uue2SLUJiX5V5toFJTzc7u7AYY0GWjn5BfOF6Gy0BN2xO8sTr0sVpoRFw5+Ilqvfrw73
 j8Hgj+/4Rv3HZmBT1ben6b4vtx1AQ7NZfMzX6MLHtuyIIxPRhjnES2anPO/rRpL6c+sQ
 rc6O7aO9YNSYlEPAedIbIdejhJpAR/VEuo68dbxRy5KnANnet1+I3Yo7mvPLp9ykKs/P
 05PAlawzqjhI7HOf2Xb1CxXYsIdx3yv5YusUCcG9nFDPt5H1Jk61KB9lDetxwdWKxr+7
 BGVA==
X-Gm-Message-State: AOJu0YzkX4gJtE62INkuFCTk33JIAENhilH78y1prxAXgzdX2K6O8P6X
 hIxRwmESQ5e9TsiFS0UIfwKo5eFBcbkfc0o4df6fApkcc5dcAWwPYbvdqVhgAfpcK/8JJrbxn4v
 cui2AUOQrbuJublKg2wimXHNDiMo5eA==
X-Gm-Gg: ASbGncvpSTfsT6xOtQP34wO/MHwy7iNISRVVFyj6qQOFRYWdcwa0NN0NQkfG4eF5/3z
 bMH5WtE1nETD+Miki7faiAwavOj/eOsIDiuikMA==
X-Google-Smtp-Source: AGHT+IGhWkiSVm0cYZd6PhuD+FmlyXmPCdhXWuXQhHCD7bqhsyLkcRBU7POtWHLjeTThSJHbaWa/W8zOzjeIlJQ2YF8=
X-Received: by 2002:a17:90b:2c8c:b0:2ee:b665:12c2 with SMTP id
 98e67ed59e1d1-2f548f04e89mr18551403a91.2.1737040037150; Thu, 16 Jan 2025
 07:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20250116122908.1451094-1-lijo.lazar@amd.com>
In-Reply-To: <20250116122908.1451094-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2025 10:07:05 -0500
X-Gm-Features: AbW1kvalF80oCrhZw2zcl5YHsTi6UoLBL1XAsyDpsvYTRKr0SErzm2noiDS5m_0
Message-ID: <CADnq5_MEEUN5wnUt2Hk17+5prLBKjZCGA5pn=1FLJ9MXbBf+JQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Add capability flags for SMU v13.0.6
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, kevinyang.wang@amd.com
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

On Thu, Jan 16, 2025 at 7:29=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add capability flags for SMU v13.0.6 variants. Initialize the flags
> based on firmware support. As there are multiple IP versions maintained,
> it is more manageable with one time initialization caps flags based on
> IP version and firmware feature support.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

This is a nice cleanup.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   1 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 225 ++++++++++++------
>  2 files changed, 158 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_v13_0.h
> index 356d9422b411..8d4a96e23326 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -107,6 +107,7 @@ struct smu_13_0_dpm_context {
>         struct smu_13_0_dpm_tables  dpm_tables;
>         uint32_t                    workload_policy_mask;
>         uint32_t                    dcef_min_ds_clk;
> +       uint64_t                    caps;
>  };
>
>  enum smu_13_0_power_state {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index c12959a36d78..56e26fcd3066 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -101,38 +101,25 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
>  #define MCA_BANK_IPID(_ip, _hwid, _type) \
>         [AMDGPU_MCA_IP_##_ip] =3D { .hwid =3D _hwid, .mcatype =3D _type, =
}
>
> -static inline bool smu_v13_0_6_is_unified_metrics(struct smu_context *sm=
u)
> -{
> -       return (smu->adev->flags & AMD_IS_APU) &&
> -               smu->smc_fw_version <=3D 0x4556900;
> -}
> -
> -static inline bool smu_v13_0_6_is_other_end_count_available(struct smu_c=
ontext *smu)
> -{
> -       switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
> -       case IP_VERSION(13, 0, 6):
> -               return smu->smc_fw_version >=3D 0x557600;
> -       case IP_VERSION(13, 0, 14):
> -               return smu->smc_fw_version >=3D 0x05550E00;
> -       default:
> -               return false;
> -       }
> -}
> -
> -static inline bool smu_v13_0_6_is_blw_host_limit_available(struct smu_co=
ntext *smu)
> -{
> -       if (smu->adev->flags & AMD_IS_APU)
> -               return smu->smc_fw_version >=3D 0x04556F00;
> +enum smu_v13_0_6_caps {
> +       SMU_13_0_6_CAPS_DPM,
> +       SMU_13_0_6_CAPS_UNI_METRICS,
> +       SMU_13_0_6_CAPS_DPM_POLICY,
> +       SMU_13_0_6_CAPS_OTHER_END_METRICS,
> +       SMU_13_0_6_CAPS_SET_UCLK_MAX,
> +       SMU_13_0_6_CAPS_PCIE_METRICS,
> +       SMU_13_0_6_CAPS_HST_LIMIT_METRICS,
> +       SMU_13_0_6_CAPS_MCA_DEBUG_MODE,
> +       SMU_13_0_6_CAPS_PER_INST_METRICS,
> +       SMU_13_0_6_CAPS_CTF_LIMIT,
> +       SMU_13_0_6_CAPS_RMA_MSG,
> +       SMU_13_0_6_CAPS_ACA_SYND,
> +       SMU_13_0_6_CAPS_SDMA_RESET,
> +       SMU_13_0_6_CAPS_ALL,
> +};
>
> -       switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
> -       case IP_VERSION(13, 0, 6):
> -               return smu->smc_fw_version >=3D 0x557900;
> -       case IP_VERSION(13, 0, 14):
> -               return smu->smc_fw_version >=3D 0x05551000;
> -       default:
> -               return false;
> -       }
> -}
> +#define SMU_CAPS_MASK(x) (ULL(1) << x)
> +#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)
>
>  struct mca_bank_ipid {
>         enum amdgpu_mca_ip ip;
> @@ -297,6 +284,119 @@ struct smu_v13_0_6_dpm_map {
>         uint32_t *freq_table;
>  };
>
> +static void smu_v13_0_14_init_caps(struct smu_context *smu)
> +{
> +       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> +       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
> +                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
> +                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
> +                       SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
> +                       SMU_CAPS(ACA_SYND);
> +       uint32_t fw_ver =3D smu->smc_fw_version;
> +
> +       if (fw_ver >=3D 0x05550E00)
> +               caps |=3D SMU_CAPS(OTHER_END_METRICS);
> +       if (fw_ver >=3D 0x05551000)
> +               caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +       if (fw_ver >=3D 0x05550B00)
> +               caps |=3D SMU_CAPS(PER_INST_METRICS);
> +       if (fw_ver > 0x05550f00)
> +               caps |=3D SMU_CAPS(SDMA_RESET);
> +
> +       dpm_context->caps =3D caps;
> +}
> +
> +static void smu_v13_0_6_init_caps(struct smu_context *smu)
> +{
> +       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
> +                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
> +                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(MCA_DEBUG_MODE)=
 |
> +                       SMU_CAPS(CTF_LIMIT) | SMU_CAPS(RMA_MSG) |
> +                       SMU_CAPS(ACA_SYND);
> +       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> +       struct amdgpu_device *adev =3D smu->adev;
> +       uint32_t fw_ver =3D smu->smc_fw_version;
> +       uint32_t pgm =3D (fw_ver >> 24) & 0xFF;
> +
> +       if (fw_ver < 0x552F00)
> +               caps &=3D ~SMU_CAPS(DPM);
> +
> +       if (adev->flags & AMD_IS_APU) {
> +               caps &=3D ~SMU_CAPS(PCIE_METRICS);
> +               caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
> +               caps &=3D ~SMU_CAPS(DPM_POLICY);
> +               caps &=3D ~SMU_CAPS(RMA_MSG);
> +               caps &=3D ~SMU_CAPS(ACA_SYND);
> +
> +               if (fw_ver <=3D 0x4556900)
> +                       caps &=3D ~SMU_CAPS(UNI_METRICS);
> +
> +               if (fw_ver >=3D 0x04556F00)
> +                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +               if (fw_ver >=3D 0x04556A00)
> +                       caps |=3D SMU_CAPS(PER_INST_METRICS);
> +               if (fw_ver < 0x554500)
> +                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
> +       } else {
> +               if (fw_ver >=3D 0x557600)
> +                       caps |=3D SMU_CAPS(OTHER_END_METRICS);
> +               if (fw_ver < 0x00556000)
> +                       caps &=3D ~SMU_CAPS(DPM_POLICY);
> +               if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
> +                       caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
> +               if (fw_ver < 0x556300)
> +                       caps &=3D ~SMU_CAPS(PCIE_METRICS);
> +               if (fw_ver < 0x554800)
> +                       caps &=3D ~SMU_CAPS(MCA_DEBUG_MODE);
> +               if (fw_ver >=3D 0x556F00)
> +                       caps |=3D SMU_CAPS(PER_INST_METRICS);
> +               if (fw_ver < 0x554500)
> +                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
> +               if (fw_ver < 0x00555a00)
> +                       caps &=3D ~SMU_CAPS(RMA_MSG);
> +               if (fw_ver < 0x00555600)
> +                       caps &=3D ~SMU_CAPS(ACA_SYND);
> +               if (pgm =3D=3D 0 && fw_ver >=3D 0x557900)
> +                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +       }
> +       if (((pgm =3D=3D 7) && (fw_ver > 0x07550700)) ||
> +           ((pgm =3D=3D 0) && (fw_ver > 0x00557700)) ||
> +           ((pgm =3D=3D 4) && (fw_ver > 0x4556e6c)))
> +               caps |=3D SMU_CAPS(SDMA_RESET);
> +
> +       dpm_context->caps =3D caps;
> +}
> +
> +static inline bool smu_v13_0_6_caps_supported(struct smu_context *smu,
> +                                             enum smu_v13_0_6_caps caps)
> +{
> +       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> +
> +       return (dpm_context->caps & SMU_CAPS_MASK(caps)) =3D=3D SMU_CAPS_=
MASK(caps);
> +}
> +
> +static void smu_v13_0_x_init_caps(struct smu_context *smu)
> +{
> +       switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
> +       case IP_VERSION(13, 0, 14):
> +               return smu_v13_0_14_init_caps(smu);
> +       default:
> +               return smu_v13_0_6_init_caps(smu);
> +       }
> +}
> +
> +static int smu_v13_0_6_check_fw_version(struct smu_context *smu)
> +{
> +       int r;
> +
> +       r =3D smu_v13_0_check_fw_version(smu);
> +       /* Initialize caps flags once fw version is fetched */
> +       if (!r)
> +               smu_v13_0_x_init_caps(smu);
> +
> +       return r;
> +}
> +
>  static int smu_v13_0_6_init_microcode(struct smu_context *smu)
>  {
>         const struct smc_firmware_header_v2_1 *v2_1;
> @@ -616,7 +716,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct sm=
u_context *smu)
>         MetricsTableA_t *metrics_a =3D (MetricsTableA_t *)smu_table->metr=
ics_table;
>         struct PPTable_t *pptable =3D
>                 (struct PPTable_t *)smu_table->driver_pptable;
> -       bool flag =3D smu_v13_0_6_is_unified_metrics(smu);
> +       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRI=
CS));
>         int ret, i, retry =3D 100;
>         uint32_t table_version;
>
> @@ -812,8 +912,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct s=
mu_context *smu)
>         smu_v13_0_6_setup_driver_pptable(smu);
>
>         /* DPM policy not supported in older firmwares */
> -       if (!(smu->adev->flags & AMD_IS_APU) &&
> -           (smu->smc_fw_version < 0x00556000)) {
> +       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM_POLICY))) {
>                 struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
>
>                 smu_dpm->dpm_policies->policy_mask &=3D
> @@ -990,7 +1089,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct s=
mu_context *smu,
>         struct smu_table_context *smu_table =3D &smu->smu_table;
>         MetricsTableX_t *metrics_x =3D (MetricsTableX_t *)smu_table->metr=
ics_table;
>         MetricsTableA_t *metrics_a =3D (MetricsTableA_t *)smu_table->metr=
ics_table;
> -       bool flag =3D smu_v13_0_6_is_unified_metrics(smu);
> +       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRI=
CS));
>         struct amdgpu_device *adev =3D smu->adev;
>         int ret =3D 0;
>         int xcc_id;
> @@ -1003,7 +1102,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct =
smu_context *smu,
>         switch (member) {
>         case METRICS_CURR_GFXCLK:
>         case METRICS_AVERAGE_GFXCLK:
> -               if (smu->smc_fw_version >=3D 0x552F00) {
> +               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM))) {
>                         xcc_id =3D GET_INST(GC, 0);
>                         *value =3D SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFr=
equency, flag)[xcc_id]);
>                 } else {
> @@ -1692,7 +1791,7 @@ static int smu_v13_0_6_notify_unload(struct smu_con=
text *smu)
>  static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool =
enable)
>  {
>         /* NOTE: this ClearMcaOnRead message is only supported for smu ve=
rsion 85.72.0 or higher */
> -       if (smu->smc_fw_version < 0x554800)
> +       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(MCA_DEBUG_MODE)))
>                 return 0;
>
>         return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRea=
d,
> @@ -1837,9 +1936,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(=
struct smu_context *smu,
>                         if (max =3D=3D pstate_table->uclk_pstate.curr.max=
)
>                                 return 0;
>                         /* For VF, only allowed in FW versions 85.102 or =
greater */
> -                       if (amdgpu_sriov_vf(adev) &&
> -                           ((smu->smc_fw_version < 0x556600) ||
> -                            (adev->flags & AMD_IS_APU)))
> +                       if (!smu_v13_0_6_caps_supported(smu,
> +                                                       SMU_CAPS(SET_UCLK=
_MAX)))
>                                 return -EOPNOTSUPP;
>                         /* Only max clock limiting is allowed for UCLK */
>                         ret =3D smu_v13_0_set_soft_freq_limited_range(
> @@ -2043,7 +2141,7 @@ static int smu_v13_0_6_get_enabled_mask(struct smu_=
context *smu,
>
>         ret =3D smu_cmn_get_enabled_mask(smu, feature_mask);
>
> -       if (ret =3D=3D -EIO && smu->smc_fw_version < 0x552F00) {
> +       if (ret =3D=3D -EIO && !smu_v13_0_6_caps_supported(smu, SMU_CAPS(=
DPM))) {
>                 *feature_mask =3D 0;
>                 ret =3D 0;
>         }
> @@ -2336,11 +2434,10 @@ static int smu_v13_0_6_get_current_pcie_link_spee=
d(struct smu_context *smu)
>
>  static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void=
 **table)
>  {
> -       bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per=
_inst;
>         struct smu_table_context *smu_table =3D &smu->smu_table;
>         struct gpu_metrics_v1_7 *gpu_metrics =3D
>                 (struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
> -       bool flag =3D smu_v13_0_6_is_unified_metrics(smu);
> +       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRI=
CS));
>         int ret =3D 0, xcc_id, inst, i, j, k, idx;
>         struct amdgpu_device *adev =3D smu->adev;
>         MetricsTableX_t *metrics_x;
> @@ -2348,6 +2445,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>         struct amdgpu_xcp *xcp;
>         u16 link_width_level;
>         u32 inst_mask;
> +       bool per_inst;
>
>         metrics_x =3D kzalloc(max(sizeof(MetricsTableX_t), sizeof(Metrics=
TableA_t)), GFP_KERNEL);
>         ret =3D smu_v13_0_6_get_metrics_table(smu, metrics_x, true);
> @@ -2421,7 +2519,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>                  * table for both pf & one vf for smu version 85.99.0 or =
higher else report only
>                  * for pf from registers
>                  */
> -               if (smu->smc_fw_version >=3D 0x556300) {
> +               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(PCIE_METRICS=
))) {
>                         gpu_metrics->pcie_link_width =3D metrics_x->PCIeL=
inkWidth;
>                         gpu_metrics->pcie_link_speed =3D
>                                 pcie_gen_to_speed(metrics_x->PCIeLinkSpee=
d);
> @@ -2450,7 +2548,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>                                 metrics_x->PCIeNAKSentCountAcc;
>                 gpu_metrics->pcie_nak_rcvd_count_acc =3D
>                                 metrics_x->PCIeNAKReceivedCountAcc;
> -               if (smu_v13_0_6_is_other_end_count_available(smu))
> +               if (smu_v13_0_6_caps_supported(smu,
> +                                              SMU_CAPS(OTHER_END_METRICS=
)))
>                         gpu_metrics->pcie_lc_perf_other_end_recovery =3D
>                                 metrics_x->PCIeOtherEndRecoveryAcc;
>
> @@ -2475,17 +2574,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct =
smu_context *smu, void **table
>
>         gpu_metrics->num_partition =3D adev->xcp_mgr->num_xcps;
>
> -       apu_per_inst =3D (adev->flags & AMD_IS_APU) && (smu->smc_fw_versi=
on >=3D 0x04556A00);
> -       smu_13_0_6_per_inst =3D !(adev->flags & AMD_IS_APU) &&
> -                               (amdgpu_ip_version(smu->adev, MP1_HWIP, 0=
)
> -                                =3D=3D IP_VERSION(13, 0, 6)) &&
> -                               (smu->smc_fw_version >=3D 0x556F00);
> -       smu_13_0_14_per_inst =3D !(adev->flags & AMD_IS_APU) &&
> -                               (amdgpu_ip_version(smu->adev, MP1_HWIP, 0=
)
> -                                =3D=3D IP_VERSION(13, 0, 14)) &&
> -                               (smu->smc_fw_version >=3D 0x05550B00);
> -
> -       per_inst =3D apu_per_inst || smu_13_0_6_per_inst || smu_13_0_14_p=
er_inst;
> +       per_inst =3D smu_v13_0_6_caps_supported(smu, SMU_CAPS(PER_INST_ME=
TRICS));
>
>         for_each_xcp(adev->xcp_mgr, xcp, i) {
>                 amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_ma=
sk);
> @@ -2516,7 +2605,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>                                 gpu_metrics->xcp_stats[i].gfx_busy_acc[id=
x] =3D
>                                         SMUQ10_ROUND(metrics_x->GfxBusyAc=
c[inst]);
>
> -                               if (smu_v13_0_6_is_blw_host_limit_availab=
le(smu))
> +                               if (smu_v13_0_6_caps_supported(
> +                                           smu, SMU_CAPS(HST_LIMIT_METRI=
CS)))
>                                         gpu_metrics->xcp_stats[i].gfx_bel=
ow_host_limit_acc[idx] =3D
>                                                 SMUQ10_ROUND(metrics_x->G=
fxclkBelowHostLimitAcc
>                                                                 [inst]);
> @@ -2624,7 +2714,7 @@ static int smu_v13_0_6_get_thermal_temperature_rang=
e(struct smu_context *smu,
>                 return -EINVAL;
>
>         /*Check smu version, GetCtfLimit message only supported for smu v=
ersion 85.69 or higher */
> -       if (smu->smc_fw_version < 0x554500)
> +       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(CTF_LIMIT)))
>                 return 0;
>
>         /* Get SOC Max operating temperature */
> @@ -2726,11 +2816,10 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(=
struct smu_context *smu,
>
>  static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
>  {
> -       struct amdgpu_device *adev =3D smu->adev;
>         int ret;
>
>         /* NOTE: the message is only valid on dGPU with pmfw 85.90.0 and =
above */
> -       if ((adev->flags & AMD_IS_APU) || smu->smc_fw_version < 0x00555a0=
0)
> +       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(RMA_MSG)))
>                 return 0;
>
>         ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_RmaDueToBadPageThreshol=
d, NULL);
> @@ -2750,18 +2839,17 @@ static int smu_v13_0_6_reset_sdma(struct smu_cont=
ext *smu, uint32_t inst_mask)
>         smu_program =3D (smu->smc_fw_version >> 24) & 0xff;
>         switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
>         case IP_VERSION(13, 0, 6):
> -               if (((smu_program =3D=3D 7) && (smu->smc_fw_version > 0x0=
7550700)) ||
> -                       ((smu_program =3D=3D 0) && (smu->smc_fw_version >=
 0x00557700)))
> +               if ((smu_program =3D=3D 7 || smu_program =3D=3D 0) &&
> +                   smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET))=
)
>                         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                 SMU_MSG_ResetSDMA, inst_mask, NULL);
>                 else if ((smu_program =3D=3D 4) &&
> -                       (smu->smc_fw_version > 0x4556e6c))
> +                        smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RE=
SET)))
>                         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                       SMU_MSG_ResetSDMA2, inst_mask, NULL=
);
>                 break;
>         case IP_VERSION(13, 0, 14):
> -               if ((smu_program =3D=3D 5) &&
> -                       (smu->smc_fw_version > 0x05550f00))
> +               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET))=
)
>                         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                       SMU_MSG_ResetSDMA2, inst_mask, NULL=
);
>                 break;
> @@ -3087,7 +3175,7 @@ static bool mca_smu_bank_is_valid(const struct mca_=
ras_info *mca_ras, struct amd
>         if (instlo !=3D 0x03b30400)
>                 return false;
>
> -       if (!(adev->flags & AMD_IS_APU) && smu->smc_fw_version >=3D 0x005=
55600) {
> +       if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND))) {
>                 errcode =3D MCA_REG__SYND__ERRORINFORMATION(entry->regs[M=
CA_REG_IDX_SYND]);
>                 errcode &=3D 0xff;
>         } else {
> @@ -3373,9 +3461,10 @@ static int aca_smu_get_valid_aca_bank(struct amdgp=
u_device *adev,
>
>  static int aca_smu_parse_error_code(struct amdgpu_device *adev, struct a=
ca_bank *bank)
>  {
> +       struct smu_context *smu =3D adev->powerplay.pp_handle;
>         int error_code;
>
> -       if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >=3D 0x005=
55600)
> +       if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND)))
>                 error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank->regs=
[ACA_REG_IDX_SYND]);
>         else
>                 error_code =3D ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_=
REG_IDX_STATUS]);
> @@ -3413,7 +3502,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_f=
uncs =3D {
>         .fini_power =3D smu_v13_0_fini_power,
>         .check_fw_status =3D smu_v13_0_6_check_fw_status,
>         /* pptable related */
> -       .check_fw_version =3D smu_v13_0_check_fw_version,
> +       .check_fw_version =3D smu_v13_0_6_check_fw_version,
>         .set_driver_table_location =3D smu_v13_0_set_driver_table_locatio=
n,
>         .set_tool_table_location =3D smu_v13_0_set_tool_table_location,
>         .notify_memory_pool_location =3D smu_v13_0_notify_memory_pool_loc=
ation,
> --
> 2.25.1
>
