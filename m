Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B63E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 14:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F9410E265;
	Mon,  9 Oct 2023 14:37:21 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F281710E279
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 14:37:20 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1dcdfeb7e44so3214128fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696862240; x=1697467040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQSGvADq4J2YDbl/vUPGWDXHHN4Lh3fGLmNS7bmI8cE=;
 b=RCWt5yTiacY1hu8HRlljYIOpTbg0NpLajQhGF1lfgHoVFHy+VYEzA+nKbbpKDqw8Xv
 lredu3iBqWdf1ptpibIZUWau04XkPRhMRLdZ96K5C1PX5sETmlNAL4ZwjQQZwh7BTF3+
 N25Tj2C+C24OeT8p0aQsauRDHymnt3luRm/3tMQq9cp+zLq8+NyuXQJ32kXqhnhNlacn
 JoSmKDMmut6QW7mQ8p7l4O5OcLqMlxQmZCv15XRsohQxiyIAHtsknfrvQBKSN/7/WwAg
 PlxpZUrLJQ6ef8lbzVRhai9CBAmPrYxP3MjuXO0dWf6y0H1lYRnhJG3pElz9MJJzOZcR
 LGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862240; x=1697467040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQSGvADq4J2YDbl/vUPGWDXHHN4Lh3fGLmNS7bmI8cE=;
 b=CSNtRpn7lz6pyKDWwMw34cfpFobDqiO9fRMiYIvj2AVhzZSPdS187dVSoIHABKlbMz
 QL+mehiF81SBZ0VG/QitSVauooMwdVhtuuaoBmggjYwlabFxvmLnaRc3QnDwRPiC27+F
 GTq2ceKdj9ZjwpXFqKs2A4WFeqkV8JOZF/EIN1nVjGsu7alI7xLsHWm3Xve0Kw+ggbnx
 RetmbR5qMlXtJf9vmv0yNBkmNO9zbk0ZE+FhlTodgeiaTGCZ5zSqVUyPnvOIUjA6xmdW
 CMbfxjv5oJaelxpSjB5oI/+BMP9tSuCOFgFH5g5J7Gjd3EhkmQsEIsS6Fczf78NiSgdd
 qL3Q==
X-Gm-Message-State: AOJu0YzTGiU0mh9kXA86kQkMrje+QjldE4zXoh+0I2TbBNIe1aeG8NuP
 fFp43tEo4xvL+senBFE88nXDThAXuZX0VrDW0fQ=
X-Google-Smtp-Source: AGHT+IFbDvsQVvOoVylFX/vsH03M6IoxijYlzp04j+HS7xn994u+ZUu6rVkfC2g9dCVO1FZSw8PZ5MhDa5qOsnOWhgQ=
X-Received: by 2002:a05:6870:e390:b0:1d6:567b:79aa with SMTP id
 x16-20020a056870e39000b001d6567b79aamr17756147oad.56.1696862240117; Mon, 09
 Oct 2023 07:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231006185026.5536-1-mario.limonciello@amd.com>
 <20231006185026.5536-2-mario.limonciello@amd.com>
In-Reply-To: <20231006185026.5536-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Oct 2023 10:37:09 -0400
Message-ID: <CADnq5_PjZGbBh+XCSMarxMtpHNGDDL0wSBeoQCDO86qP5GsEfw@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] drm/amd: Evict resources during PM ops prepare()
 callback
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
Cc: Harry.Wentland@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 6, 2023 at 3:17=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Linux PM core has a prepare() callback run before suspend.
>
> If the system is under high memory pressure, the resources may need
> to be evicted into swap instead.  If the storage backing for swap
> is offlined during the suspend() step then such a call may fail.
>
> So move this step into prepare() to move evict majority of
> resources and update all non-pmops callers to call the same callback.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v4->v5:
>  * Call amdgpu_device_prepare() from other callers to amdgpu_device_suspe=
nd()
>  * 3x evict calls -> 2x evict calls
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 10 ++++---
>  3 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 4cc78e0e4304..fdb2e9ae13e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1409,6 +1409,7 @@ void amdgpu_driver_postclose_kms(struct drm_device =
*dev,
>  void amdgpu_driver_release_kms(struct drm_device *dev);
>
>  int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
> +int amdgpu_device_prepare(struct drm_device *dev);
>  int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
>  int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
>  u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 0cb702c3046a..cb334dc57c59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1760,6 +1760,7 @@ static void amdgpu_switcheroo_set_state(struct pci_=
dev *pdev,
>         } else {
>                 pr_info("switched off\n");
>                 dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
> +               amdgpu_device_prepare(dev);
>                 amdgpu_device_suspend(dev, true);
>                 amdgpu_device_cache_pci_state(pdev);
>                 /* Shut down the device */
> @@ -4335,6 +4336,31 @@ static int amdgpu_device_evict_resources(struct am=
dgpu_device *adev)
>  /*
>   * Suspend & resume.
>   */
> +/**
> + * amdgpu_device_prepare - prepare for device suspend
> + *
> + * @dev: drm dev pointer
> + *
> + * Prepare to put the hw in the suspend state (all asics).
> + * Returns 0 for success or an error on failure.
> + * Called at driver suspend.
> + */
> +int amdgpu_device_prepare(struct drm_device *dev)
> +{
> +       struct amdgpu_device *adev =3D drm_to_adev(dev);
> +       int r;
> +
> +       if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
> +               return 0;
> +
> +       /* Evict the majority of BOs before starting suspend sequence */
> +       r =3D amdgpu_device_evict_resources(adev);
> +       if (r)
> +               return r;
> +
> +       return 0;
> +}
> +
>  /**
>   * amdgpu_device_suspend - initiate device suspend
>   *
> @@ -4355,11 +4381,6 @@ int amdgpu_device_suspend(struct drm_device *dev, =
bool fbcon)
>
>         adev->in_suspend =3D true;
>
> -       /* Evict the majority of BOs before grabbing the full access */
> -       r =3D amdgpu_device_evict_resources(adev);
> -       if (r)
> -               return r;
> -
>         if (amdgpu_sriov_vf(adev)) {
>                 amdgpu_virt_fini_data_exchange(adev);
>                 r =3D amdgpu_virt_request_full_gpu(adev, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 81affdf7c0c3..420196a17e22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2427,8 +2427,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
>         /* Return a positive number here so
>          * DPM_FLAG_SMART_SUSPEND works properly
>          */
> -       if (amdgpu_device_supports_boco(drm_dev))
> -               return pm_runtime_suspended(dev);
> +       if (amdgpu_device_supports_boco(drm_dev) &&
> +           pm_runtime_suspended(dev))
> +               return 1;
>
>         /* if we will not support s3 or s2i for the device
>          *  then skip suspend
> @@ -2437,7 +2438,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
>             !amdgpu_acpi_is_s3_active(adev))
>                 return 1;
>
> -       return 0;
> +       return amdgpu_device_prepare(drm_dev);
>  }
>
>  static void amdgpu_pmops_complete(struct device *dev)
> @@ -2637,6 +2638,9 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)
>         if (amdgpu_device_supports_boco(drm_dev))
>                 adev->mp1_state =3D PP_MP1_STATE_UNLOAD;
>
> +       ret =3D amdgpu_device_prepare(drm_dev);
> +       if (ret)
> +               return ret;
>         ret =3D amdgpu_device_suspend(drm_dev, false);
>         if (ret) {
>                 adev->in_runpm =3D false;
> --
> 2.34.1
>
