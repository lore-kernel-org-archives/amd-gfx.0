Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382E0EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 16:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA4110E674;
	Fri, 23 Jun 2023 16:45:50 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C144F10E674
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 16:45:48 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b720fd0e60so793069a34.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687538747; x=1690130747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUqZIz4hwUwO1kDvHUaNDWlGq1yfeIISyuQcJ+RbrQk=;
 b=OPY6VM4GNsm5R/lfo/sV4qpOLgy1Pb5eklMxWncxmiKLGv2dche+SfdncTkJ3afJFX
 KIAXGlvuphRPpMeKEOdV4f/r7F0oWho3Vu8HRiCxU+DOa8+0WcstZh1hFIi1IIUlEJXW
 fmwH3b8Nn8dsOKzkS+bT6DK4jfiO8BM8RW72Ww1yIrlz0ClUfxtv5/9/ijpaZIxv7VBn
 d0VYGFxRVBHlIzNOdM5sp4uv4DkvWWi4x2rn9mnZfwBhqqG6+OwKPiTuRUSdjvnU58P5
 14Dqq4GkntxOTHENrj0iYSfdoMCn8LZT0wkM6LrVfhpX4g0D5Ago8tBvg/Y1kzamDPCr
 VZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687538747; x=1690130747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pUqZIz4hwUwO1kDvHUaNDWlGq1yfeIISyuQcJ+RbrQk=;
 b=MB+O6Jp1mk7w34PeZ0yBUoUYGDNujjE4vygM+ZdcBulGBl123Wi7o/RnHjSwWvG/+W
 8F4hxTker/Olt/trojEu4gmzLv2VIk02+iMVDzCfXdgCCoD8/9Om4zIZ3HNXFrlvZXWE
 wrQOt5QPMTkAAdJZRsyx6prKq22E5Op6zEbbwOlyHbuo4d3JVppbHgYgGRBR1T+8Muc6
 HQqJDYDs2LwDEKmeGDjwXUgy9Oz3rMVe0M4zMc7xVWwVVrmbvkLKXBh/ZVntILSX1UC3
 yByK8yAlj5hauPx7Cx0+o8oS9bJ3TnQBV7jXnpDOn0pSvcqsQbhfONrHDTU9CyOOuaah
 igLg==
X-Gm-Message-State: AC+VfDyKc7io0q/HoYRzrKNWc829w/OsbmTB3ggPqmwj7i79Sotgl5vD
 46lo+xojv+lv1PnafgKipO4WKfBcRCc3aWoJcfuLvSyP
X-Google-Smtp-Source: ACHHUZ5xdxzBH6dMM58O0p+a6kheQR3z7IFBfheqricbZBCbopvUAZ+UA/uedF0HOOT5hbgMP/0ZjXzIfcwz4NiWorA=
X-Received: by 2002:a05:6871:250a:b0:1a9:caa6:1337 with SMTP id
 yx10-20020a056871250a00b001a9caa61337mr16984932oab.23.1687538747423; Fri, 23
 Jun 2023 09:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230621073008.1262837-1-evan.quan@amd.com>
In-Reply-To: <20230621073008.1262837-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jun 2023 12:45:36 -0400
Message-ID: <CADnq5_OABnhTw269m6oEHz5Nc5Q2tx7h1Bc=JgvJ1La7SqDFfA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fulfill the missing enablement for
 vega12/vega20 L2H and H2L interrupts
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jun 21, 2023 at 3:30=E2=80=AFAM Evan Quan <evan.quan@amd.com> wrote=
:
>
> The feature mask bit was not correctly cleared. Without that, the L2H
> and H2L interrupts cannot be enabled.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c | 4 +++-
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
> index ed3dff0b52d2..ae342c58cd3e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
> @@ -192,7 +192,9 @@ static int vega12_thermal_set_temperature_range(struc=
t pp_hwmgr *hwmgr,
>         val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA,=
 1);
>         val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, =
high);
>         val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, =
low);
> -       val =3D val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
> +       val &=3D ~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK;
> +       val &=3D ~THM_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK;
> +       val &=3D ~THM_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK;
>
>         WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> index f4f4efdbda79..e9737ca8418a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> @@ -263,7 +263,9 @@ static int vega20_thermal_set_temperature_range(struc=
t pp_hwmgr *hwmgr,
>         val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_=
ENA, 1);
>         val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_IN=
TH, high);
>         val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_IN=
TL, low);
> -       val =3D val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
> +       val &=3D ~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK;
> +       val &=3D ~THM_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK;
> +       val &=3D ~THM_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK;
>
>         WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
>
> --
> 2.34.1
>
