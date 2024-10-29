Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4EBD3A67C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 18:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E284510E104;
	Tue, 29 Oct 2024 18:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eTDeY2fi";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A552D10E6C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 18:34:26 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-7ea85fa4f45so870423a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730226866; x=1730831666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJSYJGWytzACeq9Mg1fDyaUIaf2N9Hde2rf0tzbQFUM=;
 b=eTDeY2fiRatvP9Zd7z/gvNWYGD7grF0TN1jQt5Ok3vltg4p5webQ+cKCgAdEYgOrsu
 GCz6uGK747IQ9XKW4TVv2PbGEwOOCMGzPXbNNumIEQAzZNVbpgDQqEVT9xOGQTFfoWLJ
 X2WqStJXkjwQWCiQkSpfNDqoMrmCO0hssJUZt3s6CaGGoN1eCIjPFqOn143HATEhZ8lC
 qYLPzxC/I/XPaQoMp2L40Ny7y80AId9csOL96alTlSbLWoB5c+mcYqGVIp5F9TOr+bjg
 6HSGL9InkCoRmEgtPy6QN7bfTpymg3CGENYJ+Uj3xyJmsbDkSUkNSpbg01KRF+X5zhMR
 DEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730226866; x=1730831666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJSYJGWytzACeq9Mg1fDyaUIaf2N9Hde2rf0tzbQFUM=;
 b=QmrLcko5l7eTs8qVpnzLs83BdjSEMSovj9QwfzCs6J0UZRJ+e3ZcGlu67tzQdUb2Og
 r30NnjPLjQFCV09PWoG5gPr2Qdi/DJplsfNQ8lqsu8hPiRw8BlHH/MzRmcpgVZcBaY16
 yF6V9q1W+ZXHFIIi2xAqkeeKgvF1l6BbYdVrPKmwbHsvDTlJzr0QE5oAo7oBFwI2pzuu
 54WoifG5YMIIvQBsLGvD8q3a/D1UeoTTXRG3yVEtvjV9Z969OM/C937PS69TvnMHPfBN
 IN+6vECknvPlWzZO7qSQt1DllNQRV5sKCPMNBvJDz20ystFjcLSDjsjvvcr8Jdc11qJS
 apWQ==
X-Gm-Message-State: AOJu0YwDjHoLDgnfA8bvxATAUWxRSGFwugNOm1wjBOiCzssyInZNJMcc
 Et8HSurtOZCuzgglHT+cfP2RgEmOvQgSgonuuvnWXl5EwOzzR/bIK4clpbiYhDDG7xc/XzD9xtr
 cYPPIrDzPcA5Ishkn/HUN6bR7aYU=
X-Google-Smtp-Source: AGHT+IF53fJngBkLFmpOxln9Lrla79+8cCMdxoPjg0V71u5U7/E2wdqJa1JXbdZyYiXfnHgXhUkBYfMAfcUlp2YznSM=
X-Received: by 2002:a05:6a20:72a6:b0:1cf:3b1e:ccd with SMTP id
 adf61e73a8af0-1d9a83dfe4amr9710545637.5.1730226865995; Tue, 29 Oct 2024
 11:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
 <20241029174240.682928-4-boyuan.zhang@amd.com>
In-Reply-To: <20241029174240.682928-4-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 14:34:14 -0400
Message-ID: <CADnq5_PbzMf9Q+iM48jqf4wr82B1onJFBgMO0k=1AbM4eJzuUA@mail.gmail.com>
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

On Tue, Oct 29, 2024 at 1:53=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
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
> v4: declaring i at the top of the function.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 75 ++++++++++++-------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
>  2 files changed, 47 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index ccacba56159e..dfbec2e2ec20 100644
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
> @@ -359,7 +357,8 @@ static int smu_dpm_set_power_gate(void *handle,
>                                   bool gate)
>  {
>         struct smu_context *smu =3D handle;
> -       int ret =3D 0;
> +       struct amdgpu_device *adev =3D smu->adev;
> +       int i, ret =3D 0;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
>                 dev_WARN(smu->adev->dev,
> @@ -375,10 +374,12 @@ static int smu_dpm_set_power_gate(void *handle,
>          */
>         case AMD_IP_BLOCK_TYPE_UVD:
>         case AMD_IP_BLOCK_TYPE_VCN:
> -               ret =3D smu_dpm_set_vcn_enable(smu, !gate);
> -               if (ret)
> -                       dev_err(smu->adev->dev, "Failed to power %s VCN!\=
n",
> -                               gate ? "gate" : "ungate");
> +               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
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
> @@ -1251,7 +1258,7 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_b=
lock)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct smu_context *smu =3D adev->powerplay.pp_handle;
> -       int ret;
> +       int i, ret;
>
>         smu->pool_size =3D adev->pm.smu_prv_buffer_size;
>         smu->smu_feature.feature_num =3D SMU_FEATURE_MAX;
> @@ -1265,7 +1272,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_b=
lock)
>         smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>         smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;
>
> -       atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> +               atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
>         atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
>         atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>         atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
> @@ -1806,7 +1814,7 @@ static int smu_start_smc_engine(struct smu_context =
*smu)
>
>  static int smu_hw_init(struct amdgpu_ip_block *ip_block)
>  {
> -       int ret;
> +       int i, ret;
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct smu_context *smu =3D adev->powerplay.pp_handle;
>
> @@ -1832,7 +1840,8 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_b=
lock)
>                 ret =3D smu_set_gfx_imu_enable(smu);
>                 if (ret)
>                         return ret;
> -               smu_dpm_set_vcn_enable(smu, true);
> +               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> +                       smu_dpm_set_vcn_enable(smu, true, i);
>                 smu_dpm_set_jpeg_enable(smu, true);
>                 smu_dpm_set_vpe_enable(smu, true);
>                 smu_dpm_set_umsch_mm_enable(smu, true);
> @@ -2030,12 +2039,13 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip=
_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct smu_context *smu =3D adev->powerplay.pp_handle;
> -       int ret;
> +       int i, ret;
>
>         if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>                 return 0;
>
> -       smu_dpm_set_vcn_enable(smu, false);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> +               smu_dpm_set_vcn_enable(smu, false, i);
>         smu_dpm_set_jpeg_enable(smu, false);
>         smu_dpm_set_vpe_enable(smu, false);
>         smu_dpm_set_umsch_mm_enable(smu, false);
> @@ -2949,9 +2959,10 @@ static int smu_read_sensor(void *handle,
>                            int *size_arg)
>  {
>         struct smu_context *smu =3D handle;
> +       struct amdgpu_device *adev =3D smu->adev;
>         struct smu_umd_pstate_table *pstate_table =3D
>                                 &smu->pstate_table;
> -       int ret =3D 0;
> +       int i, ret =3D 0;
>         uint32_t *size, size_val;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> @@ -2997,7 +3008,13 @@ static int smu_read_sensor(void *handle,
>                 *size =3D 4;
>                 break;
>         case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
> -               *(uint32_t *)data =3D atomic_read(&smu->smu_power.power_g=
ate.vcn_gated) ? 0 : 1;
> +               *(uint32_t *)data =3D 0;
> +               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
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
