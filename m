Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E94C25B45
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 21:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF2D10E279;
	Mon, 23 Oct 2023 21:47:32 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A2810E279
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 21:47:30 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1e9fbb7d88eso2846302fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 14:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698097650; x=1698702450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hghwFGK4NuqCLa1e6pzS9+Q2hz467GLO1UHPtHJOtoU=;
 b=KgohYj8H0X41UbugmAcCKVA2Y4iwxXQ0mi0izfy8GpNFK1ONWM4/Uii/un7Lhpm9g+
 Uc1g9kkT/fy6JYTK8jUO/nvmLFV0646ERZe7FVgIzKYnQWv891a/bwOmrqYUchSjWGaX
 Inri5ulZ5o9ncJjhGzHWF6EavET0xQ2/Q0Wtn5Aq/4Jw42anlxrt2bFRoMzAqDaW6O7C
 BzwKNCrpJc8rILLHw4myMbGgW929kN6rx4VtzEgHHxY+8rfzCL09sXyNjw3+UjJqN+He
 vM3wz8PZd33XQ38Bv0LwbTlKOOoAzwR/17j0ObZI+khofgsA3IcuZ9nHVH/N+fRCPqD6
 uyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698097650; x=1698702450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hghwFGK4NuqCLa1e6pzS9+Q2hz467GLO1UHPtHJOtoU=;
 b=SrqLGzymIJFIj5ejCkVW+ZO0DmvN12ZytFwRpm+6a7mmc87EXVEPylfjg98Gr8P0/3
 LmlYSEzjWyUBK/Dg2JFVb2ZEuSGD7ZWJkRGV/iQ0oRqLoTt4zLQdOeOAvcrKqD8euvM9
 /ATCCTSil99sla/X1oGxmqB8CIPtMhvgahke9SfHe0Bo1mmS5hu+IzTT4iZR382ZBKtL
 VaFNAmrN+g21N0aFvIPt0wklQTi/BQguF94ZsW6NyGk4YelaLy34Wl7jqvTlVXIbW72b
 zHpGh/EmH32KnM4v4Yp84r3m8V+ob3lY6O6b+SoDY2iIKZW4tLTD3bbiPnj91v8pHJ8A
 hSYw==
X-Gm-Message-State: AOJu0YylWHFfCEJhLRmIVcaZj+dIHzS+iUO0SAWDMqfZvBlRxfx08wwF
 XD04Bre0hMibb8AF86g3tfMZpMXPzYJCG6nqcqNAoPsR
X-Google-Smtp-Source: AGHT+IF23LFmN5thGTgQuyVb2DukL2wErkk7ty3Ad831pPxdTnPFWEoJuwiaQE+/3iJcbW68+SNXLSvtf66S0mlDmf8=
X-Received: by 2002:a05:6870:8a12:b0:1d0:dc5b:d67 with SMTP id
 p18-20020a0568708a1200b001d0dc5b0d67mr13476123oaq.42.1698097650162; Mon, 23
 Oct 2023 14:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231023205831.511-1-mario.limonciello@amd.com>
 <20231023205831.511-3-mario.limonciello@amd.com>
In-Reply-To: <20231023205831.511-3-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Oct 2023 17:47:19 -0400
Message-ID: <CADnq5_O3-mSWkG+gQO5cVr3bq1bYYTzEH8_qj2qRr_aMJEVq9Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd: Explicitly disable ASPM when dynamic
 switching disabled
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 23, 2023 at 5:12=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Currently there are separate but related checks:
> * amdgpu_device_should_use_aspm()
> * amdgpu_device_aspm_support_quirk()
> * amdgpu_device_pcie_dynamic_switching_supported()
>
> Simplify into checking whether DPM was enabled or not in the auto
> case.  This works because amdgpu_device_pcie_dynamic_switching_supported(=
)
> populates that value.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++---------------
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  7 +++----
>  drivers/gpu/drm/amd/amdgpu/vi.c            |  2 +-
>  4 files changed, 10 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 44df1a5bce7f..c1c98bd2d489 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1339,9 +1339,7 @@ void amdgpu_device_pci_config_reset(struct amdgpu_d=
evice *adev);
>  int amdgpu_device_pci_reset(struct amdgpu_device *adev);
>  bool amdgpu_device_need_post(struct amdgpu_device *adev);
>  bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev);
> -bool amdgpu_device_pcie_dynamic_switching_supported(void);
>  bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
> -bool amdgpu_device_aspm_support_quirk(void);
>
>  void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_by=
tes,
>                                   u64 num_vis_bytes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 4e144be7f044..7ec32b44df05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1456,14 +1456,14 @@ bool amdgpu_device_seamless_boot_supported(struct=
 amdgpu_device *adev)
