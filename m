Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9011C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 21:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE2510E160;
	Mon, 15 Apr 2024 21:32:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j1BuI7f6";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8EFE10E160
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 21:32:33 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso2216712a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713216753; x=1713821553; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTWHooD6OGghpZ0kPpNPNMfvNlEx6jWWxaT6TeBiLSY=;
 b=j1BuI7f62ZXulsFICdAEYGN+6zuleRF4axrw78fHWARevx6LImOiL7ECNUa060JDII
 GYPBmGrBUZXKEPTxwf0d/VpFUMMmjP6o5NR01ByPsWYjUK2fEBGKGQccd1twIIUMldxZ
 I5hJfpIDyBHkohaQeF4O2kt+lEdS4Eb/ggkbfF0Z3H373xXRbMKHTqYHPrMvEB74kpFw
 CxaufclHwv9NU5I9CkXbaTNHhyAO+FzGLUJJBGhhqtJORWkYveJH5GPuEN7Kvq3cQ3eL
 NB0OL7ZKGiUNAHiWws4QaOG/h4p3oWt7MKQUq+EbpukqtH8wSxRvYyTAJQIlSsM0d5Yi
 2ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713216753; x=1713821553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTWHooD6OGghpZ0kPpNPNMfvNlEx6jWWxaT6TeBiLSY=;
 b=D7QucWXAFUUO+zwvtdoEI2SaUz599ThKlRZ/40wWqE+RLZBS8A7bwOUC0x7MKLusTZ
 7bZbmqeBYv3Ohr14X4V5wlml2tCZzg3OGY+0PMm3rb6OvKCtutpQdNMuIR3VjGY2DI5v
 vUxNW+WpoDxaNlI/lQWV4yAQZl13jVqCDZpAshMFe/bzV+EKOgd2JvoKi7plC4R17Ls0
 04TUo1D8md/xzmUY8c4KWIS+zzJ6055q3xCMXh7PMjVWQCcvvEJ89IpxmAvOn8gAlAAD
 Ho9HSbcuREeE+DQITG1aniPLybwccz8GZjNdt0TuM0NC/Opn3t+SfxctR6QFSoqWYsiI
 VXzA==
X-Gm-Message-State: AOJu0Yxjv7NOJTkQPDCDKtgkjMRRnp6gBkF1H074VjqrE7Xei9OQIZ5D
 yXiX2tY56Besz9okfGK8ib10IiyOLKUh0YgM4z0YYDDgTkgXQFBfgPn+h5hQt4V8Pml1sNyFmve
 FVcuUjRbMnTUQxv+PsLh5el/OIbE=
X-Google-Smtp-Source: AGHT+IEu0zo4Rb1w5v6roMcvNUCDMYC9rrxrNOdAoGzrZv6nvOhjuh8gGMVeREIrsF4ITnrjJ4GByWGF0HoqZFJNsSA=
X-Received: by 2002:a17:90b:180a:b0:2a4:a87c:b907 with SMTP id
 lw10-20020a17090b180a00b002a4a87cb907mr8579797pjb.4.1713216752948; Mon, 15
 Apr 2024 14:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240415212500.1097164-1-sonny.jiang@amd.com>
 <20240415212500.1097164-2-sonny.jiang@amd.com>
In-Reply-To: <20240415212500.1097164-2-sonny.jiang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Apr 2024 17:32:20 -0400
Message-ID: <CADnq5_Oy6zckDHsqz819fpg8tgH77GYDR2N=8Zucah4n+rpHrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: IB test encode test package change for
 VCN5
To: Sonny Jiang <sonny.jiang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sonny Jiang <sonjiang@amd.com>
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

On Mon, Apr 15, 2024 at 5:25=E2=80=AFPM Sonny Jiang <sonny.jiang@amd.com> w=
rote:
>
> From: Sonny Jiang <sonjiang@amd.com>
>
> VCN5 session info package interface changed
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 7d176046498f..e08aacacc43e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -882,7 +882,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgp=
u_ring *ring, uint32_t hand
>         ib->ptr[ib->length_dw++] =3D handle;
>         ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
>         ib->ptr[ib->length_dw++] =3D addr;
> -       ib->ptr[ib->length_dw++] =3D 0x0000000b;
> +       ib->ptr[ib->length_dw++] =3D 0x00000000;
>
>         ib->ptr[ib->length_dw++] =3D 0x00000014;
>         ib->ptr[ib->length_dw++] =3D 0x00000002; /* task info */
> @@ -949,7 +949,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdg=
pu_ring *ring, uint32_t han
>         ib->ptr[ib->length_dw++] =3D handle;
>         ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
>         ib->ptr[ib->length_dw++] =3D addr;
> -       ib->ptr[ib->length_dw++] =3D 0x0000000b;
> +       ib->ptr[ib->length_dw++] =3D 0x00000000;

These patches are touching common files, are these changes safe on pre-VCN5=
 IPs?

Alex

>
>         ib->ptr[ib->length_dw++] =3D 0x00000014;
>         ib->ptr[ib->length_dw++] =3D 0x00000002;
> --
> 2.43.2
>
