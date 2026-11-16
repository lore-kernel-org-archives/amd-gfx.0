Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC98606A323
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gq25WPq3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC3EF10F31E;
	Mon, 16 Nov 2026 17:08:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA00F10F314
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 17:08:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7069B43631;
 Mon, 16 Nov 2026 17:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C351F000CD;
 Mon, 16 Nov 2026 17:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794848928;
 bh=N3E3LLAI7YXA4m8v09IrCJDm+j0hF2TEwhMiv3lhr8A=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Gq25WPq3yv1W5DN8gW/0dKi2UTFO2hhUHSU/Lh2vzQkTMUBEurUdmKcqJJfNVEDQU
 11jm2MZd0yG61cJfY5DetUJMXKKAEU+OkINPf1s+OX93F378eWGeR8PSIAqEs931hU
 DMVjrq3n7TnceRckROuaS3azNksNaBfilzhyyH+kewVrzJXvImAE1MlpyaLXdyIFud
 7ynMLw0oYAC+uYCpS+SLthqmAsSmUvvW6lijrHhXb/lkcBzDvB/PNcWW7MkF3C2cMx
 QNbVp/LRSFTbPEpqFDTXpFNnCn4swyNrzhqPBGLnYbgBKZ+MmZzUtuMIpBAvb8mInd
 cyuDzoXnc5qqg==
Message-ID: <sashiko-outbox-217409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] Revert "drm/amdgpu: re-enable SPM updates in the
 the IB path"
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261116165713.1945549-1-alexander.deucher@amd.com>
References: <20261116165713.1945549-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:08:47 +0000
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
- [Low] drm/amdgpu: missing Fixes trailer for reverted commit
  d44428868e5b
--

commit 36fa0c29e9f1b1b0ebcda0c9f28cb357bd14196e
Author: Alex Deucher <alexander.deucher@amd.com>

> Revert "drm/amdgpu: re-enable SPM updates in the the IB path"
>
> This reverts commit d44428868e5b9f97c6216eee1b4f82aec7a6e8d2.
>
> This causes flakiness in gfx11 CI tests.  Revert.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

[Severity: Low]
Since commit d44428868e5b ("drm/amdgpu: re-enable SPM updates in the the
IB path") carries its own Fixes: tag, should this revert include:

  Fixes: d44428868e5b ("drm/amdgpu: re-enable SPM updates in the the IB pat=
h")

so stable and backport trees do not pick up the original commit without
this revert?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116165713.1945=
549-1-alexander.deucher@amd.com?part=3D1