>  }
>
>  /*
> - * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dyn=
amic
> - * speed switching. Until we have confirmation from Intel that a specifi=
c host
> - * supports it, it's safer that we keep it disabled for all.
> + * Intel hosts such as Rocket Lake, Alder Lake, Raptor Lake and Sapphire=
 Rapids
> + * don't support dynamic speed switching. Until we have confirmation fro=
m Intel
> + * that a specific host supports it, it's safer that we keep it disabled=
 for all.
>   *
>   * https://edc.intel.com/content/www/us/en/design/products/platforms/det=
ails/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/=
005/pci-express-support/
>   * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
>   */
> -bool amdgpu_device_pcie_dynamic_switching_supported(void)
> +static bool amdgpu_device_pcie_dynamic_switching_supported(void)
>  {
>  #if IS_ENABLED(CONFIG_X86)
>         struct cpuinfo_x86 *c =3D &cpu_data(0);
> @@ -1498,20 +1498,11 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_=
device *adev)
>         }
>         if (adev->flags & AMD_IS_APU)
>                 return false;
> +       if (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK))
> +               return false;
>         return pcie_aspm_enabled(adev->pdev);
>  }
>
> -bool amdgpu_device_aspm_support_quirk(void)
> -{
> -#if IS_ENABLED(CONFIG_X86)
> -       struct cpuinfo_x86 *c =3D &cpu_data(0);
> -
> -       return !(c->x86 =3D=3D 6 && c->x86_model =3D=3D INTEL_FAM6_ALDERL=
AKE);
> -#else
> -       return true;
> -#endif
> -}
> -
>  /* if we get transitioned to only one device, take VGA back */
>  /**
>   * amdgpu_device_vga_set_decode - enable/disable vga decode
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 9fa220de1490..4d7976b77767 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -513,7 +513,7 @@ static int nv_set_vce_clocks(struct amdgpu_device *ad=
ev, u32 evclk, u32 ecclk)
>
>  static void nv_program_aspm(struct amdgpu_device *adev)
>  {
> -       if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_s=
upport_quirk())
> +       if (!amdgpu_device_should_use_aspm(adev))
>                 return;
>
>         if (adev->nbio.funcs->program_aspm)
> @@ -608,9 +608,8 @@ static int nv_update_umd_stable_pstate(struct amdgpu_=
device *adev,
>         if (adev->gfx.funcs->update_perfmon_mgcg)
>                 adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
>
> -       if (!(adev->flags & AMD_IS_APU) &&
> -           (adev->nbio.funcs->enable_aspm) &&
> -            amdgpu_device_should_use_aspm(adev))
> +       if (adev->nbio.funcs->enable_aspm &&
> +           amdgpu_device_should_use_aspm(adev))
>                 adev->nbio.funcs->enable_aspm(adev, !enter);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu=
/vi.c
> index 1a08052bade3..1a98812981f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1124,7 +1124,7 @@ static void vi_program_aspm(struct amdgpu_device *a=
dev)
>         bool bL1SS =3D false;
>         bool bClkReqSupport =3D true;
>
> -       if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_pcie_d=
ynamic_switching_supported())
> +       if (!amdgpu_device_should_use_aspm(adev))
>                 return;
>
>         if (adev->asic_type < CHIP_POLARIS10)
> --
> 2.34.1
>
