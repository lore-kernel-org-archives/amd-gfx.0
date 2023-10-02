Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79666E743C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 16:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C711410E2F0;
	Mon,  2 Oct 2023 16:01:25 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1961510E2E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 16:01:23 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1dce0f9e222so7652665fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Oct 2023 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696262482; x=1696867282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdGgwwh6aHB2XdpPMIDtNb06d4V5P70EUQKuSIkabZ4=;
 b=e7Ys7sm+hYwUf0WmqsDPoFSDS+5OHIrZsvaba4TuBXV+vWrTKflEDdZh2Z69eQLFq4
 jLthlO3P1wYXhQzsgtG+eRWN1O6k6cT4Lc1lpxm5QVXnthTi9Vug7cZ542CzqTOSDF4K
 pBotSScsTEvgw8hFl1fZV5ecaiTJ3QIcE9Y8a2IyfBE7kEDkdLQFb5290Mxqe35eSaRV
 ZYepN2qwUyLX2To/M/EXOUtq9cprI54P3RlfQ4qLWS0T4kDLSJcHea4gR5x8DgD5N8wZ
 4OqYoytiqGHHZhEAPEg4Dqp4UJQjTvmwp51hRFlFNYYOPEOgdHnD9hyp+bLLxfGc8LL3
 Ehzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696262482; x=1696867282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TdGgwwh6aHB2XdpPMIDtNb06d4V5P70EUQKuSIkabZ4=;
 b=St5NraxGcJ7y1xMYoeU6zwqLdxUOii9Tf8gWxtNLQDonOgpSC74c/N90JlqEvHAGBC
 eV7TWF4XHBhvP3M1Ik4rOju6nd7Q7ViIhQfNNcVQk7dUTX3u0j6Y2XS5W+fe1hO6I18D
 47Rh5khkoCSsPdvfEHEouDgGVxNsQMNkX6sFQ5DpsFLXUjFnLZ6+Pd4un8Vooyuk2Frt
 8u7K3ZhcvykNprabng55j/C7QrKnZQW2eLuBz6vo41S0qDD34Kd4DdOhWJFndmhv1XV9
 kTnbYD0wgFMbUI+5ubXKBhz45CsRpUTLZmBV0XlG1OcWZEafHRG+8oo9vhcJX99bp7yi
 UnUg==
X-Gm-Message-State: AOJu0YzHaXFroFMcR4MzFjt9s+wS8ZWoMMWCButESnawkoemkSVYpfKf
 nLfBQvD3S8MJyHCFIadmUMlnJSEe0ThswrnXLudwbC2t
X-Google-Smtp-Source: AGHT+IEV3hUM6CwbaeKE2M8mYj+CMkXeJ7ypi03ETt7/G9l/nZnacumHA/I+urq34oY2Q1qDGhvlXtXQxrnse3DG1lU=
X-Received: by 2002:a05:6870:8196:b0:1c4:ee87:d3f6 with SMTP id
 k22-20020a056870819600b001c4ee87d3f6mr15527317oae.50.1696262480553; Mon, 02
 Oct 2023 09:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230930032254.580-1-mario.limonciello@amd.com>
 <20230930032254.580-2-mario.limonciello@amd.com>
In-Reply-To: <20230930032254.580-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Oct 2023 12:01:09 -0400
Message-ID: <CADnq5_MkBBGoTfeqP7NW2X4_J3BmhKJHGzcPVhS2pens=PVfpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd: Drop all hand-built MIN and MAX macros in
 the amdgpu base driver
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Sep 30, 2023 at 3:01=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Several files declare MIN() or MAX() macros that ignore the types of the
> values being compared.  Drop these macros and switch to min() min_t(),
> and max() from `linux/minmax.h`.
>
> Suggested-by: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                    |  2 --
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c             |  2 +-
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c  |  4 ++--
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c    |  4 ++--
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c    |  4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c      |  4 ++--
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++------
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c         |  4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c         |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  7 +++----
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  7 +++----
>  11 files changed, 22 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 73e825d20259..d23fb4b5ad95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1329,8 +1329,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>         for (i =3D ffs(inst_mask); i-- !=3D 0; \
>              i =3D ffs(inst_mask & BIT_MASK_UPPER(i + 1)))
>
> -#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
> -
>  /* Common functions */
>  bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
>  bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index 02e69ccff3ba..fc8e4ac6c8e7 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -6600,7 +6600,7 @@ static int si_dpm_get_fan_speed_pwm(void *handle,
>
>         tmp64 =3D (u64)duty * 255;
>         do_div(tmp64, duty100);
> -       *speed =3D MIN((u32)tmp64, 255);
> +       *speed =3D min_t(u32, tmp64, 255);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> index a6c3610db23e..a8fc0fa44db6 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> @@ -72,7 +72,7 @@ int smu7_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hw=
mgr,
>
>         tmp64 =3D (uint64_t)duty * 255;
>         do_div(tmp64, duty100);
> -       *speed =3D MIN((uint32_t)tmp64, 255);
> +       *speed =3D min_t(uint32_t, tmp64, 255);
>
>         return 0;
>  }
> @@ -210,7 +210,7 @@ int smu7_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr *=
hwmgr,
>         if (hwmgr->thermal_controller.fanInfo.bNoFan)
>                 return 0;
>
> -       speed =3D MIN(speed, 255);
> +       speed =3D min_t(uint32_t, speed, 255);
>
>         if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
>                 smu7_fan_ctrl_stop_smc_fan_control(hwmgr);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> index 190af79f3236..379012494da5 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> @@ -81,7 +81,7 @@ int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *=
hwmgr,
>
>         tmp64 =3D (uint64_t)duty * 255;
>         do_div(tmp64, duty100);
> -       *speed =3D MIN((uint32_t)tmp64, 255);
> +       *speed =3D min_t(uint32_t, tmp64, 255);
>
>         return 0;
>  }
> @@ -255,7 +255,7 @@ int vega10_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr=
 *hwmgr,
