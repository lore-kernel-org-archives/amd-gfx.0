Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9D3C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 14:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A87E10E596;
	Tue, 21 Jan 2025 14:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VU/Uy0ts";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C151710E596
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 14:04:29 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2161d4b820bso10015165ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 06:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737468209; x=1738073009; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hjgdws7ibRhYrY7D2keMx1tV63NCsntzYm/527aPYIU=;
 b=VU/Uy0tsO4TMdpex7HGblTv0hgBRt+h5ktDK1UIvGfmYlOh99fkDyXyWGNFd1Rgz7f
 W2oIH+q6DBzByAeVfhCAZUo8/8SEbCR0FecTxiui6WOEfELCor0j5K3zMEClPsVhZ63S
 m5bVDBQf1x62PtEjfIR/4kpltiYRApWfkH44UnI3I75D3wRQ7JgNs60P+Q82Qi8N3rX1
 uDrxw9SPKIrDBHHOhJYtytxTs/QZFeYL88Dmb6C1dpXYNvMtkV52E5rQwLvbkGxlC8n6
 uWtpkJ2VH0sE4sIyyiKM/4pbwhsAA1hR5RWrMzEwRj82deRo4cMir+jLZe/YH7YmpJ8v
 bXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737468209; x=1738073009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hjgdws7ibRhYrY7D2keMx1tV63NCsntzYm/527aPYIU=;
 b=VDaU7mNfqIeIc122+H1y3ARbSj/quw3qiO2q7F1MH7ck3GuPmBx7DMJGuWw3IOsPhz
 tWKKwJ0zr5UDv5WGyT2IPYMRoACgXHXHM7NpSFGqu4dMSvRZytZNRLfWsOuBiTcS5H4+
 F14xTh1ZfQU4RS6fjmb7h+PZqqE5bnOw3DjZCpwBb1sRY2QzxSZFsbCirp2/0q5qCefN
 bf7T8XfmoHeEWv29tRvMycJf47Ey1FVYyw0278wC45BQNcRZph2NqrxDEDl0l/hel6cq
 Sz3heKX29OMHcP/445UQue5kHFlRzwwKddT6nKWHJ0elNW0u5Eb+VHaw+LiToJAeRq8h
 O3Ww==
X-Gm-Message-State: AOJu0Ywbq063RREINFN3u3zx0qERXCoIO2p//QBzNNdw1nFguZMH3B4I
 BAUoYfkggmUcRCAgPpdt8DVQrBAsW0A7MSsx7LxWUZEygFr3Zs9QXM12w3IpIBp4Yft3Ps5QCyP
 HvLaP+v81SVjjm1NCpQQJZFil30w=
X-Gm-Gg: ASbGncuXqr+GcLml1IUqnFO9p46xXCFrIWK6KTbPT4EeZ/ghJ1Zr5ssC9I8SThO2FTq
 mqlLHdoTwixJbfc9bt9zgnlZj0OOCYmyIbUeBxPbaklYlmSM5i+Y=
X-Google-Smtp-Source: AGHT+IE4zJI5Wdg48xMPII9ubu9JGrPnrY5IAq2W7Gc1cBwfQH8DUad/xJ4iScTbNyq65/YbZ1kVDfpONVzUtSpL5EU=
X-Received: by 2002:a17:902:f68c:b0:215:b8b6:d2c4 with SMTP id
 d9443c01a7336-21c35551599mr96853605ad.4.1737468209181; Tue, 21 Jan 2025
 06:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20250121053929.1538914-1-lijo.lazar@amd.com>
In-Reply-To: <20250121053929.1538914-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Jan 2025 09:03:17 -0500
X-Gm-Features: AbW1kvZUlMWuTvfrMh3xA_d7JpUBIJJv8f4-XJadjcJ4kmaxoVqgKdKAmMRQQAk
Message-ID: <CADnq5_OsTbuY1+3U8QEO8_vOepeYYMn43cx-G0Z_dnq+8Z0asQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/pm: Fix smu v13.0.6 caps initialization
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

