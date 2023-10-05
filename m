Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B9CE92702
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 14:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4966110E3EC;
	Thu,  5 Oct 2023 14:14:04 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8529110E3EC
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 14:14:02 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1dceaa7aeffso1117543fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Oct 2023 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696515241; x=1697120041; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74Q5Vjbk3jIoIZXhuxW3Z463biHzZsIgNkgaSVqqIs4=;
 b=YtKW1K04+TfUnO/ufqO3h87nm9uejAKauAJmppN3lWqJH7RlASzD4ht3qeHYdiCxpr
 Ra0V7miHFeJE2JsOiE18DVqqnpGqwc28J9tEB6C9TJcN9w4IOesokjP/MVkAi2zv2qht
 HRNQT+XcHmCHlhhzXeFsZKZJkeEAFa5fZFZKURuHMNbQ1ET74YL6lcFkKJM/8KqzC6C3
 8U7ElASGwEJTaZgmkSlNa0lHgJ45IDo9/KddetV7wggcRfE9GPZCKGJ4hXVd9qu1YLBz
 YgV3JahP+Y1qu0JVXr/ef/u7N3WbAJvTLnnCbRQcDCImDK3PrhQ6iJWhUr3w9eX+tXms
 uDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696515241; x=1697120041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74Q5Vjbk3jIoIZXhuxW3Z463biHzZsIgNkgaSVqqIs4=;
 b=E8gquNf6EgrYOzORv5ecCRAqMrw0XLShOfArbvD3Z12Uq1rYlaffVoOtKPJw3kl3i/
 HrQGQlIC+uezgBjxwI4vaJm/MyhDYvyAgzAzkDq7ennv4ink9hq8WoGRdVO++dFCNyE7
 wtTFKgsjHnhSOv7Vk8ex1xGnrTx7AFnBc7yMH3sqH36iZecsFLe9BuP6EvPgsfTTnI3N
 D8iQxo+MfSFV3nc1rq4/2pGePgmot1852vKZGldzArlapmcsX24U7WzUUSlcBTYK/EwH
 4a13e16+TtpyMq7joJz0I7UPe352qEGkpnlwQ0AEuhnqRXGL6LfrLZ8wLAFeVrdAwh9l
 Ct8A==
X-Gm-Message-State: AOJu0Yw159Eo4honKzt3TgYoBZssMM8UvBhDvMK+GjAO9JgFnAKfB2EK
 s6Jw9IzFLOQU2JS3GL9+OZnQa878BrXyxxvJIfw=
X-Google-Smtp-Source: AGHT+IHBmtjwAPoyDG+54+Lg9TsOXqVUxX3GAndb1frUPhB96JVgct2852ZcNOvywASBz00snEqyDEE7NmXqGUcj3Ow=
X-Received: by 2002:a05:6870:f110:b0:1d5:946d:72cb with SMTP id
 k16-20020a056870f11000b001d5946d72cbmr1561715oac.23.1696515241635; Thu, 05
 Oct 2023 07:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231004171838.168215-1-mario.limonciello@amd.com>
 <20231004171838.168215-2-mario.limonciello@amd.com>
In-Reply-To: <20231004171838.168215-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Oct 2023 10:13:50 -0400
Message-ID: <CADnq5_MxDg0wzWmhDGAh6dUzpk_Au9X-SHL7d6EAjXmuerKKhQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] drm/amd: Evict resources during PM ops prepare()
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

On Wed, Oct 4, 2023 at 1:37=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Linux PM core has a prepare() callback run before suspend.
>
> If the system is under high memory pressure, the resources may need
> to be evicted into swap instead.  If the storage backing for swap
> is offlined during the suspend() step then such a call may fail.
>
> So duplicate this step into prepare() to move evict majority of
> resources while leaving all existing steps that put the GPU into a
> low power state in suspend().
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  7 +++---
>  3 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index d23fb4b5ad95..6643d0ed6b1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1413,6 +1413,7 @@ void amdgpu_driver_postclose_kms(struct drm_device =
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
> index bad2b5577e96..67acee569c08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4259,6 +4259,31 @@ static int amdgpu_device_evict_resources(struct am=
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
> @@ -4279,7 +4304,6 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool fbcon)
>
>         adev->in_suspend =3D true;
>
> -       /* Evict the majority of BOs before grabbing the full access */
>         r =3D amdgpu_device_evict_resources(adev);
>         if (r)
>                 return r;

Might want to add a note that this is likely a noop in the normal
suspend case and is just here to handle the case where
amdgpu_device_suspend() is called outside of the normal pmops
framework.
Other than that, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index e3471293846f..175167582db0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2425,8 +2425,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
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
> @@ -2435,7 +2436,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
>             !amdgpu_acpi_is_s3_active(adev))
>                 return 1;
>
> -       return 0;
> +       return amdgpu_device_prepare(drm_dev);
>  }
>
>  static void amdgpu_pmops_complete(struct device *dev)
> --
> 2.34.1
>
