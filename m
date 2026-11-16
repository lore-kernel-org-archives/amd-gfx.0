Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30410606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQSr5iKY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C0810EEE9;
	Mon, 16 Nov 2026 14:29:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC9A10EEE9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 14:29:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D64D61B38;
 Mon, 16 Nov 2026 14:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA1A1F000C6;
 Mon, 16 Nov 2026 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794839344;
 bh=JlgduDuze7tpFbvxUJd8c73yb8G5kBiTrR5yRXUwxsU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=AQSr5iKYgKY1vrnupY64Qvfr4+xHtBftNpJoZTF1R6cd6kqZKJhzDVRYOqr3FPCmR
 YIvqSbcC7FxtdaRZwzDEJTT+ttK/wb6iBDg7u+zChPI5DH/nTtJLoFywE3qVc6soXp
 SW0uxb9whLcJEwc4TJOar/csmI4Bvj8bCcmAdH5UtqdCAEdi5kBXkZfF4glsDoHMMT
 9rUd/8UbBv+hkszY8ulz63nmojsmOmOy9E3/USmvI4qd3pljXEPYrouP4t8te2IgTf
 c62oLJnuky7sMhuBc/IYcbHUiFFj0HKOI3IgcAzgya5LmiuJt37oufoLUJJ6UyNCYq
 YlclBZJE0Atdw==
Message-ID: <sashiko-outbox-217163@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: move TBA/TMA back to system memory
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261116141731.1903647-1-alexander.deucher@amd.com>
References: <20261116141731.1903647-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 14:29:04 +0000
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
- [Medium] drm/amdkfd: missing GC 9.4.4 and 9.5.0 in
  kfd_process_device_init_cwsr_dgpu()
--

commit cc9ef3d2bb074c200e9b29b42b4feba716d6b86b
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdkfd: move TBA/TMA back to system memory

This commit restricts CWSR TBA/TMA VRAM allocation to specific MI GC IP
versions so that non-MI parts allocate TBA/TMA in GTT memory.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 546721b4d59ac..7a424184a4a3c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1554,7 +1554,10 @@ static int kfd_process_device_init_cwsr_dgpu(struc=
t kfd_process_device *pdd)
>  	if (!dev->kfd->cwsr_enabled || !iosys_map_is_null(&qpd->cwsr_map) || !q=
pd->cwsr_base)
>  		return 0;
> =20
> -	if (KFD_GC_VERSION(dev) >=3D IP_VERSION(9, 4, 2) && !dev->adev->apu_pre=
fer_gtt)
> +	if ((KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2) ||
> +	     KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 3) ||
> +	     KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0)) &&
> +	    !dev->adev->apu_prefer_gtt)
>  		flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
>  	else
>  		flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_GTT;

[Severity: Medium]
Should this condition also include IP_VERSION(9, 4, 4) and
IP_VERSION(9, 5, 0)?

Other MI checks such as mqd_on_vram(), kfd_process_close_interrupt_drain(),
and KFD_SUPPORT_XNACK_PER_PROCESS() list GC 9.4.4 and 9.5.0 alongside 9.4.2
and 9.4.3.  Omitting them here causes kfd_process_device_init_cwsr_dgpu()
to regress to KFD_IOC_ALLOC_MEM_FLAGS_GTT on those MI parts instead of
keeping TBA/TMA in VRAM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116141731.1903=
647-1-alexander.deucher@amd.com?part=3D1
