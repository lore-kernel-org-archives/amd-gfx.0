Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D482C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 19:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B6FB10E44A;
	Mon, 24 Mar 2025 19:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E9Zz6K9e";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988BD10E44A
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 19:48:00 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-224104a9230so10658825ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 12:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742845680; x=1743450480; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOS0u4ilj3JJ/v+GbpU0A1hcbS4vr855P7G09ks6E6U=;
 b=E9Zz6K9etbPP0LuOIfW/4Jf2pzk5sWDgYtkwKvhVlhUPA7cu7f+Sh2ImVI0nDz1jEl
 DZBFRZT7bBTe2AmHIMHNmq410lJHAY4bdWyM3YATXJd4RRv1XDcIlax9eDjOjGD95B1g
 5bgIHjunJxgsLuGrx+uhEL0rN5mtuDocNjy+qCWP9pfcspdMhTIj/I2eP47v/fZsTJjj
 u4NSeTFtzrGuVdmZxC03b4qi4Qb+jbRq+F/+y2q0U0sz2AnIZDbTKZHGypsa5QwUbcv0
 6PGP+H7OoQDqYRyyflb8uYKWuBI0SrtNPZZ6D1cEsuwuOxgMLbBHV3fWEOxOz8JyjeEX
 4EqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742845680; x=1743450480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOS0u4ilj3JJ/v+GbpU0A1hcbS4vr855P7G09ks6E6U=;
 b=MzwupYV9mQ8PI6CiUzzZ1z0JOVe/MoIOc5zXV4mcShm+QM7W4mm35p1mwfK+OovchX
 RoXxm30L2pL3vKJTmdt8INUo828hpE4/Kj8olies/YKMBbnYa6yE5FusNBDe3SuLCY9Z
 7iDfNZ1YtwkbWTSsSZIMx3n+4yoISZ0dgltSGecCEAcBmWK9nwlNbe+h2qc/McmFp9dF
 issXnHcjrnLH4F4WhkRNq+0dR37RWfOECg1JCyW/Z/1oBytnK9p3gdvXKUxiVs6ox427
 SUnEvk16wPLK9FnklxV8TGGDN0Y5JU1JHNSM96A1H5vtLtoIbKprhn1as6H75mYr4E9e
 g/OQ==
X-Gm-Message-State: AOJu0Yz6z/VeZ5rWsiGpvwuVTo3HtHwBB39+mRkkM/ok8SzIFhAe4Mej
 R6EYblkDK2Ei3PJZRzo8oyJrWJ0MGO90TYOVjvTMyu2+MLc2WQ0A83VHdcdFpmrU7nWChHsJSvu
 l/2dfW1cwVvkbNlazPWoxwnzyEEY=
X-Gm-Gg: ASbGncvw8aXJIRb/8esXV1NUE2nWh3edcT+NXggwEbcdVwniu57W9RosVYLzqHIHZMj
 sj4M7VWLDE4EXr3yb30zHzGY4rP08K6bg4/THPNS+fyunmcBiKwM6ezx7QuakUuzitPcCZChe1e
 RKf22hDUUJ2lkdcMSjNOSjRevxYQ==
X-Google-Smtp-Source: AGHT+IHZR5KRRAKGnrDCi9+uU+cLtF+ige4RBmjWvUr1NQNrNaZBprOxLPybFseIpVvOFtlGTYYj+Mqo+D88FsbjpD8=
X-Received: by 2002:a17:902:c944:b0:223:659d:ac66 with SMTP id
 d9443c01a7336-22780e1418bmr76090145ad.12.1742845679918; Mon, 24 Mar 2025
 12:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250320161540.1213501-1-alexander.deucher@amd.com>
In-Reply-To: <20250320161540.1213501-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 15:47:48 -0400
X-Gm-Features: AQ5f1JpiXIhsbPCE0C2eQVdENS2omIyaHPLjLA1q2UKWBkI8usnN-acEmvfquoo
Message-ID: <CADnq5_ODAThf4s7HF-KUVQCtzR_E1QfauN2xKzR2wZfs+vqeoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx12: fix num_mec
To: Alex Deucher <alexander.deucher@amd.com>
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

ping?

On Thu, Mar 20, 2025 at 12:22=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> GC12 only has 1 mec.
>
> Fixes: 52cb80c12e8a ("drm/amdgpu: Add gfx v12_0 ip block support (v6)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index f4ef81ce36701..ae41c91c9f6a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1398,7 +1398,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 adev->gfx.me.num_me =3D 1;
>                 adev->gfx.me.num_pipe_per_me =3D 1;
>                 adev->gfx.me.num_queue_per_pipe =3D 1;
> -               adev->gfx.mec.num_mec =3D 2;
> +               adev->gfx.mec.num_mec =3D 1;
>                 adev->gfx.mec.num_pipe_per_mec =3D 2;
>                 adev->gfx.mec.num_queue_per_pipe =3D 4;
>  #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> --
> 2.49.0
>
