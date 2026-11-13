Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCF60A5BDC
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSe4DiSz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D121112674;
	Fri, 13 Nov 2026 15:55:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A8F10EC3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:55:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7455627EC;
 Fri, 13 Nov 2026 15:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734A41F000CD;
 Fri, 13 Nov 2026 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794585341;
 bh=y+zoGzr9yHodL+BI0wnmzRweSLm9FkqdRfaSxcvl6Ic=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=CSe4DiSzR1638OsIrsasXqwps2pNp9qTZhAT4qO/0hMps7AA03ucmIxTlim0jwMPQ
 6YdGn5arnAXgNLDDJ6X453WidS6yX7YUFWbL7eP/w8IZ8k7Xb/R6QR1kXCwUUkJkm/
 Ba38H5i9UDCpeUCkrp33WbEtbY3wbTh9aMEtg6sjzMJs+3tVOmOomBgWRgcl3oNJY1
 rLG4oI99YTgZOScDHNcOvtQe0ldp3hKbb8CjkZD7nWMz8E3+PCrL8Z4YO8J+rKvaQl
 Jn/elHCdVAdmAO5knYsBhonFxarzgmoa3pQLMTZEDCWI1AINNYTHEwLRHCIcZuak7e
 7zmX8nkv8/+iQ==
Message-ID: <sashiko-outbox-213131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] Revert "drm/amdgpu: reemit RLC SPM register in ring
 reemit"
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113154954.1865439-2-alexander.deucher@amd.com>
References: <20261113154954.1865439-1-alexander.deucher@amd.com>
 <20261113154954.1865439-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:55:41 +0000
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
- [Low] drm/amdgpu: missing Fixes trailer on revert of commit
  8a4dfdc0d2ad
--

commit 765981743becaf8dc015c14e1e583ccf6339298b
Author: Alex Deucher <alexander.deucher@amd.com>

> Revert "drm/amdgpu: reemit RLC SPM register in ring reemit"
>
> This reverts commit 8a4dfdc0d2adfc362ec310ff70526e79ff8377b6.
>
> This causes flakiness in gfx11 CI tests.  Revert.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

[Severity: Low]
Since this reverts a commit to fix gfx11 CI flakiness, should the commit
message include a Fixes tag so stable and backport tooling pairs it with
the offending commit?

  Fixes: 8a4dfdc0d2ad ("drm/amdgpu: reemit RLC SPM register in ring reemit")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113154954.1865=
439-1-alexander.deucher@amd.com?part=3D2
