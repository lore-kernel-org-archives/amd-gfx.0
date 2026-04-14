Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E397EF9D0CF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 13:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E166B10E5FB;
	Tue, 14 Apr 2026 13:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BZiajlVq";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C129B10E5FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 13:11:37 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-124a7216c9cso324243c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 06:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776172297; cv=none;
 d=google.com; s=arc-20240605;
 b=B5eBUc8Vzeo54rvJuMr9E6lnt+McM/AkFyIt7Uum1BupW8o4xd2QGRLaDlkY08sPaR
 DtJ7+JoyhjRChkwneztH+StcXO17bYcV4CKjQoDR73GuTO+cQnPUJ1sueff4qc7Irq6L
 y6BzuOAY5uv8U+4PB9nds96Xcs11dxYUzxxzb3UZlG76S66blg4yfqXcUTJpwHdLkmq4
 /KaUDg6u3xqpzXUQSjpMmpcCTbJHgWNIjUaWBil5IA2ngcrFb7iuBZFe7EourReYiRrn
 7eu3x0Yv8RMKAH+TsHVpqT/FIbujYAyoOCUyBC0+BJ11sOqhNtopv9VFzVoQZPEbWsJD
 6m5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xAUGbKK/fQ8I+ulZb26pbb2JDvVKutYnIPXuPQk8XPY=;
 fh=kVxK90IDavuIyCA5gQtkGxIldLhJPj1NF7JQyMxdCx8=;
 b=iq2ickLT4X0PhlDZvv2HdAGDzotiXaEfKuhlFzIfHGD1TdVh834rB2xqb4ivi/X5Iz
 K8OYhygLf23K4HIz33OcnJObcBC9sl4lrQfauKDb55L1d4pQiQK1q0uYGaBVyZyVOeIS
 1xS+eMr3ORW2HTwvY00lp/rkyM3/u8XV542xevj0rq2mqFAYjchpvOGmLDGNJZlSD6SG
 5U6z2LR/JMYNshJPEyn4xfLH2nTBtFqyw0FKtTHJc16I9tJNi+FoKnYrRCIxsHGy7bEf
 lRfDjK/XzN2nP5YvOwkf04lOlYmQjqlpAMzfl/1UGQuac3ugY415IehFCg7XugW/cQI0
 vThA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776172297; x=1776777097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAUGbKK/fQ8I+ulZb26pbb2JDvVKutYnIPXuPQk8XPY=;
 b=BZiajlVqwDbLpL+ZXq0yR1Om0zeAfFybcyhXZBB4UqYrWdQsrT14NHU2CYajptNduC
 8pOlmsb3gF5uX6m5ak7ngzhtjsGrhUaFbz2XlxcqtWRiNUS8ND9pBHT1BDPb+dCHh5Lt
 ww9T1fU3V9BD7dkFbxFE8i0Tz1wbPJQp+M4KBhhcQHhLD5ZzmNHRNCLr7L66telxvXke
 nOHzggFdqAwnd1aAtxVi6LFIEukPCOYuAUkp2e7vvWYs9Z1CPMtdCOtklzz+yVB/3Iyt
 zipP94FNLP8p6/lq9uxUFQHjqcRjbiCCHoeXTWLXheGyaRS4Cvk6RaU2xUYY653wVWsk
 Liog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776172297; x=1776777097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xAUGbKK/fQ8I+ulZb26pbb2JDvVKutYnIPXuPQk8XPY=;
 b=SEgaOCmoAE9Y7mx95ySRzhxAKt3MrqG0Xr7F2IqyqrY1fAyrd8RDY56sjkv7Hz28wl
 sYLXi3gbYNBkX11xkIoisanNCD4vZjJZx/U+xqHr/VWB7wvZUaDFFPse+FegDtkS/ISl
 Mtd1EyzS3FcCM7ikr4LYnd2YGk8QAMvFfPfkF70+ZwMNy1uTvTH9JnsokVn6Qq7K/sO8
 j4RLUNqpxlHr0p3beahIM1YPNjkW1oJoE1eFaKD9HhYMoT940eOS6oeo2tRjgDVJgWf/
 NVXcIjqX59WaA+MYM2j5k4CORwd92NZb9ogfmIHW4v0w9HJxJk/2Cojed77C+6b6KuN5
 9rpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pRLK/XEQNw1Kbe0+P+CYn1rPPafpY0aEievIv/7ZSfQBgP8TV/4e0SRZwU5mye2KwI0uQ8mzQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+x9bNKJaFtnrhAJlg//s8p2nDmQu/dGj2ylLUaNUJ/nWvxk6h
 VAtkkkzyJADfdoUedsIdJcYCIxWHzV+9102XS6sb3oZ5GjkjE9J87HSg/h6v3K+y7ujNyYozXgr
 iSVFBh0E+gudgRDEpouLslc0/CW5hZ3g=
