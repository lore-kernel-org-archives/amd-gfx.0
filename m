Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4500EC77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BA510EA1E;
	Fri, 27 Jun 2025 14:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="le2puY30";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C665410EA1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:44:29 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b34abba1e9dso125352a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751035469; x=1751640269; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hX+YDXwV3KO1ar2oN+5amXK2VmVUkreWf9XJ63AtXBE=;
 b=le2puY30HVEdWyligMffd9kcdFdw7LctdovnVPek8IhETKOb/2bcXjyhph/R61i7NH
 F3XrtcBagkOhJ3awGv9mvCgyy5++lcEBcW5i0bFQctQK4F9MbSyv0fAFvUoE88v88rRW
 GjC1OaOX79XCCOvwmbdMsJX0xnJPrcq/4lXtVAz6nwIdNbxHuB38G9BQj8MxBod/Tvf1
 MzaGbtPtuKFVvw1yEa7bSM/WiD644SMPiIjUqbbVoWHSna2bs+ubY0THZ44zW9CEJxa5
 20I80hLTIrkyTjwYeWKIbOrCSbymDwzm00m6uiNIoWNEhZmAj7BSEHUMw+GrY0FGvLfn
 ruyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751035469; x=1751640269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hX+YDXwV3KO1ar2oN+5amXK2VmVUkreWf9XJ63AtXBE=;
 b=VamTr2fejDk/B5tNaqF9N3omcisjK9N3hmarZdWde8tqKYTUd8kHsRmgiN6Melxt9d
 SopBJCDrA0Vsx5OqxkAl0VCidmRMumvgJ8XSEd2BwIHQuNFKV1WdO3xcSi/B4dRJy832
 2j8h44bGUEkiGLMV2zckRaHHlB9qPWXd1M66RqFsIbvuRFvuAFjNuJoA66Jp/1gKV4Gn
 F/G2l0nTvMw52L3YIA7AQG+mMhlunGMNpyoNgoaY1lzbdGfPXngc6m2ZgYAtbgzO4/OH
 aQJRYSx13ZQ16WimlObRsminuBSFtJfjcy5/Hn0RE9wn2fqnwHr+yumaUacqZIIDs7JW
 TVqQ==
X-Gm-Message-State: AOJu0Yyevn8Vd/f1uQ1COUNgAhvcHhciP3/CwYjXmf/HWqjWDICobFXB
 +tQKTZD4dTcPtERV/Mb0wobnXiZhGm4t/hg4xZCR7aissboJCVJ+GLq6gI/uPLBdwws1/2bc21J
 Y+pYsiCiVeaqELsGkdD1jhpR3iFaVMC4=
X-Gm-Gg: ASbGncstXV6FNCnMvUWJi8IyKRF5EPT0dZ5hKhnAcLmzyszV/5AXuABlVLvduuF5mqJ
 1smYlABbcX3OsJFOQOcstXjyOyZf8nmjvqCH/nuXvI70CJn+f8n0WFdL28rud6shwqzKAovzFD8
 76h0uik+gKZMoRHv1CtL7wl+8TG0i1+XiU85llZZY4ZaKN
X-Google-Smtp-Source: AGHT+IGV0NiCkkjkEM2Lk3/LViWKAKTLffu+pBFp0yQP9TorwZukfBFtMIiAl6nrMEbuy0gOw3HJSvcwm110GX/4idg=
X-Received: by 2002:a17:90b:35c5:b0:313:151a:8653 with SMTP id
 98e67ed59e1d1-318c92bbba1mr1961406a91.8.1751035467650; Fri, 27 Jun 2025
 07:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250627143432.3222843-1-superm1@kernel.org>
 <20250627143432.3222843-3-superm1@kernel.org>
