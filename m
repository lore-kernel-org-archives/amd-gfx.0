Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2C3C87FD2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 13:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9844F10E079;
	Mon, 11 Aug 2025 13:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OryML7gA";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3650010E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 13:45:50 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2400b3008e8so6492265ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754919949; x=1755524749; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wS0ARNU5yCAZpX0WE15KIsmucUPcI/5nx58MeZKnjQk=;
 b=OryML7gA0VCYCflqeeszlTCcFBsJ6LXOSUmb75zD/n0dFcov5qsSvqWfOJ3MKVDdw7
 FBa/uN6a0ZLIo8hijQvJWjuGED87CUCXau6sysWUzXlAHoPoRB1n0nS+7VIbe9p6mrz9
 qEt/60zutR4Q8A+JYBqhNm+ymEDQ/i2nXMiE+u5mFZAzXbnffYRMgUqDoWrqgyPEbk3E
 ibqARnpUSZI0Pu/7g0ZrZnab9ihimKHlAdMGbdMbegkSZHqO9a6xeBtGIWsPjjgcamld
 NiNo49KQmt622RtA4oZWtBlemjL2kZ4bqCL+Tl1s6MRsiN/q1naSm2O4G06veCJT4jQJ
 Oqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754919949; x=1755524749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wS0ARNU5yCAZpX0WE15KIsmucUPcI/5nx58MeZKnjQk=;
 b=nggR/7dzF3zVuqIJ84xhaz+KkjgFerLErXbjT9NLt6hUxn86fDG/pRR4RgVVWdL9N/
 n+BjwlRwIbTCi7x13LXj3Awl78Zsqa3Cj+zb+UxdnZAuC1XeK6oVjA+QebOv7PVyX8wm
 vLCSJ+yz256isaddA58t1wHS+O0MPFCbkqlnlKRA0AtXFGUMJtHqjb3ufF2a6eD2aPMj
 4Z90gk3Mtn6IoAkb6n5gnwrj57RzYGp4BYnjuZKPxqqrjZmHXftDePoD4XlbHWeQ/QY0
 C36crsufdg579dZoXyj/jONlx66qS8JfbDqQ1B9UHu0teeQTt/ti/7yM1ozGw7ff3IzP
 YuJg==
X-Gm-Message-State: AOJu0Yx8A26R5seU9DxfnGKZsg1V8T4IKxGk+1vzudGRFE6hxQH4FY8a
 tYPDUDY/UNx+pP50ipRhAimION5/DnDG+LmYHEYvFuMwcdPhu4cJ9Yj/bdWnbNDDdpwYtvB7MGD
 OcuwIhYXC7bRJkmd9TxVZyWfXBobgqBfP3LYP
X-Gm-Gg: ASbGncu2RfiWXgzYXbOoEroeP2lN9qT6ZK6lVouKZCpIknJADfW2P2YC7EmLpvCjQnC
 xvOT/GKVujm/0r5pS6Hqu3GpXHKVBalB3XymQQl4vHvjWImDQj6YakoSjk3oGzhktM0YRbSGy6m
 Lmf8WE1WJ5cAzO+wgayPhN4e0SA72XNi9w2FVR3McXtjVQwLUtLQvQ2I0shsfPLyY2Yjl8zYQuA
 G+9IK6POK8vt8Fyyw==
X-Google-Smtp-Source: AGHT+IFpyZdfSpokWAGUFDXUMeHqhpR7qZJXpeq5HABBOiT/baOXvz5sQFYr5yMq/mXNEpT3DIYiNhmwAnxQC8TyBag=
X-Received: by 2002:a17:902:ec8e:b0:240:711f:2068 with SMTP id
 d9443c01a7336-242d6ca1102mr55583715ad.7.1754919949335; Mon, 11 Aug 2025
 06:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250811010437.1895121-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250811010437.1895121-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Aug 2025 09:45:37 -0400
X-Gm-Features: Ac12FXwiMaPK93wwcBHkKhVE3RkNTtKSuG_OZW2G3kg8dFjeIE1Yf9PN3rSR0zA
Message-ID: <CADnq5_NYFU0EhX9D9yWT1drjZBBBfnVXUg+KyCvpjSrFDnqWZQ@mail.gmail.com>
Subject: Re: [v2 1/2] drm/amd/pm: Add VCN reset support detection for SMU
 v13.0.6
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Ruili Ji <ruiliji2@amd.com>
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

On Sun, Aug 10, 2025 at 9:13=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> From: Ruili Ji <ruiliji2@amd.com>
>
> This commit introduces support for detecting VCN reset capability through
> the SMU interface. Key changes include:
>
> 1. Added amdgpu_dpm_reset_vcn_is_supported() interface to check VCN reset=
 support
> 2. Implemented SMU backend functions for VCN reset capability detection
> 3. Added SMU_CAP(VCN_RESET) capability flag for SMU v13.0.6
> 4. Updated PPSMC message definitions to accommodate VCN reset functionali=
ty
> 5. Added version checks for VCN reset support (fw_ver >=3D 0x04557100)
>
> The changes maintain backward compatibility while enabling proper detecti=
on
> of VCN reset capabilities when supported by the firmware.
>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 15 +++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 11 +++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  |  5 +++++
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   |  4 ++--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 18 ++++++++++++++++++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |  1 +
>  7 files changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 6e0d711820ea..518d07afc7df 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -820,6 +820,21 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev,=
 uint32_t inst_mask)