>         if (hwmgr->thermal_controller.fanInfo.bNoFan)
>                 return 0;
>
> -       speed =3D MIN(speed, 255);
> +       speed =3D min_t(uint32_t, speed, 255);
>
>         if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
>                 vega10_fan_ctrl_stop_smc_fan_control(hwmgr);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> index e9737ca8418a..a3331ffb2daf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> @@ -131,7 +131,7 @@ int vega20_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr=
 *hwmgr,
>
>         tmp64 =3D (uint64_t)duty * 255;
>         do_div(tmp64, duty100);
> -       *speed =3D MIN((uint32_t)tmp64, 255);
> +       *speed =3D min_t(uint32_t, tmp64, 255);
>
>         return 0;
>  }
> @@ -144,7 +144,7 @@ int vega20_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr=
 *hwmgr,
>         uint32_t duty;
>         uint64_t tmp64;
>
> -       speed =3D MIN(speed, 255);
> +       speed =3D min_t(uint32_t, speed, 255);
>
>         if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
>                 vega20_fan_ctrl_stop_smc_fan_control(hwmgr);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 6e2e665ad383..a2bbc180b160 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1203,7 +1203,7 @@ static int arcturus_set_fan_speed_pwm(struct smu_co=
ntext *smu,
>         uint32_t duty100, duty;
>         uint64_t tmp64;
>
> -       speed =3D MIN(speed, 255);
> +       speed =3D min_t(uint32_t, speed, 255);
>
>         duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1_ARC=
T),
>                                 CG_FDO_CTRL1, FMAX_DUTY100);
> @@ -1267,7 +1267,7 @@ static int arcturus_get_fan_speed_pwm(struct smu_co=
ntext *smu,
>         if (duty100) {
>                 tmp64 =3D (uint64_t)duty * 255;
>                 do_div(tmp64, duty100);
> -               *speed =3D MIN((uint32_t)tmp64, 255);
> +               *speed =3D min_t(uint32_t, tmp64, 255);
>         } else {
>                 *speed =3D 0;
>         }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index dd07662262e4..ad2884088e69 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2089,8 +2089,6 @@ static int sienna_cichlid_display_disable_memory_cl=
ock_switch(struct smu_context
>         return ret;
>  }
>
> -#define MAX(a, b)      ((a) > (b) ? (a) : (b))
> -
>  static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu=
,
>                                                  uint8_t pcie_gen_cap,
>                                                  uint8_t pcie_width_cap)
> @@ -2106,12 +2104,12 @@ static int sienna_cichlid_update_pcie_parameters(=
struct smu_context *smu,
>         GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
>         GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
>
> -       min_gen_speed =3D MAX(0, table_member1[0]);
> -       max_gen_speed =3D MIN(pcie_gen_cap, table_member1[1]);
> +       min_gen_speed =3D max_t(uint8_t, 0, table_member1[0]);
> +       max_gen_speed =3D min(pcie_gen_cap, table_member1[1]);
>         min_gen_speed =3D min_gen_speed > max_gen_speed ?
>                         max_gen_speed : min_gen_speed;
> -       min_lane_width =3D MAX(1, table_member2[0]);
> -       max_lane_width =3D MIN(pcie_width_cap, table_member2[1]);
> +       min_lane_width =3D max_t(uint8_t, 1, table_member2[0]);
> +       max_lane_width =3D min(pcie_width_cap, table_member2[1]);
>         min_lane_width =3D min_lane_width > max_lane_width ?
>                          max_lane_width : min_lane_width;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index ece43b41141c..5a314d0316c1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1174,7 +1174,7 @@ smu_v11_0_set_fan_speed_pwm(struct smu_context *smu=
, uint32_t speed)
>         uint32_t duty100, duty;
>         uint64_t tmp64;
>
> -       speed =3D MIN(speed, 255);
> +       speed =3D min_t(uint32_t, speed, 255);
>
>         duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
>                                 CG_FDO_CTRL1, FMAX_DUTY100);
> @@ -1249,7 +1249,7 @@ int smu_v11_0_get_fan_speed_pwm(struct smu_context =
*smu,
>
>         tmp64 =3D (uint64_t)duty * 255;
>         do_div(tmp64, duty100);
> -       *speed =3D MIN((uint32_t)tmp64, 255);
> +       *speed =3D min_t(uint32_t, tmp64, 255);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 208db8b580eb..8dc683c02a7d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1169,7 +1169,7 @@ int smu_v13_0_set_fan_speed_pwm(struct smu_context =
*smu,
>         uint32_t duty100, duty;
>         uint64_t tmp64;
>
> -       speed =3D MIN(speed, 255);
> +       speed =3D min_t(uint32_t, speed, 255);
>
>         if (smu_v13_0_auto_fan_control(smu, 0))
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 1c15fa911176..a52da7bc787b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1998,7 +1998,6 @@ static int smu_v13_0_0_get_thermal_temperature_rang=
e(struct smu_context *smu,
>         return 0;
>  }
>
> -#define MAX(a, b)      ((a) > (b) ? (a) : (b))
>  static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
>                                            void **table)
>  {
> @@ -2022,12 +2021,12 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct=
 smu_context *smu,
>         gpu_metrics->temperature_mem =3D metrics->AvgTemperature[TEMP_MEM=
];
>         gpu_metrics->temperature_vrgfx =3D metrics->AvgTemperature[TEMP_V=
R_GFX];
>         gpu_metrics->temperature_vrsoc =3D metrics->AvgTemperature[TEMP_V=
R_SOC];
> -       gpu_metrics->temperature_vrmem =3D MAX(metrics->AvgTemperature[TE=
MP_VR_MEM0],
> +       gpu_metrics->temperature_vrmem =3D max(metrics->AvgTemperature[TE=
MP_VR_MEM0],
>                                              metrics->AvgTemperature[TEMP=
_VR_MEM1]);
>
>         gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivity=
;
>         gpu_metrics->average_umc_activity =3D metrics->AverageUclkActivit=
y;
> -       gpu_metrics->average_mm_activity =3D MAX(metrics->Vcn0ActivityPer=
centage,
> +       gpu_metrics->average_mm_activity =3D max(metrics->Vcn0ActivityPer=
centage,
>                                                metrics->Vcn1ActivityPerce=
ntage);
>
>         gpu_metrics->average_socket_power =3D metrics->AverageSocketPower=
;
> @@ -2286,7 +2285,7 @@ static int smu_v13_0_0_get_fan_speed_pwm(struct smu=
_context *smu,
>         }
>
>         /* Convert the PMFW output which is in percent to pwm(255) based =
*/
> -       *speed =3D MIN(*speed * 255 / 100, 255);
> +       *speed =3D min(*speed * 255 / 100, (uint32_t)255);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 430ad1b05ba3..b8a7a1d853df 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1946,7 +1946,6 @@ static int smu_v13_0_7_get_thermal_temperature_rang=
e(struct smu_context *smu,
>         return 0;
>  }
>
> -#define MAX(a, b)      ((a) > (b) ? (a) : (b))
>  static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
>                                            void **table)
>  {
> @@ -1970,12 +1969,12 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct=
 smu_context *smu,
>         gpu_metrics->temperature_mem =3D metrics->AvgTemperature[TEMP_MEM=
];
>         gpu_metrics->temperature_vrgfx =3D metrics->AvgTemperature[TEMP_V=
R_GFX];
>         gpu_metrics->temperature_vrsoc =3D metrics->AvgTemperature[TEMP_V=
R_SOC];
> -       gpu_metrics->temperature_vrmem =3D MAX(metrics->AvgTemperature[TE=
MP_VR_MEM0],
> +       gpu_metrics->temperature_vrmem =3D max(metrics->AvgTemperature[TE=
MP_VR_MEM0],
>                                              metrics->AvgTemperature[TEMP=
_VR_MEM1]);
>
>         gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivity=
;
>         gpu_metrics->average_umc_activity =3D metrics->AverageUclkActivit=
y;
> -       gpu_metrics->average_mm_activity =3D MAX(metrics->Vcn0ActivityPer=
centage,
> +       gpu_metrics->average_mm_activity =3D max(metrics->Vcn0ActivityPer=
centage,
>                                                metrics->Vcn1ActivityPerce=
ntage);
>
>         gpu_metrics->average_socket_power =3D metrics->AverageSocketPower=
;
> @@ -2210,7 +2209,7 @@ static int smu_v13_0_7_get_fan_speed_pwm(struct smu=
_context *smu,
>         }
>
>         /* Convert the PMFW output which is in percent to pwm(255) based =
*/
> -       *speed =3D MIN(*speed * 255 / 100, 255);
> +       *speed =3D min(*speed * 255 / 100, (uint32_t)255);
>
>         return 0;
>  }
> --
> 2.34.1
>