X-Gm-Gg: AeBDieuZC0zX1VvG9KjeRnVlynz0kvwisG5L9MyYq04Yoo+txH8QrdnqH/V3Ty6vlW0
 Vg65NuHQBQnV1L930goV2Wr22Z721ZvoYYGy7pdQb4sG5ltxvO2z+i8MZMb7JrkCM6Ow/MZjOZG
 CxR4x/pv10q7Ez3iWvjLSXW6gxUelYVoJGxtOqFK4WoMB67cfrcBEG0QLHnqAOYi0DiAjHcLoGV
 VK55xUTnRpZbARmz8+3CDPDvXgncb14xsE0dsOyZfYPhtyj4tSkttU+mfrccP188e2hKRqqgGdE
 bTGQCMyA8aTtIcvEDx0HKjSX3pZdbqINt5NIt1v/XaTeZjYMgO/rBmI2NQY484BRdONA9Q==
X-Received: by 2002:a05:7022:31b:b0:12c:3ef2:ef0b with SMTP id
 a92af1059eb24-12c3ef2ef95mr3052157c88.6.1776172296806; Tue, 14 Apr 2026
 06:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260406225008.2787532-1-werner@verivus.com>
 <20260406225008.2787532-3-werner@verivus.com>
In-Reply-To: <20260406225008.2787532-3-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Apr 2026 09:11:25 -0400
X-Gm-Features: AQROBzAsbCXMjAgIiqqWYbip5sdNaqMuufvvZpt7WJlaFFjmFoOYluDAPOh2VSY
Message-ID: <CADnq5_OVN+uCioTWNeuHkGpkUU-VhEio_uMEBMVur6-hWXwtug@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon: fix integer overflow in
 radeon_align_pitch()
To: Werner Kasselman <werner@verivus.ai>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
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

On Tue, Apr 7, 2026 at 3:41=E2=80=AFAM Werner Kasselman <werner@verivus.ai>=
 wrote:
>
> radeon_align_pitch() has the same integer overflow as amdgpu's variant:
> 'aligned * cpp' can overflow signed int to 0 when alignment rounding
> pushes the width past INT_MAX/cpp. This produces a 0-byte GEM buffer
> via radeon_mode_dumb_create(), reachable from unprivileged userspace
> via DRM_IOCTL_MODE_CREATE_DUMB on the render node.
>
> Add an overflow check in radeon_align_pitch() and reject zero pitch/size
> in radeon_mode_dumb_create().
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>

Can you fix this up similar to the amdgpu patch?

Thanks,

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_gem.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 20fc87409f2e..2cd179fef347 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -828,6 +828,11 @@ int radeon_align_pitch(struct radeon_device *rdev, i=
nt width, int cpp, bool tile
>
>         aligned +=3D pitch_mask;
>         aligned &=3D ~pitch_mask;
> +
> +       /* Guard against integer overflow in aligned * cpp. */
> +       if (aligned > INT_MAX / (cpp ? cpp : 1) || aligned <=3D 0)
> +               return 0;
> +
>         return aligned * cpp;
>  }
>
> @@ -842,8 +847,12 @@ int radeon_mode_dumb_create(struct drm_file *file_pr=
iv,
>
>         args->pitch =3D radeon_align_pitch(rdev, args->width,
>                                          DIV_ROUND_UP(args->bpp, 8), 0);
> +       if (!args->pitch)
> +               return -EINVAL;
>         args->size =3D (u64)args->pitch * args->height;
>         args->size =3D ALIGN(args->size, PAGE_SIZE);
> +       if (!args->size)
> +               return -EINVAL;
>
>         r =3D radeon_gem_object_create(rdev, args->size, 0,
>                                      RADEON_GEM_DOMAIN_VRAM, 0,
> --
> 2.43.0
>
