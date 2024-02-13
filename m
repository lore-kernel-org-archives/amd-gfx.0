Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA49C4829A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 20:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8408110E292;
	Tue, 13 Feb 2024 20:21:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i6cITONF";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A507810E292
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 20:21:48 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-296d24631c0so2784481a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 12:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707855708; x=1708460508; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IK2qy2bLTrXhpTJ5/K6WtigVNgJOT/4OfpnIJ3jC8dg=;
 b=i6cITONFmilsYnDJC7r6KaS/MzmDC2g0ou7cdOTAzQYi26Zl592zdWQge15niI6j3m
 hK25kSpd3L/eXZpWIX0p3z4iijmaCtN0KEG5Ro7HDJuNYdToa+ZeBaJz3eMEh7RR6jp5
 YpOLamY2QDP2wWJYOFfjwbzfWPPbUC3NWgiHvP2ORhtMAbAiyol13+6XWabkMrhRPeql
 0ipZAFxlTAqRlHK5P9V7GTzZWK2U6k2YQKv71IMFgINCeH0sv62VQi/jf6h7NtNGiMUT
 tRuAOrMldwpJLTR8hQ3jj/rg0X3B1txRVsqgqsooebze412h3k3IBUDGY85cZLUIDF9P
 nKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707855708; x=1708460508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IK2qy2bLTrXhpTJ5/K6WtigVNgJOT/4OfpnIJ3jC8dg=;
 b=lZadVdjjB5gdO9poSFi2pQKN5+M3SrdIO5nxjX3aR+EQYOpou5QQyeKiQRV94wnrvA
 BbbSjpXuoYxOvqhckv4ICrOYgqUK/shyvIt9knlFKngfjZ9TJp/BEGVCnIEjIUFUQZbz
 ikHSzDGXwyGgi9jWDAd7PEbXjVdnQhgPUQTTfHReOsjTsVo/XJM8lm416tL65uk8JXR1
 XWIwDAmkkOn/tAPXyPdvOTmM6gWH4RKsgT7+DzlB1EshI30yQDAwb+VyqXhRFTQTpxke
 uCnXXcrvfdXiUNyMFDK4MOCJG7HC6MIAaRF7MUg+YO3t+rKy1szcUzLLmjPRU4tuUeV1
 F8bA==
X-Gm-Message-State: AOJu0YyOk5O5QvB0duPPcaec/2RtnZ7LPHX2aAxOBbfPUy1ILuag0Hp3
 T8xWTsOdkNCdY/Jo1jyyo6PuaAw3Rq6WkaHw2zJ+S24NY228K1yB53gg2b25HuT/tBYjhjAo1od
 o9GjFzS6bFdtUGoTDc3yJtM1b3XI=
X-Google-Smtp-Source: AGHT+IHDInFIcddfugZ5b4AD/LSe7jnPtrlHY+W7/1usCvVeCco+eO6c0Z0XQ2GjHTbpumJ2JO3+C5MKno9lPF9GMBU=
X-Received: by 2002:a17:90b:3714:b0:298:d1ee:17fa with SMTP id
 mg20-20020a17090b371400b00298d1ee17famr61513pjb.5.1707855707994; Tue, 13 Feb
 2024 12:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20240213184758.1503483-1-David.Francis@amd.com>
In-Reply-To: <20240213184758.1503483-1-David.Francis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Feb 2024 15:21:35 -0500
Message-ID: <CADnq5_MBYJmZJUX7UU5-gY9ZswOWNUiFD0LUFMQPai6de5zajg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Allow secure submission on SDMAv4.4.2 rings
To: David Francis <David.Francis@amd.com>
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

On Tue, Feb 13, 2024 at 1:58=E2=80=AFPM David Francis <David.Francis@amd.co=
m> wrote:
>
> This flag was accidentally left off of SDMAv4.4.2 when it was
> added. SDMAv4.4.2, like all other SDMA engines, does support
> secure submission.
>
> Signed-off-by: David Francis <David.Francis@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index fec5a3d1c4bc..bd29b13bc3d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1839,6 +1839,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_r=
ing_funcs =3D {
>         .align_mask =3D 0xff,
>         .nop =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>         .support_64bit_ptrs =3D true,
> +       .secure_submission_supported =3D true,
>         .get_rptr =3D sdma_v4_4_2_ring_get_rptr,
>         .get_wptr =3D sdma_v4_4_2_ring_get_wptr,
>         .set_wptr =3D sdma_v4_4_2_ring_set_wptr,
> @@ -1870,6 +1871,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_p=
age_ring_funcs =3D {
>         .align_mask =3D 0xff,
>         .nop =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>         .support_64bit_ptrs =3D true,
> +       .secure_submission_supported =3D true,
>         .get_rptr =3D sdma_v4_4_2_ring_get_rptr,
>         .get_wptr =3D sdma_v4_4_2_page_ring_get_wptr,
>         .set_wptr =3D sdma_v4_4_2_page_ring_set_wptr,
> --
> 2.25.1
>
