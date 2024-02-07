Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BB8C4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 22:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA14510E872;
	Wed,  7 Feb 2024 22:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c03/kN5j";
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F2110E7D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 22:34:59 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-2185a9966bcso164979fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Feb 2024 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707345298; x=1707950098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USkOTTOclDpsIN7Bx47ATlw5tDL6ok8I9JqzkCpwGOM=;
 b=c03/kN5jAslF3O56pr2w072mLHTl09oKISXai+DMHfMcLQ7gRY+Sz8z6Q5jQa8GIqv
 Qj95lG/N4c//DaHTp0ViJgZV4sdMzqleut5GGXDw12bVBD62jqlA8ETKQlyFPawE7g67
 uOCWkwOEUHg+61K8tcyaeRgIczJwnwsUnQT81tT0aiW2hKkU2VQ62olwmcxCMKNFomLt
 aejy+AOKqwJymgbUUSpYiGBi0wdS77xALFnGi6+64ICKdCpDxLESIOTNZHgmV9q9LHGQ
 g/3+y/4KeIsO4+eb2OgRnx/WJl3Gnpj1COcjTD8WcbaVWplkWitiDNU0xXRyiu0MqSng
 iZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707345298; x=1707950098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USkOTTOclDpsIN7Bx47ATlw5tDL6ok8I9JqzkCpwGOM=;
 b=Q0LQR1uv2psm3f7YB3FE9Xg9yG8POgl2OJ5lYOfp29Y6bvTxdGfPVKnO9HXimHmkbe
 8dNlEjqg7dQ0sa4pg9wpVeu04zrmi+oVy9wkVmxnhNjcSXDb7Lld7P/1iPu4LAVP+MTS
 iP8A1mLwGnSRmiF+Zp4P9g2KrXrLX6j6kYCOobBwFqWW/sBl7cG7Wy1tLegaAuzAd7tG
 xfzLpFdrsMPOG3KChgZ1FYtZBPY+I1glQ36jNumfOnqQLkaOw+Y4c5KJce47laBQ9u8u
 yluoywC2IkUkIXjas3VdGX+WW26Nxr2sikedlhTKYmA2hUKH68Lo1JK93fLFXMjOZBxe
 HQLg==
X-Gm-Message-State: AOJu0Yxqf1aQTF4iRY4mPg+dA0lfcUAFinDD1BIoyF8QJkvcEGAeax6f
 o1kgumLcyAP0C1d31VkHz4vmh9JC3RW6LF2EDEukmaA/4G7P1BM7zUxvOUhbXSgbdVrgSVaF0rg
 JGh2O9XMX6FasSbo6RCySG1UKBZo=
X-Google-Smtp-Source: AGHT+IEOPteHPexzbnI7NEnyW/hixaLVGyZLJFy5FSBat/3q7pGT4M8GVyLnSNSGjhbPl8PCLdCJhNUGICJGhpPoGcI=
X-Received: by 2002:a05:6870:f114:b0:219:42d3:f1b with SMTP id
 k20-20020a056870f11400b0021942d30f1bmr463221oac.2.1707345298184; Wed, 07 Feb
 2024 14:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20240207204103.82789-1-mario.limonciello@amd.com>
 <20240207204103.82789-2-mario.limonciello@amd.com>
In-Reply-To: <20240207204103.82789-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Feb 2024 17:34:46 -0500
Message-ID: <CADnq5_NZWoO_0tXx74P785H75ZBJph=nF_5XbAqkpBEztK9vSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amd: Stop evicting resources on APUs in suspend
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
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

On Wed, Feb 7, 2024 at 3:48=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() ca=
llback")
> intentionally moved the eviction of resources to earlier in the suspend
> process, but this introduced a subtle change that it occurs before adev->=
in_s0ix
> or adev->in_s3 are set. This meant that APUs actually started to evict
> resources at suspend time as well.
>
> Add a new `in_prepare` flag that is set for the life of the prepare() cal=
lback
> to return the old code flow. Drop the existing call to return 1 in this c=
ase because
> the suspend() callback looks for the flags too.
>
> Also, introduce a new amdgpu_device_freeze() function to call at S4 and e=
vict
> resources in this callback so that APUs will still get resources evicted.
>
> Reported-by: J=C3=BCrg Billeter <j@bitron.ch>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3132#note_2271038
> Fixes: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() ca=
llback")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Add and use new in_prepare member
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 21 ++--------
>  3 files changed, 48 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 5d5be3e20687..f9db09a9017a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1075,7 +1075,8 @@ struct amdgpu_device {
>         u8                              reset_magic[AMDGPU_RESET_MAGIC_NU=
M];
>
>         /* s3/s4 mask */
> -       bool                            in_suspend;
> +       bool                            in_prepare;
> +       bool                            in_suspend;
>         bool                            in_s3;
>         bool                            in_s4;
>         bool                            in_s0ix;
> @@ -1462,6 +1463,7 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *=
adev);
>  int amdgpu_device_prepare(struct drm_device *dev);
>  int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
>  int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
> +int amdgpu_device_freeze(struct drm_device *drm_dev);
>  u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
>  int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
>  void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 2bc460cb993d..0a337fcd89b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4492,7 +4492,7 @@ static int amdgpu_device_evict_resources(struct amd=
gpu_device *adev)
>         int ret;
>
>         /* No need to evict vram on APUs for suspend to ram or s2idle */
> -       if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
> +       if ((adev->in_prepare) && (adev->flags & AMD_IS_APU))

