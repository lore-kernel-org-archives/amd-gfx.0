Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B107DC02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 22:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433B810E285;
	Thu, 16 Jan 2025 22:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iWeYfQdh";
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE94110E285
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 22:15:05 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f440e152fdso312869a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 14:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737065705; x=1737670505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oi0/wsFsm/sJpqN5Ny7bFO5GcxB9mzDNP0C4V2gcI88=;
 b=iWeYfQdhZ/TWPyglHZsksZd/qBp6OrJGCFXFaQ6Ti/QGp0Q/9GYBulfRvmSh0nhsaX
 6G9gPbisRv97tbE573yhEnP56R7SXsHITqGMd/+joKz4ktZwJNevg+uFRr7i2F+8Yz1n
 flS3lj1eAp1SNr0m7c1ebw9UR+P0+ER/6GXW82Cy7BAtRu4jb+nTYVlOKK2JXT2lmvNo
 eNdF4yWUpx3kQFt2tMos90Ichy+2AQTVWi5T13y/hP9jvK4C7K0/FcC4Zeod520zjqJQ
 9juBAMUTyiJjKu+GXACxJGgN50IWl8wXGZq7GfOXGRaFjA0JQySmri1/3bDkVCXxQYSz
 FUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737065705; x=1737670505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oi0/wsFsm/sJpqN5Ny7bFO5GcxB9mzDNP0C4V2gcI88=;
 b=ihc/xQYZK8Gm71sVqvCHlpEXR7bMQWzFGy/GmZY3MXEpQRNynua0GGRTkRsRX+Mlxq
 PZ65PO3fTmhtwOqVDdi2k7HWltaCiXGIpnZyJ9Zl1XGIyFAGm6C7YSt9i8pYUkBRoGl3
 LcvBMLDL2DI/hm4FtC4Lxx8/3XbqCcZ7GxabdgGco+LCJ0l8mu9R7FLFZPQAbLsx7TuL
 lNcbXrZfmwJXXlrhUqQ3l8jHvfJCkxUrmYVs3ZRCqgYecrTtcilFma/BM3WcRy6e3ke4
 Xx7P/ZsP4/NrfBp7ClW5Ln1sJxTmlAOtysikicEiZFYI+UW25uMiJyq8ztjvlLEeIo55
 4/uQ==
X-Gm-Message-State: AOJu0Yz2fqdtP6JBIKCF2nJZ8VYAM0BbIic8pRHKgElfUS+4O2v/Ln3m
 Fy9In5m6n7YBQZBOEoW0beMRmRjcackmmKo+dpCyvuaml6GdeQCYtg9UnNM+YE5Fldgx68QrZMv
 9xq1dd8bdS57ksCV/5auI47rkl/1hJg==
X-Gm-Gg: ASbGncsdV5XpyLe7JCGYUj5L4i6LqqZRYSlrihdWFlJOifw0aIfw6kP+JNvRi0pt5gb
 iozEpmktJs3vME35BYi0SWciCTCrHgULx+plY3A==
X-Google-Smtp-Source: AGHT+IGe7xTsY4gTj3HFO4vRwQTjuaB7LkOgmwHNQylKoYVdi35uMtRrP568wt9G19sgfjssi0I4VKDpX1ZVzC0K2uo=
X-Received: by 2002:a17:90b:2c84:b0:2ee:6a70:c5d1 with SMTP id
 98e67ed59e1d1-2f782d3845fmr121304a91.3.1737065705317; Thu, 16 Jan 2025
 14:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20250116220020.2425025-1-superm1@kernel.org>
 <20250116220020.2425025-2-superm1@kernel.org>
In-Reply-To: <20250116220020.2425025-2-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2025 17:14:53 -0500
X-Gm-Features: AbW1kvZMHmaJgd3ATLmxu9CUoY8XZH-e3ghrESxsorRHesVAeXUi8hiniaNe954
Message-ID: <CADnq5_NeHrNu98mw0HvwW3k35y-dfU5Pvm8CzPDkQuYsxt6m8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amd: Mark amdgpu.gttsize parameter as
 deprecated and show warnings on use
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Jan 16, 2025 at 5:00=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When not set `gttsize` module parameter by default will get the
> value to use for the GTT pool from the TTM page limit, which is
> set by a separate module parameter.
>
> This inevitably leads to people not sure which one to set when they
> want more addressable memory for the GPU, and you'll end up seeing
> instructions online saying to set both.
>
> Add some messages to try to guide people both who are using or misusing
> the parameters and mark the parameter as deprecated with the plan to
> drop it after the next LTS kernel release.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 +++++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 680b272a83c9..31d4b6aebca5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -283,6 +283,7 @@ module_param_named(gartsize, amdgpu_gart_size, uint, =
0600);
>   * DOC: gttsize (int)
>   * Restrict the size of GTT domain (for userspace use) in MiB for testin=
g.
>   * The default is -1 (Use value specified by TTM).
> + * This parameter is deprecated and will be removed in the future.
>   */
>  MODULE_PARM_DESC(gttsize, "Size of the GTT userspace domain in megabytes=
 (-1 =3D auto)");
>  module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index e6fc89440210..becdeab369c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1960,10 +1960,19 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>         /* Compute GTT size, either based on TTM limit
>          * or whatever the user passed on module init.
>          */
> -       if (amdgpu_gtt_size =3D=3D -1)
> -               gtt_size =3D ttm_tt_pages_limit() << PAGE_SHIFT;
> -       else
> -               gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
> +       gtt_size =3D ttm_tt_pages_limit() << PAGE_SHIFT;
> +       if (amdgpu_gtt_size !=3D -1) {
> +               uint64_t configured_size =3D (uint64_t)amdgpu_gtt_size <<=
 20;
> +
> +               drm_warn(&adev->ddev,
> +                       "Configuring gttsize via module parameter is depr=
ecated, please use ttm.pages_limit");

Missing newline at the end.

> +               if (gtt_size !=3D configured_size)
> +                       drm_warn(&adev->ddev,
> +                               "GTT size has been set as %llu but TTM si=
ze has been set as %llu, this is unusual",

Same here.

With those fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +                               configured_size, gtt_size);
> +
> +               gtt_size =3D configured_size;
> +       }
>
>         /* Initialize GTT memory pool */
>         r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
> --
> 2.48.0
>
