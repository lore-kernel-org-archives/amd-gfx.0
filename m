Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B00C02185
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 15:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E1010EB1D;
	Fri, 17 Jan 2025 15:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WfjPGa6D";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A120110EAF4
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 15:23:58 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f615e14d0fso483430a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737127378; x=1737732178; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgB4NZsjhvgsvk0kWmxLCKHzLsSN2desk0x4ldkVKLc=;
 b=WfjPGa6DFNWFXaK2ALHEchw9dX+qYuxGdi3rGweZ42c86EVpdPFOa89dubnNM7Q2yY
 X9VpdojXSMvg6UXXVidZ0uQjll7oF/lyLh+l09AEVxzbgxQ4ZFxGWpL85nJ+UEBIvidN
 TESThiWS70Lle4vqzp76rJ4GeFaHtutdExXTOl/iYcuMgAs59TnLao3uPFMZ1rNZ4obU
 qnuuDjA3DJ9wdiBYb7pvbhV7Safi0v7Ku0SUONyHmakktCXb0fDlJIGMfu0DkjywxH2s
 EGKILVFE3vjXupiR0hq9lkpWhaHeA2qOhkq3xDzUpyed7G0i67X34DSgZwFx49uMfc4a
 s1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737127378; x=1737732178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgB4NZsjhvgsvk0kWmxLCKHzLsSN2desk0x4ldkVKLc=;
 b=gnT5s7fCxkOOSdGCLUc3vSYK3Dgr7BE1kAZkFp/1BxAkdMSNRvsGUPhI0iWiP1or66
 0GmUajEsBNNT5HJ68FB3Oy/hlwZ/sSrl1HRRuM+uVsF0bukDSBcjN/5UaIRBRX7tMA4g
 sxeqstebE1TUi9C9Y4sTQ4w6yudcdLiSNxO2BwO1tUKjm7oXuUW28WHXkImO6XWUqnMG
 XKjTqGYOz+96rnH4XBBKBkPfkb8+MNiCaDRK5lkpDBY3RRTuV7JWoywXCbQVMHxGdY8O
 /amN+DF+4SuX/SAT7hjKUD9q7KQrd1cVPMvIpC7tdHkx7DNjbDOGIjg8xf5vHC4N6fRE
 Hp3Q==
X-Gm-Message-State: AOJu0YypK/S5xGSaNIjE5c0FEUp43Ex5nar7FTL2q6PmhXJK4mZyD4Pa
 ZosGBBtLyCfU2nejadsWxyttJdgHFdsnG5WnoeAarPRPh/GF5eoqlIhUdWT6PwA8gJK1aQvW8NN
 CTy1oG5NsZLRRISdzfvZ46aiT3AX1XA==
X-Gm-Gg: ASbGncttuT/5eOFRbWwjn5KgjogHqDpawGPh8uwf8tQJtar3R1YcwTvBOAXzKIJZhLk
 qKTpLWyjCpyu8q4JbYQ8tZJ0ws3o6iwIQcYGftg==
X-Google-Smtp-Source: AGHT+IExCpTY9C6RABOY1egL8p4CBotHjK6DoI9YBhUk5aIMaoRcPmQyUPt+OD862+K9xv8ClzQPU16VwBaYdSs9Vxc=
X-Received: by 2002:a17:90b:534c:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-2f782b06b52mr1665922a91.0.1737127378173; Fri, 17 Jan 2025
 07:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20250117151357.1480352-1-lijo.lazar@amd.com>
In-Reply-To: <20250117151357.1480352-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Jan 2025 10:22:46 -0500
X-Gm-Features: AbW1kvZcy9FbC5V355h_L0MYRmtk9dS9BXfLajCD5E1ZPVH1FOcoJH7ylBT1bfU
Message-ID: <CADnq5_Oo6s2gFe_UUHL_SHeHPK0er8XOkv+R-E49iEHxS-PTcA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Use correct macros for smu caps
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

On Fri, Jan 17, 2025 at 10:14=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Fix the initialization and usage of capability values and mask.
> SMU_CAPS_MASK indicates mask value, and SMU_CAPS represent the
> capability value.
>

Might be cleaner to have CAP_GET and CAP_SET macros.

Alex

> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Fixes: 9bb53d2ce109 ("drm/amd/pm: Add capability flags for SMU v13.0.6")
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 80 ++++++++++---------
>  1 file changed, 42 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 56e26fcd3066..52fd8355eee1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -118,8 +118,9 @@ enum smu_v13_0_6_caps {
>         SMU_13_0_6_CAPS_ALL,
>  };
>
> -#define SMU_CAPS_MASK(x) (ULL(1) << x)
> -#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)
> +#define SMU_CAPS_TO_MASK(x) (ULL(1) << x)
> +#define SMU_CAPS(x) SMU_13_0_6_CAPS_##x
> +#define SMU_CAPS_MASK(x) SMU_CAPS_TO_MASK(SMU_CAPS(x))
>
>  struct mca_bank_ipid {
>         enum amdgpu_mca_ip ip;
> @@ -287,82 +288,84 @@ struct smu_v13_0_6_dpm_map {
>  static void smu_v13_0_14_init_caps(struct smu_context *smu)
>  {
>         struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> -       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
> -                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
> -                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
> -                       SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
> -                       SMU_CAPS(ACA_SYND);
> +       uint64_t caps =3D SMU_CAPS_MASK(DPM) | SMU_CAPS_MASK(UNI_METRICS)=
 |
> +                       SMU_CAPS_MASK(SET_UCLK_MAX) |
> +                       SMU_CAPS_MASK(DPM_POLICY) |
> +                       SMU_CAPS_MASK(PCIE_METRICS) | SMU_CAPS_MASK(CTF_L=
IMIT) |
> +                       SMU_CAPS_MASK(MCA_DEBUG_MODE) | SMU_CAPS_MASK(RMA=
_MSG) |
> +                       SMU_CAPS_MASK(ACA_SYND);
>         uint32_t fw_ver =3D smu->smc_fw_version;
>
>         if (fw_ver >=3D 0x05550E00)
> -               caps |=3D SMU_CAPS(OTHER_END_METRICS);
> +               caps |=3D SMU_CAPS_MASK(OTHER_END_METRICS);
>         if (fw_ver >=3D 0x05551000)
> -               caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +               caps |=3D SMU_CAPS_MASK(HST_LIMIT_METRICS);
>         if (fw_ver >=3D 0x05550B00)
> -               caps |=3D SMU_CAPS(PER_INST_METRICS);
> +               caps |=3D SMU_CAPS_MASK(PER_INST_METRICS);
>         if (fw_ver > 0x05550f00)
> -               caps |=3D SMU_CAPS(SDMA_RESET);
> +               caps |=3D SMU_CAPS_MASK(SDMA_RESET);
>
>         dpm_context->caps =3D caps;
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
> +       uint64_t caps =3D
> +               SMU_CAPS_MASK(DPM) | SMU_CAPS_MASK(UNI_METRICS) |
> +               SMU_CAPS_MASK(SET_UCLK_MAX) | SMU_CAPS_MASK(DPM_POLICY) |
> +               SMU_CAPS_MASK(PCIE_METRICS) | SMU_CAPS_MASK(MCA_DEBUG_MOD=
E) |
> +               SMU_CAPS_MASK(CTF_LIMIT) | SMU_CAPS_MASK(RMA_MSG) |
> +               SMU_CAPS_MASK(ACA_SYND);
>         struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
>         struct amdgpu_device *adev =3D smu->adev;
>         uint32_t fw_ver =3D smu->smc_fw_version;
>         uint32_t pgm =3D (fw_ver >> 24) & 0xFF;
>
>         if (fw_ver < 0x552F00)
> -               caps &=3D ~SMU_CAPS(DPM);
> +               caps &=3D ~SMU_CAPS_MASK(DPM);
>
>         if (adev->flags & AMD_IS_APU) {
> -               caps &=3D ~SMU_CAPS(PCIE_METRICS);
> -               caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
> -               caps &=3D ~SMU_CAPS(DPM_POLICY);
> -               caps &=3D ~SMU_CAPS(RMA_MSG);
> -               caps &=3D ~SMU_CAPS(ACA_SYND);
> +               caps &=3D ~SMU_CAPS_MASK(PCIE_METRICS);
> +               caps &=3D ~SMU_CAPS_MASK(SET_UCLK_MAX);
> +               caps &=3D ~SMU_CAPS_MASK(DPM_POLICY);
> +               caps &=3D ~SMU_CAPS_MASK(RMA_MSG);
> +               caps &=3D ~SMU_CAPS_MASK(ACA_SYND);
>
>                 if (fw_ver <=3D 0x4556900)
> -                       caps &=3D ~SMU_CAPS(UNI_METRICS);
> +                       caps &=3D ~SMU_CAPS_MASK(UNI_METRICS);
>
>                 if (fw_ver >=3D 0x04556F00)
> -                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +                       caps |=3D SMU_CAPS_MASK(HST_LIMIT_METRICS);
>                 if (fw_ver >=3D 0x04556A00)
> -                       caps |=3D SMU_CAPS(PER_INST_METRICS);
> +                       caps |=3D SMU_CAPS_MASK(PER_INST_METRICS);
>                 if (fw_ver < 0x554500)
> -                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
> +                       caps &=3D ~SMU_CAPS_MASK(CTF_LIMIT);
>         } else {
>                 if (fw_ver >=3D 0x557600)
> -                       caps |=3D SMU_CAPS(OTHER_END_METRICS);
> +                       caps |=3D SMU_CAPS_MASK(OTHER_END_METRICS);
>                 if (fw_ver < 0x00556000)
> -                       caps &=3D ~SMU_CAPS(DPM_POLICY);
> +                       caps &=3D ~SMU_CAPS_MASK(DPM_POLICY);
>                 if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
> -                       caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
> +                       caps &=3D ~SMU_CAPS_MASK(SET_UCLK_MAX);
>                 if (fw_ver < 0x556300)
> -                       caps &=3D ~SMU_CAPS(PCIE_METRICS);
> +                       caps &=3D ~SMU_CAPS_MASK(PCIE_METRICS);
>                 if (fw_ver < 0x554800)
> -                       caps &=3D ~SMU_CAPS(MCA_DEBUG_MODE);
> +                       caps &=3D ~SMU_CAPS_MASK(MCA_DEBUG_MODE);
>                 if (fw_ver >=3D 0x556F00)
> -                       caps |=3D SMU_CAPS(PER_INST_METRICS);
> +                       caps |=3D SMU_CAPS_MASK(PER_INST_METRICS);
>                 if (fw_ver < 0x554500)
> -                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
> +                       caps &=3D ~SMU_CAPS_MASK(CTF_LIMIT);
>                 if (fw_ver < 0x00555a00)
> -                       caps &=3D ~SMU_CAPS(RMA_MSG);
> +                       caps &=3D ~SMU_CAPS_MASK(RMA_MSG);
>                 if (fw_ver < 0x00555600)
> -                       caps &=3D ~SMU_CAPS(ACA_SYND);
> +                       caps &=3D ~SMU_CAPS_MASK(ACA_SYND);
>                 if (pgm =3D=3D 0 && fw_ver >=3D 0x557900)
> -                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
> +                       caps |=3D SMU_CAPS_MASK(HST_LIMIT_METRICS);
>         }
>         if (((pgm =3D=3D 7) && (fw_ver > 0x07550700)) ||
>             ((pgm =3D=3D 0) && (fw_ver > 0x00557700)) ||
>             ((pgm =3D=3D 4) && (fw_ver > 0x4556e6c)))
> -               caps |=3D SMU_CAPS(SDMA_RESET);
> +               caps |=3D SMU_CAPS_MASK(SDMA_RESET);
>
>         dpm_context->caps =3D caps;
>  }
> @@ -372,7 +375,8 @@ static inline bool smu_v13_0_6_caps_supported(struct =
smu_context *smu,
>  {
>         struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
>
> -       return (dpm_context->caps & SMU_CAPS_MASK(caps)) =3D=3D SMU_CAPS_=
MASK(caps);
> +       return (dpm_context->caps & SMU_CAPS_TO_MASK(caps)) =3D=3D
> +              SMU_CAPS_TO_MASK(caps);
>  }
>
>  static void smu_v13_0_x_init_caps(struct smu_context *smu)
> --
> 2.25.1
>
