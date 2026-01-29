Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0717D358EB
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 09:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B2410E841;
	Thu, 29 Jan 2026 09:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U0unhF6y";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271E110E841
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 09:35:37 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so7774505e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 01:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769679335; x=1770284135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+AD9MARHUhTfZR5S46iiGR0fZ10eWiss2y4lAR7bc4=;
 b=U0unhF6yJvV6Q8WFQW3+u7iCLar2MAIzjUHlt193uv0gSqxmXp3PkWP8nXNucHGqSe
 bSBB15rfmSpoNyMaQG/dwKN0y6DwN9wFZ0GBz9A4MjEcL5XybSmy7eF8q49jopsp+otj
 RdIW/qki5XzI0svC1hUeGs9BBUP1TsX64Dr4d+W/AJL6o0iC6WQ0FxaA3/7bESUZEWfM
 HJusHC/ur6sLiIFFQrddn6UYZyV7eHRy8l7M30gnqRlzkAv7DvaIkpQgCusjpA0hQiSv
 gGDU/AGoCLFlqsBSnRKCeFsbQkEZQINA7E1n0NQXxXjwH9esVKChKMDXP8yzQlPuGAmk
 /CIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769679335; x=1770284135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1+AD9MARHUhTfZR5S46iiGR0fZ10eWiss2y4lAR7bc4=;
 b=LzQGLDl7krR0+JxRghpnl4jwwYrQkU/22MXzAoXo4j2uIy+5RU9OWL/Eqx0QGW5Ty/
 3euzopVO8chk9YNBUVBeCpLxsn8WUOcREdBzq2iN6lQaZTY3dSzgghUpAdx9BrHZ02gA
 lifloYi8w3K3JL+CB4h9ZqMOuAl+z8pfSGZp8UiTlLXV06S3+SiQfsmkZgI8YR45fsxF
 TDkxOG7c0EP3Wt7iF+5DVkfWRaXZjoidNlP/VFnKNGWpyODJ23JSMCmC5QMnTchGOMKc
 1qL36fo8f4qL68CJCAqz4UIhSlLcARDN/aq1ByrMr2CkgrJkbUM+ZRMTKTrlzPD8mtPz
 Pk+w==
X-Gm-Message-State: AOJu0YyNvaGBLcupM7Xma7mVKA5OP9pZg4+cregq680eNrx1JUN1p9ij
 43JsdmPtnWFFzJ01CDFMF+euvygpFCnasMfLcV0d06UspoELev9reAcgC23yrw==
X-Gm-Gg: AZuq6aJgO6/fwaC7/IjzeUl5bFrdRLoAEF9fLDZmJysFh6Tykt2pU5x1uqb2d3r1BZz
 +RCVATypEXXe9gwrex02HAJtEKED7b7/6gTtZnY1Pz5nzahJtR6tDgea/h6avuvsDdFWoRzmq0x
 t/zKrp8w8PlTEGXt1fOPG040Ncmb1F3F7yTrM0heJmc6dy9nFdQlHaYAcXzMkG0zspy8DYlTvSB
 pjn8zb1pSOUOAgPkq4jDmvW/TfC0cBKgWMD9UCYdZHBfzIw3OxHs8E5KAbpibV9f/0gEox+9kbP
 uPMG+YxPubeaM8dztuR08L1wfzEMfd2QGcFdFCScjuhzFI4Big2PC+r9r2RqW2hplNNGJrytDiq
 ErTmZjh04uLrR2Eg50mf93vf+y57OmgICTTauHpQ6rybdHuAbLNFMDLG/Wr/2/bdfyx5l7yAR3x
 9E0BkKQ+oKaMruNVDzwim0WgJwNQ/kFzGrc28knorduma4ORRgo2wYq7MxWQU=
X-Received: by 2002:a05:600c:4689:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-48069c63339mr116254735e9.31.1769679335506; 
 Thu, 29 Jan 2026 01:35:35 -0800 (PST)
Received: from timur-hyperion.localnet (5401DF8B.dsl.pool.telekom.hu.
 [84.1.223.139]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5d9becdsm6836795e9.3.2026.01.29.01.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 01:35:35 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx11: adjust KGQ reset sequence
Date: Thu, 29 Jan 2026 10:35:34 +0100
Message-ID: <2769950.lGaqSPkdTl@timur-hyperion>
In-Reply-To: <20260129043936.33607-1-alexander.deucher@amd.com>
References: <20260129043936.33607-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Thursday, January 29, 2026 5:39:35=E2=80=AFAM Central European Standard =
Time Alex=20
Deucher wrote:
> Kernel gfx queues do not need to be reinitialized or
> remapped after a reset.  This fixes queue reset failures
> on APUs.
>=20
> Fixes: b3e9bfd86658 ("drm/amdgpu/gfx11: add ring reset callbacks")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4789
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

The series is:
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
(including with Jesse's suggestion if you choose to implement that).

I notice that gfx_v10_0_reset_kgq() also calls gfx_v10_0_kgq_init_queue(),=
=20
should that call be removed as well or made conditional?

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c index b5a2d09fc3469..489edf517f9=
1c
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6854,18 +6854,6 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring
> *ring, return r;
>  	}
>=20
> -	r =3D gfx_v11_0_kgq_init_queue(ring, true);
> -	if (r) {
> -		dev_err(adev->dev, "failed to init kgq\n");
> -		return r;
> -	}
> -
> -	r =3D amdgpu_mes_map_legacy_queue(adev, ring, 0);
> -	if (r) {
> -		dev_err(adev->dev, "failed to remap kgq\n");
> -		return r;
> -	}
> -
>  	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }




