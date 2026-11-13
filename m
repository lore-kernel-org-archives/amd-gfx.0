Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24A606A8A6
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gbvc6+L3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53490112663;
	Fri, 13 Nov 2026 15:16:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3232A112649
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:16:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD4D341742;
 Fri, 13 Nov 2026 15:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18191F000C8;
 Fri, 13 Nov 2026 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794582997;
 bh=SkV/7c6HW2KYf0FajSBwsVtSvz5vkTpyS/4Eh4DNPcA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Gbvc6+L3O643974tm6wPcSMDknDZXS91wMzekEVBAGHG82XyoGWNCrEKEQCN6o70X
 7tJPZLl7sKlBz9RBgATXzKH1khsiJ6Wkk8psP3/9L5+mJ39loRdtVM9Wtpp8/qS9WY
 zbPNKc/eFvwrsA4ZF8FD3jxbcpZAVDL0eB0blhXO2O0OY20i2OmY7YLUO+CgQSnzp1
 kg7ItSVXal0j00XqU2MDQrTPAiYzJwO7w+dQ8pIPxKBATz8ukDc6bmb1IjW3486bjI
 NDecEsNSaxtr9BaWst59VfX1CjotngzaugkTjUYeJVAO6rGjUYK4+6VPq3BMHehl22
 e9g7/KJ2xnyyQ==
Message-ID: <sashiko-outbox-213072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] Revert "drm/amdkfd: mark A+A VF VRAM PTEs as system
 memory"
To: "Zhigang Luo" <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113145702.323968-2-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
 <20261113145702.323968-2-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:16:37 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amdkfd: revert commit message cites non-ancestor SHA
  daf19be40e04
--

commit 3e660e5d230b226dd7bb0de7b064fd710bf0e2a4
Author: Zhigang Luo <Zhigang.Luo@amd.com>

> Revert "drm/amdkfd: mark A+A VF VRAM PTEs as system memory"
>
> This reverts commit daf19be40e04.
>
> SVM VRAM ranges leave AMDGPU_PTE_SYSTEM clear and then call
> amdgpu_gmc_get_vm_pte() with a NULL buffer object. The GFX 12.1
> PTE helper sets the bit for an A+A VF, so the special case in
> svm_range_get_pte_flags() is the wrong place.
>
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>

[Severity: Low]
Commit daf19be40e04 ("drm/amdkfd: mark A+A VF VRAM PTEs as system memory")
is not an ancestor of this branch; the commit in the branch history that
added the amdgpu_virt_vram_is_spm() check in svm_range_get_pte_flags() is
a69f4d4076ea ("drm/amdkfd: mark A+A VF VRAM PTEs as system memory").
Should the revert reference be updated to cite a69f4d4076ea ("drm/amdkfd:
mark A+A VF VRAM PTEs as system memory")?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113145702.3239=
68-1-Zhigang.Luo@amd.com?part=3D2
