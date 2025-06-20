Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EC2C7115B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 21:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1E010E22F;
	Fri, 20 Jun 2025 21:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/OxpJYX";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF2B10E22F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 21:41:51 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-31384c8ba66so244167a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750455711; x=1751060511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfefVm31vmwqa12+v+xYXQGhpxOpssXn6k/8EXtdsBc=;
 b=T/OxpJYX/DNiHXHbB3X4qAKS3JbT8gt/LgWoT0xty1NA1ZbsoF1Kl7lnODZgg9lfqD
 X9Cj/EWBeC54DOzZjiEdrxl8ns+zpLn7oszlzu2aAQPAeEL0lQsGJpRMOfkQeKcmnQo+
 9yA61vNldQqfMSViyZQDI+i6g02n1HYauuLTr3wjGbywawjQJPjYHi5O+VlorIkq8wYT
 93B3hYtJIsQgfH39w7tqY8rQ1XNLJ5sr57HDa9n6IlZjGPl1zWbsZBa24wsim+I05Q6i
 hDO4kEy9tt2823BI6kJdz4H3Okwoyltk94Naj6FEJ672q3N+OLq06lSTtN9ym6AB9uhh
 tfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750455711; x=1751060511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfefVm31vmwqa12+v+xYXQGhpxOpssXn6k/8EXtdsBc=;
 b=R6sNWHVGkz+IYrzj11/3QqxBRaUV6Gw+fXhzPjaIbyNs52Dv4/XKnqG1tDAN4JxiRJ
 amz9edSL8l4yXouJwlEioD+WNK51I3iQtLCxqGRugfjO2sRUkUAlo//OP9oFgc1VIG5l
 ytz9CaLjCvVsEU5sYTR8ldykuqTpTI+95NedjeoAeHfTCirRDUHi9r8pOuc874Lf2I4w
 Q8GNulJhy08CgGEMiF4q5mCmN0HJVGh29U9weKeVXznSlqoXtIAorqo1gCsCYhUTJnek
 Biu4t0IE53//7GtpGj8yxK/rlvXyCAIUQUOmmNC+AiswtGiykhkVTO94L7TxKRjwKwdm
 52kw==
X-Gm-Message-State: AOJu0Yzap8GlGi0KLt8BZFIjD/XMAGYHVroa0bkIbGlos9DzbTj4qMtk
 U+zuaqjw9uyFXWOXdHlQv4/zi+d/P1osFLJj2kZMYvJoQghmr6KcCcZhNY2fnFNBdv0fxm8+6k0
 Guskhy2aYdOhz/FxAipvFeQeXw2YBoz5g9Q==
X-Gm-Gg: ASbGncsz9Lh2XkQk3onRLuv6/ADbdDQrAzI4LxP7efuloV7i3stiTNpan7mEQeLzbTw
 vC4Eb521qqlvNjy4zW8odysc2dVx1IcTrDzuq7spVe31PB6PurzHI6+FU8qNWFAbcqQj4XaCYP5
 Z48iry6kVOszflz5cOftU9+J6f0PSX0aei4XEoPV3Wzmd0edUTuQm/NwM=
X-Google-Smtp-Source: AGHT+IEiNzEXT3UCLO1580dowNJZpvw+aDdbXumfrgjpFMiMjRh1dxFXHlWUL5EHbxRr3opULola4V7agjnUOBtZcKs=
X-Received: by 2002:a17:90b:5603:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-3159d63225bmr2966559a91.1.1750455711332; Fri, 20 Jun 2025
 14:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250610191232.15597-1-patrick9876@free.fr>
 <20250610191232.15597-2-patrick9876@free.fr>
In-Reply-To: <20250610191232.15597-2-patrick9876@free.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Jun 2025 17:41:38 -0400
X-Gm-Features: AX0GCFsFV_g5E9wqegvToV7zJfk2aMRqvqBjmyfIRCk_5scOMLRBUxWQQBjEEHM
Message-ID: <CADnq5_M=yTiipiYxwvxGDGMfbWqOWJwcdRk1kgPVK_jB7=f+Ug@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon/evergreen_cs: lower
 evergreen_surface_check_linear_aligned restriction
To: Patrick Lerda <patrick9876@free.fr>
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

Applied the series.

Thanks!

On Tue, Jun 10, 2025 at 3:12=E2=80=AFPM Patrick Lerda <patrick9876@free.fr>=
 wrote:
>
> This change removes the restriction when palign=3D64 and nbx=3D32.
> This makes two piglit tests working. This is discussed on the
> thread linked below.
>
> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/9056
> Signed-off-by: Patrick Lerda <patrick9876@free.fr>
> ---
>  drivers/gpu/drm/radeon/evergreen_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/rade=
on/evergreen_cs.c
> index 7d00096fc915..266c57733136 100644
> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> @@ -211,7 +211,7 @@ static int evergreen_surface_check_linear_aligned(str=
uct radeon_cs_parser *p,
>         surf->base_align =3D track->group_size;
>         surf->palign =3D palign;
>         surf->halign =3D 1;
> -       if (surf->nbx & (palign - 1)) {
> +       if ((surf->nbx & (palign - 1)) && !(palign =3D=3D 64 && surf->nbx=
 =3D=3D 32)) {
>                 if (prefix) {
>                         dev_warn(p->dev, "%s:%d %s pitch %d invalid must =
be aligned with %d\n",
>                                  __func__, __LINE__, prefix, surf->nbx, p=
align);
> --
> 2.49.0
>
