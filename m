Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F6606A332
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jf/itGoi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C8810E1BB;
	Thu, 19 Nov 2026 19:33:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E5010E1BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 19:33:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8739260EE9;
 Thu, 19 Nov 2026 19:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B0F1F000CD;
 Thu, 19 Nov 2026 19:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795116801;
 bh=FFElzrKlx6+ynqqGNLaHEFs43VqbjqFugPcIuEab4Ro=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Jf/itGoiFaiM+ZuWxvjFcT+FxaGWtOO5YoiCG2cskf4jaEZ/xy10M87GRAtONQZBN
 3pgZKY0v+/1Y2xu7mAFBszDM68wK0wV8xvfajl8Gi3HCtK35vwZCPIiOsYCNyDlJuj
 hIlz9EUpQe4HBR8pxRE3Mbo471fwgU40RNHBJZcqcCOFaZgdSsBwmUH+hihMnK9Tf7
 sO7tNPHTsuNM/sFFds6IqzsSEdIg7JpM82FlEsjLdXXGpH7nKKur35v5JWnjLKvCNo
 s6HR6f1Uz4kzo0/WW19Eb3Qz5AODkb40imeeUC5BlIIg5kiBSKR0der4OUh+7rloGb
 zuzVGcRLPFvpg==
Message-ID: <sashiko-outbox-223934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] drm/amdgpu/gfx11: don't enable gfx on pipe1 with tmz
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261119191202.190939-1-alexander.deucher@amd.com>
References: <20261119191202.190939-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:33:20 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amdgpu/gfx11: dead tmz_enabled check in
  gfx_v11_0_early_init()
--

commit 7adeab4007af8d1d45d18ee604343d9e2fa08024
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/gfx11: don't enable gfx on pipe1 with tmz

This commit restricts GFX11 to a single GFX pipe and ring when TMZ is
enabled, because the firmware does not support TMZ on pipe 1.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5d068a9d9c72c..d4ea4769efa0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
[ ... ]
> @@ -5302,10 +5303,15 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_=
block *ip_block)
>  		adev->gfx.num_compute_rings =3D 0;
>  	} else {
>  		/* rs64 only supports one gfx pipe */
> -		if (adev->gfx.rs64_enable)
> +		if (adev->gfx.rs64_enable) {
>  			adev->gfx.num_gfx_rings =3D 1;
> -		else
> -			adev->gfx.num_gfx_rings =3D GFX11_NUM_GFX_RINGS;
> +		} else {
> +			/* FW doesn't support TMZ on gfx pipe1 */
> +			if (adev->gmc.tmz_enabled)
> +				adev->gfx.num_gfx_rings =3D 1;
> +			else
> +				adev->gfx.num_gfx_rings =3D GFX11_NUM_GFX_RINGS;
> +		}
>  		adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
>  						  AMDGPU_MAX_COMPUTE_RINGS);
>  	}

[Severity: Low]
Can adev->gmc.tmz_enabled ever be true in gfx_v11_0_early_init()?

In amdgpu_device_init(), amdgpu_device_ip_early_init() runs before
amdgpu_gmc_tmz_set() initializes adev->gmc.tmz_enabled:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_device_init() {
	...
	/* early init functions */
	r =3D amdgpu_device_ip_early_init(adev);
	if (r)
		return r;
	...
	/* Enable TMZ based on IP_VERSION */
	amdgpu_gmc_tmz_set(adev);
	...
}

Because adev->gmc.tmz_enabled is still false here,
gfx_v11_0_early_init() always sets adev->gfx.num_gfx_rings to
GFX11_NUM_GFX_RINGS and gfx_v11_0_set_ring_funcs() populates
gfx_ring[1].funcs before gfx_v11_0_sw_init() later clamps
num_pipe_per_me and num_gfx_rings back to 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119191202.1909=
39-1-alexander.deucher@amd.com?part=3D1