On Tue, Jan 21, 2025 at 12:47=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Fix the initialization and usage of SMU v13.0.6 capability values. Use
> caps_set/clear functions to set/clear capability.
>
> Also, fix SET_UCLK_MAX capability on APUs, it is supported on APUs.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Fixes: 9bb53d2ce109 ("drm/amd/pm: Add capability flags for SMU v13.0.6")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v1: ("drm/amd/pm: Use correct macros for smu caps")
> v2:
>         Use caps_set/clear instead of macros (Alex). Commit message chang=
ed.
>         Use BIT_ULL (Kevin)
>         Fix SET_UCLK_MAX capability on APUs
> v3:
>         Rename to cap to indicate operations on single capability (Alex)
>         Use SMU_CAP in enum value definition also for consistency
>
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 197 ++++++++++--------
>  1 file changed, 108 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 56e26fcd3066..d991a5df3796 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -101,26 +101,25 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
>  #define MCA_BANK_IPID(_ip, _hwid, _type) \
>         [AMDGPU_MCA_IP_##_ip] =3D { .hwid =3D _hwid, .mcatype =3D _type, =
}
>
> +#define SMU_CAP(x) SMU_13_0_6_CAPS_##x
> +
>  enum smu_v13_0_6_caps {
> -       SMU_13_0_6_CAPS_DPM,
> -       SMU_13_0_6_CAPS_UNI_METRICS,
> -       SMU_13_0_6_CAPS_DPM_POLICY,
> -       SMU_13_0_6_CAPS_OTHER_END_METRICS,
> -       SMU_13_0_6_CAPS_SET_UCLK_MAX,
> -       SMU_13_0_6_CAPS_PCIE_METRICS,
> -       SMU_13_0_6_CAPS_HST_LIMIT_METRICS,
> -       SMU_13_0_6_CAPS_MCA_DEBUG_MODE,
> -       SMU_13_0_6_CAPS_PER_INST_METRICS,
> -       SMU_13_0_6_CAPS_CTF_LIMIT,
> -       SMU_13_0_6_CAPS_RMA_MSG,
> -       SMU_13_0_6_CAPS_ACA_SYND,
> -       SMU_13_0_6_CAPS_SDMA_RESET,
> -       SMU_13_0_6_CAPS_ALL,
> +       SMU_CAP(DPM),
> +       SMU_CAP(UNI_METRICS),
> +       SMU_CAP(DPM_POLICY),
> +       SMU_CAP(OTHER_END_METRICS),
> +       SMU_CAP(SET_UCLK_MAX),
> +       SMU_CAP(PCIE_METRICS),
> +       SMU_CAP(HST_LIMIT_METRICS),
> +       SMU_CAP(MCA_DEBUG_MODE),
> +       SMU_CAP(PER_INST_METRICS),
> +       SMU_CAP(CTF_LIMIT),
> +       SMU_CAP(RMA_MSG),
> +       SMU_CAP(ACA_SYND),
> +       SMU_CAP(SDMA_RESET),
> +       SMU_CAP(ALL),
>  };
>
> -#define SMU_CAPS_MASK(x) (ULL(1) << x)
> -#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)
> -
>  struct mca_bank_ipid {
>         enum amdgpu_mca_ip ip;
>         uint16_t hwid;
> @@ -284,95 +283,116 @@ struct smu_v13_0_6_dpm_map {
>         uint32_t *freq_table;
>  };
>
> -static void smu_v13_0_14_init_caps(struct smu_context *smu)
> +static inline void smu_v13_0_6_cap_set(struct smu_context *smu,
> +                                      enum smu_v13_0_6_caps cap)
> +{
> +       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> +
> +       dpm_context->caps |=3D BIT_ULL(cap);
> +}
> +
> +static inline void smu_v13_0_6_cap_clear(struct smu_context *smu,
> +                                        enum smu_v13_0_6_caps cap)
>  {
>         struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> -       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
> -                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
> -                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
> -                       SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
> -                       SMU_CAPS(ACA_SYND);
> +
> +       dpm_context->caps &=3D ~BIT_ULL(cap);
> +}
> +
> +static inline bool smu_v13_0_6_cap_supported(struct smu_context *smu,
> +                                            enum smu_v13_0_6_caps cap)
> +{
> +       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> +
> +       return !!(dpm_context->caps & BIT_ULL(cap));
> +}
> +
> +static void smu_v13_0_14_init_caps(struct smu_context *smu)
> +{
> +       enum smu_v13_0_6_caps default_cap_list[] =3D { SMU_CAP(DPM),
> +                                                    SMU_CAP(UNI_METRICS)=
,
> +                                                    SMU_CAP(SET_UCLK_MAX=
),
> +                                                    SMU_CAP(DPM_POLICY),
> +                                                    SMU_CAP(PCIE_METRICS=
),
> +                                                    SMU_CAP(CTF_LIMIT),
> +                                                    SMU_CAP(MCA_DEBUG_MO=
DE),
> +                                                    SMU_CAP(RMA_MSG),
> +                                                    SMU_CAP(ACA_SYND) };
>         uint32_t fw_ver =3D smu->smc_fw_version;
>
> +       for (int i =3D 0; i < ARRAY_SIZE(default_cap_list); i++)
> +               smu_v13_0_6_cap_set(smu, default_cap_list[i]);
> +
>         if (fw_ver >=3D 0x05550E00)
> -               caps |=3D SMU_CAPS(OTHER_END_METRICS);
> +               smu_v13_0_6_cap_set(smu, SMU_CAP(OTHER_END_METRICS));
>         if (fw_ver >=3D 0x05551000)
> -               caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +               smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
>         if (fw_ver >=3D 0x05550B00)
> -               caps |=3D SMU_CAPS(PER_INST_METRICS);
> +               smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
>         if (fw_ver > 0x05550f00)
> -               caps |=3D SMU_CAPS(SDMA_RESET);
> -
> -       dpm_context->caps =3D caps;
> +               smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
>  }
>
>  static void smu_v13_0_6_init_caps(struct smu_context *smu)
>  {
> -       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
> -                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
> -                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(MCA_DEBUG_MODE)=
 |
> -                       SMU_CAPS(CTF_LIMIT) | SMU_CAPS(RMA_MSG) |
> -                       SMU_CAPS(ACA_SYND);
> -       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> +       enum smu_v13_0_6_caps default_cap_list[] =3D { SMU_CAP(DPM),
> +                                                    SMU_CAP(UNI_METRICS)=
,
> +                                                    SMU_CAP(SET_UCLK_MAX=
),
> +                                                    SMU_CAP(DPM_POLICY),
> +                                                    SMU_CAP(PCIE_METRICS=
),
> +                                                    SMU_CAP(CTF_LIMIT),
> +                                                    SMU_CAP(MCA_DEBUG_MO=
DE),
> +                                                    SMU_CAP(RMA_MSG),
> +                                                    SMU_CAP(ACA_SYND) };
>         struct amdgpu_device *adev =3D smu->adev;
>         uint32_t fw_ver =3D smu->smc_fw_version;
>         uint32_t pgm =3D (fw_ver >> 24) & 0xFF;
>
> +       for (int i =3D 0; i < ARRAY_SIZE(default_cap_list); i++)
> +               smu_v13_0_6_cap_set(smu, default_cap_list[i]);
>         if (fw_ver < 0x552F00)
> -               caps &=3D ~SMU_CAPS(DPM);
> +               smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM));
>
>         if (adev->flags & AMD_IS_APU) {
> -               caps &=3D ~SMU_CAPS(PCIE_METRICS);
> -               caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
> -               caps &=3D ~SMU_CAPS(DPM_POLICY);
> -               caps &=3D ~SMU_CAPS(RMA_MSG);
> -               caps &=3D ~SMU_CAPS(ACA_SYND);
> +               smu_v13_0_6_cap_clear(smu, SMU_CAP(PCIE_METRICS));
> +               smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM_POLICY));
> +               smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
> +               smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));
>
>                 if (fw_ver <=3D 0x4556900)
> -                       caps &=3D ~SMU_CAPS(UNI_METRICS);
> -
> +                       smu_v13_0_6_cap_clear(smu, SMU_CAP(UNI_METRICS));
>                 if (fw_ver >=3D 0x04556F00)
> -                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +                       smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRIC=
S));
>                 if (fw_ver >=3D 0x04556A00)
> -                       caps |=3D SMU_CAPS(PER_INST_METRICS);
> +                       smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS=
));
>                 if (fw_ver < 0x554500)
> -                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
> +                       smu_v13_0_6_cap_clear(smu, SMU_CAP(CTF_LIMIT));
>         } else {
>                 if (fw_ver >=3D 0x557600)
> -                       caps |=3D SMU_CAPS(OTHER_END_METRICS);
> +                       smu_v13_0_6_cap_set(smu, SMU_CAP(OTHER_END_METRIC=
S));
>                 if (fw_ver < 0x00556000)
> -                       caps &=3D ~SMU_CAPS(DPM_POLICY);
> +                       smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM_POLICY));
>                 if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
> -                       caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
> +                       smu_v13_0_6_cap_clear(smu, SMU_CAP(SET_UCLK_MAX))=
;
>                 if (fw_ver < 0x556300)
> -                       caps &=3D ~SMU_CAPS(PCIE_METRICS);
> +                       smu_v13_0_6_cap_clear(smu, SMU_CAP(PCIE_METRICS))=
;
>                 if (fw_ver < 0x554800)
> -                       caps &=3D ~SMU_CAPS(MCA_DEBUG_MODE);
> +                       smu_v13_0_6_cap_clear(smu, SMU_CAP(MCA_DEBUG_MODE=
));
>                 if (fw_ver >=3D 0x556F00)
> -                       caps |=3D SMU_CAPS(PER_INST_METRICS);
> +                       smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS=
));
>                 if (fw_ver < 0x554500)
> -                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
> +                       smu_v13_0_6_cap_clear(smu, SMU_CAP(CTF_LIMIT));
>                 if (fw_ver < 0x00555a00)
> -                       caps &=3D ~SMU_CAPS(RMA_MSG);
> +                       smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
>                 if (fw_ver < 0x00555600)
> -                       caps &=3D ~SMU_CAPS(ACA_SYND);
> +                       smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));
>                 if (pgm =3D=3D 0 && fw_ver >=3D 0x557900)
> -                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +                       smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRIC=
S));
>         }
>         if (((pgm =3D=3D 7) && (fw_ver > 0x07550700)) ||
>             ((pgm =3D=3D 0) && (fw_ver > 0x00557700)) ||
>             ((pgm =3D=3D 4) && (fw_ver > 0x4556e6c)))
> -               caps |=3D SMU_CAPS(SDMA_RESET);
> -
> -       dpm_context->caps =3D caps;
> -}
> -
> -static inline bool smu_v13_0_6_caps_supported(struct smu_context *smu,
> -                                             enum smu_v13_0_6_caps caps)
> -{
> -       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> -
> -       return (dpm_context->caps & SMU_CAPS_MASK(caps)) =3D=3D SMU_CAPS_=
MASK(caps);
> +               smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
>  }
>
>  static void smu_v13_0_x_init_caps(struct smu_context *smu)
> @@ -716,7 +736,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct sm=
u_context *smu)
>         MetricsTableA_t *metrics_a =3D (MetricsTableA_t *)smu_table->metr=
ics_table;
>         struct PPTable_t *pptable =3D
>                 (struct PPTable_t *)smu_table->driver_pptable;
> -       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRI=
CS));
> +       bool flag =3D !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS=
));
>         int ret, i, retry =3D 100;
>         uint32_t table_version;
>
> @@ -912,7 +932,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct s=
mu_context *smu)
>         smu_v13_0_6_setup_driver_pptable(smu);
>
>         /* DPM policy not supported in older firmwares */
> -       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM_POLICY))) {
> +       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM_POLICY))) {
>                 struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
>
>                 smu_dpm->dpm_policies->policy_mask &=3D
> @@ -1089,7 +1109,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct =
smu_context *smu,
>         struct smu_table_context *smu_table =3D &smu->smu_table;
>         MetricsTableX_t *metrics_x =3D (MetricsTableX_t *)smu_table->metr=
ics_table;
>         MetricsTableA_t *metrics_a =3D (MetricsTableA_t *)smu_table->metr=
ics_table;
> -       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRI=
CS));
> +       bool flag =3D !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS=
));
>         struct amdgpu_device *adev =3D smu->adev;
>         int ret =3D 0;
>         int xcc_id;
> @@ -1102,7 +1122,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct =
smu_context *smu,
>         switch (member) {
>         case METRICS_CURR_GFXCLK:
>         case METRICS_AVERAGE_GFXCLK:
> -               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM))) {
> +               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM))) {
>                         xcc_id =3D GET_INST(GC, 0);
>                         *value =3D SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFr=
equency, flag)[xcc_id]);
>                 } else {
> @@ -1791,7 +1811,7 @@ static int smu_v13_0_6_notify_unload(struct smu_con=
text *smu)
>  static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool =
enable)
>  {
>         /* NOTE: this ClearMcaOnRead message is only supported for smu ve=
rsion 85.72.0 or higher */
> -       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(MCA_DEBUG_MODE)))
> +       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(MCA_DEBUG_MODE)))
>                 return 0;
>
>         return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRea=
d,
> @@ -1936,8 +1956,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(=
struct smu_context *smu,
>                         if (max =3D=3D pstate_table->uclk_pstate.curr.max=
)
>                                 return 0;
>                         /* For VF, only allowed in FW versions 85.102 or =
greater */
> -                       if (!smu_v13_0_6_caps_supported(smu,
> -                                                       SMU_CAPS(SET_UCLK=
_MAX)))
> +                       if (!smu_v13_0_6_cap_supported(smu,
> +                                                      SMU_CAP(SET_UCLK_M=
AX)))
>                                 return -EOPNOTSUPP;
>                         /* Only max clock limiting is allowed for UCLK */
>                         ret =3D smu_v13_0_set_soft_freq_limited_range(
> @@ -2141,7 +2161,7 @@ static int smu_v13_0_6_get_enabled_mask(struct smu_=
context *smu,
>
>         ret =3D smu_cmn_get_enabled_mask(smu, feature_mask);
>
> -       if (ret =3D=3D -EIO && !smu_v13_0_6_caps_supported(smu, SMU_CAPS(=
DPM))) {
> +       if (ret =3D=3D -EIO && !smu_v13_0_6_cap_supported(smu, SMU_CAP(DP=
M))) {
>                 *feature_mask =3D 0;
>                 ret =3D 0;
>         }
> @@ -2437,7 +2457,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>         struct smu_table_context *smu_table =3D &smu->smu_table;
>         struct gpu_metrics_v1_7 *gpu_metrics =3D
>                 (struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
> -       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRI=
CS));
> +       bool flag =3D !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS=
));
>         int ret =3D 0, xcc_id, inst, i, j, k, idx;
>         struct amdgpu_device *adev =3D smu->adev;
>         MetricsTableX_t *metrics_x;
> @@ -2519,7 +2539,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>                  * table for both pf & one vf for smu version 85.99.0 or =
higher else report only
>                  * for pf from registers
>                  */
> -               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(PCIE_METRICS=
))) {
> +               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(PCIE_METRICS))=
) {
>                         gpu_metrics->pcie_link_width =3D metrics_x->PCIeL=
inkWidth;
>                         gpu_metrics->pcie_link_speed =3D
>                                 pcie_gen_to_speed(metrics_x->PCIeLinkSpee=
d);
> @@ -2548,8 +2568,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>                                 metrics_x->PCIeNAKSentCountAcc;
>                 gpu_metrics->pcie_nak_rcvd_count_acc =3D
>                                 metrics_x->PCIeNAKReceivedCountAcc;
> -               if (smu_v13_0_6_caps_supported(smu,
> -                                              SMU_CAPS(OTHER_END_METRICS=
)))
> +               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(OTHER_END_METR=
ICS)))
>                         gpu_metrics->pcie_lc_perf_other_end_recovery =3D
>                                 metrics_x->PCIeOtherEndRecoveryAcc;
>
> @@ -2574,7 +2593,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>
>         gpu_metrics->num_partition =3D adev->xcp_mgr->num_xcps;
>
> -       per_inst =3D smu_v13_0_6_caps_supported(smu, SMU_CAPS(PER_INST_ME=
TRICS));
> +       per_inst =3D smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METR=
ICS));
>
>         for_each_xcp(adev->xcp_mgr, xcp, i) {
>                 amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_ma=
sk);
> @@ -2605,8 +2624,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>                                 gpu_metrics->xcp_stats[i].gfx_busy_acc[id=
x] =3D
>                                         SMUQ10_ROUND(metrics_x->GfxBusyAc=
c[inst]);
>
> -                               if (smu_v13_0_6_caps_supported(
> -                                           smu, SMU_CAPS(HST_LIMIT_METRI=
CS)))
> +                               if (smu_v13_0_6_cap_supported(
> +                                           smu, SMU_CAP(HST_LIMIT_METRIC=
S)))
>                                         gpu_metrics->xcp_stats[i].gfx_bel=
ow_host_limit_acc[idx] =3D
>                                                 SMUQ10_ROUND(metrics_x->G=
fxclkBelowHostLimitAcc
>                                                                 [inst]);
> @@ -2714,7 +2733,7 @@ static int smu_v13_0_6_get_thermal_temperature_rang=
e(struct smu_context *smu,
>                 return -EINVAL;
>
>         /*Check smu version, GetCtfLimit message only supported for smu v=
ersion 85.69 or higher */
> -       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(CTF_LIMIT)))
> +       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(CTF_LIMIT)))
>                 return 0;
>
>         /* Get SOC Max operating temperature */
> @@ -2819,7 +2838,7 @@ static int smu_v13_0_6_send_rma_reason(struct smu_c=
ontext *smu)
>         int ret;
>
>         /* NOTE: the message is only valid on dGPU with pmfw 85.90.0 and =
above */
> -       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(RMA_MSG)))
> +       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(RMA_MSG)))
>                 return 0;
>
>         ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_RmaDueToBadPageThreshol=
d, NULL);
> @@ -2840,16 +2859,16 @@ static int smu_v13_0_6_reset_sdma(struct smu_cont=
ext *smu, uint32_t inst_mask)
>         switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
>         case IP_VERSION(13, 0, 6):
>                 if ((smu_program =3D=3D 7 || smu_program =3D=3D 0) &&
> -                   smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET))=
)
> +                   smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
>                         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                 SMU_MSG_ResetSDMA, inst_mask, NULL);
>                 else if ((smu_program =3D=3D 4) &&
> -                        smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RE=
SET)))
> +                        smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESE=
T)))
>                         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                       SMU_MSG_ResetSDMA2, inst_mask, NULL=
);
>                 break;
>         case IP_VERSION(13, 0, 14):
> -               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET))=
)
> +               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
>                         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                       SMU_MSG_ResetSDMA2, inst_mask, NULL=
);
>                 break;
> @@ -3175,7 +3194,7 @@ static bool mca_smu_bank_is_valid(const struct mca_=
ras_info *mca_ras, struct amd
>         if (instlo !=3D 0x03b30400)
>                 return false;
>
> -       if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND))) {
> +       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND))) {
>                 errcode =3D MCA_REG__SYND__ERRORINFORMATION(entry->regs[M=
CA_REG_IDX_SYND]);
>                 errcode &=3D 0xff;
>         } else {
> @@ -3464,7 +3483,7 @@ static int aca_smu_parse_error_code(struct amdgpu_d=
evice *adev, struct aca_bank
>         struct smu_context *smu =3D adev->powerplay.pp_handle;
>         int error_code;
>
> -       if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND)))
> +       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND)))
>                 error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank->regs=
[ACA_REG_IDX_SYND]);
>         else
>                 error_code =3D ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_=
REG_IDX_STATUS]);
> --
> 2.25.1
>
