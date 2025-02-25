Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3520C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 15:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A1B10E707;
	Tue, 25 Feb 2025 15:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ReEX4Ecd";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AAD610E707
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 15:07:17 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2fc0ab102e2so1454367a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740496037; x=1741100837; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oHUVy5dapyHqdcEbm9Lk+gKo6u9d3tJxbS616isis4=;
 b=ReEX4EcdTSYzyPbf6v/X81Sb0HMcTcZVGqJSTYfVaEKdCBvgzfmzovh/i9KGurNkDa
 cV6JN+6zO+QBVjZXdadCoU3K7Ld7nd7ka4pwPKYenbtf6H4FArCuOESCTSoGkxnnhT2n
 5liZsks881tMarpQmxb4RTOCpIh7mny3Lv91D3xHJGRJU+nqqE0SbG6p29GhQN8WRKFx
 MveeAIbYgpyD0bMovVqngEM0Saqa4WJ6iQ6vwyyCf/zZ9F+u/A/5fOh9fVLSm3OVsz5S
 xkrqImbSFH19H8sFjYVe686Me3R+dzA6SvIHmp/roCgSWn2VFZ7dGdiR57PoMapzd/2i
 UclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740496037; x=1741100837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oHUVy5dapyHqdcEbm9Lk+gKo6u9d3tJxbS616isis4=;
 b=DLcYt03wPNNL104mThIdAcv7iPQyDhrBI/i+KwK3cxonoHuWLp6d6hk4NPI5TPjivK
 orBePT1qOiPauQnTfC4uCVIc2vCvUA7l1n4RzxbMmRW+XbAUm+nBGBJ1WiJkAWwTxNkH
 zmpXxV5ik6SkzFRHtX6+LNlmgZEbTz/KmbU/vIwg+m92h+S5X6IHMZodtfyCUFYnZ+Kf
 1R/cQjbCLdk/E+OV+pyWM/Cedw2w1ln2LiA+ARXajV91gWFcW7R3hUxSQ/r/SedbVID7
 r5Y59CDOHGuFkNq9aUDjjSjey8X63iQgsJvcsek2ix3slfhCV8u/OLdakcb3k0YG/w8O
 q4Eg==
X-Gm-Message-State: AOJu0YzRforq51tTQmB1rJE4HDtAt1Q/uFyXLicffHMUs9BY4XRJ++0N
 2NTfOQZ2F1MEL/Xa9sJaVYTa7acjoSSUjyVSWac8enovzhp1Kj2zA13XYrhIdUUO+IsWy0i/wk+
 LxCsEOptSDZSqdHIxLxtlzChJsn4DyQ==
X-Gm-Gg: ASbGncsLoDJLOkY+e6NdNHP8Gz7vCjb69yfpkaP2KqNHlYDvIeRfWfI4Raks7R05Vf5
 Pp97lO1BRm8Mtj0XR46GJetmWTgOYWm55NkXTRomHNE8vJ7+D50cgPXHYQfYJ8+YviD76G5J64b
 No0HU8bJ8=
X-Google-Smtp-Source: AGHT+IHYnAITOaxrhuX68BO0bauSSrAbqlvcZCR8ju3Rlag1T+87aFl0l8cdid4o7nL8pkD48pvRjZIUR8f8qFCnXTM=
X-Received: by 2002:a17:90b:4c0a:b0:2ee:b665:12c2 with SMTP id
 98e67ed59e1d1-2fce769a322mr11263578a91.2.1740496036384; Tue, 25 Feb 2025
 07:07:16 -0800 (PST)
MIME-Version: 1.0
References: <20250224190110.645062-1-alexander.deucher@amd.com>
In-Reply-To: <20250224190110.645062-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Feb 2025 10:07:05 -0500
X-Gm-Features: AWEUYZkTL8OmPDguuW0ykAkC1CABxv8O6EHIRaUButka3ngswt7CAZb-0LFaxGs
Message-ID: <CADnq5_O-JC2ALnNouksBTOzJcNfNDVUwnJx3GqeJ9aY90UMnxw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn2.5: fix VCN stop logic
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Boyuan Zhang <boyuan.zhang@amd.com>
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

Ping?

On Mon, Feb 24, 2025 at 2:39=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Need to make sure we call amdgpu_dpm_enable_vcn()
> in vcn_v2_5_stop() at the end if there are errors
> or DPG is enabled.
>
> Fixes: ebc25499de12 ("drm/amdgpu/vcn2.5: split code along instances")
> Suggested-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index a6726afcf89cb..e36e2a5676df9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1414,13 +1414,15 @@ static int vcn_v2_5_stop(struct amdgpu_device *ad=
ev, int i)
>
>         if (adev->vcn.harvest_config & (1 << i))
>                 return 0;
> -       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -               return vcn_v2_5_stop_dpg_mode(adev, i);
> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +               r =3D vcn_v2_5_stop_dpg_mode(adev, i);
> +               goto done;
> +       }
>
>         /* wait for vcn idle */
>         r =3D SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, =
0x7);
>         if (r)
> -               return r;
> +               goto done;
>
>         tmp =3D UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>                 UVD_LMI_STATUS__READ_CLEAN_MASK |
> @@ -1428,7 +1430,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev=
, int i)
>                 UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>         r =3D SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>         if (r)
> -               return r;
> +               goto done;
>
>         /* block LMI UMC channel */
>         tmp =3D RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> @@ -1439,7 +1441,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev=
, int i)
>                 UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>         r =3D SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>         if (r)
> -               return r;
> +               goto done;
>
>         /* block VCPU register access */
>         WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> @@ -1465,10 +1467,11 @@ static int vcn_v2_5_stop(struct amdgpu_device *ad=
ev, int i)
>                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>                  ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>
> +done:
>         if (adev->pm.dpm_enabled)
>                 amdgpu_dpm_enable_vcn(adev, false, i);
>
> -       return 0;
> +       return r;
>  }
>
>  static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
> --
> 2.48.1
>
