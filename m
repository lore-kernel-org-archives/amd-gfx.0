Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDF6C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 20:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9310310E065;
	Wed, 26 Jun 2024 20:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WaI52Coz";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17D210E065
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 20:51:48 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-1fa2782a8ccso29784745ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 13:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719435108; x=1720039908; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGrsiIRHDVqQzyHILgfIXoewmNWMuBT7LV2wut0O6+I=;
 b=WaI52CozLrSkhvGfi1G7WLS4AuD4HQU9Pv5aYM+HC+rrbeCt1Tf+byEcupcwD+zYxF
 g4CuWhFAOtMdpQbw2/5XQFx7XBg632HmGU64wGfeTqOxouz4MTXrDVMJcCMPYknIJZue
 pJZ+mdWYKsnlemvrvsk2NO/vlD493dOMBLRT9VZJieBh8DOKHb1tBBdsl/0lYoGo+bVB
 DA5u08jeoNnfcBnAWs727tHs77H9OI826Lymh7yHYhJnSjZ7oZ7OnGcSXCL+LY+/b8A7
 F/uWKqpOVtryrYARLqu3mMpmDBkbtdBMt6HIDQ7kEnDNuCwokgQSPDtZK/nOvQXRbCDK
 hf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719435108; x=1720039908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGrsiIRHDVqQzyHILgfIXoewmNWMuBT7LV2wut0O6+I=;
 b=FBYmR89g9dMFea8d3bXOZHeOY5OAFR7h3TN/+WV6uFjY2YDq0QOxMhIqXU5PfasJtb
 cels/U8orH0CNmGAoyStKLknHD48y1MHJsW0+/U+JCPxqXBYiV/wTsP5aX6qMyteJzOo
 of5cUpmdzUbkCv+VxB+p51IpW3wk3eILjwfcnvmX593/KT2/7V59cl0LLv3076eQkVMA
 hkQEUqPcaRSdPEiBf5kmyOyjVvq4jOGHBFiOyiZkRzH1ih3Z+Umiz3CrU7/FkBjaqS9P
 Wdt23znRFU2K4o/5HNkN7C2IBXOcvoi92AOr0XZECIJB0D6qFHajOwX1eXhtTBCBQp3D
 BnPA==
X-Gm-Message-State: AOJu0YxQzVMhXboCe6NI+yrhkLz6qboGx+SOm7zV277A/Ro1KJGACCVM
 8VLFh4sef8ZawKLCdhWMr/PYqOrmTL/1HQgDbCpK1eVA2kGg+RxJwFR6gCtS1vPoGT2cR8ZuvAA
 kkEJaKSPklY7TLMsvT5Ba9QFasZE=
X-Google-Smtp-Source: AGHT+IHdgDJNS32MD0AX3MlCm2hia90hmbIxl0cg/A4mSTVC++vYDaMHxU76qQKVDRcbdyV0vc87MKDnvbS6nIUkjz4=
X-Received: by 2002:a17:902:f54c:b0:1fa:ff8:e66e with SMTP id
 d9443c01a7336-1fa23f1f418mr134489815ad.59.1719435108096; Wed, 26 Jun 2024
 13:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240626183135.8606-1-marek.olsak@amd.com>
 <20240626183135.8606-7-marek.olsak@amd.com>
In-Reply-To: <20240626183135.8606-7-marek.olsak@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jun 2024 16:51:35 -0400
Message-ID: <CADnq5_O4RsivVyHJ8YPC1yRY7E+pOJUO+HW8wy88F2SHX2=82A@mail.gmail.com>
Subject: Re: [PATCH 07/13] drm/amdgpu: add amdgpu_framebuffer::gfx12_dcc
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
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

On Wed, Jun 26, 2024 at 2:42=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> amdgpu_framebuffer doesn't have tiling_flags, so we need this.

Maybe move this patch before patch 13?  It took me a while to see
where this was used.  Either that or maybe mention where it will get
used in the later patch.
With that fixed, the series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>



Alex


>
> amdgpu_display_get_fb_info never gets NULL parameters, so checking for NU=
LL
> was useless.
>
> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 15 ++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  1 +
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index 3c5fb907bdd9..3f431e6b155a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1143,7 +1143,8 @@ static int amdgpu_display_verify_sizes(struct amdgp=
u_framebuffer *rfb)
>  }
>
>  static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *a=
mdgpu_fb,
> -                                     uint64_t *tiling_flags, bool *tmz_s=
urface)
> +                                     uint64_t *tiling_flags, bool *tmz_s=
urface,
> +                                     bool *gfx12_dcc)
>  {
>         struct amdgpu_bo *rbo;
>         int r;
> @@ -1151,6 +1152,7 @@ static int amdgpu_display_get_fb_info(const struct =
amdgpu_framebuffer *amdgpu_fb
>         if (!amdgpu_fb) {
>                 *tiling_flags =3D 0;
>                 *tmz_surface =3D false;
> +               *gfx12_dcc =3D false;
>                 return 0;
>         }
>
> @@ -1164,11 +1166,9 @@ static int amdgpu_display_get_fb_info(const struct=
 amdgpu_framebuffer *amdgpu_fb
>                 return r;
>         }
>
> -       if (tiling_flags)
> -               amdgpu_bo_get_tiling_flags(rbo, tiling_flags);
> -
> -       if (tmz_surface)
> -               *tmz_surface =3D amdgpu_bo_encrypted(rbo);
> +       amdgpu_bo_get_tiling_flags(rbo, tiling_flags);
> +       *tmz_surface =3D amdgpu_bo_encrypted(rbo);
> +       *gfx12_dcc =3D rbo->flags & AMDGPU_GEM_CREATE_GFX12_DCC;
>
>         amdgpu_bo_unreserve(rbo);
>
> @@ -1237,7 +1237,8 @@ static int amdgpu_display_framebuffer_init(struct d=
rm_device *dev,
>                 }
>         }
>
> -       ret =3D amdgpu_display_get_fb_info(rfb, &rfb->tiling_flags, &rfb-=
>tmz_surface);
> +       ret =3D amdgpu_display_get_fb_info(rfb, &rfb->tiling_flags, &rfb-=
>tmz_surface,
> +                                        &rfb->gfx12_dcc);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_mode.h
> index 1fe21a70ddd0..d002b845d8ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -300,6 +300,7 @@ struct amdgpu_framebuffer {
>
>         uint64_t tiling_flags;
>         bool tmz_surface;
> +       bool gfx12_dcc;
>
>         /* caching for later use */
>         uint64_t address;
> --
> 2.34.1
>
