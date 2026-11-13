Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E8606AE32
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjIZM8UA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2915B10EC1D;
	Fri, 13 Nov 2026 15:58:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B84BC10EC1D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:58:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 204CA4688B;
 Fri, 13 Nov 2026 15:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19A31F000C6;
 Fri, 13 Nov 2026 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794585499;
 bh=H8KgBpCfr1XWk1YuhOX1JRm8EPRNhZArKP7bJqqQbgE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ZjIZM8UAHKFETqmj3El3seXL0ckQqHSTh3Oibdf4REaf/Uq2R5lGh+MORTNQg8uys
 98YQQ2LVGg28QTIJFq5GfHj9j79kHtULvsI4HFEh3/c1P8WDf4WT6OI84T7/M+kUpA
 OveFIxMmY243OqlKBFwK5m3yBRScQTcemhNuZNcXCMfZj3dq5jnZlsxo2KgET4MFTe
 QUtLpw0VizA2YRCv/EsR8ehDd1LRiXY+dZP43jZTUQ/NO5g4rXZx/WYKKXmj94xAXl
 CYlvWgnrPgFGCzyXiAt02XJKb9rJzBwNkP5JHHxXPYji14uxrw1xS8x7Tv+K44Nm9e
 P4SdtbwoBL+SA==
Message-ID: <sashiko-outbox-213136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu: re-enable SPM updates in the
 the IB path"
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113154954.1865439-1-alexander.deucher@amd.com>
References: <20261113154954.1865439-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:58:18 +0000
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
- [Low] drm/amdgpu: missing Fixes: trailer for reverted commit
  d44428868e5b
--

commit 12b1b21ab2f5553c0093b8415a98c46d2dc21fed
Author: Alex Deucher <alexander.deucher@amd.com>

> Revert "drm/amdgpu: re-enable SPM updates in the the IB path"
>
> This reverts commit d44428868e5b9f97c6216eee1b4f82aec7a6e8d2.
>
> This causes flakiness in gfx11 CI tests.  Revert.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

[Severity: Low]
Should this revert include a Fixes: tag for the commit it reverts?

  Fixes: d44428868e5b ("drm/amdgpu: re-enable SPM updates in the the IB pat=
h")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113154954.1865=
439-1-alexander.deucher@amd.com?part=3D1
