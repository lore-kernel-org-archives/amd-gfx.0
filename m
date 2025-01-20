Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C269FC02185
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 15:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 676EB10E037;
	Mon, 20 Jan 2025 15:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JCNWdmF1";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBB710E05B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 15:46:24 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-21c0e29b26bso10292235ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737387924; x=1737992724; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOtzg6/aD57coK6TdIvBbjoa/TpemCu8Md8hQr4A1b0=;
 b=JCNWdmF17wbxW5fDw9Cl51o7kKY7IufJ/trK2hCIgB1KfsLTrsx/WavnZcCwsD+fxM
 Ex2eTfCKxBnwq5QNuPM61ZIu+8OyDJ1sDBH+I33bb6I6aqwh5y1yXNUgjzCa5CEiXWS1
 uwJTPi0vpxKdAI7qyl6N5vfaPiZIu08+q8tqoiRLycz/rhWBHUsTQ+ad5VYQ0GYxWh35
 LW8Hqx08jlM0XpWOdEh5yOAf6f1LH//c/tsd2cs6Tx1tt+LD3VHDUSC054oPhfvsxr6o
 ueRu0nqAprMPxC4JLxeAHLC5ie5KT0TXUvTEOSlN+Ci7mHl+kCwqvQc4sTZ5vQc1wvtQ
 3jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737387924; x=1737992724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOtzg6/aD57coK6TdIvBbjoa/TpemCu8Md8hQr4A1b0=;
 b=pOsGupaz07VKvFsan50ahoKPSB3AyjD9Y4tFeJyQofUF9WskX0HTEIYEybdC/inGkh
 Mv4z3eDkYfR/USkYebSSH/AuxVVvZe7fMlID+fkjky0pXaRyQ/P9d2LCoduMgJlAg7cJ
 Qo7JLib25grjc2hSwjol0Txg1V5k9JvGMWERpCdOceLItlKwTS7Usc9blbFDwiE3r+Pf
 8w9wjL2GNLdu9rDRshW03HOQtF2RNhlIFslix4gxtVPn4liTv4DIFk4MwlyULsNE/mYd
 yjSyvTvEqZK/lRdsrN7sX63mWoNMbXh3OiZZfxfmDzbuYOhMJW00kwQ38RWN/TOAtIJG
 dwBg==
X-Gm-Message-State: AOJu0YzyDO7EzJmd6hc7+7URYJ6lVPyz4o4OOB/fdKrkY05S8SoBpesR
 ktbSGbZh0W4JQHZQ2X45rp6y4nUgJWmIFghJP/cAjsjaaVh1+MGlXoQ1tP7eLcPWC3mx4eFrV2g
 cAHe+cyPqhBKeLKm4ds5ciB2zBYU=
X-Gm-Gg: ASbGncucirXBdLweZKAs7TsVQ375LusVKODlq4QOdAclLwls2BdREQlSbfEbwi6KJCV
 poH5cPMZ/26N5ifBNVesx5aA4ZtivPvKg5it49CkzWpst4JMKdjk=
X-Google-Smtp-Source: AGHT+IHkPJZa0/WTZbi7EMyIS0kmJl9PonUrHMAG2cSs7vmwEjAla/fLG8PwpO0Ae/bjHs0RyOSDrn7JMa21c5CUhgs=
X-Received: by 2002:a17:902:f548:b0:215:3862:603a with SMTP id
 d9443c01a7336-21c355854e8mr78244355ad.10.1737387923552; Mon, 20 Jan 2025
 07:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20250120111027.1525667-1-lijo.lazar@amd.com>
In-Reply-To: <20250120111027.1525667-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Jan 2025 10:45:11 -0500
X-Gm-Features: AbW1kvZhb3RhnZGhYA0l2-4c4Y5PrXEwXOMFZtX5FXPIhNJAOZOMIIPm0Z-3gaA
Message-ID: <CADnq5_NrqKXzwA6LjRRMtRL14YRT4n2UE=RnYAFeTaSYQHfWvw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: Fix smu v13.0.6 caps initialization
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

On Mon, Jan 20, 2025 at 6:17=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Fix the initialization and usage of SMU v13.0.6 capability values. Use
> caps_set/clear functions to set/clear capability.
>
> Also, fix SET_UCLK_MAX capability on APUs, it is supported on APUs.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Fixes: 9bb53d2ce109 ("drm/amd/pm: Add capability flags for SMU v13.0.6")

