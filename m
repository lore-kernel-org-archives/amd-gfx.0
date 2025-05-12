Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2ACC3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 14:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D94610E419;
	Mon, 12 May 2025 14:44:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CSezF9av";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7F910E419
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 14:44:44 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-22eed3b3cabso5244405ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747061084; x=1747665884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdbjFlMBPFZKGNCJqyDTCwgdwUQOWpZ4+F9bKUnh7Uk=;
 b=CSezF9av0kPKcZklOMRH/E8ObEoyfXdQIXv/7Rb+D7EHgnPNAymTpz6MojAkLzvsqL
 iiSOGIy0nzG5uteBzj3Vx6xU4cP6ED8LGA5q0Ky+6dVhkdO34qBuAkO30jueC9atwwGW
 qR4/6rr+9VrNM1atKVwI4wfjPQE0ZZi5N4sLNdvmbmB9ckaUYrQvjhkGSD9ereqMiz7t
 VO1j2lNxtAjvSLvlUHtsTUL7CS3c5ehuYGtZ5Kd3XK2RNKnAhlCWjrp5pwZDKEzdtA1W
 zARj8WSxlxgg8dEdoUmiZTLQe70E1SRPT/+HitBBYlmgWlUREr5LeoFLEINuuHjCiJba
 yeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747061084; x=1747665884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OdbjFlMBPFZKGNCJqyDTCwgdwUQOWpZ4+F9bKUnh7Uk=;
 b=mRK62z69R48kk3L5CNO8r+ELJfAFCuHKsL8qs6o5TFYXQqtmA0hUY4DC/Ii1iOFh+F
 fSg7cles/JzWda5Y8M7zX2yPwJhfyPsBzXngyj4gFgXfBkBShT62YxsYtDCQmhwAPaJf
 6ckBXDweKdE3Hs1xnTvvZEr9XbJvr6uE6YP02X2JNZfVn1Y8wDMlf9SHhZnh58ItlAHK
 IH8Wl7t1J4G71Y2NHNCmM4zsi9mkgSsbEla3OPeD8qTTKy57/CXqZthv3yk1W5UTsoXZ
 VAe2p7bxfmAvTj7yar9ixChlQjY+FjyGluKeUUvDLePGdsn35GTSgjI1DgWsjtLevPnf
 zkMw==
X-Gm-Message-State: AOJu0YyUmLBcpwtSayJUmJn1+++HE+k1PG47zjeK5tTkmApgIsX5ICb3
 imcvj17F4LxXPVD41DMZMvejP3NHe8Xp5R6ezF2WadhdWKlw7pJKdz0et7wHz2bgVlzzRuiirhr
 +Y90iYLZwUtIEHnAstoijqTzldpszuA==
X-Gm-Gg: ASbGncuXUkgSSm0jlEGYSwnP7fyEbnvQ2FgqdUoEpENbw+xDEFnv/vjWC+cB0a/f6EB
 mFyThNdd6fL+ieFFH1Gdc8KpC6gHzs+5yp6OJWqxuKMU+9CUHETTE14C87UiMncN46E5j4pMsIt
 0tWZyt35KpQh9U1d1NnzDEBNbPGo+UP/CO
X-Google-Smtp-Source: AGHT+IGWiM641WzwfgdFW8Ei124SZf6clA71i9zVP7upFUzVSy7z4hwwTJqJX9YTu55wJYq/v0CKNYGeICOqP3/Xk40=
X-Received: by 2002:a17:902:d2c1:b0:215:435d:b41a with SMTP id
 d9443c01a7336-22fc8b0fb2cmr71503245ad.1.1747061084227; Mon, 12 May 2025
 07:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250512011406.5272-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250512011406.5272-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 May 2025 10:44:32 -0400
X-Gm-Features: AX0GCFvKzH5lROW6f5Yk5etPpgxJOwYi15rr33Ifj9qliGLgS694k0St8CScpIo
Message-ID: <CADnq5_OXO_aoopjcoOg9C2-+_Db_sNeRgZsmUSgPSawqYeLXzA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add GFX 9.5.0 support for per-queue/pipe reset
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, lijo.lazar@amd.com, 
 Asad Kamal <asad.kamal@amd.com>
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

On Sun, May 11, 2025 at 9:23=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> This patch enables per-queue and per-pipe reset functionality for
> GFX IP v9.5.0 when using MEC firmware version 21 (0x15) or later.
>
> This change:
> 1. Refactors the pipe reset support check in gfx_v9_4_3_pipe_reset_suppor=
t()
>    to use the compute_supported_reset flags instead of hardcoding
>    version checks.
> 2. Adds support for GFX9.5.0 (IP 9.5.0) with MEC firmware version >=3D 21
>    to enable per-queue and per-pipe reset capabilities.
>
> v2: Replaced mec version check with !!(adev->gfx.compute_supported_reset =
& AMDGPU_RESET_TYPE_PER_PIPE) (Lijo)
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 9db2bde5c59d..e6d516b1efd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1153,6 +1153,12 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                         adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_PIPE;
>                 }
>                 break;
> +       case IP_VERSION(9, 5, 0):
> +               if (adev->gfx.mec_fw_version >=3D 21) {
> +                       adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_QUEUE;
> +                       adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_PIPE;
> +               }
> +               break;
>         default:
>                 break;
>         }
> @@ -3452,9 +3458,7 @@ static int gfx_v9_4_3_unmap_done(struct amdgpu_devi=
ce *adev, uint32_t me,
>
>  static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
>  {
> -       /*TODO: Need check gfx9.4.4 mec fw whether supports pipe reset as=
 well.*/
> -       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3=
) &&
> -                       adev->gfx.mec_fw_version >=3D 0x0000009b)
> +       if (!!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_=
PIPE))
>                 return true;
>         else
>                 dev_warn_once(adev->dev, "Please use the latest MEC versi=
on to see whether support pipe reset\n");
> --
> 2.49.0
>