>         return ret;
>  }
>
> +bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev)
> +{
> +       struct smu_context *smu =3D adev->powerplay.pp_handle;
> +       bool ret;
> +
> +       if (!is_support_sw_smu(adev))
> +               return false;
> +
> +       mutex_lock(&adev->pm.mutex);
> +       ret =3D smu_reset_vcn_is_supported(smu);
> +       mutex_unlock(&adev->pm.mutex);
> +
> +       return ret;
> +}
> +
>  int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
>                                   enum pp_clock_type type,
>                                   uint32_t *min,
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_dpm.h
> index 09962db988d6..9748744133d9 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -615,6 +615,7 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_d=
evice *adev,
>  int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask=
);
>  bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
>  int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)=
;
> +bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
>  bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
>                                           enum smu_temp_metric_type type)=
;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index dc48a1dd8be4..a03d37bd9e48 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -4106,6 +4106,17 @@ int smu_reset_sdma(struct smu_context *smu, uint32=
_t inst_mask)
>         return ret;
>  }
>
> +bool smu_reset_vcn_is_supported(struct smu_context *smu)
> +{
> +       bool ret =3D false;
> +
> +        dev_info(smu->adev->dev, "SMU driver smu %p\n", smu);

This looks like leftover debugging output?


> +       if (smu->ppt_funcs && smu->ppt_funcs->reset_vcn_is_supported)
> +               ret =3D smu->ppt_funcs->reset_vcn_is_supported(smu);
> +
> +       return ret;
> +}
> +
>  int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
>  {
>         if (smu->ppt_funcs && smu->ppt_funcs->dpm_reset_vcn)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 611b381b9147..7990771151be 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1426,6 +1426,10 @@ struct pptable_funcs {
>          * @reset_vcn: message SMU to soft reset vcn instance.
>          */
>         int (*dpm_reset_vcn)(struct smu_context *smu, uint32_t inst_mask)=
;
> +       /**
> +        * @reset_vcn_is_supported: Check if support resets vcn.
> +        */
> +       bool (*reset_vcn_is_supported)(struct smu_context *smu);
>
>         /**
>          * @get_ecc_table:  message SMU to get ECC INFO table.
> @@ -1702,6 +1706,7 @@ int smu_send_rma_reason(struct smu_context *smu);
>  int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
>  bool smu_reset_sdma_is_supported(struct smu_context *smu);
>  int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask);
> +bool smu_reset_vcn_is_supported(struct smu_context *smu);
>  int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
>                       int level);
>  ssize_t smu_get_pm_policy_info(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h=
 b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> index 41f268313613..63a088ef7169 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> @@ -94,9 +94,9 @@
>  #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
>  #define PPSMC_MSG_SetThrottlingPolicy               0x44
>  #define PPSMC_MSG_ResetSDMA                         0x4D
> -#define PPSMC_MSG_ResetVCN                          0x4E
>  #define PPSMC_MSG_GetStaticMetricsTable             0x59
> -#define PPSMC_Message_Count                         0x5A
> +#define PPSMC_MSG_ResetVCN                          0x5B
> +#define PPSMC_Message_Count                         0x5C
>
>  //PPSMC Reset Types for driver msg argument
>  #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 90e66c8f2f82..c25dd7427f1d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -434,6 +434,9 @@ static void smu_v13_0_6_init_caps(struct smu_context =
*smu)
>             ((pgm =3D=3D 0) && (fw_ver >=3D 0x00557900)) ||
>             ((pgm =3D=3D 4) && (fw_ver >=3D 0x4557000)))
>                 smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
> +
> +       if ((pgm =3D=3D 4) && (fw_ver >=3D 0x04557100))
> +               smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>  }
>
>  static void smu_v13_0_x_init_caps(struct smu_context *smu)
> @@ -3171,6 +3174,20 @@ static int smu_v13_0_6_reset_sdma(struct smu_conte=
xt *smu, uint32_t inst_mask)
>         return ret;
>  }
>
> +static bool smu_v13_0_6_reset_vcn_is_supported(struct smu_context *smu)
> +{
> +       bool ret =3D true;
> +
> +        dev_info(smu->adev->dev, "SMU driver smu_v13_0_6_reset_vcn_is_su=
pported\n");

Same here.


> +       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(VCN_RESET))) {
> +               dev_info(smu->adev->dev,
> +                       "VCN reset capability is not supported\n");

Maybe adjust this message to be more meaningful?  E.g., something like:
"SMU VCN reset not supported.  Please update SMU firmware."

Alex

> +               ret =3D false;
> +       }
> +
> +       return ret;
> +}
> +
>  static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_=
mask)
>  {
>         int ret =3D 0;
> @@ -3859,6 +3876,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_f=
uncs =3D {
>         .reset_sdma =3D smu_v13_0_6_reset_sdma,
>         .reset_sdma_is_supported =3D smu_v13_0_6_reset_sdma_is_supported,
>         .dpm_reset_vcn =3D smu_v13_0_6_reset_vcn,
> +       .reset_vcn_is_supported =3D smu_v13_0_6_reset_vcn_is_supported,
>  };
>
>  void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index ece04ad724fb..7c98f77c429d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -64,6 +64,7 @@ enum smu_v13_0_6_caps {
>         SMU_CAP(RMA_MSG),
>         SMU_CAP(ACA_SYND),
>         SMU_CAP(SDMA_RESET),
> +       SMU_CAP(VCN_RESET),
>         SMU_CAP(STATIC_METRICS),
>         SMU_CAP(HST_LIMIT_METRICS),
>         SMU_CAP(BOARD_VOLTAGE),
> --
> 2.49.0
>
