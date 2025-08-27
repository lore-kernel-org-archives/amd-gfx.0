Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1449DCA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 12:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE00210E039;
	Wed, 27 Aug 2025 12:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fU/LrMLf";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5039510E039
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 12:54:54 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b4c54676186so28767a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756299294; x=1756904094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maq1UVnp5erCqyxVhxxp6CtYYOmDFtfNdKK2tulbdi8=;
 b=fU/LrMLfRfhtkZb11NkclE347c9RH4GyMVfNGcwhXFdG2c82MnVCrCWsgb7XaLQQY1
 jCPcUHTgG5ydh6shn97GRVUcjN7GBCQPXZ1OPx6Y25hPZ+UlRpwA2wRQBkFa6vSkwBGt
 BwaD5NPrfEuZy6wPIV0julcy0+A8GXGhlMXJ1l4/YI8fSGXqaQQ3WG1uhUank6K+bdGv
 inIb7O1aArKHzHn0Kj4VBGXzZ6y6Y268UGCVelCuGnMx91NyGLRqyhROZLkJv/tjyTwK
 q5B+VCBLyr0iOuiN7313esKECHk+PcLzViigKUuBpvq2JvMk8ZnyQ27ciacu/grHjU0w
 zSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756299294; x=1756904094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maq1UVnp5erCqyxVhxxp6CtYYOmDFtfNdKK2tulbdi8=;
 b=Vo/GPr39viUiKYQ3CNGmUh1ImU2bCZje7jjMAboBDw0QwpLymVnMUWVtcPaQJIRvfq
 /n0+LK9YDxkqCSR6DIVLYsGWUv4GWLW5W1qeHQ7PfXjQQfsahS6JPwdyFFNdfLu70onQ
 k0N3ChVus9Fp8CdsR2zmrWsuEBVJmWg+URIhzMppg7krK/ujn0HjS3BU5I4RwlAXgW/y
 S6wFJVtAYo6tieh1O7bG1Uf5QGJUfe2+V01JfGWL3SEhoynlVDUDzKQ9UZ/t4YSa0RLX
 Sd2b4v1rsY8ZekiLSE3MSKFPgOJxAsjOs0CA1T7OElJQGdjzG483BThSYGxbC+iXTp/h
 CGkg==
X-Gm-Message-State: AOJu0Yyc3IrXG0WwSw48TrOPKlZdkCIL1MNOMavqoQ4UdlM3o3OKO3Aj
 8BeRj9qoe0N6cXhQWOxm9m+w9q2gpbn1xUrJJKmYIrF6ZcaYZF2ksKlnAs1sb5VJESt4Uz9JjrK
 oDw0rDD70kfIFYrWiMc8sd7rhIpza3W837w==
X-Gm-Gg: ASbGncv3a8nuvzhvi7+7ijyK+h90qbkHJGNJpw26LnlvVHu0Jq6lAyUdDz/UqMeUJgz
 hEMZQkRf0pyB1vayYjKjWu3uZGHsblTToyYB71fBLNQnE1HdWd1owsa9I4TUcIt+E7+XlABXRKq
 T2JpYYB8DzWdQX0n21WruLO3zwYgh1FQ/nER3nhSsZheYTOSDEHdfVDSxUP3GyWm0Jesm24ZR0I
 l1Gkbo=
X-Google-Smtp-Source: AGHT+IEdR7Itzgjr/uIjDX0qb90PRFfH+ATVURR0x/aPdJxMRkVKdujb3AIeVvE+xg27eYqrsVPKnytzlEQyf1XKApc=
X-Received: by 2002:a17:902:e744:b0:248:7a43:e1c5 with SMTP id
 d9443c01a7336-2487a43e264mr38542905ad.7.1756299293647; Wed, 27 Aug 2025
 05:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250827054330.1791207-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250827054330.1791207-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 08:54:41 -0400
X-Gm-Features: Ac12FXwMpn_mHH3mK2dM6bMX1z17BQGDivw7OHW7ZLNkzH1-WmV5Q5wcIJleHNE
Message-ID: <CADnq5_O74623id4qBZHE3MSWbBy4t-5jZTULu2T4v=rMAYn7BA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma: bump firmware version checks for user
 queue support
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Wed, Aug 27, 2025 at 1:43=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Using the previous firmware could lead to problems with
> PROTECTED_FENCE_SIGNAL commands, specifically causing register
> conflicts between MCU_DBG0 and MCU_DBG1.
>
> The updated firmware versions ensure proper alignment
> and unification of the SDMA_SUBOP_PROTECTED_FENCE_SIGNAL value with SDMA =
7.x,
> resolving these hardware coordination issues
>
> Fixes: 604d44879707 ("drm/amdgpu/sdma6: add ucode version checks for user=
q support")
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index e6d8eddda2bf..db6e41967f12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1377,7 +1377,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
>         case IP_VERSION(6, 0, 0):
> -               if ((adev->sdma.instance[0].fw_version >=3D 24) && !adev-=
>sdma.disable_uq)
> +               if ((adev->sdma.instance[0].fw_version >=3D 27) && !adev-=
>sdma.disable_uq)
>                         adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_me=
s_funcs;
>                 break;
>         case IP_VERSION(6, 0, 1):
> @@ -1385,11 +1385,11 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                         adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_me=
s_funcs;
>                 break;
>         case IP_VERSION(6, 0, 2):
> -               if ((adev->sdma.instance[0].fw_version >=3D 21) && !adev-=
>sdma.disable_uq)
> +               if ((adev->sdma.instance[0].fw_version >=3D 23) && !adev-=
>sdma.disable_uq)
>                         adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_me=
s_funcs;
>                 break;
>         case IP_VERSION(6, 0, 3):
> -               if ((adev->sdma.instance[0].fw_version >=3D 25) && !adev-=
>sdma.disable_uq)
> +               if ((adev->sdma.instance[0].fw_version >=3D 27) && !adev-=
>sdma.disable_uq)
>                         adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_me=
s_funcs;
>                 break;
>         case IP_VERSION(6, 1, 0):
> --
> 2.49.0
>
