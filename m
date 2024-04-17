Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5F7C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 06:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82FE01131DE;
	Wed, 17 Apr 2024 06:43:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="j+Q/mTjf";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46521131DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 06:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713336212; x=1713941012; i=friedrich.vock@gmx.de;
 bh=G9k+CHtdWi8xczjZ43rIpdv+BJqBI8qB5P03uRRE4RA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=j+Q/mTjfRtcMGgoB2FxX3ulOXSDm6vJlDyiDhnT8byjSZiRPaQ5l9zlI13UMvXSE
 DxNWwQLIQTVk1CWsOrXBHYqgm3DdVDsKHFpkEs65bO5JPMDNEacggTUR9z3oZne5m
 yybZHMEuu9WPyVa/WCuRIlczkb3KiYjfh+gjacn8dteawTHpBwkrO84MvWmdRFrqS
 KxbiKclfohyGobRdXcHJbltfpT1Rd+pqb9uSvRZJyq5S0RF8M1duwCNgD3x0B3SQf
 ygiyGnaQ2vg1T32AbkrMMwlBb5MJPV0FZORrgboGVA3dFUlXJQDvrbu/8AhybVsnd
 Y2qJzFzgZEFTJRgI7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.19]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1rqONA2Wm8-006hPN; Wed, 17
 Apr 2024 08:43:32 +0200
Message-ID: <9bf1d4c8-d34b-4249-99f3-6232a97ae3b8@gmx.de>
Date: Wed, 17 Apr 2024 08:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Friedrich Vock <friedrich.vock@gmx.de>
Subject: Re: [PATCH v3 2/5] drm:amdgpu: Enable IH ring1 for IH v6.1
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240416133423.3346-1-sunil.khatri@amd.com>
 <20240416133423.3346-2-sunil.khatri@amd.com>
Content-Language: en-US
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <20240416133423.3346-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TcwkYvTlQKzdeDDkiWXx61rQazY3IdxlzB5xu+rkTrypmjIDX64
 lVHvHXBIoBgwtuSUZzQpXFOkaye6egkz2mBycW8IJlMgEwCV7jsaL30a0UX2ZGeMtYMWjqe
 oZDqRqjWI6auv9rtqGFgHwuJnLFCw/2x0Yr35p/HM34s+fba7aHHYd0tb1w4tKTFQWZZaDz
 gM28DrJfolaWZ6Ede5tjQ==
UI-OutboundReport: notjunk:1;M01:P0:2hgK5XVHahE=;dyKg1SlCZAqKjTQgcsWrkbrDz+B
 a80NgmYwe5mVsdNkiiwN8B2pEYUzuC+EvWjIt8uPQy9jSq7TOX3HHmUOraxVSddSaYng5AMur
 46L24sjk8+YiuscMzYDFoYppAWA+XTIPWvJ+K5j0+Bb0rD/yWmFpJFCdnEZs2qy+qLLVxvEH4
 njHQYgPwLEe54eFc2qM52lSNmPStHN1S0JoD+WnBWE2rgxqTq+OmMNKO5Csnb8CgXovO+vWQh
 T1KH+G54B/yx2ArDTrHVo/NRVGUCtXoICPdtJgLsUY/75ay3juPEGAxplOibdRVqYgElcDs5z
 9SOdC1ngpry+EYIonRIthVsw04U0eIgSxKE7nSxjWB+sxHmq233ENF8xzDm8rRgJBkzKb24A9
 LkcwUHN6SF8sD32tiDihOc+Lop5a81O+utrs4Zsz7U0EmD7x25loDLVa1bPjubDOWklHhtZp6
 fkB3o8BU9PdQ1c08UlkWoBR5TXdgRLAgO3gsGj08y8TOJUoOluLOkNFRrfFdwqoDyXIFTc9Wm
 Fmoq5V5JO9/tGL2cVlx9tlBFRa2kmu5Iur5+S7SQkzhLBzf41C/h1YvxswTabGFenHUGWxbWb
 eRy7PS/IaedLv26ohGqepgtW+UbIEeF5789vxHop1rOYdijD7f85hNwomCmoerSjUuwFlYBJY
 1Fjabeo9U7hflYNFaYpsviSZFekgS6aaI1LTOCa3Mjf74/R94CjYrYfP71iPbtUcZ0ddsZmJK
 Y285t8OhxDeaT7vhL0stn29jFxG3dsPMt5PD0f46i+Y9PiovgdZ92ae9brlxQRAuYCFcC2aYb
 fMHTFKt3xdVKq5aIYYUclvxzJYyIHO0w+4F3NXAG6jZHI=
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

On 16.04.24 15:34, Sunil Khatri wrote:
> We need IH ring1 for handling the pagefault
> interrupts which over flow in default
> ring for specific usecases.
>
> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/=
amdgpu/ih_v6_1.c
> index b8da0fc29378..73dba180fabd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> @@ -550,8 +550,15 @@ static int ih_v6_1_sw_init(void *handle)
>   	adev->irq.ih.use_doorbell =3D true;
>   	adev->irq.ih.doorbell_index =3D adev->doorbell_index.ih << 1;
>
> -	adev->irq.ih1.ring_size =3D 0;
> -	adev->irq.ih2.ring_size =3D 0;
> +	if (!(adev->flags & AMD_IS_APU)) {

Why restrict this to dGPUs? Page faults can overflow the default ring on
APUs too (e.g. for Vangogh).

Regards,
Friedrich

> +		r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih1, IH_RING_SIZE,
> +					use_bus_addr);
> +		if (r)
> +			return r;
> +
> +		adev->irq.ih1.use_doorbell =3D true;
> +		adev->irq.ih1.doorbell_index =3D (adev->doorbell_index.ih + 1) << 1;
> +	}
>
>   	/* initialize ih control register offset */
>   	ih_v6_1_init_register_offset(adev);
