Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBB4606A329
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JaTOxcZU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13EB910E1B1;
	Tue, 17 Nov 2026 04:42:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BA310E1B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 04:42:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5806760D60;
 Tue, 17 Nov 2026 04:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51941F000C4;
 Tue, 17 Nov 2026 04:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794890559;
 bh=DxfpPNLJ4I+IYc7M9yATYRDclCX3RcYzFq4jV7z5x+4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=JaTOxcZUPPRLqfWk1xwf7deqzxjktnRpCdr1nxqWBdAqOw+wlg0aoCB0DEiNPVjBt
 De0pEtys8vHAN4hctDMJMGpfNKD1mcU8WecDikna3nEytp1VZguG+ndpBoaQBD+k/u
 HmlmfyRX8ojqr06/jzH9hKmI5TIC97nV1ENrd6/woE//LnN2xXfbzyz5njdSLJA+WV
 nFHGuauy5c2cZZRPIT0HfJH76oni8WxlA/M2Tu7k9gvoFsnAgp8WMGRceBulAmu/6K
 XqHEb9AsueM0S8yOwpLFd7hfk5vzZV5vP2z4RB3ULGzpe8Hvq9asFo/4umLkE8vfd0
 yVn5K1e7lfJNQ==
Message-ID: <sashiko-outbox-218191@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] drm/amdkfd: honor KFD_IOCTL_SVM_FLAG_GPU_RO for
 read-only SVM ranges
To: "Junhua Shen" <Junhua.Shen@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117042051.768201-3-Junhua.Shen@amd.com>
References: <20261117042051.768201-1-Junhua.Shen@amd.com>
 <20261117042051.768201-3-Junhua.Shen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 04:42:38 +0000
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
- [Low] drm/amdkfd: missing Fixes trailer for commit 2f617f4df8df
--

commit 7d7f0cff270e1b2b262588e7979494905efa821e
Author: Junhua Shen <Junhua.Shen@amd.com>

> drm/amdkfd: honor KFD_IOCTL_SVM_FLAG_GPU_RO for read-only SVM ranges
>
> When mapping an SVM range, svm_range_validate_and_map() faults the pages
> with hmm_range_fault(), requesting write access unless the range is
> read-only. It decides read-only from the VMA write permission alone, so
> KFD_IOCTL_SVM_FLAG_GPU_RO is ignored and the range is faulted for write.
>
> svm_range_get_pte_flags() already honors GPU_RO for the page table; honor
> it for the fault too.
>
> Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>

[Severity: Low]
Since this fixes the read-only calculation in svm_range_validate_and_map(),
should it include a Fixes tag?

  Fixes: 2f617f4df8df ("drm/amdkfd: map SVM range with correct access permi=
ssion")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117042051.7682=
01-1-Junhua.Shen@amd.com?part=3D2
