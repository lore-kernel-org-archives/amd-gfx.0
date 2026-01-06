Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37573CE9D42
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 14:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D098B10E123;
	Tue,  6 Jan 2026 14:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X8sHDySV";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F5A10E50B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 14:47:50 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2ae2dfd9eefso2483eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jan 2026 06:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767710869; x=1768315669; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGFocwYcUO10lAdaXraGl5kbq7qJfVKH2xOcweaicaY=;
 b=X8sHDySVCkyexJsz2TCMqmVl7pjSAU+6eWS4czL3xwx/h65nsy8kbpGYvlZrgZH/Xj
 AbpeeFT8DFSzstFWTmD2gfv0aETCj5I7a3JPT+kykRhxQSY4fb/UVPSTvk4y2Q/cU2fr
 YJzEu5G3sGNJ035qiu7uGNpl1VLL7Qy4QjRwIvQMCXbJlM3P+5V+yEBV0Uu+zejgjfOy
 TgtAaZcc0M75gZsahmPQnbwuqxsORs8N4vH7rU7W6KEqfNEr3yRzv+KdlR7C6eY74nmL
 k10Z7S/zSkxLf5mISRB/NBREo7crNXjHTq7Oz5Ydadm3N23U/Qt4QsgP+V2VzNrnGFyr
 cJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767710869; x=1768315669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lGFocwYcUO10lAdaXraGl5kbq7qJfVKH2xOcweaicaY=;
 b=EX8wctuj3o4MgiqxRCagtZU0tE0cao03K/kfp9nnp3PSMWVoUaY6SvU04Fc5KnvxP3
 CqGpphRIxZifAqPA/OCmN7Kwe81dtCJPWx9kwNXhGm4LaZsJsC8hr5uM4zoHIuD5tLTZ
 Sp+QqJ5E7IO/kfkzWoTSMTZYBmY3uXYzTtEkDq3AebzsRK+v17GsEIjh5tZKK7+85aZb
 DucmmmjOZCGYjO6MLFloc3EoTcSSgFDjByodQpw8OtbMlpmjioRE8pX9N7iusH4ZA8PR
 RFtdb2Ho0nq+c9UdQAz1j0SQusL9RKyqEt8IJITqwvI/+zyRkNzAFr2N+G5KSw2QM5WX
 IwZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE9DGYgj9yK4+W+ke+w8NzTRf+uoWPk4dhTNCi5pUaR7p21ieuzwSx4PLLBKQyLJf+WLvwJBV/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoGZLOr97AprM26ZlPWPlwB+4WTilPD05s3cv6vyRdTGX2+3bX
 akbl/8c8tBCpsRcRQ83csKFdaNkGcORkdJs/XZHigazkeHo4zcuGQdjhSIWOwLurjQYIQELDF70
 f3+n+NP+s7zNjzKOw8oBsa2w1fZYJ1nY=
X-Gm-Gg: AY/fxX4ErZFhC2VxlEAG4c37NU5tNhLIZspvCuws4LUsQCLFmu3ZsLomE8Q4a0EX0wj
 MjkOLAytC54P/dZQln7icLNOy+nkoPS5GO1GC5SZgE5xN6TXiezliqDH1wyZZ78zP368fkopR29
 L4/ORcO0LmjgHPZmYNcQ5hBea/VOn543ecQaRfFB75dELZ2e1gYBpd0RS8U+X7v0DxBV6jwpHCc
 l3q9cClmhngGAcotgTSVkiVb+44dCxiZSbHT1SwJdNr6RRZqeODFs3IZA2v2IpkBKo8xB3o
X-Google-Smtp-Source: AGHT+IEeTUiuD7kCf6JvD92QT3fvl/RpMs7KXHBBTDvwNHDOFoemydUJ2WuNt3K41sWhVgVvtnjJ7fUHLLutaCZ5vd8=
X-Received: by 2002:a05:7301:1446:b0:2a4:3593:2c0a with SMTP id
 5a478bee46e88-2b16f864435mr979958eec.3.1767710869195; Tue, 06 Jan 2026
 06:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20260106023712.54546-1-yaolu@kylinos.cn>
In-Reply-To: <20260106023712.54546-1-yaolu@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Jan 2026 09:47:37 -0500
X-Gm-Features: AQt7F2p9ChaNCsLSPwYIOt2PgtwTnPPeqDb16LJopLTt5PzQrlbAse8IKAMpwY8
Message-ID: <CADnq5_Oh5iJirX57cJskcTyKixsLFGeDBaTgc-r15UjFt8fWVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix drm panic null pointer when driver not
 support atomic
To: yaolu@kylinos.cn
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Mon, Jan 5, 2026 at 9:37=E2=80=AFPM <yaolu@kylinos.cn> wrote:
>
> From: Lu Yao <yaolu@kylinos.cn>
>
> When driver not support atomic, fb using plane->fb rather than
> plane->state->fb.
>
> Fixes: fe151ed7af54 ("drm/amdgpu: add generic display panic helper code")
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index b5d34797d606..52bc04452812 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1880,7 +1880,12 @@ int amdgpu_display_get_scanout_buffer(struct drm_p=
lane *plane,
>                                       struct drm_scanout_buffer *sb)
>  {
>         struct amdgpu_bo *abo;
> -       struct drm_framebuffer *fb =3D plane->state->fb;
> +       struct drm_framebuffer *fb;
> +
> +       if (drm_drv_uses_atomic_modeset(plane->dev))
> +               fb =3D plane->state->fb;
> +       else
> +               fb =3D plane->fb;
>
>         if (!fb)
>                 return -EINVAL;
> --
> 2.25.1
>
