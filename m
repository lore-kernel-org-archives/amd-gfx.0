Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C36606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oRjWKViD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7942210E5FE;
	Thu, 12 Nov 2026 14:35:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A1410E6B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 14:35:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5042E6587A;
 Thu, 12 Nov 2026 14:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32781F00A05;
 Thu, 12 Nov 2026 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794494124;
 bh=Gi53u2K6FZoEE6sFuBNKueUHEItkfWMxtcTBzZlpgb4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=oRjWKViDxjgfjuU7rwHb+ivB8p00DkVJ6xjCGdc0yWZKefVJzR2Ir8zzGeZmUQLmg
 nkTavp3Fml2zLeSCZitNi4UU/klNmI5+szD5Sm97WuGff18rOLSPyMLSqIPLQIhh1O
 EbUmzNkZAPQB2tUuBMnak+A4YzhV5y01yizvdWRPBVpim1OVujDjtCFAZO9EUMS4S4
 R6tQNnqxcrHgt6oqsN9cKqI3QLvFkSOQKGCO10SN1UWY+o8RMX/fSp8cmQegXzYYeF
 Z0avedojITGsqe9Q0am8sZvtuisbVUVbqRqhvsOycP+FhnEBoETHLZW3xjfjIrgujh
 1UdEjK5vq3aJg==
Message-ID: <sashiko-outbox-211347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix fault shader cleaner on MI3
To: "Kent Russell" <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261112134340.4122401-2-kent.russell@amd.com>
References: <20261112134340.4122401-1-kent.russell@amd.com>
 <20261112134340.4122401-2-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:35:23 +0000
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
- [Medium] drm/amdgpu: physical XCC bit index used in
  gfx_v9_clean_shaders()
--

commit d2d8466691d7c4222ecf6651152915dffb5f88c8
Author: Kent Russell <kent.russell@amd.com>

drm/amdgpu: Fix fault shader cleaner on MI3

This commit adds MI300/MI350 register initialization definitions for the
fault shader cleaner and updates the dispatch dimension in
gfx_v9_clean_shaders() to cover all wave slots per SIMD.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_2.c
> index dc46133ed5068..95789f8d7018a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c

[ ... ]

> @@ -731,6 +735,20 @@ static int gfx_v9_clean_shaders(struct amdgpu_device=
 *adev)
>  		return 0;
>  	}
> =20
> +	/* gfx943+ has different register layout compared to gfx942.*/
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(9, 4, 3):
> +	case IP_VERSION(9, 4, 4):
> +	case IP_VERSION(9, 5, 0):
> +		init_regs =3D gfx_v9_4_3_fault_cleaner_init_regs;
> +		init_regs_size =3D GFX_V9_4_3_FAULT_CLEANER_INIT_REGS_SIZE;
> +		break;
> +	default:
> +		init_regs =3D fault_cleaner_init_regs_aldebaran;
> +		init_regs_size =3D ARRAY_SIZE(fault_cleaner_init_regs_aldebaran);
> +		break;
> +	}
> +
>  	for_each_inst(xcc_id, adev->gfx.xcc_mask) {
>  		ring =3D &adev->gfx.compute_ring[xcc_id * adev->gfx.num_compute_rings];

[Severity: Medium]
Does iterating over adev->gfx.xcc_mask with for_each_inst() index
adev->gfx.compute_ring[] with a physical XCC bit position instead of a
logical XCC index?

In amdgpu_discovery_harvest_ip(), harvested GC instances are cleared from
adev->gfx.xcc_mask with ~BIT(inst), whereas gfx_v9_4_3_sw_init() and
amdgpu_gfx_run_cleaner_shader() populate and index adev->gfx.compute_ring[]
contiguously for logical XCCs 0 .. NUM_XCC(adev->gfx.xcc_mask) - 1.  On
MI300/MI350 parts with harvested lower-numbered XCCs, this loop skips the
logical compute rings at the harvested bit positions (leaving those active
XCCs uncleaned after a VM fault) and reads uninitialized compute_ring
entries at physical bit positions >=3D NUM_XCC(adev->gfx.xcc_mask).

Iterating from 0 to NUM_XCC(adev->gfx.xcc_mask) - 1 would match how
adev->gfx.compute_ring[] is indexed elsewhere.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112134340.4122=
401-1-kent.russell@amd.com?part=3D2
