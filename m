Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37334CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 13:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08CF10E518;
	Mon,  8 Sep 2025 13:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRCx+ssG";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A40110E518
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 13:30:39 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-32d89e962cdso194244a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757338239; x=1757943039; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCNMK/PKzJ+kYg2lN7SpfTojVKNWvfmRPbnNaGEvPUQ=;
 b=BRCx+ssGX3BXDc0CRux6udgPdqMm2OpalUhzOKJaDFKfW8eOdG/kpu/MPby/SGSSfB
 5zsfUl6Pevt70ZS7PmfhTTZsM2X7iXBJuKwdvxdex688NuufVIct++pJ4PhbgVBf7li+
 7mGx0xu37ibq0ezPjGgHBW/Jnn0cbrxeyTEtZf6RDehS98PbTbgxci2gPPcE3LzMLvMv
 zVB1EO2W2C85uQHtNbOY+I7UyOSx+8+GuovvJ7Lfm+v0CuwA12AuW0LEjXld/8MdiMJp
 pb7h+P91Bc1Y8lWJbOhF7xdBcUdouQxkrmo8SJtIQff+oDr5rbnF2xDJ7pTbs86jHpeG
 B1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757338239; x=1757943039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NCNMK/PKzJ+kYg2lN7SpfTojVKNWvfmRPbnNaGEvPUQ=;
 b=Stw3yK9dQdqo8mT+DlBwaADTMJ8LarxQBfe07NCBwDBbnWH+iv/Jt/8mQ5kTLd/6lW
 J85uqjDJ1hELRK3tXUyp8+cHt/gZNRKJQBJbCRWa0ClUNZNrvTY3l0Ho3nHQjPA2ipNu
 N160jclzgT02QSSm+vf+qWgUgKIqDQWuNftLStwaLOWIZ0mPE1JDaZmYwYnSLEszNTVT
 RU3pvKO1KNNSrpaXAGaIepI9vxFLawDzGcRPecNLOhe9JaaZpnaXEn8f1j/LUCpX7KKe
 eY4DU1nhZIUxJ9wr1gw7oP0JV4wp/nyMadghf9qXvBpXy7llS0jhUp4CZTr2GWwVUWnN
 mE0w==
X-Gm-Message-State: AOJu0YznEsYlf8ZrO6MDmyKpAi/2djRkBeTbF+XOA6l2ga8yk5X0HdTo
 4przP6Gs0Rf/7O2y+H446VRI8ttACZgDPHgT0TQ1NNtqMvvbKNGaZ4if+meHWbo1K3oOshWsTpI
 T7DIuUZTEaL7THs/6PcC1UGNMEWXFbZIhNw==
X-Gm-Gg: ASbGncsjfBBzWUA2DEnA2Hfun/wJjKdZs/iMb8/QAz7aHr5DGLBIksXTYFBuf2j/RVT
 vmR6Pqhigq9jbZ0ZGI6g5S1oDGuy7LcyIR8AMUC8uugrSIueyaK+CC0h7GxND0oZqVGR92RK9nz
 pkdxHl9dJUw2XeaJCl1i399+GqXKVrjbgnLBh6sKryf5cL53npDRHRlRpR203NHn4cc9v4nihx2
 Q4mY8FM3ZDQmxi8hA==
X-Google-Smtp-Source: AGHT+IHkqa+E8YDEDT2a5QtXihGekFUvEln6eLsb52CYKXpb33Nbl330o3HjsGWxEUOgBSaM8R0RjsSGQhjiv3/2qDA=
X-Received: by 2002:a17:90b:3a87:b0:32b:8373:203f with SMTP id
 98e67ed59e1d1-32d43f77304mr6068263a91.4.1757338237972; Mon, 08 Sep 2025
 06:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250908130928.1215893-1-ray.wu@amd.com>
In-Reply-To: <20250908130928.1215893-1-ray.wu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Sep 2025 09:30:25 -0400
X-Gm-Features: Ac12FXzrZR1m1v4FhB3IgziZaNYjg4xv7c4gtZUhO69VmavTAQsW9xziLhohzkM
Message-ID: <CADnq5_Px3OB_z-kk6prAv=nJw-PPbL43mZo_A_fDgTu26t+Vmw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicated code
To: Ray Wu <ray.wu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>, 
 Tom Chung <chiahsuan.chung@amd.com>
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

On Mon, Sep 8, 2025 at 9:09=E2=80=AFAM Ray Wu <ray.wu@amd.com> wrote:
>
> [Why&How]
> Remove duplicated code
>
> Signed-off-by: Ray Wu <ray.wu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 3 ---
>  .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c   | 3 ---
>  drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c | 3 ---
>  3 files changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 8475c6eec547..1d1a002f6d54 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -1900,9 +1900,6 @@ static bool dcn35_resource_construct(
>         dc->caps.num_of_host_routers =3D 2;
>         dc->caps.num_of_dpias_per_host_router =3D 2;
>
> -       dc->caps.num_of_host_routers =3D 2;
> -       dc->caps.num_of_dpias_per_host_router =3D 2;
> -
>         /* max_disp_clock_khz_at_vmin is slightly lower than the STA valu=
e in order
>          * to provide some margin.
>          * It's expected for furture ASIC to have equal or higher value, =
in order to
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> index 0971c0f74186..47912e0861a2 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> @@ -1872,9 +1872,6 @@ static bool dcn351_resource_construct(
>         dc->caps.num_of_host_routers =3D 2;
>         dc->caps.num_of_dpias_per_host_router =3D 2;
>
> -       dc->caps.num_of_host_routers =3D 2;
> -       dc->caps.num_of_dpias_per_host_router =3D 2;
> -
>         /* max_disp_clock_khz_at_vmin is slightly lower than the STA valu=
e in order
>          * to provide some margin.
>          * It's expected for furture ASIC to have equal or higher value, =
in order to
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> index 8bae7fcedc22..9ba91e214dda 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> @@ -1873,9 +1873,6 @@ static bool dcn36_resource_construct(
>         dc->caps.num_of_host_routers =3D 2;
>         dc->caps.num_of_dpias_per_host_router =3D 2;
>
> -       dc->caps.num_of_host_routers =3D 2;
> -       dc->caps.num_of_dpias_per_host_router =3D 2;
> -
>         /* max_disp_clock_khz_at_vmin is slightly lower than the STA valu=
e in order
>          * to provide some margin.
>          * It's expected for furture ASIC to have equal or higher value, =
in order to
> --
> 2.43.0
>
