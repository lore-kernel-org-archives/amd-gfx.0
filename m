Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51C0C79FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 13:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF2310E842;
	Thu, 10 Sep 2026 13:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZzgXBNdL";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FFE10E842
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 13:32:55 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f16f12so2157671e87.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789047173; x=1789651973; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WOwxlgokdHb2jfAdfUM240g2J7udr7nQghWxHkBF554=;
 b=ZzgXBNdL8eG2fjI7+htbOmAH8sjatbboM/M46XL1wiyhEyj79T4MLqE48zNkLN6uwr
 xF9UeSzv344I0W5JtZyDihuCcwn/ejqCJBzQLHJk/LvXJBr9zXkBEWMFd4mDZn0oMMZJ
 4Ltt830uPPK3uKg8WCjlV8tSonQL+KeRGg75YtB/DWC1tphyPBlUu1gVNiXqmDzpLr7m
 r1rwrWm5l42qlOBrz5abSoM9kVtlRi967XE5hMvWsuF/QlgSF4i0Im8WMkYsz5p/w2gX
 KIyLsXset/zuFkAMD95juAAbhhWzQLZGBhV6RTqT2rL6CHLZfjYQmV5R+qEt8r0BWkfW
 Fyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789047173; x=1789651973;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WOwxlgokdHb2jfAdfUM240g2J7udr7nQghWxHkBF554=;
 b=VAYBLEpPSk2jzeXbwMNpFXciO1JUC3lUC2sAnqIO5WphRHv4I6qXr68vP2yUhzNYpg
 8x+pWvzcqulZdL4u5Xwzj7lEmFN0bwendH7asFny1KJq+WcN8wbpS/qQlL7J0yv0BHEh
 mYahC7r+RZaNgpkDrPHVnm7GT1R+Fuj04B3HX9UdunzqQojrs4E13hoYDJ5rWfnwf3Aw
 mAN28URUifAkidBF6AI9/dFf51/oZJMxrWmro2O12ICTs6GxR0cm4U24oiYIUAn/aUiL
 dvvy9J+7ka5yKZCIkXc583YENAJ26yoFkvuruqr90U2VtneVdvIGmzP7gPu38NgezpJR
 Bx2w==
X-Gm-Message-State: AFuF++nLPuTwOTgJhbV5EzO6cyaCCclgCw1I1GuxsPveGBqaJOuHGeos
 2gDW/pof/dFXvAg1igLtlcU+iuvDVOw5rJny5FwfFmUeOBGw8P7wVArlLNaAwQ==
X-Gm-Gg: AYBFou25K9zvVaOIQB5lA1zdb3fQ8xoj/jojoheALI9vFCYpsdJc5b5rdmqHTaSqRFx
 sKupaqDf+VQ1pDieK9PcB3uHRc50V1bmThxaqgsKBPUki1/KDeFoDp+NgHG3t/S6LvYXLDGfeRf
 +wN8g2uFVNyq0Fl1zDwnTmYLTBJ72NfSlmn8Hd02fyeded6AWuZN1jSzHuN03Wfk9Eks/7vj7cz
 8pxrhkUgNOL67XV5GMqOS2LWzOt8nOnl7ERvCKXCr7+cxLF2pgshNIJtBl6/jwa+tmwj8NMkR8r
 ELdgylERlSE63SrMBlealnLyV+nVbXV7QfD8NFhTl12W/cakn5pnL3xsVlzXeKNxIo7mdMcKea3
 IU4BpSOCnCxlPNu/wLqVtjLkvzXcirWBB0Beepu3il8SsYybzJlW8PpaY4OZ2GPXHA3xwahXYJk
 LIHGMF+U3fF0phblBIvNqxbwIhISkJrlEP6Fy5jV/qRa0vq5hWiQcgOfJIUsh5IIxtV+fZpZEYc
 8Iuf56Ja3Q=
X-Received: by 2002:a05:6402:5024:b0:6a6:32f5:90b3 with SMTP id
 4fb4d7f45d1cf-6a98e04ebdbmr9519240a12.21.1789046719283; 
 Thu, 10 Sep 2026 06:25:19 -0700 (PDT)
