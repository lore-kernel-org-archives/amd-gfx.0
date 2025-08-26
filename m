Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD94CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 20:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F17E810E3A8;
	Tue, 26 Aug 2025 20:05:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gZPcBRpG";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1A110E3A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 20:05:45 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-24617d3f077so8654085ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756238745; x=1756843545; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8C/dz6tDJtBIyLnZyz+QG4BYkG8W70HFD/oOt+0LAQ=;
 b=gZPcBRpGJIiH2K2LLIA5bYKSTENt4BvQCNVoazV/Zm97xB49PU/QjNmg8I7e8IAfo+
 H49nqD3WDTow5YkpRT3gVO1NUturjWmJ78DTP9v0khJPM67hWYlHfIHZ0lZEs6mDwvV7
 hgqX/JVUC7RQjQ4W5yHXauWmrVne/Jy52iNT3V9YYg2wxwMko1NOJ0i+4jh/Mx1gk2Cm
 LEyu80BSyw1+SVcchKXkIFisvuBRubQry4/VnEXX6GeTjTk0mc6nXxag+VWo0FncdFgG
 Tk3Do67eI1s3g7fXVj+H33fPm37osAd+bfig6CKkl8JTBgHSu/ArlqS7U04WrQgHP9KI
 /yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756238745; x=1756843545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8C/dz6tDJtBIyLnZyz+QG4BYkG8W70HFD/oOt+0LAQ=;
 b=I8D8sHJzyFmyQrmo96cd0Z2YCdi1vAX6tBzGZCMnBS/coHCjexpkZl98qieK5ylOt5
 xhtMn6ssNKC8+z0nSSXemuLKY/TxcIxOq+dvz58wXY7FZWu6Kurf7tvVOKlkZRkVVD9G
 OvPouzn+vl2OfcG9itazZUPFqjd/XqUL/MwNUX9RK6p0Qi/D2CXa+42RLtOU3B4Rz8n6
 q4iKFk6VcgrZhUUL9lrW9O2cvq39sqZAPkLPJMLhR6TTc5meP7rBoHqv3g5lOhwP6dXk
 WSVpeAysnv+lzE6SkKFwIGyvISKWhEn/IT3GTbO2VnJt63Z5vPzewm9GXWxwp0TZf8jr
 SMvg==
X-Gm-Message-State: AOJu0YyhnEPyi+aCqF+gxW01Pqbtp0q009ptZuva5Sd+J/YRUmc4uxVP
 TEabVMDSgrhN/M0gSPVxGu67smE1Br+PqwZdmixHIAN82n5sTkwk8+cInW5fV435Q2J8BIdg6cz
 7qyecQJ9izAuzxsQ6XfmllbQksoDZ/xap7Q==
X-Gm-Gg: ASbGnculK4hqXrNWKp4XPfewg6sVJ5L2T0csEhVQIKGbNHRq7AtyM1t3qPiKdyKt3TQ
 ie6QeQUhNkkMwVu+vPdU6nhrGm8LolQJJdVD5PM14pbxYjJKke8rna2QtRzM+eNRErVi4mFZ1iy
 ZaRYWhgS5WLGlKWDuYhXdxxupJqMWi5OriU9lgevXW/aYp1IlalRnmVC0fWnDixBYXrg8EwYE7v
 eIX/ckDCjLztCUcjA==
X-Google-Smtp-Source: AGHT+IEvOE89wV3FdK+6PpG2V1Jm4oCRBAYsM8Xm+vZ5qxz9m3tTTO4d2UV05kWAJ5X/d4GkqJ2pwW7bocZun2DJGzw=
X-Received: by 2002:a17:902:d4c8:b0:246:fbeb:b661 with SMTP id
 d9443c01a7336-246fbebce86mr42732555ad.10.1756238744619; Tue, 26 Aug 2025
 13:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250825214635.621539-1-timur.kristof@gmail.com>
 <20250825214635.621539-6-timur.kristof@gmail.com>
In-Reply-To: <20250825214635.621539-6-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 16:05:32 -0400
X-Gm-Features: Ac12FXyI1r713RPknm7PYOIifIvNif0vj0yC9LCLY5gAnoo05T0-Dz7zVuGLap0
Message-ID: <CADnq5_NtWdn_v4JLHuzDGDE2NQn3jJZ+GNP1_dg2QMW2dUuBYA@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/amd/pm: Treat zero vblank time as too short in
 si_dpm (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, alex.hung@amd.com
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

On Mon, Aug 25, 2025 at 5:46=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Some parts of the code base expect that MCLK switching is turned
> off when the vblank time is set to zero.
>
> According to pp_pm_compute_clocks the non-DC code has issues
> with MCLK switching with refresh rates over 120 Hz.
>
> Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index db46fc0817a7..1e2aeea0b552 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -3082,8 +3082,8 @@ static bool si_dpm_vblank_too_short(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         u32 vblank_time =3D amdgpu_dpm_get_vblank_time(adev);
> -       /* we never hit the non-gddr5 limit so disable it */
> -       u32 switch_limit =3D adev->gmc.vram_type =3D=3D AMDGPU_VRAM_TYPE_=
GDDR5 ? 450 : 0;
> +       /* we never hit the non-gddr5 limit so disable it (but treat 0 as=
 too short) */
> +       u32 switch_limit =3D adev->gmc.vram_type =3D=3D AMDGPU_VRAM_TYPE_=
GDDR5 ? 450 : 1;

Took me a while to wrap my head around this.  It might be clearer to
just return early if the vblank_time is 0.  That said, if there are no
displays attached there is no reason to not enable mclk switching.

Alex

>
>         if (vblank_time < switch_limit)
>                 return true;
> --
> 2.50.1
>
