Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420ABE92705
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 14:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA8F110E3E0;
	Thu,  5 Oct 2023 14:28:45 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE4A10E3E0
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 14:28:44 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1e19cb7829bso629055fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Oct 2023 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696516124; x=1697120924; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+/RIlK/HvYJTs2InntWtHG9NPU7Eq4fmntMPp5wYWM=;
 b=Nfdai+nlsNJpQJWGdO50fI/uqoaBQctP3O9X4OfWmUziIG5ctpMv3WXGxCnOHGLXsk
 GP/y9X15urHH4B7dHxYn+xkWa/av1WGSD4afUqs5IRJt7qqLG84itSJ+ZoNRs2yFM/CY
 hn6mKsGhE4X4nJHdWRTVFYKzJIosuw5Iser+tSU/Izs5ZtB/BqqwzftRHv6q9pk88rHL
 iaalUODTtbJ3FfRfPdZoP8m8vNLFcOBobqBfSqrf9m5ohHsA8ESr2ComAlGZI0aj0UUK
 /v2FCG7a1Ti3ikM8rn/HkaDbXf5ZvypBv4LvpQJOY//AV581ggzrCnEy5rQhFrFmtl9C
 Z3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696516124; x=1697120924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L+/RIlK/HvYJTs2InntWtHG9NPU7Eq4fmntMPp5wYWM=;
 b=MD2eznQFoPWfwwWQwdIz5WkFnfgAc8s5KYGSBqswjwRrqj0xOBCxuLs1DCma1O48sF
 pDFhBhyys/C7bZ83/5WTacUjdmPMhLYEuvyDysxDgpGbAqKbFvXnSO5Z4Q4XnKbPQaNL
 5XgWhDuO0SQ6W2OMmF4tKcmbYp/Zbhc1L3SpI3IwBCjBoYw0D2t7wD7HkUe1ZGfq9B4c
 3/klJNKecOgBRAiRH3hEMm/vT+rYLF7hUNi2kCnJpQhOZTpWzalGuSLo01bHO9LaAR+N
 icJUr9EvHRwIy735RV2saYxrteLpFNe5aAOEFzwCjhBbqKq6tHM4gTB5Ck9Dy5vfzwgZ
 992w==
X-Gm-Message-State: AOJu0YzpD/0VWzYa/IwjXx02N4YuJX6+qMfgXCADN60MS+K/Rceczt9W
 F7ezszX4MDGKfy0QACNuIo86Vz8pmoqBp6N+Mri+1zSn
X-Google-Smtp-Source: AGHT+IEKh+/uL8Nn5nRizpx65AkkbBWpZBmZZUVomHcS8LLyU9DZCsHvkUxcd5iz9QW9MawPjlbBGAyNO2RG2so7s7s=
X-Received: by 2002:a05:6870:89aa:b0:1e1:e1f8:ea3e with SMTP id
 f42-20020a05687089aa00b001e1e1f8ea3emr5663217oaq.1.1696516123900; Thu, 05 Oct
 2023 07:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231004171838.168215-1-mario.limonciello@amd.com>
 <20231004171838.168215-4-mario.limonciello@amd.com>
In-Reply-To: <20231004171838.168215-4-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Oct 2023 10:28:32 -0400
Message-ID: <CADnq5_MZ=K=NP0ujgOFB4Ds+BWc-jqb5OSr78hJhXMSp2gS8_Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/amd/display: make dc_set_power_state() return
 type `void` again
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

On Wed, Oct 4, 2023 at 1:27=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> As dc_set_power_state() no longer allocates memory, it's not necessary
> to have return types and check return code as it can't fail anymore.
>
> Change it back to `void`.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++------------
>  drivers/gpu/drm/amd/display/dc/core/dc.c        |  6 ++----
>  drivers/gpu/drm/amd/display/dc/dc.h             |  2 +-
>  3 files changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a59a11ae42db..df9d9437f149 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2685,11 +2685,6 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_=
display_manager *dm)
>         }
>  }
>
> -static int dm_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state=
 power_state)
> -{
> -       return dc_set_power_state(dc, power_state) ? 0 : -ENOMEM;
> -}
> -
>  static int dm_suspend(void *handle)
>  {
>         struct amdgpu_device *adev =3D handle;
> @@ -2723,7 +2718,9 @@ static int dm_suspend(void *handle)
>
>         hpd_rx_irq_work_suspend(dm);
>
> -       return dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
> +       dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
> +
> +       return 0;
>  }
>
>  struct drm_connector *
> @@ -2917,9 +2914,7 @@ static int dm_resume(void *handle)
>                 if (r)
>                         DRM_ERROR("DMUB interface failed to initialize: s=
tatus=3D%d\n", r);
>
> -               r =3D dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D=
0);
> -               if (r)
> -                       return r;
> +               dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>
>                 dc_resume(dm->dc);
>
> @@ -2969,9 +2964,7 @@ static int dm_resume(void *handle)
>         }
>
>         /* power on hardware */
> -       r =3D dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> -       if (r)
> -               return r;
> +        dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>
>         /* program HPD filter */
>         dc_resume(dm->dc);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index cb8c7c5a8807..2645d59dc58e 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -4724,12 +4724,12 @@ void dc_power_down_on_boot(struct dc *dc)
>                 dc->hwss.power_down_on_boot(dc);
>  }
>
> -bool dc_set_power_state(
> +void dc_set_power_state(
>         struct dc *dc,
>         enum dc_acpi_cm_power_state power_state)
>  {
>         if (!dc->current_state)
> -               return true;
> +               return;
>
>         switch (power_state) {
>         case DC_ACPI_CM_POWER_STATE_D0:
> @@ -4752,8 +4752,6 @@ bool dc_set_power_state(
>
>                 break;
>         }
> -
> -       return true;
>  }
>
>  void dc_resume(struct dc *dc)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index b140eb240ad7..b6002b11a745 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -2330,7 +2330,7 @@ void dc_notify_vsync_int_state(struct dc *dc, struc=
t dc_stream_state *stream, bo
>
>  /* Power Interfaces */
>
> -bool dc_set_power_state(
> +void dc_set_power_state(
>                 struct dc *dc,
>                 enum dc_acpi_cm_power_state power_state);
>  void dc_resume(struct dc *dc);
> --
> 2.34.1
>
