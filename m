Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AAA606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 04:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCOpGTB4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C944210E37A;
	Tue, 17 Nov 2026 04:30:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB0710E37A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 04:30:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37650601BF;
 Tue, 17 Nov 2026 04:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF351F000C4;
 Tue, 17 Nov 2026 04:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794889832;
 bh=5/qmGmcvVx6/q7vaV+fNSo1iOloR8aNrc715xsPCxTY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=RCOpGTB4+nta8/SFM1iDaThJDhJmNnbewj8VJMpyjZIZr7UIpgp4f4PvjQAF4ri2E
 7b7Q+Af16i4ISChpMTTPbgK3QfAwBRoGYFxgNOM0j8PyZwELsdwfh6RcImasTgllJ1
 VwYZN/06ZPwwfh9oPr/5rfaHYPI5//1xobQeeRR2bdsGdkoQOrZ90wMwpm8xl+KiPo
 w8JLclOPesEYY2I/00DXV0xW1GTJNEaabxtS4nP6ngVu4+hC/4dyBY2PC6h3DJDSxl
 QJxhJre+mLr+J34apBONkpYL2eRYm9C84BEjReS/Xz8PbfDVvpmO71FlzROl/ay6bl
 YRIOw2GYhjqtA==
Message-ID: <sashiko-outbox-218189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] drm/amdgpu: map KFD userptr read-only when the
 BO is not writable
To: "Junhua Shen" <Junhua.Shen@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117042051.768201-2-Junhua.Shen@amd.com>
References: <20261117042051.768201-1-Junhua.Shen@amd.com>
 <20261117042051.768201-2-Junhua.Shen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 04:30:32 +0000
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
- [Low] drm/amdgpu: missing Fixes trailer for KFD read-only userptr bug
  in init_user_pages()
--

commit 29a249e733b969cc649ffa369fb4f4e2387a5611
Author: Junhua Shen <Junhua.Shen@amd.com>

> drm/amdgpu: map KFD userptr read-only when the BO is not writable
>
> init_user_pages() registers every userptr writable (flags =3D 0), ignoring
> the KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE flag that get_pte_flags() already
> honors when mapping the BO.
>
> Pass AMDGPU_GEM_USERPTR_READONLY for a read-only allocation, so the
> userptr registration matches the permission already enforced in the page
> table.
>
> Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>

[Severity: Low]
Should this include a Fixes: tag for the commit that introduced the
hardcoded 0 flags argument in init_user_pages()?

  Fixes: 5ae0283e831a ("drm/amdgpu: Add userptr support for KFD")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117042051.7682=
01-1-Junhua.Shen@amd.com?part=3D1
