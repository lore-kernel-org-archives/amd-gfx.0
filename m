Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7416606A325
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dlJAVe7A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C87D10E040;
	Thu, 19 Nov 2026 19:47:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00E410E040
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 19:47:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2950961DE6;
 Thu, 19 Nov 2026 19:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A941F000C5;
 Thu, 19 Nov 2026 19:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795117622;
 bh=z/Dp0WaTM9EzY+7pzp2l/ifyJ3KyxBN4ojmBrIqrXro=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=dlJAVe7ATv1rWHr7tNaRxf1v6f88+n5MITmWKU07+1eMvWbbiCSyqmln8wM+vcvcy
 MosR1KGD0exLEJzRM1hdrxusKaZFUeMjkKGBmGhH+UKOPZF9gl/DOidh3qcvugLOAy
 WuTB6tIBTi9XQfW53xl9/GXvcnDV1pK2XlwotybTElyC3kSZssgpJ9ouJ/6bwItUI7
 VqEpaP/RL34Mt0w75rtm3wrRy5nvEgOmYpNh6Lg2VrK4pZeS0u2jb07XG2kBbGHPWc
 SP62b3rK1Kyjeqi3++ufmBvPOai3WQBlhwFECK5pwotqC8ZRkNBGotbKc6FoTWHFna
 3NoP2YqfysmcA==
Message-ID: <sashiko-outbox-223970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx11: don't enable gfx on pipe1 with tmz
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261119193620.217718-2-alexander.deucher@amd.com>
References: <20261119193620.217718-1-alexander.deucher@amd.com>
 <20261119193620.217718-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:47:02 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/amdgpu/gfx11: NULL pointer dereference in
  amdgpu_ring_init() [1]
--

commit 0a934348cc9c64c8c23b8255a5b64447ad24179d
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/gfx11: don't enable gfx on pipe1 with tmz

This commit limits GFX11 devices to a single GFX pipe and ring when TMZ
is enabled, as the firmware does not support TMZ on pipe 1.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 570f0f3a2ea5e..16b211174c8dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1690,7 +1690,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>  	case IP_VERSION(11, 7, 0):
>  	case IP_VERSION(11, 7, 1):
>  		adev->gfx.me.num_me =3D 1;
> -		if (adev->gfx.rs64_enable)
> +		if (adev->gfx.rs64_enable ||
> +		    adev->gmc.tmz_enabled)
>  			adev->gfx.me.num_pipe_per_me =3D 1;
>  		else
>  			adev->gfx.me.num_pipe_per_me =3D 2;

[Severity: High]
This problem wasn't introduced by this patch, but should this condition
also check adev->gfx.disable_kq [1]?

When amdgpu.user_queue=3D2 sets adev->gfx.disable_kq, gfx_v11_0_early_init()
sets adev->gfx.num_gfx_rings =3D 1, so gfx_v11_0_set_ring_funcs() only
populates adev->gfx.gfx_ring[0].funcs and leaves gfx_ring[1].funcs NULL.

If adev->gfx.me.num_pipe_per_me is set to 2 here, gfx_v11_0_me_init() ->
amdgpu_gfx_graphics_queue_acquire() enables queues on both pipes and
overwrites adev->gfx.num_gfx_rings to 2.  gfx_v11_0_sw_init() then calls
gfx_v11_0_gfx_ring_init() for gfx_ring[1], causing amdgpu_ring_init() to
dereference the NULL ring->funcs pointer.

[1] https://sashiko.dev/#/bug/linux-cb8251e2-db73-484e-81c4-7d48aaa6e13f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119193620.2177=
18-1-alexander.deucher@amd.com?part=3D2
