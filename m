Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FA4C27C6E
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 13:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966E310EC5F;
	Fri,  7 Jun 2024 13:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UpXLRnSX";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E035310EC62
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 13:49:43 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-6e5fd488d9fso50978a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Jun 2024 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717768183; x=1718372983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rb25iHweqtoEaeKmcQtZlsvQ3z9W0gtdhgD0Qa18kJU=;
 b=UpXLRnSXYGvwuuaeofFHFAwysZ1C9oi+USLyp+mlmvjOpPnT4Lf8dD9M3kCY6Dzzn+
 lAUwsQoiM3navfD86ezvY6Kge8u8SZ7h286fK0S0eDlKK8pR7bVr07Dyk4ZNfxuMHAbg
 LO3+dS3+44W0eA9EO/2O4qcylA3FsmTdwS85ywXiFZZ1Qmi6+uuGBReA3tLy5q5u9Izm
 0z7BCduBgvZH+VhAEyPQyYOZWOxV6X25w4bAU/QaLyKZfgK7J1KTjeXQowG8HxtKT69D
 g0HdfTTplIu73z5PtTNQdG2N8TM9Uh3vnNgkKdLeTNCoIxuJGywsQsFKiYnAmc0p3qVu
 3wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717768183; x=1718372983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rb25iHweqtoEaeKmcQtZlsvQ3z9W0gtdhgD0Qa18kJU=;
 b=M/stTMuGe1O9OKqbEmv54BAPO4Vj29CQXHr8KGairdn7ouCooYE7sPj1odsauxi2QA
 p+3b3gE0gcTJ96Uk0aofAAYqXLOo98r0krWErNZ+hCQiqok3pbFjxDu+6pqs6lHum5TJ
 OAuIxBh2iWFCStYkrqSNDngBVFUgXtjpIScbrUKPbqTHo2oJ+I9qGAwwWm2m2NGRT4J6
 IhxhHnCQLVWe/6mhKys4iUpJbuwmr0Ua+v6gg9qxTZLTT6Durv+dPBZdTbyPm6nsDii9
 QobtS9EpPOOj7DZ78u+0LGww/TufUe9a3yGvJHOgMUvaYXOSEHVO+dEudSoueAgb2/9x
 H23w==
X-Gm-Message-State: AOJu0YxVyD1yJOp3YyWNAthQNHg3jBgqdU6OSfCJpCNH6L4Fq2PIyDnR
 I8/KGtF3L8BZA9DbklXnFJ65j+08p+GYnv44b/0d+mM4XRVKc0eFj1XbvcAgq3OyRSLzc/LDeRo
 9+hFBr5drBmhbJAYDeBbs6POvzrg=
X-Google-Smtp-Source: AGHT+IErlt3dEew4E0HBZPkM7qVSe92AHXxnrK7lVJNO1NqUxL162m2ilAzzpmtY4Fmbb4o8Worg2naiaoBKdQwRntg=
X-Received: by 2002:a05:6a21:9985:b0:1af:cefe:9741 with SMTP id
 adf61e73a8af0-1b2f97d6fe4mr3273937637.17.1717768183153; Fri, 07 Jun 2024
 06:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240607060228.509050-1-mario.limonciello@amd.com>
In-Reply-To: <20240607060228.509050-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Jun 2024 09:49:31 -0400
Message-ID: <CADnq5_Oijf8vWntypaSYy4WFvVJbuWShinHKCYmV270fcb1K8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Set default brightness according to ACPI
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <Harry.Wentland@amd.com>
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

On Fri, Jun 7, 2024 at 3:22=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Currently, amdgpu will always set up the brightness at 100% when it
> loads.  However this is jarring when the BIOS has it previously
> programmed to a much lower value.
>
> The ACPI ATIF method includes two members for "ac_level" and "dc_level".
> These represent the default values that should be used if the system is
> brought up in AC and DC respectively.
>
> Use these values to set up the default brightness when the backlight
> device is registered.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c          |  4 ++++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++++++-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  8 ++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 7099ff9cf8c5..f85ace0384d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -383,6 +383,8 @@ static int amdgpu_atif_query_backlight_caps(struct am=
dgpu_atif *atif)
>                         characteristics.min_input_signal;
>         atif->backlight_caps.max_input_signal =3D
>                         characteristics.max_input_signal;
> +       atif->backlight_caps.ac_level =3D characteristics.ac_level;
> +       atif->backlight_caps.dc_level =3D characteristics.dc_level;
>  out:
>         kfree(info);
>         return err;
> @@ -1268,6 +1270,8 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_d=
m_backlight_caps *caps)
>         caps->caps_valid =3D atif->backlight_caps.caps_valid;
>         caps->min_input_signal =3D atif->backlight_caps.min_input_signal;
>         caps->max_input_signal =3D atif->backlight_caps.max_input_signal;
> +       caps->ac_level =3D atif->backlight_caps.ac_level;
> +       caps->dc_level =3D atif->backlight_caps.dc_level;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5fd7210b2479..71aa0c518951 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -77,6 +77,7 @@
>  #include <linux/types.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci.h>
> +#include <linux/power_supply.h>
>  #include <linux/firmware.h>
>  #include <linux/component.h>
>  #include <linux/dmi.h>
> @@ -4321,6 +4322,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_d=
m_connector *aconnector)
>         struct drm_device *drm =3D aconnector->base.dev;
>         struct amdgpu_display_manager *dm =3D &drm_to_adev(drm)->dm;
>         struct backlight_properties props =3D { 0 };
> +       struct amdgpu_dm_backlight_caps caps =3D { 0 };
>         char bl_name[16];
>
>         if (aconnector->bl_idx =3D=3D -1)
> @@ -4333,8 +4335,16 @@ amdgpu_dm_register_backlight_device(struct amdgpu_=
dm_connector *aconnector)
>                 return;
>         }
>
> +       amdgpu_acpi_get_backlight_caps(&caps);
> +       if (caps.caps_valid) {
> +               if (power_supply_is_system_supplied() > 0)
> +                       props.brightness =3D caps.ac_level;
> +               else
> +                       props.brightness =3D caps.dc_level;
> +       } else
> +               props.brightness =3D AMDGPU_MAX_BL_LEVEL;
> +
>         props.max_brightness =3D AMDGPU_MAX_BL_LEVEL;
> -       props.brightness =3D AMDGPU_MAX_BL_LEVEL;
>         props.type =3D BACKLIGHT_RAW;
>
>         snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index b246e82f5b0d..df72cb71e95a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -173,6 +173,14 @@ struct amdgpu_dm_backlight_caps {
>          * @aux_support: Describes if the display supports AUX backlight.
>          */
>         bool aux_support;
> +       /**
> +        * @ac_level: the default brightness if booted on AC
> +        */
> +       u8 ac_level;
> +       /**
> +        * @dc_level: the default brightness if booted on DC
> +        */
> +       u8 dc_level;
>  };
>
>  /**
> --
> 2.43.0
>
