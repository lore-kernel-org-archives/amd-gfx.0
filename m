Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FD6EE49BC
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016C010EA44;
	Wed, 11 Sep 2024 16:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QgQU7JF4";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1493B10EA44
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:02:36 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2053f72319fso20515ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726070555; x=1726675355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDhL4oYdR8Sqe9fFS4EK82VW+pf2nUQluIkSXu86dWc=;
 b=QgQU7JF4Z5ifKaPCHsRGzCd9R8GQY9H3hIFw7VvBSl7puWju37qsqXL2xJ8EZCxAuP
 XQ8bo+Dhw6zpvshl1Yejwj0eK1mTqJetKYN7WDXpP3MvgRQtvUXvwTjh7qtHqbMW7MPw
 vst6b4B3oSUUreR8z7mfpt9qCKtKK5Ph42UmgVNWyQEZ3QOkw7AgDCfcPEKZDjNJrHZW
 ewLnbomzC0sC5DVQL9Il2jA8+E/6Q/wk9yc8BoYnf8jwljwE0wK1UjF0obeSo9wBoIXx
 w0SIh8A+SaM4VGozEsVvt+O+4eFi6utueK6mnOFtFQ1ooKOggr2HqgkYXX8N4tHRJqyE
 aU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726070555; x=1726675355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDhL4oYdR8Sqe9fFS4EK82VW+pf2nUQluIkSXu86dWc=;
 b=WixwTz8s50fTZy+7LjoKBZNUqWNZn/aryPo4eCuYcUYBIYd2OxDpvSxMdnHu4GuVza
 8aWTdkHIzxiReuqoA0HnqypGNPXdoglxqoEO5wOaBFLztmst4a+tsug3bgKiTB/itVld
 obeEedqbPbEcjOr4xQmaEpBUMkDl6j0mMlWxo0wLe6R+pLInZMB5cicMgzYiatPbXJBx
 poFKELOtG6XZ/MMFmuCPouXC9L3yncp36k58OfCt4gFVhGo1wlMDv3Cm9TATcxxvJ7bC
 KpVemqJu6Ka6o0nT4+EFYmD+Vfj+Ba4MV2DMjZ1+rkCkLhrBc8607i9OBRhxqtDG8VGC
 WuFQ==
X-Gm-Message-State: AOJu0YxAIS2jrnnANpNbXRDBJ6cSZ0LIqSdxFkAgLPWtVkzS4DHAkpRx
 zvpsSppNRnjTN+aedjnLpciZqsLOZUtcd1W9CDVk7psv3eFGaY26i2uu485+GjhHAjfp3rHnp6R
 SWSlOiy4Og9aarUetImkvkpLiBTSWDA==
X-Google-Smtp-Source: AGHT+IEY6OSDuj+jZalIrdeTtAj90388zohmsCqZeTvqAAf/QzJEjBV7LwpBgOHyXfXQPuLxB2Mz9xbmoqRsU6ObnSs=
X-Received: by 2002:a17:902:cecd:b0:207:da7:bd0a with SMTP id
 d9443c01a7336-2074c69ddd7mr28785375ad.12.1726070555082; Wed, 11 Sep 2024
 09:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240911154718.39846-1-david.belanger@amd.com>
In-Reply-To: <20240911154718.39846-1-david.belanger@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Sep 2024 12:02:23 -0400
Message-ID: <CADnq5_OgDsC+8Wk27-CoExn43B6bgBzFkJuoqMB3NrDgVvKnsg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix selfring initialization sequence on soc24
To: David Belanger <david.belanger@amd.com>
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

On Wed, Sep 11, 2024 at 11:58=E2=80=AFAM David Belanger <david.belanger@amd=
.com> wrote:
>
> Move enable_doorbell_selfring_aperture from common_hw_init
> to common_late_init in soc24, otherwise selfring aperture is
> initialized with an incorrect doorbell aperture base.
>
> Port changes from this commit from soc21 to soc24:
> commit 1c312e816c40 ("drm/amdgpu: Enable doorbell selfring after resize F=
B
> BAR")
>
> Signed-off-by: David Belanger <david.belanger@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc24.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amd=
gpu/soc24.c
> index b0c3678cfb31..fd4c3d4f8387 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -250,13 +250,6 @@ static void soc24_program_aspm(struct amdgpu_device =
*adev)
>                 adev->nbio.funcs->program_aspm(adev);
>  }
>
> -static void soc24_enable_doorbell_aperture(struct amdgpu_device *adev,
> -                                          bool enable)
> -{
> -       adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -       adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable)=
;
> -}
> -
>  const struct amdgpu_ip_block_version soc24_common_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
>         .major =3D 1,
> @@ -454,6 +447,11 @@ static int soc24_common_late_init(void *handle)
>         if (amdgpu_sriov_vf(adev))
>                 xgpu_nv_mailbox_get_irq(adev);
>
> +       /* Enable selfring doorbell aperture late because doorbell BAR
> +        * aperture will change if resize BAR successfully in gmc sw_init=
.
> +        */
> +       adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
> +
>         return 0;
>  }
>
> @@ -491,7 +489,7 @@ static int soc24_common_hw_init(void *handle)
>                 adev->df.funcs->hw_init(adev);
>
>         /* enable the doorbell aperture */
> -       soc24_enable_doorbell_aperture(adev, true);
> +       adev->nbio.funcs->enable_doorbell_aperture(adev, true);
>
>         return 0;
>  }
> @@ -500,8 +498,13 @@ static int soc24_common_hw_fini(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> -       /* disable the doorbell aperture */
> -       soc24_enable_doorbell_aperture(adev, false);
> +       /* Disable the doorbell aperture and selfring doorbell aperture
> +        * separately in hw_fini because soc21_enable_doorbell_aperture
> +        * has been removed and there is no need to delay disabling
> +        * selfring doorbell.
> +        */
> +       adev->nbio.funcs->enable_doorbell_aperture(adev, false);
> +       adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
>
>         if (amdgpu_sriov_vf(adev))
>                 xgpu_nv_mailbox_put_irq(adev);
> --
> 2.41.0
>
