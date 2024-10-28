Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D7CD3E2A3
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C06510E51A;
	Mon, 28 Oct 2024 19:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TS7UiVs9";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E74EF10E51A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:04:47 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-71e5a00d676so170019b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730142287; x=1730747087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvXISVB0ZExVtuNzTuMGCy68m7LcLTAWkMkj3nvOszA=;
 b=TS7UiVs9aEMNF8yWPD2oMHTDRvF2h+k81r+Kr2kRfQBM1oZEwhUsPyf6uDICqXUw8n
 5iTKWbi+CJ/vhQ/cWCMR6G3B3pfOhe0zBhqyR8RTa66Rg9bFCUX7Mwk+jUXe1B+KVi/N
 vquOjVmYvijhHLXfyHwkwPHP3FQtVgMe7+yt+ut2dPhI3XT7V5jHFCNHNgQpA5AqT4sY
 1QafJQcAxVwxh8Fkto+E5n/HLCRC+LUikZ/9WrzDSgBk7VwJCXlM+1XG/wEzxVTmSQUP
 JwzTmJDpgpd/tUiFkMGOOjVYQby07QDs9xAwObzjQ2OeohfrKOlRmjSoZwG4sWgd+OGF
 vZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730142287; x=1730747087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvXISVB0ZExVtuNzTuMGCy68m7LcLTAWkMkj3nvOszA=;
 b=gICwowPWELO056IaKG/74+aqARlGH2lrrMQaMSYW9hVaT33gmRISEAmUiYqXg/lgzL
 DcQurx8xqn8FvZhE70hWF+zDBPd+Ovuah6V4OXEd8TTnQSr3t6Io5xb0Jz4hWvy9MPAA
 CSDVSPly2wylDlh84LJlAxO+XXCKaakDpdCOecTuqvwCK4btPeLkw9XQ1xVnqFkPsDxe
 eWUkLogGPUnCMUxqzFViVaV9QkuQoruC7y2KP1OfsQSIwekPEm0Y3/69RMpkKOdHt4gZ
 8KnC1dBf2h4/DOubnsixC4rUzj3wA4g6OgJ6DjUOsSEo/lBCo6AQoM75A490zH1tSOfT
 7e1A==
X-Gm-Message-State: AOJu0Yz1VVCbGCblqpoN1zBse/glki3KOF/P8EqKiWnaFvrwIaVYPc1E
 +N+AyWJoG+iXk6+VU4mvHEbQGNKRJw1GkIK/mlvNz3H6aqPhKRzuOSde8Mjy1ngwG2vGaUfw/cN
 yyD+PAUl0gFyu9HurjiJQbRHZDw8=
X-Google-Smtp-Source: AGHT+IHFvCADx2xMoLqVdro23glQP3u7z4/aZ9voJ38f2/Nd5QDTn/12yGviDpEcJkLkWz55y3hXsl1GRZ+LKP//p2s=
X-Received: by 2002:a05:6a00:9a4:b0:71e:594c:a812 with SMTP id
 d2e1a72fcca58-72062a74ec2mr5674747b3a.0.1730142287279; Mon, 28 Oct 2024
 12:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-4-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-4-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:04:35 -0400
Message-ID: <CADnq5_Oi5Vvs1bJa3+TtoCkxAo-jVcJagQtn6JRhpNTpPMpd3w@mail.gmail.com>
Subject: Re: [PATCH 03/29] drm/amd/pm: add inst to smu_dpm_set_vcn_enable
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Thu, Oct 24, 2024 at 10:36=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> First, add an instance parameter to smu_dpm_set_vcn_enable() function,
> and calling dpm_set_vcn_enable() with this given instance.
>
> Second, modify vcn_gated to be an array, to track the gating status
> for each vcn instance separately.
>
> With these 2 changes, smu_dpm_set_vcn_enable() will check and set the
> gating status for the given vcn instance ONLY.
>
> v2: remove duplicated functions.
>
> remove for-loop in dpm_set_vcn_enable(), and temporarily move it to
> to smu_dpm_set_power_gate(), in order to keep the exact same logic as
> before, until further separation in next patch.
>
> v3: add instance number in error message.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 65 ++++++++++++-------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
>  2 files changed, 42 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index ccacba56159e..bb7980f48674 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -234,11 +234,11 @@ static bool is_vcn_enabled(struct amdgpu_device *ad=
ev)
>  }
>
>  static int smu_dpm_set_vcn_enable(struct smu_context *smu,
> -                                 bool enable)
> +                                  bool enable,
> +                                  int inst)
>  {
>         struct smu_power_context *smu_power =3D &smu->smu_power;
>         struct smu_power_gate *power_gate =3D &smu_power->power_gate;
> -       struct amdgpu_device *adev =3D smu->adev;
>         int ret =3D 0;
>
>         /*
> @@ -250,14 +250,12 @@ static int smu_dpm_set_vcn_enable(struct smu_contex=
t *smu,
>         if (!smu->ppt_funcs->dpm_set_vcn_enable)
>                 return 0;
>
> -       if (atomic_read(&power_gate->vcn_gated) ^ enable)
> +       if (atomic_read(&power_gate->vcn_gated[inst]) ^ enable)
>                 return 0;
>
> -       for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               ret =3D smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, i=
);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret =3D smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, inst);
> +       if (!ret)
> +               atomic_set(&power_gate->vcn_gated[inst], !enable);
>
>         return ret;
>  }
> @@ -359,6 +357,7 @@ static int smu_dpm_set_power_gate(void *handle,
>                                   bool gate)
>  {
>         struct smu_context *smu =3D handle;
> +       struct amdgpu_device *adev =3D smu->adev;
>         int ret =3D 0;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
> @@ -375,10 +374,12 @@ static int smu_dpm_set_power_gate(void *handle,
>          */
>         case AMD_IP_BLOCK_TYPE_UVD:
>         case AMD_IP_BLOCK_TYPE_VCN:
> -               ret =3D smu_dpm_set_vcn_enable(smu, !gate);
> -               if (ret)
> -                       dev_err(smu->adev->dev, "Failed to power %s VCN!\=
n",
> -                               gate ? "gate" : "ungate");
> +               for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++) {

Some compilers will warn about mixed declarations and code.  I'd
suggest declaring i at the top of the function.

> +                       ret =3D smu_dpm_set_vcn_enable(smu, !gate, i);
> +                       if (ret)
> +                               dev_err(smu->adev->dev, "Failed to power =
%s VCN instance %d!\n",
> +                                       gate ? "gate" : "ungate", i);
> +               }
>                 break;
>         case AMD_IP_BLOCK_TYPE_GFX:
>                 ret =3D smu_gfx_off_control(smu, gate);
> @@ -780,21 +781,25 @@ static int smu_set_default_dpm_table(struct smu_con=
text *smu)
>         struct amdgpu_device *adev =3D smu->adev;
>         struct smu_power_context *smu_power =3D &smu->smu_power;
>         struct smu_power_gate *power_gate =3D &smu_power->power_gate;
> -       int vcn_gate, jpeg_gate;
> +       int vcn_gate[AMDGPU_MAX_VCN_INSTANCES], jpeg_gate, i;
>         int ret =3D 0;
>
>         if (!smu->ppt_funcs->set_default_dpm_table)
>                 return 0;
>
> -       if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
> -               vcn_gate =3D atomic_read(&power_gate->vcn_gated);
> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> +               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> +                       vcn_gate[i] =3D atomic_read(&power_gate->vcn_gate=
d[i]);
> +       }
>         if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
>                 jpeg_gate =3D atomic_read(&power_gate->jpeg_gated);
>
>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> -               ret =3D smu_dpm_set_vcn_enable(smu, true);
> -               if (ret)
> -                       return ret;
> +               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +                       ret =3D smu_dpm_set_vcn_enable(smu, true, i);
> +                       if (ret)
> +                               return ret;
> +               }
>         }
>
>         if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
> @@ -811,8 +816,10 @@ static int smu_set_default_dpm_table(struct smu_cont=
ext *smu)
>         if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
>                 smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
>  err_out:
> -       if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
> -               smu_dpm_set_vcn_enable(smu, !vcn_gate);
> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> +               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> +                       smu_dpm_set_vcn_enable(smu, !vcn_gate[i], i);
> +       }
>
>         return ret;
>  }
> @@ -1265,7 +1272,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_b=
lock)
>         smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>         smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;
>
> -       atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
> +       for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++)

Same comment here and all the place below as well.

Alex

> +               atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
>         atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
>         atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>         atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
> @@ -1832,7 +1840,8 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_b=
lock)
>                 ret =3D smu_set_gfx_imu_enable(smu);
>                 if (ret)
>                         return ret;
> -               smu_dpm_set_vcn_enable(smu, true);
> +               for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> +                       smu_dpm_set_vcn_enable(smu, true, i);
>                 smu_dpm_set_jpeg_enable(smu, true);
>                 smu_dpm_set_vpe_enable(smu, true);
>                 smu_dpm_set_umsch_mm_enable(smu, true);
> @@ -2035,7 +2044,8 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_b=
lock)
>         if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>                 return 0;
>
> -       smu_dpm_set_vcn_enable(smu, false);
> +       for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> +               smu_dpm_set_vcn_enable(smu, false, i);
>         smu_dpm_set_jpeg_enable(smu, false);
>         smu_dpm_set_vpe_enable(smu, false);
>         smu_dpm_set_umsch_mm_enable(smu, false);
> @@ -2949,6 +2959,7 @@ static int smu_read_sensor(void *handle,
>                            int *size_arg)
>  {
>         struct smu_context *smu =3D handle;
> +       struct amdgpu_device *adev =3D smu->adev;
>         struct smu_umd_pstate_table *pstate_table =3D
>                                 &smu->pstate_table;
>         int ret =3D 0;
> @@ -2997,7 +3008,13 @@ static int smu_read_sensor(void *handle,
>                 *size =3D 4;
>                 break;
>         case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
> -               *(uint32_t *)data =3D atomic_read(&smu->smu_power.power_g=
ate.vcn_gated) ? 0 : 1;
> +               *(uint32_t *)data =3D 0;
> +               for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +                       if (!atomic_read(&smu->smu_power.power_gate.vcn_g=
ated[i])) {
> +                               *(uint32_t *)data =3D 1;
> +                               break;
> +                       }
> +               }
>                 *size =3D 4;
>                 break;
>         case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 4ebcc1e53ea2..06d817fb84aa 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -399,7 +399,7 @@ struct smu_dpm_context {
>  struct smu_power_gate {
>         bool uvd_gated;
>         bool vce_gated;
> -       atomic_t vcn_gated;
> +       atomic_t vcn_gated[AMDGPU_MAX_VCN_INSTANCES];
>         atomic_t jpeg_gated;
>         atomic_t vpe_gated;
>         atomic_t umsch_mm_gated;
> --
> 2.34.1
>
