Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2836CE7A81
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 14:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B84310E256;
	Mon, 25 Sep 2023 14:32:47 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA4710E256
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 14:32:44 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1dcf357deedso2132871fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695652364; x=1696257164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/3HqQ4ox7Fb9siS8AepHIy6hECl4OQ2to8wUI2aLzQ=;
 b=mxBSzimfBjrh0n/eIOox44ViaQHY6I+zKt41aFjiBbAP/rthh5Dy9+CQ8Nl6O8Lyym
 K8WFsS7Kn1M+vXeX7X9/wRN7OLQjpLDkh1DoaiWdzyr9S6d9vm8W6N2aOLWfijYTnn7A
 dVgvi0T0aHS8TXL4Ss0xy2NFOLXDKGxSpc6rGgCB/OTT7NDi3HIMh5elO1qZG6hNYjy3
 zyTPhWyFskdgdpFJGO084x2y5wfNN2v1RhPdBhIZifQSyhFD0rsjErYHDMJTawtCttyb
 /qcaHOLwFt4h6GhQZBYc1ixvMvOaeEc70yOaRAP6qk9Tg03sVmIktclEuRPx6SyiFNX/
 7Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695652364; x=1696257164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/3HqQ4ox7Fb9siS8AepHIy6hECl4OQ2to8wUI2aLzQ=;
 b=WdMxPJsBYjbIkC5f9yXIlt3zi6zrjPQzqwZWvVxCu36eP/VJ6XfMcEdur9wjpVD/NE
 Hrn1DDr+17aUfzoB3F3l2zPbV7ePwsRCdwhqSiXSX69gTsh6eXNmU/PYfClEoeonVtLJ
 ZWO0lCCmxcteLkXpEdi7WtTtTQkpwzh43XKVT/tpRzD0oB2PUMRLUT7fEDt0FbyT7iPh
 sGk5AbuISjedU3dMmg0zjJ/NwnjfRhQ8iVsyUUAvseEE+xqtL/eABzUlfPXwLh/WDNl3
 PTPcetttZ9dCi5YBuLiMeIvSeWhiWNvVNWk3Tzc7LT8ia7QKGuHg2P2dSvFrR7jtqXvj
 qSgw==
X-Gm-Message-State: AOJu0YwPu3GIlUziLRqnTDMeAgXF8aMB239+41ISdqrnSK/lfihBKU1M
 e3LY/nIlEQCBe/2RG+HnrQBMH/BU8E4B2cKDTyDZqa0M
X-Google-Smtp-Source: AGHT+IFgIlLK8ERG5HVXUXbjRNuy0otlgmwsY0ktqUwnYbb75FkqH2IUbx3ZGMBTGI4BUxSqhLRQoJDAc/PkgYa6xxA=
X-Received: by 2002:a05:6870:f689:b0:1d5:b9e1:d35e with SMTP id
 el9-20020a056870f68900b001d5b9e1d35emr9438900oab.41.1695652363939; Mon, 25
 Sep 2023 07:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230922201243.104935-1-mario.limonciello@amd.com>
In-Reply-To: <20230922201243.104935-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Sep 2023 10:32:32 -0400
Message-ID: <CADnq5_NLSz0Ur2NFMadGSx2im3PCUrO577e52ahAs8M+YN8C-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Propagate failures in dc_set_power_state()
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

On Fri, Sep 22, 2023 at 4:51=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> During the suspend process dc_set_power_state() will use kzalloc
> to allocate memory, but this potentially fails with memory pressure.
> If it fails, the suspend should be aborted.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> Cc: Harry.Wentland@amd.com
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++-----
>  drivers/gpu/drm/amd/display/dc/core/dc.c          |  8 +++++---
>  drivers/gpu/drm/amd/display/dc/dc.h               |  2 +-
>  3 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 373884ca38b9..2acb555343ae 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2670,9 +2670,7 @@ static int dm_suspend(void *handle)
>
>         hpd_rx_irq_work_suspend(dm);
>
> -       dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
> -
> -       return 0;
> +       return dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>  }
>
>  struct amdgpu_dm_connector *
> @@ -2865,7 +2863,10 @@ static int dm_resume(void *handle)
>                 if (r)
>                         DRM_ERROR("DMUB interface failed to initialize: s=
tatus=3D%d\n", r);
>
> -               dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +               r =3D dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D=
0);
> +               if (r)
> +                       return r;
> +
>                 dc_resume(dm->dc);
>
>                 amdgpu_dm_irq_resume_early(adev);
> @@ -2914,7 +2915,9 @@ static int dm_resume(void *handle)
>         }
>
>         /* power on hardware */
> -       dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +       r =3D dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +       if (r)
> +               return r;
>
>         /* program HPD filter */
>         dc_resume(dm->dc);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 293489c41086..a1593d550526 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -4711,7 +4711,7 @@ void dc_power_down_on_boot(struct dc *dc)
>                 dc->hwss.power_down_on_boot(dc);
>  }
>
> -void dc_set_power_state(
> +int dc_set_power_state(
>         struct dc *dc,
>         enum dc_acpi_cm_power_state power_state)
>  {
> @@ -4719,7 +4719,7 @@ void dc_set_power_state(
>         struct display_mode_lib *dml;
>
>         if (!dc->current_state)
> -               return;
> +               return 0;
>
>         switch (power_state) {
>         case DC_ACPI_CM_POWER_STATE_D0:
> @@ -4746,7 +4746,7 @@ void dc_set_power_state(
>
>                 ASSERT(dml);
>                 if (!dml)
> -                       return;
> +                       return -ENOMEM;
>
>                 /* Preserve refcount */
>                 refcount =3D dc->current_state->refcount;
> @@ -4764,6 +4764,8 @@ void dc_set_power_state(
>
>                 break;
>         }
> +
> +       return 0;
>  }
>
>  void dc_resume(struct dc *dc)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index faf897ac75d8..82013ebcba91 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -2329,7 +2329,7 @@ void dc_notify_vsync_int_state(struct dc *dc, struc=
t dc_stream_state *stream, bo
>
>  /* Power Interfaces */
>
> -void dc_set_power_state(
> +int dc_set_power_state(
>                 struct dc *dc,
>                 enum dc_acpi_cm_power_state power_state);
>  void dc_resume(struct dc *dc);
> --
> 2.34.1
>