A couple minor nits below.  Otherwise,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v1: ("drm/amd/pm: Use correct macros for smu caps")
> v2:
>         Use caps_set/clear instead of macros (Alex). Commit message chang=
ed.
>         Use BIT_ULL (Kevin)
>         Fix SET_UCLK_MAX capability on APUs
>
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 124 ++++++++++--------
>  1 file changed, 72 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 56e26fcd3066..9e64392d23a9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -118,8 +118,7 @@ enum smu_v13_0_6_caps {
>         SMU_13_0_6_CAPS_ALL,
>  };
>
> -#define SMU_CAPS_MASK(x) (ULL(1) << x)
> -#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)
> +#define SMU_CAPS(x) SMU_13_0_6_CAPS_##x
>
>  struct mca_bank_ipid {
>         enum amdgpu_mca_ip ip;
> @@ -284,95 +283,116 @@ struct smu_v13_0_6_dpm_map {
>         uint32_t *freq_table;
>  };
>
> -static void smu_v13_0_14_init_caps(struct smu_context *smu)
> +static inline void smu_v13_0_6_caps_set(struct smu_context *smu,
> +                                       enum smu_v13_0_6_caps caps)
> +{
> +       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> +
> +       dpm_context->caps |=3D BIT_ULL(caps);
> +}
> +
> +static inline void smu_v13_0_6_caps_clear(struct smu_context *smu,
> +                                         enum smu_v13_0_6_caps caps)

Maybe s/caps/cap/ to make it clear that this function should only be
used for a single cap.

>  {
>         struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> -       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
> -                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
> -                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
> -                       SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
> -                       SMU_CAPS(ACA_SYND);
> +
> +       dpm_context->caps &=3D ~BIT_ULL(caps);
> +}
> +
> +static inline bool smu_v13_0_6_caps_supported(struct smu_context *smu,
> +                                             enum smu_v13_0_6_caps caps)

Same here.

> +{
> +       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> +
> +       return !!(dpm_context->caps & BIT_ULL(caps));
> +}
> +
> +static void smu_v13_0_14_init_caps(struct smu_context *smu)
> +{
> +       enum smu_v13_0_6_caps default_caps_list[] =3D { SMU_CAPS(DPM),
> +                                                     SMU_CAPS(UNI_METRIC=
S),
> +                                                     SMU_CAPS(SET_UCLK_M=
AX),
> +                                                     SMU_CAPS(DPM_POLICY=
),
> +                                                     SMU_CAPS(PCIE_METRI=
CS),
> +                                                     SMU_CAPS(CTF_LIMIT)=
,
> +                                                     SMU_CAPS(MCA_DEBUG_=
MODE),
> +                                                     SMU_CAPS(RMA_MSG),
> +                                                     SMU_CAPS(ACA_SYND) =
};
>         uint32_t fw_ver =3D smu->smc_fw_version;
>
> +       for (int i =3D 0; i < ARRAY_SIZE(default_caps_list); i++)
> +               smu_v13_0_6_caps_set(smu, default_caps_list[i]);
> +
>         if (fw_ver >=3D 0x05550E00)
> -               caps |=3D SMU_CAPS(OTHER_END_METRICS);
> +               smu_v13_0_6_caps_set(smu, SMU_CAPS(OTHER_END_METRICS));
>         if (fw_ver >=3D 0x05551000)
> -               caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +               smu_v13_0_6_caps_set(smu, SMU_CAPS(HST_LIMIT_METRICS));
>         if (fw_ver >=3D 0x05550B00)
> -               caps |=3D SMU_CAPS(PER_INST_METRICS);
> +               smu_v13_0_6_caps_set(smu, SMU_CAPS(PER_INST_METRICS));
>         if (fw_ver > 0x05550f00)
> -               caps |=3D SMU_CAPS(SDMA_RESET);
> -
> -       dpm_context->caps =3D caps;
> +               smu_v13_0_6_caps_set(smu, SMU_CAPS(SDMA_RESET));
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
> +       enum smu_v13_0_6_caps default_caps_list[] =3D { SMU_CAPS(DPM),
> +                                                     SMU_CAPS(UNI_METRIC=
S),
> +                                                     SMU_CAPS(SET_UCLK_M=
AX),
> +                                                     SMU_CAPS(DPM_POLICY=
),
> +                                                     SMU_CAPS(PCIE_METRI=
CS),
> +                                                     SMU_CAPS(CTF_LIMIT)=
,
> +                                                     SMU_CAPS(MCA_DEBUG_=
MODE),
> +                                                     SMU_CAPS(RMA_MSG),
> +                                                     SMU_CAPS(ACA_SYND) =
};
>         struct amdgpu_device *adev =3D smu->adev;
>         uint32_t fw_ver =3D smu->smc_fw_version;
>         uint32_t pgm =3D (fw_ver >> 24) & 0xFF;
>
> +       for (int i =3D 0; i < ARRAY_SIZE(default_caps_list); i++)
> +               smu_v13_0_6_caps_set(smu, default_caps_list[i]);
>         if (fw_ver < 0x552F00)
> -               caps &=3D ~SMU_CAPS(DPM);
> +               smu_v13_0_6_caps_clear(smu, SMU_CAPS(DPM));
>
>         if (adev->flags & AMD_IS_APU) {
> -               caps &=3D ~SMU_CAPS(PCIE_METRICS);
> -               caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
> -               caps &=3D ~SMU_CAPS(DPM_POLICY);
> -               caps &=3D ~SMU_CAPS(RMA_MSG);
> -               caps &=3D ~SMU_CAPS(ACA_SYND);
> +               smu_v13_0_6_caps_clear(smu, SMU_CAPS(PCIE_METRICS));
> +               smu_v13_0_6_caps_clear(smu, SMU_CAPS(DPM_POLICY));
> +               smu_v13_0_6_caps_clear(smu, SMU_CAPS(RMA_MSG));
> +               smu_v13_0_6_caps_clear(smu, SMU_CAPS(ACA_SYND));
>
>                 if (fw_ver <=3D 0x4556900)
> -                       caps &=3D ~SMU_CAPS(UNI_METRICS);
> -
> +                       smu_v13_0_6_caps_clear(smu, SMU_CAPS(UNI_METRICS)=
);
>                 if (fw_ver >=3D 0x04556F00)
> -                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +                       smu_v13_0_6_caps_set(smu, SMU_CAPS(HST_LIMIT_METR=
ICS));
>                 if (fw_ver >=3D 0x04556A00)
> -                       caps |=3D SMU_CAPS(PER_INST_METRICS);
> +                       smu_v13_0_6_caps_set(smu, SMU_CAPS(PER_INST_METRI=
CS));
>                 if (fw_ver < 0x554500)
> -                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
> +                       smu_v13_0_6_caps_clear(smu, SMU_CAPS(CTF_LIMIT));
>         } else {
>                 if (fw_ver >=3D 0x557600)
> -                       caps |=3D SMU_CAPS(OTHER_END_METRICS);
> +                       smu_v13_0_6_caps_set(smu, SMU_CAPS(OTHER_END_METR=
ICS));
>                 if (fw_ver < 0x00556000)
> -                       caps &=3D ~SMU_CAPS(DPM_POLICY);
> +                       smu_v13_0_6_caps_clear(smu, SMU_CAPS(DPM_POLICY))=
;
>                 if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
> -                       caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
> +                       smu_v13_0_6_caps_clear(smu, SMU_CAPS(SET_UCLK_MAX=
));
>                 if (fw_ver < 0x556300)
> -                       caps &=3D ~SMU_CAPS(PCIE_METRICS);
> +                       smu_v13_0_6_caps_clear(smu, SMU_CAPS(PCIE_METRICS=
));
>                 if (fw_ver < 0x554800)
> -                       caps &=3D ~SMU_CAPS(MCA_DEBUG_MODE);
> +                       smu_v13_0_6_caps_clear(smu, SMU_CAPS(MCA_DEBUG_MO=
DE));
>                 if (fw_ver >=3D 0x556F00)
> -                       caps |=3D SMU_CAPS(PER_INST_METRICS);
> +                       smu_v13_0_6_caps_set(smu, SMU_CAPS(PER_INST_METRI=
CS));
>                 if (fw_ver < 0x554500)
> -                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
> +                       smu_v13_0_6_caps_clear(smu, SMU_CAPS(CTF_LIMIT));
>                 if (fw_ver < 0x00555a00)
> -                       caps &=3D ~SMU_CAPS(RMA_MSG);
> +                       smu_v13_0_6_caps_clear(smu, SMU_CAPS(RMA_MSG));
>                 if (fw_ver < 0x00555600)
> -                       caps &=3D ~SMU_CAPS(ACA_SYND);
> +                       smu_v13_0_6_caps_clear(smu, SMU_CAPS(ACA_SYND));
>                 if (pgm =3D=3D 0 && fw_ver >=3D 0x557900)
> -                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +                       smu_v13_0_6_caps_set(smu, SMU_CAPS(HST_LIMIT_METR=
ICS));
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
> +               smu_v13_0_6_caps_set(smu, SMU_CAPS(SDMA_RESET));
>  }
>
>  static void smu_v13_0_x_init_caps(struct smu_context *smu)
> --
> 2.25.1
>
