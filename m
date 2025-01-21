Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06156C0218C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 13:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A164D10E5BD;
	Tue, 21 Jan 2025 13:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rhKK30OK";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FA710E5B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 13:57:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5300A5C5679;
 Tue, 21 Jan 2025 13:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04439C4CEE3;
 Tue, 21 Jan 2025 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737467862;
 bh=1ioINbYhEgAmTtXKfCjn8KVHJPkUYoXSiAGIVsOs/Os=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rhKK30OKGUMq6Py7HsK1y3/wugM+wA9qHjrJfk3+LarjPqWRI99I7p/FSUwrnbXDH
 /mm63NQIxiTT42lf+Pi8C4K2oLxA8scJ1i2M4AiVRC12CIvYMs7KcKIYaHihA4aZAt
 A/kge/xs6tW5TEfvpt5Sl5FI8ujKWFKc3Y7NGKBpyMw/QJfEyE4d0vw2bQc3kQQYU3
 H/FrQ9InN9XBip2M0LlN5sxHrUlamv9TpruCilUSZXkgzL3Kpgzmu6kTVAtrZgvtQQ
 84P/VrFYzDoSrrZIpcu2D6oi0thcbrQcKkPh3oSpLeEPakVjiMAlbHXQoI+LVb88ER
 ODl0SM9/UAntw==
From: Mario Limonciello <superm1@kernel.org>
To: roman.li@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, Luke Jones <luke@ljones.dev>
Subject: [PATCH 1/4] drm/amd/display: Adjust plane init for off by one error
Date: Tue, 21 Jan 2025 07:57:16 -0600
Message-ID: <20250121135719.2883833-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121135719.2883833-1-superm1@kernel.org>
References: <20250121135719.2883833-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Limonciello <mario.limonciello@amd.com>

The number of active surfaces is initialized to the number
of active planes.  If the number of planes aren't initialized
properly then the last plane can end up not getting initialized
which can be a divide by zero error.

Reported-and-tested-by: Luke Jones <luke@ljones.dev>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3794
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3533
Fixes: 7966f319c66d9 ("drm/amd/display: Introduce DML2")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 8dabb1ac0b684..45147b812d7d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6787,7 +6787,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 		}
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		CalculateBytePerPixelAndBlockSizes(
 								mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k],
 								mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k],
-- 
2.43.0

