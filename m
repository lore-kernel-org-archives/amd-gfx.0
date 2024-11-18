Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D632CD591AD
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 19:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E21110E271;
	Mon, 18 Nov 2024 19:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a32jta/X";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F8B10E271
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 19:11:43 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2ea46465d69so128551a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 11:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731957102; x=1732561902; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bE4V8xquVkNweCtA5UcqXpUWDcULEp2SV9ngmxHuG4E=;
 b=a32jta/X6vdKyM6K+bse7urng3bzsvt+uaVLjBA84oJOKn56hLZ1F7Lo7dtw4dmhdb
 vv/d4tDXscrGOm+YANAA4h4hV509fLL7WprBCWTORuKYQVuW4aBnnlODwtq4Vc6tgamC
 07MC9qnjRyqPseNG0mklXGghYX0wMkUVo5oMMnApPgDoA82Uxq7gvJzbqrpJegr8F7LJ
 DOAjGb8gsiqi6vID29dYAZ4hfiF68U8Y0zzZ23+RB0xTfSg8QfjXHrihvxDMbe11yFa2
 2vLT1Cep0tU2qKcqf0MuJfpdzAGSPWTDxGvMqewORffABeVhY/E21K6lD5nCqbwvjS9Y
 MxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731957102; x=1732561902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bE4V8xquVkNweCtA5UcqXpUWDcULEp2SV9ngmxHuG4E=;
 b=gfOtN935KYw9+FuaQ5IpKmfoQbDn10IF5GhUL6m+cK5yZC0w9No8l5Q1/qZvrtEDDv
 1knjeefpViUE3IlurJPwymIcljtqRjt/wSHgFFP7KW+X6hDC3k1tpVWguJPe8eJvK0be
 Fk4rT704v3gpFG8EL/ttB5AjG3twGPeGFvDzqiBnzHKeNaM1xBJ0ItcCZzYkbkmEKPBj
 5c48dAVVOEZECTlZkrb6qDiXTiCVR2ILpQm1zGT97zHOEogtoZkkd0YJ+t/fHb1KkMRd
 +Yi4ox3SIzRUx56kaHEyA8zjZPx5EFoyfvZ9Nkw6WS3hiYT6gRybWnCI/N0qwTKIybGx
 9Thg==
X-Gm-Message-State: AOJu0Yxk1mQpuMoL1vrz6N4BnuFlM6xy4q6/lJ+x4tk0UXmkO4J3UJHV
 pLr/WnELx0/F9yxO3BApSLDBvfdfRQ4kDRa39mYeMYD6aoOfewAlOjCHGMKpzY3wZr8M9gBMLhs
 JTsfIQHh2oKUIlu7jRzd1t73aMPoqCA==
X-Google-Smtp-Source: AGHT+IG+3YP8hvx1dWOZIo6bNlBF5e7Kb9JssPvrU2zExO8Z9098ktW+5MT4Eyamx/vYW3PzCSdh39ic8GxedsI7cVk=
X-Received: by 2002:a17:90a:e70c:b0:2ea:47f1:79d3 with SMTP id
 98e67ed59e1d1-2ea47f18194mr3715511a91.6.1731957102562; Mon, 18 Nov 2024
 11:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20241118174611.10700-1-mario.limonciello@amd.com>
 <20241118174611.10700-2-mario.limonciello@amd.com>
In-Reply-To: <20241118174611.10700-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Nov 2024 14:11:30 -0500
Message-ID: <CADnq5_NrjSCUpGQ33OA9iyb7J84fFEvsj-8thEMWS4s8rShN7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd: Fix initialization mistake for NBIO 7.11
 devices
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Nov 18, 2024 at 12:57=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> There is a strapping issue on NBIO 7.11.x that can lead to spurious PME
> events while in the D0 state.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/am=
d/amdgpu/nbio_v7_11.c
> index 7a9adfda5814..814ab59fdd4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> @@ -275,6 +275,15 @@ static void nbio_v7_11_init_registers(struct amdgpu_=
device *adev)
>         if (def !=3D data)
>                 WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE=
_MST_CTRL_3, data);
>
> +       switch (adev->ip_versions[NBIO_HWIP][0]) {
> +       case IP_VERSION(7, 11, 0):
> +       case IP_VERSION(7, 11, 1):
> +       case IP_VERSION(7, 11, 2):
> +       case IP_VERSION(7, 11, 3):
> +               data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4) &=
 ~BIT(23);
> +               WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4, data);
> +               break;
> +       }
>  }
>
>  static void nbio_v7_11_update_medium_grain_clock_gating(struct amdgpu_de=
vice *adev,
> --
> 2.34.1
>
