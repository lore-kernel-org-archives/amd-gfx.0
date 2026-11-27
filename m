Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B98606A31E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fveX/EI1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA9310E480;
	Fri, 27 Nov 2026 08:37:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E40C11285C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 08:37:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3758060CD8;
 Fri, 27 Nov 2026 08:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01621F00893;
 Fri, 27 Nov 2026 08:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795768653;
 bh=BCRtlI1jSceoYJKIVsFv9bQQqT1BUr6ceR/V6qz2G9s=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=fveX/EI1zFhGbuvZgzUTK5RGofrafnry54Zi5k+SzcyABjsQHzXoq4VvhiDK8DGIP
 aFK9ZhtM+kusrv3AIvcyKr+cYveBOLyzxyo/0SwO5IlwOxl6Jw3/ZCyS1fZNW+wt73
 YO5dd/VNDaT90wM36Oha5gT6Ju+3Ln9wOnVQPi2f8YMoQNtUSwCC8sWtAdjsA8xwHp
 5sGauoXve7d1amE+yIFed1mqST7LRbLcbt8BwzKB9U2q6RZ6bYSghQ6AcELmCHRgdq
 hIeD4nX7Q5CAyh3evR2iV+OVhQdITTkea62trrUZvCcuWBMjVvL41AQygnh6RnaE1L
 lGWh4K7zg+1Yg==
Message-ID: <sashiko-outbox-236887@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/amdkfd: bound APU available memory by host
 available memory
To: "Priya Hosur" <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261127082854.112025-2-Priya.Hosur@amd.com>
References: <20261127082854.112025-1-Priya.Hosur@amd.com>
 <20261127082854.112025-2-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:37:33 +0000
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
- [High] drm/amdkfd: missing Signed-off-by trailer for Co-developed-by
  author
--

commit 420a8aac5bafb2838f8e3671bb8ebf0a0f48b7bc
Author: Priya Hosur <Priya.Hosur@amd.com>

> drm/amdkfd: bound APU available memory by host available memory
>
> On APUs where the VRAM carve-out is smaller than GTT (apu_prefer_gtt),
> KFD serves VRAM allocations from GTT, which is ordinary system memory.
> amdgpu_amdkfd_get_available_memory() then reports the minimum of the
> static KFD system limit, the TTM limit and the XCP size, each reduced
> only by KFD's own allocations. Memory used by the rest of the system is
> never subtracted, so AMDKFD_IOC_AVAILABLE_MEMORY, and hipMemGetInfo() on
> top of it, overstates what can be allocated.
>
> On a Ryzen AI MAX+ 395 (gfx1151, 62 GiB RAM, ttm.pages_limit 80 GiB)
> with 40 GiB held by another process, hipMemGetInfo() reports 59.67 GiB
> free while MemAvailable is 20.39 GiB. Applications that size buffers
> from it (e.g. a KV cache) overcommit and, without swap, trigger the OOM
> killer instead of failing cleanly.
>
> Bound the reported value by si_mem_available() when apu_prefer_gtt is
> set, unless no_system_mem_limit is set, which explicitly allows KFD to
> overcommit system memory. si_mem_available() includes reclaimable page
> cache, so this does not under-report on an idle system.
>
> Apply the bound in amdgpu_amdkfd_get_available_memory() rather than in
> __get_available_memory(), which is also used by the allocation path for
> is_app_apu. Allocation limits are unchanged; only the reported value is
> affected.
>
> Co-developed-by: Strahinja Stamenkovic <strahinja.stamenkovic@amd.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>

[Severity: High]
Per Documentation/process/submitting-patches.rst, every Co-developed-by
trailer must be immediately followed by a matching Signed-off-by trailer
from that co-author.  Should a Signed-off-by trailer for Strahinja
Stamenkovic be added right after the Co-developed-by line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127082854.1120=
25-1-Priya.Hosur@amd.com?part=3D1