Received: from timur-max.localnet ([37.220.204.82])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a88b7c04edsm3413159a12.15.2026.09.10.06.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 06:25:18 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: Use memset32 for SDMA padding
Date: Wed, 09 Sep 2026 20:37:53 +0200
Message-ID: <ax2H_UmvS4-HpuCRpSm7EA@gmail.com>
In-Reply-To: <20260909105215.88242-7-tvrtko.ursulin@igalia.com>
References: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
 <20260909105215.88242-7-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. szeptember 9., szerda 12:52:15 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> Instead of open coding it via the inefficient amdgpu_ring_write(), which
> which the compiler is not able to optimise much, we can add a new
> amdgpu_ring_fill() helper which pads using memset32.

Can you elaborate more on that? It seems to me that amdgpu_ring_insert_nop(=
)=20
already uses memset32() so I don't see how the commit improves it.

>=20
> We convert the amdgpu_ring_insert_nop() used by the GFX rings and also
> the SDMA ones.

As far as I see amdgpu_ring_insert_nop() is used by all rings not just GFX =
and=20
SDMA, isn't it?

> Although with SDMA this should have much less benefit than
> with GFX (only SDMA v4.0 uses the 256 byte ring padding while the rest use
> 16), but on the other hand it should not harm and is at least more
> consistent.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 17 +---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 26 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 15 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 15 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 15 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 15 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 15 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 15 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 15 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 15 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 15 +++++++-------
>  11 files changed, 90 insertions(+), 88 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c index 686c92e96025..38434a4c35=
66
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -117,22 +117,7 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring,
> unsigned int ndw) */
>  void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>  {
> -	uint32_t occupied, chunk1, chunk2;
> -
> -	occupied =3D ring->wptr & ring->buf_mask;
> -	chunk1 =3D ring->buf_mask + 1 - occupied;
> -	chunk1 =3D (chunk1 >=3D count) ? count : chunk1;
> -	chunk2 =3D count - chunk1;
> -
> -	if (chunk1)
> -		memset32(&ring->ring[occupied], ring->funcs->nop,=20
chunk1);
> -
> -	if (chunk2)
> -		memset32(ring->ring, ring->funcs->nop, chunk2);
> -
> -	ring->wptr +=3D count;
> -	ring->wptr &=3D ring->ptr_mask;
> -	ring->count_dw -=3D count;
> +	amdgpu_ring_fill(ring, ring->funcs->nop, count);
>  }
>=20
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h index 6b6ee4083c8d..2b1d3956cd=
d3
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -522,6 +522,32 @@ static inline void amdgpu_ring_write_multiple(struct
> amdgpu_ring *ring, ring->count_dw -=3D count_dw;
>  }
>=20
> +static inline void amdgpu_ring_fill(struct amdgpu_ring *ring,
> +				    u32 val, u32 count)
> +{
> +	const u32 buf_mask =3D ring->buf_mask;
> +	u32 occupied, chunk1, chunk2;
> +	u64 wptr =3D ring->wptr;
> +
> +	if (count =3D=3D 0)
> +		return;
> +
> +	occupied =3D wptr & buf_mask;
> +	chunk1 =3D buf_mask + 1 - occupied;
> +	chunk1 =3D (chunk1 >=3D count) ? count : chunk1;
> +	chunk2 =3D count - chunk1;
> +
> +	if (chunk1)
> +		memset32(&ring->ring[occupied], val, chunk1);
> +
> +	if (chunk2)
> +		memset32(ring->ring, val, chunk2);
> +
> +	wptr +=3D count;
> +	ring->wptr =3D wptr & ring->ptr_mask;
> +	ring->count_dw -=3D count;
> +}
> +
>  static inline unsigned int amdgpu_ring_get_dw_distance(struct amdgpu_ring
> *ring, u64 start_wptr, u64 end_wptr)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c index 006f3fd3464a..e461e0236b5f
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -224,15 +224,14 @@ static void sdma_v2_4_ring_set_wptr(struct amdgpu_r=
ing
> *ring) static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring,
> uint32_t count) {
>  	struct amdgpu_sdma_instance *sdma =3D
> amdgpu_sdma_get_instance_from_ring(ring); -	const bool burst_nop =3D
> sdma->burst_nop;
> -	int i;
> +	const u32 nop =3D ring->funcs->nop;
>=20
> -	for (i =3D 0; i < count; i++)
> -		if (i =3D=3D 0 && burst_nop)
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count -=20
1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (sdma->burst_nop) {
> +		--count;
> +		amdgpu_ring_write(ring, nop |=20
SDMA_PKT_NOP_HEADER_COUNT(count));
> +	}
> +
> +	amdgpu_ring_fill(ring, nop, count);
>  }
>=20
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c index 3fb15032e1ef..5cca7f715c6a
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -401,15 +401,14 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_r=
ing
> *ring) static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring,
> uint32_t count) {
>  	struct amdgpu_sdma_instance *sdma =3D
> amdgpu_sdma_get_instance_from_ring(ring); -	const bool burst_nop =3D
> sdma->burst_nop;
> -	int i;
> +	const u32 nop =3D ring->funcs->nop;
>=20
> -	for (i =3D 0; i < count; i++)
> -		if (i =3D=3D 0 && burst_nop)
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count -=20
1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (sdma->burst_nop) {
> +		--count;
> +		amdgpu_ring_write(ring, nop |=20
SDMA_PKT_NOP_HEADER_COUNT(count));
> +	}
> +
> +	amdgpu_ring_fill(ring, nop, count);
>  }
>=20
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c index dfb0ea709bad..63bdf8d4e8d5
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -784,15 +784,14 @@ static void sdma_v4_0_page_ring_set_wptr(struct
> amdgpu_ring *ring) static void sdma_v4_0_ring_insert_nop(struct amdgpu_ri=
ng
> *ring, uint32_t count) {
>  	struct amdgpu_sdma_instance *sdma =3D
> amdgpu_sdma_get_instance_from_ring(ring); -	const bool burst_nop =3D
> sdma->burst_nop;
> -	int i;
> +	const u32 nop =3D ring->funcs->nop;
>=20
> -	for (i =3D 0; i < count; i++)
> -		if (i =3D=3D 0 && burst_nop)
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count -=20
1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (sdma->burst_nop) {
> +		--count;
> +		amdgpu_ring_write(ring, nop |=20
SDMA_PKT_NOP_HEADER_COUNT(count));
> +	}
> +
> +	amdgpu_ring_fill(ring, nop, count);
>  }
>=20
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c index f2e6abe44a43..145f862cbc=
c6
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -350,15 +350,14 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct
> amdgpu_ring *ring) static void sdma_v4_4_2_ring_insert_nop(struct
> amdgpu_ring *ring, uint32_t count) {
>  	struct amdgpu_sdma_instance *sdma =3D
> amdgpu_sdma_get_instance_from_ring(ring); -	const bool burst_nop =3D
> sdma->burst_nop;
> -	int i;
> +	const u32 nop =3D ring->funcs->nop;
>=20
> -	for (i =3D 0; i < count; i++)
> -		if (i =3D=3D 0 && burst_nop)
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count -=20
1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (sdma->burst_nop) {
> +		--count;
> +		amdgpu_ring_write(ring, nop |=20
SDMA_PKT_NOP_HEADER_COUNT(count));
> +	}
> +
> +	amdgpu_ring_fill(ring, nop, count);
>  }
>=20
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c index cb36b38582c5..124bc5768983
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -407,15 +407,14 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_r=
ing
> *ring) static void sdma_v5_0_ring_insert_nop(struct amdgpu_ring *ring,
> uint32_t count) {
>  	struct amdgpu_sdma_instance *sdma =3D
> amdgpu_sdma_get_instance_from_ring(ring); -	const bool burst_nop =3D
> sdma->burst_nop;
> -	int i;
> +	const u32 nop =3D ring->funcs->nop;
>=20
> -	for (i =3D 0; i < count; i++)
> -		if (i =3D=3D 0 && burst_nop)
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count -=20
1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (sdma->burst_nop) {
> +		--count;
> +		amdgpu_ring_write(ring, nop |=20
SDMA_PKT_NOP_HEADER_COUNT(count));
> +	}
> +
> +	amdgpu_ring_fill(ring, nop, count);
>  }
>=20
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c index 2858820bb864..242586ea951a
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -255,15 +255,14 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_r=
ing
> *ring) static void sdma_v5_2_ring_insert_nop(struct amdgpu_ring *ring,
> uint32_t count) {
>  	struct amdgpu_sdma_instance *sdma =3D
> amdgpu_sdma_get_instance_from_ring(ring); -	const bool burst_nop =3D
> sdma->burst_nop;
> -	int i;
> +	const u32 nop =3D ring->funcs->nop;
>=20
> -	for (i =3D 0; i < count; i++)
> -		if (i =3D=3D 0 && burst_nop)
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count -=20
1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (sdma->burst_nop) {
> +		--count;
> +		amdgpu_ring_write(ring, nop |=20
SDMA_PKT_NOP_HEADER_COUNT(count));
> +	}
> +
> +	amdgpu_ring_fill(ring, nop, count);
>  }
>=20
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c index d3504606bee7..ae063ac3bd74
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -243,15 +243,14 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_r=
ing
> *ring) static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring,
> uint32_t count) {
>  	struct amdgpu_sdma_instance *sdma =3D
> amdgpu_sdma_get_instance_from_ring(ring); -	const bool burst_nop =3D
> sdma->burst_nop;
> -	int i;
> +	const u32 nop =3D ring->funcs->nop;
>=20
> -	for (i =3D 0; i < count; i++)
> -		if (i =3D=3D 0 && burst_nop)
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count -=20
1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (sdma->burst_nop) {
> +		--count;
> +		amdgpu_ring_write(ring, nop |=20
SDMA_PKT_NOP_HEADER_COUNT(count));
> +	}
> +
> +	amdgpu_ring_fill(ring, nop, count);
>  }
>=20
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c index 1760f03db9e7..fd92830d3324
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -245,15 +245,14 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_r=
ing
> *ring) static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring,
> uint32_t count) {
>  	struct amdgpu_sdma_instance *sdma =3D
> amdgpu_sdma_get_instance_from_ring(ring); -	const bool burst_nop =3D
> sdma->burst_nop;
> -	int i;
> +	const u32 nop =3D ring->funcs->nop;
>=20
> -	for (i =3D 0; i < count; i++)
> -		if (i =3D=3D 0 && burst_nop)
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count -=20
1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (sdma->burst_nop) {
> +		--count;
> +		amdgpu_ring_write(ring, nop |=20
SDMA_PKT_NOP_HEADER_COUNT(count));
> +	}
> +
> +	amdgpu_ring_fill(ring, nop, count);
>  }
>=20
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c index b9f11f2f7e5c..c0824c83ace9
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -239,15 +239,14 @@ static void sdma_v7_1_ring_set_wptr(struct amdgpu_r=
ing
> *ring) static void sdma_v7_1_ring_insert_nop(struct amdgpu_ring *ring,
> uint32_t count) {
>  	struct amdgpu_sdma_instance *sdma =3D
> amdgpu_sdma_get_instance_from_ring(ring); -	const bool burst_nop =3D
> sdma->burst_nop;
> -	int i;
> +	const u32 nop =3D ring->funcs->nop;
>=20
> -	for (i =3D 0; i < count; i++)
> -		if (i =3D=3D 0 && burst_nop)
> -			amdgpu_ring_write(ring, ring->funcs->nop |
> -				SDMA_PKT_NOP_HEADER_COUNT(count -=20
1));
> -		else
> -			amdgpu_ring_write(ring, ring->funcs->nop);
> +	if (sdma->burst_nop) {
> +		--count;
> +		amdgpu_ring_write(ring, nop |=20
SDMA_PKT_NOP_HEADER_COUNT(count));
> +	}
> +
> +	amdgpu_ring_fill(ring, nop, count);
>  }
>=20
>  /**




