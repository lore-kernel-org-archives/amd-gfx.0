Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13097C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 04:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D5B10E035;
	Wed,  7 Aug 2024 04:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LeHpKQi+";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D282410E035
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 04:00:15 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so813055a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 21:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723003215; x=1723608015; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoh2Zvh3JPUdPw7A4h/hm2sY9uSJsvHdN65Sc5mp4DY=;
 b=LeHpKQi+YTh0F+FrrvuJPt8iYDTs2W7vYqZq6YabfhuubjjkB/OSG1HFNCr3E6RP+8
 YwSZyWSB9tSe+9h85cdEpAHXkTN2S/L0TBTycLdBH/JJWIoZHIlvP0YNFfH4ko+8t75P
 +94JtP85Mis8f4jsNlTCPvur96YdLYL9Ya4urL4thuvpEdcfpMKvmi5tZduUHTzVDqVO
 b8k01s7qwNjrqi5twYdiN/XZTQefUHD9+pm9ELONRjdleKHormxSG0LOEmRuYO6THhCo
 ff0rKQO0KSLqBBEKRD40lhlJGPumrcVKzz/qM7pBZCLwMWKJLQVg1b78uj+GS20ormPx
 B81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723003215; x=1723608015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hoh2Zvh3JPUdPw7A4h/hm2sY9uSJsvHdN65Sc5mp4DY=;
 b=ASBM/nl+MSDMMbnHo5N3rhieMLSrBOqjTtGnR2PKnSrwZafPtSfnmFOBjM4bYxCUFM
 tR4aNwneIHw4OUb0lW1P0iXYOz0FyciRcP3c6F92uwjFh6fiZeeLcgzi9uV6/YzhTs+m
 rkFh9+uppQ0/+UZVRMzJyXLF+LAQeSgoAsgauC+z6D7Um409WU/Wa8UqDJlMb7Vw4726
 Uop/PLG1x7X0H3itCi99CWlEgTacEt6rKp3M9T2qvtJPgkUkHOw2cLnVYrad2YBkZgLI
 93xgt/w/d8gSYdo9fv9u3BwBYvpAAvTw0EGhjPig/6l3OoiaDl6qfqw9IFbFHEtjr8sd
 6D7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIoSfjRAp+cA2EBMz09YnGb7aJ6S39CGiCsKOF1jmYr88JIdGFxz95pB72VbCqgoL++86h8PYhUfB7n/3bNbMRr/fbNKmHFmVUATQ1RQ==
X-Gm-Message-State: AOJu0Yw98hE3RziMwbSuY2aCKkJjNyDWRxdSr6IZQcRUw0gFkioCBGaX
 QOtg/MsC0SMgt/W2KUzPNBHjUWzzpB/3dxs/9RprsWvGAGcIko81NlYgGYP4lGnvxHVOPlleQWM
 15omQxbqQ8Ng5VZmjmDohuLKiY/Lh8nze
X-Google-Smtp-Source: AGHT+IG15FMUpCrUZkp0ffdMM40Pdv6r6sgVh/cpanPz+sSuquulSwSLvkZPYvh11O8dfC9WSTo/CwLcYwmwM/GR4BI=
X-Received: by 2002:a05:6a20:258e:b0:1c4:ae14:4e3d with SMTP id
 adf61e73a8af0-1c6995809d9mr20615278637.13.1723003215126; Tue, 06 Aug 2024
 21:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
 <20240806081825.2422771-16-sunil.khatri@amd.com>
In-Reply-To: <20240806081825.2422771-16-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Aug 2024 00:00:03 -0400
Message-ID: <CADnq5_Ps1k02WcJstPhM8D+PG1ia_jwsf62bwdHLCGcv2dsuZw@mail.gmail.com>
Subject: Re: [PATCH v1 15/15] drm/amdgpu: add vcn ip dump support for vcn_v2_6
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

The patches other than 4.0.3 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
I think 4.0.3 needs the GET_INST() fix.

Alex

On Tue, Aug 6, 2024 at 4:18=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> Add support for logging the registers in devcoredump
> buffer for vcn_v2_6.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index fdbf56a0e46e..d3e00c0bb608 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -2056,8 +2056,8 @@ static const struct amd_ip_funcs vcn_v2_6_ip_funcs =
=3D {
>          .post_soft_reset =3D NULL,
>          .set_clockgating_state =3D vcn_v2_5_set_clockgating_state,
>          .set_powergating_state =3D vcn_v2_5_set_powergating_state,
> -       .dump_ip_state =3D NULL,
> -       .print_ip_state =3D NULL,
> +       .dump_ip_state =3D vcn_v2_5_dump_ip_state,
> +       .print_ip_state =3D vcn_v2_5_print_ip_state,
>  };
>
>  const struct amdgpu_ip_block_version vcn_v2_5_ip_block =3D
> --
> 2.34.1
>
