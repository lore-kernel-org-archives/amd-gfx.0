Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC213606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 19:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=giZwoh4J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3CB10EC80;
	Mon, 23 Nov 2026 19:23:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1688710EC70
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 19:23:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1567A62115;
 Mon, 23 Nov 2026 19:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED211F000D0;
 Mon, 23 Nov 2026 19:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795461803;
 bh=2Lj0PvlJkN4p7JRW5s9I9sGIza8nyGrz9cv62yXjjtQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=giZwoh4JvQch73JDnAoHo+zyw8/8YCziZE9mCTwN5bj2QBKO7469hJ1tySKf+4fXY
 87kgXXtMFzuAFC3s0EvbbPXdyWmHdehhNw8WGZmnDF3HlfNx4njcEx9fPqHePlKXnk
 zCJQArQq28Cjurd5ogKHRuvRAYEyGIkKXnfdCy4D77UFkYfU2P3tY8jvL07AzK6eOF
 TOlqiM1FFm+F42zzDqdxXQ90OLgwPOJS11SGUXOpgOcdHFi7dNuvysHbANet9RDmWE
 mLcQYqL2s/C1Qw7YMRydReTVbNsXUHfZq9xcU7a/Cd1eGLqkrbd5j+QXR4Ne7afSQU
 ISnXPBzo433Eg==
Message-ID: <sashiko-outbox-229924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Revert "drm/amd/amdgpu: Use RSMU index and data pair in
 nbio_v6_3_2 get_pcie_index/data_offset()"
To: "Jiahao Li" <Jiahao.Li@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261123191634.765657-1-Jiahao.Li@amd.com>
References: <20261123191634.765657-1-Jiahao.Li@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:23:23 +0000
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
- [Low] drm/amd/amdgpu: missing Fixes trailer for reverted commit
  b91d2d56110b
--

commit 8b1dbccdccaec36799bc8a849b8b0419ae82b353
Author: Jiahao Li <Jiahao.Li@amd.com>

> Revert "drm/amd/amdgpu: Use RSMU index and data pair in nbio_v6_3_2 get_p=
cie_index/data_offset()"
>
> This reverts commit e61b299b866e4ff06145a87da304af9a169231f9.
>
> Change get_pcie_index/data functions in nbio_v6_3_2 back to use
> PCIe index and data pair because the RSMU pair is dedicated to tools
>
> Signed-off-by: Jiahao Li <Jiahao.Li@amd.com>

[Severity: Low]
This revert references pre-apply commit e61b299b866e4ff06145a87da304af9a169=
231f9
instead of the merged commit b91d2d56110b564d8552e8ac94b6b8729a35377c, and =
is
missing a Fixes: tag.  Should the commit message reference
b91d2d56110b564d8552e8ac94b6b8729a35377c and include:

  Fixes: b91d2d56110b ("drm/amd/amdgpu: Use RSMU index and data pair in nbi=
o_v6_3_2 get_pcie_index/data_offset()")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123191634.7656=
57-1-Jiahao.Li@amd.com?part=3D1
