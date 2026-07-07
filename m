Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BF5C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 08:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7550210EBD3;
	Tue,  7 Jul 2026 08:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p3Z7TbXy";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6843210EBE6
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 08:08:49 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493d28b1930so29346705e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 01:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783411727; x=1784016527; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XwOJwHLVDxacGdLHTtjCtam6+RXVuvv8mvU0LJyn9o4=;
 b=p3Z7TbXyg85KllcT0jlzV5ThrhAPP2sJgRCIFOLHXBQguDUe5DmmIeSOCroh3VyVml
 qejLZMhWiX1TKMcbep1aWqHusIJPwgH08z6qcCfr2SUtcA6y7SE6Ma42zy0l61j26rOC
 8VXS2b64t/JeEyDVtfr5MsHNC6tsz7zKQMGGUOInO4hLENF6rV+KCCPzlG2PY/rJJ+z6
 I3OFOaYCUm/bIbzOapplH7ddRLJ77kFilFqNLUt6zbnBQs+QlgvBtGHLfF6k7KrvWjgQ
 qkI8KwdRrF1ov4bIS4bs+PZI933TzsVO58Vbq2ABFuIzmc+xIfXdTI93R0TROO0MiJr0
 7zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783411727; x=1784016527;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XwOJwHLVDxacGdLHTtjCtam6+RXVuvv8mvU0LJyn9o4=;
 b=AczWQ003p3EVhRuMk/TwcHP7t8mSlhOJNdGdXv/a06hjSowlLrwXyeZs2iXlezLneX
 t3mc5oiBAbPSemXkjZn9h1P6lDcdqiG7xGd3AjKFQKzDFgN3yILd8XYkmVROEa8CKoY0
 pIk+98aTBO85rgZdxXxezAINV9sNMWU3P679zABWd1qLeSVjD1I2o32cztrpAxhyAVWI
 +XqofAoFtp44+DK+vV25UTH3DlLnfOYFfphsnpnVzfAf7QPr5e/x3LcfjRA8z7l7aWux
 hn19srvr1Ja4kS5W82jwDXKkqc3Jak2BjwhowOXNLUIX4kcVdBMYdePrifxxKl7g0xhv
 3NAw==
X-Gm-Message-State: AOJu0YzsqIXEOqwwtcA9tL3n5s60q9VsTWZdL0A+V8tXdW4V/xXeGPQy
 P32uO1b++eKCLA1ANzsfxuiXKKxeZMW/paFw/yBB094J7eeauD/Yu870IOYSMg==
X-Gm-Gg: AfdE7cnwRRD5z6aa5JE9Vs/qvvuYCnNCA8kIz2fZ8eOmZ8b7zumDJ7xTkmyUHPieT0d
 gYseWvleEl8/A6/KXJSeBf+enLs4W5XkqGf7/I4N7CqTJeW7MDMhc1XXQjvSddKL0dZ+oshJpxy
 8FHi0d7OjMU7LgKMjzuhokQgvTpoB0SbvFGHAuO3x5ekZf8zBneh5GN9QBtI0Gy63sbdqp80UfY
 24Q597ZZYpmapA2YcY1M7QYFJCmwpwOXEKgMivAciPTeWBbG8L2E7nqSoBhBw8GI+wtcV9cUvJN
 YJAK05vi87BoHHfh5oAF+cfa6WY+UOPjimR5t9YGGiAJdW8QYC3wAJZvV3OdOeyABIHH7VEwofH
 tErlDQMQyxiR9NJUn5VSvqUVtXje5fbHQFIBJWvbk9tAoKhcMlDVfbdIJTv6MZ9AGs53YTIosIn
 YUgeufpdWPgPDOd1UOuk7hR2sVzqdyFfe0nwUBWy9kD+rgHWEFWgeCW7D9G7hQV9FrTvD6GCdfe
 cGY9h8X/Z4rej4bZt4=
X-Received: by 2002:a05:600c:56c6:b0:492:68bc:3237 with SMTP id
 5b1f17b1804b1-493df08900emr30081805e9.32.1783411727042; 
 Tue, 07 Jul 2026 01:08:47 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24D8E500AC9DAEE3E0CDFA47.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e500:ac9d:aee3:e0cd:fa47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d910sm30844655f8f.6.2026.07.07.01.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 01:08:46 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 4/4] drm/amdgpu/gfx11: enable gfx pipe1 hardware support
