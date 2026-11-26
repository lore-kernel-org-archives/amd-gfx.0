Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19D606A329
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAG41ann
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C4EE10E0E1;
	Thu, 26 Nov 2026 20:50:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2A910E0E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 20:50:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9F826111A;
 Thu, 26 Nov 2026 20:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C98D1F00893;
 Thu, 26 Nov 2026 20:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795726201;
 bh=D48+CGFgvNFLZfpg2d/9USrZTOt3VEHs+m0y4g1Cxto=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=JAG41annrylbPxEPEZjj+pZKJxQaRV0vbIgp4V7KnGSM76siEowwgyYnkcFiEaVsM
 dC45/g12UwDjablFbLAVsPAq9OKiMC3F2KBJwFQIsx4nQzmIpBkQlSe7xOhxgN3OIz
 MEyGsHvYuPfZtCCB+GTvOUrmvzzMnOXWDi3or+0v1gHrGQFI65i50IrzIr66EhxJxZ
 xznUfP1Fq9viLmQhaUQ2BTD2kO/sfEVB3oqL4/42bBnLGjmjTlpdFz7e/kNPJBFvpT
 5O12rC7fMXRTtfhuB52Vveb7b3pe3orhUFeGflhavsNZG8NuIC/7bCWWYkT/cWrlzm
 RskiFg/y+mNdg==
Message-ID: <sashiko-outbox-236166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/amdkfd: Add CWSR trap handler for GFX13
To: "Lancelot SIX" <lancelot.six@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126203011.295945-1-lancelot.six@amd.com>
References: <20261126203011.295945-1-lancelot.six@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 20:50:00 +0000
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
- [High] drm/amdkfd: unused cwsr_trap_gfx13_hex triggers
  -Wunused-const-variable
--

commit 2e64101d36eee8890b942dff02c7d421f5a71ffe
Author: Lancelot SIX <lancelot.six@amd.com>

drm/amdkfd: Add CWSR trap handler for GFX13

This commit adds the GFX13 CWSR trap handler assembly source and its
compiled hex array in cwsr_trap_handler.h.

> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu=
/drm/amd/amdkfd/cwsr_trap_handler.h
> index 5d468460f532c..82f75bcf31842 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -5994,3 +5994,573 @@ static const uint32_t cwsr_trap_gfx12_1_0_rev_1_h=
ex[] =3D {
>  	0xbf9f0000, 0xbf9f0000,
>  	0xbf9f0000, 0xbf9f0000,
>  };
> +
> +static const uint32_t cwsr_trap_gfx13_hex[] =3D {

[Severity: High]
Does defining cwsr_trap_gfx13_hex without referencing it in
kfd_cwsr_init() trigger a -Wunused-const-variable warning when building
kfd_device.c?

drivers/gpu/drm/Makefile unconditionally enables -Wunused-const-variable,
and cwsr_trap_handler.h is only included by kfd_device.c, where
kfd_cwsr_init() has no branch selecting cwsr_trap_gfx13_hex:

drivers/gpu/drm/amd/amdkfd/kfd_device.c:kfd_cwsr_init() {
	...
		} else if (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(12, 1, 0) &&
			(kfd->adev->rev_id & 0xF) =3D=3D 0) {
			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_rev_0_hex)
					     > KFD_CWSR_TMA_OFFSET);
			kfd->cwsr_isa =3D cwsr_trap_gfx12_1_0_rev_0_hex;
			kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx12_1_0_rev_0_hex);
		} else {
			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_rev_1_hex)
					     > KFD_CWSR_TMA_OFFSET);
			kfd->cwsr_isa =3D cwsr_trap_gfx12_1_0_rev_1_hex;
			kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx12_1_0_rev_1_hex);
		}
}

With CONFIG_WERROR, CONFIG_DRM_WERROR, or CONFIG_DRM_AMDGPU_WERROR
enabled, this breaks the build, and GFX13 devices will fall through to
cwsr_trap_gfx12_1_0_rev_1_hex unless wired up in kfd_cwsr_init() (or
marked __maybe_unused if wired up in a later patch).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126203011.2959=
45-1-lancelot.six@amd.com?part=3D1
