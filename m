Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926C3C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 08:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3733810EBC3;
	Tue,  7 Jul 2026 08:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bkcmWMt6";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F0010EBC3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 08:06:13 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so34041955e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 01:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783411572; x=1784016372; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c3vFlt3pZO/3yLwveExsfSU7tqW/XLYcKWKUqfX9WVY=;
 b=bkcmWMt6ATZBImFMwIhTiVnnG3O98Fa1nvW/vPSzaNocWSehPfE5sa3vyq88sBeJYc
 8gzvSwQg7Z3jw3YqGpTLC9/b4X2+O37uPlw+QRG35pXm9JVKFA0afDEfQz7sH7i764pU
 hmlw5frJUwYs0UgncODqCVHZvRaS+fk9giRbLeMo4VeCYM9P1QsPucgYJGPqs8tQS6ld
 5QhUIBQ+Og1ryaMncg8ZosIlwMSZBG41Dag6W4lzbJL4Pei8hDJQiFf0XMP+EKQv5+YA
 78zzXkjQIN4e96d3gNuSld62dWmqZdg8Ttxa37bNScU3Zdsxb2n0wnQ30aNhu8GOtp4k
 mJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783411572; x=1784016372;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c3vFlt3pZO/3yLwveExsfSU7tqW/XLYcKWKUqfX9WVY=;
 b=NdoerFgp3lPPS7G4mQbqd6NihL+o/ifTaJf4Vnsb0l+naaTxR/BuV7ftt3gGSTvsmX
 a8B2NQd5mwLiZBDdPeSKTHQQAzerJIKL47Idk9eeQnYLueM0z5fjEGlughM9Y1A2G7Cn
 MzadqyumBkGEOtq5ujsjm6bk+DS0e/zHnr1+vrqmxE4nbXc7OeB89W3Es7t1xdnLde7Y
 bxxW9v1+Sc+1R/eq7oqrtfMmUI+1wzwiXWlQYHA87JA8miFD7Mcu397bxc688CMWq9uV
 vmsxr7Y8hmAlKNBkzz+jZt6xcgnZWkc2JRsLJpd0znKBGns1IhQiAeRaPkfJUrM7wk7x
 B+NA==
X-Gm-Message-State: AOJu0YwPYOF1NGgA4Q88b7PjiFy4gpEhMT2kVAFYdzLx3udxRvsgmJCV
 bqCa5LcI1RZshUv/6deW0JF5SGX6V7L5HpCgsAu5+mnPTBxiZreUF22Fq7va6w==
X-Gm-Gg: AfdE7cl0/Bqr2TP1UHPeOC1qwvCGtWqFwz2YcnQAqLP/W+1iC2Y33Hd9a6kHM3ygrnH
 Bqk4fXiCMirOQDkL1rp/97kaMapNCFmJYT9RIHVhm9R+23LyVYd6S8ot52wZ7S5Wia4T26HBVmM
 TjR/0t2cTICzW3PceuH6gebWEx+04yifm0naq2nwzkoyS+Nzegwolb1HXn+CxchCH6wk0KR+hlO
 PfC2i79Fk9qSxs4KVjCKxtH9gQRHDvctKx9YMXakm2V+n71xm9ca6WbDc+4ta71CTPW9BahiEBt
 HNpPzJlelV0eVCfYQuScgoX3wQ4RfBrcDRyGk1YA4F3wWQSHFL+hrQakhA6TLdiMSOQBRbj/iQ2
 sMfNCUIgYDRz9Npqs1glxdMEbGD0PlqrT7bvlVTQlODsJZHEvAp1qz8KD7wr64UCgr0wqlTQ1B3
 MCRj5BNkgiOQDmr7Fy7argW+nUj/Y+tnoMdNKkNcC23APc7VcvSH4xQnl6BHK8W4WL/A7FJG5mc
 MUXiV36DVQRfarr+pQ=
X-Received: by 2002:a05:600c:55d7:b0:493:b962:4abe with SMTP id
 5b1f17b1804b1-493df0a1785mr30964975e9.36.1783411572023; 
 Tue, 07 Jul 2026 01:06:12 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24D8E500AC9DAEE3E0CDFA47.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e500:ac9d:aee3:e0cd:fa47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d780csm32801713f8f.11.2026.07.07.01.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 01:06:11 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/4] drm/gfx10: Program DB_RING_CONTROL
Date: Tue, 07 Jul 2026 10:06:10 +0200
Message-ID: <14526594.2vocr9iq0E@timur-max>
In-Reply-To: <20260626204101.31172-1-alexander.deucher@amd.com>
References: <20260626204101.31172-1-alexander.deucher@amd.com>
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

On 2026. j=C3=BAnius 26., p=C3=A9ntek 22:40:58 k=C3=B6z=C3=A9p-eur=C3=B3pai=
 ny=C3=A1ri id=C5=91 Alex Deucher=20
wrote:
> This is needed to allocate occlusion counters across
> both gfx pipes.
>=20
> Fixes: b7a1a0ef12b8 ("drm/amd/amdgpu: add pipe1 hardware support")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c index d72ecf5dab09e..6ff7a8a7009=
39
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5352,6 +5352,9 @@ static void gfx_v10_0_constants_init(struct
> amdgpu_device *adev) gfx_v10_0_get_tcc_info(adev);
>  	adev->gfx.config.pa_sc_tile_steering_override =3D
>  		gfx_v10_0_init_pa_sc_tile_steering_override(adev);
> +	/* program DB_RING_CONTROL for multiple GFX pipes */
> +	WREG32_FIELD15(GC, 0, DB_RING_CONTROL, COUNTER_CONTROL,
> +		       (adev->gfx.me.num_pipe_per_me > 1) ? 0 : 1);

Hi Alex,

Why do you set this to zero when the number of pipes is more than 1?
Wouldn't it need to be the other way around and set to the number of pipes =
(or=20
number of rings)?

Thanks,
Timur

>=20
>  	/* XXX SH_MEM regs */
>  	/* where to put LDS, scratch, GPUVM in FSA64 space */




