Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B31606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k403+Htd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798A189BE8;
	Thu, 12 Nov 2026 14:48:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8BC89BE8
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 14:48:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F28E640DD3;
 Thu, 12 Nov 2026 14:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C391F00A06;
 Thu, 12 Nov 2026 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794494900;
 bh=OfnG9eyk0qMY52+M3JMqzbqXkqXOCyF6eOzxAh1l+rs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=k403+Htd9fvMKCnJv4H/WzDbXFfNn24eR+D07wGv3D8RudrzHQ3u8qaT8kPylNQWv
 cNlx2Ih8t+atTW4np64guzoqdJjJEzIkkS+CDW/SrbSZ0wVhQaQ05F9VCch+ywotNf
 GygNT5VUC3mhfUq/LpO2Zi6iCnHwpjKMDIFyhCwENfdfHRDzEEDRot3rpGcxtvIe7F
 +KK/2PQvlbopNxFO0lXk2CIIS3mbXDbfl8Ih0aqnX7u/BINlzWH9in6n9c+Qs9kFow
 TKllFSfGWIwqa9Ial9otNYIXMj87C9hLy0wQQEDxdqN/0jSn8fZY78iRlWdiYGIDC1
 84jjWuM86u8HQ==
Message-ID: <sashiko-outbox-211382@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix fault cleaner race condition
To: "Kent Russell" <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261112134340.4122401-3-kent.russell@amd.com>
References: <20261112134340.4122401-1-kent.russell@amd.com>
 <20261112134340.4122401-3-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:48:20 +0000
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
- [Low] drm/amdkfd: missing Fixes trailer for
  clean_process_queues_cpsch() race fix
--

commit f7b85995fa163f69dd802bed02a96361c80519f7
Author: Kent Russell <kent.russell@amd.com>

> drm/amdgpu: Fix fault cleaner race condition
>
> clean_process_queues_cpsch would exit early if the memory was evicted,
> which would skip running the shader cleaner
>
> Run the cleaner unconditionally, and track whether the fault was cleaned
> with a new boolean in the qcd struct.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

[Severity: Low]
This fixes a bug in clean_process_queues_cpsch() where already-evicted
queues caused an early return before running hqd_gfx_clean_fault().
Should the commit message include:

  Fixes: a6332b847187 ("drm/amdkfd: Fix TCP XNACK scoreboard reset race")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112134340.4122=
401-1-kent.russell@amd.com?part=3D3