Could probably simplify this to:
if ((!adev->in_s4) && (adev->flags & AMD_IS_APU))

Then you could drop the in_prepare variable.

>                 return 0;
>
>         ret =3D amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
> @@ -4521,10 +4521,12 @@ int amdgpu_device_prepare(struct drm_device *dev)
>         if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>                 return 0;
>
> +       adev->in_prepare =3D true;
> +
>         /* Evict the majority of BOs before starting suspend sequence */
>         r =3D amdgpu_device_evict_resources(adev);
>         if (r)
> -               return r;
> +               goto unprepare;
>
>         for (i =3D 0; i < adev->num_ip_blocks; i++) {
>                 if (!adev->ip_blocks[i].status.valid)
> @@ -4533,10 +4535,46 @@ int amdgpu_device_prepare(struct drm_device *dev)
>                         continue;
>                 r =3D adev->ip_blocks[i].version->funcs->prepare_suspend(=
(void *)adev);
>                 if (r)
> -                       return r;
> +                       goto unprepare;
>         }
>
> -       return 0;
> +unprepare:
> +       adev->in_prepare =3D FALSE;
> +
> +       return r;
> +}
> +
> +/**
> + * amdgpu_device_freeze - run S4 sequence
> + *
> + * @dev: drm dev pointer
> + *
> + * Prepare to put the hw in the S4 state (all asics).
> + * Returns 0 for success or an error on failure.
> + * Called at driver freeze.
> + */
> +int amdgpu_device_freeze(struct drm_device *drm_dev)
> +{
> +       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> +       int r;
> +
> +       adev->in_s4 =3D true;
> +
> +       r =3D amdgpu_device_evict_resources(adev);

Won't this be too late to allocate memory?  Doesn't this need to
happen in prepare() even for S4?

Alex

> +       if (r)
> +               goto cleanup;
> +
> +       r =3D amdgpu_device_suspend(drm_dev, true);
> +       if (r)
> +               goto cleanup;
> +
> +       if (amdgpu_acpi_should_gpu_reset(adev))
> +               r =3D amdgpu_asic_reset(adev);
> +
> +cleanup:
> +       adev->in_s4 =3D false;
> +
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b74f68a15802..fc9caa14c9d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2456,6 +2456,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> +       int r;
>
>         /* Return a positive number here so
>          * DPM_FLAG_SMART_SUSPEND works properly
> @@ -2464,13 +2465,6 @@ static int amdgpu_pmops_prepare(struct device *dev=
)
>             pm_runtime_suspended(dev))
>                 return 1;
>
> -       /* if we will not support s3 or s2i for the device
> -        *  then skip suspend
> -        */
> -       if (!amdgpu_acpi_is_s0ix_active(adev) &&
> -           !amdgpu_acpi_is_s3_active(adev))
> -               return 1;
> -
>         return amdgpu_device_prepare(drm_dev);
>  }
>
> @@ -2488,6 +2482,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
>                 adev->in_s0ix =3D true;
>         else if (amdgpu_acpi_is_s3_active(adev))
>                 adev->in_s3 =3D true;
> +
>         if (!adev->in_s0ix && !adev->in_s3)
>                 return 0;
>         return amdgpu_device_suspend(drm_dev, true);
> @@ -2528,18 +2523,8 @@ static int amdgpu_pmops_resume(struct device *dev)
>  static int amdgpu_pmops_freeze(struct device *dev)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> -       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> -       int r;
> -
> -       adev->in_s4 =3D true;
> -       r =3D amdgpu_device_suspend(drm_dev, true);
> -       adev->in_s4 =3D false;
> -       if (r)
> -               return r;
>
> -       if (amdgpu_acpi_should_gpu_reset(adev))
> -               return amdgpu_asic_reset(adev);
> -       return 0;
> +       return amdgpu_device_freeze(drm_dev);
>  }
>
>  static int amdgpu_pmops_thaw(struct device *dev)
> --
> 2.34.1
>
