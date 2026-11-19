Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010F606A332
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9R1TsBF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB3A10F0C7;
	Thu, 19 Nov 2026 19:10:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D59C410F0C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 19:10:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A585962210;
 Thu, 19 Nov 2026 19:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367571F000C4;
 Thu, 19 Nov 2026 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795115436;
 bh=ZKLRd10GJMuPslVro2cjQVehh7PbZVj51D5/EBErQ8M=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=H9R1TsBFFh417ha3DTORwnspogrrWHTOBCGALs8cyEf/xd7VU0nLRFcO0KVhyO1fd
 /h/sgI7z/xXoebjTb+jRFxb0tIVBEEntVB5KTbGGgLKFeyyPNdEtNvCm0MmjfsPRVP
 BIotvNqcQM3N5WRH0SiTaLCtQjVN5pMHG8gU8lboIkyfAGD61zyyqx0poew8/GSp3y
 p3yi4DjAhXhvzyLuOaRihoKrZHOLx+psgbbZ05E0lybDYJZ8FJJ9RTQk1Kr3VV7rdZ
 OPRP0wXUaiuDpZD3zWk800U83W1czXM2v86dz1oKAZPrGCEayAukxxB9VfOO77lu4B
 ebkhrY66qpfMw==
Message-ID: <sashiko-outbox-223835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu/gfx11: don't enable gfx on pipe1 with tmz
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261119185657.4071721-1-alexander.deucher@amd.com>
References: <20261119185657.4071721-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:10:35 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/amdgpu/gfx11: gfx_v11_0_early_init() reads tmz_enabled
  before init
- [High] drm/amdgpu/gfx11: gfx_v11_0_sw_init() enables pipe1 with TMZ
  and crashes
--

commit 3a6ea4e2362ddd6d94fcfcb16809c1b42fa126ef
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/gfx11: don't enable gfx on pipe1 with tmz

This commit limits adev->gfx.num_gfx_rings to 1 in gfx_v11_0_early_init()
when Trusted Memory Zone (TMZ) is enabled, because GFX11 firmware does not
support TMZ on GFX pipe 1.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5d068a9d9c72c..16c8dff858c5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5302,10 +5302,15 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_=
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

[Severity: High]
Is adev->gmc.tmz_enabled already initialized when gfx_v11_0_early_init()
runs?

In amdgpu_device_init(), amdgpu_device_ip_early_init() runs before
amdgpu_gmc_tmz_set():

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

Because adev->gmc.tmz_enabled is still false during early_init,
adev->gfx.num_gfx_rings is always set to GFX11_NUM_GFX_RINGS (2) and GFX
pipe 1 remains enabled when TMZ is active.

[Severity: High]
Should gfx_v11_0_sw_init() also check adev->gmc.tmz_enabled when setting
adev->gfx.me.num_pipe_per_me?

Commit fec62b5e1425 ("drm/amdgpu/gfx11: enable gfx pipe1 hardware
support") enabled pipe 1 in both gfx_v11_0_early_init() and
gfx_v11_0_sw_init():

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:gfx_v11_0_sw_init() {
	...
		if (adev->gfx.rs64_enable)
			adev->gfx.me.num_pipe_per_me =3D 1;
		else
			adev->gfx.me.num_pipe_per_me =3D 2;
	...
}

When num_gfx_rings is 1 in gfx_v11_0_early_init(),
gfx_v11_0_set_ring_funcs() only initializes adev->gfx.gfx_ring[0].funcs
and leaves gfx_ring[1].funcs NULL.  If gfx_v11_0_sw_init() still sets
num_pipe_per_me to 2, gfx_v11_0_me_init() ->
amdgpu_gfx_graphics_queue_acquire() acquires a queue on pipe 1 and resets
num_gfx_rings to 2, and the ring initialization loop in
gfx_v11_0_sw_init() then calls gfx_v11_0_gfx_ring_init() ->
amdgpu_ring_init() on gfx_ring[1], causing a NULL pointer dereference on
ring->funcs->type.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185657.4071=
721-1-alexander.deucher@amd.com?part=3D1
