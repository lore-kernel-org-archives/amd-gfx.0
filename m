Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF835606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIMJ4bBc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE0610FFA2;
	Wed, 18 Nov 2026 19:09:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C38C10FFA2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:09:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 38F08470DF;
 Wed, 18 Nov 2026 19:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A061F000CE;
 Wed, 18 Nov 2026 19:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795028988;
 bh=KWx+FRHXW42Wny0YRT+jYTBjphmbrd1Vw49hG/YlIbg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WIMJ4bBc5gD7eUPePeZrl5B5T/RQBNQ/A6YqjDPDWVW0ONyCGLhoagiyyR7ju1Wwb
 TVbbDBu5Y7/X9LNRsyskxDpafPtSEoTEybGCtsMz6i5GCwoI1wHXsg+8yJwVQN0/sF
 UbYYsVH5th9JXBJ5NEJLFflLGSIE8Zyw6VJBjwgmZs/L+/2ieOVh+zcyrG6jJZb4L6
 Yw19PBqw5b200n98sPsSDkQGtjth3GZWBz7A31hmvWiIKpEYex6gdFqp4W1808wxdk
 8BiZ0YokxyMyx+D2udfsD1+2nc45ZNk9+9kfvRLlWlzZjAcE/HBv/xA/i6oH0SDIJB
 s1giCVT0q6pAw==
Message-ID: <sashiko-outbox-221823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/amdgpu: release WC memtype and MTRR when
 amdgpu_bo_init() fails
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118-superm1-amdgpu-memory-leak-v2-3-38365f37bd5a@amd.com>
References: <20261118-superm1-amdgpu-memory-leak-v2-0-38365f37bd5a@amd.com>
 <20261118-superm1-amdgpu-memory-leak-v2-3-38365f37bd5a@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 19:09:47 +0000
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
- [Low] drm/amdgpu: missing Fixes trailer for amdgpu_bo_init() leak fix
--

commit b39bca7df25d1f904ab6219bf84105076d42ff05
Author: Mario Limonciello <mario.limonciello@amd.com>

> drm/amdgpu: release WC memtype and MTRR when amdgpu_bo_init() fails
>
> amdgpu_bo_init() reserves the WC memtype for the VRAM aperture and adds
> an MTRR before calling amdgpu_ttm_init(). If amdgpu_ttm_init() fails,
> the GMC sw_init callers just return the error and GMC's sw_fini is never
> run, so amdgpu_bo_fini(), the only place that drops the memtype and MTRR,
> is never called. A later rebind then reserves the same aperture again
> with the old reservation still held.
>
> Undo the memtype reservation and the MTRR in amdgpu_bo_init() itself when
> amdgpu_ttm_init() fails.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

[Severity: Low]
Should this bug fix include Fixes tags for the commits that introduced the
MTRR and WC memtype reservations in amdgpu_bo_init() without unwinding
them on failure?

  Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
  Fixes: 7cf321d118a8 ("drm/drivers: add support for using the arch wc mapp=
ing API.")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-superm1-am=
dgpu-memory-leak-v2-0-38365f37bd5a@amd.com?part=3D3
