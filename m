Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20A9C3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 16:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F3C10E3BA;
	Mon,  8 Jul 2024 16:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gZXNMqLn";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F66A10E3BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 16:15:25 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2c5362c7c0bso2295024a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jul 2024 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720455325; x=1721060125; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LcVMc7lFx/Z5rJ3xdP4F11hAPHeJ3NzESW2fj2mE/b4=;
 b=gZXNMqLnhSyZ9SZgMvpmCm/dZGAzSA+LP4EcOYGF3DHX7qO+ia9PsqO/8elWSU+6X6
 O8cB2MYrDR9GZwB2Yv9X90uqxOyzZDE9TWMGF7SoqzAzHTvlw2EbHJ99iM5mjsGQYDdH
 j/D0IQUiNDygaJO0jD5JqJmTEToSernBaNtZvBB2WAEBXtMi1iMMOHLlNAJv7kAWw+O/
 7DXCJ4ikFs1E6tq9AbXfbx9+b43oBjVC03loOcfnrUKZk+YvshKBp5FcB15tFJQAtUO/
 PbyJmTswbdpoLGm9wauJuE8uQOqskvubVFc0BP/sD3z23u7+fG0bUSnvTbtOExZ9CtOb
 TX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720455325; x=1721060125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LcVMc7lFx/Z5rJ3xdP4F11hAPHeJ3NzESW2fj2mE/b4=;
 b=uxxnS7hd5sqPay0FjNugdMlfSKhzFI4Sbj8hmUNI+iZpI/8lL5RE0lILX/9Ib6j1q+
 HOuXnOhoqdXK304blW1wvqegVBM5nuIHDyv+RjLIn8zemYT7e1rHLAZ/inF3H0050rse
 oM/iZXPb/MLHCZ8+UOHMpxf8Mfvcn/9yzNR57iDNtnWm5nwgJrVgMzMUSub/o7HUzpGz
 7kCaxdOdKx9cXM1/REaunHwfecwcNOUvyH6LNgoVIk2+mVaAt2MAVG0Ju0igesJHjH6R
 G9vHYFdixF0XrkureKUvn6zRvCKZ3DFhH7GYZrZA/o3gMmPCOcQkZWwhwleSEdDvjm11
 a/jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5cjNFBj/V5vQKwg2ytwwW801V22ZaIcYedU7E05FVs5o8vAw4ZCUjn+E8Q18ihn7h+G3wcYGqhAzp4ubJ/aJ/J54cnVlJ2QKYYJugmA==
X-Gm-Message-State: AOJu0YzPZ+TKCNZM2ui6uMZhrDVcWyGllZwIl3vdQEW0nR+aEszh0mcs
 cCOsKnIrR0DtSWc+HOKFWL7Qrw87d6nOriRnFRB6+R3AH434kgzHHR1y9ABECmI0lkej0qSlkOW
 /f5cbUo/w6FPrwc9tnHth6g9VxMdplw==
X-Google-Smtp-Source: AGHT+IH8EaSNuogc6VMeWe1mTrLYu42ogE0VU5OSMEwpaLZYnO8drHZaqwsvkukI6ZqhJW5i20axBhH/0pwot/3pM1I=
X-Received: by 2002:a17:90b:51ce:b0:2c9:8b0c:af10 with SMTP id
 98e67ed59e1d1-2ca35d86ef8mr121492a91.45.1720455324618; Mon, 08 Jul 2024
 09:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240702084116.1263774-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240702084116.1263774-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Jul 2024 12:15:12 -0400
Message-ID: <CADnq5_NTrRLQAOb_h9ekFERBGOze+esb9Ta9c-GmN-okSyDA6A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/acpi: Add NULL check for event->device_class
 in amdgpu_atif_handler
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Jul 2, 2024 at 4:50=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit addresses a NULL dereference issue in the
> amdgpu_atif_handler function.
>
> The issue arises when event->device_class is NULL and is passed to the
> DRM_DEBUG_DRIVER macro, which attempts to print the NULL string with the
> %s format specifier. This constitutes undefined behavior.
>
> To resolve this, a conditional check is added to ensure that
> event->device_class is not NULL before it is passed to the
> DRM_DEBUG_DRIVER macro. If it is NULL, the string "NULL" is printed
> instead, thereby preventing the NULL dereference.

I don't think this can ever be NULL.  Not sure there is a way to indicate t=
hat.

Alex

>
> Fixes the below:
> In function =E2=80=98amdgpu_atif_handler=E2=80=99,
>     inlined from =E2=80=98amdgpu_acpi_event=E2=80=99 at drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c:1215:9:
> ./include/drm/drm_print.h:536:49: warning: =E2=80=98%s=E2=80=99 directive=
 argument is null [-Wformat-overflow=3D]
>   536 | #define __drm_dbg(cat, fmt, ...)                ___drm_dbg(NULL, =
cat, fmt, ##__VA_ARGS__)
>       |                                                 ^~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/drm/drm_print.h:582:9: note: in expansion of macro =E2=80=98__d=
rm_dbg=E2=80=99
>   582 |         __drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:452:9: note: in expansion of mac=
ro =E2=80=98DRM_DEBUG_DRIVER=E2=80=99
>   452 |         DRM_DEBUG_DRIVER("event, device_class =3D %s, type =3D %#=
x\n",
>       |         ^~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: In function =E2=80=98amdgpu_acp=
i_event=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:452:49: note: format string is d=
efined here
>   452 |         DRM_DEBUG_DRIVER("event, device_class =3D %s, type =3D %#=
x\n",
>       |
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index f85ace0384d2..27131ff30579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -450,7 +450,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *=
adev,
>         int count;
>
>         DRM_DEBUG_DRIVER("event, device_class =3D %s, type =3D %#x\n",
> -                       event->device_class, event->type);
> +                       event->device_class ? event->device_class : "NULL=
", event->type);
>
>         if (strcmp(event->device_class, ACPI_VIDEO_CLASS) !=3D 0)
>                 return NOTIFY_DONE;
> --
> 2.34.1
>