Date: Tue, 07 Jul 2026 10:08:45 +0200
Message-ID: <1961599.dNmn5OnKVQ@timur-max>
In-Reply-To: <20260626204101.31172-4-alexander.deucher@amd.com>
References: <20260626204101.31172-1-alexander.deucher@amd.com>
 <20260626204101.31172-4-alexander.deucher@amd.com>
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

On 2026. j=C3=BAnius 26., p=C3=A9ntek 22:41:01 k=C3=B6z=C3=A9p-eur=C3=B3pai=
 ny=C3=A1ri id=C5=91 Alex Deucher=20
wrote:
> Enable gfx pipe1 hardware support.  This is only available
> on gfx11 chips using the F32 microcontroller.  Chips using
> the RS64 microcontroller are not able to use the second gfx
> pipe.  In practice this means the second pipe is only
> available on APUs. This explains the stability issues
> Pierre-Eric saw previously with this on Navi33.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c index 5e7d0cd85c365..c0e34519b6b=
06
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -51,7 +51,7 @@
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
>=20
> -#define GFX11_NUM_GFX_RINGS		1
> +#define GFX11_NUM_GFX_RINGS		2
>  #define GFX11_MEC_HPD_SIZE	2048
>=20
>  #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
> @@ -1612,7 +1612,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block
> *ip_block) case IP_VERSION(11, 5, 4):
>  	case IP_VERSION(11, 5, 6):
>  		adev->gfx.me.num_me =3D 1;
> -		adev->gfx.me.num_pipe_per_me =3D 1;
> +		if (adev->gfx.rs64_enable)
> +			adev->gfx.me.num_pipe_per_me =3D 1;
> +		else
> +			adev->gfx.me.num_pipe_per_me =3D 2;
>  		adev->gfx.me.num_queue_per_pipe =3D 2;
>  		adev->gfx.mec.num_mec =3D 1;
>  		adev->gfx.mec.num_pipe_per_mec =3D 4;
> @@ -5355,6 +5358,7 @@ static void gfx_v11_0_ring_emit_gds_switch(struct
> amdgpu_ring *ring, static int gfx_v11_0_early_init(struct amdgpu_ip_block
> *ip_block) {
>  	struct amdgpu_device *adev =3D ip_block->adev;
> +	int r;
>=20
>  	switch (amdgpu_user_queue) {
>  	case -1:
> @@ -5375,6 +5379,11 @@ static int gfx_v11_0_early_init(struct
> amdgpu_ip_block *ip_block)
>=20
>  	adev->gfx.funcs =3D &gfx_v11_0_gfx_funcs;
>=20
> +	gfx_v11_0_set_imu_funcs(adev);
> +	r =3D gfx_v11_0_init_microcode(adev);
> +	if (r)
> +		return r;
> +
>  	if (adev->gfx.disable_kq) {
>  		/* We need one GFX ring temporarily to set up
>  		 * the clear state.
> @@ -5382,7 +5391,11 @@ static int gfx_v11_0_early_init(struct
> amdgpu_ip_block *ip_block) adev->gfx.num_gfx_rings =3D 1;
>  		adev->gfx.num_compute_rings =3D 0;
>  	} else {
> -		adev->gfx.num_gfx_rings =3D GFX11_NUM_GFX_RINGS;
> +		/* rs64 only supports one gfx pipe */
> +		if (adev->gfx.rs64_enable)
> +			adev->gfx.num_gfx_rings =3D 1;
> +		else
> +			adev->gfx.num_gfx_rings =3D=20
GFX11_NUM_GFX_RINGS;

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Could you maybe move this code to a small helper function, eg. we could cal=
l=20
it gfx_v11_0_calc_num_pipes_per_me() and call that from both places.

Thanks & best regards,
Timur


>  		adev->gfx.num_compute_rings =3D=20
min(amdgpu_gfx_get_num_kcq(adev),
>  						 =20
AMDGPU_MAX_COMPUTE_RINGS);
>  	}
> @@ -5393,13 +5406,12 @@ static int gfx_v11_0_early_init(struct
> amdgpu_ip_block *ip_block) gfx_v11_0_set_gds_init(adev);
>  	gfx_v11_0_set_rlc_funcs(adev);
>  	gfx_v11_0_set_mqd_funcs(adev);
> -	gfx_v11_0_set_imu_funcs(adev);
>=20
>  	gfx_v11_0_init_rlcg_reg_access_ctrl(adev);
>=20
>  	amdgpu_init_rlc_reg_funcs(adev);
>=20
> -	return gfx_v11_0_init_microcode(adev);
> +	return 0;
>  }
>=20
>  static bool gfx_v11_0_is_rlc_enabled(struct amdgpu_device *adev)