In-Reply-To: <20250627143432.3222843-3-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 27 Jun 2025 10:44:15 -0400
X-Gm-Features: Ac12FXzmxkq5iGh23uSYIkynXXmlPizSL6-mPKxe5QIvwI14U5ZRHqSkXPq5kXk
Message-ID: <CADnq5_PpC_ghVY+EdZamYhvbHGGYJHWq9WoD475h8jSf6iqtew@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/amd: Change kv-dpm DRM_*() macros to drm_*()
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Jun 27, 2025 at 10:43=E2=80=AFAM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> drm_*() macros can show the device a message came from.
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 56 +++++++++++-----------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/kv_dpm.c
> index 5d0b18062b8c1..307ebf7e32267 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -1242,7 +1242,7 @@ static void kv_dpm_enable_bapm(void *handle, bool e=
nable)
>         if (pi->bapm_enable) {
>                 ret =3D amdgpu_kv_smc_bapm_enable(adev, enable);
>                 if (ret)
> -                       DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
> +                       drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_en=
able failed\n");
>         }
>  }
>
> @@ -1266,40 +1266,40 @@ static int kv_dpm_enable(struct amdgpu_device *ad=
ev)
>
>         ret =3D kv_process_firmware_header(adev);
>         if (ret) {
> -               DRM_ERROR("kv_process_firmware_header failed\n");
> +               drm_err(adev_to_drm(adev), "kv_process_firmware_header fa=
iled\n");
>                 return ret;
>         }
>         kv_init_fps_limits(adev);
>         kv_init_graphics_levels(adev);
>         ret =3D kv_program_bootup_state(adev);
>         if (ret) {
> -               DRM_ERROR("kv_program_bootup_state failed\n");
> +               drm_err(adev_to_drm(adev), "kv_program_bootup_state faile=
d\n");
>                 return ret;
>         }
>         kv_calculate_dfs_bypass_settings(adev);
>         ret =3D kv_upload_dpm_settings(adev);
>         if (ret) {
> -               DRM_ERROR("kv_upload_dpm_settings failed\n");
> +               drm_err(adev_to_drm(adev), "kv_upload_dpm_settings failed=
\n");
>                 return ret;
>         }
>         ret =3D kv_populate_uvd_table(adev);
>         if (ret) {
> -               DRM_ERROR("kv_populate_uvd_table failed\n");
> +               drm_err(adev_to_drm(adev), "kv_populate_uvd_table failed\=
n");
>                 return ret;
>         }
>         ret =3D kv_populate_vce_table(adev);
>         if (ret) {
> -               DRM_ERROR("kv_populate_vce_table failed\n");
> +               drm_err(adev_to_drm(adev), "kv_populate_vce_table failed\=
n");
>                 return ret;
>         }
>         ret =3D kv_populate_samu_table(adev);
>         if (ret) {
> -               DRM_ERROR("kv_populate_samu_table failed\n");
> +               drm_err(adev_to_drm(adev), "kv_populate_samu_table failed=
\n");
>                 return ret;
>         }
>         ret =3D kv_populate_acp_table(adev);
>         if (ret) {
> -               DRM_ERROR("kv_populate_acp_table failed\n");
> +               drm_err(adev_to_drm(adev), "kv_populate_acp_table failed\=
n");
>                 return ret;
>         }
>         kv_program_vc(adev);
> @@ -1310,39 +1310,39 @@ static int kv_dpm_enable(struct amdgpu_device *ad=
ev)
>         if (pi->enable_auto_thermal_throttling) {
>                 ret =3D kv_enable_auto_thermal_throttling(adev);
>                 if (ret) {
> -                       DRM_ERROR("kv_enable_auto_thermal_throttling fail=
ed\n");
> +                       drm_err(adev_to_drm(adev), "kv_enable_auto_therma=
l_throttling failed\n");
>                         return ret;
>                 }
>         }
>         ret =3D kv_enable_dpm_voltage_scaling(adev);
>         if (ret) {
> -               DRM_ERROR("kv_enable_dpm_voltage_scaling failed\n");
> +               drm_err(adev_to_drm(adev), "kv_enable_dpm_voltage_scaling=
 failed\n");
>                 return ret;
>         }
>         ret =3D kv_set_dpm_interval(adev);
>         if (ret) {
> -               DRM_ERROR("kv_set_dpm_interval failed\n");
> +               drm_err(adev_to_drm(adev), "kv_set_dpm_interval failed\n"=
);
>                 return ret;
>         }
>         ret =3D kv_set_dpm_boot_state(adev);
>         if (ret) {
> -               DRM_ERROR("kv_set_dpm_boot_state failed\n");
> +               drm_err(adev_to_drm(adev), "kv_set_dpm_boot_state failed\=
n");
>                 return ret;
>         }
>         ret =3D kv_enable_ulv(adev, true);
>         if (ret) {
> -               DRM_ERROR("kv_enable_ulv failed\n");
> +               drm_err(adev_to_drm(adev), "kv_enable_ulv failed\n");
>                 return ret;
>         }
>         kv_start_dpm(adev);
>         ret =3D kv_enable_didt(adev, true);
>         if (ret) {
> -               DRM_ERROR("kv_enable_didt failed\n");
> +               drm_err(adev_to_drm(adev), "kv_enable_didt failed\n");
>                 return ret;
>         }
>         ret =3D kv_enable_smc_cac(adev, true);
>         if (ret) {
> -               DRM_ERROR("kv_enable_smc_cac failed\n");
> +               drm_err(adev_to_drm(adev), "kv_enable_smc_cac failed\n");
>                 return ret;
>         }
>
> @@ -1350,7 +1350,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev=
)
>
>         ret =3D amdgpu_kv_smc_bapm_enable(adev, false);
>         if (ret) {
> -               DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
> +               drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable fai=
led\n");
>                 return ret;
>         }
>
> @@ -1358,7 +1358,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev=
)
>             kv_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
>                 ret =3D kv_set_thermal_temperature_range(adev, KV_TEMP_RA=
NGE_MIN, KV_TEMP_RANGE_MAX);
>                 if (ret) {
> -                       DRM_ERROR("kv_set_thermal_temperature_range faile=
d\n");
> +                       drm_err(adev_to_drm(adev), "kv_set_thermal_temper=
ature_range failed\n");
>                         return ret;
>                 }
>                 amdgpu_irq_get(adev, &adev->pm.dpm.thermal.irq,
> @@ -1382,7 +1382,7 @@ static void kv_dpm_disable(struct amdgpu_device *ad=
ev)
>
>         err =3D amdgpu_kv_smc_bapm_enable(adev, false);
>         if (err)
> -               DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
> +               drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable fai=
led\n");
>
>         if (adev->asic_type =3D=3D CHIP_MULLINS)
>                 kv_enable_nb_dpm(adev, false);
> @@ -1920,7 +1920,7 @@ static int kv_dpm_set_power_state(void *handle)
>         if (pi->bapm_enable) {
>                 ret =3D amdgpu_kv_smc_bapm_enable(adev, adev->pm.ac_power=
);
>                 if (ret) {
> -                       DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
> +                       drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_en=
able failed\n");
>                         return ret;
>                 }
>         }
> @@ -1931,7 +1931,7 @@ static int kv_dpm_set_power_state(void *handle)
>                         kv_update_dfs_bypass_settings(adev, new_ps);
>                         ret =3D kv_calculate_ds_divider(adev);
>                         if (ret) {
> -                               DRM_ERROR("kv_calculate_ds_divider failed=
\n");
> +                               drm_err(adev_to_drm(adev), "kv_calculate_=
ds_divider failed\n");
>                                 return ret;
>                         }
>                         kv_calculate_nbps_level_settings(adev);
> @@ -1947,7 +1947,7 @@ static int kv_dpm_set_power_state(void *handle)
>
>                         ret =3D kv_update_vce_dpm(adev, new_ps, old_ps);
>                         if (ret) {
> -                               DRM_ERROR("kv_update_vce_dpm failed\n");
> +                               drm_err(adev_to_drm(adev), "kv_update_vce=
_dpm failed\n");
>                                 return ret;
>                         }
>                         kv_update_sclk_t(adev);
> @@ -1960,7 +1960,7 @@ static int kv_dpm_set_power_state(void *handle)
>                         kv_update_dfs_bypass_settings(adev, new_ps);
>                         ret =3D kv_calculate_ds_divider(adev);
>                         if (ret) {
> -                               DRM_ERROR("kv_calculate_ds_divider failed=
\n");
> +                               drm_err(adev_to_drm(adev), "kv_calculate_=
ds_divider failed\n");
>                                 return ret;
>                         }
>                         kv_calculate_nbps_level_settings(adev);
> @@ -1972,7 +1972,7 @@ static int kv_dpm_set_power_state(void *handle)
>                         kv_set_enabled_levels(adev);
>                         ret =3D kv_update_vce_dpm(adev, new_ps, old_ps);
>                         if (ret) {
> -                               DRM_ERROR("kv_update_vce_dpm failed\n");
> +                               drm_err(adev_to_drm(adev), "kv_update_vce=
_dpm failed\n");
>                                 return ret;
>                         }
>                         kv_update_acp_boot_level(adev);
> @@ -2521,7 +2521,7 @@ static int kv_set_thermal_temperature_range(struct =
amdgpu_device *adev,
>         if (high_temp > max_temp)
>                 high_temp =3D max_temp;
>         if (high_temp < low_temp) {
> -               DRM_ERROR("invalid thermal range: %d - %d\n", low_temp, h=
igh_temp);
> +               drm_err(adev_to_drm(adev), "invalid thermal range: %d - %=
d\n", low_temp, high_temp);
>                 return -EINVAL;
>         }
>
> @@ -2563,7 +2563,7 @@ static int kv_parse_sys_info_table(struct amdgpu_de=
vice *adev)
>                                               data_offset);
>
>                 if (crev !=3D 8) {
> -                       DRM_ERROR("Unsupported IGP table: %d %d\n", frev,=
 crev);
> +                       drm_err(adev_to_drm(adev), "Unsupported IGP table=
: %d %d\n", frev, crev);
>                         return -EINVAL;
>                 }
>                 pi->sys_info.bootup_sclk =3D le32_to_cpu(igp_info->info_8=
.ulBootUpEngineClock);
> @@ -2579,7 +2579,7 @@ static int kv_parse_sys_info_table(struct amdgpu_de=
vice *adev)
>                 else
>                         pi->sys_info.htc_hyst_lmt =3D igp_info->info_8.uc=
HtcHystLmt;
>                 if (pi->sys_info.htc_tmp_lmt <=3D pi->sys_info.htc_hyst_l=
mt) {
> -                       DRM_ERROR("The htcTmpLmt should be larger than ht=
cHystLmt.\n");
> +                       drm_err(adev_to_drm(adev), "The htcTmpLmt should =
be larger than htcHystLmt.\n");
>                 }
>
>                 if (le32_to_cpu(igp_info->info_8.ulSystemConfig) & (1 << =
3))
> @@ -3015,13 +3015,13 @@ static int kv_dpm_sw_init(struct amdgpu_ip_block =
*ip_block)
>         adev->pm.dpm.current_ps =3D adev->pm.dpm.requested_ps =3D adev->p=
m.dpm.boot_ps;
>         if (amdgpu_dpm =3D=3D 1)
>                 amdgpu_pm_print_power_states(adev);
> -       DRM_INFO("amdgpu: dpm initialized\n");
> +       drm_info(adev_to_drm(adev), "dpm initialized\n");
>
>         return 0;
>
>  dpm_failed:
>         kv_dpm_fini(adev);
> -       DRM_ERROR("amdgpu: dpm initialization failed\n");
> +       drm_err(adev_to_drm(adev), "dpm initialization failed: %d\n", ret=
);
>         return ret;
>  }
>
> --
> 2.43.0
>
