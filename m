Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE38BCAC5A0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 13:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C0B10E89F;
	Thu, 18 Sep 2025 13:12:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I9D9DTpo";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0634B10E8A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:12:23 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2630354dd1aso1817175ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758201142; x=1758805942; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ow/FekpgA7UhV9Mvh36laSeW60WQ/h2Ti7HkmGFnCsM=;
 b=I9D9DTpoSIyHbtqQR1QCxVzbfouq6MLVBPUOgmN0+uwB7Fc8FLj47R7r4kDG03azwx
 S6/pb/hkf9XjHIRZiGo52Fzkd5wbDNiMCIUialvSodQkdDjaPLJknPooRrpbzuuZQtlT
 gKrLO9ueA/CyFizrIi5gjw56BMXet522y2ibm2vPaZ2BKkxkGYFkAPmVZ8LY4qMkQu24
 BEfxkU2BQDBYd/Lku02Pip5ZnL/W8egbwCTiqRKYe/1cWBYkhp6i7L1GiZQSmRxdO4jm
 qwxcwiOxuNuTJ11E/93HfZ7ODpUwwT6VXG13HJTZPN/YSMb64tG3UtO+cOCNhwNaYUjA
 NtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758201142; x=1758805942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ow/FekpgA7UhV9Mvh36laSeW60WQ/h2Ti7HkmGFnCsM=;
 b=Dt6f5WKZvCYQx6bCP7wFdpLSdBK188Rp1Ial6rpjzG53bBV9grc2m8B1dNaI2W5n1z
 CSnkO5Fn3MJuG7TdU7206xobujO0wUeKx3E5t5ABlv4VFBCIaU6K72LDxJ0ffNo3Zj88
 ne8uzETMQEdMrCy6dzD/FCC3wafw6AVFfuLg322KpURfx1lctaEpVhF2zOt2RIpnAd7T
 FWEU+K9xxoWK0HLmQY/1hXcnrLUL02/OmWwBVVCadl7NUAJs0kliAkMZIfqRRPSrWAOv
 kiNQBPXbGrLdEcqd1Krt0QETGe49AvNMz66YwjYOBKw/LOqnDR19kKq62h8X4BgT2BQz
 J2XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4nhiWz7ln+9CoR/H1AIvwa2nLurwwvMAP9eBpnYuQt2rVG4UcKT3pA+W3kDa8GWZVR6S/sc1/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnHOo4vIGTeJYprqw9zF+fYhspKSlpEcwxIIg37H/MqtDJbnkg
 6v7dz/IU73VnfIEzA3ZNr3qJTQXR01It2K9M5wMbSbZhBUbUc9JDD7QfRz/TzDKybRp4I1yZbkp
 PeSgXic69YX6Ukkib8qjI7dFC386s1gM=
X-Gm-Gg: ASbGnct/ViuScIijQQI78ljxjEnVhygGyRuPujbLAs31qZWpTuLyjokFNE0aHGPF/vG
 jI+Cm13+c2/ZhdQ/6ELUv/PBIGRNPgu3PBxiJUC6WPKkq3IpGThHfGN8eh3ImpA4qgl0wYWsW6j
 uqRDfSVDGsbo+AvIUuBX5RBd8vTniNF5jMjz0KZolXbReDNzjTzOvgK40cTTA4GuTYDxMDM53hr
 EsX9S36yAwjM3KrnL6xqv465ik=
X-Google-Smtp-Source: AGHT+IGPGpvPJnDMA+MU6VEF8DQ0xnGm1dy+iqzuJdF1p3969ZuqYgSVs9i3T569keWH/YmK9RWABocwx0S6kTCDWjQ=
X-Received: by 2002:a17:902:ce81:b0:269:9ae5:26cf with SMTP id
 d9443c01a7336-2699ae52d42mr9215285ad.4.1758201142273; Thu, 18 Sep 2025
 06:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250918105705.3480495-1-lgs201920130244@gmail.com>
In-Reply-To: <20250918105705.3480495-1-lgs201920130244@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 09:12:10 -0400
X-Gm-Features: AS18NWBryzMXeisWyksAUCkLKladPwFh28QPE6dGbAFuIaGpcNhnEsksRdkuC1w
Message-ID: <CADnq5_NQMQNpa7=MW4LXHvnKWTc4+QSEoA0zsNqpdfEV5Ho0SA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atom: Check kcalloc() for WS buffer in
 amdgpu_atom_execute_table_locked()
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Al Viro <viro@zeniv.linux.org.uk>, 
 Kees Cook <kees@kernel.org>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

On Thu, Sep 18, 2025 at 8:44=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> kcalloc() may fail. When WS is non-zero and allocation fails, ectx.ws
> remains NULL while ectx.ws_size is set, leading to a potential NULL
> pointer dereference in atom_get_src_int() when accessing WS entries.
>
> Return -ENOMEM on allocation failure to avoid the NULL dereference.
>
> Fixes: 6396bb221514 ("treewide: kzalloc() -> kcalloc()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 82a02f831951..bed3083f317b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1247,9 +1247,9 @@ static int amdgpu_atom_execute_table_locked(struct =
atom_context *ctx, int index,
>         if (ws) {
>                 ectx.ws =3D kcalloc(4, ws, GFP_KERNEL);
>                 if (!ectx.ws) {
> -               ret =3D -ENOMEM;
> -               goto free;
> -        }
> +                       ret =3D -ENOMEM;
> +                       goto free;
> +               }

What branch is this patch against?  This doesn't apply as is.  I've
fixed this up manually and applied it.

Thanks,

Alex

>                 ectx.ws_size =3D ws;
>         } else {
>                 ectx.ws =3D NULL;
> --
> 2.43.0
>
