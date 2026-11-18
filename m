Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56255606A335
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqnqztVU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50BF1120BA;
	Wed, 18 Nov 2026 23:10:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4541120BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 23:10:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A06C641B3;
 Wed, 18 Nov 2026 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C661F0089E;
 Wed, 18 Nov 2026 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795043433;
 bh=YyjM2Y+usyxMVtrPX/6ICw7AgwLhgoB5LODRbN1s4ug=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=SqnqztVUHXUn0IcyH/17F6GDLwg8a9BFPhwZLNGtKJbN5jo/eC6hZjWUu3rmB6nd9
 eJYaIWa2JMm7ltFJ4ldV+UZMm8teqvlOab5+Gk3jX5YXUT3A6lo+7gBq1tP02eeTpk
 GoEm4suwnnFvfn7iCFlSkV8jaYKQmgA6jjnKontge8KoX/bI6TcFzBTzYAkx0SBLp0
 JOF+O/GNC1ReG4sbXqGncskWMzNvrQ45Cal7nKyw/NWcLdqKIxAiM+FbpUwfDudWbo
 dHQ5zY4DihVXckYDZ6n60PlzFYt5nTgwui/164PjepX2WJvE5PIclrxdUWhc1GaHQN
 BLqJoOz6Mgb+g==
Message-ID: <sashiko-outbox-222148@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Fix a race issue at
 svm_migrate_copy_to_ram() error path
To: Xiaogang.Chen <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118225834.60743-1-xiaogang.chen@amd.com>
References: <20261118225834.60743-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:10:32 +0000
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
- [Low] drm/amdkfd: missing Fixes trailer for svm_migrate_copy_to_ram()
  fix
--

commit 36078b6a47909e79e845fa9d13dc4df2f88836b7
Author: Xiaogang Chen <xiaogang.chen@amd.com>

> drm/amdkfd: Fix a race issue at svm_migrate_copy_to_ram() error path
>
> The destination pages were freed while SDMA copies queued earlier
> could still be writing into them, and while they were still DMA
> mapped. The mappings were only removed later by the caller's
> svm_range_dma_unmap_dev().
>
> With swiotlb, the BIDIRECTIONAL unmap copies the bounce buffer back into
> a page that may already be reused.
>
> With an IOMM, the GPU still has a valid bus address that points at a page
> now maybe owned by another user. Any SDMA write still in flight, corrupts
> that page.
>
> So, wait on the fence first, then dma unmap before release buffer.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

[Severity: Low]
This fixes a bug on the svm_migrate_copy_to_ram() error path where
destination pages were unmapped and freed before waiting on in-flight SDMA
copies.  Should the commit message include Fixes tags for the introducing
commits?

  Fixes: 960c4a8069bf ("drm/amdkfd: Fix error path at svm_migrate_copy_to_r=
am")
  Fixes: 48ff079b28d8 ("drm/amdkfd: HMM migrate vram to ram")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118225834.6074=
3-1-xiaogang.chen@amd.com?part=3D1
